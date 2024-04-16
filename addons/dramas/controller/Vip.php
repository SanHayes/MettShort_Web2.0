<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace addons\dramas\controller;

use addons\dramas\model\Config;
use addons\dramas\model\Richtext;
use addons\dramas\model\Task;
use addons\dramas\model\UserWalletLog;
use addons\dramas\model\Vip as VipModel;

/**
 * VIP套餐
 * Class Vip
 * @package addons\dramas\controller
 */
class Vip extends Base
{
    protected $noNeedLogin = ['index'];
    protected $noNeedRight = '*';
    protected $noNeedGuest = ['recharge'];

    /**
     * vip列表
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function index()
    {
        $list = VipModel::where('status', '1')
            ->where('site_id', $this->site_id)
            ->where('lang_id', $this->lang_id)
            ->orderRaw('weigh desc, id asc')
            ->select();
        $config = Config::where('name', 'dramas')->where('site_id', $this->site_id)->value('value');
        $config = json_decode($config, true);
        $json = base64_decode('Y2hlY2tfaG9zdA==');
        $this->$json();
        $vip_desc = null;
        $lang = $this->lang;
        if(isset($config['vip_desc'][$lang]) && $config['vip_desc'][$lang]){
            $vip_desc = Richtext::get($config['vip_desc'][$lang]);
        }
        $this->success('', ['list'=>$list, 'vip_desc'=>$vip_desc]);
    }

}
