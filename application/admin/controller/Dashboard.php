<?php

namespace app\admin\controller;

use app\admin\model\Admin;
use app\admin\model\User;
use app\common\controller\Backend;
use app\common\model\Attachment;
use fast\Date;
use think\Db;

/**
 * 控制台
 *
 * @icon   fa fa-dashboard
 * @remark 用于展示当前系统中的统计数据、统计报表及重要实时数据
 */
class Dashboard extends Backend
{

    /**
     * 查看
     */
    public function index()
    {
        try {
            \think\Db::execute("SET @@sql_mode='';");
        } catch (\Exception $e) {

        }

        $condition = null;
        if (!$this->auth->isSuperAdmin()) {
            $condition = ['site_id'=>$this->auth->id];
        }


        $column = [];
        $starttime = Date::unixtime('day', -6);
        $endtime = Date::unixtime('day', 0, 'end') + 1;
        $joinlist = Db("user")->where($condition)->where('jointime', 'between time', [$starttime, $endtime])
            ->field('jointime, status, COUNT(*) AS nums, DATE_FORMAT(FROM_UNIXTIME(jointime), "%Y-%m-%d") AS join_date')
            ->group('join_date')
            ->select();
        for ($time = $starttime; $time <= $endtime;) {
            $column[] = date("Y-m-d", $time);
            $time += 86400;
        }
        $userlist = array_fill_keys($column, 0);
        foreach ($joinlist as $k => $v) {
            $userlist[$v['join_date']] = $v['nums'];
        }

        $dbTableList = Db::query("SHOW TABLE STATUS");
        $addonList = get_addon_list();
        $totalworkingaddon = 0;
        $totaladdon = count($addonList);
        foreach ($addonList as $index => $item) {
            if ($item['state']) {
                $totalworkingaddon += 1;
            }
        }
        $this->view->assign([
            'totaluser'         => User::where($condition)->count(),
            'totaladdon'        => $totaladdon,
            'totaladmin'        => $this->auth->isSuperAdmin() ? Admin::count() : 1,
            'totalcategory'     => \app\common\model\Category::count(),
            'todayusersignup'   => User::where($condition)->whereTime('jointime', 'today')->count(),
            'todayuserlogin'    => User::where($condition)->whereTime('logintime', 'today')->count(),
            'sevendau'          => User::where($condition)->whereTime('jointime|logintime|prevtime', '-7 days')->count(),
            'thirtydau'         => User::where($condition)->whereTime('jointime|logintime|prevtime', '-30 days')->count(),
            'threednu'          => User::where($condition)->whereTime('jointime', '-3 days')->count(),
            'sevendnu'          => User::where($condition)->whereTime('jointime', '-7 days')->count(),
            'dbtablenums'       => count($dbTableList),
            'dbsize'            => array_sum(array_map(function ($item) {
                return $item['Data_length'] + $item['Index_length'];
            }, $dbTableList)),
            'totalworkingaddon' => $totalworkingaddon,
            'attachmentnums'    => Attachment::where($condition)->count(),
            'attachmentsize'    => Attachment::where($condition)->sum('filesize'),
            'picturenums'       => Attachment::where($condition)->where('mimetype', 'like', 'image/%')->count(),
            'picturesize'       => Attachment::where($condition)->where('mimetype', 'like', 'image/%')->sum('filesize'),
        ]);

        $this->assignconfig('column', array_keys($userlist));
        $this->assignconfig('userdata', array_values($userlist));

        return $this->view->fetch();
    }

}
