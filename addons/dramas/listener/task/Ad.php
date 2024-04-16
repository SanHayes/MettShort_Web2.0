<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace addons\dramas\listener\task;

use addons\dramas\model\AdLog;
use addons\dramas\model\Task;
use addons\dramas\model\User as UserModel;
use addons\dramas\model\UserWalletLog;
use think\Db;

/**
 * 广告
 */
class Ad
{
    // 看完广告
    public function adSuccess($data){
        $user = UserModel::get($data['user_id']);
        if($user['mode'] == 'guest'){
            return false;
        }
        $ad_log = AdLog::where('id', $data['ad_log_id'])->where('user_id', $user->id)
            ->where('status', 0)->find();
        if(empty($ad_log)) return false;
        // 增加剧场积分
        $task = Task::where('site_id', $data['site_id'])
            ->where('lang_id', $data['lang_id'])
            ->where('hook', 'ad_success')
            ->where('status', 'normal')
            ->find();
        if($task){
            $task_ids = Db::name('dramas_task')
                ->where('site_id', $data['site_id'])
                ->whereIn('hook', $task['hook'])
                ->column('id');
            $where['item_id'] = ['in', $task_ids];
            $where['site_id'] = $data['site_id'];
            $where['user_id'] = $data['user_id'];
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
                Db::transaction(function () use ($task, $ad_log) {
                    $user = UserModel::where('id', $ad_log->user_id)->lock(true)->find();
                    $ad_log->status = 1;
                    $ad_log->save();
                    UserModel::usable($ad_log['reward'], $user, 'task', $task['id'], Task::$hooks[$task['hook']], [
                        'request_id'=>$ad_log->id
                    ]);
                });
                return true;
            }
            return false;
        }
    }

}
