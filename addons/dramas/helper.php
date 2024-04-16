<?php

/**
 * 检测系统必要环境
 */
if (!function_exists('check_env')) {
    function check_env($need = [], $is_throw = true)
    {
        $need = is_string($need) ? [$need] : $need;

        // 检查是否有版权分润功能
        if (in_array('copyright', $need)) {
            if (!class_exists(\app\admin\controller\dramas\Copyright::class)) {
                if ($is_throw) {
                    new \addons\dramas\exception\Exception('请先升级版权方分润');
                } else {
                    return false;
                }
            }
        }
        return true;
    }
}
