<?php

namespace addons\dramas\model;

use think\Model;
use traits\model\SoftDelete;

class VideoEpisodes extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'dramas_video_episodes';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';
    protected $hidden = ['site_id', 'weigh', 'sales', 'status', 'deletetime'];

    // 追加属性
    protected $append = [
    ];

    public static $fields = ['id','vid','name','image','duration','price','vprice','sales',
        '(views + fake_views) as views','(favorites + fake_favorites) as favorites',
        '(shares + fake_shares) as shares','(likes + fake_likes) as likes'];


    public function getImageAttr($value, $data)
    {
        $value = $value ?: ($data['image'] ?? '');
        return $value ? cdnurl($value, true) : '';
    }
    public function getViewsAttr($value, $data)
    {
        $value = $value ?: ($data['views'] ?? 0);
        return $value>=1000 ? rtrim(rtrim(bcdiv($value, 1000, 2), '0'), '.').'K' : $value;
    }
    public function getSalesAttr($value, $data)
    {
        $value = $value ?: ($data['sales'] ?? 0);
        return $value>=1000 ? rtrim(rtrim(bcdiv($value, 1000, 2), '0'), '.').'K' : $value;
    }
    public function getSharesAttr($value, $data)
    {
        $value = $value ?: ($data['shares'] ?? 0);
        return $value>=1000 ? rtrim(rtrim(bcdiv($value, 1000, 2), '0'), '.').'K' : $value;
    }
    public function getFavoritesAttr($value, $data)
    {
        $value = $value ?: ($data['favorites'] ?? 0);
        return $value>=1000 ? rtrim(rtrim(bcdiv($value, 1000, 2), '0'), '.').'K' : $value;
    }
    public function getLikesAttr($value, $data)
    {
        $value = $value ?: ($data['likes'] ?? 0);
        return $value>=1000 ? rtrim(rtrim(bcdiv($value, 1000, 2), '0'), '.').'K' : $value;
    }

    /**
     * 推荐列表
     * @param $pagesize
     * @return bool|\PDOStatement|string|\think\Collection
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public static function getFreeList($site_id, $lang_id, $pagesize){
        $model = self::where(['site_id'=>$site_id, 'lang_id'=>$lang_id, 'status'=>'normal'])
            ->whereExists(function ($query) {
                $videoTableName = (new Video())->getQuery()->getTable();
                $tableName = (new self())->getQuery()->getTable();
                $query = $query->table($videoTableName)
                    ->where($videoTableName . '.id=' . $tableName . '.vid')
                    ->whereNull('deletetime')
                    ->where('status', 'up');
                return $query;
            });
        $user = User::info();
        if($user && $user->vip_expiretime > time()){
            $model = $model->where(function ($query) {
                $query->where(implode("|", ['price', 'vprice']), 0);
            });
        }else{
            $model = $model->where('price', 0);
        }
        $fields = self::$fields;
        $fields[] = 'video';
        $list = $model->orderRaw('rand()')
            ->field($fields)
            ->limit($pagesize)
            ->select();
        return $list;
    }

    public function video()
    {
        return $this->belongsTo('Video', 'vid', 'id', [], 'LEFT')->setEagerlyType(0);
    }
}
