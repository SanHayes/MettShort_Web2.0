<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace app\admin\controller\dramas;

use addons\dramas\library\UserSignProvider;
use app\admin\model\Sites;
use app\common\controller\Backend;
use app\admin\model\dramas\Config as ConfigModel;
use addons\dramas\model\Richtext;
use app\common\library\Email;
use fast\Http;
use PhpZip\Exception\ZipException;
use PhpZip\ZipFile;
use think\addons\AddonException;
use think\Db;
use think\Exception;
use think\Validate;

/**
 * dramas配置
 *
 * @icon fa fa-cogs
 * @remark 可以在此增改系统的变量和分组,也可以自定义分组和变量,如果需要删除请从数据库中删除
 */
class Config extends Backend
{
    protected $dataLimit = 'auth';
    protected $dataLimitField = 'site_id';

    /**
     * @var \app\admin\model\dramas\Config
     */
    protected $model = null;
    protected $noNeedRight = ['check', 'rulelist', 'check_theme', 'backup_download', 'emailtest'];
    protected $site_id = 0;
    protected $sign = '';


    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('app\admin\model\dramas\Config');
        $site = Sites::where('site_id', $this->auth->id)->find();
        $this->site_id = $site['site_id'] ?? 0;
        $this->sign = $site['sign'] ?? '';
        $this->assignconfig('site_id', $this->site_id);
        $this->assignconfig('sign', $site['sign'] ?? '');
        $this->assignconfig('host', $_SERVER['HTTP_HOST']);
    }

    /**
     * 查看
     */
    public function index()
    {
        $siteList = [];
        $groupList = ConfigModel::getGroupList();
        foreach ($groupList as $k => $v) {
            $siteList[$k]['name'] = $k;
            $siteList[$k]['title'] = $v;
            $siteList[$k]['list'] = [];
        }

        foreach ($this->model->all(['site_id'=>$this->site_id]) as $k => $v) {
            if (!isset($siteList[$v['group']])) {
                continue;
            }
            $value = $v->toArray();
            $value['title'] = __($value['title']);
            if (in_array($value['type'], ['select', 'selects', 'checkbox', 'radio'])) {
                $value['value'] = explode(',', $value['value']);
            }
            $value['content'] = json_decode($value['content'], true);
            $value['tip'] = htmlspecialchars($value['tip']);
            $siteList[$v['group']]['list'][] = $value;
        }
        $index = 0;
        foreach ($siteList as $k => &$v) {
            $v['active'] = !$index ? true : false;
            $index++;
        }
        $this->view->assign('siteList', $siteList);
        $this->view->assign('typeList', ConfigModel::getTypeList());
        $this->view->assign('ruleList', ConfigModel::getRegexList());
        $this->view->assign('groupList', ConfigModel::getGroupList());
        $addons = get_addon_list();
        foreach ($addons as $k => &$v) {
            $config = get_addon_config($v['name']);
            $v['config'] = $config ? 1 : 0;
            $v['url'] = str_replace($this->request->server('SCRIPT_NAME'), '', $v['url']);
        }
        $this->assignconfig(['addons' => $addons]);
        return $this->view->fetch();
    }

    /**
     * 添加
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $this->token();
            $params = $this->request->post("row/a", [], 'trim');
            if ($params) {
                foreach ($params as $k => &$v) {
                    $v = is_array($v) ? implode(',', $v) : $v;
                }
                try {
                    if (in_array($params['type'], ['select', 'selects', 'checkbox', 'radio', 'array'])) {
                        $params['content'] = json_encode(ConfigModel::decode($params['content']), JSON_UNESCAPED_UNICODE);
                    } else {
                        $params['content'] = '';
                    }
                    $result = $this->model->create($params);
                    if ($result !== false) {
                        $this->success();
                    } else {
                        $this->error($this->model->getError());
                    }
                } catch (Exception $e) {
                    $this->error($e->getMessage());
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }
        return $this->view->fetch();
    }

    /**
     * 编辑
     * @param null $ids
     */
    public function edit($ids = null)
    {
        if ($this->request->isPost()) {
            $this->token();
            $row = $this->request->post("row/a", [], 'trim');
            if ($row) {
                $configList = [];
                foreach ($this->model->all() as $v) {
                    if (isset($row[$v['name']])) {
                        $value = $row[$v['name']];
                        if (is_array($value) && isset($value['field'])) {
                            $value = json_encode(ConfigModel::getArrayData($value), JSON_UNESCAPED_UNICODE);
                        } else {
                            $value = is_array($value) ? implode(',', $value) : $value;
                        }
                        $v['value'] = $value;
                        $configList[] = $v->toArray();
                    }
                }
                $this->model->allowField(true)->saveAll($configList);
                try {
                } catch (Exception $e) {
                    $this->error($e->getMessage());
                }
                $this->success();
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }
    }

    public function platform($type)
    {
        if ($this->request->isPost()) {
            $data = $this->request->post("data");
            if ($data) {
                if($type == 'usersign'){
                    (new UserSignProvider())->check(['rules'=>json_decode($data, true)]);
                }
                try {
                    $config = $this->model->get(['name' => $type, 'site_id'=>$this->site_id]);
                    if(!$config) {
                        $this->model->allowField(true)->save([
                            'site_id'=>$this->site_id,
                            'name' => $type,
                            'title' => $this->request->post("title"),
                            'group' => $this->request->post("group"),
                            'type' => 'array',
                            'value' => $data,
                        ]);
                    }else {
                        $config->value = $data;
                        $config->save();
                    }
                } catch (Exception $e) {
                    $this->error($e->getMessage());
                }
                $this->success();
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $config = $this->model->where(['name' => $type, 'site_id'=>$this->site_id])->value('value');
        $config = json_decode($config, true);
        if ($type === 'wxOfficialAccount') {
            //动态解析微信公众号服务端Api Url地址域名
            $config['url'] = request()->domain() . '/addons/dramas/wechat/index/sign/'.$this->sign;
        }
        if($type === 'user') {
            $groupList = \app\admin\model\UserGroup::where('site_id', $this->auth->id)
                ->where('status', 'normal')
                ->field('id,name,status')
                ->select();
            $this->assignconfig('groupList', $groupList);
        }
        if($type === 'dramas'){
            $site_info = Db::name('sites')->where('site_id', $this->auth->id)->find();
            if($site_info['is_default'] == 1 || $site_info['domain']){
                $h5 = '/h5/';
            }else{
                $h5 = '/h5/?sign='.$site_info['sign'].'#/';
            }
            $config['domain'] = request()->domain();
            $config['h5'] = request()->domain().$h5;
            $info = get_addon_info('dramas');
            $config['version'] = $info['version'];

            $lang_ids = (new \app\admin\model\Lang())->column('id', 'lang');
            if(isset($config['user_protocol']) && $config['user_protocol']){
                foreach ($config['user_protocol'] as $key=>$item){
                    if(isset($lang_ids[$key]) && !Richtext::get(['id'=>$item,'site_id'=>$this->site_id,'lang_id'=>$lang_ids[$key]])){
                        $config['user_protocol'][$key] = '';
                        $config['user_protocol_title'][$key] = '';
                    }
                }
            }
            if(isset($config['privacy_protocol']) && $config['privacy_protocol']){
                foreach ($config['privacy_protocol'] as $key=>$item){
                    if(isset($lang_ids[$key]) && !Richtext::get(['id'=>$item,'site_id'=>$this->site_id,'lang_id'=>$lang_ids[$key]])){
                        $config['privacy_protocol'][$key] = '';
                        $config['privacy_protocol_title'][$key] = '';
                    }
                }
            }
            if(isset($config['about_us']) && $config['about_us']){
                foreach ($config['about_us'] as $key=>$item){
                    if(isset($lang_ids[$key]) && !Richtext::get(['id'=>$item,'site_id'=>$this->site_id,'lang_id'=>$lang_ids[$key]])){
                        $config['about_us'][$key] = '';
                        $config['about_us_title'][$key] = '';
                    }
                }
            }
            if(isset($config['contact_us']) && $config['contact_us']){
                foreach ($config['contact_us'] as $key=>$item){
                    if(isset($lang_ids[$key]) && !Richtext::get(['id'=>$item,'site_id'=>$this->site_id,'lang_id'=>$lang_ids[$key]])){
                        $config['contact_us'][$key] = '';
                        $config['contact_us_title'][$key] = '';
                    }
                }
            }
            if(isset($config['legal_notice']) && $config['legal_notice']){
                foreach ($config['legal_notice'] as $key=>$item){
                    if(isset($lang_ids[$key]) && !Richtext::get(['id'=>$item,'site_id'=>$this->site_id,'lang_id'=>$lang_ids[$key]])){
                        $config['legal_notice'][$key] = '';
                        $config['legal_notice_title'][$key] = '';
                    }
                }
            }
            if(isset($config['usable_desc']) && $config['usable_desc']){
                foreach ($config['usable_desc'] as $key=>$item){
                    if(isset($lang_ids[$key]) && !Richtext::get(['id'=>$item,'site_id'=>$this->site_id,'lang_id'=>$lang_ids[$key]])){
                        $config['usable_desc'][$key] = '';
                        $config['usable_desc_title'][$key] = '';
                    }
                }
            }
            if(isset($config['vip_desc']) && $config['vip_desc']){
                foreach ($config['vip_desc'] as $key=>$item){
                    if(isset($lang_ids[$key]) && !Richtext::get(['id'=>$item,'site_id'=>$this->site_id,'lang_id'=>$lang_ids[$key]])){
                        $config['vip_desc'][$key] = '';
                        $config['vip_desc_title'][$key] = '';
                    }
                }
            }
            if(isset($config['reseller_desc']) && $config['reseller_desc']){
                foreach ($config['reseller_desc'] as $key=>$item){
                    if(isset($lang_ids[$key]) && !Richtext::get(['id'=>$item,'site_id'=>$this->site_id,'lang_id'=>$lang_ids[$key]])){
                        $config['reseller_desc'][$key] = '';
                        $config['reseller_desc_title'][$key] = '';
                    }
                }
            }
        }
        if($type === 'usersign'){
            if(isset($config['richtext']) && $config['richtext']){
                $lang_ids = (new \app\admin\model\Lang())->column('id', 'lang');
                foreach ($config['richtext'] as $key=>$item){
                    if(!isset($lang_ids[$key])){
                        unset($config['richtext'][$key]);
                    }
                    if(!Richtext::get(['id'=>$item['id']??''])){
                        $config['richtext'][$key] = '';
                    }
                }
            }
        }
        if($type === 'email'){
            if(isset($config['mail_template']) && $config['mail_template']){
                foreach ($config['mail_template'] as $key=>$item){
                    if(!Richtext::get(['id'=>$item['value'],'site_id'=>$this->site_id])){
                        $config['mail_template'][$key]['value'] = '';
                        $config['mail_template'][$key]['title'] = '';
                    }
                }
            }
        }
        if($type == 'paypal' || $type == 'stripe'){
            $site_info = Db::name('sites')->where('site_id', $this->auth->id)->find();
            $notify_url = request()->domain() . '/addons/dramas/pay/notify_paypal/payment/'.$type.'/sign/' . $site_info['sign'];
            $config['webhook'] = $notify_url;
        }
        if($type == 'google' || $type == 'facebook'){
            $site_info = Db::name('sites')->where('site_id', $this->auth->id)->find();
            $redirect_url = request()->domain() . '/addons/dramas/user/thirdCallback/type/'.$type.'/sign/'.$site_info['sign'];
            $config['redirect'] = $redirect_url;
            if($site_info['is_default'] == 1 || $site_info['domain']){
                $return_url = '/h5/#/';
            }else{
                $return_url = '/h5/?sign='.$site_info['sign'].'#/';
            }
            $config['return_url'] = request()->domain() . $return_url;
        }
        if($type === 'share'){
            $config['user_poster_bg'] = isset($config['user_poster_bg']) && $config['user_poster_bg'] ? cdnurl($config['user_poster_bg'], true) : '';
            $config['user_poster_bg_color'] = $config['user_poster_bg_color'] ?? '#6A62D1';
        }
        $this->assignconfig('row', $config);
        $langList = (new \app\admin\model\Lang())->column('lang', 'id');
        $this->assignconfig('langList', $langList);

        return $this->view->fetch();  
    }

    /**
     * 删除
     * @param string $ids
     */
    public function del($ids = "")
    {
        $name = $this->request->post('name');
        $config = ConfigModel::getByName($name);
        if ($name && $config) {
            try {
                $config->delete();
                $this->refreshFile();
            } catch (Exception $e) {
                $this->error($e->getMessage());
            }
            $this->success();
        } else {
            $this->error(__('Invalid parameters'));
        }
    }

    /**
     * 刷新配置文件
     */
    protected function refreshFile()
    {
        $config = [];
        foreach ($this->model->all() as $k => $v) {
            $value = $v->toArray();
            if (in_array($value['type'], ['selects', 'checkbox', 'images', 'files'])) {
                $value['value'] = explode(',', $value['value']);
            }
            if ($value['type'] == 'array') {
                $value['value'] = (array)json_decode($value['value'], true);
            }
            $config[$value['name']] = $value['value'];
        }
        file_put_contents(
            APP_PATH . 'extra' . DS . 'site.php',
            '<?php' . "\n\nreturn " . var_export($config, true) . ";"
        );
    }

    /**
     * 检测配置项是否存在
     * @internal
     */
    public function check()
    {
        $params = $this->request->post("row/a");
        if ($params) {
            $config = $this->model->get($params);
            if (!$config) {
                return $this->success();
            } else {
                return $this->error(__('Name already exist'));
            }
        } else {
            return $this->error(__('Invalid parameters'));
        }
    }

    public function check_theme(){
        $theme = $this->request->param('theme');
        $domain = $_SERVER['HTTP_HOST'];
        $data = Http::post('https://shouquan2023.nymaite.cn/api/check', ['type'=>'dramas', 'url'=>$domain, 'theme'=>$theme]);
        $data = json_decode($data, true);
        if(isset($data['code']) && $data['code'] == 0){
             $this->error($data['msg'] ?? '未购买主题授权，请购买后重试！');
        }
        $this->success();
    }

    /**
     * 规则列表
     * @internal
     */
    public function rulelist()
    {
        //主键
        $primarykey = $this->request->request("keyField");
        //主键值
        $keyValue = $this->request->request("keyValue", "");

        $keyValueArr = array_filter(explode(',', $keyValue));
        $regexList = \app\common\model\Config::getRegexList();
        $list = [];
        foreach ($regexList as $k => $v) {
            if ($keyValueArr) {
                if (in_array($k, $keyValueArr)) {
                    $list[] = ['id' => $k, 'name' => $v];
                }
            } else {
                $list[] = ['id' => $k, 'name' => $v];
            }
        }
        return json(['list' => $list]);
    }

    /**
     * 导入站点测试数据
     */
    public function testdata(){
        $name = $this->request->post("name");
        if (!$name) {
            $this->error(__('Parameter %s can not be empty', 'name'));
        }
        if (!preg_match("/^[a-zA-Z0-9]+$/", $name)) {
            $this->error(__('Addon name incorrect'));
        }

        $config = $this->model->get(['name' => 'dramas', 'site_id'=>$this->site_id]);
        if(empty($config)){
            $this->error('请先配置当前页面信息并保存后再导入测试数据！');
        }
        $data = @json_decode($config['value'], true);
        $info = get_addon_info('dramas');
        if(isset($data['import']) && $data['import'] === $info['version']){
            $this->error('请勿重复导入测试数据'.$data['import'].'->'.$info['version']);
        }
        $sql = (isset($data['import']) && $data['import']) ? 'sitetestdata_'.$info['version'].'.sql' : 'sitetestdata.sql';
        try {
            $this->importsql($name, $sql);
            $data['import'] = $info['version'];
            $config->value = json_encode($data);
            $config->save();
        } catch (AddonException $e) {
            $this->result($e->getData(), $e->getCode(), __($e->getMessage()));
        } catch (Exception $e) {
            $this->error(__($e->getMessage()), $e->getCode());
        }
        $this->success(__('测试数据导入成功'), '');
    }

    /**
     * 导入SQL
     *
     * @param string $name     插件名称
     * @param string $fileName SQL文件名称
     * @return  boolean
     */
    private function importsql($name, $fileName)
    {
        $sqlFile = ADDON_PATH . $name . DS . $fileName;
        if (is_file($sqlFile)) {
            $lines = file($sqlFile);
            $templine = '';
            foreach ($lines as $line) {
                if (substr($line, 0, 2) == '--' || $line == '' || substr($line, 0, 2) == '/*') {
                    continue;
                }
                $templine .= $line;
                if (substr(trim($line), -1, 1) == ';') {
                    $templine = str_ireplace('__PREFIX__', config('database.prefix'), $templine);
                    $templine = str_ireplace('__SITEID__', $this->site_id, $templine);
                    $templine = str_ireplace('INSERT INTO ', 'INSERT IGNORE INTO ', $templine);
                    $is_cate = 1;
                    if(strpos($templine, '__LASTINSERTID__') !== false){
                        $id = $id ? $id : 0;
                        $templine = str_ireplace('__LASTINSERTID__', $id, $templine);
                        $is_cate = 0;
                    }
                    try {
                        Db::getPdo()->exec($templine);
                        if($is_cate === 1){
                            $id = Db::getPdo()->lastInsertId();
                        }
                    } catch (\PDOException $e) {
                        //$e->getMessage();
                    }
                    $templine = '';
                }
            }
        }
        return true;
    }

    /**
     * 发送测试邮件
     * @internal
     */
    public function emailtest()
    {
        $row = $this->request->post('row/a');
        $receiver = $this->request->post("receiver");
        if ($receiver) {
            if (!Validate::is($receiver, "email")) {
                $this->error(__('Please input correct email'));
            }
            \think\Config::set('site', array_merge(\think\Config::get('site'), $row));
            $email = new Email;
            $result = $email
                ->to($receiver)
                ->subject(__("This is a test mail", config('site.name')))
                ->message('<div style="min-height:550px; padding: 100px 55px 200px;">' . __('This is a test mail content', config('site.name')) . '</div>')
                ->send();
            if ($result) {
                $this->success();
            } else {
                $this->error($email->getError());
            }
        } else {
            $this->error(__('Invalid parameters'));
        }
    }

    /**
     * 打包下载静态资源
     */
    public function backup_download()
    {
        $assets_img_dir = ROOT_PATH.'public'.DS.'assets'.DS;
        $uploads_dir = ROOT_PATH.'public';

        $cache_addons = RUNTIME_PATH . 'addons_temp';
        $cache_assets_img_dir = $cache_addons . DS.'assets'.DS;
        if (!is_dir($cache_assets_img_dir)) {
            @mkdir($cache_assets_img_dir, 0755, true);
        }
        if (is_dir($assets_img_dir)) {
            @copydirs($assets_img_dir, $cache_assets_img_dir);
        }
        $lists = Db::name('attachment')->where('site_id', $this->auth->id)->where('storage','local')->select();
        foreach ($lists as $item){
            $local_url = $item['url'];
            $cache_uploads_dir = $cache_addons.$local_url;
            $path = pathinfo($cache_uploads_dir)['dirname'];
            if (!is_dir($path)) {
                @mkdir($path, 0755, true);
            }
            @copy($uploads_dir.$local_url, $cache_uploads_dir);
        }

        $addons_dir = RUNTIME_PATH . 'addons' . DS;
        if (!is_dir($addons_dir)) {
            @mkdir($addons_dir, 0755, true);
        }
        $filename = 'uploads'.time().'.zip';
        $file = $addons_dir.$filename;
        $zipFile = new ZipFile();
        try {
            $zipFile
                ->addDirRecursive($cache_addons . DS)
                ->saveAsFile($file)
                ->close();
        } catch (ZipException $e) {
            $this->error(__('Resource file compression failed: %s', $e));
        } finally {
            $zipFile->close();
        }
        if (file_exists($file)) {
            // 发送相关头部信息
            header('Content-Type: application/zip');
            header('Content-disposition: attachment; filename=' . $filename);
            header('Content-Length: ' . filesize($file));
            readfile($file);
            @unlink($file);
            @$this->deleteDirectory($cache_addons . DS);
            exit;
        } else {
            $this->error(__('Resource file download failed: %s', $file));
        }
    }

    private function deleteDirectory($dir) {
        if (!is_dir($dir)) {
            return false;
        }

        $files = array_diff(scandir($dir), array('.', '..'));

        foreach ($files as $file) {
            $path = $dir . DS . $file;

            if (is_dir($path)) {
                $this->deleteDirectory($path);
            } else {
                @unlink($path);
            }
        }

        return rmdir($dir);
    }

}