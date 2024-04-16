<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace addons\dramas\validate;

use think\Validate;

class VipOrder extends Validate
{

    /**
     * 验证规则
     */
    protected $rule = [
        'vip_id' => 'require',
    ];

    /**
     * 提示消息
     */
    protected $message = [
        'vip_id.require' => '请选择vip套餐',
    ];

    /**
     * 字段描述
     */
    protected $field = [];

    /**
     * 验证场景
     */
    protected $scene = [
        'recharge' => ['vip_id'],
    ];
}
