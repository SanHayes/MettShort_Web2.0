<?php

namespace app\admin\model\dramas;

use think\Model;
use traits\model\SoftDelete;

class VideoOrder extends Model
{

    use SoftDelete;



    // 表名
    protected $name = 'dramas_video_order';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'platform_text'
    ];



    public function getPlatformList()
    {
        return ['H5' => __('Platform h5'), 'App' => __('Platform app')];
    }


    public function getPlatformTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['platform']) ? $data['platform'] : '');
        $list = $this->getPlatformList();
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


    public function user()
    {
        return $this->belongsTo('User', 'user_id', 'id', [], 'LEFT');
    }


    public function video()
    {
        return $this->belongsTo('Video', 'vid', 'id', [], 'LEFT');
    }


    public function episodes()
    {
        return $this->belongsTo('VideoEpisodes', 'episode_id', 'id', [], 'LEFT');
    }

    public function copyright()
    {
        return $this->belongsTo('Copyright', 'copyright_id', 'id', [], 'LEFT');
    }
}
