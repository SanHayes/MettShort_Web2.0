<?php

namespace app\admin\validate\dramas;

use think\Validate;

class Video extends Validate
{
    /**
     * 验证规则
     */
    protected $rule = [
        'title' => 'require',
        'subtitle' => 'require',
        'category_ids' => 'require',
        'image' => 'require',
        'price' => 'require',
        'vprice' => 'require',
        'episodes' => 'require',
        'score' => 'require',
        'description' => 'require',
    ];

    /**
     * 提示消息
     */
    protected $message = [
        'title.require' => '短剧名称必须填写',
        'subtitle.require' => '短剧副标题必须填写',
        'category_ids.require' => '所属分类必须选择',
        'image.require' => '短剧主图必须上传',
        'price.require' => '价格必须填写',
        'vprice.require' => 'VIP价格必须填写',
        'score.require' => '短剧评分必须填写',
        'description.require' => '短剧描述必须填写',
        'episodes.require' => '短剧总集数必须填写',
    ];

    /**
     * 验证场景
     */
    protected $scene = [
        'add'  => ['title', 'subtitle', 'image', 'category_ids','price', 'score', 'description', 'vprice', 'episodes'],
        'edit' => ['title', 'subtitle', 'image', 'category_ids','price', 'score', 'description', 'vprice', 'episodes'],
    ];
    
}
