<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace addons\dramas\validate;

use think\Validate;

class Usable extends Validate
{

    /**
     * 验证规则
     */
    protected $rule = [
        'usable_id' => 'require',
    ];

    /**
     * 提示消息
     */
    protected $message = [
        'usable_id.require' => '请选择剧场积分充值套餐',
    ];

    /**
     * 字段描述
     */
    protected $field = [];

    /**
     * 验证场景
     */
    protected $scene = [
        'recharge' => ['usable_id'],
    ];
}
