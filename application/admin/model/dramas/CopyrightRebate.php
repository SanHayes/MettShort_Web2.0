<?php

namespace app\admin\model\dramas;

use think\Model;
use traits\model\SoftDelete;

class CopyrightRebate extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'dramas_copyright_rebate';
    
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
}
