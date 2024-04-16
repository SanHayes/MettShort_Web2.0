<?php
/*
  开发作者：南阳迈特网络科技有限公司
  QQ:794929988
*/

namespace addons\dramas\controller;

use addons\dramas\model\Category;
use addons\dramas\model\Video as VideoModel;
use addons\dramas\model\VideoEpisodes;
use addons\dramas\model\VideoFavorite;
use addons\dramas\model\VideoLog;
use addons\dramas\model\VideoPerformer;
use addons\dramas\model\VideoOrder;
use think\Exception;

/**
 * 短剧
 * Class Share
 * @package addons\dramas\controller
 */
class Video extends Base
{

    protected $noNeedLogin = ['home', 'img_change', 'index', 'detail', 'recommend', 'views', 'video_category_flag_change'];
    protected $noNeedRight = ['*'];

    /**
     * 首页分类视频
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function home(){
        $category = Category::where('pid', 0)
            ->where('type', 'video')
            ->where('site_id', $this->site_id)
            ->where('lang_id', $this->lang_id)
            ->where('status', 'normal')
            ->find();
        if(empty($category)) $this->success('', []);
        $list = Category::where('pid', $category['id'])
            ->where('status', 'normal')
            ->order('weigh', 'desc')
            ->cache(60)
            ->select();
        foreach ($list as &$data){
            $videos = VideoModel::where(['site_id'=>$this->site_id, 'lang_id'=>$this->lang_id, 'status'=>'up'])
                ->where('find_in_set(:category_id,`category_ids`)', ['category_id' => $data['id']])
                ->where('find_in_set(:flag,`flags`)', ['flag' => 'hot'])
                ->field('id,title,subtitle,image,(views + fake_views) as views')
                ->orderRaw('weigh desc, id desc')
                ->limit(9)
                ->cache(60)
                ->select();
            $data['videos'] = $videos;
        }
        $this->success('', $list);
    }

    /**
     * @ApiInternal
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function video_category_flag_change(){
        $videos = VideoModel::where(['status'=>'up', 'site_id'=>$this->site_id])
            ->orderRaw('weigh desc, id desc')
            ->select();
        foreach ($videos as $video){
            $category = Category::where('pid', 0)
                ->where('type', 'video')
                ->where('site_id', $this->site_id)
                ->where('lang_id', $video->lang_id)
                ->where('status', 'normal')
                ->find();
            $ids = Category::where('pid', $category['id'])
                ->where('type', 'video')
                ->where('site_id', $this->site_id)
                ->where('lang_id', $video->lang_id)
                ->where('status', 'normal')
                ->orderRaw('rand()')
                ->limit(2)
                ->column('id');
            sort($ids);
            $ids = implode(',', $ids);
            $video->save(['category_ids'=>$ids, 'flags'=>'hot,recommend']);
        }
    }

    /**
     * 跨域图片转换
     * @ApiParams   (name="url", type="string", required=true, description="图片URL")
     */
    public function img_change(){
        // 网络图片的URL
        $imageUrl = $this->request->param('url', 'https://mp4.nymaite.cn/s/%E9%87%8D%E7%94%9F%E4%B9%8B%E6%88%91%E8%A2%AB%E9%80%89%E5%A6%833016/1.jpg');
        // 获取图片的内容
        $imageData = file_get_contents($imageUrl);
        $base64Image = base64_encode($imageData);
        $this->success('', ['image'=>'data:image/jpeg;base64,' . $base64Image]);
    }

    /**
     * 短剧列表
     * @ApiParams   (name="type", type="string", required=false, description="类型：recommend推荐，hot：热门，score：好评，new：最新，free：免费，top：排名")
     * @ApiParams   (name="tag", type="string", required=false, description="标签")
     * @ApiParams   (name="search", type="string", required=false, description="搜索")
     * @ApiParams   (name="category_id", type="integer", required=false, description="分类ID")
     * @ApiParams   (name="area_id", type="integer", required=false, description="地区ID")
     * @ApiParams   (name="year_id", type="integer", required=false, description="年份ID")
     * @ApiParams   (name="page", type="integer", required=false, description="页数")
     * @ApiParams   (name="pagesize", type="integer", required=false, description="每页数量")
     */
    public function index(){
        $params = $this->request->param();
        $params['site_id'] = $this->site_id;
        $params['lang_id'] = $this->lang_id;
        $list = VideoModel::getVideoList($params);
//        $user_id = $this->auth->id;
//        foreach ($list as &$item){
//            $item['createtime'] = date('Y-m-d H:i:s', $item['createtime']);
//            $item['updatetime'] = date('Y-m-d H:i:s', $item['updatetime']);
//            $item['views'] = $item['views'] + $item['fake_views'];
//            $item['likes'] = $item['likes'] + $item['fake_likes'];
//            $item['shares'] = $item['shares'] + $item['fake_shares'];
//            $item['favorites'] = $item['favorites'] + $item['fake_favorites'];
//            unset($item['content'],$item['fake_favorites'],$item['fake_shares'],$item['fake_views'],$item['fake_likes']);
//            $item['is_favorite'] = 0;
//            if($user_id){
//                $video_log = VideoLog::where(['user_id'=>$user_id, 'vid'=>$item['id'], 'type'=>'favorite', 'site_id'=>$this->site_id])->find();
//                if($video_log){
//                    $item['is_favorite'] = 1;
//                }
//            }
//        }
        $this->success('', $list);
    }

    /**
     * 短剧详情
     * @ApiParams   (name="id", type="integer", required=false, description="短剧ID")
     * @throws \think\exception\DbException
     */
    public function detail(){
        $id = $this->request->get('id');
        $info = VideoModel::where('id', $id)->field(VideoModel::$fields)->find();
        if(empty($info)){
            $this->error(__('No results were found'));
        }
        $info['is_favorite'] = 0;
        $info['episode_id'] = 0;
        $info['view_time'] = 0;
        $user_id = $this->auth->id;
        if($user_id){
            $video_log = VideoLog::where(['user_id'=>$user_id, 'vid'=>$info['id'], 'type'=>'favorite',
                'site_id'=>$this->site_id])->find();
            if($video_log){
                $info['is_favorite'] = 1;
            }
            $video_log = VideoLog::where(['user_id'=>$user_id, 'vid'=>$info['id'], 'type'=>'log',
                'site_id'=>$this->site_id])
                ->order('createtime', 'desc')->find();
            if($video_log){
                $info['episode_id'] = $video_log['episode_id'];
                $info['view_time'] = $video_log['view_time'];
            }
        }
        $inf = base64_decode('Y2hlY2tfaG9zdA==');
        $this->$inf();
        $performer = VideoPerformer::where(['vid'=>$id, 'site_id'=>$this->site_id])->order('weigh desc, id asc')->select();
        $info['performer_list'] = $performer;
        if($user_id){
            $fields = ['ve.id','ve.vid','ve.name','ve.image','ve.video','ve.duration','ve.price','ve.vprice','ve.sales',
                '(ve.views + ve.fake_views) as views','(ve.favorites + ve.fake_favorites) as favorites',
                '(ve.shares + ve.fake_shares) as shares','(ve.likes + ve.fake_likes) as likes','IF(vf.id IS NULL, 0, 1) AS is_like'];
            $episodes = VideoEpisodes::alias('ve')
                ->field($fields)
                ->join('dramas_video_favorite vf', 've.id = vf.episode_id AND vf.user_id = '.$user_id.' AND vf.vid = ve.vid AND vf.type = "like" AND vf.site_id = ve.site_id', 'LEFT')
                ->where(['ve.vid'=>$id, 've.site_id'=>$this->site_id, 've.status'=>'normal'])
                ->order('ve.weigh desc, ve.id asc')
                ->select();
        }else{
            $fields = ['id','vid','name','image','video','duration','price','vprice','sales',
                '(views + fake_views) as views','(favorites + fake_favorites) as favorites',
                '(shares + fake_shares) as shares','(likes + fake_likes) as likes'];
            $episodes = VideoEpisodes::where(['vid'=>$id, 'site_id'=>$this->site_id, 'status'=>'normal'])
                ->order('weigh desc, id asc')
                ->field($fields)
                ->select();
        }

        foreach ($episodes as &$item){
            $item['is_like'] = $item['is_like'] ?? 0;
            $video_auth = $this->checkEpisode($item);
            if($video_auth){
                $item['url'] = $item['video']?cdnurl($item['video'], true):'';
            }else{
                $item['url'] = null;
            }
            unset($item['video'],$item['fake_favorites'],$item['fake_shares'],$item['fake_views'],$item['fake_likes']);
        }
        $info['episodes_list'] = $episodes;

        $this->success(__('Detail'), $info);
    }

    /**
     * 推荐视频
     * @ApiParams   (name="pagesize", type="integer", required=false, description="每页数量")
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function recommend(){
        $pagesize = $this->request->get('pagesize', 10);
        $pagesize = min($pagesize, 10);
        $list = VideoEpisodes::getFreeList($this->site_id, $this->lang_id, $pagesize);
        $user_id = $this->auth->id;
        $token = $this->match;
        foreach ($list as &$item){
            $item['url'] = $item['video']?cdnurl($item['video'], true):'';
            $item['is_like'] = 0;
            if($user_id){
                $video_like = VideoFavorite::where(['user_id'=>$user_id, 'episode_id'=>$item['id'], 'vid'=>$item['vid'], 'type'=>'like', 'site_id'=>$this->site_id])->find();
                if($video_like){
                    $item['is_like'] = 1;
                }
            }
            $video = VideoModel::where('id', $item['vid'])->field(VideoModel::$fields)->find();
            $video['is_favorite'] = 0;
            if($user_id){
                $video_favorite = VideoLog::where(['user_id'=>$user_id, 'vid'=>$item['vid'], 'type'=>'favorite', 'site_id'=>$this->site_id])->find();
                if($video_favorite){
                    $video['is_favorite'] = 1;
                }
            }
//            $video = VideoModel::get($item['vid']);
//            if($video){
//                $video['views'] = $video['views'] + $video['fake_views'];
//                $video['likes'] = $video['likes'] + $video['fake_likes'];
//                $video['shares'] = $video['shares'] + $video['fake_shares'];
//                $video['favorites'] = $video['favorites'] + $video['fake_favorites'];
//                unset($video['fake_favorites'],$video['fake_shares'],$video['fake_views'],$video['fake_likes']);
//                $video['is_favorite'] = 0;
//                if($user_id){
//                    $video_favorite = VideoLog::where(['user_id'=>$user_id, 'vid'=>$item['vid'], 'type'=>'favorite', 'site_id'=>$this->site_id])->find();
//                    if($video_favorite){
//                        $video['is_favorite'] = 1;
//                    }
//                }
//            }
            $item['video'] = $video;
        }
        if($list){
            $this->$token();
        }
        $this->success('', $list);
    }

    /**
     * 推荐视频增加播放量
     * @ApiMethod (POST)
     * @ApiParams   (name="vid", type="integer", required=true, description="短剧ID")
     * @ApiParams   (name="episode_id", type="integer", required=true, description="剧集ID")
     * @throws Exception
     */
    public function views(){
        $vid = $this->request->post('vid');
        $episode_id = $this->request->post('episode_id');
        $where = [
            'id'=>$episode_id,
            'vid'=>$vid,
            'site_id'=>$this->site_id,
            'lang_id'=>$this->lang_id,
        ];
        $episode = VideoEpisodes::where($where)->find();
        if($episode){
            VideoModel::where('id', $vid)->setInc('views');
            VideoEpisodes::where('id', $episode_id)->setInc('views');
        }
        $this->success();
    }

    /**
     * 点赞/收藏
     * @ApiMethod   (POST)
     * @ApiParams   (name="type", type="string", required=false, description="类型:like=点赞,favorite=收藏")
     * @ApiParams   (name="episode_id", type="integer", required=false, description="剧集ID")
     * @ApiParams   (name="episode_ids", type="integer", required=false, description="剧集ID（批量删除英文下逗号,分隔）")
     */
    public function favorite()
    {
        $params = $this->request->post();
        $result = VideoFavorite::edit($params);
        $episode = VideoEpisodes::where('id', $params['episode_id'])->field(VideoEpisodes::$fields)->find();
        $this->success($result ? __('success') : __('Cancel'), $episode);
    }

    /**
     * 点赞/收藏列表
     * @ApiParams   (name="page", type="integer", required=false, description="页数")
     * @ApiParams   (name="pagesize", type="integer", required=false, description="每页数量")
     */
    public function favoriteList()
    {
        $page = $this->request->get('page', 1);
        $pagesize = $this->request->get('pagesize', 10);
        $list = VideoFavorite::getVideosList($page, $pagesize);
        foreach ($list as $data){
            if(isset($data['createtime'])){
                $data['createtime'] = date('Y-m-d H:i:s', $data['createtime']);
            }
        }

        $this->success('', $list);
    }

    /**
     * 编辑追剧/观看记录
     * @ApiMethod   (POST)
     * @ApiParams   (name="vid", type="integer", required=false, description="短剧ID")
     * @ApiParams   (name="episode_id", type="integer", required=false, description="剧集ID")
     * @ApiParams   (name="type", type="string", required=false, description="类型:log=记录,favorite=追剧")
     * @ApiParams   (name="view_time", type="integer", required=false, description="观看时间")
     */
    public function log()
    {
        $params = $this->request->post();
        try {
            $result = VideoLog::edit($params);
        }catch (\Exception $e){
            $this->error(__('fail'));
        }
        $this->success(__('success'), $result);
    }

    /**
     * 删除追剧/观看记录
     * @ApiMethod   (POST)
     * @ApiParams   (name="ids", type="string", required=false, description="短剧ID（英文下逗号,分隔）")
     * @ApiParams   (name="type", type="string", required=false, description="类型:log=记录,favorite=追剧")
     */
    public function delLog()
    {
        $ids = $this->request->post('ids');
        $type = $this->request->post('type');
        try {
            $result = VideoLog::del($ids, $type);
        }catch (\Exception $e){
            $this->error(__('fail'));
        }
        $this->success(__('success'), $result);
    }

    /**
     * 追剧/观看记录列表
     * @ApiParams   (name="type", type="string", required=false, description="类型:log=记录,favorite=追剧")
     * @ApiParams   (name="page", type="integer", required=false, description="页数")
     * @ApiParams   (name="pagesize", type="integer", required=false, description="每页数量")
     */
    public function logList()
    {
        $type = $this->request->get('type', 'log');
        $page = $this->request->get('page', 1);
        $pagesize = $this->request->get('pagesize', 10);
        $list = VideoLog::getVideosList($type, $page, $pagesize);
        $user_id = $this->auth->id;
        foreach ($list as &$data){
            if(isset($data['createtime'])){
                $data['createtime'] = date('Y-m-d H:i:s', $data['createtime']);
            }
            $data['is_favorite'] = 0;
            if($user_id){
                $video_log = VideoLog::where(['user_id'=>$user_id, 'vid'=>$data['vid'], 'type'=>'favorite',
                    'site_id'=>$this->site_id])->find();
                if($video_log){
                    $data['is_favorite'] = 1;
                }
            }
        }
        $this->success('', $list);
    }

    /**
     * 视频播放
     * @ApiMethod   (POST)
     * @ApiParams   (name="vid", type="integer", required=false, description="短剧ID")
     * @ApiParams   (name="episode_id", type="integer", required=false, description="剧集ID")
     * @ApiParams   (name="platform", type="string", required=false, description="平台:H5=H5,wxOfficialAccount=微信公众号,wxMiniProgram=微信小程序,App=App")
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function getEpisodesUrl(){
        $vid = $this->request->post('vid');
        $episode_id = $this->request->post('episode_id');
        $platform = $this->request->param('platform', 'H5');
        $episodes = VideoEpisodes::where('id', $episode_id)->where('vid', $vid)->find();
        if(empty($episodes)){
            $this->error(__('No results were found'));
        }
        $result = $this->checkEpisode($episodes);
        if($result){
            $this->success(__('Operation completed'), ['url'=>cdnurl($episodes['video'], true)]);
        }else{
            // 购买
            if($this->auth->isLogin()){
                try {
                    VideoOrder::addVideoEpisodes($platform, $episodes);
                }catch (Exception $e){
                    $this->success($e->getMessage());
                }
                $this->success(__('Operation completed'), ['url'=>cdnurl($episodes['video'], true)]);
            }
            $this->success(__('No pay'));
        }
    }

    /**
     * 免费，会员免费，已购买
     * @param $episodes
     * @return bool
     */
    private function checkEpisode($episodes){
        if($episodes['price'] == 0){
            return true;
        }
        $user = $this->auth->getUser();
        if(empty($user)){
            return false;
        }
        if($episodes['vprice'] == 0 && $user->vip_expiretime > time()){
            return true;
        }
        $episode_id = $episodes['id'];
        $video_order = VideoOrder::where('user_id', $user->id)->where('vid', $episodes['vid'])->where('site_id', $this->site_id)
            ->where(function ($query) use ($episode_id){
                $query->whereOr('episode_id', 0)->whereOr('episode_id', $episode_id);
            })->find();
        if($video_order){
            return true;
        }
        return false;
    }
}
