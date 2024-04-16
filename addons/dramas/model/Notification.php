<?php

namespace addons\dramas\model;

use think\Model;
use traits\model\SoftDelete;

class Notification extends Model
{

    use SoftDelete;


    // 表名
    protected $name = 'dramas_notification';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    protected $hidden = ['platform', 'starttime', 'endtime', 'createtime', 'deletetime', 'updatetime', 'status', 'weigh'];

    // 追加属性
    protected $append = [
    ];

    public function getImageAttr($value, $data)
    {
        $value = $value ?: ($data['image'] ?? '');
        return $value ? cdnurl($value, true) : '';
    }

}
