<?php

namespace app\admin\model\dramas;

use think\Model;


class UserSign extends Model
{

    // 表名
    protected $name = 'dramas_user_sign';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'is_replenish_text'
    ];

    protected $type = [
        'rules' => 'json'
    ];



    public function getIsReplenishList()
    {
        return ['0' => __('Is_replenish 0'), '1' => __('Is_replenish 1')];
    }


    public function getIsReplenishTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['is_replenish']) ? $data['is_replenish'] : '');
        $list = $this->getIsReplenishList();
        return isset($list[$value]) ? $list[$value] : '';
    }




    public function user()
    {
        return $this->belongsTo('app\admin\model\User', 'user_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }
}
