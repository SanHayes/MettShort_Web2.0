<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace app\admin\model\dramas;

use think\Model;
use traits\model\SoftDelete;

class Task extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'dramas_task';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'type_text',
        'status_text'
    ];
    

    
    public function getTypeList()
    {
        return ['first' => __('Type first'), 'day' => __('Type day')];
    }

    public function getStatusList()
    {
        return ['normal' => __('Status normal'), 'hidden' => __('Status hidden')];
    }


    public function getTypeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['type']) ? $data['type'] : '');
        $list = $this->getTypeList();
        return isset($list[$value]) ? $list[$value] : '';
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


}
