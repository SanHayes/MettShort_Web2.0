<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace addons\dramas\listener\task;

use addons\dramas\model\Task;
use addons\dramas\model\User as UserModel;
use addons\dramas\model\UserWalletLog;
use think\Db;

/**
 * 分享
 */
class Share
{
    // 分享成功后（用户注册）
    public function shareSuccess($data){
        $user = UserModel::get($data['user_id']);
        if($user['mode'] == 'guest'){
            return;
        }
        // 增加剧场积分
        $task = Task::where('site_id', $data['site_id'])
            ->where('lang_id', $data['lang_id'])
            ->where('hook', 'share_success')
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
                UserModel::usable($task['usable'], $data['user_id'], 'task', $task['id'], Task::$hooks[$task['hook']]);
            }
        }
    }

}
