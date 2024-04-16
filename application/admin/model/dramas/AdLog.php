<?php

namespace app\admin\model\dramas;

use think\Model;
use traits\model\SoftDelete;

class AdLog extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'dramas_ad_log';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'status_text'
    ];
    

    
    public function getStatusList()
    {
        return ['0' => __('Status 0'), '1' => __('Status 1')];
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getLangList()
    {
        $list = (new \app\admin\model\Lang())->column('lang', 'id');
        foreach ($list as &$value){
            $value = __($value);
        }
        return $list;
    }


    public function ad()
    {
        return $this->belongsTo('Ad', 'ad_id', 'id', [], 'LEFT');
    }

    public function user()
    {
        return $this->belongsTo('User', 'user_id', 'id', [], 'LEFT');
    }

}
