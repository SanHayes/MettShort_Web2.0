<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace addons\dramas\model;

use think\Model;

/**
 * 配置模型
 */
class Richtext extends Model
{

    // 表名,不含前缀
    protected $name = 'dramas_richtext';
    // 追加属性
    protected $append = [
    ];
    protected $hidden = ['deletetime'];

    public function getContentAttr($value, $data)
    {
        $content = $data['content'];
        $content = str_replace("<img src=\"/uploads", "<img style=\"width: 100%;!important\" src=\"" . cdnurl("/uploads", true), $content);
        $content = str_replace("<video src=\"/uploads", "<video style=\"width: 100%;!important\" src=\"" . cdnurl("/uploads", true), $content);
        return $content;
    }

}
