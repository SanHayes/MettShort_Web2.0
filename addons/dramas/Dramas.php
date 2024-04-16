<?php

namespace addons\dramas;

use app\admin\model\AuthRule;
use app\common\library\Menu;
use fast\Tree;
use think\Addons;
use think\Db;
use think\Exception;
use think\exception\PDOException;
use addons\dramas\library\Hook;

/**
 * 插件
 */
class Dramas extends Addons
{
    /**
     * 插件安装方法
     * @return bool
     */
    public function install()
    {
        $menu = self::getMenu();
        Menu::create($menu['new']);
        return true;
    }

    /**
     * 插件卸载方法
     * @return bool
     */
    public function uninstall()
    {
        Menu::delete('dramas');
        return true;
    }

    /**
     * 插件启用方法
     * @return bool
     */
    public function enable()
    {
        Menu::enable('dramas');
        return true;
    }

    /**
     * 插件禁用方法
     * @return bool
     */
    public function disable()
    {
        Menu::disable('dramas');
        return true;
    }


    /**
     * 插件更新方法
     */
    public function upgrade()
    {
        $menu = self::getMenu();
        if(method_exists(Menu::class, 'upgrade')){
            Menu::upgrade('dramas', $menu['new']);
        }else{
            //使用dramas自带的更新操作
            self::menuCreateOrUpdate($menu['new'], $menu['old']);
        }
        // TODO 更新dramas分站点权限
        $ai_rule_id = Db::name('auth_rule')->where('name', 'dramas')->value('id');
        $yx_rule_id = Db::name('auth_rule')->where('name', 'dramas/yingxiao')->value('id');
        $children_auth_rules = Db::name('auth_rule')->select();
        $ruleTree = new Tree();
        $ruleTree->init($children_auth_rules);
        $ruleIdList1 = $ruleTree->getChildrenIds($ai_rule_id, true);
        $ruleIdList2 = $ruleTree->getChildrenIds($yx_rule_id, true);
        $rules1 = implode(',', $ruleIdList1);
        $rules2 = implode(',', $ruleIdList2);
        $rules = trim('29,30,32,23,24,25,26,27,28,8,2,7,'.$rules1.','.$rules2, ',');
        Db::name('auth_group')->where('id', 2)->update(['rules'=>$rules]);

        return true;
    }

    /**
     * 应用初始化
     */
    public function appInit()
    {
        // 公共方法
        require_once __DIR__ . '/helper.php';

        // database 增加断线重连参数
        $database = \think\Config::get('database');
        $database['break_reconnect'] = true;        // 断线重连
        \think\Config::set('database', $database);
        // 全局注册行为事件
        Hook::register();
    }


    private static function getMenu()
    {
        $newMenu = [];
        $config_file = ADDON_PATH . "dramas" . DS . 'config' . DS . "menu.php";
        if (is_file($config_file)) {
            $newMenu = include $config_file;
        }
        $oldMenu = AuthRule::where('name','like',"dramas%")->select();
        $oldMenu = array_column($oldMenu, null, 'name');
        return ['new' => $newMenu, 'old' => $oldMenu];
    }

    private static function menuCreateOrUpdate($newMenu, $oldMenu, $parent = 0)
    {
        if (!is_numeric($parent)) {
            $parentRule = AuthRule::getByName($parent);
            $pid = $parentRule ? $parentRule['id'] : 0;
        } else {
            $pid = $parent;
        }
        $allow = array_flip(['file', 'name', 'title', 'icon', 'condition', 'remark', 'ismenu', 'weigh']);
        foreach ($newMenu as $k => $v) {
            $hasChild = isset($v['sublist']) && $v['sublist'] ? true : false;
            $data = array_intersect_key($v, $allow);
            $data['ismenu'] = isset($data['ismenu']) ? $data['ismenu'] : ($hasChild ? 1 : 0);
            $data['icon'] = isset($data['icon']) ? $data['icon'] : ($hasChild ? 'fa fa-list' : 'fa fa-circle-o');
            $data['pid'] = $pid;
            $data['status'] = 'normal';
            try {
                if (!isset($oldMenu[$data['name']])) {
                    $menu = AuthRule::create($data);
                }else{
                    $menu = $oldMenu[$data['name']];
                }
                if ($hasChild) {
                    self::menuCreateOrUpdate($v['sublist'], $oldMenu, $menu['id']);
                }
            } catch (PDOException $e) {
                new Exception($e->getMessage());
            }
        }
    }

}
