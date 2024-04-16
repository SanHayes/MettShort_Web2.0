<?php

namespace addons\dramas\model;

use think\Model;
use traits\model\SoftDelete;

class Video extends Model
{

    use SoftDelete;


    // 表名
    protected $name = 'dramas_video';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    protected $hidden = ['site_id', 'flags', 'weigh', 'sales', 'status', 'deletetime'];

    // 追加属性
    protected $append = [
        'tags_arr',
        'category_text_arr',
        'year_text',
        'area_text',
    ];

    public static $fields = 'id,title,subtitle,image,flags,description,tags,price,vprice,episodes,score,sales,
    (views + fake_views) as views,(favorites + fake_favorites) as favorites,(shares + fake_shares) as shares,
    (likes + fake_likes) as likes,(sales + views + shares + favorites + likes + fake_views + fake_shares + fake_favorites + fake_likes) as hots';

    public function getCategoryList($site_id)
    {
        $category = Category::where('pid', 0)->where('type', 'video')->where('site_id', $site_id)->find();
        $category_list = [];
        if($category){
            $category_list = Category::where('pid', $category['id'])
                ->where('type', 'video')
                ->orderRaw('weigh desc, id asc')
                ->column('name', 'id');
        }
        return $category_list;
    }

    public function getYearList($site_id)
    {
        $category = Category::where('pid', 0)->where('type', 'year')->where('site_id', $site_id)->find();
        $category_list = [];
        if($category){
            $category_list = Category::where('pid', $category['id'])
                ->where('type', 'year')
                ->orderRaw('weigh desc, id asc')
                ->select();
            if($category_list){
                $category_list = collection($category_list)->toArray();
            }
        }
        return $category_list;
    }

    public function getAreaList($site_id)
    {
        $category = Category::where('pid', 0)->where('type', 'area')->where('site_id', $site_id)->find();
        $category_list = [];
        if($category){
            $category_list = Category::where('pid', $category['id'])
                ->where('type', 'area')
                ->orderRaw('weigh desc, id asc')
                ->select();
            if($category_list){
                $category_list = collection($category_list)->toArray();
            }
        }
        return $category_list;
    }

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
    public function getHotsAttr($value, $data)
    {
        $value = $value ?: ($data['hots'] ?? 0);
        return $value>=1000 ? rtrim(rtrim(bcdiv($value, 1000, 2), '0'), '.').'K' : $value;
    }

    public function getCategoryTextArrAttr($value, $data)
    {
        $value = $value ?: ($data['category_ids'] ?? '');
        if($value=='') return $value;
        $valueArr = $value?explode(',', $value):[];
        $site_id = Config::getSiteId();
        $list = $this->getCategoryList($site_id);
        return array_values(array_intersect_key($list, array_flip($valueArr)));
    }


    public function gettagsArrAttr($value, $data)
    {
        $value = $value ?: ($data['tags'] ?? '');
        $valueArr = $value?explode(',', $value):[];
        return $valueArr;
    }


    public function getYearTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['year_id']) ? $data['year_id'] : '');
        if($value == '') return $value;
        $site_id = Config::getSiteId();
        $yearList = $this->getYearList($site_id);
        $list = [];
        foreach ($yearList as $item){
            $list[$item['id']] = $item['name'];
        }
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getAreaTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['area_id']) ? $data['area_id'] : '');
        if($value == '') return $value;
        $site_id = Config::getSiteId();
        $areaList = $this->getAreaList($site_id);
        $list = [];
        foreach ($areaList as $item){
            $list[$item['id']] = $item['name'];
        }
        return isset($list[$value]) ? $list[$value] : '';
    }


    /**
     * 获取短剧列表
     * @param $params
     */
    public static function getVideoList($params){
        $model = self::where(['status'=>'up', 'site_id'=>$params['site_id'], 'lang_id'=>$params['lang_id']]);
        $order = 'weigh desc, id desc';
        $type = $params['type'] ?? '';
        if($type == 'recommend'){
            $model = $model->where('find_in_set(:flag,`flags`)', ['flag' => 'recommend']);
        }elseif($type == 'hot'){
            $model = $model->where('find_in_set(:flag,`flags`)', ['flag' => 'hot']);
        }elseif($type == 'free'){
            $user = User::info();
            if($user && $user->vip_expiretime > time()){
                $model = $model->where(function ($query) {
                    $query->where(implode("|", ['price', 'vprice']), 0);
                });
            }else{
                $model = $model->where('price', 0);
            }
        }elseif($type == 'score'){
            $order = 'score desc, weigh desc, id desc';
        }elseif($type == 'new'){
            $order = 'id desc';
        }elseif($type == 'top'){
            $order = 'hots desc, weigh desc, id desc';
        }
        if(isset($params['category_id']) && $params['category_id']){
            $model = $model->where('find_in_set(:category_id,`category_ids`)', ['category_id' => $params['category_id']]);
        }
        if(isset($params['area_id']) && $params['area_id']){
            $model = $model->where('area_id', $params['area_id']);
        }
        if(isset($params['year_id']) && $params['year_id']){
            $model = $model->where('year_id', $params['year_id']);
        }
        if(isset($params['tag']) && $params['tag']){
            $model = $model->where('find_in_set(:tag,`tags`)', ['tag' => $params['tag']]);
        }
        if (isset($params['search']) && $params['search']) {
            $search = $params['search'];
            // 模糊搜索字段
            $searcharr = ['title', 'subtitle', 'description'];
            $model = $model->where(function ($query) use ($searcharr, $search) {
                $query->where(implode("|", $searcharr), "LIKE", "%{$search}%")
                    ->whereOr("find_in_set('{$search}', tags)");
            });
        }
        $page = $params['page'] ?? 1;
        $pagesize = $params['pagesize'] ?? 10;
        $list = $model->field(self::$fields)
            ->orderRaw($order)
            ->page($page, $pagesize)
            ->select();
        return $list;
    }
}
