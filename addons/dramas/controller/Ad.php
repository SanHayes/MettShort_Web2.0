<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace addons\dramas\controller;

use addons\dramas\model\Ad as AdModel;
use addons\dramas\model\Config;

/**
 * 广告管理
 */
class Ad extends Base
{
    protected $noNeedLogin = [];
    protected $noNeedRight = ['*'];
    protected $noNeedGuest = ['add', 'commit'];

    /**
     * @ApiTitle    (获取广告)
     */
    public function index(){
        $data = AdModel::getAd($this->lang_id, $this->site_id);
        $this->success(__('Operation completed'), $data);
    }

    /**
     * 添加记录
     * @ApiMethod   (POST)
     * @ApiParams   (name="data", type="string", required=true, description="加密数据")
     */
    public function add(){
        $data = $this->paramsDecrypt();
        $ad_id = $data['ad_id'] ?? '';
        $time = $data['time'] ?? 0;
        if($time+60*5 < time() || !$ad_id) $this->error(__('Error parameters'));
        $res = AdModel::addAd($this->lang_id, $this->site_id, $ad_id);
        if($res){
            $this->success(__('Operation completed'), ['id'=>$res['id']]);
        }
        $this->error(__('No results were found'));
    }

    /**
     * 奖励发放
     * @ApiMethod   (POST)
     * @ApiParams   (name="data", type="string", required=true, description="加密数据")
     */
    public function commit(){
        $data = $this->paramsDecrypt();
        $ad_log_id = $data['ad_log_id'] ?? '';
        $time = $data['time'] ?? 0;
        if($time+60*5 < time() || !$ad_log_id) $this->error(__('Error parameters'));
        $params = [
            'site_id'=>$this->site_id,
            'lang_id'=>$this->lang_id,
            'user_id'=>$this->auth->id,
            'ad_log_id'=>$ad_log_id,
        ];
        \think\Hook::listen('ad_success', $params);

        $this->success(__('Operation completed'));
    }

    /**
     * 解密参数
     * @return mixed
     */
    private function paramsDecrypt(){
        $encryptedData = $this->request->post('data');
        $encryptedData = str_replace(['-', '_'], ['+', '/'], $encryptedData);
        $encryptedData .= '===';
        $private_key = ROOT_PATH . 'addons/dramas/library/data/private_key.pem';
        $privateKey = openssl_pkey_get_private(file_get_contents($private_key));
        // 解密数据
        $decryptedData = '';
        openssl_private_decrypt(base64_decode($encryptedData), $decryptedData, $privateKey, OPENSSL_PKCS1_PADDING);

        return @json_decode(base64_decode($decryptedData), true);
    }
}
