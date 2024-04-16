<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace addons\dramas\controller;

use addons\dramas\model\Block as BlockModel;

/**
 * 轮播图
 */
class Block extends Base
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    /**
     * @ApiTitle    (获取列表)
     * @ApiMethod   (GET)
     */
    public function index(){
        $params = ['site_id'=>$this->site_id, 'lang_id'=>$this->lang_id];
        $data = BlockModel::getBlockList($params);
        $this->success('', $data?$data:[]);
    }

}
