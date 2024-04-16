<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace app\admin\model\dramas;

use think\Model;


class UserWalletLog extends Model
{
    // 表名
    protected $name = 'dramas_user_wallet_log';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'wallet_type_text',
        'oper_type_text',
        'oper'
    ];

    public function getOperAttr($value, $data)
    {
        return \addons\dramas\library\Oper::get($data['oper_type'], $data['oper_id']);
    }

    public function getWalletAttr($value, $data)
    {
        if($data['wallet_type'] === 'score') {
            return intval($data['wallet']);
        }elseif($data['wallet_type'] === 'usable') {
            return intval($data['wallet']);
        }else {
            return $data['wallet'];
        }
    }

    public function getBeforeAttr($value, $data)
    {
        if($data['wallet_type'] === 'score') {
            return intval($data['before']);
        }if($data['wallet_type'] === 'usable') {
            return intval($data['before']);
        }else {
            return $data['before'];
        }
    }

    public function getAfterAttr($value, $data)
    {
        if($data['wallet_type'] === 'score') {
            return intval($data['after']);
        }elseif($data['wallet_type'] === 'usable') {
            return intval($data['after']);
        }else {
            return $data['after'];
        }
    }

    public static function getTypeName($type)
    {
        return isset(\addons\dramas\model\UserWalletLog::$typeAll[$type]) ? __(\addons\dramas\model\UserWalletLog::$typeAll[$type]['name']) : '';
    }


    public function getTypeList()
    {
        $typeAll = \addons\dramas\model\UserWalletLog::$typeAll;
        $type_list = [];
        foreach ($typeAll as $key=>$value){
            $type_list[$key] = __($value['name']);
        }
        return $type_list;
    }

    
    public function getWalletTypeList()
    {
        return ['usable' => __('Wallet_type usable')];
    }

    public function getOperTypeList()
    {
        return ['user' => __('User'), 'admin' => __('Admin'), 'system' => __('System')];
    }


    public function getWalletTypeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['wallet_type']) ? $data['wallet_type'] : '');
        $list = $this->getWalletTypeList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getOperTypeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['oper_type']) ? $data['oper_type'] : '');
        $list = $this->getOperTypeList();
        return isset($list[$value]) ? $list[$value] : '';
    }




    public function user()
    {
        return $this->belongsTo('app\admin\model\User', 'user_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }
}
