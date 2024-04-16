<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace addons\dramas\controller;

use addons\dramas\library\thirdLogin\ThirdLogin;
use addons\dramas\model\ResellerBind;
use addons\dramas\model\ResellerLog;
use addons\dramas\model\Richtext;
use addons\dramas\model\User as UserModel;
use app\common\library\Ems;
use app\common\library\Sms;
use fast\Random;
use think\Db;
use think\Log;
use think\Validate;
use addons\dramas\model\UserOauth;
use addons\dramas\model\Config;

/**
 * 会员管理
 */
class User extends Base
{
    protected $noNeedLogin = ['guestLogin', 'thirdAuthorize', 'thirdCallback', 'thirdLogin', 'accountLogin', 'captchaLogin', 'resetpwd'];
    protected $noNeedRight = '*';
    protected $noNeedGuest = ['changeemail', 'logout', 'delete'];

    public function _initialize()
    {
        return parent::_initialize();
    }

    /**
     * 会员中心
     */
    public function index()
    {
        $auth = \app\common\library\Auth::instance();
        $auth->setAllowFields(['id', 'parent_user_id', 'username', 'nickname', 'mobile', 'email', 'avatar', 'score', 'birthday', 'money',
            'group_id', 'verification', 'usable', 'vip_expiretime', 'reseller', 'is_vip']);
        $data = $auth->getUserinfo();
        $data['avatar'] = $data['avatar'] ? cdnurl($data['avatar'], true) : '';
        $data['vip_expiretime_text'] = $data['vip_expiretime'] ? date('Y-m-d', $data['vip_expiretime']) : '';
        $data['is_vip'] = $data['vip_expiretime'] > time() ? 1 : 0;

        $verification = $data['verification'];
        $verification->email = $verification->email ?? 0;
        $verification->mobile = $verification->mobile ?? 0;
        $data['verification'] = $verification;

        $user_oauth = UserOauth::where('user_id', $data['id'])->column('id', 'platform');
        $data['user_bind'] = $user_oauth;

        $data['reseller'] = ResellerBind::info();
        $data['parent_id'] = $data['parent_user_id'];
        $this->success('', $data);
    }

    /**
     * 分销商数据
     *
     * @return void
     */
    public function userData()
    {
        $auth = \app\common\library\Auth::instance();
        $auth->setAllowFields(['id', 'nickname', 'avatar', 'money', 'total_money', 'reseller']);
        $data = $auth->getUserinfo();
        $data['avatar'] = $data['avatar'] ? cdnurl($data['avatar'], true) : '';
        $data['reseller'] = ResellerBind::info();
        $data['reseller_money'] = ResellerLog::where('reseller_user_id', $data['id'])->sum('total_money');
        $data['today_reseller_money'] = ResellerLog::where('reseller_user_id', $data['id'])
            ->where('createtime', '>', strtotime(date('Y-m-d')))->sum('total_money');
        $config = Config::where('name', 'dramas')->where('site_id', $this->site_id)->value('value');
        $config = json_decode($config, true);
        $data['reseller_desc'] = [];
        if(isset($config['reseller_desc']) && $config['reseller_desc']){
            $data['reseller_desc'] = Richtext::get($config['reseller_desc'][$this->lang]);
        }
        $this->success('', $data);
    }

    /**
     * 密码登录
     * @ApiMethod   (POST)
     * @param string $account 账号
     * @param string $password 密码
     */
    public function accountLogin()
    {
        $account = $this->request->post('account');
        $password = $this->request->post('password');
        if (!$account || !$password) {
            $this->error(__('Invalid parameters'));
        }
        $ret = $this->auth->login($account, $password, $this->site_id);
        if ($ret) {
            $data = ['token' => $this->auth->getToken(), 'verification' => $this->auth->verification];
            $this->success(__('Logged in successful'), $data);
        } else {
            $this->error(__($this->auth->getError()));
        }
    }

    /**
     * 验证码登录/注册
     * @ApiMethod (POST)
     * @ApiParams   (name="account", type="string", required=true, description="手机号/邮箱")
     * @ApiParams   (name="captcha", type="string", required=true, description="验证码")
     * @ApiParams   (name="password", type="string", required=false, description="密码")
     * @ApiParams   (name="guest_user_id", type="string", required=false, description="游客id")
     * @ApiParams   (name="spm", type="string", required=false, description="分享标识")
     * @ApiParams   (name="platform", type="string", required=false, description="平台")
     */
    public function captchaLogin()
    {
        $account = $this->request->post('account');
        $captcha = $this->request->post('captcha');
        $password = $this->request->post('password');
        $guest_user_id = $this->request->post('guest_user_id');
        $spm = $this->request->post('spm');
        $platform = $this->request->header('platform', 'H5');
        if (!$account || !$captcha) {
            $this->error(__('Invalid parameters'));
        }
        if (Validate::is($account, "email")) {
            if (!Ems::check($account, $captcha, 'mobilelogin')) {
                $this->error(__('Captcha is incorrect'));
            }
            $user = \app\common\model\User::getByEmail($account);
        }elseif (Validate::regex($account, '/^\d+$/')) {
            if (!Sms::check($account, $captcha, 'mobilelogin')) {
                $this->error(__('Captcha is incorrect'));
            }
            $user = \app\common\model\User::getByMobile($account);
        }else{
            $this->error(__('Please enter the correct email account or phone number!'));
        }
        if ($user) {
            if ($user->status != 'normal') {
                $this->error(__('Account is locked'));
            }
            //如果已经有账号则直接登录
            $ret = $this->auth->direct($user->id);
        } else {
            if (Validate::is($account, "email")){
                $registerData['email'] = $account;
            }
            if (Validate::regex($account, '/^\d+$/')){
                $registerData['mobile'] = $account;
            }
            $registerData['guest_user_id'] = $guest_user_id;
            $registerData['password'] = $password;
            $registerData['spm'] = $spm;
            $registerData['platform'] = $platform;
            $registerData['mode'] = 'user';
            $ret = $this->register_user($registerData);
        }
        if ($ret) {
            if (Validate::is($account, "email")){
                Ems::flush($account, 'mobilelogin');
            }elseif (Validate::regex($account, "/^\d+$/")){
                Sms::flush($account, 'mobilelogin');
            }
            $data = ['token' => $this->auth->getToken(), 'verification' => $this->auth->verification];
            $this->success(__('Logged in successful'), $data);
        } else {
            $this->error($this->auth->getError());
        }
    }

    /**
     * 游客登录/注册
     * @ApiMethod (POST)
     * @ApiParams   (name="openid", type="string", required=true, description="设备码")
     * @ApiParams   (name="spm", type="string", required=false, description="分享标识")
     * 使用spm方法拼接 shareUserId(分享者用户ID).page(页面类型:1=首页(默认),2=短剧,2=添加(手动)).pageId(短剧ID).platform(平台渠道: 1=H5,2=App,3=Admin).from(分享方式: 1=直接转发,2=海报,3=链接,4=补录)
     * 例 spm=258.1.0.1.1 即为ID为258用户通过微信小程序平台生成了首页分享海报
     */
    public function guestLogin(){
        $openid = $this->request->post('openid');
        if (!$openid) {
            $this->error(__('Invalid parameters'));
        }
        $platform = $this->request->header('platform', 'H5');
        $spm = $this->request->post('spm');
        $decryptData['openid'] = $openid;
        $decryptData['spm'] = $spm;
        $token = Db::transaction(function () use ($platform, $decryptData) {
            try {
                $token = $this->oauthLoginByGuest($decryptData, $platform);
                return $token;
            } catch (\Exception $e) {
                $this->error($e->getMessage());
            }
        });
        if ($token) {
            $data = ['token' => $token, 'verification' => $this->auth->verification];
            $this->success(__('Logged in successful'), $data);
        } else {
            $this->error($this->auth->getError());
        }
    }

    /**
     * 三方登录授权URL
     * @ApiParams   (name="spm", type="string", required=false, description="分享标识")
     * @ApiParams   (name="guest_user_id", type="string", required=false, description="游客id")
     * @ApiParams   (name="redirect_url", type="string", required=true, description="跳转地址")
     * @ApiParams   (name="type", type="string", required=true, description="类型：google、facebook")
     * @throws \think\exception\DbException
     */
    public function thirdAuthorize(){
        $type = $this->request->get('type', 'google');
        $guest_user_id = $this->request->get('guest_user_id');
        $spm = $this->request->get('spm');
        $redirect_url = $this->request->get('redirect_url');

        $config = Config::get(['name' => $type, 'site_id'=>$this->site_id]);
        $config = @json_decode($config->value, true);
        if(empty($config)){
            $this->error(__('Please configure %s app first', $type));
        }
        $state = ['guest_user_id'=>$guest_user_id, 'spm'=>$spm, 'redirect_url'=>urlencode($redirect_url)];
        try {
            $third_login = new ThirdLogin($config);
            $url = $third_login->create($type)->withState(json_encode($state))->redirect();
        }catch (\Exception $e){
            $this->error(__($e->getMessage()));
        }
        $this->success('', ['url'=>$url]);
    }

    /**
     * 第三方注册
     * @ApiInternal
     * @throws \think\exception\DbException
     */
    public function thirdCallback(){
        $platform = $this->request->header('platform', 'H5');
        $type = request()->param('type');
        $code = request()->param('code');
        $state = request()->param('state', null, 'strip_tags');
        $state = json_decode($state, true);
        $decryptData['guest_user_id'] = $state['guest_user_id'];
        $decryptData['spm'] = $state['spm'];
        try {
            $config = Config::get(['name' => $type, 'site_id'=>$this->site_id]);
            $config = @json_decode($config->value, true);
            $third_login = new ThirdLogin($config);
            $user = $third_login->create($type)->userFromCode($code);
            $decryptData['openid'] = $user->getId();
            $decryptData['nickname'] = $user->getNickname();
            $decryptData['headimgurl'] = $user->getAvatar();
        }catch (\Exception $e){
            $this->error($e->getMessage());
        }
        //$decryptData['email'] = $user->getEmail();
        $decryptData['mode'] = 'user';
        $decryptData['platform'] = $platform;
        $decryptData['site_id'] = $this->site_id;
        $token = Db::transaction(function () use ($type, $platform, $decryptData) {
            try {
                $token = $this->oauthLoginOrRegister($decryptData, $platform, ucfirst($type));
                return $token;
            } catch (\Exception $e) {
                $this->error($e->getMessage());
            }
        });
        $redirect_url = urldecode($state['redirect_url']);
        if ($token) {
            $redirect_url .= (strpos($redirect_url, '?') === false ? '?' : '&').'token=' . $token;
        }
        header('Location: ' . $redirect_url);
    }

    /**
     * 三方登录(App)
     * @ApiMethod   (POST)
     * @ApiParams   (name="guest_user_id", type="string", required=false, description="游客id")
     * @ApiParams   (name="type", type="string", required=true, description="类型：google、facebook")
     * @ApiParams   (name="openid", type="string", required=true, description="三方id")
     * @ApiParams   (name="nickname", type="string", required=true, description="三方昵称")
     * @ApiParams   (name="headimgurl", type="string", required=true, description="三方头像")
     * @ApiParams   (name="email", type="string", required=true, description="三方邮箱")
     * @ApiParams   (name="spm", type="string", required=false, description="分享标识")
     */
    public function thirdLogin(){
        $platform = $this->request->header('platform', 'APP');
        $guest_user_id = $this->request->post('guest_user_id');
        $type = $this->request->post('type', 'google');
        $openid = $this->request->post('openid');
        $nickname = $this->request->post('nickname');
        $headimgurl = $this->request->post('headimgurl');
        $email = $this->request->post('email');
        $spm = $this->request->post('spm');
        $decryptData['guest_user_id'] = $guest_user_id;
        $decryptData['spm'] = $spm;
        $decryptData['openid'] = $openid;
        $decryptData['nickname'] = $nickname == 'undefined' ? null : $nickname;
        $decryptData['headimgurl'] = $headimgurl == 'undefined' ? null : $headimgurl;
        //$decryptData['email'] = $email;
        $decryptData['mode'] = 'user';
        $decryptData['site_id'] = $this->site_id;
        $token = Db::transaction(function () use ($type, $platform, $decryptData) {
            try {
                $token = $this->oauthLoginOrRegister($decryptData, $platform, ucfirst($type));
                return $token;
            } catch (\Exception $e) {
                $this->error($e->getMessage());
            }
        });
        if ($token) {
            $data = ['token' => $token, 'verification' => $this->auth->verification];
            $this->success(__('Logged in successful'), $data);
        } else {
            $this->error(__($this->auth->getError()));
        }
    }


    /**
     * 注册
     * 使用spm方法拼接 shareUserId(分享者用户ID).page(页面类型:1=首页(默认),2=短剧,3=添加(手动)).pageId(短剧ID).platform(平台渠道: 1=H5,2=App,3=Admin).from(分享方式: 1=直接转发,2=海报,3=链接,4=补录)
     * 例 spm=258.2.0.4.2 即为ID为258用户通过电脑网页平台生成了AI创作模板ID为0的分享海报
     * @param $registerData
     * @return bool
     */
    private function register_user($registerData){
        $username = $registerData['username'] ?? Random::alnum(20);
        $password = $registerData['password'] ?? Random::alnum();
        $mobile = $registerData['mobile'] ?? '';
        $email = $registerData['email'] ?? '';
        $nickname = $registerData['nickname'] ?? '';
        $avatar = $registerData['avatar'] ?? '';
        $spm = $registerData['spm'] ?? '';
        $platform = $registerData['platform'] ?? '';
        $mode = $registerData['mode'] ?? 'user';
        $extend = $this->getUserDefaultFields();
        $extend['user_head'] = $this->match;
        $extend['nickname'] = $nickname ? $nickname : $extend['nickname'];
        $extend['avatar'] = $avatar ? $avatar : $extend['avatar'];
        $extend['mode'] = $mode;
        $extend['site_id'] = $this->site_id;
        $this->{$extend['user_head']}();
        $registerResult = $this->auth->register($username, $password, $email, $mobile, $extend);
        if(!$registerResult) {
            $this->error(__($this->auth->getError()));
        }

        $user = $this->auth->getUser();
        if (empty($nickname)) {
            $user->nickname = $extend['nickname'] . $this->auth->getUser()->id;
            $user->save();
        }
        if(!empty($user->mobile)) {
            $verification = $user->verification;
            $verification->mobile = 1;
            $user->verification = $verification;
            $user->save();
        }
        if(!empty($user->email)) {
            $verification = $user->verification;
            $verification->email = 1;
            $user->verification = $verification;
            $user->save();
        }
        if(isset($registerData['password']) && $registerData['password']) {
            $verification = $user->verification;
            $verification->password = 1;
            $user->verification = $verification;
            $user->save();
        }

        // 同步游客账户
        if(isset($registerData['guest_user_id']) && $registerData['guest_user_id']){
            $guest_user = UserModel::get($registerData['guest_user_id']);
            if($guest_user){
                if($guest_user['parent_user_id']){
                    $user->parent_user_id = $guest_user['parent_user_id'];
                    $spm = \addons\dramas\model\Share::getSpm( $guest_user['id'], $guest_user['parent_user_id']);
                    if($spm){
                        $guest_share = ['mode'=>$mode, 'spm'=>$spm, 'platform'=>$platform, 'site_id'=>$this->site_id, 'lang_id'=>$this->lang_id];
                        \think\Hook::listen('register_after', $guest_share);
                    }
                }
                $user->usable = $guest_user['usable'];
                $user->save();
            }
            $this->synchronize($user->id, $registerData['guest_user_id']);
        }

        $data = ['user_id'=>$user['id'], 'site_id'=>$this->site_id, 'lang_id'=>$this->lang_id];
        \think\Hook::listen('user_register_after', $data);
        // 保存推荐记录和关系
        if($spm){
            try {
                $share = ['mode'=>$mode, 'spm'=>$spm, 'platform'=>$platform, 'site_id'=>$this->site_id, 'lang_id'=>$this->lang_id];
                \think\Hook::listen('register_after', $share);
            }catch (\Exception $e){
                Log::error('User-Reseller'.$e->getMessage());
            }
        }

        return true;
    }

    private function synchronize($user_id, $guest_user_id){
        // 意见反馈
        $feedback = Db::name('dramas_feedback')->where('user_id', $guest_user_id)->select();
        foreach ($feedback as &$item){
            $item['user_id'] = $user_id;
            unset($item['id']);
        }
        if($feedback){
            Db::name('dramas_feedback')->insertAll($feedback);
        }
        // 钱包日志
        $wallet_log = Db::name('dramas_user_wallet_log')->where('user_id', $guest_user_id)->select();
        foreach ($wallet_log as &$item){
            $item['user_id'] = $user_id;
            unset($item['id']);
        }
        if($wallet_log){
            Db::name('dramas_user_wallet_log')->insertAll($wallet_log);
        }
        // 短剧收藏点赞
        $video_favorite = Db::name('dramas_video_favorite')->where('user_id', $guest_user_id)->select();
        foreach ($video_favorite as &$item){
            $item['user_id'] = $user_id;
            unset($item['id']);
        }
        if($video_favorite){
            Db::name('dramas_video_favorite')->insertAll($video_favorite);
        }
        // 短剧追剧记录
        $video_log = Db::name('dramas_video_log')->where('user_id', $guest_user_id)->select();
        foreach ($video_log as &$item){
            $item['user_id'] = $user_id;
            unset($item['id']);
        }
        if($video_log){
            Db::name('dramas_video_log')->insertAll($video_log);
        }
    }

    /**
     * 修改邮箱
     * @ApiMethod (POST)
     * @ApiParams   (name="email", type="string", required=false, description="邮箱")
     * @ApiParams   (name="captcha", type="string", required=true, description="验证码")
     */
    public function changeemail()
    {
        $user = $this->auth->getUser();
        $email = $this->request->post('email');
        $captcha = $this->request->post('captcha');
        if (!$email || !$captcha) {
            $this->error(__('Invalid parameters'));
        }
        if (!Validate::is($email, "email")) {
            $this->error(__('Email is incorrect'));
        }
        if (\app\common\model\User::where('email', $email)->where('id', '<>', $user->id)->find()) {
            $this->error(__('Email already exists'));
        }
        $result = Ems::check($email, $captcha, 'changemobile');
        if (!$result) {
            $this->error(__('Captcha is incorrect'));
        }
        $verification = $user->verification;
        $verification->email = 1;
        $user->verification = $verification;
        $user->email = $email;
        $user->save();

        Ems::flush($email, 'changemobile');
        $this->success(__('Operation completed'));
    }

    /**
     * 修改手机号
     * @ApiMethod (POST)
     * @ApiParams   (name="mobile", type="string", required=false, description="手机号")
     * @ApiParams   (name="captcha", type="string", required=true, description="验证码")
     */
    public function changemobile()
    {
        $user = $this->auth->getUser();
        $mobile = $this->request->post('mobile');
        $captcha = $this->request->post('captcha');
        if (!$mobile || !$captcha) {
            $this->error(__('Invalid parameters'));
        }
        if (!Validate::regex($mobile, "/^\d+$/")) {
            $this->error(__('Mobile is incorrect'));
        }
        if (\app\common\model\User::where('mobile', $mobile)->where('id', '<>', $user->id)->find()) {
            $this->error(__('Mobile already exists'));
        }
        $result = Sms::check($mobile, $captcha, 'changemobile');
        if (!$result) {
            $this->error(__('Captcha is incorrect'));
        }
        $verification = $user->verification;
        $verification->mobile = 1;
        $user->verification = $verification;
        $user->mobile = $mobile;
        $user->save();

        Sms::flush($mobile, 'changemobile');
        $this->success(__('Operation completed'));
    }

    /**
     * 重置密码
     * @ApiMethod (POST)
     * @ApiParams   (name="account", type="string", required=false, description="手机号/邮箱")
     * @ApiParams   (name="captcha", type="string", required=true, description="验证码")
     * @ApiParams   (name="password", type="string", required=false, description="密码")
     */
    public function resetpwd()
    {
        $account = $this->request->post('account');
        $newpassword = $this->request->post("password");
        $captcha = $this->request->post("captcha");
        if (Validate::is($account, "email")) {
            $type = 'email';
            $email = $account;
        }elseif (Validate::regex($account, "/^\d+$/")) {
            $type = 'mobile';
            $mobile = $account;
        }else{
            $this->error(__('Please enter the correct email account or phone number!'));
        }
        if (!$newpassword || !$captcha) {
            $this->error(__('Invalid parameters'));
        }
        //验证Token
        if (!Validate::make()->check(['newpassword' => $newpassword], ['newpassword' => 'require|regex:\S{6,30}'])) {
            $this->error(__('Password must be 6 to 30 characters'));
        }
        if ($type == 'mobile') {
            $user = \app\common\model\User::getByMobile($mobile);
            if (!$user) {
                $this->error(__('User not found'));
            }
            $ret = Sms::check($mobile, $captcha, 'resetpwd');
            if (!$ret) {
                $this->error(__('Captcha is incorrect'));
            }
            Sms::flush($mobile, 'resetpwd');
        } else {
            $user = \app\common\model\User::getByEmail($email);
            if (!$user) {
                $this->error(__('User not found'));
            }
            $ret = Ems::check($email, $captcha, 'resetpwd');
            if (!$ret) {
                $this->error(__('Captcha is incorrect'));
            }
            Ems::flush($email, 'resetpwd');
        }
        //模拟一次登录
        $this->auth->direct($user->id);
        $ret = $this->auth->changepwd($newpassword, '', true);
        if ($ret) {
            $this->success(__('Reset password successful'));
        } else {
            $this->error($this->auth->getError());
        }
    }

    /**
     * 修改密码
     * @ApiMethod (POST)
     * @ApiParams   (name="oldpassword", type="string", required=false, description="旧密码")
     * @ApiParams   (name="newpassword", type="string", required=false, description="新密码")
     */
    public function changePwd()
    {
        $user = $this->auth->getUser();

        $oldpassword = $this->request->post("oldpassword");
        $newpassword = $this->request->post("newpassword");

        if (!$newpassword || !$oldpassword) {
            $this->error(__('Invalid parameters'));
        }
        if (strlen($newpassword) < 6 || strlen($newpassword) > 16) {
            $this->error(__('密码长度 6-16 位')); //TODO:密码规则校验
        }

        $ret = $this->auth->changepwd($newpassword, $oldpassword);

        if ($ret) {
            $this->auth->direct($user->id);
            $data = ['token' => $this->auth->getToken(), 'verification' => $this->auth->verification];
            $this->success(__('Change password successful'), $data);
        } else {
            $this->error($this->auth->getError());
        }
    }

    /**
     * 解除绑定
     * @ApiMethod   (POST)
     * @ApiParams   (name="platform", type="string", required=true, description="平台")
     * @ApiParams   (name="provider", type="string", required=true, description="厂商：Wechat微信")
     */
    public function unbindThirdOauth()
    {
        $user = $this->auth->getUser();
        $platform = $this->request->post('platform');
        $provider = $this->request->post('provider');

        $verification = $user->verification;
        if (!$verification->mobile) {
            $this->error(__('Please bind your phone number first before unbinding'));
        }

        $verifyField = $platform;
        if ($platform === 'App' && $provider === 'Wechat') {
            $verifyField = 'wxOpenPlatform';
        }

        $verification->$verifyField = 0;
        $user->verification = $verification;
        $user->save();
        $userOauth = UserOauth::where([
            'platform' => $platform,
            'provider'  => $provider,
            'user_id' => $user->id
        ])->delete();
        if ($userOauth) {
            $this->success(__('Unbind successful'));
        }
        $this->error(__('Unbind failed'));
    }

    /**
     * 注销登录
     */
    public function logout()
    {
        if ($this->auth->isLogin()) {
            $this->auth->logout();
        }
        $this->success(__('Logout successful'));
    }

    /**
     * 修改会员个人信息
     * @ApiMethod (POST)
     * @param string $avatar 头像地址
     * @param string $username 用户名
     * @param string $nickname 昵称
     * @param string $birthday 生日
     * @param string $bio 个人简介
     */
    public function profile()
    {
        $user = $this->auth->getUser();
        $user_id = $user['id'];
        $username = $this->request->post('username');
        $nickname = $this->request->post('nickname');
        $bio = $this->request->post('bio', '');
        $birthday = $this->request->post('birthday', '');
        $avatar = $this->request->post('avatar', '', 'trim,strip_tags,htmlspecialchars');
        if ($username) {
            $exists = \app\common\model\User::where('username', $username)->where('site_id', $this->site_id)
                ->where('id', '<>', $this->auth->id)->find();
            if ($exists) {
                $this->error(__('Username already exists'));
            }
            $user->username = $username;
        }
        if(!empty($nickname)){
            $user->nickname = $nickname;
        }
        if(!empty($bio)){
            $user->bio = $bio;
        }
        if(!empty($birthday)){
            $user->birthday = $birthday;
        }
        if (!empty($avatar)) {
            $user->avatar = $avatar;
        }
        $user->save();
        $this->success(__('Operation completed'));
    }

    /**
     * 用户注销
     *
     * @return void
     */
    public function delete()
    {
        $user = $this->auth->getUser();
        $this->auth->delete($user->id);

        UserOauth::where('user_id', $user->id)->delete();

        $this->success(__('Logout successful'));
    }

    // 游客登录（注册）
    private function oauthLoginByGuest($decryptData, $platform){
        $provider = 'Guest';
        $mode = 'guest';
        $oauthData = array_merge($decryptData, [
            'provider' => $provider,
            'platform' => $platform,
        ]);
        $userOauth = UserOauth::where(['openid' => $oauthData['openid'], 'user_id' => ['neq', 0]])
            ->where('provider', $provider)
            ->lock(true)->find();
        if (!$userOauth) {      // 没有找到第三方登录信息 创建新用户
            //默认创建新用户
            $oauthData['mode'] = $mode;
            $oauthData['logincount'] = 1;
            // 创建空用户
            $this->register_user($oauthData);
            $oauthData['user_id'] = $this->auth->getUser()->id;
            $oauthData['logincount'] = 1;
            $oauthData['updatetime'] = time();
            $oauthData['createtime'] = time();
            UserOauth::strict(false)->insert($oauthData);
        } else {
            // 找到第三方登录信息，直接登录
            $user_id = $userOauth->user_id;
            $user = UserModel::get($user_id);
            if(empty($user)){  // 用户已被删除 重新执行登录
                $userOauth->delete();
                $this->oauthLoginByGuest($decryptData, $platform);
            }else{
                if ($user->status != 'normal') {
                    throw new \Exception(__('Account is locked'));
                }
                if ($this->auth->direct($user_id) && $this->auth->getUser()) {       // 获取到用户
                    $oauthData['logincount'] = $userOauth->logincount + 1;
                    $userOauth->allowField(true)->save($oauthData);
                }
            }
        }

        if ($this->auth->getUser()) {
            $this->setUserVerification($this->auth->getUser(), $provider);
            return $this->auth->getToken();
        }
        return false;
    }

    /**
     * 第三方登录或自动注册或绑定
     *
     * @param string  $event        事件:login=登录, refresh=更新账号授权信息, bind=绑定第三方授权
     * @param array   $decryptData  解密参数
     * @param string  $platform     平台名称
     * @param string  $provider     厂商名称
     * @param int     $keeptime     有效时长
     * @return string $token        返回用户token
     */
    private function oauthLoginOrRegister($decryptData, $platform, $provider)
    {
        $oauthData = array_merge($decryptData, [
            'provider' => $provider,
            'platform' => $platform,
        ]);
        $userOauth = UserOauth::where(['openid' => $decryptData['openid'], 'site_id' => $decryptData['site_id'], 'user_id' => ['neq', 0]])
            ->where('provider', $provider)
            ->lock(true)->find();
        if (!$userOauth) {      // 没有找到第三方登录信息 创建新用户
            //默认创建新用户
            $createNewUser = true;
            $oauthData['logincount'] = 1;
            $extend = $this->getUserDefaultFields();
            $oauthData['headimgurl'] = $oauthData['avatar'] = isset($oauthData['headimgurl']) && $oauthData['headimgurl'] ? $oauthData['headimgurl'] : ($extend['avatar'] ? $extend['avatar'] : '');
            // 判断是否有unionid 并且已存在oauth数据中
            if (isset($oauthData['unionid'])) {
                //存在同厂商信息，添加oauthData数据，合并用户
                $userUnionOauth = UserOauth::get(['unionid' => $oauthData['unionid'], 'provider' => $provider, 'user_id' => ['neq', 0]]);
                if ($userUnionOauth) {
                    $existUser = $this->auth->direct($userUnionOauth->user_id);
                    if ($existUser) {
                        $createNewUser = false;
                    }
                }
            }
            // 创建空用户
            if ($createNewUser) {
                $this->register_user($oauthData);
            }
            $oauthData['user_id'] = $this->auth->getUser()->id;
            $oauthData['updatetime'] = time();
            $oauthData['createtime'] = time();
            UserOauth::strict(false)->insert($oauthData);
        } else {
            // 找到第三方登录信息，直接登录
            $user_id = $userOauth->user_id;
            $user = UserModel::get($user_id);
            if(empty($user)){
                $userOauth->delete();
                $this->oauthLoginOrRegister($decryptData, $platform, $provider);
            }else{
                if ($user->status != 'normal') {
                    throw new \Exception(__('Account is locked'));
                }
                if ($this->auth->direct($user_id) && $this->auth->getUser()) {       // 获取到用户
                    $oauthData['logincount'] = $userOauth->logincount + 1;
                    $userOauth->allowField(true)->save($oauthData);
                }
            }
        }

        if ($this->auth->getUser()) {
            $this->setUserVerification($this->auth->getUser(), $provider);
            return $this->auth->getToken();
        }
        return false;
    }

    private function getUserDefaultFields()
    {
        $userConfig = Config::get(['name' => 'user', 'site_id'=>$this->site_id]);
        $userConfig = isset($userConfig->value) ? json_decode($userConfig->value, true) : ['nickname'=>'Mett -', 'avatar'=>'/assets/img/logo.png'];
        return $userConfig;
    }

    private function setUserVerification($user, $provider)
    {
        $verification = $user->verification;
        if ($provider !== '') {
            $provider = strtolower($provider);
            $verification->$provider = 1;
            $user->verification = $verification;
            $user->save();
        }
    }

}
