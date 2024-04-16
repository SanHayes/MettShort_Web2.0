<?php

namespace addons\dramas\controller;

use addons\dramas\library\UserSignService;

/**
 * 每日签到
 * Class UserSign
 * @package addons\dramas\controller
 */
class UserSign extends Base
{

    protected $noNeedLogin = [];
    protected $noNeedRight = ['*'];
    protected $noNeedGuest = ['signin', 'replenish'];

    /**
     * 签到列表
     * @ApiParams   (name="month", type="string", required=false, description="月份：2024-1")
     */
    public function index()
    {
        $params = $this->request->param();
        $month = (isset($params['month']) && $params['month']) ? date('Y-m', strtotime($params['month'])) : date('Y-m');     // 前端可能传来 2023-1,这里再统一格式化一下 month

        $is_current = ($month == date('Y-m')) ? true : false;
        $signin = new UserSignService();
        // 当前月，获取连续签到天数
        $continue_days = $signin->getContinueDays();

        $days = $signin->getList($month, $continue_days);

        $rules = $signin->getRules();
        $rules['richtext'] = $rules['richtext'][$this->lang]['id'] ?? '';

        $this->success(__('Operation completed'), compact('days', 'continue_days', 'rules', 'is_current'));
    }


    /**
     * 签到
     */
    public function signin()
    {
        $signin = new UserSignService();
        $signin = $signin->signin();

        $this->success(__('Successful check-in'), $signin);
    }


    /**
     * 补签
     * @ApiParams   (name="date", type="string", required=false, description="日期：2024-01-15")
     */
    public function replenish()
    {
        $params = $this->request->param();
        $this->dramasValidate($params, get_class(), "replenish");

        $signin = new UserSignService();
        $signin = $signin->replenish($params);

        $this->success(__('Supplementary check-in successful'), $signin);
    }
}
