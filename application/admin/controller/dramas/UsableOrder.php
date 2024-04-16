<?php

namespace app\admin\controller\dramas;

use app\common\controller\Backend;

/**
 * 剧场积分充值订单
 *
 * @icon fa fa-circle-o
 */
class UsableOrder extends Backend
{

    /**
     * UsableOrder模型对象
     * @var \app\admin\model\dramas\UsableOrder
     */
    protected $model = null;
    protected $dataLimit = 'auth';
    protected $dataLimitField = 'site_id';
    protected $noNeedRight = ['detail'];


    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\dramas\UsableOrder;
        $this->assignconfig("statusList", $this->model->getStatusList());
        $this->assignconfig("payTypeList", $this->model->getPayTypeList());
        $this->assignconfig("platformList", $this->model->getPlatformList());
        $this->assignconfig("currencyList", $this->model->getCurrencyList());
        $this->assignconfig("langList", $this->model->getLangList());
    }



    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */


    /**
     * 查看列表
     */
    public function index()
    {
        //当前是否为关联查询
        $this->relationSearch = true;
        //设置过滤方法
        $this->request->filter(['strip_tags', 'trim']);
        // 统计数据
        $count = [
            'total_usable' => 0,
            'total_orders' => 0,
            'pay_orders' => 0,
            'nopay_orders' => 0,
            'total_fee' => 0,
            'pay_fee' => 0,
            'currency' => '---',
        ];

        if ($this->request->isAjax()) {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }

            $nobuildfields = ['lang_id', 'status', 'nickname', 'user_email'];
            list($where, $sort, $order, $offset, $limit) = $this->custombuildparams(null, $nobuildfields);

            $total = $this->buildSearchOrder()
                ->where($where)
                ->order($sort, $order)
                ->count();

            $list = $this->buildSearchOrder()
                ->where($where)
                ->with(['user', 'usables'])
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();

            $list = collection($list)->toArray();

            $nobuildfields = ['lang_id', 'status', 'nickname', 'user_email'];
            list($where, $sort, $order, $offset, $limit) = $this->custombuildparams(null, $nobuildfields);

            $count['total_usable'] = $this->buildSearchOrder()
                ->where($where)
                ->where('status', 1)
                ->sum('usable');
            $count['total_orders'] = $this->buildSearchOrder()
                ->where($where)
                ->count();
            $count['pay_orders'] = $this->buildSearchOrder()
                ->where($where)
                ->where('status', 1)
                ->count();
            $count['nopay_orders'] = $this->buildSearchOrder()
                ->where($where)
                ->where('status', '<>', 1)
                ->count();
            $count['total_fee'] = $this->buildSearchOrder()
                ->where($where)
                ->where('status', 1)
                ->sum('total_fee');
            $count['pay_fee'] = $this->buildSearchOrder()
                ->where($where)
                ->where('status', 1)
                ->sum('pay_fee');
            $filter = $this->request->get("filter", '');
            $filter = (array)json_decode($filter, true);
            $count['currency'] = $filter['currency'] ?? $count['currency'];

            $result = array("total" => $total, "rows" => $list, "count" => $count);

            return $this->success(__('Operation completed'), null, $result);
        }
        return $this->view->fetch();
    }



    // 订单详情
    public function detail($id)
    {
        if ($this->request->isAjax()) {
            $table = $this->model->getTable();
            $row = $this->model->withTrashed()->with(['user', 'usables'])->where($table.'.id', $id)->find();
            if (!$row) {
                $this->error(__('No Results were found'));
            }

            return $this->success(__('Operation completed'), null,  $row);
        }

        $this->assignconfig('id', $id);
        return $this->view->fetch();
    }



    // 构建查询条件
    private function buildSearchOrder($is_status=true)
    {
        $filter = $this->request->get("filter", '');
        $filter = (array)json_decode($filter, true);
        $filter = $filter ? $filter : [];

        $lang_id = isset($filter['lang_id']) ? $filter['lang_id'] : '';
        $status = isset($filter['status']) ? $filter['status'] : 'all';
        $nickname = isset($filter['nickname']) ? $filter['nickname'] : '';
        $email = isset($filter['user_email']) ? $filter['user_email'] : '';

        $name = $this->model->getQuery()->getTable();
        $tableName = $name . '.';

        $orders = $this->model;

        if ($nickname || $email) {
            $orders = $orders->whereExists(function ($query) use ($nickname, $email, $tableName) {
                $userTableName = (new \app\admin\model\User())->getQuery()->getTable();

                $query = $query->table($userTableName)->where($userTableName . '.id=' . $tableName . 'user_id');

                if ($nickname) {
                    $query = $query->where('nickname', 'like', "%{$nickname}%");
                }

                if ($email) {
                    $query = $query->where('email', 'like', "%{$email}%");
                }

                return $query;
            });
        }

        if ($lang_id) {
            $orders = $orders->whereExists(function ($query) use ($lang_id, $tableName) {
                $usableTableName = (new \app\admin\model\dramas\Usable())->getQuery()->getTable();

                $query = $query->table($usableTableName)->where($usableTableName . '.id=' . $tableName . 'usable_id');

                $query = $query->where('lang_id', $lang_id);

                return $query;
            });
        }

        // 订单状态
        if ($is_status && $status != 'all' && in_array($status, ['-2', '-1', '0', '1', '2'])) {
            $orders = $orders->where($tableName.'status', $status);
        }

        return $orders;
    }

    /**
     * 可自定义组合的条件 生成查询所需要的条件,排序方式
     * @param mixed   $searchfields   快速查询的字段
     * @param mixed   $nobuildfields   不参与buildParams 的字段
     * @param boolean $relationSearch 是否关联查询
     * @return array
     */
    protected function custombuildparams($searchfields = null, $nobuildfields = [], $relationSearch = null)
    {
        $searchfields = is_null($searchfields) ? $this->searchFields : $searchfields;
        $relationSearch = is_null($relationSearch) ? $this->relationSearch : $relationSearch;
        $search = $this->request->get("search", '');
        $filter = $this->request->get("filter", '');
        $op = $this->request->get("op", '', 'trim');
        $sort = $this->request->get("sort", !empty($this->model) && $this->model->getPk() ? $this->model->getPk() : 'id');
        $order = $this->request->get("order", "DESC");
        $offset = $this->request->get("offset", 0);
        $limit = $this->request->get("limit", 0);
        $filter = (array)json_decode($filter, true);
        $op = (array)json_decode($op, true);
        $filter = $filter ? $this->filterParams($filter, $nobuildfields) : [];     // 过滤掉不参与 buildParams 的参数
        $where = [];
        $tableName = '';
        if ($relationSearch) {
            if (!empty($this->model)) {
                $name = \think\Loader::parseName(basename(str_replace('\\', '/', get_class($this->model))));
                $name = $this->model->getTable();
                $tableName = $name . '.';
            }
            $sortArr = explode(',', $sort);
            foreach ($sortArr as $index => &$item) {
                $item = stripos($item, ".") === false ? $tableName . trim($item) : $item;
            }
            unset($item);
            $sort = implode(',', $sortArr);
        }
        $adminIds = $this->getDataLimitAdminIds();
        if (is_array($adminIds)) {
            $where[] = [$tableName . $this->dataLimitField, 'in', $adminIds];
        }
        if ($search) {
            $searcharr = is_array($searchfields) ? $searchfields : explode(',', $searchfields);
            foreach ($searcharr as $k => &$v) {
                $v = stripos($v, ".") === false ? $tableName . $v : $v;
            }
            unset($v);
            $where[] = [implode("|", $searcharr), "LIKE", "%{$search}%"];
        }
        foreach ($filter as $k => $v) {
            $sym = isset($op[$k]) ? $op[$k] : '=';
            if (stripos($k, ".") === false) {
                $k = $tableName . $k;
            }
            $v = !is_array($v) ? trim($v) : $v;
            $sym = strtoupper(isset($op[$k]) ? $op[$k] : $sym);
            switch ($sym) {
                case '=':
                case '<>':
                    $where[] = [$k, $sym, (string)$v];
                    break;
                case 'LIKE':
                case 'NOT LIKE':
                case 'LIKE %...%':
                case 'NOT LIKE %...%':
                    $where[] = [$k, trim(str_replace('%...%', '', $sym)), "%{$v}%"];
                    break;
                case '>':
                case '>=':
                case '<':
                case '<=':
                    $where[] = [$k, $sym, intval($v)];
                    break;
                case 'FINDIN':
                case 'FINDINSET':
                case 'FIND_IN_SET':
                    $where[] = "FIND_IN_SET('{$v}', " . ($relationSearch ? $k : '`' . str_replace('.', '`.`', $k) . '`') . ")";
                    break;
                case 'IN':
                case 'IN(...)':
                case 'NOT IN':
                case 'NOT IN(...)':
                    $where[] = [$k, str_replace('(...)', '', $sym), is_array($v) ? $v : explode(',', $v)];
                    break;
                case 'BETWEEN':
                case 'NOT BETWEEN':
                    $arr = array_slice(explode(',', $v), 0, 2);
                    if (stripos($v, ',') === false || !array_filter($arr)) {
                        continue 2;
                    }
                    //当出现一边为空时改变操作符
                    if ($arr[0] === '') {
                        $sym = $sym == 'BETWEEN' ? '<=' : '>';
                        $arr = $arr[1];
                    } elseif ($arr[1] === '') {
                        $sym = $sym == 'BETWEEN' ? '>=' : '<';
                        $arr = $arr[0];
                    }
                    $where[] = [$k, $sym, $arr];
                    break;
                case 'RANGE':
                case 'NOT RANGE':
                    $v = str_replace(' - ', ',', $v);
                    $arr = array_slice(explode(',', $v), 0, 2);
                    if (stripos($v, ',') === false || !array_filter($arr)) {
                        continue 2;
                    }
                    //当出现一边为空时改变操作符
                    if ($arr[0] === '') {
                        $sym = $sym == 'RANGE' ? '<=' : '>';
                        $arr = $arr[1];
                    } elseif ($arr[1] === '') {
                        $sym = $sym == 'RANGE' ? '>=' : '<';
                        $arr = $arr[0];
                    }
                    $where[] = [$k, str_replace('RANGE', 'BETWEEN', $sym) . ' time', $arr];
                    break;
                case 'LIKE':
                case 'LIKE %...%':
                    $where[] = [$k, 'LIKE', "%{$v}%"];
                    break;
                case 'NULL':
                case 'IS NULL':
                case 'NOT NULL':
                case 'IS NOT NULL':
                    $where[] = [$k, strtolower(str_replace('IS ', '', $sym))];
                    break;
                default:
                    break;
            }
        }
        $where = function ($query) use ($where) {
            foreach ($where as $k => $v) {
                if (is_array($v)) {
                    call_user_func_array([$query, 'where'], $v);
                } else {
                    $query->where($v);
                }
            }
        };
        return [$where, $sort, $order, $offset, $limit];
    }



    /**
     * 过滤原始的不能用buildParams 的条件
     */
    public function filterParams($filter, $nobuildfields = []) {
        if ($nobuildfields) {
            foreach ($filter as $k => $f) {
                if (in_array($k, $nobuildfields)) {
                    unset($filter[$k]);
                }
            }
        }

        return $filter;
    }

}
