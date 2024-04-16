<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace app\admin\model\dramas;

use app\admin\model\Lang;
use think\Model;
use traits\model\SoftDelete;

class ResellerOrder extends Model
{

    use SoftDelete;



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



    public function getStatusList()
    {
        return ['-2' => __('Status -2'), '-1' => __('Status -1'), '0' => __('Status 0'), '1' => __('Status 1')];
    }

    public function getPayTypeList()
    {
        return ['paypal' => __('Paypal'), 'stripe' => __('Stripe'), 'cryptocard' => __('Cryptocard'), 'system' => __('System')];
    }

    public function getPlatformList()
    {
        return ['H5' => __('Platform h5'), 'App' => __('Platform app')];
    }

    public function getCurrencyList(){
        $lang_liist = (new Lang())->column('currency');

        return $lang_liist ?? [];
    }

    public function getLangList()
    {
        $list = (new \app\admin\model\Lang())->column('lang', 'id');
        foreach ($list as &$value){
            $value = __($value);
        }
        return $list;
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


    public function user()
    {
        return $this->belongsTo('User', 'user_id', 'id', [], 'LEFT');
    }


    public function reseller()
    {
        return $this->belongsTo('Reseller', 'reseller_id', 'id', [], 'LEFT');
    }
}
