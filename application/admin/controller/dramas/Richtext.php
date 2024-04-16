<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace app\admin\controller\dramas;

use app\admin\model\Lang;
use app\common\controller\Backend;
use think\Db;

/**
 * 富文本
 *
 * @icon fa fa-circle-o
 */
class Richtext extends Backend
{
    protected $dataLimit = 'auth';
    protected $dataLimitField = 'site_id';
    protected $noNeedRight = ['sync'];
    protected $searchFields = ['title', 'content'];
    /**
     * Richtext模型对象
     * @var \app\admin\model\dramas\Richtext
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\dramas\Richtext;
        $this->view->assign("langList", $this->model->getLangList());
        $this->assignconfig("langList", $this->model->getLangList());
    }



    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */

    /**
     * 选择富文本
     */
    public function select()
    {
        if ($this->request->isAjax()) {
            $condition = [];
            $lang_k = $this->request->param('lang_k', '');
            $lang_id = Lang::where('lang', $lang_k)->value('id');
            if($lang_id){
                $condition = ['lang_id' => $lang_id];
            }
            //设置过滤方法
            $this->request->filter(['strip_tags', 'trim']);
            //如果发送的来源是 Selectpage，则转发到 Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            [$where, $sort, $order, $offset, $limit] = $this->buildparams();
            $list = $this->model
                ->where($condition)
                ->where($where)
                ->order($sort, $order)
                ->paginate($limit);
            $result = ['total' => $list->total(), 'rows' => $list->items()];
            return json($result);
        }
        return $this->view->fetch();
    }

    public function sync(){
        $testdata_file = ADDON_PATH . "dramas" . DS . 'testdata' . DS . "richtext.php";
        if (is_file($testdata_file)) {
            $datas = include $testdata_file;
            Db::startTrans();
            foreach ($datas as $templine) {
                $templine = str_ireplace('__PREFIX__', config('database.prefix'), $templine);
                $templine = str_ireplace('__SITEID__', $this->auth->id, $templine);
                $templine = str_ireplace('INSERT INTO ', 'INSERT IGNORE INTO ', $templine);
                try {
                    Db::execute($templine);
                } catch (\PDOException $e) {
                    Db::rollback();
                    $this->error(__('Operation failed').'：'.$e->getMessage());
                }
            }
            Db::commit();
            $this->success(__('Operation completed'));
        }else{
            $this->error(__('No results were found'));
        }

    }

}
