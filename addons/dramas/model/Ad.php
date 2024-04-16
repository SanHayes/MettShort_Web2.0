<?php

namespace addons\dramas\model;

use think\Db;
use think\Model;
use traits\model\SoftDelete;

class Ad extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'dramas_ad';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [

    ];

    protected $hidden = ['createtime', 'updatetime', 'deletetime', 'content'];


    public function getVideoAttr($value, $data)
    {
        $value = $value ?: ($data['video'] ?? '');
        return $value ? cdnurl($value, true) : '';
    }

    public function getImageAttr($value, $data)
    {
        $value = $value ?: ($data['image'] ?? '');
        return $value ? cdnurl($value, true) : '';
    }

    public static function getAd($lang_id, $site_id){
        $user = User::info();
        $user_ad_ids = AdLog::where('user_id', $user->id)
            ->where('site_id', $site_id)
            ->where('status', 1)
            ->where('createtime', '>',time()-60*30)
            ->column('ad_id');

        $ad = self::where('lang_id', $lang_id)->where('site_id', $site_id)
            ->whereNotIn('id', $user_ad_ids)->orderRaw('rand()')->find();
        if(empty($ad)){
            $ad = self::where('lang_id', $lang_id)->where('site_id', $site_id)->orderRaw('rand()')->find();
        }

        return $ad;
    }

    public static function addAd($lang_id, $site_id, $ad_id){
        $user = User::info();
        if(!$user || $user->mode == 'guest'){
            return false;
        }
        // 增加记录
        $task = Task::where('site_id', $site_id)
            ->where('lang_id', $lang_id)
            ->where('hook', 'ad_success')
            ->where('status', 'normal')
            ->find();
        if($task){
            $task_ids = Db::name('dramas_task')
                ->where('site_id', $site_id)
                ->whereIn('hook', $task['hook'])
                ->column('id');
            $where['item_id'] = ['in', $task_ids];
            $where['site_id'] = $site_id;
            $where['user_id'] = $user->id;
            $where['wallet_type'] = 'usable';
            $where['type'] = 'task';
            if($task['type'] == 'day'){
                $count = UserWalletLog::where($where)
                    ->whereTime('createtime', 'd')
                    ->count();
            }else{
                $count = UserWalletLog::where($where)->count();
            }
            if($count < $task['limit']){
                $data = [
                    'site_id' => $site_id,
                    'user_id' => $user->id,
                    'ad_id' => $ad_id,
                    'reward' => $task['usable'],
                    'status' => 0,
                ];
                return AdLog::create($data);
            }
        }
        return false;
    }


}
