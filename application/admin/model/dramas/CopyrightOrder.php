<?php

namespace app\admin\model\dramas;

use think\Model;
use traits\model\SoftDelete;

class CopyrightOrder extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'dramas_copyright_order';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [

    ];
    

    







    public function copyright()
    {
        return $this->belongsTo('Copyright', 'copyright_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }


    public function order()
    {
        return $this->belongsTo('videoOrder', 'order_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }
}
