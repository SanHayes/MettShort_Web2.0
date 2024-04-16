<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace addons\dramas\controller;

use addons\dramas\model\Config;
use addons\dramas\model\Share as ShareModel;
use fast\Random;

/**
 * 分享
 * Class Share
 * @package addons\dramas\controller
 */
class Share extends Base
{

    protected $noNeedLogin = [];
    protected $noNeedRight = ['*'];
    protected $noNeedGuest = ['facebook'];

    /**
     * @ApiInternal
     * 小程序分享二维码
     * https://mettgpt.nymaite.cn/addons/dramas/wechat/wxacode?scene=165.1.0.3.1
     */
    public function qrcode(){
        $scene = $this->request->get('scene', '');
        if(empty($scene)){
            $scene = $this->auth->id.'.1.0.3.2';
        }
        $path = $this->request->get('path', 'pages/home/index');
        $url = request()->domain().'/addons/dramas/wechat/wxacode?scene='.$scene.'&sign='.$this->sign.'&path='.$path;
        $this->success('', ['qrcode'=>$url]);
    }

    /**
     * 获取分享记录
     * @return void
     */
    public function index()
    {
        $params = $this->request->get();

        $shares = ShareModel::getList($params);
        return $this->success('', $shares);
    }

    /**
     * 添加上级
     * @ApiParams   (name="id", type="integer", required=true, description="上级用户ID")
     * @ApiParams   (name="platform", type="string", required=true, description="平台:H5=H5,App=APP")
     */
    public function add()
    {
        $id = $this->request->get('id');
        $platform = $this->request->get('platform', '');
        $key = array_search($platform, array_keys(ShareModel::getEventMap('share_platform')));
        $spm = $id.'.3.0.'.($key+1).'.4';
        $share = ['spm'=>$spm, 'platform'=>$platform, 'site_id'=>$this->site_id, 'lang_id'=>$this->lang_id];
        try {
            \think\Db::transaction(function () use ($share) {
                \think\Hook::listen('register_after', $share);
            });
        } catch (\Exception $e) {
            $this->error($e->getMessage());
        }
        $this->success(__('Operation completed'));
    }


    /**
     * Facebook分享链接
     * @ApiSummary  ("使用spm方法拼接 shareUserId（分享者用户ID）.page（页面类型:1=首页（默认）,2=短剧,2=添加（手动））.pageId（短剧ID）.platform（平台渠道: 1=H5,2=App,3=Admin）.from（分享方式: 1=直接转发,2=海报,3=链接,4=补录）")
     * @ApiParams   (name="href", type="string", required=true, description="要分享的链接")
     * @ApiParams   (name="redirect_uri", type="string", required=true, description="分享后重定向网址")
     */
    public function facebook(){
        $url = 'https://www.facebook.com/dialog/share';
        $config = Config::where('name', 'facebook')->value('value');
        $config = @json_decode($config, true);
        $href = $this->request->param('href', $config['return_url'] ?? '');
        $redirect_uri = $this->request->param('redirect_uri', $config['return_url'] ?? '');
        $params['app_id'] = $config['app_id'] ?? '';
        $params['display'] = 'popup';
        // 要添加到分享内容中的话题标签。话题标签中必须有 # 符号
        //$params['hashtag'] = '#';
        // 要分享的链接
        $params['href'] = $href;
        // 用户点击分享对话框中的按钮后要重新定向到的网址
        $params['redirect_uri'] = $redirect_uri;
        $this->success('', $url . '?' . http_build_query($params));
    }

}
