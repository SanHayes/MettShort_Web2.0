<?php

namespace app\admin\controller\dramas;

use app\common\controller\Backend;

/**
 * 广告内容
 *
 * @icon fa fa-circle-o
 */
class Ad extends Backend
{

    protected $dataLimit = 'auth';
    protected $dataLimitField = 'site_id';

    /**
     * Ad模型对象
     * @var \app\admin\model\dramas\Ad
     */
    protected $model = null;
    protected $noNeedRight = ['select'];

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\dramas\Ad;
        $this->view->assign("langList", $this->model->getLangList());
        $this->assignconfig("langList", $this->model->getLangList());
    }



    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */



    /**
     * 选择
     */
    public function select()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags']);
        if ($this->request->isAjax()) {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $search = $this->request->request('search');

            $model = $this->model;
            if ($search) {
                // 模糊搜索字段
                $searcharr = ['description', 'title', 'id'];
                $model = $model->where(function ($query) use ($searcharr, $search) {
                    $query->where(implode("|", $searcharr), "LIKE", "%{$search}%");
                });
            }

            $total = $model
                ->where($where)
                ->order($sort, $order)
                ->field('id, title, description')
                ->count();

            $model = $this->model;
            if ($search) {
                // 模糊搜索字段
                $searcharr = ['description', 'title', 'id'];
                $model = $model->where(function ($query) use ($searcharr, $search) {
                    $query->where(implode("|", $searcharr), "LIKE", "%{$search}%");
                });
            }
            $list = $model
                ->where($where)
                ->order($sort, $order)
                ->field('id, title, description')
                ->limit($offset, $limit)
                ->select();
            $result = array("total" => $total, "rows" => $list);

            $this->success(__('Select'), null, $result);
        }
    }

}
