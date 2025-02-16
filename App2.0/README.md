# 迈特海外短剧短剧出海多语言版短剧APP H5

#### 介绍
迈特短剧系统是一款功能强大的海外短剧平台，包含H5、安卓APP、苹果APPP多种展示形式，支持PayPal支付、stripe支付，Facebook登录、游客登录、Google登录、多语言选择，提供多开的开源系统。该系统提供了丰富的短剧资源，支持用户免费观看热门短剧、影视作品，同时也支持多种付费观看方式，如单人、全款和会员等，满足不同用户的需求。

#### 软件架构
- 前端：uniapp
- 后端：php  fastadmin(thinkphp)

#### 产品开源
- 注：此产品仅开源老版本前端代码，后台代码以及最新产品并未开源。需要可联系我们购买商业版
- 开源代码不可用于任何商业用途。
- 商业版全部开源，并且提供售后更新以及技术支持。
 
## 企业官网： https://product.nymaite.cn

## 产品演示
#### 海外短剧后台演示
- 总后台：（语言包配置，站点添加，矩阵管理，系统更新）
- https://test.mettshort.nymaite.cn/nymaite_com.php
- 账号：admin
- 密码：联系开发者


#### 子后台：（短剧配置、支付、积分、货币等等都在子后台）
- https://test.mettshort.nymaite.cn/nymaite_com.php
- 账号：nymaite
- 密码：联系开发者
- 注：测试后台不与线上前端演示后台互通，只是功能展示

#### 前端演示：[http://video.nymaite.cn/h5](http://video.nymaite.cn/h5)

### 客户案例演示： 联系开发者
### Google上架案例： 联系开发者

## 联系开发者
![联系我们](static/git1.png)
- 开发者微信：kaifa8898  备注来意。


#### 产品介绍
![输入图片说明](uview-ui/components/%E8%AF%A6%E6%83%85%E5%B1%95%E7%A4%BA_01.png)
![输入图片说明](uview-ui/components/u--image/%E8%AF%A6%E6%83%85%E5%B1%95%E7%A4%BA_02.png)
![输入图片说明](uview-ui/components/u--image/%E8%AF%A6%E6%83%85%E5%B1%95%E7%A4%BA_03.png)
![输入图片说明](uview-ui/components/u--image/%E8%AF%A6%E6%83%85%E5%B1%95%E7%A4%BA_04.png)

### 产品功能文档
海外短剧功能表：联系客服。

## 版本更新记录

### V2.0（2024年03月19日）
⚡ 优化
- 优化语言包管理
- 优化会员管理
- 优化控制台数据统计
- 优化部分菜单tab选项
- ✅ 功能
- 新增用户游客登录
- 新增用户Google登录
- 新增用户Facebook登录
- 新增公告通知
- 新增轮播图内链跳转
- 新增轮播图外链跳转
- 新增短剧订单统计管理
- 新增VIP订单统计
- 新增分销商订单统计
- 新增分销记录统计
- 新增剧场积分统计


### V1.5.3（2024年1月30日）
- ⚡ 优化
- 添加剧集年份地区改成非必要填写

### 
- ⚡ 优化
- 支付后跳转页面无反应


### 版本：V1.4.6(2024-01-29) 
- ⚡ 优化
- 更改前端URL路由模式
- 修复用户无法修改个人信息
 

### 版本：V1.4.5(2024-01-13) 
- ⚡ 优化
- 积分流水适配多语言
- 电子邮件模板
- 视频地址泄露问题
- 后台视频管理功能
- 任务逻辑
- 后台配置项
- 点赞和收藏逻辑
- 🐞 修复
- 首页部分情况下500错误
- 后台分类隐藏失效问题
- 后台视频分类多语言兼容问题



### 版本：V1.4.0(2024-01-03) 
🐞 修复
- 腾讯云存储配置异常
- app端视频播放页无法调起支付
- app端部分页面键盘弹出时，输入框无法上升问题
- 调整手机号登录为后台可配置项
- 手机区号检索忽略大小写
- 视频播放页面积分显示异常问题
- 切换语言后，推荐视频列表未刷新
- ⚡ 优化
- 数据库断线重连
- 多语言分销商覆盖
- 支付显示微信支付问题
- 电子邮件验证码模板
- 短信及签名配置
- 积分充值页面内容展示
- 视频列表修复 
- ✅ 功能
- 营销统计功能
- 剧集增加一键清空
- 优化 视频自动播放（浏览器原则上不支持自动播放，根据浏览器策略的不同，会出现无法自动播放问题）
- 分享功能新UI
- 首页新UI

 

### 版本：V1.3.1(2023-12-22) 

- ✅ 功能
- 添加stripe支付，方便与东南亚地区常用支付方式
- 国际手机号登录注册功能
- 提现模块货币相关内容
- 用户个人中心手机号、邮箱可自由更换
- 重构提现体系兼容多币种提现

- ⚡ 优化
- 修复分销记录兼容多币种展示
- 修复系统配置多语言兼容
- 分类显示语言类别
- 所有订单增加货币符号
优化部分语言积分过小
- 🐞 修复
- APP端导航栏无法返回上一页


### V1.3.0（2023年12月25日）
- 添加stripe支付
- 适配短信宝国际短信发送
- 添加邮件发送模板
- 重构提现体系兼容多币种提现
- 修复分销记录兼容多币种展示
- 修复系统配置多语言兼容
- 后台分类显示语言类别
- 所有订单增加货币符号
- 优化部分语言积分过小
- 新增 国际手机号登录注册功能
- 新增 提现模块货币相关内容
- 新增 用户个人中心手机号、邮箱可自由更换
- 修复 APP端导航栏无法返回上一页


### V1.2.2（2023年12月15日）
- 优化语言包管理
- 添加货币设置，支持每种语言对应不同的收款货币
- 优化导入测试数据
- 修复批量导入视频异常
- 优化视频编辑分类显示
- 优化支付webhook地址
- 修复视频收藏数量显示异常
- 优化提现功能相关问题
- 优化任务多语言
- 新增 新用户首次验证码登录提示
- 修复 观看记录页面未登录时一直显示loading
- 修复 应用在设备中首次加载无法获取视频列表
- 新增 页面中相应货币展示
- 修改 调整部分页面UI布局



### V1.2.0（2023年12月10日）
- 优化语言包管理
- 添加货币设置
- 优化导入测试数据
- 修复批量导入视频异常
- 优化视频编辑分类显示
- 修复支付webhook地址
- 修复视频收藏数量显示异常
- 修复提现相关异常
- 优化任务多语言
- 新增 新用户首次验证码登录提示
- 修复 观看记录页面未登录时一直显示loading
- 修复 应用在设备中首次加载无法获取视频列表
- 新增 页面中相应货币展示
- 修改 调整部分页面UI布局

### V1.1.3（2023年12月9日）
- 修复PayPal支付
- 修复分销商有效期
- 修复短剧分类保存失败
- 优化短剧分类名称限制
- 优化语言包
- 优化PayPal支付配置


### V1.1.2（2023年12月7日）
- 1.后台支持多语言
- 2.后台协议、系统配置支持多语言配置
- 3.优化回调逻辑
- 4.多语言语言包配置问题处理
- - 5.视频批量导入功能完善
6.新版本上线


### V1.1.1（2023年11月20日）

- 1.优化Paypal支付回调问题
- 2.修复前端标题展示问题
- 3.新增注册登录时邮箱和手机号的识别问题
- 4.优化Paypal支付拉起展示图片
- 5.修复兼容问题



### V1.1.0（2023年11月12日）

- 1.海外短剧上线
- 2.增加saas多开功能
- 3.后台新增多语言自定义配置，不仅仅只支持英文。
- 4.后台多语言配置模块新增一键翻配置
- 5.前台多语言适配完成。

## 联系开发者
![联系我们](static/git1.png)
