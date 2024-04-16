<?php

$defaultHooks = [
    'ad_success' => [            //广告
        'addons\\dramas\\listener\\task\\Ad'
    ],
    'share_success' => [            //邀请新用户
        'addons\\dramas\\listener\\task\\Share'
    ],
    'user_register_after' => [            //用户注册后
        'addons\\dramas\\listener\\task\\Register'
    ],
    'register_after' => [            //用户注册后推广关系保存
        'addons\\dramas\\listener\\Reseller'
    ],
    'finish_after' => [            //购买成功后分润
        'addons\\dramas\\listener\\Reseller'
    ],
    'order_after' => [            //版权分润
        'addons\\dramas\\listener\\Copyright'
    ],
];


return $defaultHooks;
