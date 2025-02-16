<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace addons\dramas\model;

use app\common\model\Lang;
use think\Db;
use think\Model;
use addons\dramas\exception\Exception;


class ResellerOrder extends Model
{
    // 表名
    protected $name = 'dramas_reseller_order';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'status_text',
        'pay_type_text',
        'paytime_text',
        'platform_text'
    ];

    // 订单状态
    const STATUS_INVALID = -2;
    const STATUS_CANCEL = -1;
    const STATUS_NOPAY = 0;
    const STATUS_PAYED = 1;
    const STATUS_FINISH = 2;


    public function getStatusList()
    {
        return [
            '-2' => __('Status invalid'),
            '-1' => __('Status cancel'),
            '0' => __('Status nopay'),
            '1' => __('Status payed'),
            '2' => __('Status finish')
        ];
    }

    public function getPayTypeList()
    {
        return [
            'paypal' => __('Paypal'),
            'wechat' => __('Wechat'),
            'alipay' => __('Alipay'),
            'wallet' => __('Wallet'),
            'score' => __('Score'),
            'cryptocard' => __('Cryptocard'),
            'system' => __('System')
        ];
    }

    public function getPlatformList()
    {
        return [
            'H5' => __('Platform h5'),
            'App' => __('Platform app')
        ];
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getPayTypeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['pay_type']) ? $data['pay_type'] : '');
        $list = $this->getPayTypeList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getPaytimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['paytime']) ? $data['paytime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getPlatformTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['platform']) ? $data['platform'] : '');
        $list = $this->getPlatformList();
        return isset($list[$value]) ? $list[$value] : '';
    }

    protected function setPaytimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }


    public function reseller()
    {
        return $this->belongsTo('Reseller', 'reseller_id', 'id', [], 'LEFT')->setEagerlyType(1);
    }


    // 获取订单号
    public static function getSn($user_id)
    {
        $rand = $user_id < 9999 ? mt_rand(100000, 99999999) : mt_rand(100, 99999);
        $order_sn = date('Yhis') . $rand;

        $id = str_pad($user_id, (24 - strlen($order_sn)), '0', STR_PAD_BOTH);

        return $order_sn . $id;
    }

    // 购买记录
    public static function getList($params)
    {
        $user = User::info();
        extract($params);
        $site_id = Config::getSiteId();
        $orders = self::with('reseller')
            ->where('site_id', $site_id)
            ->where('user_id', $user->id)
            ->where('status', 'in', [1,2])
            ->order('id', 'desc')
            ->paginate(10);

        return $orders;
    }


    // 订单详情
    public static function detail($params)
    {
        $user = User::info();
        extract($params);

        $site_id = Config::getSiteId();
        $order = self::with('reseller')->where('user_id', $user->id)->where('site_id', $site_id);

        if (isset($order_sn)) {
            $order = $order->where('order_sn', $order_sn);
        }
        if (isset($id)) {
            $order = $order->where('id', $id);
        }

        $order = $order->find();

        if (!$order) {
            new Exception(__('Order does not exist'));
        }

        return $order;
    }

    // 创建订单
    public static function recharge($params)
    {
        $site_id = Config::getSiteId();
        $user = User::info();
        $reseller_bind = ResellerBind::info();
        // 入参
        extract($params);
        $total_fee = floatval($total_fee);

        $reseller = Reseller::where('id', $reseller_id)->where('site_id', $site_id)->where('status', 'normal')->find();
        if (empty($reseller)) {
            new Exception(__('No results were found'));
        }
        if($reseller_bind && $reseller_bind['reseller_id'] && $reseller_bind['level'] > $reseller['level'] &&
            ($reseller_bind['expiretime'] > time() || $reseller_bind['expiretime'] == 0)){
            //TODO 支付成功需要防止低级覆盖高级
            // new Exception('分销商只能升级，不能降级');
        }
        if ($total_fee < 0.01 || $reseller['price'] != $total_fee) {
            new Exception(__('Please enter the correct amount'));
        }

        $currency = Lang::where('id', $reseller['lang_id'])->value('currency');
        $close_time = 10;

        $orderData = [];
        $orderData['site_id'] = $site_id;
        $orderData['order_sn'] = self::getSn($user->id);
        $orderData['user_id'] = $user->id;
        $orderData['reseller_id'] = $reseller_id;
        $orderData['status'] = 0;
        $orderData['total_fee'] = $total_fee;
        $orderData['currency'] = $currency;
        $orderData['times'] = $reseller['expire'];
        $orderData['remark'] = $remark ?? null;
        $orderData['platform'] = $platform;
        $orderData['ext'] = json_encode(['expired_time' => time() + ($close_time * 60)]);

        $order = new ResellerOrder();
        $order->allowField(true)->save($orderData);

        // \think\Queue::later(($close_time * 60), '\addons\dramas\job\TradeOrderAutoOper@autoClose', ['order' => $order], 'dramas');

        return $order;
    }


    /**
     * 订单支付成功
     * @param [type] $order
     * @param [type] $notify
     * @return void
     */
    public function paymentProcess($order, $notify)
    {
        $reseller = Reseller::where('id', $order->reseller_id)->where('status', 'normal')->find();
        // 判断订单合法性
        if($notify['pay_fee'] != $reseller['price']){
            $msg = __('The amount (%s) does not match the payment amount (%s)', $notify['pay_fee'], $reseller['price']);
            $order->remark = $msg;
            $order->save();
            new Exception($msg);
        }

        try {
            Db::startTrans();
            // 添加reseller到期时间
            ResellerBind::add($order->site_id, $order->user_id, $order->reseller_id);
            // 修改订单状态等
            $order->status = 1;
            $order->paytime = time();
            $order->transaction_id = $notify['transaction_id'];
            $order->payment_json = $notify['payment_json'];
            $order->pay_type = $notify['pay_type'];
            $order->pay_fee = $notify['pay_fee'];
            $order->save();

            $share = ['order'=>$order, 'order_type'=>'reseller'];
            \think\Hook::listen('finish_after', $share);
            Db::commit();
        }catch (\think\Exception $e){
            Db::rollback();
            new Exception(__('Operation failed').'：'.$e->getMessage());
        }

        return $order;
    }

    public function setExt($order, $field, $origin = [])
    {
        $newExt = array_merge($origin, $field);

        $orderExt = $order['ext_arr'];

        return array_merge($orderExt, $newExt);
    }

}
