<?php

namespace app\admin\controller\dramas;

use app\common\controller\Backend;

/**
 * 会员规则管理
 *
 * @icon fa fa-circle-o
 */
class UserRule extends Backend
{
    /**
     * 选择链接
     */
    public function select()
    {
        $this->model = new \app\admin\model\UserRule();
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            $list = $this->model->with('children')->where('pid', '1')->select();
            $list = collection($list)->toArray();
            return $this->success('', null, $list);
        }
        return $this->view->fetch();
    }
}
