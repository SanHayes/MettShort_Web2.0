<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace addons\dramas\listener;

use addons\dramas\model\CopyrightOrder;
use addons\dramas\model\Video;
use addons\dramas\model\VideoOrder;
use think\Db;

/**
 * 版权分润
 */
class Copyright
{
    /**
     * 追剧支付
     */
    public function orderAfter($params){
        $order_id = $params['order_id'];
        $video_order = VideoOrder::get($order_id);
        if($video_order){
            $video = Video::get($video_order['vid']);
            $copyright_id = $video['copyright_id'];
            $copyright = \addons\dramas\model\Copyright::where('id', $copyright_id)->lock(true)->find();
            if($copyright){
                $ratio = bcdiv($copyright['ratio'], 100, 4);
                $rebate_fee = bcmul($video_order['total_fee'], $ratio);
                CopyrightOrder::create([
                    'site_id' => $video_order['site_id'],
                    'copyright_id' => $copyright_id,
                    'order_id' => $order_id,
                    'pay_fee' => $video_order['total_fee'],
                    'rebate_fee' => $rebate_fee,
                    'ratio' => $copyright['ratio'],
                ]);
                $copyright->total_fee = Db::raw('total_fee + ' . $video_order['total_fee']);
                $copyright->rebate_fee = Db::raw('rebate_fee + ' . $rebate_fee);
                $copyright->save();
                $video_order->copyright_id = $copyright_id;
                $video_order->save();
            }
        }
    }

}
