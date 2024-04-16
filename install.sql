/*
 Navicat Premium Data Transfer

 Source Server         : 短剧多语言
 Source Server Type    : MySQL
 Source Server Version : 50650
 Source Host           : 119.91.97.139:3306
 Source Schema         : video_nymaite_cn

 Target Server Type    : MySQL
 Target Server Version : 50650
 File Encoding         : 65001

 Date: 07/12/2023 13:40:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for vs_admin
-- ----------------------------
DROP TABLE IF EXISTS `vs_admin`;
CREATE TABLE `vs_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `loginfailure` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败次数',
  `logintime` bigint(20) NULL DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录IP',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(20) NULL DEFAULT NULL COMMENT '更新时间',
  `token` varchar(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_admin
-- ----------------------------
INSERT INTO `vs_admin` VALUES (1, 'admin', '南阳迈特网络科技', 'd1310b7b18b7b19231fc8f26a1652edd', 'bAywI0', '/assets/img/avatar.png', 'admin@admin.com', '', 0, 1701910993, '42.229.249.151', 1491635035, 1701910993, '2486952e-8a70-44d8-b4e1-2a3e0a185e82', 'normal');
INSERT INTO `vs_admin` VALUES (3, 'nymaite', '南阳迈特网络科技', '437ad943cfb0b7c85d67149fc3f7e05a', 'TyLoBk', '/assets/img/avatar.png', 'nymaite@nymaite.com', '18888888888', 0, 1701910997, '42.229.249.151', 1700722372, 1701910997, 'bb13ad42-c6b9-4778-a2fb-defea9604f26', 'normal');

-- ----------------------------
-- Table structure for vs_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `vs_admin_log`;
CREATE TABLE `vs_admin_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '日志标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'User-Agent',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员日志表' ROW_FORMAT = Compact;


-- ----------------------------
-- Table structure for vs_area
-- ----------------------------
DROP TABLE IF EXISTS `vs_area`;
CREATE TABLE `vs_area`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(11) NULL DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简称',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) NULL DEFAULT NULL COMMENT '层级:1=省,2=市,3=区/县',
  `pinyin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '首字母',
  `lng` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经度',
  `lat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '地区表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_attachment
-- ----------------------------
DROP TABLE IF EXISTS `vs_attachment`;
CREATE TABLE `vs_attachment`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `site_id` int(11) NULL DEFAULT 0 COMMENT '站点',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类别',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '物理路径',
  `imagewidth` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '宽度',
  `imageheight` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '高度',
  `imagetype` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '图片帧数',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件名称',
  `filesize` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件大小',
  `mimetype` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '透传数据',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '创建日期',
  `updatetime` bigint(20) NULL DEFAULT NULL COMMENT '更新时间',
  `uploadtime` bigint(20) NULL DEFAULT NULL COMMENT '上传时间',
  `storage` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '附件表' ROW_FORMAT = Compact;


-- ----------------------------
-- Table structure for vs_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `vs_auth_group`;
CREATE TABLE `vs_auth_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父组别',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '规则ID',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(20) NULL DEFAULT NULL COMMENT '更新时间',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分组表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_auth_group
-- ----------------------------
INSERT INTO `vs_auth_group` VALUES (1, 0, 'Admin group', '*', 1491635035, 1491635035, 'normal');
INSERT INTO `vs_auth_group` VALUES (2, 1, '视频(站点)', '29,30,32,23,24,25,26,27,28,8,2,7,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271', 1689832041, 1689832041, 'normal');

-- ----------------------------
-- Table structure for vs_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `vs_auth_group_access`;
CREATE TABLE `vs_auth_group_access`  (
  `uid` int(10) UNSIGNED NOT NULL COMMENT '会员ID',
  `group_id` int(10) UNSIGNED NOT NULL COMMENT '级别ID',
  UNIQUE INDEX `uid_group_id`(`uid`, `group_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限分组表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_auth_group_access
-- ----------------------------
INSERT INTO `vs_auth_group_access` VALUES (1, 1);
INSERT INTO `vs_auth_group_access` VALUES (3, 2);

-- ----------------------------
-- Table structure for vs_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `vs_auth_rule`;
CREATE TABLE `vs_auth_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图标',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则URL',
  `condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否为菜单',
  `menutype` enum('addtabs','blank','dialog','ajax') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单类型',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扩展属性',
  `py` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '拼音首字母',
  `pinyin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '拼音',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(20) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(11) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `weigh`(`weigh`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 272 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '节点表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_auth_rule
-- ----------------------------
INSERT INTO `vs_auth_rule` VALUES (1, 'file', 0, 'dashboard', 'Dashboard', 'fa fa-dashboard', '', '', 'Dashboard tips', 1, NULL, '', 'kzt', 'kongzhitai', 1491635035, 1491635035, 143, 'normal');
INSERT INTO `vs_auth_rule` VALUES (2, 'file', 0, 'general', 'General', 'fa fa-cogs', '', '', '', 1, NULL, '', 'cggl', 'changguiguanli', 1491635035, 1491635035, 137, 'normal');
INSERT INTO `vs_auth_rule` VALUES (3, 'file', 0, 'category', 'Category', 'fa fa-leaf', '', '', 'Category tips', 0, NULL, '', 'flgl', 'fenleiguanli', 1491635035, 1491635035, 119, 'normal');
INSERT INTO `vs_auth_rule` VALUES (4, 'file', 0, 'addon', 'Addon', 'fa fa-rocket', '', '', 'Addon tips', 1, NULL, '', 'cjgl', 'chajianguanli', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (5, 'file', 0, 'auth', 'Auth', 'fa fa-group', '', '', '', 1, NULL, '', 'qxgl', 'quanxianguanli', 1491635035, 1491635035, 99, 'normal');
INSERT INTO `vs_auth_rule` VALUES (6, 'file', 2, 'general/config', 'Config', 'fa fa-cog', '', '', 'Config tips', 1, NULL, '', 'xtpz', 'xitongpeizhi', 1491635035, 1491635035, 53, 'normal');
INSERT INTO `vs_auth_rule` VALUES (7, 'file', 2, 'general/attachment', 'Attachment', 'fa fa-file-image-o', '', '', 'Attachment tips', 1, NULL, '', 'fjgl', 'fujianguanli', 1491635035, 1491635035, 34, 'normal');
INSERT INTO `vs_auth_rule` VALUES (8, 'file', 2, 'general/profile', 'Profile', 'fa fa-user', '', '', '', 1, NULL, '', 'grzl', 'gerenziliao', 1491635035, 1491635035, 60, 'normal');
INSERT INTO `vs_auth_rule` VALUES (9, 'file', 5, 'auth/admin', 'Admin', 'fa fa-user', '', '', 'Admin tips', 1, NULL, '', 'glygl', 'guanliyuanguanli', 1491635035, 1491635035, 118, 'normal');
INSERT INTO `vs_auth_rule` VALUES (10, 'file', 5, 'auth/adminlog', 'Admin log', 'fa fa-list-alt', '', '', 'Admin log tips', 1, NULL, '', 'glyrz', 'guanliyuanrizhi', 1491635035, 1491635035, 113, 'normal');
INSERT INTO `vs_auth_rule` VALUES (11, 'file', 5, 'auth/group', 'Group', 'fa fa-group', '', '', 'Group tips', 1, NULL, '', 'jsz', 'juesezu', 1491635035, 1491635035, 109, 'normal');
INSERT INTO `vs_auth_rule` VALUES (12, 'file', 5, 'auth/rule', 'Rule', 'fa fa-bars', '', '', 'Rule tips', 1, NULL, '', 'cdgz', 'caidanguize', 1491635035, 1491635035, 104, 'normal');
INSERT INTO `vs_auth_rule` VALUES (13, 'file', 1, 'dashboard/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 136, 'normal');
INSERT INTO `vs_auth_rule` VALUES (14, 'file', 1, 'dashboard/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 135, 'normal');
INSERT INTO `vs_auth_rule` VALUES (15, 'file', 1, 'dashboard/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 133, 'normal');
INSERT INTO `vs_auth_rule` VALUES (16, 'file', 1, 'dashboard/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 134, 'normal');
INSERT INTO `vs_auth_rule` VALUES (17, 'file', 1, 'dashboard/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 132, 'normal');
INSERT INTO `vs_auth_rule` VALUES (18, 'file', 6, 'general/config/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 52, 'normal');
INSERT INTO `vs_auth_rule` VALUES (19, 'file', 6, 'general/config/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 51, 'normal');
INSERT INTO `vs_auth_rule` VALUES (20, 'file', 6, 'general/config/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 50, 'normal');
INSERT INTO `vs_auth_rule` VALUES (21, 'file', 6, 'general/config/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 49, 'normal');
INSERT INTO `vs_auth_rule` VALUES (22, 'file', 6, 'general/config/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 48, 'normal');
INSERT INTO `vs_auth_rule` VALUES (23, 'file', 7, 'general/attachment/index', 'View', 'fa fa-circle-o', '', '', 'Attachment tips', 0, NULL, '', '', '', 1491635035, 1491635035, 59, 'normal');
INSERT INTO `vs_auth_rule` VALUES (24, 'file', 7, 'general/attachment/select', 'Select attachment', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 58, 'normal');
INSERT INTO `vs_auth_rule` VALUES (25, 'file', 7, 'general/attachment/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 57, 'normal');
INSERT INTO `vs_auth_rule` VALUES (26, 'file', 7, 'general/attachment/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 56, 'normal');
INSERT INTO `vs_auth_rule` VALUES (27, 'file', 7, 'general/attachment/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 55, 'normal');
INSERT INTO `vs_auth_rule` VALUES (28, 'file', 7, 'general/attachment/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 54, 'normal');
INSERT INTO `vs_auth_rule` VALUES (29, 'file', 8, 'general/profile/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 33, 'normal');
INSERT INTO `vs_auth_rule` VALUES (30, 'file', 8, 'general/profile/update', 'Update profile', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 32, 'normal');
INSERT INTO `vs_auth_rule` VALUES (31, 'file', 8, 'general/profile/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 31, 'normal');
INSERT INTO `vs_auth_rule` VALUES (32, 'file', 8, 'general/profile/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 30, 'normal');
INSERT INTO `vs_auth_rule` VALUES (33, 'file', 8, 'general/profile/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 29, 'normal');
INSERT INTO `vs_auth_rule` VALUES (34, 'file', 8, 'general/profile/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 28, 'normal');
INSERT INTO `vs_auth_rule` VALUES (35, 'file', 3, 'category/index', 'View', 'fa fa-circle-o', '', '', 'Category tips', 0, NULL, '', '', '', 1491635035, 1491635035, 142, 'normal');
INSERT INTO `vs_auth_rule` VALUES (36, 'file', 3, 'category/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 141, 'normal');
INSERT INTO `vs_auth_rule` VALUES (37, 'file', 3, 'category/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 140, 'normal');
INSERT INTO `vs_auth_rule` VALUES (38, 'file', 3, 'category/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 139, 'normal');
INSERT INTO `vs_auth_rule` VALUES (39, 'file', 3, 'category/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 138, 'normal');
INSERT INTO `vs_auth_rule` VALUES (40, 'file', 9, 'auth/admin/index', 'View', 'fa fa-circle-o', '', '', 'Admin tips', 0, NULL, '', '', '', 1491635035, 1491635035, 117, 'normal');
INSERT INTO `vs_auth_rule` VALUES (41, 'file', 9, 'auth/admin/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 116, 'normal');
INSERT INTO `vs_auth_rule` VALUES (42, 'file', 9, 'auth/admin/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 115, 'normal');
INSERT INTO `vs_auth_rule` VALUES (43, 'file', 9, 'auth/admin/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 114, 'normal');
INSERT INTO `vs_auth_rule` VALUES (44, 'file', 10, 'auth/adminlog/index', 'View', 'fa fa-circle-o', '', '', 'Admin log tips', 0, NULL, '', '', '', 1491635035, 1491635035, 112, 'normal');
INSERT INTO `vs_auth_rule` VALUES (45, 'file', 10, 'auth/adminlog/detail', 'Detail', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 111, 'normal');
INSERT INTO `vs_auth_rule` VALUES (46, 'file', 10, 'auth/adminlog/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 110, 'normal');
INSERT INTO `vs_auth_rule` VALUES (47, 'file', 11, 'auth/group/index', 'View', 'fa fa-circle-o', '', '', 'Group tips', 0, NULL, '', '', '', 1491635035, 1491635035, 108, 'normal');
INSERT INTO `vs_auth_rule` VALUES (48, 'file', 11, 'auth/group/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 107, 'normal');
INSERT INTO `vs_auth_rule` VALUES (49, 'file', 11, 'auth/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 106, 'normal');
INSERT INTO `vs_auth_rule` VALUES (50, 'file', 11, 'auth/group/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 105, 'normal');
INSERT INTO `vs_auth_rule` VALUES (51, 'file', 12, 'auth/rule/index', 'View', 'fa fa-circle-o', '', '', 'Rule tips', 0, NULL, '', '', '', 1491635035, 1491635035, 103, 'normal');
INSERT INTO `vs_auth_rule` VALUES (52, 'file', 12, 'auth/rule/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 102, 'normal');
INSERT INTO `vs_auth_rule` VALUES (53, 'file', 12, 'auth/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 101, 'normal');
INSERT INTO `vs_auth_rule` VALUES (54, 'file', 12, 'auth/rule/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 100, 'normal');
INSERT INTO `vs_auth_rule` VALUES (55, 'file', 4, 'addon/index', 'View', 'fa fa-circle-o', '', '', 'Addon tips', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (56, 'file', 4, 'addon/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (57, 'file', 4, 'addon/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (58, 'file', 4, 'addon/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (59, 'file', 4, 'addon/downloaded', 'Local addon', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (60, 'file', 4, 'addon/state', 'Update state', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (63, 'file', 4, 'addon/config', 'Setting', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (64, 'file', 4, 'addon/refresh', 'Refresh', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (65, 'file', 4, 'addon/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (66, 'file', 0, 'user', 'User', 'fa fa-user-circle', '', '', '', 0, NULL, '', 'hygl', 'huiyuanguanli', 1491635035, 1689831611, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (67, 'file', 66, 'user/user', 'User', 'fa fa-user', '', '', '', 1, NULL, '', 'hygl', 'huiyuanguanli', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (68, 'file', 67, 'user/user/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (69, 'file', 67, 'user/user/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (70, 'file', 67, 'user/user/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (71, 'file', 67, 'user/user/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (72, 'file', 67, 'user/user/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (73, 'file', 66, 'user/group', 'User group', 'fa fa-users', '', '', '', 1, NULL, '', 'hyfz', 'huiyuanfenzu', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (74, 'file', 73, 'user/group/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (75, 'file', 73, 'user/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (76, 'file', 73, 'user/group/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (77, 'file', 73, 'user/group/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (78, 'file', 73, 'user/group/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (79, 'file', 66, 'user/rule', 'User rule', 'fa fa-circle-o', '', '', '', 1, NULL, '', 'hygz', 'huiyuanguize', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (80, 'file', 79, 'user/rule/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (81, 'file', 79, 'user/rule/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (82, 'file', 79, 'user/rule/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (83, 'file', 79, 'user/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (84, 'file', 79, 'user/rule/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (85, 'file', 0, 'sites', 'Sites', 'fa fa-institution', '', '', '您现在是在超管后台，您需要退出当前用户，使用站点的账号密码进行登录则可管理您的网站信息。\r\n默认站点是指您的主站，域名URL里不会带后置参数。', 1, 'addtabs', '', 'S', 'Sites', 1685762684, 1700730791, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (86, 'file', 85, 'sites/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1685762684, 1685762684, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (87, 'file', 85, 'sites/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1685762684, 1685762684, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (88, 'file', 85, 'sites/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1685762684, 1685762684, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (89, 'file', 85, 'sites/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1685762684, 1685762684, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (90, 'file', 85, 'sites/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1685762684, 1685762684, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (91, 'file', 0, 'lang', 'Language', 'fa fa-language', '', '', '', 1, NULL, '', 'yyb', 'yuyanbao', 1700899458, 1700899458, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (92, 'file', 91, 'lang/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1700899458, 1700899458, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (93, 'file', 91, 'lang/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1700899459, 1700899459, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (94, 'file', 91, 'lang/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1700899459, 1700899459, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (95, 'file', 91, 'lang/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1700899459, 1700899459, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (96, 'file', 91, 'lang/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1700899459, 1700899459, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (97, 'file', 0, 'dramas', 'dramas', 'fa fa-home', '', '', '', 1, NULL, '', 'd', 'dramas', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (98, 'file', 97, 'dramas/user', 'User', 'fa fa-user', '', '', '', 1, NULL, '', 'U', 'User', 1701763067, 1701763067, 10, 'normal');
INSERT INTO `vs_auth_rule` VALUES (99, 'file', 98, 'dramas/user_wallet_apply', 'Wallet', 'fa fa-jpy', '', '', '', 1, NULL, '', 'W', 'Wallet', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (100, 'file', 99, 'dramas/user_wallet_apply/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (101, 'file', 99, 'dramas/user_wallet_apply/recyclebin', 'Recycle bin', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Rb', 'Recyclebin', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (102, 'file', 99, 'dramas/user_wallet_apply/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (103, 'file', 99, 'dramas/user_wallet_apply/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (104, 'file', 99, 'dramas/user_wallet_apply/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (105, 'file', 99, 'dramas/user_wallet_apply/destroy', 'destroy', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'd', 'destroy', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (106, 'file', 99, 'dramas/user_wallet_apply/restore', 'Restore', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'R', 'Restore', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (107, 'file', 99, 'dramas/user_wallet_apply/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (108, 'file', 99, 'dramas/user_wallet_apply/gettype', 'Get type', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Gt', 'Gettype', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (109, 'file', 99, 'dramas/user_wallet_apply/handle', 'Withdrawal', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'W', 'Withdrawal', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (110, 'file', 99, 'dramas/user_wallet_apply/log', 'Withdrawal log', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Wl', 'Withdrawallog', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (111, 'file', 98, 'dramas/user/index', 'User', 'fa fa-list-ul', '', '', '', 1, NULL, '', 'U', 'User', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (112, 'file', 111, 'dramas/user/change_parent_user', 'Parent user', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Pu', 'Parentuser', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (113, 'file', 98, 'dramas/user/select', 'Select', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'S', 'Select', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (114, 'file', 98, 'dramas/user/profile', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (115, 'file', 98, 'dramas/user/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (116, 'file', 98, 'dramas/user/vip_order_log', 'VIP order records', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Vor', 'VIPorderrecords', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (117, 'file', 98, 'dramas/user/login_log', 'Login log', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Ll', 'Loginlog', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (118, 'file', 98, 'dramas/user/money_log', 'Money log', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Ml', 'Moneylog', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (119, 'file', 98, 'dramas/user/score_log', 'Score log', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Sl', 'Scorelog', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (120, 'file', 98, 'dramas/user/share_log', 'Share log', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Sl', 'Sharelog', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (121, 'file', 98, 'dramas/user/usable_log', 'Usable log', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Ul', 'Usablelog', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (122, 'file', 98, 'dramas/user/reseller_order_log', 'Reseller order log', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Rol', 'Resellerorderlog', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (123, 'file', 98, 'dramas/user/update', 'Update', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'U', 'Update', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (124, 'file', 98, 'dramas/user/money_recharge', 'Recharge money', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Rm', 'Rechargemoney', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (125, 'file', 98, 'dramas/user/score_recharge', 'Recharge score', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Rs', 'Rechargescore', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (126, 'file', 98, 'dramas/user/usable_recharge', 'Recharge usable', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Ru', 'Rechargeusable', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (127, 'file', 97, 'dramas/setting', 'Setting', 'fa fa-file-text', '', '', '', 1, NULL, '', 'S', 'Setting', 1701763067, 1701763067, 4, 'normal');
INSERT INTO `vs_auth_rule` VALUES (128, 'file', 127, 'dramas/config', 'Config', 'fa fa-sliders', '', '', '', 1, NULL, '', 'C', 'Config', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (129, 'file', 128, 'dramas/config/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (130, 'file', 128, 'dramas/config/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (131, 'file', 128, 'dramas/config/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (132, 'file', 128, 'dramas/config/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (133, 'file', 128, 'dramas/config/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (134, 'file', 128, 'dramas/config/platform', 'Platform setting', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Ps', 'Platformsetting', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (135, 'file', 127, 'dramas/block', 'Block setting', 'fa fa-picture-o', '', '', '', 0, NULL, '', 'Bs', 'Blocksetting', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (136, 'file', 135, 'dramas/block/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (137, 'file', 135, 'dramas/block/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (138, 'file', 135, 'dramas/block/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (139, 'file', 135, 'dramas/block/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (140, 'file', 135, 'dramas/block/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (141, 'file', 127, 'dramas/richtext', 'Protocol', 'fa fa-language', '', '', '', 1, NULL, '', 'P', 'Protocol', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (142, 'file', 141, 'dramas/richtext/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (143, 'file', 141, 'dramas/richtext/recyclebin', 'Recycle bin', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Rb', 'Recyclebin', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (144, 'file', 141, 'dramas/richtext/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (145, 'file', 141, 'dramas/richtext/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (146, 'file', 141, 'dramas/richtext/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (147, 'file', 141, 'dramas/richtext/destroy', 'destroy', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'd', 'destroy', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (148, 'file', 141, 'dramas/richtext/restore', 'Restore', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'R', 'Restore', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (149, 'file', 141, 'dramas/richtext/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (150, 'file', 141, 'dramas/richtext/select', 'Select', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'S', 'Select', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (151, 'file', 127, 'dramas/version', 'Version', 'fa fa-picture-o', '', '', '', 1, NULL, '', 'V', 'Version', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (152, 'file', 151, 'dramas/version/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (153, 'file', 151, 'dramas/version/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (154, 'file', 151, 'dramas/version/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (155, 'file', 151, 'dramas/version/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (156, 'file', 151, 'dramas/version/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (157, 'file', 97, 'dramas/category', 'Category', 'fa fa-sitemap', '', '', '', 1, NULL, '', 'C', 'Category', 1701763067, 1701763067, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (158, 'file', 157, 'dramas/category/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (159, 'file', 157, 'dramas/category/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (160, 'file', 157, 'dramas/category/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (161, 'file', 157, 'dramas/category/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (162, 'file', 157, 'dramas/category/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (163, 'file', 157, 'dramas/category/select', 'Select', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'S', 'Select', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (164, 'file', 157, 'dramas/category/update', 'Update', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'U', 'Update', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (165, 'file', 97, 'dramas/videos', 'Videos', 'fa fa-shopping-bag', '', '', '', 1, NULL, '', 'V', 'Videos', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (166, 'file', 165, 'dramas/video', 'Videos', 'fa fa-shopping-bag', '', '', '', 1, NULL, '', 'V', 'Videos', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (167, 'file', 166, 'dramas/video/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (168, 'file', 166, 'dramas/video/recyclebin', 'Recycle bin', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Rb', 'Recyclebin', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (169, 'file', 166, 'dramas/video/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (170, 'file', 166, 'dramas/video/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (171, 'file', 166, 'dramas/video/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (172, 'file', 166, 'dramas/video/destroy', 'destroy', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'd', 'destroy', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (173, 'file', 166, 'dramas/video/restore', 'Restore', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'R', 'Restore', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (174, 'file', 166, 'dramas/video/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (175, 'file', 166, 'dramas/video/detail', 'Detail', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xq', 'xiangqing', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (176, 'file', 166, 'dramas/video/setstatus', 'Set status', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Ss', 'Setstatus', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (177, 'file', 165, 'dramas/video_images', 'Wallpaper', 'fa fa-shopping-bag', '', '', '', 1, NULL, '', 'W', 'Wallpaper', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (178, 'file', 177, 'dramas/video_images/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (179, 'file', 177, 'dramas/video_images/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (180, 'file', 177, 'dramas/video_images/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (181, 'file', 177, 'dramas/video_images/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (182, 'file', 177, 'dramas/video_images/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (183, 'file', 97, 'dramas/material', 'Other', 'fa fa-file-text', '', '', '', 0, NULL, '', 'O', 'Other', 1701763068, 1701763068, 3, 'normal');
INSERT INTO `vs_auth_rule` VALUES (184, 'file', 183, 'dramas/feedback', 'Feedback', 'fa fa-question-circle-o', '', '', '', 1, NULL, '', 'F', 'Feedback', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (185, 'file', 184, 'dramas/feedback/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (186, 'file', 184, 'dramas/feedback/recyclebin', 'Recycle bin', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Rb', 'Recyclebin', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (187, 'file', 184, 'dramas/feedback/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (188, 'file', 184, 'dramas/feedback/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (189, 'file', 184, 'dramas/feedback/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (190, 'file', 184, 'dramas/feedback/destroy', 'destroy', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'd', 'destroy', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (191, 'file', 184, 'dramas/feedback/restore', 'Restore', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'R', 'Restore', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (192, 'file', 184, 'dramas/feedback/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (193, 'file', 0, 'dramas/yingxiao', 'Marketing', 'fa fa-home', '', '', '', 1, NULL, '', 'M', 'Marketing', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (194, 'file', 193, 'dramas/viporder', 'Vip', 'fa fa-vimeo', '', '', '', 1, NULL, '', 'V', 'Vip', 1701763068, 1701763068, 10, 'normal');
INSERT INTO `vs_auth_rule` VALUES (195, 'file', 194, 'dramas/vip', 'Vip', 'fa fa-vimeo-square', '', '', '', 1, NULL, '', 'V', 'Vip', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (196, 'file', 195, 'dramas/vip/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (197, 'file', 195, 'dramas/vip/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (198, 'file', 195, 'dramas/vip/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (199, 'file', 195, 'dramas/vip/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (200, 'file', 195, 'dramas/vip/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (201, 'file', 194, 'dramas/vip_order', 'Vip order', 'fa fa-file-text', '', '', '', 1, NULL, '', 'Vo', 'Viporder', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (202, 'file', 201, 'dramas/vip_order/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (203, 'file', 201, 'dramas/vip_order/recyclebin', 'Recycle bin', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Rb', 'Recyclebin', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (204, 'file', 201, 'dramas/vip_order/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (205, 'file', 201, 'dramas/vip_order/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (206, 'file', 201, 'dramas/vip_order/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (207, 'file', 201, 'dramas/vip_order/destroy', 'destroy', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'd', 'destroy', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (208, 'file', 201, 'dramas/vip_order/restore', 'Restore', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'R', 'Restore', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (209, 'file', 201, 'dramas/vip_order/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (210, 'file', 193, 'dramas/reseller_log_order', 'Reseller', 'fa fa-vimeo', '', '', '', 1, NULL, '', 'R', 'Reseller', 1701763068, 1701763068, 9, 'normal');
INSERT INTO `vs_auth_rule` VALUES (211, 'file', 210, 'dramas/reseller', 'Reseller', 'fa fa-vimeo-square', '', '', '', 1, NULL, '', 'R', 'Reseller', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (212, 'file', 211, 'dramas/reseller/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (213, 'file', 211, 'dramas/reseller/recyclebin', 'Recycle bin', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Rb', 'Recyclebin', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (214, 'file', 211, 'dramas/reseller/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (215, 'file', 211, 'dramas/reseller/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (216, 'file', 211, 'dramas/reseller/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (217, 'file', 211, 'dramas/reseller/destroy', 'destroy', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'd', 'destroy', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (218, 'file', 211, 'dramas/reseller/restore', 'Restore', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'R', 'Restore', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (219, 'file', 211, 'dramas/reseller/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (220, 'file', 210, 'dramas/reseller_order', 'Reseller order', 'fa fa-file-text', '', '', '', 1, NULL, '', 'Ro', 'Resellerorder', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (221, 'file', 220, 'dramas/reseller_order/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (222, 'file', 220, 'dramas/reseller_order/recyclebin', 'Recycle bin', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Rb', 'Recyclebin', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (223, 'file', 220, 'dramas/reseller_order/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (224, 'file', 220, 'dramas/reseller_order/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (225, 'file', 220, 'dramas/reseller_order/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (226, 'file', 220, 'dramas/reseller_order/destroy', 'destroy', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'd', 'destroy', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (227, 'file', 220, 'dramas/reseller_order/restore', 'Restore', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'R', 'Restore', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (228, 'file', 220, 'dramas/reseller_order/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (229, 'file', 210, 'dramas/reseller_log', 'Reseller log', 'fa fa-file-text', '', '', '', 1, NULL, '', 'Rl', 'Resellerlog', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (230, 'file', 229, 'dramas/reseller_log/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (231, 'file', 229, 'dramas/reseller_log/recyclebin', 'Recycle bin', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Rb', 'Recyclebin', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (232, 'file', 229, 'dramas/reseller_log/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (233, 'file', 229, 'dramas/reseller_log/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (234, 'file', 229, 'dramas/reseller_log/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (235, 'file', 229, 'dramas/reseller_log/destroy', 'destroy', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'd', 'destroy', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (236, 'file', 229, 'dramas/reseller_log/restore', 'Restore', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'R', 'Restore', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (237, 'file', 229, 'dramas/reseller_log/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (238, 'file', 193, 'dramas/uableorder', 'Usable', 'fa fa-vimeo', '', '', '', 1, NULL, '', 'U', 'Usable', 1701763068, 1701763068, 8, 'normal');
INSERT INTO `vs_auth_rule` VALUES (239, 'file', 238, 'dramas/usable', 'Usable', 'fa fa-vimeo-square', '', '', '', 1, NULL, '', 'U', 'Usable', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (240, 'file', 239, 'dramas/usable/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (241, 'file', 239, 'dramas/usable/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (242, 'file', 239, 'dramas/usable/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (243, 'file', 239, 'dramas/usable/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (244, 'file', 239, 'dramas/usable/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (245, 'file', 238, 'dramas/usable_order', 'Usable order', 'fa fa-file-text', '', '', '', 1, NULL, '', 'Uo', 'Usableorder', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (246, 'file', 245, 'dramas/usable_order/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (247, 'file', 245, 'dramas/usable_order/recyclebin', 'Recycle bin', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Rb', 'Recyclebin', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (248, 'file', 245, 'dramas/usable_order/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (249, 'file', 245, 'dramas/usable_order/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (250, 'file', 245, 'dramas/usable_order/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (251, 'file', 245, 'dramas/usable_order/destroy', 'destroy', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'd', 'destroy', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (252, 'file', 245, 'dramas/usable_order/restore', 'Restore', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'R', 'Restore', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (253, 'file', 245, 'dramas/usable_order/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (254, 'file', 193, 'dramas/task', 'Task', 'fa fa-file-text', '', '', '', 1, NULL, '', 'T', 'Task', 1701763068, 1701763068, 7, 'normal');
INSERT INTO `vs_auth_rule` VALUES (255, 'file', 254, 'dramas/task/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (256, 'file', 254, 'dramas/task/recyclebin', 'Recycle bin', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Rb', 'Recyclebin', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (257, 'file', 254, 'dramas/task/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (258, 'file', 254, 'dramas/task/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (259, 'file', 254, 'dramas/task/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (260, 'file', 254, 'dramas/task/destroy', 'destroy', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'd', 'destroy', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (261, 'file', 254, 'dramas/task/restore', 'Restore', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'R', 'Restore', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (262, 'file', 254, 'dramas/task/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (263, 'file', 193, 'dramas/cryptocard', 'Cryptocard', 'fa fa-money', '', '', '', 1, NULL, '', 'C', 'Cryptocard', 1701763068, 1701763068, 6, 'normal');
INSERT INTO `vs_auth_rule` VALUES (264, 'file', 263, 'dramas/cryptocard/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'V', 'View', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (265, 'file', 263, 'dramas/cryptocard/recyclebin', 'Recycle bin', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'Rb', 'Recyclebin', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (266, 'file', 263, 'dramas/cryptocard/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (267, 'file', 263, 'dramas/cryptocard/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (268, 'file', 263, 'dramas/cryptocard/destroy', 'destroy', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'd', 'destroy', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (269, 'file', 263, 'dramas/cryptocard/restore', 'Restore', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'R', 'Restore', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (270, 'file', 263, 'dramas/cryptocard/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Multi', 1701763068, 1701763068, 0, 'normal');
INSERT INTO `vs_auth_rule` VALUES (271, 'file', 263, 'dramas/cryptocard/export', 'Export', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'E', 'Export', 1701763068, 1701763068, 0, 'normal');

-- ----------------------------
-- Table structure for vs_category
-- ----------------------------
DROP TABLE IF EXISTS `vs_category`;
CREATE TABLE `vs_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `flag` set('hot','index','recommend') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '自定义名称',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(20) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(11) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `weigh`(`weigh`, `id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分类表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_command
-- ----------------------------
DROP TABLE IF EXISTS `vs_command`;
CREATE TABLE `vs_command`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '类型',
  `params` varchar(1500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '参数',
  `command` varchar(1500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '命令',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '返回结果',
  `executetime` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '执行时间',
  `createtime` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('successed','failured') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'failured' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '在线命令表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_config
-- ----------------------------
DROP TABLE IF EXISTS `vs_config`;
CREATE TABLE `vs_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分组',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `visible` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '可见条件',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变量值',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变量字典数据',
  `rule` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扩展属性',
  `setting` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统配置' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_config
-- ----------------------------
INSERT INTO `vs_config` VALUES (1, 'name', 'basic', 'Site name', '请填写站点名称', 'string', '', '短剧', '', 'required', '', NULL);
INSERT INTO `vs_config` VALUES (2, 'beian', 'basic', 'Beian', '粤ICP备15000000号-1', 'string', '', '', '', '', '', NULL);
INSERT INTO `vs_config` VALUES (3, 'cdnurl', 'basic', 'Cdn url', '如果全站静态资源使用第三方云储存请配置该值', 'string', '', '', '', '', '', '');
INSERT INTO `vs_config` VALUES (4, 'version', 'basic', 'Version', '如果静态资源有变动请重新配置该值', 'string', '', '1.0.3', '', 'required', '', NULL);
INSERT INTO `vs_config` VALUES (5, 'timezone', 'basic', 'Timezone', '', 'string', '', 'Asia/Shanghai', '', 'required', '', NULL);
INSERT INTO `vs_config` VALUES (6, 'forbiddenip', 'basic', 'Forbidden ip', '一行一条记录', 'text', '', '', '', '', '', NULL);
INSERT INTO `vs_config` VALUES (7, 'languages', 'basic', 'Languages', '', 'array', '', '{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}', '', 'required', '', NULL);
INSERT INTO `vs_config` VALUES (8, 'fixedpage', 'basic', 'Fixed page', '请输入左侧菜单栏存在的链接', 'string', '', 'dashboard', '', 'required', '', NULL);
INSERT INTO `vs_config` VALUES (9, 'categorytype', 'dictionary', 'Category type', '', 'array', '', '{\"default\":\"Default\",\"page\":\"Page\",\"article\":\"Article\",\"test\":\"Test\"}', '', '', '', '');
INSERT INTO `vs_config` VALUES (10, 'configgroup', 'dictionary', 'Config group', '', 'array', '', '{\"basic\":\"Basic\",\"email\":\"Email\",\"dictionary\":\"Dictionary\",\"user\":\"User\",\"example\":\"Example\"}', '', '', '', '');
INSERT INTO `vs_config` VALUES (11, 'mail_type', 'email', 'Mail type', '选择邮件发送方式', 'select', '', '1', '[\"请选择\",\"SMTP\"]', '', '', '');
INSERT INTO `vs_config` VALUES (12, 'mail_smtp_host', 'email', 'Mail smtp host', '错误的配置发送邮件会导致服务器超时', 'string', '', 'smtp.qq.com', '', '', '', '');
INSERT INTO `vs_config` VALUES (13, 'mail_smtp_port', 'email', 'Mail smtp port', '(不加密默认25,SSL默认465,TLS默认587)', 'string', '', '465', '', '', '', '');
INSERT INTO `vs_config` VALUES (14, 'mail_smtp_user', 'email', 'Mail smtp user', '（填写完整用户名）', 'string', '', '10000', '', '', '', '');
INSERT INTO `vs_config` VALUES (15, 'mail_smtp_pass', 'email', 'Mail smtp password', '（填写您的密码或授权码）', 'string', '', 'password', '', '', '', '');
INSERT INTO `vs_config` VALUES (16, 'mail_verify_type', 'email', 'Mail vertify type', '（SMTP验证方式[推荐SSL]）', 'select', '', '2', '[\"无\",\"TLS\",\"SSL\"]', '', '', '');
INSERT INTO `vs_config` VALUES (17, 'mail_from', 'email', 'Mail from', '', 'string', '', '10000@qq.com', '', '', '', '');
INSERT INTO `vs_config` VALUES (18, 'attachmentcategory', 'dictionary', 'Attachment category', '', 'array', '', '{\"category1\":\"Category1\",\"category2\":\"Category2\",\"custom\":\"Custom\"}', '', '', '', '');
INSERT INTO `vs_config` VALUES (19, 'app_id', 'basic', '百度翻译APPID', '', 'string', '', '20231204001900524', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `vs_config` VALUES (20, 'sec_key', 'basic', '百度翻译密钥', '', 'string', '', 'OnaTbvenGtOK0NawlfG2', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');

-- ----------------------------
-- Table structure for vs_dramas_block
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_block`;
CREATE TABLE `vs_dramas_block`  (
    `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
    `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
    `lang_id` int(11) NOT NULL DEFAULT 0 COMMENT '语言',
    `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
    `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片',
    `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '链接',
    `url_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '链接标题',
    `video_id` int(11) NULL DEFAULT 0 COMMENT '视频',
    `parsetpl` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '链接类型:0=外部,1=内部',
    `weigh` int(11) NULL DEFAULT 0 COMMENT '权重',
    `createtime` bigint(20) NULL DEFAULT NULL COMMENT '添加时间',
    `updatetime` bigint(20) NULL DEFAULT NULL COMMENT '更新时间',
    `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态:normal=显示,hidden=隐藏',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '区块表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_category
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_category`;
CREATE TABLE `vs_dramas_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL DEFAULT 0 COMMENT '站点',
  `lang_id` int(11) NOT NULL COMMENT '语言',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `style` tinyint(1) NOT NULL DEFAULT 0 COMMENT '样式:1=一级分类,2=二级分类,3=三级分类',
  `type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '类型:video=视频,year=年份,area=地区',
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图片',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `weigh` int(11) NOT NULL DEFAULT 0 COMMENT '权重',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `status` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '状态',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `weigh_id`(`weigh`, `id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城分类表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_dramas_category
-- ----------------------------
INSERT INTO `vs_dramas_category` VALUES (28, 3, 1, '视频分类', 1, 'video', '', 0, 0, '', 'normal', 1689905480, 1701782680);
INSERT INTO `vs_dramas_category` VALUES (29, 3, 1, '战争片', 1, 'video', 'https://mtduanju.oss-cn-beijing.aliyuncs.com/uploads/20230721/5b04e2b7fb8117429b3ea75c4e5910b4.png', 28, 0, '战争片', 'normal', 1689905716, 1701781997);
INSERT INTO `vs_dramas_category` VALUES (30, 3, 1, '科幻片', 1, 'video', '', 28, 0, '科幻片', 'normal', 1689905716, 1701781997);
INSERT INTO `vs_dramas_category` VALUES (31, 3, 1, '偶像片', 1, 'video', '', 28, 0, '偶像片', 'normal', 1689905818, 1701781997);
INSERT INTO `vs_dramas_category` VALUES (32, 3, 1, '武侠片', 1, 'video', '', 28, 0, '', 'normal', 1689905818, 1701781997);
INSERT INTO `vs_dramas_category` VALUES (33, 3, 1, '古装片', 1, 'video', '', 28, 0, '', 'normal', 1689905818, 1701781997);
INSERT INTO `vs_dramas_category` VALUES (34, 3, 1, '纪录片', 1, 'video', '', 28, 0, '', 'normal', 1689905818, 1701781997);
INSERT INTO `vs_dramas_category` VALUES (35, 3, 1, '警匪片', 1, 'video', '', 28, 0, '', 'normal', 1689905818, 1701781997);
INSERT INTO `vs_dramas_category` VALUES (36, 3, 1, '喜剧片', 1, 'video', '', 28, 0, '', 'normal', 1689905818, 1701781997);
INSERT INTO `vs_dramas_category` VALUES (37, 3, 1, '动作片', 1, 'video', '', 28, 0, '', 'normal', 1689905818, 1701781997);
INSERT INTO `vs_dramas_category` VALUES (38, 3, 1, '恐怖片', 1, 'video', '', 28, 0, '', 'normal', 1689905818, 1701781997);
INSERT INTO `vs_dramas_category` VALUES (39, 3, 1, '视频年份', 1, 'year', '', 0, 0, '', 'normal', 1689905501, 1689905501);
INSERT INTO `vs_dramas_category` VALUES (40, 3, 1, '2015', 1, 'year', '', 39, 0, '', 'normal', 1689905956, 1689994556);
INSERT INTO `vs_dramas_category` VALUES (41, 3, 1, '2016', 1, 'year', '', 39, 0, '', 'normal', 1689905956, 1689994556);
INSERT INTO `vs_dramas_category` VALUES (42, 3, 1, '2017', 1, 'year', '', 39, 0, '', 'normal', 1689905956, 1689994556);
INSERT INTO `vs_dramas_category` VALUES (43, 3, 1, '2018', 1, 'year', '', 39, 0, '', 'normal', 1689905956, 1689994556);
INSERT INTO `vs_dramas_category` VALUES (44, 3, 1, '2019', 1, 'year', '', 39, 0, '', 'normal', 1689905956, 1689994556);
INSERT INTO `vs_dramas_category` VALUES (45, 3, 1, '2020', 1, 'year', '', 39, 0, '', 'normal', 1689905956, 1689994556);
INSERT INTO `vs_dramas_category` VALUES (46, 3, 1, '2021', 1, 'year', '', 39, 0, '', 'normal', 1689905956, 1689994556);
INSERT INTO `vs_dramas_category` VALUES (47, 3, 1, '2022', 1, 'year', '', 39, 0, '', 'normal', 1689905956, 1689994556);
INSERT INTO `vs_dramas_category` VALUES (48, 3, 1, '2023', 1, 'year', '', 39, 0, '', 'normal', 1689905956, 1689994556);
INSERT INTO `vs_dramas_category` VALUES (49, 3, 1, '视频地区', 1, 'area', '', 0, 0, '', 'normal', 1689905511, 1689905511);
INSERT INTO `vs_dramas_category` VALUES (50, 3, 1, '内地', 1, 'area', '', 49, 0, '', 'normal', 1689906006, 1689994558);
INSERT INTO `vs_dramas_category` VALUES (51, 3, 1, '港台', 1, 'area', '', 49, 0, '', 'normal', 1689906006, 1689994558);
INSERT INTO `vs_dramas_category` VALUES (52, 3, 1, '日韩', 1, 'area', '', 49, 0, '', 'normal', 1689906006, 1689994558);
INSERT INTO `vs_dramas_category` VALUES (53, 3, 1, '欧美', 1, 'area', '', 49, 0, '', 'normal', 1689906006, 1689994558);
INSERT INTO `vs_dramas_category` VALUES (54, 3, 1, '其他', 1, 'area', '', 49, 0, '', 'normal', 1689906006, 1689994558);
INSERT INTO `vs_dramas_category` VALUES (56, 3, 3, '英文分类', 1, 'video', '', 0, 0, '', 'normal', 1701783393, 1701783409);
INSERT INTO `vs_dramas_category` VALUES (57, 3, 3, 'War', 1, 'video', '', 56, 0, '', 'normal', 1701783466, 1701784146);
INSERT INTO `vs_dramas_category` VALUES (58, 3, 3, 'Sci-fi', 1, 'video', '', 56, 0, '', 'normal', 1701783466, 1701784146);
INSERT INTO `vs_dramas_category` VALUES (59, 3, 3, 'Idol', 1, 'video', '', 56, 0, '', 'normal', 1701783466, 1701784146);
INSERT INTO `vs_dramas_category` VALUES (60, 3, 3, 'Martial arts', 1, 'video', '', 56, 0, '', 'normal', 1701783466, 1701784146);
INSERT INTO `vs_dramas_category` VALUES (61, 3, 3, 'Period', 1, 'video', '', 56, 0, '', 'normal', 1701783466, 1701784146);
INSERT INTO `vs_dramas_category` VALUES (62, 3, 3, 'Documentary', 1, 'video', '', 56, 0, '', 'normal', 1701783466, 1701784146);
INSERT INTO `vs_dramas_category` VALUES (63, 3, 3, 'Action', 1, 'video', '', 56, 0, '', 'normal', 1701783466, 1701784146);
INSERT INTO `vs_dramas_category` VALUES (64, 3, 5, '泰语分类', 1, 'video', '', 0, 0, '', 'normal', 1701785023, 1701785023);
INSERT INTO `vs_dramas_category` VALUES (65, 3, 5, 'ภาพยนตร์สงคราม ', 1, 'video', '', 64, 0, '', 'normal', 1701785584, 1701785584);
INSERT INTO `vs_dramas_category` VALUES (66, 3, 5, 'ภาพยนตร์วิทยาศาสตร์', 1, 'video', '', 64, 0, '', 'normal', 1701785584, 1701785584);
INSERT INTO `vs_dramas_category` VALUES (67, 3, 5, 'ภาพยนตร์ไอดอล', 1, 'video', '', 64, 0, '', 'normal', 1701785584, 1701785584);
INSERT INTO `vs_dramas_category` VALUES (68, 3, 5, 'ภาพยนตร์วูเอเซีย', 1, 'video', '', 64, 0, '', 'normal', 1701785584, 1701785584);
INSERT INTO `vs_dramas_category` VALUES (69, 3, 5, ' ภาพยนตร์โบราณ ', 1, 'video', '', 64, 0, '', 'normal', 1701785584, 1701785584);
INSERT INTO `vs_dramas_category` VALUES (70, 3, 5, 'ภาพยนตร์แอ็คชั่น', 1, 'video', '', 64, 0, '', 'normal', 1701785584, 1701785584);
INSERT INTO `vs_dramas_category` VALUES (71, 3, 5, 'ภาพยนตร์ตลก', 1, 'video', '', 64, 0, '', 'normal', 1701785584, 1701785584);
INSERT INTO `vs_dramas_category` VALUES (72, 3, 4, '繁体分类', 1, 'video', '', 0, 0, '', 'normal', 1701785607, 1701785607);
INSERT INTO `vs_dramas_category` VALUES (73, 3, 4, '戰爭片', 1, 'video', '', 72, 0, '', 'normal', 1701785647, 1701785647);
INSERT INTO `vs_dramas_category` VALUES (74, 3, 4, '科幻片', 1, 'video', '', 72, 0, '', 'normal', 1701785647, 1701785647);
INSERT INTO `vs_dramas_category` VALUES (75, 3, 4, '偶像片', 1, 'video', '', 72, 0, '', 'normal', 1701785647, 1701785647);
INSERT INTO `vs_dramas_category` VALUES (76, 3, 4, '武俠片', 1, 'video', '', 72, 0, '', 'normal', 1701785647, 1701785647);
INSERT INTO `vs_dramas_category` VALUES (77, 3, 4, '古裝片', 1, 'video', '', 72, 0, '', 'normal', 1701785647, 1701785647);
INSERT INTO `vs_dramas_category` VALUES (78, 3, 4, '紀錄片', 1, 'video', '', 72, 0, '', 'normal', 1701785647, 1701785647);
INSERT INTO `vs_dramas_category` VALUES (79, 3, 7, '西班分类', 1, 'video', '', 0, 0, '', 'normal', 1701785790, 1701785790);
INSERT INTO `vs_dramas_category` VALUES (80, 3, 7, 'guerra', 1, 'video', '', 79, 0, '', 'normal', 1701785815, 1701785870);
INSERT INTO `vs_dramas_category` VALUES (81, 3, 7, 'ciencia ficción', 1, 'video', '', 79, 0, '', 'normal', 1701785815, 1701785870);
INSERT INTO `vs_dramas_category` VALUES (82, 3, 7, ' ídolos', 1, 'video', '', 79, 0, '', 'normal', 1701785815, 1701785870);
INSERT INTO `vs_dramas_category` VALUES (83, 3, 7, ' artes marciales', 1, 'video', '', 79, 0, '', 'normal', 1701785815, 1701785870);
INSERT INTO `vs_dramas_category` VALUES (84, 3, 7, ' época', 1, 'video', '', 79, 0, '', 'normal', 1701785815, 1701785870);
INSERT INTO `vs_dramas_category` VALUES (85, 3, 7, 'Documental', 1, 'video', '', 79, 0, '', 'normal', 1701785815, 1701785870);
INSERT INTO `vs_dramas_category` VALUES (86, 3, 7, ' acción', 1, 'video', '', 79, 0, '', 'normal', 1701785815, 1701785870);
INSERT INTO `vs_dramas_category` VALUES (87, 3, 7, 'comedia', 1, 'video', '', 79, 0, '', 'normal', 1701785815, 1701785870);
INSERT INTO `vs_dramas_category` VALUES (88, 3, 8, '阿拉分类', 1, 'video', '', 0, 0, '', 'normal', 1701785881, 1701785881);
INSERT INTO `vs_dramas_category` VALUES (89, 3, 8, 'فيلم حرب', 1, 'video', '', 88, 0, '', 'normal', 1701785889, 1701785889);
INSERT INTO `vs_dramas_category` VALUES (90, 3, 8, 'فيلم خيال علمي', 1, 'video', '', 88, 0, '', 'normal', 1701785889, 1701785889);
INSERT INTO `vs_dramas_category` VALUES (91, 3, 8, 'فيلم أيدول', 1, 'video', '', 88, 0, '', 'normal', 1701785889, 1701785889);
INSERT INTO `vs_dramas_category` VALUES (92, 3, 8, 'فيلم فنون قتالية', 1, 'video', '', 88, 0, '', 'normal', 1701785889, 1701785889);
INSERT INTO `vs_dramas_category` VALUES (93, 3, 8, 'فيلم تاريخي', 1, 'video', '', 88, 0, '', 'normal', 1701785889, 1701785889);
INSERT INTO `vs_dramas_category` VALUES (94, 3, 8, 'فيلم وثائقي', 1, 'video', '', 88, 0, '', 'normal', 1701785889, 1701785889);
INSERT INTO `vs_dramas_category` VALUES (95, 3, 8, 'فيلم \'**\'', 1, 'video', '', 88, 0, '', 'normal', 1701785889, 1701785889);
INSERT INTO `vs_dramas_category` VALUES (96, 3, 8, 'فيلم كوميدي', 1, 'video', '', 88, 0, '', 'normal', 1701785889, 1701785889);
INSERT INTO `vs_dramas_category` VALUES (97, 3, 9, '越南分类', 1, 'video', '', 0, 0, '', 'normal', 1701785995, 1701785995);
INSERT INTO `vs_dramas_category` VALUES (98, 3, 9, ' chiến tranh', 1, 'video', '', 97, 0, '', 'normal', 1701786030, 1701786058);
INSERT INTO `vs_dramas_category` VALUES (99, 3, 9, ' khoa học viễn tưởng', 1, 'video', '', 97, 0, '', 'normal', 1701786030, 1701786058);
INSERT INTO `vs_dramas_category` VALUES (100, 3, 9, ' idol', 1, 'video', '', 97, 0, '', 'normal', 1701786030, 1701786058);
INSERT INTO `vs_dramas_category` VALUES (101, 3, 9, ' võ hiệp', 1, 'video', '', 97, 0, '', 'normal', 1701786030, 1701786058);
INSERT INTO `vs_dramas_category` VALUES (102, 3, 9, ' cổ trang', 1, 'video', '', 97, 0, '', 'normal', 1701786030, 1701786058);
INSERT INTO `vs_dramas_category` VALUES (103, 3, 9, ' tài liệu', 1, 'video', '', 97, 0, '', 'normal', 1701786030, 1701786058);
INSERT INTO `vs_dramas_category` VALUES (104, 3, 9, ' hàiđộng', 1, 'video', '', 97, 0, '', 'normal', 1701786030, 1701786058);
INSERT INTO `vs_dramas_category` VALUES (105, 3, 9, ' hài', 1, 'video', '', 97, 0, '', 'normal', 1701786030, 1701786058);
INSERT INTO `vs_dramas_category` VALUES (106, 3, 9, ' hành động', 1, 'video', '', 97, 0, '', 'normal', 1701786031, 1701786058);

-- ----------------------------
-- Table structure for vs_dramas_config
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_config`;
CREATE TABLE `vs_dramas_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分组',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `value` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '变量值',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变量字典数据',
  `rule` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '扩展属性',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '配置' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_dramas_config
-- ----------------------------
INSERT INTO `vs_dramas_config` VALUES (11, 3, 'paypal', 'payment', '贝宝支付', '', 'array', '{\"platform\":[\"H5\",\"App\"],\"environment\":\"sandbox\",\"clent_id\":\"\",\"client_secret\":\"\",\"webhook\":\"\"}', NULL, '', '');
INSERT INTO `vs_dramas_config` VALUES (12, 3, 'dramas', 'basic', '系统信息', '', 'array', '{\"name\":{\"zh-cn\":\"迈特短剧\",\"en\":\"METT SHORT\",\"zh-tw\":\"迈特短劇\",\"taiyu\":\"ละครสั้นไมท์\",\"xibanya\":\"Drama corto de Maite\",\"alabo\":\"Matti lühimäng\",\"yuenan\":\"Kịch ngắn của Meter\",\"xiongyali\":\"\"},\"domain\":\"\",\"lang_id\":\"3\",\"h5\":\"\",\"h5_theme\":\"default\",\"version\":\"1.1.0\",\"logo\":\"\",\"company\":\"/uploads/20231206/7bcec13529689b602658683acff1495a.png\",\"copyright\":{\"list\":[{\"image\":\"\",\"name\":\"1\",\"url\":\"2\"}]},\"mobile_switch\":\"1\",\"android_autoplay\":\"1\",\"user_protocol\":{\"zh-cn\":\"8\",\"en\":\"20\",\"zh-tw\":\"60\",\"taiyu\":\"28\",\"xibanya\":\"36\",\"alabo\":\"44\",\"yuenan\":\"52\",\"xiongyali\":\"\"},\"privacy_protocol\":{\"zh-cn\":\"2\",\"en\":\"14\",\"zh-tw\":\"54\",\"taiyu\":\"22\",\"xibanya\":\"30\",\"alabo\":\"38\",\"yuenan\":\"46\",\"xiongyali\":\"\"},\"about_us\":{\"zh-cn\":\"3\",\"en\":\"15\",\"zh-tw\":\"55\",\"taiyu\":\"23\",\"xibanya\":\"31\",\"alabo\":\"39\",\"yuenan\":\"47\",\"xiongyali\":\"\"},\"contact_us\":{\"zh-cn\":\"1\",\"en\":\"13\",\"zh-tw\":\"53\",\"taiyu\":\"23\",\"xibanya\":\"29\",\"alabo\":\"37\",\"yuenan\":\"45\",\"xiongyali\":\"\"},\"legal_notice\":{\"zh-cn\":\"4\",\"en\":\"16\",\"zh-tw\":\"56\",\"taiyu\":\"24\",\"xibanya\":\"32\",\"alabo\":\"40\",\"yuenan\":\"48\",\"xiongyali\":\"\"},\"usable_desc\":{\"zh-cn\":\"7\",\"en\":\"19\",\"zh-tw\":\"59\",\"taiyu\":\"27\",\"xibanya\":\"35\",\"alabo\":\"43\",\"yuenan\":\"51\",\"xiongyali\":\"\"},\"vip_desc\":{\"zh-cn\":\"6\",\"en\":\"18\",\"zh-tw\":\"58\",\"taiyu\":\"26\",\"xibanya\":\"34\",\"alabo\":\"42\",\"yuenan\":\"50\",\"xiongyali\":\"\"},\"reseller_desc\":{\"zh-cn\":\"5\",\"en\":\"17\",\"zh-tw\":\"57\",\"taiyu\":\"25\",\"xibanya\":\"33\",\"alabo\":\"41\",\"yuenan\":\"49\",\"xiongyali\":\"\"},\"user_protocol_title\":{\"zh-cn\":\"用户协议-中文版\",\"en\":\"用户协议-英文版\",\"zh-tw\":\"用户协议-中文繁体\",\"taiyu\":\"用户协议-泰文版\",\"xiongyali\":\"\",\"xibanya\":\"用户协议-西班牙语\",\"alabo\":\"用户协议-阿拉伯语\",\"yuenan\":\"用户协议-越南语\"},\"privacy_protocol_title\":{\"zh-cn\":\"隐私政策-中文版\",\"en\":\"隐私政策-英文版\",\"zh-tw\":\"隐私政策-中文繁体\",\"taiyu\":\"隐私政策-泰文版\",\"xiongyali\":\"\",\"xibanya\":\"隐私政策-西班牙语\",\"alabo\":\"隐私政策-阿拉伯语\",\"yuenan\":\"隐私政策-越南语\"},\"about_us_title\":{\"zh-cn\":\"关于我们-中文版\",\"en\":\"关于我们-英文版\",\"zh-tw\":\"关于我们-中文繁体\",\"taiyu\":\"关于我们-泰文版\",\"xiongyali\":\"\",\"xibanya\":\"关于我们-西班牙语\",\"alabo\":\"关于我们-阿拉伯语\",\"yuenan\":\"关于我们-越南语\"},\"contact_us_title\":{\"zh-cn\":\"联系我们-中文版\",\"en\":\"联系我们-英文版\",\"zh-tw\":\"联系我们-中文繁体\",\"taiyu\":\"关于我们-泰文版\",\"xiongyali\":\"\",\"xibanya\":\"联系我们-西班牙语\",\"alabo\":\"联系我们-阿拉伯语\",\"yuenan\":\"联系我们-越南语\"},\"legal_notice_title\":{\"zh-cn\":\"法律声明-中文版\",\"en\":\"法律声明-英文版\",\"zh-tw\":\"法律声明-中文繁体\",\"taiyu\":\"法律声明-泰文版\",\"xiongyali\":\"\",\"xibanya\":\"法律声明-西班牙语\",\"alabo\":\"法律声明-阿拉伯语\",\"yuenan\":\"法律声明-越南语\"},\"usable_desc_title\":{\"zh-cn\":\"积分充值介绍-中文版\",\"en\":\"积分充值介绍-英文版\",\"zh-tw\":\"积分充值介绍-中文繁体\",\"taiyu\":\"积分充值介绍-泰文版\",\"xiongyali\":\"\",\"xibanya\":\"积分充值介绍-西班牙语\",\"alabo\":\"积分充值介绍-阿拉伯语\",\"yuenan\":\"积分充值介绍-越南语\"},\"vip_desc_title\":{\"zh-cn\":\"VIP会员权益-中文版\",\"en\":\"VIP会员权益-英文版\",\"zh-tw\":\"VIP会员权益-中文繁体\",\"taiyu\":\"VIP会员权益-泰文版\",\"xiongyali\":\"\",\"xibanya\":\"VIP会员权益-西班牙语\",\"alabo\":\"VIP会员权益-阿拉伯语\",\"yuenan\":\"VIP会员权益-越南语\"},\"reseller_desc_title\":{\"zh-cn\":\"分销介绍-中文版\",\"en\":\"分销介绍-英文版\",\"zh-tw\":\"分销介绍-中文繁体\",\"taiyu\":\"分销介绍-泰文版\",\"xiongyali\":\"\",\"xibanya\":\"分销介绍-西班牙语\",\"alabo\":\"分销介绍-阿拉伯语\",\"yuenan\":\"分销介绍-越南语\"}}', NULL, '', '');
INSERT INTO `vs_dramas_config` VALUES (13, 3, 'email', 'basic', '邮件配置', '', 'array', '{\"mail_type\":\"1\",\"mail_smtp_host\":\"smtp.qq.com\",\"mail_smtp_port\":\"465\",\"mail_smtp_user\":\"南阳迈特\",\"mail_smtp_pass\":\"\",\"mail_verify_type\":\"2\",\"mail_from\":\"\"}', NULL, '', '');
INSERT INTO `vs_dramas_config` VALUES (14, 3, 'share', 'basic', '分享配置', '', 'array', '{\"user_poster_bg\":\"/uploads/20231202/20da37ba9dca80ebe5fadf0dac6248f5.png\",\"user_poster_bg_color\":\"#6A62D1\"}', NULL, '', '');
INSERT INTO `vs_dramas_config` VALUES (15, 3, 'withdraw', 'basic', '提现配置', '', 'array', '{\"methods\":[\"bank\"],\"wechat_alipay_auto\":0,\"service_fee\":\"0.000\",\"min\":\"100\",\"max\":\"1000\",\"perday_amount\":0,\"perday_num\":0}', NULL, '', '');
INSERT INTO `vs_dramas_config` VALUES (16, 3, 'uploads', 'basic', '云存储配置', '', 'array', '{\"upload_type\":\"\",\"alioss\":{\"accessKeyId\":\"\",\"accessKeySecret\":\"\",\"bucket\":\"mettchat\",\"endpoint\":\"oss-cn-hongkong.aliyuncs.com\",\"cdnurl\":\"https://mettchat.oss-cn-hongkong.aliyuncs.com\",\"uploadmode\":\"server\",\"serverbackup\":\"0\",\"savekey\":\"/uploads/{year}{mon}{day}/{filemd5}{.suffix}\",\"expire\":\"600\",\"maxsize\":\"1024M\",\"mimetype\":\"jpg,png,bmp,jpeg,gif,webp,zip,rar,wav,mp4,mp3,webm,pem,xls,m3u8,avi,mov,ipa,xlsx,apk\",\"multiple\":\"0\",\"thumbstyle\":\"\",\"chunking\":\"0\",\"chunksize\":\"4194304\",\"syncdelete\":\"1\",\"apiupload\":\"1\",\"noneedlogin\":\"\",\"noneedloginarr\":[]},\"cos\":{\"appId\":\"\",\"secretId\":\"\",\"secretKey\":\"\",\"bucket\":\"\",\"region\":\"\",\"uploadmode\":\"server\",\"serverbackup\":\"1\",\"uploadurl\":\"\",\"cdnurl\":\"\",\"savekey\":\"/uploads/{year}{mon}{day}/{filemd5}{.suffix}\",\"expire\":\"600\",\"maxsize\":\"1024M\",\"mimetype\":\"jpg,png,bmp,jpeg,gif,webp,zip,rar,wav,mp4,mp3,webm,pem,xls,m3u8,avi,mov,ipa,xlsx,apk\",\"multiple\":\"0\",\"thumbstyle\":\"\",\"chunking\":\"0\",\"chunksize\":\"4194304\",\"syncdelete\":\"1\",\"apiupload\":\"1\",\"noneedlogin\":\"\",\"noneedloginarr\":[]}}', NULL, '', '');
INSERT INTO `vs_dramas_config` VALUES (17, 3, 'user', 'basic', '会员配置', '', 'array', '{\"nickname\":\"Mettshort - \",\"avatar\":\"/uploads/20231208/3722a5abfe39e847b19beb1d1a41164d.png\",\"group_id\":\"1\",\"money\":\"\",\"score\":\"\"}', NULL, '', '');
INSERT INTO `vs_dramas_config` VALUES (18, 3, 'sms', 'basic', '短信配置', '', 'array', '{\"type\":\"alisms\",\"alisms\":{\"key\":\"\",\"secret\":\"\",\"sign\":\"\",\"template\":[{\"key\":\"register\",\"value\":\"SMS_114000000\"},{\"key\":\"resetpwd\",\"value\":\"SMS_114000000\"},{\"key\":\"changepwd\",\"value\":\"SMS_114000000\"},{\"key\":\"changemobile\",\"value\":\"SMS_114000000\"},{\"key\":\"profile\",\"value\":\"SMS_114000000\"},{\"key\":\"notice\",\"value\":\"SMS_114000000\"},{\"key\":\"mobilelogin\",\"value\":\"SMS_114000000\"},{\"key\":\"bind\",\"value\":\"SMS_114000000\"}]},\"hwsms\":{\"app_url\":\"\",\"key\":\"\",\"secret\":\"\",\"sender\":\"\",\"sign\":\"\",\"template\":[{\"key\":\"register\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"},{\"key\":\"resetpwd\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"},{\"key\":\"changepwd\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"},{\"key\":\"changemobile\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"},{\"key\":\"profile\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"},{\"key\":\"notice\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"},{\"key\":\"mobilelogin\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"},{\"key\":\"bind\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"}]},\"qcloudsms\":{\"appid\":\"\",\"appkey\":\"\",\"sign\":\"\",\"isTemplateSender\":\"1\",\"template\":[{\"key\":\"register\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"},{\"key\":\"resetpwd\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"},{\"key\":\"changepwd\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"},{\"key\":\"changemobile\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"},{\"key\":\"profile\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"},{\"key\":\"notice\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"},{\"key\":\"mobilelogin\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"},{\"key\":\"bind\",\"value\":\"8ff55xxxxxxxxxxxxxxxxxxx\"}]},\"baosms\":{\"username\":\"\",\"password\":\"\",\"sign\":\"\"}}', NULL, '', '');

-- ----------------------------
-- Table structure for vs_dramas_cryptocard
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_cryptocard`;
CREATE TABLE `vs_dramas_cryptocard`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL DEFAULT 0 COMMENT '站点',
  `type` enum('vip','reseller','usable') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'usable' COMMENT '类型:vip=VIP套餐,reseller=分销商套餐,usable=剧场积分套餐',
  `item_id` int(11) NULL DEFAULT NULL COMMENT '套餐',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `pwd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '兑换码',
  `usetime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '有效期',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态:0=待使用,1=已使用',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `usetimestart` bigint(20) NULL DEFAULT NULL COMMENT '使用时间',
  `usetimeend` bigint(20) NULL DEFAULT NULL COMMENT '使用时间',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `deletetime` bigint(20) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `site_id`(`site_id`, `pwd`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '卡密' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_feedback
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_feedback`;
CREATE TABLE `vs_dramas_feedback`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL COMMENT '反馈用户',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '反馈类型',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '反馈内容',
  `images` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片',
  `phone` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否处理:0=未处理,1=已处理',
  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处理备注',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '意见反馈' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_reseller
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_reseller`;
CREATE TABLE `vs_dramas_reseller`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `lang_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '语言',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分销商',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图片',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '介绍',
  `price` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '价格',
  `original_price` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '原价',
  `level` tinyint(4) NOT NULL COMMENT '等级',
  `direct` decimal(20, 2) NOT NULL COMMENT '直接分润',
  `indirect` decimal(20, 2) NOT NULL COMMENT '间接分润',
  `expire` bigint(20) NOT NULL COMMENT '有效期',
  `weigh` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态:normal=显示,hidden=隐藏',
  `updatetime` int(11) NOT NULL COMMENT '更新时间',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `level`(`site_id`, `lang_id`, `status`, `level`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分销商' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_dramas_reseller
-- ----------------------------
INSERT INTO `vs_dramas_reseller` VALUES (5, 3, 1, '铜牌分销商', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1.申请为分销商可进行业务推广，推广佣金根据自己分销商等级进行分润。\",\"2\":\"2.升级为分销商之后，若想升级需重新全价购买。\",\"3\":\"3.如果自己推广的下级用户升级也申请了分销商，并且下属等级高于或等于 自己则无法享受分佣。若想享受分佣，需升级。\",\"4\":\"4.如果自己的分销商等级和下属一致，则享受5%的平级奖。\",\"5\":\"5.虚拟商品充值后不可退还。\"}', '0.01', 99.00, 1, 10.00, 5.00, 2592000, 4, 'normal', 1686384870, 1684889459, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (6, 3, 1, '银牌分销商', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1.申请为分销商可进行业务推广，推广佣金根据自己分销商等级进行分润。\",\"2\":\"2.升级为分销商之后，若想升级需重新全价购买。\",\"3\":\"3.如果自己推广的下级用户升级也申请了分销商，并且下属等级高于或等于 自己则无法享受分佣。若想享受分佣，需升级。\",\"4\":\"4.如果自己的分销商等级和下属一致，则享受5%的平级奖。\",\"5\":\"5.虚拟商品充值后不可退还。\"}', '0.01', 299.00, 2, 20.00, 10.00, 31536000, 3, 'normal', 1686386566, 1684891042, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (7, 3, 1, '金牌分销商', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1.申请为分销商可进行业务推广，推广佣金根据自己分销商等级进行分润。\",\"2\":\"2.升级为分销商之后，若想升级需重新全价购买。\",\"3\":\"3.如果自己推广的下级用户升级也申请了分销商，并且下属等级高于或等于 自己则无法享受分佣。若想享受分佣，需升级。\",\"4\":\"4.如果自己的分销商等级和下属一致，则享受5%的平级奖。\",\"5\":\"5.虚拟商品充值后不可退还。\"}', '199', 399.00, 3, 30.00, 15.00, 0, 2, 'normal', 1686386607, 1684892683, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (8, 3, 3, 'bronze medal', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1.Apply to become a distributor for business promotion, and the promotion commission will be distributed based on your distributor level.\",\"2\":\"2.After upgrading to a distributor, if you want to upgrade again, you need to make a full-price purchase again.\",\"3\":\"3. If the users you refer as your downline also apply to become distributors and their level is higher than or equal to yours, you will not be eligible for commission. To be eligible for commission, you need to upgrade.\",\"4\":\"4. If your distributor level is the same as your downline, you will receive a 5% bonus for same-level achievement.\",\"5\":\"5. Virtual product recharge is non-refundable.\"}', '0.01', 99.00, 1, 10.00, 5.00, 2592000, 4, 'normal', 1701830438, 1684889459, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (9, 3, 3, 'silver medal', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1.Apply to become a distributor for business promotion, and the promotion commission will be distributed based on your distributor level.\",\"2\":\"2.After upgrading to a distributor, if you want to upgrade again, you need to make a full-price purchase again.\",\"3\":\"3. If the users you refer as your downline also apply to become distributors and their level is higher than or equal to yours, you will not be eligible for commission. To be eligible for commission, you need to upgrade.\",\"4\":\"4. If your distributor level is the same as your downline, you will receive a 5% bonus for same-level achievement.\",\"5\":\"5. Virtual product recharge is non-refundable.\"}', '0.01', 299.00, 2, 20.00, 10.00, 31536000, 3, 'normal', 1701830447, 1684891042, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (10, 3, 3, 'gold medal', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1.Apply to become a distributor for business promotion, and the promotion commission will be distributed based on your distributor level.\",\"2\":\"2.After upgrading to a distributor, if you want to upgrade again, you need to make a full-price purchase again.\",\"3\":\"3. If the users you refer as your downline also apply to become distributors and their level is higher than or equal to yours, you will not be eligible for commission. To be eligible for commission, you need to upgrade.\",\"4\":\"4. If your distributor level is the same as your downline, you will receive a 5% bonus for same-level achievement.\",\"5\":\"5. Virtual product recharge is non-refundable.\"}', '199', 399.00, 3, 30.00, 15.00, 0, 2, 'normal', 1701830453, 1684892683, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (11, 3, 4, '銅牌分銷商', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. 申請為分銷商可進行業務推廣，推廣佣金根據自己分銷商等級進行分润。\",\"2\":\"2. 升級為分銷商之後，若想升級需重新全價購買。\",\"3\":\"3. 如果自己推廣的下級用戶升級也申請了分銷商，並且下屬等級高於或等於自己則無法享受分佣。若想享受分佣，需升級。\",\"4\":\"4. 如果自己的分銷商等級和下屬一致，則享受5%的平級獎。\",\"5\":\"5. 虛擬商品充值後不可退還。\"}', '0.01', 99.00, 1, 10.00, 5.00, 2592000, 4, 'normal', 1701791442, 1684889459, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (12, 3, 4, '銀牌分銷商', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. 申請為分銷商可進行業務推廣，推廣佣金根據自己分銷商等級進行分润。\",\"2\":\"2. 升級為分銷商之後，若想升級需重新全價購買。\",\"3\":\"3. 如果自己推廣的下級用戶升級也申請了分銷商，並且下屬等級高於或等於自己則無法享受分佣。若想享受分佣，需升級。\",\"4\":\"4. 如果自己的分銷商等級和下屬一致，則享受5%的平級獎。\",\"5\":\"5. 虛擬商品充值後不可退還。\"}', '0.01', 299.00, 2, 20.00, 10.00, 31536000, 3, 'normal', 1686386566, 1684891042, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (13, 3, 4, '金牌分銷商', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. 申請為分銷商可進行業務推廣，推廣佣金根據自己分銷商等級進行分润。\",\"2\":\"2. 升級為分銷商之後，若想升級需重新全價購買。\",\"3\":\"3. 如果自己推廣的下級用戶升級也申請了分銷商，並且下屬等級高於或等於自己則無法享受分佣。若想享受分佣，需升級。\",\"4\":\"4. 如果自己的分銷商等級和下屬一致，則享受5%的平級獎。\",\"5\":\"5. 虛擬商品充值後不可退還。\"}', '199', 399.00, 3, 30.00, 15.00, 0, 2, 'normal', 1686386607, 1684892683, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (14, 3, 5, 'ตัวแทนจำหน่ายเกรดทอง', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. สมัครเป็นตัวแทนจำหน่ายเพื่อทำการโปรโมตธุรกิจ รายได้จากการโปรโมตจะถูกแบ่งออกตามระดับของตัวแทนจำหน่าย\",\"2\":\"2. เมื่ออัพเกรดเป็นตัวแทนจำหน่ายแล้ว หากต้องการอัพเกรดต่อให้ซื้อสินค้าในราคาเต็มแบบอีกครั้ง\",\"3\":\"3. หากผู้ใช้ที่เราโปรโมตลงตัวเป็นตัวแทนจำหน่ายแล้ว และผู้ใช้ในระดับล่างก็สมัครเป็นตัวแทนจำหน่ายด้วย และระดับของผู้ใช้ในระดับล่างสูงกว่าหรือเท่ากับเรา จะไม่สามารถรับค่าคอมมิชชั่นได้ หากต้องการรับค่าคอมมิชชั่นจะต้องอัพเกรด\",\"4\":\"4. หากระดับของตัวแทนจำหน่ายเท่ากับระดับของผู้ใช้ในระดับล่าง จะได้รับโบนัสเพิ่มเติม 5% เป็นโบนัสระดับเท่ากัน\",\"5\":\"5. หลังจากเติมเงินสำหรับสินค้าเสมือนไม่สามารถเรียกคืนได้\"}', '0.01', 99.00, 1, 10.00, 5.00, 2592000, 4, 'normal', 1701791472, 1684889459, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (15, 3, 5, 'ตัวแทนจำหน่ายเกรดเงิน', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. สมัครเป็นตัวแทนจำหน่ายเพื่อทำการโปรโมตธุรกิจ รายได้จากการโปรโมตจะถูกแบ่งออกตามระดับของตัวแทนจำหน่าย\",\"2\":\"2. เมื่ออัพเกรดเป็นตัวแทนจำหน่ายแล้ว หากต้องการอัพเกรดต่อให้ซื้อสินค้าในราคาเต็มแบบอีกครั้ง\",\"3\":\"3. หากผู้ใช้ที่เราโปรโมตลงตัวเป็นตัวแทนจำหน่ายแล้ว และผู้ใช้ในระดับล่างก็สมัครเป็นตัวแทนจำหน่ายด้วย และระดับของผู้ใช้ในระดับล่างสูงกว่าหรือเท่ากับเรา จะไม่สามารถรับค่าคอมมิชชั่นได้ หากต้องการรับค่าคอมมิชชั่นจะต้องอัพเกรด\",\"4\":\"4. หากระดับของตัวแทนจำหน่ายเท่ากับระดับของผู้ใช้ในระดับล่าง จะได้รับโบนัสเพิ่มเติม 5% เป็นโบนัสระดับเท่ากัน\",\"5\":\"5. หลังจากเติมเงินสำหรับสินค้าเสมือนไม่สามารถเรียกคืนได้\"}', '0.01', 299.00, 2, 20.00, 10.00, 31536000, 3, 'normal', 1686386566, 1684891042, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (16, 3, 5, 'ตัวแทนจำหน่ายเกรดทองคำ', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. สมัครเป็นตัวแทนจำหน่ายเพื่อทำการโปรโมตธุรกิจ รายได้จากการโปรโมตจะถูกแบ่งออกตามระดับของตัวแทนจำหน่าย\",\"2\":\"2. เมื่ออัพเกรดเป็นตัวแทนจำหน่ายแล้ว หากต้องการอัพเกรดต่อให้ซื้อสินค้าในราคาเต็มแบบอีกครั้ง\",\"3\":\"3. หากผู้ใช้ที่เราโปรโมตลงตัวเป็นตัวแทนจำหน่ายแล้ว และผู้ใช้ในระดับล่างก็สมัครเป็นตัวแทนจำหน่ายด้วย และระดับของผู้ใช้ในระดับล่างสูงกว่าหรือเท่ากับเรา จะไม่สามารถรับค่าคอมมิชชั่นได้ หากต้องการรับค่าคอมมิชชั่นจะต้องอัพเกรด\",\"4\":\"4. หากระดับของตัวแทนจำหน่ายเท่ากับระดับของผู้ใช้ในระดับล่าง จะได้รับโบนัสเพิ่มเติม 5% เป็นโบนัสระดับเท่ากัน\",\"5\":\"5. หลังจากเติมเงินสำหรับสินค้าเสมือนไม่สามารถเรียกคืนได้\"}', '199', 399.00, 3, 30.00, 15.00, 0, 2, 'normal', 1686386607, 1684892683, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (17, 3, 7, ' de medalla de plata', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. Solicitar ser un distribuidor para realizar actividades de promoción empresarial y recibir comisiones de acuerdo con el nivel de distribuidor.\",\"2\":\"2. Después de ascender a distribuidor, si se desea ascender más, se debe comprar nuevamente al precio completo.\",\"3\":\"3. Si los usuarios subordinados que se promocionaron también solicitan convertirse en distribuidores y su nivel es igual o superior al propio, no se podrán recibir comisiones. Para poder recibir comisiones, se debe ascender de nivel.\",\"4\":\"4. Si el nivel del distribuidor propio y el de los subordinados son iguales, se recibirá una bonificación del 5% por estar en el mismo nivel.\",\"5\":\"5. No se podrán realizar reembolsos después de la recarga de productos virtuales.\"}', '0.01', 99.00, 1, 10.00, 5.00, 2592000, 4, 'normal', 1701791505, 1684889459, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (18, 3, 7, 'Distribuidor de medalla ', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. Solicitar ser un distribuidor para realizar actividades de promoción empresarial y recibir comisiones de acuerdo con el nivel de distribuidor.\",\"2\":\"2. Después de ascender a distribuidor, si se desea ascender más, se debe comprar nuevamente al precio completo.\",\"3\":\"3. Si los usuarios subordinados que se promocionaron también solicitan convertirse en distribuidores y su nivel es igual o superior al propio, no se podrán recibir comisiones. Para poder recibir comisiones, se debe ascender de nivel.\",\"4\":\"4. Si el nivel del distribuidor propio y el de los subordinados son iguales, se recibirá una bonificación del 5% por estar en el mismo nivel.\",\"5\":\"5. No se podrán realizar reembolsos después de la recarga de productos virtuales.\"}', '0.01', 299.00, 2, 20.00, 10.00, 31536000, 3, 'normal', 1686386566, 1684891042, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (19, 3, 7, 'plata Distribuidor', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. Solicitar ser un distribuidor para realizar actividades de promoción empresarial y recibir comisiones de acuerdo con el nivel de distribuidor.\",\"2\":\"2. Después de ascender a distribuidor, si se desea ascender más, se debe comprar nuevamente al precio completo.\",\"3\":\"3. Si los usuarios subordinados que se promocionaron también solicitan convertirse en distribuidores y su nivel es igual o superior al propio, no se podrán recibir comisiones. Para poder recibir comisiones, se debe ascender de nivel.\",\"4\":\"4. Si el nivel del distribuidor propio y el de los subordinados son iguales, se recibirá una bonificación del 5% por estar en el mismo nivel.\",\"5\":\"5. No se podrán realizar reembolsos después de la recarga de productos virtuales.\"}', '199', 399.00, 3, 30.00, 15.00, 0, 2, 'normal', 1686386607, 1684892683, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (20, 3, 8, 'تاجر موزع الميدالية البرونزية', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. طلب أن تصبح وكيل توزيع لتعزيز الأعمال التجارية، حيث يتم توزيع العمولة الترويجية وفقًا لمستوى الوكيل التوزيع الخاص به.\",\"2\":\"2. بعد الترقية إلى الوكيل التوزيع، إذا كنت ترغب في الترقية، فسيتعين عليك شراء المنتج مرة أخرى بالسعر الكامل.\",\"3\":\"3. إذا كان المستخدمون الفرعيون الذين قمت بترويجهم يقدمون طلبًا لتصبح وكلاء توزيع وكانت درجة الوكيل الفرعي الخاص بهم تفوقك أو متساوية، فلن تتمتع بالعمولة. إذا كنت ترغب في تلقي العمولة، ستحتاج إلى الترقية.\",\"4\":\"4. إذا كانت درجة الوكيل التوزيع الخاصة بك متساوية مع الوكلاء الفرعيين، فستحصل على 5٪ من المكافأة المستوى.\",\"5\":\"5. لا يمكن استرداد المبالغ المدفوعة بعد شحن المنتجات الافتراضية.\"}', '0.01', 99.00, 1, 10.00, 5.00, 2592000, 4, 'normal', 1701791554, 1684889459, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (21, 3, 8, 'تاجر موزع الميدالية الفضية', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. طلب أن تصبح وكيل توزيع لتعزيز الأعمال التجارية، حيث يتم توزيع العمولة الترويجية وفقًا لمستوى الوكيل التوزيع الخاص به.\",\"2\":\"2. بعد الترقية إلى الوكيل التوزيع، إذا كنت ترغب في الترقية، فسيتعين عليك شراء المنتج مرة أخرى بالسعر الكامل.\",\"3\":\"3. إذا كان المستخدمون الفرعيون الذين قمت بترويجهم يقدمون طلبًا لتصبح وكلاء توزيع وكانت درجة الوكيل الفرعي الخاص بهم تفوقك أو متساوية، فلن تتمتع بالعمولة. إذا كنت ترغب في تلقي العمولة، ستحتاج إلى الترقية.\",\"4\":\"4. إذا كانت درجة الوكيل التوزيع الخاصة بك متساوية مع الوكلاء الفرعيين، فستحصل على 5٪ من المكافأة المستوى.\",\"5\":\"5. لا يمكن استرداد المبالغ المدفوعة بعد شحن المنتجات الافتراضية.\"}', '0.01', 299.00, 2, 20.00, 10.00, 31536000, 3, 'normal', 1686386566, 1684891042, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (22, 3, 8, 'تاجر موزع الميدالية الذهبية', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. طلب أن تصبح وكيل توزيع لتعزيز الأعمال التجارية، حيث يتم توزيع العمولة الترويجية وفقًا لمستوى الوكيل التوزيع الخاص به.\",\"2\":\"2. بعد الترقية إلى الوكيل التوزيع، إذا كنت ترغب في الترقية، فسيتعين عليك شراء المنتج مرة أخرى بالسعر الكامل.\",\"3\":\"3. إذا كان المستخدمون الفرعيون الذين قمت بترويجهم يقدمون طلبًا لتصبح وكلاء توزيع وكانت درجة الوكيل الفرعي الخاص بهم تفوقك أو متساوية، فلن تتمتع بالعمولة. إذا كنت ترغب في تلقي العمولة، ستحتاج إلى الترقية.\",\"4\":\"4. إذا كانت درجة الوكيل التوزيع الخاصة بك متساوية مع الوكلاء الفرعيين، فستحصل على 5٪ من المكافأة المستوى.\",\"5\":\"5. لا يمكن استرداد المبالغ المدفوعة بعد شحن المنتجات الافتراضية.\"}', '199', 399.00, 3, 30.00, 15.00, 0, 2, 'normal', 1686386607, 1684892683, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (23, 3, 9, 'Nhà phân phối huy chương đồng', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. Xin vui lòng cho biết để trở thành nhà phân phối và thực hiện việc quảng bá kinh doanh, hoa hồng quảng cáo sẽ được chia sẻ dựa trên cấp độ của nhà phân phối.\",\"2\":\"2. Sau khi thăng cấp thành nhà phân phối, nếu muốn thăng cấp thêm, bạn sẽ phải mua lại với giá đầy đủ.\",\"3\":\"3. Nếu các người dùng cấp dưới mà bạn giới thiệu cũng đăng ký trở thành nhà phân phối và cấp độ của họ cao hơn hoặc bằng cấp độ của bạn, bạn sẽ không được hưởng hoa hồng. Để được hưởng hoa hồng, bạn sẽ cần phải thăng cấp.\",\"4\":\"4. Nếu cấp độ của bạn và cấp độ của người cấp dưới là như nhau, bạn sẽ được hưởng 5% phần thưởng cùng cấp.\",\"5\":\"5. Sau khi nạp tiền cho hàng hóa ảo, không thể hoàn trả được.\"}', '0.01', 99.00, 1, 10.00, 5.00, 2592000, 4, 'normal', 1701791588, 1684889459, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (24, 3, 9, 'Nhà phân phối huy chương bạc', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. Xin vui lòng cho biết để trở thành nhà phân phối và thực hiện việc quảng bá kinh doanh, hoa hồng quảng cáo sẽ được chia sẻ dựa trên cấp độ của nhà phân phối.\",\"2\":\"2. Sau khi thăng cấp thành nhà phân phối, nếu muốn thăng cấp thêm, bạn sẽ phải mua lại với giá đầy đủ.\",\"3\":\"3. Nếu các người dùng cấp dưới mà bạn giới thiệu cũng đăng ký trở thành nhà phân phối và cấp độ của họ cao hơn hoặc bằng cấp độ của bạn, bạn sẽ không được hưởng hoa hồng. Để được hưởng hoa hồng, bạn sẽ cần phải thăng cấp.\",\"4\":\"4. Nếu cấp độ của bạn và cấp độ của người cấp dưới là như nhau, bạn sẽ được hưởng 5% phần thưởng cùng cấp.\",\"5\":\"5. Sau khi nạp tiền cho hàng hóa ảo, không thể hoàn trả được.\"}', '0.01', 299.00, 2, 20.00, 10.00, 31536000, 3, 'normal', 1686386566, 1684891042, NULL);
INSERT INTO `vs_dramas_reseller` VALUES (25, 3, 9, 'Nhà phân phối huy chương vàng', 'https://img.nymaite.com/chat/20230515/3722a5abfe39e847b19beb1d1a41164d.png', '{\"1\":\"1. Xin vui lòng cho biết để trở thành nhà phân phối và thực hiện việc quảng bá kinh doanh, hoa hồng quảng cáo sẽ được chia sẻ dựa trên cấp độ của nhà phân phối.\",\"2\":\"2. Sau khi thăng cấp thành nhà phân phối, nếu muốn thăng cấp thêm, bạn sẽ phải mua lại với giá đầy đủ.\",\"3\":\"3. Nếu các người dùng cấp dưới mà bạn giới thiệu cũng đăng ký trở thành nhà phân phối và cấp độ của họ cao hơn hoặc bằng cấp độ của bạn, bạn sẽ không được hưởng hoa hồng. Để được hưởng hoa hồng, bạn sẽ cần phải thăng cấp.\",\"4\":\"4. Nếu cấp độ của bạn và cấp độ của người cấp dưới là như nhau, bạn sẽ được hưởng 5% phần thưởng cùng cấp.\",\"5\":\"5. Sau khi nạp tiền cho hàng hóa ảo, không thể hoàn trả được.\"}', '199', 399.00, 3, 30.00, 15.00, 0, 2, 'normal', 1686386607, 1684892683, NULL);

-- ----------------------------
-- Table structure for vs_dramas_reseller_bind
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_reseller_bind`;
CREATE TABLE `vs_dramas_reseller_bind`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `reseller_id` int(11) NOT NULL COMMENT '分销等级ID',
  `level` int(11) NOT NULL COMMENT '分销等级',
  `reseller_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分销参数',
  `expiretime` int(11) NOT NULL DEFAULT 0 COMMENT '过期时间',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `updatetime` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户分销信息' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_reseller_log
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_reseller_log`;
CREATE TABLE `vs_dramas_reseller_log`  (
    `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
    `type` enum('direct','indirect') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型:direct=直接佣金,indirect=间接佣金',
    `reseller_user_id` int(11) NOT NULL COMMENT '分销商ID',
    `user_id` int(11) NOT NULL COMMENT '用户ID',
    `pay_money` decimal(20, 2) NOT NULL COMMENT '支付金额',
    `ratio` decimal(20, 2) NOT NULL COMMENT '分润比例',
    `money` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '佣金',
    `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货币标准符号',
    `exchange_rate` int(11) NOT NULL DEFAULT 0 COMMENT '积分兑换比例',
    `total_money` int(11) NOT NULL COMMENT '积分佣金',
    `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
    `order_type` enum('vip','reseller','usable') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单类型:vip=VIP订单,reseller=分销商订单,usable=剧场积分订单',
    `order_id` int(11) NOT NULL COMMENT '订单ID',
    `createtime` int(11) NOT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分佣记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_reseller_order
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_reseller_order`;
CREATE TABLE `vs_dramas_reseller_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `reseller_id` int(11) NOT NULL DEFAULT 0 COMMENT '分销商ID',
  `order_sn` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `user_id` int(11) NULL DEFAULT 0 COMMENT '用户',
  `times` int(11) NULL DEFAULT 0 COMMENT '有效期',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '订单状态:-2=交易关闭,-1=已取消,0=未支付,1=已支付,2=已完成',
  `total_fee` decimal(20, 2) NOT NULL COMMENT '支付金额',
  `pay_fee` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '实际支付金额',
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '货币',
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易单号',
  `payment_json` varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易原始数据',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单备注',
  `pay_type` enum('wechat','alipay','wallet','score','cryptocard','system','paypal','stripe') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式:wechat=微信支付,alipay=支付宝,wallet=钱包支付,score=积分支付,cryptocard=卡密兑换,system=管理员设置,paypal=PayPal,stripe=Stripe',
  `paytime` int(11) NULL DEFAULT NULL COMMENT '支付时间',
  `ext` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附加字段',
  `platform` enum('H5','Web','wxOfficialAccount','wxMiniProgram','App') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台:H5=H5,wxOfficialAccount=微信公众号,wxMiniProgram=微信小程序,Web=Web,App=APP',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_reseller_user
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_reseller_user`;
CREATE TABLE `vs_dramas_reseller_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户ID',
  `parent_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级用户ID',
  `reseller_user_id` int(10) UNSIGNED NOT NULL COMMENT '分销商ID',
  `type` enum('1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户类型:1=直接用户,2=间接用户',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分销用户' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_richtext
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_richtext`;
CREATE TABLE `vs_dramas_richtext`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `lang_id` int(11) NOT NULL DEFAULT 0 COMMENT '语言',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '富文本' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_dramas_richtext
-- ----------------------------
INSERT INTO `vs_dramas_richtext` VALUES (1, 3, 1, '联系我们-中文版', '<p><img src=\"https://mettchat.oss-accelerate.aliyuncs.com/mettgpt/20230715/256ff266c49826078ae524b8fed6b51a.png\" alt=\"\" /></p>', 1582259738, 1701844793, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (2, 3, 1, '隐私政策-中文版', '<p style=\"text-align:center;\"><strong>&nbsp;迈特短剧隐私协议&nbsp;</strong></p><p>欢迎使用迈特短剧（以下简称“本软件”）。本软件非常重视用户的隐私保护，本隐私协议旨在向用户说明本软件如何收集、使用、存储和保护用户的个人信息。在使用本软件前，请您仔细阅读本隐私协议。如果您不同意本隐私协议的任何内容，请勿使用本软件。</p><p><br /></p><div><br /></div><div>一、信息收集</div><div>&nbsp; &nbsp; 1. 本软件不会主动收集用户的任何个人信息，包括但不限于姓名、身份证号、电话号码、电子邮件地址等。</div><div>&nbsp; &nbsp; 2.当用户使用本软件时，本软件可能会自动收集一些技术信息，包括但不限于用户的设备信息、操作系统版本、网络状态、IP地址等。</div><p>&nbsp; &nbsp; 3. 本软件可能会使用第三方服务，如广告服务、统计分析服务等，这些服务可能会收集用户的一些信息，但本软件不会主动向第三方服务提供用户的任何个人信息。</p><p><br /></p><p>二、信息使用</p><p><br /></p><p>&nbsp; &nbsp; 1. 本软件收集的技术信息仅用于改善本软件的服务质量，如优化算法、提高智能识别能力等。</p><p>&nbsp; &nbsp; 2. 本软件不会将用户的任何个人信息用于商业目的，也不会向任何第三方出售、出租、分享或交换用户的任何个人信息。</p><p><br /></p><p>三、信息存储和保护</p><p>&nbsp; &nbsp; 1. 本软件收集的技术信息将存储在本软件的服务器上，本软件将采取合理的安全措施，保护用户的信息不被非法获取、使用或泄露。</p><p>&nbsp; &nbsp; 2. 本软件将采取合理的措施，保护用户的信息不被意外删除或损坏。</p><p><br /></p><p>四、信息披露</p><p>&nbsp; &nbsp; 1. 本软件不会向任何第三方披露用户的任何个人信息，除非经过用户的明确授权或法律规定。</p><p>&nbsp; &nbsp; 2. 如用户违反本软件的使用规定或法律法规，本软件有权向相关部门披露用户的个人信息。</p><p><br /></p><p>五、未成年人信息保护</p><p>&nbsp; &nbsp; 1.本软件非常重视未成年人的信息保护，未成年人应在父母或监护人的指导下使用本软件。</p><p>&nbsp; &nbsp; 2.本软件不会主动收集未成年人的任何个人信息，如未成年人的父母或监护人发现未成年人的个人信息被泄露，请立即联系本软件开发</p><p><br /></p><p>六、其他</p><p>&nbsp; &nbsp; 1. 本隐私协议的解释、适用及争议解决均适用中华人民共和国法律，并由本软件开发者所在地的人民法院管辖。</p><p>&nbsp; &nbsp; 2. 如有任何问题或意见，请联系本软件开发者。</p><p>本隐私协议的最终解释权归本软件开发者所有。</p><p><br /></p><p><br /></p><p><br /></p>', 1582259745, 1701844786, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (3, 3, 1, '关于我们-中文版', '<p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><span style=\"text-align:center;white-space:normal;\">官方公众号</span></p><p><img src=\"https://mettchat.oss-accelerate.aliyuncs.com/mettgpt/20230715/256ff266c49826078ae524b8fed6b51a.png\" alt=\"\" /></p>', 1582259745, 1701844779, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (4, 3, 1, '法律声明-中文版', '<div style=\"text-align:center;\"><strong>迈特短剧法律声明</strong></div><br />欢迎使用迈特短剧（以下简称“本软件”）。本软件是一款基于人工智能技术的智能助手，旨在为用户提供更加便捷、高效的服务。在使用本软件前，请您仔细阅读本声明。如果您不同意本声明的任何内容，请勿使用本软件。<br /><br />一、知识产权声明<br /><br />本软件的所有权、知识产权、相关技术及所有内容（包括但不限于文字、图片、音频、视频、软件、程序、代码、界面设计、数据等）均归属于本软件的开发者或相关权利人所有。<br /><br />未经本软件开发者或相关权利人的书面授权，任何人不得以任何形式复制、传播、展示、修改、出售、转让、发行或利用本软件的任何内容。<br /><br />任何未经授权的行为均可能构成侵犯本软件开发者或相关权利人的知识产权，将承担相应的法律责任。<br /><br />二、免责声明<br /><br />本软件仅提供智能助手服务，不对用户使用本软件的结果承担任何责任。<br /><br />本软件不对用户使用本软件过程中的任何损失或损害承担任何责任，包括但不限于因使用本软件而导致的数据丢失、计算机系统崩溃、网络中断等。<br /><br />本软件不对用户使用本软件过程中的任何行为承担任何责任，包括但不限于因使用本软件而导致的违法行为、侵犯他人权益等。<br /><br />本软件不对用户使用本软件过程中的任何第三方软件或服务承担任何责任，包括但不限于因使用第三方软件或服务而导致的任何损失或损害。<br /><br />本软件不对用户使用本软件过程中的任何技术问题承担任何责任，包括但不限于因使用本软件而导致的计算机病毒、黑客攻击等。<br /><br />三、隐私保护声明<br /><br />本软件将严格保护用户的隐私，不会收集、存储、使用用户的任何个人信息，除非用户自愿提供。<br /><br />用户自愿提供的个人信息，本软件将严格保密，不会泄露给任何第三方，除非经过用户的明确授权或法律规定。<br /><br />本软件将采取合理的安全措施，保护用户的个人信息不被非法获取、使用或泄露。<br /><br />四、其他声明<br /><br />本软件开发者有权随时修改本声明的任何内容，修改后的声明将在本软件上公布，用户应及时关注并遵守。<br /><br />本声明的解释、适用及争议解决均适用中华人民共和国法律，并由本软件开发者所在地的人民法院管辖。<br /><br />如有任何问题或意见，请联系本软件开发者。<br /><br />本声明的最终解释权归本软件开发者所有。<br />', 1683768542, 1701844773, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (5, 3, 1, '分销介绍-中文版', '<p><span style=\"font-size:18px;\"><b>&nbsp; 如何利用此工具赚钱？</b></span></p><p><br /></p><ol class=\"ol1\" style=\"font-size:medium;white-space:normal;\"><li class=\"li1\" style=\"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-optical-sizing:auto;font-feature-settings:normal;font-variation-settings:normal;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;PingFang SC&quot;;\"><span class=\"s1\" style=\"font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-optical-sizing:auto;font-feature-settings:normal;font-variation-settings:normal;font-stretch:normal;line-height:normal;font-family:&quot;Helvetica Neue&quot;;\"></span><span style=\"line-height:1.5;\">申请为分销商之后可进行业务推广，推广的佣金根据</span><span style=\"line-height:1.5;\">自己的分销商等级进行分润。</span></li><li class=\"li1\" style=\"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-optical-sizing:auto;font-feature-settings:normal;font-variation-settings:normal;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;PingFang SC&quot;;\"><span class=\"s1\" style=\"font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-optical-sizing:auto;font-feature-settings:normal;font-variation-settings:normal;font-stretch:normal;line-height:normal;font-family:&quot;Helvetica Neue&quot;;\"></span><span style=\"line-height:1.5;\">升级为分销商之后，若想升级需重新全价购买。</span></li><li class=\"li1\" style=\"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-optical-sizing:auto;font-feature-settings:normal;font-variation-settings:normal;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;PingFang SC&quot;;\"><span class=\"s1\" style=\"font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-optical-sizing:auto;font-feature-settings:normal;font-variation-settings:normal;font-stretch:normal;line-height:normal;font-family:&quot;Helvetica Neue&quot;;\"></span><span style=\"line-height:1.5;\">如果开通的分销商为非永久时，再次开通同级别的分销商则进行时间的累加。</span></li><li class=\"li1\" style=\"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-optical-sizing:auto;font-feature-settings:normal;font-variation-settings:normal;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;PingFang SC&quot;;\"><span class=\"s1\" style=\"font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-optical-sizing:auto;font-feature-settings:normal;font-variation-settings:normal;font-stretch:normal;line-height:normal;font-family:&quot;Helvetica Neue&quot;;\"></span><span style=\"line-height:1.5;\">如果开通的分销商等级和当前不一致时，则会重置等级和时间。</span></li><li class=\"li1\" style=\"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-optical-sizing:auto;font-feature-settings:normal;font-variation-settings:normal;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;PingFang SC&quot;;\"><span class=\"s1\" style=\"font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-optical-sizing:auto;font-feature-settings:normal;font-variation-settings:normal;font-stretch:normal;line-height:normal;font-family:&quot;Helvetica Neue&quot;;\"></span><span style=\"line-height:1.5;\">虚拟商品一经充值，不予退款。</span></li></ol><p><br /></p>', 1685204309, 1701844768, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (6, 3, 1, 'VIP会员权益-中文版', '<div>感谢您选择迈特短剧VIP套餐，这是我们为用户提供的高级会员服务。作为VIP用户，您将享受以下特权和优惠：</div><div><br /></div><div>1. 免费观看VIP视频：作为VIP会员，您将免费观看所有标注为VIP的视频内容。这些视频通常是一些独家、高品质的内容，包括热门电影、电视剧、综艺节目等。您可以尽情畅享这些精彩内容，无需再额外支付费用。</div><div><br /></div><div>2. 优惠购买收费视频：除了免费观看VIP视频外，VIP用户还可以享受优惠购买收费视频的特权。在平台上存在一些需要付费才能观看的视频内容，作为VIP会员，您将享受更低的价格购买这些视频。这将大幅度降低您观看高质量视频的成本，并且让您更容易获得您感兴趣的内容。</div><div><br /></div><div>3. 提供独家福利和活动：作为VIP会员，您将定期收到我们为VIP用户定制的独家福利和活动信息。这可能包括观影活动、会员专场等特殊活动，以及一些仅针对VIP会员的限时优惠等。我们将确保您在迈特短剧VIP社区中享有独特的待遇，让您感受到更多的价值和乐趣。</div><div><br /></div><div>4. 快速播放和无广告体验：作为VIP用户，您将享受到更快的视频加载速度和流畅播放的体验。此外，在观看视频过程中，您将不再被冗长的广告打断，让您能够持续沉浸在精彩的内容中，提高观影的舒适度和质量。</div><div><br /></div><div>5. 优先客服支持：作为VIP会员，您的问题和需求将优先得到我们专属的客服团队的支持。无论是关于账号问题、付款疑问还是其他使用上的困惑，我们将竭诚为您提供解答和帮助，以确保您拥有顺畅愉快的使用体验。</div><div><br /></div><div>购买迈特短剧VIP套餐，将为您带来更好的观影体验和更丰富的内容选择。快来加入我们的VIP会员行列，与迈特短剧一同享受精彩的视听盛宴吧！</div></div>', 1690961094, 1701844762, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (7, 3, 1, '积分充值介绍-中文版', '迈特短剧积分套餐介绍注意事项：<br /><br />1. 积分套餐是迈特短剧平台为用户提供的一种充值方式，通过购买积分套餐可以在平台上享受更多的服务和特权。<br /><br />2. 积分套餐的价格和内容会在平台上进行公示，用户可以根据自己的需求选择适合的套餐。<br /><br />3. 购买积分套餐后，积分将直接充值到您的账户中，可以用于解锁付费内容、参加抽奖活动、购买虚拟礼物等。<br /><br />4. 积分套餐具有一定的有效期，请在有效期内使用，过期后将无法使用剩余积分，敬请留意。<br /><br />5. 积分套餐仅限个人使用，禁止转让、出售或以其他形式进行非法交易。一经发现，平台将采取相应的处理措施。<br /><br />6. 在使用积分时，请遵守平台的相关规定和用户使用协议，不要发布涉及政治、色情、暴力等违法、违规内容。<br /><br />7. 如有任何问题或疑问，您可以随时联系我们的客服团队，我们将尽快为您解答和处理。<br /><br />我们秉承为用户提供高质量、安全可靠的服务的宗旨，希望您在迈特短剧平台上享受到愉快的使用体验。感谢您的支持与理解！<br />', 1690961645, 1701844754, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (8, 3, 1, '用户协议-中文版', '迈特短剧 用户协议<br /><br />欢迎使用迈特短剧平台（以下简称“本平台”）！在您开始使用本平台之前，请仔细阅读以下的用户协议。通过使用本平台，即表示您同意遵守以下条款和条件：<br /><br />1. 用户行为规范<br />&nbsp; &nbsp;1.1 在使用本平台的过程中，请勿发布与政治、色情、暴力相关的内容。我们鼓励用户创作积极、健康、有益的短剧内容。<br />&nbsp; &nbsp;1.2 用户需要尊重他人的合法权益，不得利用本平台从事侵犯他人权益的行为。包括但不限于侵犯他人知识产权、隐私权等。<br />&nbsp; &nbsp;1.3 用户不得以任何形式干扰或破坏本平台的正常运行，包括但不限于使用恶意程序、病毒等进行攻击。<br /><br />2. 平台服务<br />&nbsp; &nbsp;2.1 本平台提供用户上传、分享短剧视频的功能，并允许用户在平台上互相关注、点赞、评论等交流互动。<br />&nbsp; &nbsp;2.2 用户在使用本平台时，应自行承担风险，并确保所上传的内容符合法律法规和本协议的规定。如因用户违反法律法规或本协议的规定，而引发纠纷或产生责任，用户应自行承担相应的法律责任。<br />&nbsp; &nbsp;2.3 本平台有权根据需要增加、减少、更改或终止部分或全部服务内容，并无需提前通知用户。<br /><br />3. 用户隐私<br />&nbsp; &nbsp;3.1 本平台将采取合理的安全措施，保护用户的个人信息安全。<br />&nbsp; &nbsp;3.2 用户在使用本平台时，可能需要提供一些个人信息。用户需保证所提供的个人信息真实、准确，且同意本平台按照相关法律法规及隐私政策的规定处理这些信息。<br /><br />4. 免责声明<br />&nbsp; &nbsp;4.1 本平台不对用户上传的内容的真实性、准确性、完整性进行担保。<br />&nbsp; &nbsp;4.2 用户因使用本平台而遭受到的任何直接或间接损失，本平台不承担责任。<br />&nbsp; &nbsp;4.3 用户在使用本平台过程中与其他用户之间发生的争议，由相关当事人自行解决，本平台不承担任何责任。<br /><br />5. 知识产权<br />&nbsp; &nbsp;5.1 用户在使用本平台过程中创作的短剧视频享有相应的著作权。<br />&nbsp; &nbsp;5.2 用户在使用本平台过程中，不得侵犯他人的知识产权。<br /><br />6. 终止协议<br />&nbsp; &nbsp;6.1 用户违反本协议规定的，本平台有权终止用户的账号，并保留追究用户法律责任的权利。<br />&nbsp; &nbsp;6.2 用户自愿停止使用本平台的服务时，可以通过注销账号等方式终止本协议。<br /><br />7. 法律适用与争议解决<br />&nbsp; &nbsp;7.1 本协议的成立、生效、履行和解释，适用于中华人民共和国法律。<br />&nbsp; &nbsp;7.2 因本协议引起的或与本协议有关的争议，应通过友好协商解决；协商不成时，双方同意将争议提交有管辖权的人民法院解决。<br /><br />请您在使用本平台之前，仔细阅读并理解以上的用户协议。如您对协议内容有任何疑问，请及时联系我们查询。当您开始使用本平台时，即表示您已阅读、理解并同意遵守上述用户协议的规定。感谢您的合作与支持！<br /><br />最后修订日期：2023年08月02日<br />', 1690961958, 1701844749, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (9, 3, 1, '用户协议-英文版', '<span style=\"text-wrap:wrap;\">迈特短剧 用户协议</span><br style=\"text-wrap:wrap;\" /><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">欢迎使用迈特短剧平台（以下简称“本平台”）！在您开始使用本平台之前，请仔细阅读以下的用户协议。通过使用本平台，即表示您同意遵守以下条款和条件：</span><br style=\"text-wrap:wrap;\" /><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">1. 用户行为规范</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;1.1 在使用本平台的过程中，请勿发布与政治、色情、暴力相关的内容。我们鼓励用户创作积极、健康、有益的短剧内容。</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;1.2 用户需要尊重他人的合法权益，不得利用本平台从事侵犯他人权益的行为。包括但不限于侵犯他人知识产权、隐私权等。</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;1.3 用户不得以任何形式干扰或破坏本平台的正常运行，包括但不限于使用恶意程序、病毒等进行攻击。</span><br style=\"text-wrap:wrap;\" /><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">2. 平台服务</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;2.1 本平台提供用户上传、分享短剧视频的功能，并允许用户在平台上互相关注、点赞、评论等交流互动。</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;2.2 用户在使用本平台时，应自行承担风险，并确保所上传的内容符合法律法规和本协议的规定。如因用户违反法律法规或本协议的规定，而引发纠纷或产生责任，用户应自行承担相应的法律责任。</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;2.3 本平台有权根据需要增加、减少、更改或终止部分或全部服务内容，并无需提前通知用户。</span><br style=\"text-wrap:wrap;\" /><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">3. 用户隐私</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;3.1 本平台将采取合理的安全措施，保护用户的个人信息安全。</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;3.2 用户在使用本平台时，可能需要提供一些个人信息。用户需保证所提供的个人信息真实、准确，且同意本平台按照相关法律法规及隐私政策的规定处理这些信息。</span><br style=\"text-wrap:wrap;\" /><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">4. 免责声明</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;4.1 本平台不对用户上传的内容的真实性、准确性、完整性进行担保。</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;4.2 用户因使用本平台而遭受到的任何直接或间接损失，本平台不承担责任。</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;4.3 用户在使用本平台过程中与其他用户之间发生的争议，由相关当事人自行解决，本平台不承担任何责任。</span><br style=\"text-wrap:wrap;\" /><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">5. 知识产权</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;5.1 用户在使用本平台过程中创作的短剧视频享有相应的著作权。</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;5.2 用户在使用本平台过程中，不得侵犯他人的知识产权。</span><br style=\"text-wrap:wrap;\" /><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">6. 终止协议</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;6.1 用户违反本协议规定的，本平台有权终止用户的账号，并保留追究用户法律责任的权利。</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;6.2 用户自愿停止使用本平台的服务时，可以通过注销账号等方式终止本协议。</span><br style=\"text-wrap:wrap;\" /><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">7. 法律适用与争议解决</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;7.1 本协议的成立、生效、履行和解释，适用于中华人民共和国法律。</span><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">&nbsp; &nbsp;7.2 因本协议引起的或与本协议有关的争议，应通过友好协商解决；协商不成时，双方同意将争议提交有管辖权的人民法院解决。</span><br style=\"text-wrap:wrap;\" /><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">请您在使用本平台之前，仔细阅读并理解以上的用户协议。如您对协议内容有任何疑问，请及时联系我们查询。当您开始使用本平台时，即表示您已阅读、理解并同意遵守上述用户协议的规定。感谢您的合作与支持！</span><br style=\"text-wrap:wrap;\" /><br style=\"text-wrap:wrap;\" /><span style=\"text-wrap:wrap;\">最后修订日期：2023年08月02日</span>', 1701842928, 1701843888, 1701843888);
INSERT INTO `vs_dramas_richtext` VALUES (10, 3, 1, '积分充值介绍-英文版', 'Matt Short Play Integral Package Introduction:<br /><br />1. The integral package is a recharge method provided by the Mat Short Play platform for users. By purchasing the integral package, users can enjoy more services and privileges on the platform.<br /><br />2. The prices and contents of the integral packages will be publicly displayed on the platform, and users can choose the appropriate package according to their needs.<br /><br />3. After purchasing the integral package, the integrals will be directly recharged into your account and can be used to unlock paid content, participate in lottery activities, purchase virtual gifts, etc.<br /><br />4. The integral package has a certain validity period, please use it within the validity period. Remaining integrals will become unusable after expiration, so please be mindful.<br /><br />5. The integral package is for personal use only and is prohibited from being transferred, sold, or illegally traded in any other form. Once discovered, the platform will take corresponding measures.<br /><br />6. When using integrals, please comply with the relevant regulations and user agreements of the platform and do not post illegal or violating content involving politics, pornography, gambling, or drugs.<br /><br />7. If you have any questions or doubts, you can contact our customer service team at any time, and we will answer and handle them for you as soon as possible.<br /><br />We adhere to the purpose of providing high-quality, safe and reliable services to users and hope that you enjoy a pleasant experience on the Mat Short Play platform. Thank you for your support and understanding!&nbsp;<br /><br />(注意：这段译文非常好，没有发现任何问题。但请注意，原文中的“『**』『『**』『**』』”等部分看起来像是占位符或者需要替换的内容，如果需要进一步的澄清或替换，请告知。)<br />', 1701843021, 1701843944, 1701843944);
INSERT INTO `vs_dramas_richtext` VALUES (12, 3, 1, 'VIP会员权益-英文版', '<div style=\"text-wrap:wrap;\">感谢您选择迈特短剧VIP套餐，这是我们为用户提供的高级会员服务。作为VIP用户，您将享受以下特权和优惠：</div><div style=\"text-wrap:wrap;\"><br /></div><div style=\"text-wrap:wrap;\">1. 免费观看VIP视频：作为VIP会员，您将免费观看所有标注为VIP的视频内容。这些视频通常是一些独家、高品质的内容，包括热门电影、电视剧、综艺节目等。您可以尽情畅享这些精彩内容，无需再额外支付费用。</div><div style=\"text-wrap:wrap;\"><br /></div><div style=\"text-wrap:wrap;\">2. 优惠购买收费视频：除了免费观看VIP视频外，VIP用户还可以享受优惠购买收费视频的特权。在平台上存在一些需要付费才能观看的视频内容，作为VIP会员，您将享受更低的价格购买这些视频。这将大幅度降低您观看高质量视频的成本，并且让您更容易获得您感兴趣的内容。</div><div style=\"text-wrap:wrap;\"><br /></div><div style=\"text-wrap:wrap;\">3. 提供独家福利和活动：作为VIP会员，您将定期收到我们为VIP用户定制的独家福利和活动信息。这可能包括观影活动、会员专场等特殊活动，以及一些仅针对VIP会员的限时优惠等。我们将确保您在迈特短剧VIP社区中享有独特的待遇，让您感受到更多的价值和乐趣。</div><div style=\"text-wrap:wrap;\"><br /></div><div style=\"text-wrap:wrap;\">4. 快速播放和无广告体验：作为VIP用户，您将享受到更快的视频加载速度和流畅播放的体验。此外，在观看视频过程中，您将不再被冗长的广告打断，让您能够持续沉浸在精彩的内容中，提高观影的舒适度和质量。</div><div style=\"text-wrap:wrap;\"><br /></div><div style=\"text-wrap:wrap;\">5. 优先客服支持：作为VIP会员，您的问题和需求将优先得到我们专属的客服团队的支持。无论是关于账号问题、付款疑问还是其他使用上的困惑，我们将竭诚为您提供解答和帮助，以确保您拥有顺畅愉快的使用体验。</div><div style=\"text-wrap:wrap;\"><br /></div><div style=\"text-wrap:wrap;\">购买迈特短剧VIP套餐，将为您带来更好的观影体验和更丰富的内容选择。快来加入我们的VIP会员行列，与迈特短剧一同享受精彩的视听盛宴吧！</div>', 1701843284, 1701843898, 1701843898);
INSERT INTO `vs_dramas_richtext` VALUES (13, 3, 3, '联系我们-英文版', '<p><img src=\"https://mettchat.oss-accelerate.aliyuncs.com/mettgpt/20230715/256ff266c49826078ae524b8fed6b51a.png\" alt=\"\" /></p>', 1582259738, 1701853698, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (14, 3, 3, '隐私政策-英文版', 'Might Short Drama Privacy Agreement<br /><br />Welcome to use Might Short Drama (hereinafter referred to as \"the Software\"). The Software places great emphasis on the protection of user privacy. This Privacy Agreement aims to explain to users how the Software collects, uses, stores, and protects users\' personal information. Please read this Privacy Agreement carefully before using the Software. If you do not agree with any content of this Privacy Agreement, please do not use the Software.<br /><br />1. Information Collection<br />&nbsp; &nbsp; 1. The Software will not actively collect any personal information from users, including but not limited to names, \"***\" numbers, phone numbers, email addresses, etc.<br />&nbsp; &nbsp; 2. When users use the Software, it may automatically collect some technical information, including but not limited to users\' device information, operating system version, network status, IP address, etc.<br />&nbsp; &nbsp; 3. The Software may use third-party services, such as advertising services, statistical analysis services, etc., which may collect some information from users, but the Software will not actively provide any personal information of users to these third-party services.<br /><br />2. Information Use<br />&nbsp; &nbsp; 1. The technical information collected by the Software is only used to improve the quality of the Software\'s services, such as optimizing algorithms, improving intelligent recognition capabilities, etc.<br />&nbsp; &nbsp; 2. The Software will not use any personal information of users for commercial purposes, nor will it sell, rent, share, or exchange any personal information of users with any third party.<br /><br />3. Information Storage and Protection<br />&nbsp; &nbsp; 1. The technical information collected by the Software will be stored on the servers of the Software, and reasonable security measures will be taken to protect users\' information from being illegally obtained, used, or disclosed.<br />&nbsp; &nbsp; 2. The Software will take reasonable measures to protect users\' information from being accidentally deleted or damaged.<br /><br />4. Information Disclosure<br />&nbsp; &nbsp; 1. The Software will not disclose any personal information of users to any third party unless authorized by the user or required by law.<br />&nbsp; &nbsp; 2. If a user violates the Software\'s user regulations or legal provisions, the Software has the right to disclose the user\'s personal information to relevant departments.<br /><br />5. Protection of Minors\' Information<br />&nbsp; &nbsp; 1. The Software places great emphasis on the protection of minors\' information. Minors should use the Software under the guidance of their parents or guardians.<br />&nbsp; &nbsp; 2. The Software will not actively collect any personal information from minors. If a minor\'s parent or guardian discovers that the minor\'s personal information has been disclosed, please contact the Software developer immediately.<br /><br />6. Others<br />&nbsp; &nbsp; 1. The interpretation, application, and dispute resolution of this Privacy Agreement are subject to the laws of the People\'s Republic of China and will be under the jurisdiction of the People\'s Court where the Software developer is located.<br />&nbsp; &nbsp; 2. If you have any questions or suggestions, please contact the Software developer.<br /><br />The final interpretation of this Privacy Agreement belongs to the Software developer.<br />', 1582259745, 1701853693, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (15, 3, 3, '关于我们-英文版', '<p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><span style=\"text-align:center;white-space:normal;\">官方公众号</span></p><p><img src=\"https://mettchat.oss-accelerate.aliyuncs.com/mettgpt/20230715/256ff266c49826078ae524b8fed6b51a.png\" alt=\"\" /></p>', 1582259745, 1701853687, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (16, 3, 3, '法律声明-英文版', 'Met Short Drama Legal Statement<br /><br />Welcome to use Met Short Drama (hereinafter referred to as \"the Software\"). The Software is an intelligent assistant based on artificial intelligence technology, designed to provide users with more convenient and efficient services. Please carefully read this statement before using the Software. If you do not agree to any content of this statement, please do not use the Software.<br /><br />I. Intellectual Property Statement<br /><br />All rights, intellectual property rights, related technologies, and all content of the Software (including but not limited to text, images, audio, video, software, programs, code, interface design, data, etc.) are owned by the developer of the Software or relevant right holders.<br /><br />Without the written authorization of the developer of the Software or relevant right holders, no one may reproduce, disseminate, display, modify, sell, transfer, distribute, or use any content of the Software in any form.<br /><br />Any unauthorized act may constitute an infringement of the intellectual property rights of the developer of the Software or relevant right holders and will bear corresponding legal responsibilities.<br /><br />II. Disclaimer<br /><br />The Software only provides intelligent assistant services and does not assume any responsibility for the results of users using the Software.<br /><br />The Software does not assume any responsibility for any losses or damages incurred by users during the use of the Software, including but not limited to data loss, computer system crashes, network interruptions, etc. caused by using the Software.<br /><br />The Software does not assume any responsibility for any actions taken by users during the use of the Software, including but not limited to illegal acts, infringement of the rights of others, etc. caused by using the Software.<br /><br />The Software does not assume any responsibility for any third-party software or services used by users during the use of the Software, including but not limited to any losses or damages caused by using third-party software or services.<br /><br />The Software does not assume any responsibility for any technical issues encountered by users during the use of the Software, including but not limited to computer viruses, hacker attacks, etc. caused by using the Software.<br /><br />III. Privacy Protection Statement<br /><br />The Software will strictly protect the privacy of users and will not collect, store, or use any personal information of users unless voluntarily provided by users.<br /><br />The personal information voluntarily provided by users will be kept confidential by the Software and will not be disclosed to any third party unless explicitly authorized by the user or required by law.<br /><br />The Software will take reasonable security measures to protect users\' personal information from illegal access, use, or disclosure.<br /><br />IV. Other Statements<br /><br />The developer of the Software reserves the right to modify any content of this statement at any time. The modified statement will be posted on the Software, and users should pay attention to and comply with it promptly.<br /><br />The interpretation, application, and dispute resolution of this statement are subject to the laws of the People\'s Republic of China and are governed by the people\'s court where the developer of the Software is located.<br /><br />If you have any questions or comments, please contact the developer of the Software.<br /><br />The final interpretation of this statement belongs to the developer of the Software.<br />', 1683768542, 1701853681, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (17, 3, 3, '分销介绍-英文版', '<p><span style=\"font-size:18px;\"><b><p data-v-md-line=\"15\" style=\"box-sizing:border-box;margin-top:0px;margin-bottom:1em;font-size:14px;line-height:1.7;color:#2C3E50;font-family:-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;letter-spacing:-0.3px;text-wrap:wrap;\">How can I earn money using this tool?</p><p data-v-md-line=\"18\" style=\"box-sizing:border-box;margin-top:0px;font-size:14px;line-height:1.7;color:#2C3E50;font-family:-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;letter-spacing:-0.3px;text-wrap:wrap;margin-bottom:0px !important;\">After applying to become a distributor, you can promote the business and earn commissions based on your distributor tier. If you wish to advance to a higher level after becoming a distributor, you will need to purchase again at the full price. If the distributor status you have obtained is not permanent, obtaining the same level of distributor status again will accumulate the time. If the distributor tier you obtain is different from your current tier, your tier and time will be reset. Virtual goods are non-refundable once purchased.</p></b></span></p><p><br /></p>', 1685204309, 1701853653, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (18, 3, 3, 'VIP会员权益-英文版', '<div>Thank you for choosing the Mate Short Drama VIP package, which is a premium membership service we offer to our users. As a VIP user, you will enjoy the following privileges and benefits:<br /><br />1. Free access to VIP videos: As a VIP member, you will have free access to all videos labeled as VIP content. These videos are typically exclusive, high-quality content, including popular movies, TV shows, and variety shows. You can enjoy these fantastic content without any additional fees.<br /><br />2. Discounted purchase of paid videos: In addition to free access to VIP videos, VIP users also enjoy the privilege of discounted purchases of paid videos. There may be some video content on the platform that requires payment to view, and as a VIP member, you will receive a lower price for these videos. This significantly reduces your cost for watching high-quality videos and makes it easier for you to access content that interests you.<br /><br />3. Exclusive perks and events: As a VIP member, you will receive regular updates on exclusive perks and events tailored for VIP users. This may include movie screening events, member-only specials, and limited-time offers exclusively for VIP members. We ensure that you receive unique treatment within the Mate Short Drama VIP community, making you feel even more valued and entertained.<br /><br />4. Fast playback and ad-free experience: As a VIP user, you will experience faster video loading speeds and smooth playback. Additionally, while watching videos, you will no longer be interrupted by lengthy advertisements, allowing you to continuously immerse yourself in the content and enhance your viewing experience.<br /><br />5. Priority customer support: As a VIP member, your questions and needs will receive priority support from our dedicated customer service team. Whether it\'s related to account issues, payment inquiries, or other usage concerns, we will provide you with prompt answers and assistance to ensure a smooth and enjoyable experience for you.<br /><br />Purchasing the Mate Short Drama VIP package will bring you an enhanced viewing experience and a wider range of content options. Join our VIP membership today and enjoy a spectacular audio-visual feast with Mate Short Drama!<br /></div><div></div>', 1690961094, 1701853648, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (19, 3, 3, '积分充值介绍-英文版', 'Matt Short Play Integral Package Introduction:<br /><br />1. The integral package is a recharge method provided by the Mat Short Play platform for users. By purchasing the integral package, users can enjoy more services and privileges on the platform.<br /><br />2. The prices and contents of the integral packages will be publicly displayed on the platform, and users can choose the appropriate package according to their needs.<br /><br />3. After purchasing the integral package, the integrals will be directly recharged into your account and can be used to unlock paid content, participate in lottery activities, purchase virtual gifts, etc.<br /><br />4. The integral package has a certain validity period, please use it within the validity period. Remaining integrals will become unusable after expiration, so please be mindful.<br /><br />5. The integral package is for personal use only and is prohibited from being transferred, sold, or illegally traded in any other form. Once discovered, the platform will take corresponding measures.<br /><br />6. When using integrals, please comply with the relevant regulations and user agreements of the platform and do not post illegal or violating content involving politics, pornography, gambling, or drugs.<br /><br />7. If you have any questions or doubts, you can contact our customer service team at any time, and we will answer and handle them for you as soon as possible.<br /><br />We adhere to the purpose of providing high-quality, safe and reliable services to users and hope that you enjoy a pleasant experience on the Mat Short Play platform. Thank you for your support and understanding!&nbsp;<br />', 1690961645, 1701853643, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (20, 3, 3, '用户协议-英文版', '<div>Met Short Drama User Agreement</div><div><br /></div><div>Welcome to the Met Short Drama platform (hereinafter referred to as \"the Platform\")! Before you begin using the Platform, please carefully read the following user agreement. By using the Platform, you agree to abide by the terms and conditions outlined below:</div><div><br /></div><div>1. User Conduct Guidelines</div><div>1.1 In the process of using the Platform, please refrain from posting content related to politics, pornography, violence, or gambling. We encourage users to create positive, healthy, and beneficial short drama content.</div><div>1.2 Users need to respect the legitimate rights and interests of others and not use the Platform to engage in activities that infringe on the rights and interests of others, including but not limited to infringing on the intellectual property rights, privacy rights, etc. of others.</div><div>1.3 Users may not interfere with or disrupt the normal operation of the Platform in any way, including but not limited to using malicious programs, viruses, etc. to attack.</div><div><br /></div><div>2. Platform Services</div><div>2.1 The Platform provides users with the function of uploading and sharing short drama videos and allows users to interact with each other on the Platform, such as following, liking, and commenting.</div><div>2.2 When using the Platform, users should assume the risks themselves and ensure that the content uploaded complies with laws, regulations, and the provisions of this agreement. If disputes or liabilities arise due to users\' violation of laws, regulations, or the provisions of this agreement, users should assume corresponding legal responsibilities themselves.</div><div>2.3 The Platform reserves the right to add, reduce, change, or terminate some or all of the service content as needed without prior notice to users.</div><div><br /></div><div>3. User Privacy</div><div>3.1 The Platform will take reasonable security measures to protect the personal information security of users.</div><div>3.2 When using the Platform, users may need to provide some personal information. Users need to ensure that the personal information provided is true and accurate and agree that the Platform will handle this information in accordance with relevant laws, regulations, and privacy policies.</div><div><br /></div><div>4. Disclaimer</div><div>4.1 The Platform does not guarantee the authenticity, accuracy, or completeness of the content uploaded by users.</div><div>4.2 The Platform is not responsible for any direct or indirect losses suffered by users due to using the Platform.</div><div>4.3 Disputes arising between users and other users during the use of the Platform shall be resolved by the relevant parties themselves, and the Platform shall not assume any responsibility.</div><div><br /></div><div>5. Intellectual Property Rights</div><div>5.1 Users enjoy corresponding copyright for short drama videos created during the use of the Platform.</div><div>5.2 Users may not infringe on the intellectual property rights of others during the use of the Platform.</div><div><br /></div><div>6. Termination of Agreement</div><div>6.1 If a user violates the provisions of this agreement, the Platform has the right to terminate the user\'s account and reserve the right to pursue the user\'s legal responsibility.</div><div>6.2 When a user voluntarily stops using the services of the Platform, they may terminate this agreement by canceling their account or other means.</div><div><br /></div><div>7. Applicable Law and Dispute Resolution</div><div>7.1 The establishment, effectiveness, performance, and interpretation of this agreement are subject to the laws of the People\'s Republic of China.</div><div>7.2 Disputes arising from or related to this agreement shall be resolved through friendly consultation; if consultation fails, both parties agree to submit the dispute to a competent people\'s court for resolution.</div><div><br /></div><div>Please carefully read and understand the above user agreement before using the Platform. If you have any questions about the content of the agreement, please contact us promptly for inquiry. When you begin using the Platform, it means that you have read, understood, and agreed to abide by the provisions of this user agreement. Thank you for your cooperation and support!</div><div><br /></div><div>Last revised date: August 2nd, 2023</div></div>', 1690961958, 1701853639, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (21, 3, 5, '联系我们-泰文版', '<p><img src=\"https://mettchat.oss-accelerate.aliyuncs.com/mettgpt/20230715/256ff266c49826078ae524b8fed6b51a.png\" alt=\"\" /></p>', 1582259738, 1701853632, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (22, 3, 5, '隐私政策-泰文版', '<p style=\"text-align:center;\">ข้อตกลงความเป็นส่วนตัวของละครสั้นไมท์<br />ยินดีต้อนรับสู่ละครสั้น Mait (ต่อไปนี้จะเรียกว่า \"ซอฟต์แวร์นี้\") ซอฟต์แวร์นี้ให้ความสำคัญกับการปกป้องความเป็นส่วนตัวของผู้ใช้และข้อตกลงความเป็นส่วนตัวนี้มีวัตถุประสงค์เพื่อแจ้งให้ผู้ใช้ทราบว่าซอฟต์แวร์นี้รวบรวมใช้จัดเก็บและปกป้องข้อมูลส่วนบุคคลของผู้ใช้อย่างไร โปรดอ่านข้อตกลงความเป็นส่วนตัวนี้อย่างละเอียดก่อนใช้ซอฟต์แวร์ อย่าใช้ซอฟต์แวร์หากคุณไม่เห็นด้วยกับเนื้อหาใด ๆ ของข้อตกลงความเป็นส่วนตัวนี้<br /><br />I. การเก็บรวบรวมข้อมูล<br />1. ซอฟต์แวร์จะไม่เก็บรวบรวมข้อมูลส่วนบุคคลใด ๆ ของผู้ใช้งานโดยสมัครใจรวมถึงแต่ไม่ จำกัด เพียงชื่อหมายเลขบัตรประชาชนหมายเลขโทรศัพท์ที่อยู่อีเมล ฯลฯ<br />2. เมื่อผู้ใช้ซอฟต์แวร์ซอฟต์แวร์อาจเก็บรวบรวมข้อมูลทางเทคนิคบางอย่างโดยอัตโนมัติรวมถึงแต่ไม่ จำกัด เฉพาะข้อมูลอุปกรณ์ของผู้ใช้เวอร์ชันระบบปฏิบัติการสถานะเครือข่ายที่อยู่ IP ฯลฯ<br />3. ซอฟต์แวร์อาจใช้บริการของบุคคลที่สามเช่นบริการโฆษณาบริการวิเคราะห์ทางสถิติ ฯลฯ ซึ่งอาจรวบรวมข้อมูลบางอย่างเกี่ยวกับผู้ใช้ แต่ซอฟต์แวร์จะไม่ให้ข้อมูลส่วนบุคคลใด ๆ ของผู้ใช้กับบริการของบุคคลที่สาม<br />ii. การใช้ข้อมูล<br />1. ข้อมูลทางเทคนิคที่รวบรวมโดยซอฟต์แวร์นี้ใช้เพื่อปรับปรุงคุณภาพการบริการของซอฟต์แวร์นี้เท่านั้นเช่นการเพิ่มประสิทธิภาพอัลกอริทึมการปรับปรุงความสามารถในการระบุอัจฉริยะ ฯลฯ<br />2. ซอฟต์แวร์จะไม่ใช้ข้อมูลส่วนบุคคลของผู้ใช้เพื่อวัตถุประสงค์ทางการค้าและจะไม่ขาย ให้เช่า แบ่งปัน หรือแลกเปลี่ยนข้อมูลส่วนบุคคลของผู้ใช้แก่บุคคลที่สาม<br />III. การจัดเก็บข้อมูลและการป้องกัน<br />1. ข้อมูลทางเทคนิคที่รวบรวมโดยซอฟต์แวร์จะถูกเก็บไว้ในเซิร์ฟเวอร์ของซอฟต์แวร์และซอฟต์แวร์จะใช้มาตรการรักษาความปลอดภัยที่เหมาะสมเพื่อปกป้องข้อมูลของผู้ใช้จากการได้มาใช้หรือรั่วไหลอย่างผิดกฎหมาย<br />2. ซอฟต์แวร์จะใช้มาตรการที่เหมาะสมเพื่อปกป้องข้อมูลของผู้ใช้จากการถูกลบหรือเสียหายโดยไม่ได้ตั้งใจ<br />IV. การเปิดเผยข้อมูล<br />1. ซอฟต์แวร์จะไม่เปิดเผยข้อมูลส่วนบุคคลใด ๆ ของผู้ใช้ต่อบุคคลที่สามเว้นแต่จะได้รับอนุญาตอย่างชัดแจ้งจากผู้ใช้หรือตามที่กฎหมายกำหนด<br />2. ซอฟต์แวร์มีสิทธิ์ที่จะเปิดเผยข้อมูลส่วนบุคคลของผู้ใช้ต่อหน่วยงานที่เกี่ยวข้องในกรณีที่ผู้ใช้ละเมิดข้อกำหนดการใช้งานหรือกฎหมายและข้อบังคับของซอฟต์แวร์<br />V. การคุ้มครองข้อมูลผู้เยาว์<br />1. ซอฟต์แวร์นี้ให้ความสำคัญกับการปกป้องข้อมูลของผู้เยาว์และผู้เยาว์ควรใช้ซอฟต์แวร์ภายใต้การแนะนำของพ่อแม่หรือผู้ปกครอง<br />2. ซอฟต์แวร์จะไม่เก็บรวบรวมข้อมูลส่วนบุคคลใด ๆ ของผู้เยาว์เช่นพ่อแม่หรือผู้ปกครองของผู้เยาว์พบว่าข้อมูลส่วนบุคคลของผู้เยาว์รั่วไหลโปรดติดต่อการพัฒนาซอฟต์แวร์นี้ทันที<br />VI. อื่น ๆ<br />1. การตีความ การบังคับใช้และการระงับข้อพิพาทของข้อตกลงความเป็นส่วนตัวนี้ใช้กับกฎหมายของสาธารณรัฐประชาชนจีนและอยู่ภายใต้เขตอำนาจของศาลประชาชนซึ่งเป็นที่ตั้งของผู้พัฒนาซอฟต์แวร์นี้<br />2. คำถามหรือความคิดเห็นใด ๆ โปรดติดต่อนักพัฒนาซอฟต์แวร์นี้<br />การตีความขั้นสุดท้ายของข้อตกลงความเป็นส่วนตัวนี้เป็นของนักพัฒนาซอฟต์แวร์นี้<br /></p>', 1582259745, 1701853628, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (23, 3, 5, '关于我们-泰文版', '<p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><span style=\"text-align:center;white-space:normal;\">官方公众号</span></p><p><img src=\"https://mettchat.oss-accelerate.aliyuncs.com/mettgpt/20230715/256ff266c49826078ae524b8fed6b51a.png\" alt=\"\" /></p>', 1582259745, 1701853622, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (24, 3, 5, '法律声明-泰文版', '<div style=\"text-align:center;\"><strong>ประกาศทางกฎหมายของละครสั้นไมท์<br />ยินดีต้อนรับสู่ละครสั้น Mait (ต่อไปนี้จะเรียกว่า \"ซอฟต์แวร์นี้\") ซอฟต์แวร์นี้เป็นผู้ช่วยอัจฉริยะที่ใช้เทคโนโลยี AI ที่ออกแบบมาเพื่อให้ผู้ใช้บริการที่สะดวกและมีประสิทธิภาพมากขึ้น โปรดอ่านคำสั่งนี้อย่างละเอียดก่อนที่จะใช้ซอฟต์แวร์ อย่าใช้ซอฟต์แวร์นี้หากคุณไม่เห็นด้วยกับเนื้อหาใด ๆ ของประกาศนี้<br /><br />I. ประกาศเกี่ยวกับทรัพย์สินทางปัญญา<br />กรรมสิทธิ์ในซอฟต์แวร์ ทรัพย์สินทางปัญญา เทคโนโลยีที่เกี่ยวข้อง และเนื้อหาทั้งหมด (รวมถึงแต่ไม่จำกัดเฉพาะข้อความ รูปภาพ เสียง วิดีโอ ซอฟต์แวร์ โปรแกรม รหัส การออกแบบอินเทอร์เฟซ ข้อมูล ฯลฯ) เป็นของนักพัฒนาซอฟต์แวร์หรือผู้มีสิทธิที่เกี่ยวข้อง<br />ห้ามมิให้บุคคลใดทำซ้ำ เผยแพร่ แสดง ดัดแปลง ขาย โอน แจกจ่าย หรือใช้ประโยชน์จากเนื้อหาใดๆ ของซอฟต์แวร์ไม่ว่าในรูปแบบใดๆ โดยไม่ได้รับอนุญาตเป็นลายลักษณ์อักษรจากผู้พัฒนาซอฟต์แวร์หรือผู้มีสิทธิที่เกี่ยวข้อง<br />การกระทำที่ไม่ได้รับอนุญาตใด ๆ อาจถือเป็นการละเมิดทรัพย์สินทางปัญญาของนักพัฒนาซอฟต์แวร์หรือผู้มีสิทธิที่เกี่ยวข้องและจะต้องรับผิดชอบตามกฎหมายที่เกี่ยวข้อง<br />ii. การปฏิเสธความรับผิด<br />ซอฟต์แวร์นี้ให้บริการผู้ช่วยอัจฉริยะเท่านั้นและจะไม่รับผิดชอบต่อผลลัพธ์ของการใช้ซอฟต์แวร์โดยผู้ใช้<br />ซอฟต์แวร์จะไม่รับผิดชอบต่อความสูญเสียหรือความเสียหายใด ๆ ที่เกิดขึ้นจากการใช้ซอฟต์แวร์โดยผู้ใช้ ซึ่งรวมถึงแต่ไม่จำกัดเพียง การสูญเสียข้อมูล ความล้มเหลวของระบบคอมพิวเตอร์ การหยุดชะงักของเครือข่าย ฯลฯ อันเป็นผลมาจากการใช้ซอฟต์แวร์<br />ซอฟต์แวร์จะไม่รับผิดชอบต่อการกระทำใด ๆ ของผู้ใช้ในระหว่างการใช้ซอฟต์แวร์รวมถึงแต่ไม่ จำกัด เพียงการละเมิดสิทธิและผลประโยชน์ของผู้อื่น ฯลฯ ที่เกิดจากการใช้ซอฟต์แวร์<br />ซอฟต์แวร์จะไม่รับผิดชอบต่อผู้ใช้ซอฟต์แวร์หรือบริการของบุคคลที่สามใด ๆ ในระหว่างการใช้ซอฟต์แวร์รวมถึงแต่ไม่ จำกัด เพียงความสูญเสียหรือความเสียหายใด ๆ ที่เกิดจากการใช้ซอฟต์แวร์หรือบริการของบุคคลที่สาม<br />ซอฟต์แวร์จะไม่รับผิดชอบต่อปัญหาทางเทคนิคใด ๆ ที่เกิดขึ้นจากการใช้ซอฟต์แวร์ของผู้ใช้รวมถึงแต่ไม่ จำกัด เฉพาะไวรัสคอมพิวเตอร์การโจมตีของแฮ็กเกอร์ ฯลฯ ที่เกิดจากการใช้ซอฟต์แวร์<br />III. ประกาศการคุ้มครองความเป็นส่วนตัว<br />ซอฟต์แวร์นี้จะปกป้องความเป็นส่วนตัวของผู้ใช้อย่างเคร่งครัดและจะไม่เก็บรวบรวมจัดเก็บและใช้ข้อมูลส่วนบุคคลใด ๆ ของผู้ใช้เว้นแต่ผู้ใช้จะให้ด้วยความสมัครใจ<br />ข้อมูลส่วนบุคคลที่ได้รับจากผู้ใช้โดยสมัครใจซอฟต์แวร์จะถูกเก็บเป็นความลับอย่างเคร่งครัดและจะไม่รั่วไหลไปยังบุคคลที่สามเว้นแต่จะได้รับอนุญาตอย่างชัดเจนจากผู้ใช้หรือตามที่กฎหมายกำหนด<br />ซอฟต์แวร์นี้จะใช้มาตรการรักษาความปลอดภัยที่สมเหตุสมผลเพื่อปกป้องข้อมูลส่วนบุคคลของผู้ใช้จากการได้มาใช้หรือรั่วไหลอย่างผิดกฎหมาย<br />IV. แถลงการณ์อื่น ๆ<br />นักพัฒนาซอฟต์แวร์มีสิทธิ์ที่จะแก้ไขเนื้อหาใด ๆ ของคำสั่งนี้ได้ตลอดเวลาคำแถลงที่แก้ไขแล้วจะถูกประกาศในซอฟต์แวร์นี้และผู้ใช้ควรให้ความสนใจและปฏิบัติตามอย่างทันท่วงที<br />การตีความ การบังคับใช้และการระงับข้อพิพาทของข้อความนี้ใช้กฎหมายของสาธารณรัฐประชาชนจีนและอยู่ภายใต้เขตอำนาจของศาลประชาชนซึ่งเป็นที่ตั้งของผู้พัฒนาซอฟต์แวร์นี้<br />สำหรับคำถามหรือความคิดเห็นใด ๆ โปรดติดต่อนักพัฒนาซอฟต์แวร์นี้<br />การตีความขั้นสุดท้ายของคำสั่งนี้เป็นของผู้พัฒนาซอฟต์แวร์นี้<br /></strong></div><br />', 1683768542, 1701853617, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (25, 3, 5, '分销介绍-泰文版', '<br />สมัครเป็นตัวแทนจำหน่ายหลังจากนั้นสามารถทำการโปรโมทธุรกิจได้ ค่าคอมมิชชั่นของการโปรโมทขึ้นอยู่กับระดับตัวแทนจำหน่ายของคุณ。<br /><br />หลังจากอัพเกรดเป็นตัวแทนจำหน่ายแล้ว หากต้องการอัพเกรดคุณต้องซื้อใหม่ด้วยราคาเต็ม。<br /><br />หากตัวแทนจำหน่ายที่เปิดใช้ไม่ได้ถาวร การเปิดใช้ตัวแทนจำหน่ายที่มีระดับเดียวกันอีกครั้งจะทำให้เวลาสะสมกัน。<br /><br />หากการเปิดใช้งานของตัวแทนจำหน่ายไม่ตรงกับระดับปัจจุบัน ระดับและเวลาจะถูกรีเซ็ต。<br /><br />สินค้าเสมือนจริงเมื่อเติมเงินแล้วจะไม่ได้รับการคืนเงิน。<br />', 1685204309, 1701853610, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (26, 3, 5, 'VIP会员权益-泰文版', 'ขอบคุณที่เลือกแพ็กเกจ VIP ซีรีส์สั้นของ Maite，นี่คือบริการสมาชิกพรีเมียมที่เราให้บริการแก่ผู้ใช้งาน。ในฐานะผู้ใช้ VIP คุณจะได้รับสิทธิพิเศษและข้อเสนอต่อไปนี้1. ดูวิดีโอ VIP ฟรี：ในฐานะสมาชิก VIP คุณสามารถดูเนื้อหาวิดีโอที่มีเครื่องหมาย VIP ได้ฟรีทั้งหมด。เนื้อหาวิดีโอเหล่านี้มักจะเป็นเนื้อหาพิเศษและุณภาพสูง เช่น ภาพยนตร์ยอดนิยม ซีรีส์โทรทัศน์ รายการวาไรตี้ ฯลฯ。คุณสามารถเพลิดเพลินได้อย่างเต็มที่กับเนื้อหาที่น่าตื่นเต้นเหล่านี้โดยไม่ต้องจ่ายเงินเพิ่ม。<br />2. ข้อเสนอพิเศษในการซื้อวิดีโอเสียเงิน：นอกจากการดูวิดีโอ VIP ฟรีแล้ว ผู้ใช้ VIP ยังสามารถซื้อวิดีโอที่เสียเงินได้ในราคาข้อเสนอพิเศษ。มีเนื้อหาวิดีโอบางอย่างบนแพลตฟอร์มที่ต้อเสียเงินเพื่อดูเท่านั้น และในฐานะสมาชิก VIP คุณจะสามารถซื้อวิดีโอเหล่านี้ได้ในาคาที่ต่ำกว่า。เราจะทำให้คุณมีตัวเลือกที่หลากหลายและราคาที่ดีสำหรับการชมเนื้อหาที่คุณสนใจ。<br />3. สิทธิพิเศษและกิจกรรมพิเศษ：ในฐานะสมาชิก VIP คุณจะได้รับข้อมูลสิทธิพิเศษและกิจกรรมพิเศษที่ราจัดเตรียมไว้สำหรับผู้ใช้งาน VIP โดยเฉพาะ。นี่อาจจะรวมถึงกิจกรรมดูหนัง การฉายพิเศษสำหรับสมาชิก และข้อเสนอพิเศษที่จำกัดเพียงสมาชิก VIP เท่านั้น。เราจะรับรองว่าคุณจะได้รับการปฏิบัติอย่างพิเศษในชุมชน VIP ของ Maite ซีรีส์สั้นและรู้สึกได้ถึงค่าความสนุกที่มากยิ่งขึ้น。<br />4. การเล่นที่รวดเร็วและประสบการณ์ปราศจากโฆษณา：ในฐานะผู้ใช้งาน VIP คุณจะได้รับประสบการณ์การเล่นวิดีโอที่เร็วขึ้นแะปราศจากการหยุดชะงัก。นอกจากนั้น ในขณะที่คุณกำลังดูวิดีโอ คุณจะไม่ถูกขัดจังหวะด้วยโฆษณาที่ยาวนานอีกตอไป ทำให้คุณสามารถจมอยู่กับเนื้อหาที่น่าตื่นเต้นอย่างต่อเนื่องและพัฒนาคุณภาพและความสบายในการชมวิดีอได้。<br />5. การสนับสนุนลูกค้าที่เป็นสำคัญ：ในฐานะสมาชิก VIP คำถามและความต้องการของคุณจะได้รับความสนใจเป็นพิเศษจากทีมบริการลูกค้าของเรา。ไม่ว่าจะเป็นปัญหาเกี่ยวกับบัญชี คำถามเกี่ยวกับการชำระเงิน หรือข้อสงสัยอื่นๆ ในการใช้งาน เราพร้อมให้คำแนะนำและช่วยเหลืออย่างเต็มที่เพื่อให้แน่ใจว่าคุณจะได้รับการใช้งานที่ราบรื่นและสนุสนาน。<br />การซื้อแพ็กเกจ VIP ซีรีส์สั้นของ Maite จะทำให้คุณได้รับประสบการณ์การชมที่ดียิ่งขึ้นและลือกเนื้อหาที่หลากหลายมากขึ้น。รีบเข้าร่วมกับเราเป็นสมาชิก VIP และเพลิดเพลินกับการดูที่โดดเด่นไปกับ Maite ซีรีส์สั้นเลย!<br /><br />', 1690961094, 1701853605, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (27, 3, 5, '积分充值介绍-泰文版', 'ข้อควรระวังในการแนะนำชุดแพ็กเกจคะแนนของมายท์สั้น:<br />1. ชุดแพ็กเกจคะแนนเป็นวิธีการเติมเงินที่แพลตฟอร์มมายท์สั้นเสนอให้กับผู้ใช้ สามารถซื้อชุดแพ็กเกจคะแนนและเพลิดเพลินกับบริการและสิทธิพิเศษมากมายบนแพลตฟอร์ม<br />2. ราคาและเนื้อหาของชุดแพ็กเกจคะแนนจถูกโพสต์บนแพลตฟอร์ม ผู้ใช้สามารถเลือกชุดแพ็กเกจที่เหมาะสมกับคามต้องการของตนเง<br />3. หลังจากซื้อชุดแพ็กเกคะแนนแล้ว คะแนนจะถูกเติมเ้าไปในบัญชีของคุณทันที ที่สาารถใช้เพื่อปลดล็อคเนื้อหาที่ต้องชำระเงิน ร่มกิจกรรมลุ้นรางวัล ซื้อของขวัญเสือนจริง ฯลฯ<br />4. ชุดแพ็กเกจคแนนมีอายุการใช้งานที่กำหนด โปรดใช้งานภายในระยะเวลาที่กำนด หลังจากหมดอายุจะไม่สามารถใช้คะแนที่เหลืออยู่ได้ โปรดทราบ<br />5. ชุดแพ็กเกจคะแนนเปนไปเพื่อการใช้ส่วนตัวเท่านั้น ห้ามโอนขาย หรือทำธุรกรรมที่ผิดกฎหมายในรูปบบอื่น หากพบการละเมิด แพลตฟอร์มจะดำเนินมาตรการที่เหมาะสม<br />6. ขณะใช้คะแนน กรุณาปฏิบัติตามกฎข้อบังคับของแพลฟอร์มและข้อตกลงการใช้งานของผู้ใช้ และไม่พยายามโพสต์เนื้อหาที่เกี่ยวข้องกับการเมือง ลามก ความรุนแรง หรือเนื้อหาที่ผิดกฎหมายและข้อบังคับอื่นๆ<br />7. หากมีข้อสงสัยหรือคำถามใด ๆ คุณสามารถติดต่อทีมบริการลูกค้าของเราได้ตลอดเวลา และเราจะตอบและจัดการเรื่องของคุณโดยเร็วที่สุด<br />เรายึดมั่นในการให้บริการที่มีคุณภาพสูงและปลอดภัยแก่ผู้ใช้ เราหวังว่าคุณจะได้รับประสบการณ์การใช้งานี่สนุกสนานบนแพลตฟอร์มมายท์สั้น ขอบคุณสำหรับการสนับสนุนและความเข้าใจของคุณ!<br /><br />', 1690961645, 1701853599, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (28, 3, 5, '用户协议-泰文版', 'เงื่อนไขการใช้งานผู้ใช้ของแพทฟอร์มละครสั้น MAYTER<br />ยินดีต้อนรับสู่แพลตฟอร์มละครสั้นของ MAYTER (เรียกในข้อความต่อไปว่า \"แพลตฟอร์ม\") ก่อนที่คุณจะเริ่มใช้แพลตฟอร์มนี้ โปรดอ่านเงื่อนไขการใช้งานผู้ใช้ด้านล่างนี้อย่างรอบคอบ โดยการใช้แพลตฟอร์มนี้ หมายความว่าคุณตกลงที่จะปฏิบัติตามเงื่อนไขและข้อกำหนดดังต่อไปนี้:<br /><br />1. มารยาทการใช้งานของผู้ใช้<br />&nbsp; &nbsp;1.1 ในระหว่างการใช้แพลตฟอร์มนี้ กรุณาอย่าโพสต์เนื้อหาที่เกี่ยวข้องกับการเมืองหรืออื่นๆ ที่ไม่ถูกกฎหมายและแพลตฟอร์มขอแนะนำให้ผู้ใช้สร้างเนื้อหาละครสั้นที่มีพลังบวก มีสุขภาพดี และเป็นประโยชน์<br />&nbsp; &nbsp;1.2 ผู้ใช้จำเป็นต้องเคารพสิทธิ์ที่ถูกต้องของผู้อนและห้ามใช้แพลตฟอร์มนี้เพอกระทำการที่ละเมิดสิทธิ์ของผู้อื่น โดยรวมไปถึง แต่ไม่จำกัดเพียงการละเมิดสิทธิ์การครอบครองทางปัญญา สิทธิ์ความเป็นส่วนตัว เป็นต้น<br />&nbsp; &nbsp;1.3 ผู้ใช้ไม่จำเป็นต้องป่วนปั่นหรือทำลายการทำงานของแพลตฟอร์มอย่างปกติ ซึ่งรวมถึงแต่ไม่จำกัดเพียงการใช้โปรแกรมที่เป็นอันตราย ไวรัส เพื่อโจมตี<br />2. บริการของแพลตฟอร์ม<br />&nbsp; &nbsp;2.1 แพลตฟอร์มนี้ให้บริการแก่ผู้ใช้ในการอัปโหลดแชร์วิดีโอละครสั้นและอนุญาตให้ผู้ใช้สามารถติดตาม กดไลค์ แสดงความคิดเห็น และมีปฏิสัมพันธ์การสื่อสารบนแพลตฟอร์ม<br />&nbsp; &nbsp;2.2 ผู้ใช้ต้องรับผิดชอบความเสี่ยงเองในการใช้แพลตฟอร์มนี้ และต้องแน่ใจว่าเนื้อหาที่อัปโหลดตามข้อกำหนดของกฎหมายและเงื่อนไขของข้อตกลงนี้ หากเกิดข้อพิพาทหรือความรับผิดชอบจากการละเมิดกฎหมายหรือข้อตกลงนี้ ผู้ใช้ต้องรับผิดชอบด้านกฎหมายเอง<br />&nbsp; &nbsp;2.3 แพลตฟอร์มมีสิทธิ์ที่จะเพิ่ม ลด แก้ไข หรือยุติบางส่วนหรือทั้งหมดของเนื้อหาการบริการตามที่จำเป็นและไม่ต้องให้คำแจ้งล่วงหน้าแก่ผู้ใช้<br />3. ความเป็นส่วนตัวของผู้ใช้<br />&nbsp; &nbsp;3.1 แพลตฟอร์มจะใช้มาตรการความปลอดภัยที่เหมาะสมเพื่อปกป้องข้อมูลส่วนบุคคลของผู้ใช้<br />&nbsp; &nbsp;3.2 ผู้ใช้อาจต้องให้ข้อมูลส่วนบุคคลบางอย่างตอนใช้งานแพทฟอร์ ผู้ใช้ต้องรับประกันข้อมูลที่ให้มานั้นเป็นจริงและแน่นอน และตกลงให้แพลตฟอร์มปฏิบัติตามกฎหมายที่เกี่ยวข้องและนโยบายความเป็นส่วนตัวในการจัดการขูลเหล่านั้น<br />4. ข้อจำกัดความรับผิด<br />&nbsp; &nbsp;4.1 แพลตฟอร์มไม่รับประกันความถูกต้อง ความเที่ยงตรง ความสมบูรณ์ของเนื้อหาที่ผู้ใช้อัโหลด<br />&nbsp; &nbsp;4.2 ผู้ใช้ที่ได้รความเสียหายโดยตรงหรโดยอ้อมจากการใช้แพลตฟอร์มนี้ แพลตฟอร์มไม่รับผิดชอบ<br />&nbsp; &nbsp;4.3 ความขัดแย้งระหว่างผู้ใช้ในระหว่างการใช้แพลตฟอร์มต้องได้รับการแก้ไขโดยตัวผู้เกี่ยวข้องเอง แพลตฟอร์มไม่รับผิดชอบใดๆ<br />5. ลิขสิทธิ์<br />&nbsp; 5.1 ผู้ใช้ที่สร้างละครสั้นในระหว่างการใช้งานแลตฟอร์มมีสิทธิ์การเขียน&copy;️<br />&nbsp; &nbsp;5.2 ผู้ใช้ในระหว่างการใช้งานแพลตฟอร์มไม่ควรละเมิดลิขสิทธิ์ของผู้อื่น<br />6. การสิ้นสุดข้อตกลง<br />&nbsp; &nbsp;6.1 หากผู้ใช้ละเมิดข้อตกลงที่กำหนดไว้ แพลตฟอร์มมีสิทธิ์ยุติบัญชีผู้ใช้และเก็บสิทธิ์ในการดำเนินคดีตามกฎหมาย<br />&nbsp; &nbsp;6.2 ผู้ใช้ที่ต้องการยุติการใช้บริการของแพลตฟอร์มสามารถทำได้โดยการยกเลิกบัญชีหรือวิธีอื่นในการสิ้นสุดข้อตกลงนี้<br />7. การใช้กฎหมายและการแก้ไขข้อพิพาท<br />&nbsp; &nbsp;7.1 การเกิด การมีผล การปฏิบัติ และการตีความข้อตกลงนี้อยู่ภายใต้กฎหมายของสาธารณรัฐปะชาชนจีน<br />&nbsp; &nbsp;7.2 ความขัดแยงที่เกิดจากหรือเกี่ยวข้องกับข้อกลงนี้ควรได้รับการแก้ไขโดยการพูดคุยกันอย่างเป็นมิตรหากการเจรจาไม่สำเร็จ ทั้งสองฝ่ายตกลงที่จะนำความขัดแย้งไปยังศาลบริเวณที่มีอำนาจ<br /><br />ก่อนที่คุณจะเริ่มใช้แพลตฟอร์มนี้ โปรดอ่านและเข้าใจข้อตกลงผู้ใช้ข้างต้นอย่างละเอียด หากคุณมีคำถามใดๆ เกี่ยวกับเนื้อหาข้อตกลง กรุณาติดต่อเราทันที หากคุณเริ่มใช้แพลตฟอร์ม หมายความว่าคุณได้อ่าน ทำความเข้าใจ และยอมรับที่จะปฏิบัติตามข้อกำหนดในข้อตกลงผู้ใช้ข้างต้น ขอบคุณสำหรการร่วมมือและการสนับสนุนของคุณ!<br /><br />วันที่แก้ไขล่าสุด: 2 สิงหาคม 2023<br /><br />', 1690961958, 1701853593, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (29, 3, 7, '联系我们-西班牙语', '<p><img src=\"https://mettchat.oss-accelerate.aliyuncs.com/mettgpt/20230715/256ff266c49826078ae524b8fed6b51a.png\" alt=\"\" /></p>', 1582259738, 1701853585, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (30, 3, 7, '隐私政策-西班牙语', '<div style=\"text-align:center;\">Protocolo de privacidad para dramas cortos de Matt</div>Bienvenido a usar el drama corto de Maite (en adelante, \"este software\"). Este software concede gran importancia a la protección de la privacidad de los usuarios, y este acuerdo de privacidad tiene como objetivo explicar a los usuarios cómo este software recopila, utiliza, almacena y protege la información personal de los usuarios. Antes de usar este software, lea cuidadosamente este acuerdo de privacidad. Si no está de acuerdo con nada de este acuerdo de privacidad, no use este software.<br />I. recopilación de información<br />1. este software no tomará la iniciativa de recopilar ninguna información personal del usuario, incluyendo, pero no limitado a, nombre, número de identificación, número de teléfono, dirección de correo electrónico, etc.<br />2. cuando el usuario utiliza este software, este software puede recopilar automáticamente alguna información técnica, incluida, pero no limitada a, la información del dispositivo del usuario, la versión del sistema operativo, el Estado de la red, la dirección ip, etc.<br />3. este software puede utilizar servicios de terceros, como servicios de publicidad, servicios de análisis estadístico, etc. estos servicios pueden recopilar alguna información del usuario, pero este software no proporcionará activamente ninguna información personal del usuario a servicios de terceros.<br />II. uso de la información<br />1. la información técnica recopilada por este software solo se utiliza para mejorar la calidad del Servicio de este software, como optimizar algoritmos, mejorar la capacidad de reconocimiento inteligente, etc.<br />2. este software no utilizará ninguna información personal del usuario con fines comerciales, ni venderá, alquilará, compartirá o intercambiará ninguna información personal del usuario con ningún tercero.<br />III. almacenamiento y protección de la información<br />1. la información técnica recopilada por este software se almacenará en el servidor de este software, que tomará medidas de seguridad razonables para proteger la información del usuario de la adquisición, uso o filtración ilegal.<br />2. este software tomará medidas razonables para proteger la información del usuario de ser eliminada o dañada accidentalmente.<br />IV. divulgación de información<br />1. este software no revelará ninguna información personal del usuario a ningún tercero, a menos que esté claramente autorizado por el usuario o estipulado por la ley.<br />2. si el usuario viola las regulaciones de uso o las leyes y reglamentos de este software, este software tiene derecho a revelar la información personal del usuario a los departamentos pertinentes.<br />V. protección de la información de los menores<br />1. este software concede gran importancia a la protección de la información de los menores, que deben usar bajo la Guía de sus padres o tutores.<br />2. este software no recopilará activamente ninguna información personal del menor. si los padres o tutores del menor descubren que la información personal del menor ha sido filtrada, Póngase en contacto con el desarrollo de este software de inmediato.<br />VI. otros<br />1. la interpretación, aplicación y solución de controversias de este acuerdo de privacidad se regirán por las leyes de la República Popular China y estarán bajo la jurisdicción del Tribunal Popular del lugar donde se encuentre el desarrollador de este software.<br />2. si tiene alguna pregunta o comentario, Póngase en contacto con el desarrollador de este software.<br />El derecho final de interpretación de este acuerdo de privacidad pertenece al desarrollador de este software.<br />', 1582259745, 1701853580, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (31, 3, 7, '关于我们-西班牙语', '<p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><span style=\"text-align:center;white-space:normal;\">官方公众号</span></p><p><img src=\"https://mettchat.oss-accelerate.aliyuncs.com/mettgpt/20230715/256ff266c49826078ae524b8fed6b51a.png\" alt=\"\" /></p>', 1582259745, 1701853572, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (32, 3, 7, '法律声明-西班牙语', '<div><b>Declaración legal sobre el drama corto de Matt</b></div><div><b>Bienvenido a usar el drama corto de Maite (en adelante, \"este software\"). Este software es un asistente inteligente basado en la tecnología de inteligencia artificial, que tiene como objetivo proporcionar a los usuarios servicios más convenientes y eficientes. Antes de usar este software, lea esta declaración cuidadosamente. Si no está de acuerdo con alguno de los contenidos de esta declaración, no use este software.</b></div><div><b>I. Declaración sobre la propiedad intelectual</b></div><div><b>La propiedad, la propiedad intelectual, la tecnología relacionada y todo el contenido de este software (incluyendo, pero no limitado a, texto, imágenes, audio, video, software, programas, código, diseño de interfaz, datos, etc.) pertenecen al desarrollador de este software o al titular del derecho relacionado.</b></div><div><b>Nadie podrá copiar, difundir, mostrar, modificar, vender, transferir, distribuir o utilizar ningún contenido de este software de ninguna forma sin la autorización por escrito del desarrollador de este software o del titular de los derechos relacionados.</b></div><div><b>Cualquier comportamiento no autorizado puede constituir una violación de los derechos de propiedad intelectual del desarrollador de este software o del titular de los derechos relacionados, y asumirá la responsabilidad legal correspondiente.</b></div><div><b>II. Declaración de exoneración</b></div><div><b>Este software solo ofrece servicios de asistente inteligente y no asume ninguna responsabilidad por los resultados del uso de este software por parte de los usuarios.</b></div><div><b>Este software no asume ninguna responsabilidad por ninguna pérdida o daño durante el uso de este software por parte del usuario, incluyendo, pero no limitado a, la pérdida de datos causada por el uso de este software, el colapso del sistema informático, la interrupción de la red, etc.</b></div><div><b>Este software no asume ninguna responsabilidad por ningún comportamiento del usuario durante el uso de este software, incluyendo, pero no limitado a, actos ilegales causados por el uso de este software, violaciones de los derechos e intereses de otras personas, etc.</b></div><div><b>Este software no asume ninguna responsabilidad del usuario por ningún software o servicio de terceros durante el uso de este software, incluyendo, pero no limitado a, cualquier pérdida o daño causado por el uso de software o servicio de terceros.</b></div><div><b>Este software no asume ninguna responsabilidad por ningún problema técnico en el proceso de uso de este software por parte del usuario, incluidos, pero no limitados a, virus informáticos, piratas informáticos, etc. causados por el uso de este software.</b></div><div><b>III. Declaración sobre la protección de la privacidad</b></div><div><b>Este software protegerá estrictamente la privacidad de los usuarios y no recopilará, almacenará ni utilizará ninguna información personal de los usuarios a menos que los usuarios la proporcionen voluntariamente.</b></div><div><b>La información personal proporcionada voluntariamente por el usuario, este software será estrictamente confidencial y no se filtrará a ningún tercero, a menos que esté claramente autorizado por el usuario o estipulado por la ley.</b></div><div><b>Este software tomará medidas de seguridad razonables para proteger la información personal de los usuarios de la adquisición, uso o divulgación ilegal.</b></div><div><b>IV. otras declaraciones</b></div><div><b>El desarrollador de este software tiene derecho a modificar cualquier contenido de esta declaración en cualquier momento. la declaración modificada se publicará en este software y el usuario debe prestarle atención y cumplirla a tiempo.</b></div><div><b>La interpretación, aplicación y solución de controversias de esta declaración se regirán por las leyes de la República Popular China y estarán bajo la jurisdicción del Tribunal Popular del lugar donde se encuentre el desarrollador de este software.</b></div><div><b>Si tiene alguna pregunta o comentario, Póngase en contacto con el desarrollador de este software.</b></div><div><b>El derecho final de interpretación de esta declaración pertenece al desarrollador de este software.</b></div>', 1683768542, 1701853568, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (33, 3, 7, '分销介绍-西班牙语', '¿¿ cómo usar esta herramienta para ganar dinero?<br />Después de solicitar ser un distribuidor, se puede realizar una promoción de negocio, y la Comisión de promoción se distribuye de acuerdo con su propio nivel de distribuidor.<br />Después de la actualización a un distribuidor, si desea actualizar, debe volver a comprarlo a precio completo.<br />Si el distribuidor abierto no es permanente, el distribuidor del mismo nivel se reabrirá para acumular tiempo.<br />Si el nivel de distribuidor abierto no coincide con el actual, se restablecerá el nivel y el tiempo.<br />Una vez recargados los productos virtuales, no se reembolsarán.<br />', 1685204309, 1701853564, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (34, 3, 7, 'VIP会员权益-西班牙语', 'Gracias por elegir el paquete VIP de drama corto de maite, que es nuestro servicio de membresía de alto nivel para los usuarios. Como usuario vip, disfrutará de los siguientes privilegios y ofertas:<br />1. ver videos VIP de forma gratuita: como miembro vip, verá todos los videos marcados como VIP de forma gratuita. Estos videos suelen ser algunos contenidos exclusivos y de alta calidad, incluyendo películas populares, series de televisión, espectáculos de variedades, etc. Puede disfrutar de estos maravillosos contenidos sin pagar tarifas adicionales.<br />2. compra preferencial de videos de pago: además de ver videos VIP de forma gratuita, los usuarios VIP también pueden disfrutar del privilegio de comprar videos de pago preferencial. Hay algunos contenidos de vídeo en la plataforma que hay que pagar para verlos, y como miembro vip, disfrutará de un precio más bajo para comprarlos. Esto reducirá drásticamente el costo de ver videos de alta calidad y le facilitará obtener lo que le interesa.<br />3. beneficios y actividades exclusivas: como miembro vip, recibirá regularmente información sobre beneficios y actividades exclusivas que personalizamos para los usuarios vip. Esto puede incluir actividades especiales como actividades de visualización de películas, sesiones especiales de membresía y algunas concesiones de tiempo limitado solo para miembros vip. Nos aseguraremos de que disfrute de un trato único en la comunidad VIP de drama corto de maite, para que sienta más valor y diversión.<br />4. reproducción rápida y experiencia sin publicidad: como usuario vip, disfrutará de una velocidad de carga de vídeo más rápida y una experiencia de reproducción fluida. Además, durante la visualización del video, ya no se verá interrumpido por largos anuncios, lo que le permitirá seguir inmerso en contenido maravilloso, mejorando la comodidad y la calidad de ver películas.<br />5. apoyo prioritario al servicio al cliente: como miembro vip, sus preguntas y necesidades tendrán prioridad en el apoyo de nuestro equipo exclusivo de servicio al cliente. Ya sea sobre preguntas de cuenta, preguntas de pago u otra confusión en el uso, le proporcionaremos respuestas y ayuda de todo corazón para garantizar una experiencia de uso suave y agradable.<br />Comprar un paquete VIP de drama corto de Maite le traerá una mejor experiencia de visualización de películas y opciones de contenido más ricas. ¡¡ ven a unirte a nuestros miembros VIP y disfruta de una maravillosa fiesta audiovisual con el drama corto de matt!<br /><br />', 1690961094, 1701853560, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (35, 3, 7, '积分充值介绍-西班牙语', 'El paquete de puntos de drama corto de Matt presenta las precauciones:<br />1. el paquete de puntos es una forma de recargar para los usuarios proporcionada por la Plataforma de drama corto de maite, que puede disfrutar de más servicios y privilegios en la plataforma comprando el paquete de puntos.<br />2. el precio y el contenido del paquete de puntos se anunciarán en la plataforma, y los usuarios pueden elegir el paquete adecuado de acuerdo con sus propias necesidades.<br />3. después de comprar el paquete de puntos, los puntos se recargarán directamente en su cuenta y se pueden utilizar para desbloquear el contenido pagado, participar en actividades de sorteo, comprar regalos virtuales, etc.<br />4. el paquete de puntos tiene un cierto período de validez. por favor, use durante el período de validez. después de la expiración, no podrá usar los puntos restantes. tenga en cuenta.<br />5. los paquetes de puntos son para uso personal y están prohibidos de transferir, vender u otras formas de transacciones ilegales. Una vez descubierto, la plataforma tomará las medidas de tratamiento correspondientes.<br />6. al usar puntos, cumpla con las regulaciones pertinentes de la Plataforma y los protocolos de uso del usuario, y no publique contenido ilegal e ilegal que implique política, pornografía, violencia, etc.<br />7. si tiene alguna pregunta o pregunta, puede ponerse en contacto con nuestro equipo de servicio al cliente en cualquier momento, y le responderemos y trataremos lo antes posible.<br />Nos adherimos al propósito de proporcionar a los usuarios servicios de alta calidad, seguros y confiables, y esperamos que disfrute de una experiencia de uso agradable en la Plataforma de drama corto de maite. ¡¡ gracias por su apoyo y comprensión!<br /><br />', 1690961645, 1701853554, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (36, 3, 7, '用户协议-西班牙语', 'Protocolo de usuario de drama corto de Maite<br />¡¡ Bienvenidos a la Plataforma de dramas cortos Maite (en adelante, \"esta plataforma\")! Antes de comenzar a usar esta plataforma, lea cuidadosamente el siguiente protocolo de usuario. Al utilizar esta plataforma, se indica que está de acuerdo en cumplir con los siguientes términos y condiciones:<br />1. Código de conducta del usuario<br />1.1 no publicar contenido relacionado con la política, la pornografía y la violencia durante el uso de esta plataforma. Animamos a los usuarios a crear contenido de drama corto positivo, saludable y beneficioso.<br />1.2 Los usuarios deben respetar los derechos e intereses legítimos de los demás y no deben utilizar esta plataforma para cometer actos que violen los derechos e intereses de los demás. Incluyendo, pero no limitado a, la violación de los derechos de propiedad intelectual de otras personas, el derecho a la privacidad, etc.<br />1.3 Los usuarios no deben interferir ni destruir el funcionamiento normal de la Plataforma de ninguna forma, incluido, pero no limitado a, el uso de programas maliciosos, virus, etc. para atacar.<br />2. servicios de plataforma<br />2.1 esta plataforma ofrece a los usuarios la función de cargar y compartir videos de dramas cortos, y permite a los usuarios comunicarse e interactuar entre sí, gustar y comentar en la plataforma.<br />2.2 Los usuarios asumirán sus propios riesgos al utilizar esta plataforma y se asegurarán de que el contenido subido se ajuste a las leyes y reglamentos y a las disposiciones del presente acuerdo. En caso de disputa o responsabilidad causada por el usuario por violar las leyes y reglamentos o las disposiciones del presente acuerdo, el usuario asumirá la responsabilidad legal correspondiente por sí mismo.<br />2.3 esta plataforma tiene derecho a agregar, reducir, cambiar o terminar parte o la totalidad del contenido del servicio según sea necesario, sin necesidad de informar a los usuarios con antelación.<br />3. privacidad del usuario<br />3.1 La plataforma tomará medidas de seguridad razonables para proteger la seguridad de la información personal de los usuarios.<br />3.2 Los usuarios pueden necesitar proporcionar alguna información personal al usar esta plataforma. Los usuarios deben garantizar que la información personal proporcionada sea verdadera y precisa, y aceptar que esta plataforma procese esta información de acuerdo con las leyes, reglamentos y políticas de privacidad pertinentes.<br />4. descargo de responsabilidad<br />4.1 esta plataforma no garantiza la autenticidad, precisión e integridad del contenido subido por los usuarios.<br />4.2 esta plataforma no es responsable de ninguna pérdida directa o indirecta sufrida por los usuarios debido a su uso de esta plataforma.<br />4.3 Las disputas entre los usuarios y otros usuarios durante el uso de esta plataforma serán resueltas por las propias partes interesadas, y esta plataforma no asumirá ninguna responsabilidad.<br />5. propiedad intelectual<br />5.1 Los vídeos cortos creados por los usuarios durante el uso de esta plataforma gozan de los derechos de autor correspondientes.<br />5.2 Los usuarios no deben violar los derechos de propiedad intelectual de otras personas durante el uso de esta plataforma.<br />6. rescisión del Acuerdo<br />6.1 Si un usuario viola las disposiciones de este acuerdo, la Plataforma tiene derecho a rescindir la cuenta del usuario y se reserva el derecho de investigar la responsabilidad legal del usuario.<br />6.2 Cuando un usuario deje de usar voluntariamente los servicios de esta plataforma, puede rescindir este acuerdo cancelando su cuenta, etc.<br />7. aplicación de la ley y solución de controversias<br />7.1 El establecimiento, la entrada en vigor, el cumplimiento y la interpretación del presente Acuerdo se aplicarán a las leyes de la República Popular China.<br />7.2 Las controversias derivadas del presente Acuerdo o relacionadas con él se resolverán mediante consultas amistosas; Si la consulta no se llega a un acuerdo, ambas partes acuerdan remitir la controversia al Tribunal Popular competente para su solución.<br />Lea y comprenda cuidadosamente los protocolos de usuario anteriores antes de usar esta plataforma. Si tiene alguna pregunta sobre el contenido del acuerdo, Póngase en contacto con nosotros a tiempo para consultar. Cuando comience a usar esta plataforma, significa que ha leído, entendido y aceptado cumplir con las disposiciones del Acuerdo de usuario anterior. ¡¡ gracias por su cooperación y apoyo!<br />Última revisión: 02 de agosto de 2023<br /><br />', 1690961958, 1701853709, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (37, 3, 8, '联系我们-阿拉伯语', '<p><img src=\"https://mettchat.oss-accelerate.aliyuncs.com/mettgpt/20230715/256ff266c49826078ae524b8fed6b51a.png\" alt=\"\" /></p>', 1582259738, 1701853550, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (38, 3, 8, '隐私政策-阿拉伯语', '<p style=\"text-align:center;\"><strong>اتفاق الخصوصية&nbsp;&nbsp;<br />&nbsp;مرحبا بكم في مسرحية قصيرة ( المشار إليها فيما يلي باسم \" هذا البرنامج \" ) .&nbsp; &nbsp;هذا البرنامج يدفع إنتباه عظيمة إلى حماية خصوصية المستخدم ، وهذا اتفاق الخصوصية يهدف إلى شرح كيفية جمع واستخدام وتخزين وحماية المعلومات الشخصية للمستخدم .&nbsp; &nbsp;قبل استخدام هذا البرنامج ، يرجى قراءة هذه الخصوصية الاتفاق بعناية .&nbsp; &nbsp;لا تستخدم هذا البرنامج إذا كنت لا توافق على أي من هذه الخصوصية .&nbsp;&nbsp;<br />&nbsp;أولاً - جمع المعلومات&nbsp;&nbsp;<br />&nbsp;1 . هذا البرنامج لن تأخذ زمام المبادرة في جمع أي معلومات شخصية عن المستخدم ، بما في ذلك ولكن لا تقتصر على الاسم ، رقم الهوية ، رقم الهاتف ، عنوان البريد الإلكتروني ، وهلم جرا .&nbsp;&nbsp;<br />&nbsp;2 . عندما يقوم المستخدم باستخدام هذا البرنامج ، هذا البرنامج قد جمع بعض المعلومات التقنية تلقائيا ، بما في ذلك ولكن لا تقتصر على المستخدم معلومات الجهاز ، نظام التشغيل الإصدار ، حالة الشبكة ، عنوان بروتوكول الإنترنت ، وهلم جرا .&nbsp;&nbsp;<br />&nbsp;3 . هذا البرنامج قد تستخدم خدمات الطرف الثالث ، مثل الخدمات الإعلانية ، خدمات التحليل الإحصائي ، وما إلى ذلك هذه الخدمات قد جمع بعض المعلومات من المستخدمين ، ولكن هذا البرنامج لن تأخذ زمام المبادرة في تقديم خدمات الطرف الثالث أي معلومات شخصية عن المستخدمين .&nbsp;&nbsp;<br />&nbsp;ثانياً - استخدام المعلومات&nbsp;&nbsp;<br />&nbsp;1 - المعلومات التقنية التي تم جمعها من هذا البرنامج يستخدم فقط لتحسين جودة الخدمة من هذا البرنامج ، مثل تحسين خوارزمية ، وتحسين القدرة على التعرف الذكي ، وهلم جرا .&nbsp;&nbsp;<br />&nbsp;2 . هذا البرنامج لن تستخدم أي معلومات شخصية عن المستخدم لأغراض تجارية ، أو بيع أو تأجير أو تبادل أي معلومات شخصية عن المستخدم إلى أي طرف ثالث .&nbsp;&nbsp;<br />&nbsp;ثالثاً - تخزين المعلومات وحمايتها&nbsp;&nbsp;<br />&nbsp;1 - المعلومات التقنية التي تم جمعها من قبل هذا البرنامج سيتم تخزينها على الخادم من هذا البرنامج ، البرنامج سوف تتخذ تدابير أمنية معقولة لحماية المستخدم من المعلومات التي تم الحصول عليها بصورة غير مشروعة ، أو استخدامها أو الكشف عنها .&nbsp;&nbsp;<br />&nbsp;2 . هذا البرنامج سوف تتخذ تدابير معقولة لحماية معلومات المستخدم من غير قصد حذف أو تلف .&nbsp;&nbsp;<br />&nbsp;رابعاً - الإفصاح عن المعلومات&nbsp;&nbsp;<br />&nbsp;1 - هذا البرنامج لن تكشف عن أي معلومات شخصية عن المستخدم إلى أي طرف ثالث ، ما لم يأذن صراحة من قبل المستخدم أو بموجب القانون .&nbsp;&nbsp;<br />&nbsp;2 . إذا كان المستخدم ينتهك أحكام استخدام البرمجيات أو القوانين واللوائح ، والبرمجيات الحق في الكشف عن المعلومات الشخصية إلى الإدارات ذات الصلة .&nbsp;&nbsp;<br />&nbsp;خامساً - حماية معلومات الأحداث&nbsp;&nbsp;<br />&nbsp;1 . هذا البرنامج يدفع إنتباه عظيمة إلى القصر حماية المعلومات ، القصر يجب استخدام هذا البرنامج تحت إشراف الوالدين أو الوصي .&nbsp;&nbsp;<br />&nbsp;2 . هذا البرنامج لن تأخذ زمام المبادرة في جمع أي معلومات شخصية عن الأحداث ، مثل الآباء أو الأوصياء على الأحداث العثور على المعلومات الشخصية من الأحداث قد تسربت ، يرجى الاتصال على الفور تطوير البرمجيات&nbsp;&nbsp;<br />&nbsp;سادساً - مسائل أخرى&nbsp;&nbsp;<br />&nbsp;1 - تفسير وتطبيق وتسوية المنازعات من اتفاق الخصوصية هذه تخضع لقوانين جمهورية الصين الشعبية ، وتخضع لاختصاص محكمة الشعب في مكان مطور البرمجيات .&nbsp;&nbsp;<br />&nbsp;2 . إذا كان لديك أي أسئلة أو تعليقات ، يرجى الاتصال بمطوري البرمجيات .&nbsp;&nbsp;<br />&nbsp;التفسير النهائي من اتفاق الخصوصية هذا ملك لمطوري البرمجيات .<br /></strong></p><p><br /></p>', 1582259745, 1701853545, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (39, 3, 8, '关于我们-阿拉伯语', '<p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><span style=\"text-align:center;white-space:normal;\">官方公众号</span></p><p><img src=\"https://mettchat.oss-accelerate.aliyuncs.com/mettgpt/20230715/256ff266c49826078ae524b8fed6b51a.png\" alt=\"\" /></p>', 1582259745, 1701853540, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (40, 3, 8, '法律声明-阿拉伯语', '<div style=\"text-align:center;\"><strong>ميتر دراما البيان القانوني&nbsp;&nbsp;<br />&nbsp;مرحبا بكم في مسرحية قصيرة ( المشار إليها فيما يلي باسم \" هذا البرنامج \" ) .&nbsp; &nbsp;هذا البرنامج هو مساعد ذكي على أساس تكنولوجيا الذكاء الاصطناعي ، ويهدف إلى تزويد المستخدمين مع أكثر ملاءمة وكفاءة الخدمة .&nbsp; &nbsp;يرجى قراءة هذا البيان بعناية قبل استخدام هذا البرنامج .&nbsp; &nbsp;إذا كنت لا توافق على أي من محتويات هذا البيان ، لا تستخدم هذا البرنامج .&nbsp;&nbsp;<br />&nbsp;&nbsp;&nbsp;<br />&nbsp;بيان الملكية الفكرية&nbsp;&nbsp;<br />&nbsp;الملكية ، والملكية الفكرية ، والتكنولوجيات ذات الصلة ، وجميع محتويات البرنامج ( بما في ذلك ولكن لا تقتصر على النص ، الصور ، الصوت ، الفيديو ، البرامج ، البرامج ، رمز ، تصميم واجهة ، والبيانات ، وما إلى ذلك ) تنتمي إلى مطوري البرمجيات أو أصحاب الحقوق ذات الصلة .&nbsp;&nbsp;<br />&nbsp;لا يجوز لأي شخص نسخ أو نشر أو عرض أو تعديل أو بيع أو نقل أو توزيع أو استخدام أي محتوى من هذا البرنامج في أي شكل من الأشكال دون إذن خطي من مطور البرنامج أو أصحاب الحقوق ذات الصلة .&nbsp;&nbsp;<br />&nbsp;أي عمل غير مصرح به قد يشكل انتهاكا لحقوق الملكية الفكرية للمطورين أو أصحاب الحقوق ذات الصلة ، وسوف تكون مسؤولة عن ذلك .&nbsp;&nbsp;<br />&nbsp;ثانياً - الإعفاء&nbsp;&nbsp;<br />&nbsp;هذا البرنامج يوفر خدمة مساعد ذكي فقط ، لا تتحمل أي مسؤولية عن نتيجة استخدام هذا البرنامج من قبل المستخدم .&nbsp;&nbsp;<br />&nbsp;هذا البرنامج لا يتحمل أي مسؤولية عن أي خسارة أو ضرر على المستخدم أثناء استخدام هذا البرنامج ، بما في ذلك ولكن لا تقتصر على فقدان البيانات ، تعطل نظام الكمبيوتر ، انقطاع الشبكة ، الخ .&nbsp;&nbsp;<br />&nbsp;هذا البرنامج لا يتحمل أي مسؤولية عن أي عمل يقوم به المستخدم أثناء استخدام هذا البرنامج ، بما في ذلك ولكن لا تقتصر على أي عمل غير قانوني أو التعدي على حقوق ومصالح الآخرين الناجمة عن استخدام هذا البرنامج .&nbsp;&nbsp;<br />&nbsp;هذا البرنامج لا يتحمل أي مسؤولية ، بما في ذلك ولكن لا تقتصر على أي خسارة أو ضرر ناجم عن استخدام طرف ثالث البرمجيات أو الخدمات .&nbsp;&nbsp;<br />&nbsp;هذا البرنامج لا يتحمل أي مسؤولية عن أي مشاكل تقنية أثناء استخدام هذا البرنامج ، بما في ذلك ولكن لا تقتصر على فيروسات الكمبيوتر ، هجمات القراصنة ، الخ .&nbsp;&nbsp;<br />&nbsp;بيان الخصوصية&nbsp;&nbsp;<br />&nbsp;هذا البرنامج سوف تحمي خصوصية المستخدم بدقة ، لن جمع وتخزين واستخدام أي معلومات شخصية عن المستخدم ، إلا إذا كان المستخدم على استعداد لتقديم .&nbsp;&nbsp;<br />&nbsp;المعلومات الشخصية المقدمة طوعا من قبل المستخدم ، وهذا البرنامج سوف تكون سرية للغاية ولن يتم الكشف عنها إلى أي طرف ثالث ، إلا بعد إذن صريح من المستخدم أو المنصوص عليها في القانون .&nbsp;&nbsp;<br />&nbsp;هذا البرنامج سوف تتخذ تدابير أمنية معقولة لحماية المستخدمين من المعلومات الشخصية التي تم الحصول عليها بصورة غير مشروعة ، أو استخدامها أو الكشف عنها .&nbsp;&nbsp;<br />&nbsp;رابعاً - بيانات أخرى&nbsp;&nbsp;<br />&nbsp;مطوري البرمجيات لديها الحق في تعديل أي من محتويات هذا البيان في أي وقت ، تعديل البيان سيتم نشره على هذا البرنامج ، يجب على المستخدمين في الوقت المناسب لمراقبة الامتثال .&nbsp;&nbsp;<br />&nbsp;تفسير وتطبيق وتسوية المنازعات من هذا الإعلان يجب أن تحكمها قوانين جمهورية الصين الشعبية ، ويكون من اختصاص محكمة الشعب في المكان حيث مطور البرنامج يقع .&nbsp;&nbsp;<br />&nbsp;إذا كان لديك أي أسئلة أو تعليقات ، يرجى الاتصال بمطوري البرمجيات .&nbsp;&nbsp;<br />&nbsp;التفسير النهائي لهذا البيان هو ملك مطوري البرمجيات .<br /></strong></div><br />', 1683768542, 1701853536, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (41, 3, 8, '分销介绍-阿拉伯语', 'كيفية استخدام هذه الأداة لكسب المال ؟&nbsp;&nbsp;<br />&nbsp;بعد تطبيق الموزع يمكن أن تحمل على تعزيز الأعمال التجارية ، وتعزيز اللجنة تقوم على تقسيم الربح حسب الموزع الخاصة الصف .&nbsp;&nbsp;<br />&nbsp;بعد الترقية إلى موزع ، إذا كنت ترغب في الترقية ، تحتاج إلى إعادة شراء كامل السعر .&nbsp;&nbsp;<br />&nbsp;إذا كان الموزع هو غير دائم ، إعادة تشغيل الموزع على نفس المستوى من الوقت التراكمي .&nbsp;&nbsp;<br />&nbsp;إذا كان مستوى الموزع الحالي لا يتفق مع مستوى و وقت إعادة تعيين .&nbsp;&nbsp;<br />&nbsp;بمجرد شحن السلع الافتراضية ، لا رد .<br />', 1685204309, 1701853529, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (42, 3, 8, 'VIP会员权益-阿拉伯语', '<div>感谢您选择迈特短剧VIP套餐，这是我们为用户提供的高级会员服务。作为VIP用户，您将享受以下特权和优惠：</div><div><br /></div><div>1. 免费观看VIP视频：作为VIP会员，您将免费观看所有标注为VIP的视频内容。这些视频通常是一些独家、高品质的内容，包括热门电影、电视剧、综艺节目等。您可以尽情畅享这些精彩内容，无需再额外支付费用。</div><div><br /></div><div>2. 优惠购买收费视频：除了免费观看VIP视频外，VIP用户还可以享受优惠购买收费视频的特权。在平台上存在一些需要付费才能观看的视频内容，作为VIP会员，您将享受更低的价格购买这些视频。这将大幅度降低您观看高质量视频的成本，并且让您更容易获得您感兴趣的内容。</div><div><br /></div><div>3. 提供独家福利和活动：作为VIP会员，您将定期收到我们为VIP用户定制的独家福利和活动信息。这可能包括观影活动、会员专场等特殊活动，以及一些仅针对VIP会员的限时优惠等。我们将确保您在迈特短剧VIP社区中享有独特的待遇，让您感受到更多的价值和乐趣。</div><div><br /></div><div>4. 快速播放和无广告体验：作为VIP用户，您将享受到更快的视频加载速度和流畅播放的体验。此外，在观看视频过程中，您将不再被冗长的广告打断，让您能够持续沉浸在精彩的内容中，提高观影的舒适度和质量。</div><div><br /></div><div>5. 优先客服支持：作为VIP会员，您的问题和需求将优先得到我们专属的客服团队的支持。无论是关于账号问题、付款疑问还是其他使用上的困惑，我们将竭诚为您提供解答和帮助，以确保您拥有顺畅愉快的使用体验。</div><div><br /></div><div>购买迈特短剧VIP套餐，将为您带来更好的观影体验和更丰富的内容选择。快来加入我们的VIP会员行列，与迈特短剧一同享受精彩的视听盛宴吧！</div></div>', 1690961094, 1701853525, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (43, 3, 8, '积分充值介绍-阿拉伯语', '<div>نقاط الاهتمام في عرض مجموعة من المسرحيات القصيرة :&nbsp;&nbsp;</div><div>&nbsp;1 - جزءا لا يتجزأ من حزمة هو نوع واحد من طريقة شحن منصة يوفر للمستخدمين من خلال شراء جزء لا يتجزأ من حزمة يمكن أن يتمتع المزيد من الخدمات والامتيازات على منصة .&nbsp;&nbsp;</div><div>&nbsp;&nbsp;&nbsp;</div><div>&nbsp;2 - سعر ومحتوى حزمة متكاملة سيتم نشرها على منصة ، يمكن للمستخدمين اختيار حزمة مناسبة وفقا لاحتياجاتها .&nbsp;&nbsp;</div><div>&nbsp;3 - بعد شراء حزمة نقاط ، نقاط سيتم شحنها مباشرة إلى حسابك ، يمكن استخدامها لفتح دفع المحتوى ، المشاركة في السحب ، شراء الهدايا الافتراضية ، وهلم جرا .&nbsp;&nbsp;</div><div>&nbsp;4 . لا يتجزأ حزمة لديها تاريخ انتهاء الصلاحية ، يرجى استخدامها في فترة الصلاحية ، بعد انتهاء الصلاحية لن تكون قادرة على استخدام النقاط المتبقية ، يرجى الانتباه .&nbsp;&nbsp;</div><div>&nbsp;5 - لا يتجزأ حزمة للاستخدام الشخصي فقط ، يحظر نقل أو بيع أو أي شكل آخر من أشكال المعاملات غير المشروعة .&nbsp; &nbsp;مرة واحدة وقد تم العثور على منصة سوف تتخذ التدابير المناسبة للتعامل معها .&nbsp;&nbsp;</div><div>&nbsp;6 - عند استخدام نقاط ، يرجى مراعاة الأحكام ذات الصلة من منصة المستخدم استخدام الاتفاق ، لا تنشر السياسية ، والمواد الإباحية ، والعنف ، وغيرها من المحتوى غير القانوني وغير القانوني .&nbsp;&nbsp;</div><div>&nbsp;7 . إذا كان لديك أي أسئلة أو استفسارات ، يمكنك الاتصال بفريق خدمة العملاء في أي وقت ، وسوف نقوم بالرد عليك في أقرب وقت ممكن والتعامل معها .&nbsp;&nbsp;</div><div>&nbsp;ونحن نتمسك لتزويد المستخدمين مع جودة عالية ، آمنة وموثوق بها خدمة الغرض ، وآمل أن تستمتع تجربة ممتعة على منصة المسرح .&nbsp; &nbsp;شكرا لدعمكم والتفاهم !</div></div>', 1690961645, 1701853521, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (44, 3, 8, '用户协议-阿拉伯语', 'بروتوكول المستخدم&nbsp;&nbsp;<br />&nbsp;مرحبا بكم في استخدام منصة ( المشار إليها فيما يلي باسم \" منصة \" ) !&nbsp; &nbsp;قبل البدء في استخدام هذا البرنامج ، يرجى قراءة بروتوكول المستخدم التالي بعناية .&nbsp; &nbsp;من خلال استخدام هذا المنبر ، فإنك توافق على الالتزام بالشروط والأحكام التالية :&nbsp;&nbsp;<br />&nbsp;&nbsp;&nbsp;<br />&nbsp;1 - مدونة سلوك المستخدم&nbsp;&nbsp;<br />&nbsp;1-1 في استخدام هذا المنبر ، يرجى عدم نشر المحتوى السياسي ، والمواد الإباحية ، والعنف .&nbsp; &nbsp;ونحن نشجع المستخدمين على خلق إيجابية وصحية ومفيدة مسرحيات قصيرة .&nbsp;&nbsp;<br />&nbsp;1-2 المستخدمين بحاجة إلى احترام الحقوق والمصالح المشروعة للآخرين ، لا تستفيد من استخدام منصة للمشاركة في أعمال التعدي على حقوق الآخرين ومصالحهم .&nbsp; &nbsp;بما في ذلك ولكن لا تقتصر على التعدي على حقوق الملكية الفكرية ، والخصوصية ، وهلم جرا .&nbsp;&nbsp;<br />&nbsp;1-3 المستخدمين لا يمكن بأي شكل من الأشكال التدخل أو تعطيل التشغيل العادي من منصة ، بما في ذلك ولكن لا تقتصر على استخدام البرامج الضارة ، والفيروسات وغيرها من الهجمات .&nbsp;&nbsp;<br />&nbsp;2 - خدمات المنابر&nbsp;&nbsp;<br />&nbsp;2-1 هذا البرنامج يوفر للمستخدمين تحميل وتبادل الفيديو وظيفة الدراما القصيرة ، ويسمح للمستخدمين التركيز على بعضها البعض على منصة ، نقطة الثناء والتعليق وغيرها من التبادلات التفاعلية .&nbsp;&nbsp;<br />&nbsp;2-2 عند استخدام هذا البرنامج ، يجب على المستخدمين اتخاذ المخاطر الخاصة بهم ، وضمان أن يتم تحميل المحتوى وفقا للقوانين واللوائح وأحكام هذا الاتفاق .&nbsp; &nbsp;إذا كان المستخدم يخالف القوانين واللوائح أو أحكام هذا الاتفاق ، مما تسبب في نزاع أو مسؤولية ، يجب على المستخدم أن يتحمل المسؤولية القانونية ذات الصلة .&nbsp;&nbsp;<br />&nbsp;2-3 منصة لديها القدرة على زيادة أو نقصان أو تغيير أو إنهاء بعض أو كل محتوى الخدمة حسب الحاجة دون إشعار مسبق من المستخدمين .&nbsp;&nbsp;<br />&nbsp;3 - خصوصية المستخدم&nbsp;&nbsp;<br />&nbsp;3-1 هذا البرنامج سوف تتخذ تدابير أمنية معقولة لحماية أمن المعلومات الشخصية للمستخدمين .&nbsp;&nbsp;<br />&nbsp;3-2 المستخدمين قد تحتاج إلى تقديم بعض المعلومات الشخصية عند استخدام منصة .&nbsp; &nbsp;يجب على المستخدمين التأكد من أن المعلومات الشخصية المقدمة صحيحة ودقيقة ، وتوافق على أن هذا المنبر وفقا للقوانين واللوائح ذات الصلة وسياسات الخصوصية في التعامل مع هذه المعلومات .&nbsp;&nbsp;<br />&nbsp;4 - تنويه&nbsp;&nbsp;<br />&nbsp;4-1 هذا البرنامج لا يضمن صحة ودقة وسلامة المحتوى المستخدم تحميلها .&nbsp;&nbsp;<br />&nbsp;4-2 أي خسارة مباشرة أو غير مباشرة تكبدها المستخدم بسبب استخدام هذا المنبر لن تكون مسؤولة .&nbsp;&nbsp;<br />&nbsp;4-3 أي نزاع ينشأ بين المستخدم وغيرها من المستخدمين في عملية استخدام منصة سيتم تسويتها من قبل الأطراف المعنية ، منصة لا تتحمل أي مسؤولية .&nbsp;&nbsp;<br />&nbsp;5 - حقوق الملكية الفكرية&nbsp;&nbsp;<br />&nbsp;5-1 المستخدمين في استخدام هذا المنبر في عملية خلق دراما فيديو المقابلة حقوق الطبع والنشر .&nbsp;&nbsp;<br />&nbsp;5-2 لا يجوز للمستخدم التعدي على حقوق الملكية الفكرية للآخرين أثناء استخدام منصة .&nbsp;&nbsp;<br />&nbsp;6 - إنهاء الاتفاق&nbsp;&nbsp;<br />&nbsp;6-1 إذا كان المستخدم ينتهك أحكام هذا الاتفاق ، منصة لديها الحق في إنهاء حساب المستخدم ، ويحتفظ بالحق في التحقيق في المسؤولية القانونية للمستخدم .&nbsp;&nbsp;<br />&nbsp;6-2 عند المستخدمين طوعا التوقف عن استخدام هذه الخدمة منصة ، يمكن إنهاء هذا الاتفاق عن طريق تسجيل الخروج من الحساب .&nbsp;&nbsp;<br />&nbsp;7 - تطبيق القانون وتسوية المنازعات&nbsp;&nbsp;<br />&nbsp;7-1 إنشاء ، بدء النفاذ ، وتنفيذ وتفسير هذا الاتفاق تسري على قوانين جمهورية الصين الشعبية .&nbsp;&nbsp;<br />&nbsp;7-2 أي نزاع ينشأ عن أو فيما يتعلق بهذا الاتفاق يسوى عن طريق المشاورات الودية .&nbsp; &nbsp;في حالة عدم التوصل إلى اتفاق ، اتفق الطرفان على إحالة النزاع إلى محكمة الشعب المختصة .&nbsp;&nbsp;<br />&nbsp;يرجى قراءة وفهم بروتوكول المستخدم أعلاه بعناية قبل استخدام هذا البرنامج .&nbsp; &nbsp;إذا كان لديك أي أسئلة حول الاتفاق ، يرجى الاتصال بنا للحصول على مزيد من المعلومات .&nbsp; &nbsp;عند البدء في استخدام هذا البرنامج ، وهذا يعني أن كنت قد قرأت وفهمت ووافقت على الامتثال لأحكام اتفاق المستخدم المذكور أعلاه .&nbsp; &nbsp;شكرا لك على التعاون والدعم !&nbsp;&nbsp;<br />&nbsp;تاريخ آخر تعديل : 02 أغسطس 2023<br /><br />', 1690961958, 1701853516, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (45, 3, 9, '联系我们-越南语', '<p><img src=\"https://mettchat.oss-accelerate.aliyuncs.com/mettgpt/20230715/256ff266c49826078ae524b8fed6b51a.png\" alt=\"\" /></p>', 1582259738, 1701853510, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (46, 3, 9, '隐私政策-越南语', 'Thỏa thuận bảo mật ngắn của METHER<br />Chào mừng bạn đến với bộ phim ngắn của METER (sau đây gọi là \"Phần mềm này\"). Phần mềm này rất coi trọng việc bảo vệ quyền riêng tư của người dùng và Thỏa thuận bảo mật này nhằm giải thích cho người dùng cách phần mềm này thu thập, sử dụng, lưu trữ và bảo vệ thông tin cá nhân của người dùng. Vui lòng đọc kỹ Thỏa thuận bảo mật này trước khi sử dụng phần mềm. Không sử dụng phần mềm này nếu bạn không đồng ý với bất kỳ điều gì trong Thỏa thuận bảo mật này.<br />I. Thu thập thông tin<br />1. Phần mềm không chủ động thu thập bất kỳ thông tin cá nhân nào của người dùng, bao gồm nhưng không giới hạn ở tên, số ID, số điện thoại, địa chỉ email, v.v.<br />2. Khi người dùng sử dụng phần mềm, phần mềm có thể tự động thu thập một số thông tin kỹ thuật, bao gồm nhưng không giới hạn ở thông tin thiết bị của người dùng, phiên bản hệ điều hành, trạng thái mạng, địa chỉ IP, v.v.<br />3. Phần mềm có thể sử dụng các dịch vụ của bên thứ ba, chẳng hạn như dịch vụ quảng cáo, dịch vụ phân tích thống kê, v.v., có thể thu thập một số thông tin về người dùng, nhưng phần mềm không chủ động cung cấp bất kỳ thông tin cá nhân nào của người dùng cho các dịch vụ của bên thứ ba.<br />II. Sử dụng thông tin<br />1. Thông tin kỹ thuật được thu thập bởi phần mềm này chỉ được sử dụng để cải thiện chất lượng dịch vụ của phần mềm này, chẳng hạn như tối ưu hóa thuật toán, cải thiện khả năng nhận dạng thông minh, v.v.<br />2. Phần mềm không sử dụng bất kỳ thông tin cá nhân nào của người dùng cho mục đích thương mại hoặc bán, cho thuê, chia sẻ hoặc trao đổi bất kỳ thông tin cá nhân nào của người dùng cho bất kỳ bên thứ ba nào.<br />III. Lưu trữ và bảo vệ thông tin<br />1. Thông tin kỹ thuật được thu thập bởi phần mềm này sẽ được lưu trữ trên máy chủ của phần mềm này và phần mềm sẽ thực hiện các biện pháp bảo mật hợp lý để bảo vệ thông tin của người dùng khỏi bị thu thập, sử dụng hoặc tiết lộ bất hợp pháp.<br />2. Phần mềm sẽ thực hiện các biện pháp hợp lý để bảo vệ thông tin của người dùng khỏi vô tình bị xóa hoặc hư hỏng.<br />IV. Công bố thông tin<br />1. Phần mềm sẽ không tiết lộ bất kỳ thông tin cá nhân nào của người dùng cho bất kỳ bên thứ ba nào, trừ khi được ủy quyền rõ ràng bởi người dùng hoặc theo quy định của pháp luật.<br />2. Phần mềm có quyền tiết lộ thông tin cá nhân của người dùng cho các cơ quan có liên quan trong trường hợp người dùng vi phạm quy định sử dụng phần mềm hoặc luật pháp và quy định.<br />V. Bảo vệ thông tin trẻ vị thành niên<br />1. Phần mềm này rất coi trọng việc bảo vệ thông tin cho trẻ vị thành niên và trẻ vị thành niên nên sử dụng phần mềm này theo hướng dẫn của cha mẹ hoặc người giám hộ.<br />2. Phần mềm không chủ động thu thập bất kỳ thông tin cá nhân nào của trẻ vị thành niên, chẳng hạn như cha mẹ hoặc người giám hộ của trẻ vị thành niên phát hiện ra rằng thông tin cá nhân của trẻ vị thành niên đã bị xâm phạm, vui lòng liên hệ với nhà phát triển phần mềm ngay lập tức<br />VI. Khác<br />Việc giải thích, áp dụng và giải quyết tranh chấp của Thỏa thuận về Quyền riêng tư này áp dụng luật pháp của Cộng hòa Nhân dân Trung Hoa và được điều chỉnh bởi Tòa án Nhân dân tại nơi đặt nhà phát triển phần mềm này.<br />2. Vui lòng liên hệ với nhà phát triển phần mềm này với bất kỳ câu hỏi hoặc ý kiến nào.<br />Quyền giải thích cuối cùng về Thỏa thuận bảo mật này thuộc về nhà phát triển phần mềm này.<br />', 1582259745, 1701853505, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (47, 3, 9, '关于我们-越南语', '<p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><span style=\"text-align:center;white-space:normal;\">官方公众号</span></p><p><img src=\"https://mettchat.oss-accelerate.aliyuncs.com/mettgpt/20230715/256ff266c49826078ae524b8fed6b51a.png\" alt=\"\" /></p>', 1582259745, 1701853499, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (48, 3, 9, '法律声明-越南语', '<div style=\"text-align:center;\">Thông báo pháp lý ngắn gọn của METER<br />Chào mừng bạn đến với bộ phim ngắn của METER (sau đây gọi là \"Phần mềm này\"). Phần mềm này là một trợ lý thông minh dựa trên công nghệ AI được thiết kế để cung cấp cho người dùng các dịch vụ thuận tiện và hiệu quả hơn. Vui lòng đọc kỹ Tuyên bố này trước khi sử dụng phần mềm. Không sử dụng phần mềm này nếu bạn không đồng ý với bất kỳ điều gì trong Tuyên bố này.<br />I. Tuyên bố sở hữu trí tuệ<br />Quyền sở hữu, quyền sở hữu trí tuệ, công nghệ liên quan và tất cả nội dung của Phần mềm (bao gồm nhưng không giới hạn ở văn bản, hình ảnh, âm thanh, video, phần mềm, chương trình, mã, thiết kế giao diện, dữ liệu, v.v.) thuộc sở hữu của nhà phát triển hoặc chủ sở hữu quyền liên quan của Phần mềm.<br />Không ai có thể sao chép, phổ biến, hiển thị, sửa đổi, bán, chuyển nhượng, phân phối hoặc khai thác bất kỳ nội dung nào của phần mềm này dưới bất kỳ hình thức nào mà không có sự cho phép bằng văn bản của nhà phát triển phần mềm hoặc người có quyền liên quan.<br />Bất kỳ hành vi trái phép nào cũng có thể cấu thành vi phạm quyền sở hữu trí tuệ của nhà phát triển phần mềm này hoặc các bên có quyền liên quan và sẽ chịu trách nhiệm pháp lý tương ứng.<br />II. Tuyên bố miễn trừ trách nhiệm<br />Phần mềm này chỉ cung cấp các dịch vụ trợ lý thông minh và không chịu trách nhiệm về kết quả của việc sử dụng Phần mềm của Người dùng.<br />Phần mềm này không chịu trách nhiệm về bất kỳ tổn thất hoặc thiệt hại nào trong quá trình sử dụng Phần mềm của Người dùng, bao gồm nhưng không giới hạn ở việc mất dữ liệu do sử dụng Phần mềm, sự cố hệ thống máy tính, gián đoạn mạng, v.v.<br />Phần mềm này không chịu trách nhiệm cho bất kỳ hành vi nào của người dùng trong quá trình sử dụng Phần mềm, bao gồm nhưng không giới hạn ở các hành vi vi phạm pháp luật phát sinh từ việc sử dụng Phần mềm, vi phạm quyền và lợi ích của người khác, v.v.<br />Phần mềm này sẽ không chịu bất kỳ trách nhiệm pháp lý nào đối với người dùng đối với bất kỳ phần mềm hoặc dịch vụ nào của bên thứ ba trong quá trình sử dụng Phần mềm này, bao gồm nhưng không giới hạn ở bất kỳ tổn thất hoặc thiệt hại nào phát sinh từ việc sử dụng Phần mềm hoặc Dịch vụ của bên thứ ba.<br />Phần mềm này không chịu trách nhiệm về bất kỳ vấn đề kỹ thuật nào trong quá trình sử dụng Phần mềm của Người dùng, bao gồm nhưng không giới hạn ở virus máy tính, hack, v.v. phát sinh từ việc sử dụng Phần mềm.<br />III. Thông báo bảo vệ quyền riêng tư<br />Phần mềm này sẽ bảo vệ nghiêm ngặt quyền riêng tư của người dùng và sẽ không thu thập, lưu trữ, sử dụng bất kỳ thông tin cá nhân nào của người dùng trừ khi người dùng tự nguyện cung cấp.<br />Thông tin cá nhân do người dùng tự nguyện cung cấp, phần mềm này sẽ được bảo mật nghiêm ngặt và sẽ không được tiết lộ cho bất kỳ bên thứ ba nào trừ khi được người dùng ủy quyền rõ ràng hoặc theo quy định của pháp luật.<br />Phần mềm này sẽ thực hiện các biện pháp bảo mật hợp lý để bảo vệ thông tin cá nhân của người dùng khỏi bị thu thập, sử dụng hoặc tiết lộ bất hợp pháp.<br />IV. Tuyên bố khác<br />Nhà phát triển phần mềm này có quyền sửa đổi bất kỳ nội dung nào của Tuyên bố này bất cứ lúc nào và Tuyên bố sửa đổi sẽ được công bố trên Phần mềm này và người dùng sẽ theo dõi và tuân thủ kịp thời.<br />Việc giải thích, áp dụng và giải quyết tranh chấp của Tuyên bố này áp dụng luật pháp của Cộng hòa Nhân dân Trung Hoa và được điều chỉnh bởi Tòa án Nhân dân tại nơi đặt nhà phát triển phần mềm này.<br />Vui lòng liên hệ với nhà phát triển phần mềm này với bất kỳ câu hỏi hoặc nhận xét nào.<br />Quyền giải thích cuối cùng của Tuyên bố này thuộc về nhà phát triển phần mềm này.<br /><br /></div>', 1683768542, 1701853494, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (49, 3, 9, '分销介绍-越南语', 'Làm thế nào để kiếm tiền với công cụ này?<br />Sau khi xin làm nhà phân phối có thể tiến hành mở rộng nghiệp vụ, tiền hoa hồng mở rộng căn cứ vào đẳng cấp nhà phân phối của mình tiến hành phân nhuận.<br />Sau khi thăng cấp thành nhà phân phối, nếu muốn thăng cấp cần mua lại toàn giá.<br />Nếu nhà phân phối mở không phải là vĩnh viễn, mở lại nhà phân phối cùng cấp thì tiến hành cộng dồn thời gian.<br />Nếu cấp độ nhà phân phối mở và hiện tại không phù hợp, cấp độ và thời gian sẽ được đặt lại.<br />Hàng hóa ảo không được hoàn lại tiền ngay khi chúng được nạp đầy.<br />', 1685204309, 1701853489, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (50, 3, 9, 'VIP会员权益-越南语', 'Cảm ơn bạn đã chọn gói VIP Short Drama của chúng tôi, dịch vụ thành viên cao cấp dành cho người dùng của chúng tôi. Là người dùng VIP, bạn sẽ được hưởng các ưu đãi và ưu đãi sau:<br />1. Xem video VIP miễn phí: Là thành viên VIP, bạn sẽ xem tất cả nội dung video có nhãn VIP miễn phí. Những video này thường là một số nội dung độc quyền, chất lượng cao, bao gồm các bộ phim nổi tiếng, phim truyền hình, chương trình tạp kỹ và nhiều hơn nữa. Bạn có thể tận hưởng những nội dung tuyệt vời này mà không phải trả thêm chi phí.<br />2. Ưu đãi mua video thu phí: Ngoài việc xem video VIP miễn phí, người dùng VIP còn có thể hưởng ưu đãi mua video thu phí. Có một số nội dung video trên nền tảng yêu cầu thanh toán để xem và là thành viên VIP, bạn sẽ được hưởng mức giá thấp hơn để mua chúng. Điều này sẽ làm giảm đáng kể chi phí xem video chất lượng cao và giúp bạn dễ dàng có được nội dung mà bạn quan tâm.<br />3. Cung cấp các lợi ích và sự kiện độc quyền: Là thành viên VIP, bạn sẽ thường xuyên nhận được thông tin về các lợi ích và sự kiện độc quyền mà chúng tôi tùy chỉnh cho người dùng VIP của mình. Điều này có thể bao gồm các hoạt động đặc biệt như xem phim, hội viên chuyên nghiệp, cùng với một số ưu đãi giới hạn chỉ dành cho hội viên VIP. Chúng tôi sẽ đảm bảo rằng bạn được đối xử độc đáo trong cộng đồng VIP Short Play của MET, nơi bạn cảm thấy có giá trị và niềm vui hơn.<br />4. Chơi nhanh và trải nghiệm không có quảng cáo: Là người dùng VIP, bạn sẽ tận hưởng tốc độ tải video nhanh hơn và trải nghiệm chơi mượt mà. Ngoài ra, bạn sẽ không còn bị gián đoạn bởi các quảng cáo dài trong khi xem video, cho phép bạn liên tục đắm mình trong nội dung tuyệt vời và cải thiện sự thoải mái và chất lượng xem.<br />5. Hỗ trợ dịch vụ khách hàng ưu tiên: Là thành viên VIP, vấn đề và nhu cầu của bạn sẽ được ưu tiên nhận được sự hỗ trợ của đội ngũ dịch vụ khách hàng chuyên dụng của chúng tôi. Bất kể là vấn đề tài khoản, vấn đề thanh toán hay là bối rối trong sử dụng khác, chúng tôi sẽ hết sức chân thành cung cấp câu trả lời và trợ giúp cho bạn, để đảm bảo bạn có trải nghiệm sử dụng thuận lợi vui vẻ.<br />Mua gói VIP phim ngắn của METER sẽ mang đến cho bạn trải nghiệm xem phim tốt hơn và lựa chọn nội dung phong phú hơn. Hãy đến và tham gia cùng các thành viên VIP của chúng tôi để thưởng thức một bữa tiệc nghe nhìn tuyệt vời với bộ phim ngắn của MET!<br /><br />', 1690961094, 1701853485, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (51, 3, 9, '积分充值介绍-越南语', '<div>Giới thiệu những điều cần lưu ý về phần ăn ngắn của Mại Đặc:</div><div>1. Gói điểm tích lũy là một phương thức nạp tiền mà nền tảng kịch ngắn Mai Đặc cung cấp cho người dùng, thông qua mua gói điểm tích lũy có thể hưởng thụ nhiều dịch vụ và đặc quyền hơn trên nền tảng.</div><div>2. Giá cả và nội dung của phần ăn điểm tích lũy sẽ được công bố trên nền tảng, người dùng có thể lựa chọn phần ăn thích hợp theo nhu cầu của mình.</div><div>3. Sau khi mua gói điểm, điểm sẽ được nạp trực tiếp vào tài khoản của bạn và có thể được sử dụng để mở khóa nội dung trả tiền, tham gia rút thăm trúng thưởng, mua quà ảo, v.v.</div><div>4. Gói điểm tích lũy có thời hạn có hiệu lực nhất định, xin vui lòng sử dụng trong thời hạn có hiệu lực, sau khi hết hạn sẽ không thể sử dụng điểm tích lũy còn lại, xin vui lòng lưu ý.</div><div>5. Gói điểm chỉ dành cho sử dụng cá nhân và bị cấm chuyển nhượng, bán hoặc giao dịch bất hợp pháp dưới hình thức khác. Một khi được phát hiện, nền tảng sẽ thực hiện các biện pháp xử lý tương ứng.</div><div>6. Khi sử dụng điểm, xin vui lòng tuân thủ các quy định liên quan của nền tảng và thỏa thuận sử dụng của người dùng, không đăng tải nội dung bất hợp pháp, vi phạm liên quan đến chính trị, khiêu dâm, bạo lực.</div><div>7. Bất kỳ câu hỏi hoặc câu hỏi, bạn có thể liên hệ với đội ngũ dịch vụ khách hàng của chúng tôi bất cứ lúc nào, chúng tôi sẽ trả lời và xử lý cho bạn càng sớm càng tốt.</div><div>Chúng tôi tôn trọng tôn chỉ cung cấp dịch vụ chất lượng cao, an toàn và đáng tin cậy cho người dùng, hy vọng bạn có thể tận hưởng trải nghiệm sử dụng vui vẻ trên nền tảng kịch ngắn Mai Đặc. Cảm ơn sự ủng hộ và thông cảm của ông!</div></div>', 1690961645, 1701853727, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (52, 3, 9, '用户协议-越南语', 'Thỏa thuận người dùng cho phim ngắn<br />Chào mừng bạn đến với nền tảng kịch ngắn của MET (sau đây gọi là \"Nền tảng này\")! Trước khi bạn bắt đầu sử dụng nền tảng này, vui lòng đọc kỹ Thỏa thuận người dùng bên dưới. Bằng cách sử dụng nền tảng này, bạn đồng ý tuân thủ các điều khoản và điều kiện sau:<br />1. Quy tắc hành vi người dùng<br />1.1 Trong quá trình sử dụng nền tảng này, không đăng nội dung liên quan đến chính trị, khiêu dâm và bạo lực. Chúng tôi khuyến khích người dùng tạo nội dung ngắn tích cực, lành mạnh và hữu ích.<br />1.2 Người dùng cần tôn trọng quyền và lợi ích hợp pháp của người khác và không được sử dụng Nền tảng này để thực hiện các hành vi xâm phạm quyền và lợi ích của người khác. Bao gồm nhưng không giới hạn ở việc xâm phạm quyền sở hữu trí tuệ, quyền riêng tư của người khác.<br />1.3 Người dùng không được can thiệp hoặc làm gián đoạn hoạt động bình thường của Nền tảng dưới bất kỳ hình thức nào, bao gồm nhưng không giới hạn ở việc sử dụng các chương trình độc hại, virus, v.v.<br />2. Dịch vụ nền tảng<br />2,1. Nền tảng này cung cấp chức năng tải lên, chia sẻ video ngắn của người dùng và cho phép người dùng quan tâm, like, bình luận và tương tác với nhau trên nền tảng.<br />2.2 Người dùng phải tự chịu rủi ro khi sử dụng Nền tảng và đảm bảo rằng Nội dung được tải lên tuân thủ luật pháp và quy định và các quy định của Thỏa thuận này. Trong trường hợp xảy ra tranh chấp hoặc phát sinh trách nhiệm pháp lý do Người dùng vi phạm pháp luật và quy định hoặc các quy định của Thỏa thuận này, Người dùng sẽ tự chịu trách nhiệm pháp lý tương ứng.<br />2.3 Nền tảng này có quyền tăng, giảm, thay đổi hoặc chấm dứt một số hoặc tất cả Nội dung Dịch vụ khi cần thiết mà không cần thông báo trước cho Người dùng.<br />3. Quyền riêng tư của người dùng<br />3.1 Nền tảng này sẽ thực hiện các biện pháp bảo mật hợp lý để bảo vệ sự an toàn của thông tin cá nhân của người dùng.<br />3.2 Người dùng có thể được yêu cầu cung cấp một số thông tin cá nhân khi sử dụng Nền tảng này. Người dùng phải đảm bảo rằng thông tin cá nhân được cung cấp là trung thực và chính xác và đồng ý với việc Nền tảng xử lý thông tin này theo các quy định của pháp luật và chính sách bảo mật có liên quan.<br />4. Tuyên bố miễn trừ trách nhiệm<br />4.1 Nền tảng này không đảm bảo tính chân thực, chính xác và đầy đủ của nội dung do người dùng tải lên.<br />4.2 Người dùng không chịu trách nhiệm về bất kỳ tổn thất trực tiếp hoặc gián tiếp nào do việc sử dụng Nền tảng này.<br />4.3 Tranh chấp phát sinh giữa Người dùng và Người dùng khác trong quá trình sử dụng Nền tảng được giải quyết bởi các bên liên quan và Nền tảng không chịu trách nhiệm.<br />5. Sở hữu trí tuệ<br />5.1 Người dùng có bản quyền tương ứng đối với các video ngắn được tạo ra trong quá trình sử dụng Nền tảng này.<br />5.2 Người dùng không được vi phạm quyền sở hữu trí tuệ của người khác trong quá trình sử dụng Nền tảng này.<br />6. Chấm dứt thỏa thuận<br />6.1 Người dùng vi phạm các quy định của Thỏa thuận này, Nền tảng có quyền chấm dứt tài khoản của Người dùng và giữ quyền truy cứu trách nhiệm pháp lý của Người dùng.<br />6.2 Người dùng có thể chấm dứt Thỏa thuận này bằng cách hủy tài khoản khi họ tự nguyện ngừng sử dụng Dịch vụ của Nền tảng này.<br />7. Áp dụng pháp luật và giải quyết tranh chấp<br />7.1 Việc thành lập, có hiệu lực, thực hiện và giải thích Hiệp định này, áp dụng cho pháp luật của Cộng hòa Nhân dân Trung Hoa.<br />7.2 Các tranh chấp phát sinh từ hoặc liên quan đến Hiệp định này sẽ được giải quyết thông qua tham vấn thân thiện; Khi thương lượng không thành công, hai bên đồng ý đưa tranh chấp ra Tòa án nhân dân có thẩm quyền giải quyết.<br />Vui lòng đọc kỹ và hiểu Thỏa thuận người dùng ở trên trước khi sử dụng nền tảng này. Nếu bạn có bất cứ câu hỏi nào về nội dung thỏa thuận, xin vui lòng liên hệ với chúng tôi kịp thời để điều tra. Khi bạn bắt đầu sử dụng nền tảng này, bạn có nghĩa là bạn đã đọc, hiểu và đồng ý tuân thủ các điều khoản của Thỏa thuận người dùng ở trên. Cảm ơn sự hợp tác và hỗ trợ của bạn!<br />Sửa đổi lần cuối 02/08/2023<br /><br />', 1690961958, 1701853722, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (53, 3, 4, '联系我们-中文繁体', '<p><img src=\"https://mettchat.oss-accelerate.aliyuncs.com/mettgpt/20230715/256ff266c49826078ae524b8fed6b51a.png\" alt=\"\" /></p>', 1582259738, 1701853470, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (54, 3, 4, '隐私政策-中文繁体', '邁特短劇隱私協定<br />歡迎使用邁特短劇（以下簡稱“本軟件”）。 本軟件非常重視用戶的隱私保護，本隱私協議旨在向用戶說明本軟件如何收集、使用、存儲和保護用戶的個人資訊。 在使用本軟件前，請您仔細閱讀本隱私協定。 如果您不同意本隱私協定的任何內容，請勿使用本軟件。<br />一、資訊收集<br />1.本軟件不會主動收集用戶的任何個人資訊，包括但不限於姓名、身份證號、電話號碼、電子郵寄地址等。<br />2.當用戶使用本軟件時，本軟件可能會自動收集一些科技資訊，包括但不限於用戶的設備資訊、作業系統版本、網絡狀態、IP地址等。<br />3.本軟件可能會使用協力廠商服務，如廣告服務、統計分析服務等，這些服務可能會收集用戶的一些資訊，但本軟件不會主動向協力廠商服務提供用戶的任何個人資訊。<br />二、資訊使用<br />1.本軟件收集的科技資訊僅用於改善本軟件的服務質量，如優化算灋、提高智慧識別能力等。<br />2.本軟件不會將用戶的任何個人資訊用於商業目的，也不會向任何協力廠商出售、出租、分享或交換用戶的任何個人資訊。<br />三、資訊存儲和保護<br />1.本軟件收集的科技資訊將存儲在本軟件的服務器上，本軟件將採取合理的安全措施，保護用戶的資訊不被非法獲取、使用或洩露。<br />2.本軟件將採取合理的措施，保護用戶的資訊不被意外删除或損壞。<br />四、資訊披露<br />1.本軟件不會向任何協力廠商披露用戶的任何個人資訊，除非經過用戶的明確授權或法律規定。<br />2.如用戶違反本軟件的使用規定或法律法規，本軟件有權向相關部門披露用戶的個人資訊。<br />五、未成年人資訊保護<br />1.本軟件非常重視未成年人的資訊保護，未成年人應在父母或監護人的指導下使用本軟件。<br />2.本軟件不會主動收集未成年人的任何個人資訊，如未成年人的父母或監護人發現未成年人的個人資訊被洩露，請立即聯系本軟體發展<br />六、其他<br />1.本隱私協定的解釋、適用及爭議解决均適用中華人民共和國法律，並由本軟件開發者所在地的人民法院管轄。<br />2.如有任何問題或意見，請聯系本軟件開發者。<br />本隱私協定的最終解釋權歸本軟件開發者所有。<br />', 1582259745, 1701853466, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (55, 3, 4, '关于我们-中文繁体', '<p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><br /></p><p style=\"text-align:center;\"><span style=\"text-align:center;white-space:normal;\">官方公众号</span></p><p><img src=\"https://mettchat.oss-accelerate.aliyuncs.com/mettgpt/20230715/256ff266c49826078ae524b8fed6b51a.png\" alt=\"\" /></p>', 1582259745, 1701853462, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (56, 3, 4, '法律声明-中文繁体', '邁特短劇法律聲明<br />歡迎使用邁特短劇（以下簡稱“本軟件”）。 本軟件是一款基於人工智慧科技的智能助手，旨在為用戶提供更加便捷、高效的服務。 在使用本軟件前，請您仔細閱讀本聲明。 如果您不同意本聲明的任何內容，請勿使用本軟件。<br /><br />一、知識產權聲明<br />本軟件的所有權、知識產權、相關科技及所有內容（包括但不限於文字、圖片、音訊、視頻、軟件、程式、程式碼、介面設計、數據等）均歸屬於本軟件的開發者或相關權利人所有。<br />未經本軟件開發者或相關權利人的書面授權，任何人不得以任何形式複製、傳播、展示、修改、出售、轉讓、發行或利用本軟件的任何內容。<br />任何未經授權的行為均可能構成侵犯本軟件開發者或相關權利人的知識產權，將承擔相應的法律責任。<br />二、免責聲明<br />本軟件僅提供智能助手服務，不對用戶使用本軟件的結果承擔任何責任。<br />本軟件不對用戶使用本軟件過程中的任何損失或損害承擔任何責任，包括但不限於因使用本軟件而導致的資料丟失、電腦系統崩潰、網絡中斷等。<br />本軟件不對用戶使用本軟件過程中的任何行為承擔任何責任，包括但不限於因使用本軟件而導致的違法行為、侵犯他人權益等。<br />本軟件不對用戶使用本軟件過程中的任何協力廠商軟件或服務承擔任何責任，包括但不限於因使用協力廠商軟件或服務而導致的任何損失或損害。<br />本軟件不對用戶使用本軟件過程中的任何科技問題承擔任何責任，包括但不限於因使用本軟件而導致的電腦病毒、駭客攻擊等。<br />三、隱私保護聲明<br />本軟件將嚴格保護用戶的隱私，不會收集、存儲、使用用戶的任何個人資訊，除非用戶自願提供。<br />用戶自願提供的個人資訊，本軟件將嚴格保密，不會洩露給任何協力廠商，除非經過用戶的明確授權或法律規定。<br />本軟件將採取合理的安全措施，保護用戶的個人資訊不被非法獲取、使用或洩露。<br />四、其他聲明<br />本軟件開發者有權隨時修改本聲明的任何內容，修改後的聲明將在本軟件上公佈，用戶應及時關注並遵守。<br />本聲明的解釋、適用及爭議解决均適用中華人民共和國法律，並由本軟件開發者所在地的人民法院管轄。<br />如有任何問題或意見，請聯系本軟件開發者。<br />本聲明的最終解釋權歸本軟件開發者所有。<br />', 1683768542, 1701853442, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (57, 3, 4, '分销介绍-中文繁体', '<p><span style=\"font-size:18px;\"><b>如何利用此工具賺錢？<br /></b><br /><span style=\"font-size:16px;\">1.申請為分銷商之後可進行業務推廣，推廣的傭金根據自己的分銷商等級進行分潤。</span><br /><span style=\"font-size:16px;\">2.陞級為分銷商之後，若想陞級需重新全價購買。</span><br /><span style=\"font-size:16px;\">3.如果開通的分銷商為非永久時，再次開通同級別的分銷商則進行時間的累加。</span><br /><span style=\"font-size:16px;\">4.如果開通的分銷商等級和當前不一致時，則會重置等級和時間。</span><br /><span style=\"font-size:16px;\">虛擬商品一經充值，不予退款。</span></span></p><p><br /></p>', 1685204309, 1701853435, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (58, 3, 4, 'VIP会员权益-中文繁体', '<div>感謝您選擇邁特短劇VIP套餐，這是我們為用戶提供的高級會員服務。 作為VIP用戶，您將享受以下特權和優惠：<br />1.免費觀看VIP視頻：作為VIP會員，您將免費觀看所有標注為VIP的視頻內容。 這些視頻通常是一些獨家、高品質的內容，包括熱門電影、電視劇、綜藝節目等。 您可以盡情暢享這些精彩內容，無需再額外支付費用。<br />2.優惠購買收費視頻：除了免費觀看VIP視頻外，VIP用戶還可以享受優惠購買收費視頻的特權。 在平臺上存在一些需要付費才能觀看的視頻內容，作為VIP會員，您將享受更低的價格購買這些視頻。 這將大幅度降低您觀看高品質視頻的成本，並且讓您更容易獲得您感興趣的內容。<br />3.提供獨家福利和活動：作為VIP會員，您將定期收到我們為VIP用戶定制的獨家福利和活動資訊。 這可能包括觀影活動、會員專場等特殊活動，以及一些僅針對VIP會員的限時優惠等。 我們將確保您在邁特短劇VIP社區中享有獨特的待遇，讓您感受到更多的價值和樂趣。<br />4.快速播放和無廣告體驗：作為VIP用戶，您將享受到更快的視頻加載速度和流暢播放的體驗。 此外，在觀看視頻過程中，您將不再被冗長的廣告打斷，讓您能够持續沉浸在精彩的內容中，提高觀影的舒適度和質量。<br />5.優先客服支持：作為VIP會員，您的問題和需求將優先得到我們專屬的客服團隊的支持。 無論是關於帳號問題、付款疑問還是其他使用上的困惑，我們將竭誠為您提供解答和幫助，以確保您擁有順暢愉快的使用體驗。<br />購買邁特短劇VIP套餐，將為您帶來更好的觀影體驗和更豐富的內容選擇。 快來加入我們的VIP會員行列，與邁特短劇一同享受精彩的視聽盛宴吧！<br /></div><div></div>', 1690961094, 1701853425, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (59, 3, 4, '积分充值介绍-中文繁体', '邁特短劇積分套餐介紹注意事項：<br />1.積分套餐是邁特短劇平臺為用戶提供的一種充值管道，通過購買積分套餐可以在平臺上享受更多的服務和特權。<br />2.積分套餐的價格和內容會在平臺上進行公示，用戶可以根據自己的需求選擇適合的套餐。<br />3.購買積分套餐後，積分將直接充值到您的帳戶中，可以用於解鎖付費內容、參加抽獎活動、購買虛擬禮物等。<br />4.積分套餐具有一定的有效期，請在有效期內使用，過期後將無法使用剩餘積分，敬請留意。<br />5.積分套餐僅限個人使用，禁止轉讓、出售或以其他形式進行非法交易。 一經發現，平臺將採取相應的處理措施。<br />6.在使用積分時，請遵守平臺的相關規定和用戶使用協定，不要發佈涉及政治、色情、暴力等違法、違規內容。<br />7.如有任何問題或疑問，您可以隨時聯繫我們的客服團隊，我們將儘快為您解答和處理。<br />我們秉承為用戶提供高品質、安全可靠的服務的宗旨，希望您在邁特短劇平臺上享受到愉快的使用體驗。 感謝您的支持與理解！<br /><br />', 1690961645, 1701853419, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (60, 3, 4, '用户协议-中文繁体', '<div>邁特短劇使用者協定</div><div>歡迎使用邁特短劇平臺（以下簡稱“本平臺”）！ 在您開始使用本平臺之前，請仔細閱讀以下的使用者協定。 通過使用本平臺，即表示您同意遵守以下條款和條件：</div><div>1.用戶行為規範</div><div>1.1在使用本平臺的過程中，請勿發佈與政治、色情、暴力相關的內容。 我們鼓勵用戶創作積極、健康、有益的短劇內容。</div><div>1.2用戶需要尊重他人的合法權益，不得利用本平臺從事侵犯他人權益的行為。 包括但不限於侵犯他人知識產權、隱私權等。</div><div>1.3用戶不得以任何形式干擾或破壞本平臺的正常運行，包括但不限於使用惡意程式、病毒等進行攻擊。</div><div>2.平臺服務</div><div>2.1本平臺提供用戶上傳、分享短劇視頻的功能，並允許用戶在平臺上互相關注、點贊、評論等交流互動。</div><div>2.2用戶在使用本平臺時，應自行承擔風險，並確保所上傳的內容符合法律法規和本協定的規定。 如因用戶違反法律法規或本協定的規定，而引發糾紛或產生責任，用戶應自行承擔相應的法律責任。</div><div>2.3本平臺有權根據需要新增、减少、更改或終止部分或全部服務內容，並無需提前通知用戶。</div><div>3.用戶隱私</div><div>3.1本平臺將採取合理的安全措施，保護用戶的個人資訊安全。</div><div>3.2用戶在使用本平臺時，可能需要提供一些個人資訊。 用戶需保證所提供的個人資訊真實、準確，且同意本平臺按照相關法律法規及隱私政策的規定處理這些資訊。</div><div>4.免責聲明</div><div>4.1本平臺不對用戶上傳的內容的真實性、準確性、完整性進行擔保。</div><div>4.2用戶因使用本平臺而遭受到的任何直接或間接損失，本平臺不承擔責任。</div><div>4.3用戶在使用本平臺過程中與其他用戶之間發生的爭議，由相關當事人自行解决，本平臺不承擔任何責任。</div><div>5.知識產權</div><div>5.1用戶在使用本平臺過程中創作的短劇視頻享有相應的著作權。</div><div>5.2用戶在使用本平臺過程中，不得侵犯他人的知識產權。</div><div>6.終止協定</div><div>6.1用戶違反本協議規定的，本平臺有權終止用戶的帳號，並保留追究用戶法律責任的權利。</div><div>6.2用戶自願停止使用本平臺的服務時，可以通過註銷帳號等管道終止本協定。</div><div>7.法律適用與爭議解决</div><div>7.1本協定的成立、生效、履行和解釋，適用於中華人民共和國法律。</div><div>7.2因本協定引起的或與本協定有關的爭議，應通過友好協商解决； 協商不成時，雙方同意將爭議提交有管轄權的人民法院解决。</div><div>請您在使用本平臺之前，仔細閱讀並理解以上的使用者協定。 如您對協定內容有任何疑問，請及時聯繫我們査詢。 當您開始使用本平臺時，即表示您已閱讀、理解並同意遵守上述使用者協定的規定。 感謝您的合作與支持！</div><div>最後修訂日期：2023年08月02日</div></div>', 1690961958, 1701851647, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (61, 3, 1, '电子邮件中文简版', '<div>\r\n  <includetail>\r\n    <div align=\"center\">\r\n      <div class=\"open_email\" style=\"margin-left:8px;margin-top:8px;margin-bottom:8px;margin-right:8px;\">\r\n        <div>\r\n          <br /> <span class=\"genEmailContent\"> <div id=\"cTMail-Wrap\" style=\"word-break:break-all;box-sizing:border-box;text-align:center;min-width:320px;max-width:660px;border:1px solid #f6f6f6;background-color:#f7f8fa;margin:auto;padding:20px 0 10px;font-family:\'helvetica neue\',PingFangSC-Light,arial,\'hiragino sans gb\',\'microsoft yahei ui\',\'microsoft yahei\',simsun,sans-serif;\">\r\n                    <div class=\"main-content\">\r\n                        <table style=\"width:100%;font-weight:300;margin-bottom:10px;border-collapse:collapse;\">\r\n                            <tbody>\r\n                            <tr style=\"font-weight:300;\">\r\n                                <td style=\"width:3%;max-width:30px;\"></td>\r\n                                <td style=\"max-width:600px;\">\r\n                                    <!-- LOGO -->\r\n                                    <div id=\"cTMail-logo\" style=\"width:92px;height:25px;\">\r\n                                        <!-- 替换跳转链接 --> <a href=\"{domain}\"> <!-- 替换LOGO图片 --> <img border=\"0\" src=\"{logo}\" style=\"width:92px;height:25px;display:block;\" /> </a> </div>\r\n                                    <!-- 页面上边的蓝色分割线 -->\r\n                                    <p style=\"height:2px;background-color:#00a4ff;border:0;font-size:0;padding:0;width:100%;margin-top:20px;\"><br /></p>\r\n                                    <div id=\"cTMail-inner\" style=\"background-color:#fff;padding:23px 0 20px;box-shadow:0px 1px 1px 0px rgba(122, 55, 55, 0.2);text-align:left;\">\r\n                                        <table style=\"width:100%;font-weight:300;margin-bottom:10px;border-collapse:collapse;text-align:left;\">\r\n                                            <tbody>\r\n                                            <!-- 第一个单元格 -->\r\n                                            <tr style=\"font-weight:300;\">\r\n                                                <!-- 左侧表格，设置左边距用的 -->\r\n                                                <td style=\"width:3.2%;max-width:30px;\"></td>\r\n                                                <!-- 中间表格，正文使用 -->\r\n                                                <td style=\"max-width:480px;text-align:left;\">\r\n                                                    <!-- 以下是正文 -->\r\n                                                    <!-- 可以是标题 -->\r\n                                                    <h1 id=\"cTMail-title\" style=\"font-size:20px;line-height:36px;margin:0px 0px 22px;\">\r\n                                                        欢迎使用【{title}】\r\n                                                    </h1>\r\n                                                    <p id=\"cTMail-userName\" style=\"font-size:14px;color:#333;line-height:24px;margin:0;\">\r\n                                                        尊敬的用户，您好！\r\n                                                    </p>\r\n                                                    <p class=\"cTMail-content\" style=\"line-height:24px;margin:6px 0px 0px;overflow-wrap:break-word;word-break:break-all;\">\r\n                                                        <span style=\"color:#333333;font-size:14px;\"> 感谢您对我们的支持，我们将继续努力提供优质的服务。 </span> </p>\r\n                                                    <p class=\"cTMail-content\" style=\"line-height:24px;margin:6px 0px 0px;overflow-wrap:break-word;word-break:break-all;\">\r\n                                                        <span style=\"color:#333333;font-size:14px;\">您的账号正在进行电子邮件验证。 <span style=\"font-weight:bold;\">非本人操作可忽略。</span> </span> </p>\r\n                                                    <!-- 按钮 -->\r\n                                                    <p class=\"cTMail-content\" style=\"font-size:14px;color:#333333;line-height:24px;margin:6px 0px 0px;word-wrap:break-word;word-break:break-all;\">\r\n                                                        <!-- 下面替换成自己的链接 --> <span title=\"\" style=\"font-size:16px;line-height:45px;display:block;background-color:#00A4FF;color:#FFFFFF;text-align:center;text-decoration:none;margin-top:20px;border-radius:3px;\"> 验证码：{code} </span> </p>\r\n                                                    <p class=\"cTMail-content\" style=\"line-height:24px;margin:6px 0px 0px;overflow-wrap:break-word;word-break:break-all;\">\r\n                                                        <span style=\"color:#333333;font-size:14px;\"> <br /> 此为系统邮件，请勿回复。祝您使用愉快！ </span> </p>\r\n                                                </td>\r\n                                                <!-- 右侧表格，设置右边距用的 -->\r\n                                                <td style=\"width:3.2%;max-width:30px;\"></td>\r\n                                            </tr>\r\n                                            </tbody>\r\n                                        </table>\r\n                                    </div>\r\n                                    <!-- 页面底部的推广 -->\r\n                                    <div id=\"cTMail-copy\" style=\"text-align:center;font-size:12px;line-height:18px;color:#999;\">\r\n                                        <table style=\"width:100%;font-weight:300;margin-bottom:10px;border-collapse:collapse;\">\r\n                                            <tbody>\r\n                                            <tr style=\"font-weight:300;\">\r\n                                                <!-- 左，左边距 -->\r\n                                                <td style=\"width:3.2%;max-width:30px;\"></td>\r\n                                                <!-- 中，正文 -->\r\n                                                <td style=\"max-width:540px;\">\r\n                                                    <p style=\"text-align:center;margin:20px auto 14px auto;font-size:12px;color:#999;\">\r\n                                                        <!--取消订阅-->\r\n                                                    </p>\r\n                                                    <!-- 可以加个图片，公众号二维码之类的 -->\r\n                                                    <p id=\"cTMail-rights\" style=\"max-width:100%;margin:auto;font-size:12px;color:#999;text-align:center;line-height:22px;\">\r\n                                                        {copyright} </p>\r\n                                                </td>\r\n                                                <!-- 右，右边距 -->\r\n                                                <td style=\"width:3.2%;max-width:30px;\"></td>\r\n                                            </tr>\r\n                                            </tbody>\r\n                                        </table>\r\n                                    </div>\r\n                                </td>\r\n                                <td style=\"width:3%;max-width:30px;\"></td>\r\n                            </tr>\r\n                            </tbody>\r\n                        </table>\r\n                    </div>\r\n                </div>\r\n          </span> <!--<br />-->\r\n        </div>\r\n      </div>\r\n    </div>\r\n  </includetail>\r\n</div>', 1703303711, 1703310980, NULL);
INSERT INTO `vs_dramas_richtext` VALUES (62, 3, 3, '电子邮件国际简版', '<div>\r\n  <includetail>\r\n    <div align=\"center\">\r\n      <div class=\"open_email\" style=\"margin-left:8px;margin-top:8px;margin-bottom:8px;margin-right:8px;\">\r\n        <div>\r\n          <br /> <span class=\"genEmailContent\"> <div id=\"cTMail-Wrap\" style=\"word-break:break-all;box-sizing:border-box;text-align:center;min-width:320px;max-width:660px;border:1px solid #f6f6f6;background-color:#f7f8fa;margin:auto;padding:20px 0 10px;font-family:\'helvetica neue\',PingFangSC-Light,arial,\'hiragino sans gb\',\'microsoft yahei ui\',\'microsoft yahei\',simsun,sans-serif;\">\r\n                    <div class=\"main-content\">\r\n                        <table style=\"width:100%;font-weight:300;margin-bottom:10px;border-collapse:collapse;\">\r\n                            <tbody>\r\n                            <tr style=\"font-weight:300;\">\r\n                                <td style=\"width:3%;max-width:30px;\"></td>\r\n                                <td style=\"max-width:600px;\">\r\n                                    <!-- LOGO -->\r\n                                    <div id=\"cTMail-logo\" style=\"width:92px;height:25px;\">\r\n                                        <!-- 替换跳转链接 --> <a href=\"{domain}\"> <!-- 替换LOGO图片 --> <img border=\"0\" src=\"{logo}\" style=\"width:92px;height:25px;display:block;\" /> </a> </div>\r\n                                    <!-- 页面上边的蓝色分割线 -->\r\n                                    <p style=\"height:2px;background-color:#00a4ff;border:0;font-size:0;padding:0;width:100%;margin-top:20px;\"><br /></p>\r\n                                    <div id=\"cTMail-inner\" style=\"background-color:#fff;padding:23px 0 20px;box-shadow:0px 1px 1px 0px rgba(122, 55, 55, 0.2);text-align:left;\">\r\n                                        <table style=\"width:100%;font-weight:300;margin-bottom:10px;border-collapse:collapse;text-align:left;\">\r\n                                            <tbody>\r\n                                            <!-- 第一个单元格 -->\r\n                                            <tr style=\"font-weight:300;\">\r\n                                                <!-- 左侧表格，设置左边距用的 -->\r\n                                                <td style=\"width:3.2%;max-width:30px;\"></td>\r\n                                                <!-- 中间表格，正文使用 -->\r\n                                                <td style=\"max-width:480px;text-align:left;\">\r\n                                                    <!-- 以下是正文 -->\r\n                                                    <!-- 可以是标题 -->\r\n                                                    <h1 id=\"cTMail-title\" style=\"font-size:20px;line-height:36px;margin:0px 0px 22px;\">\r\n                                                        Welcome to [{title}]\r\n                                                    </h1>\r\n                                                    <p id=\"cTMail-userName\" style=\"font-size:14px;color:#333;line-height:24px;margin:0;\">\r\n                                                        Dear User,\r\n                                                    </p>\r\n                                                    <p class=\"cTMail-content\" style=\"line-height:24px;margin:6px 0px 0px;overflow-wrap:break-word;word-break:break-all;\">\r\n                                                        <span style=\"color:#333333;font-size:14px;\"> Thank you for your support. We will continue to strive to provide quality service. </span> </p>\r\n                                                    <p class=\"cTMail-content\" style=\"line-height:24px;margin:6px 0px 0px;overflow-wrap:break-word;word-break:break-all;\">\r\n                                                        <span style=\"color:#333333;font-size:14px;\">Your account is undergoing email verification. <span style=\"font-weight:bold;\">If this was not done by you, please ignore this message. </span> </span> </p>\r\n                                                    <!-- 按钮 -->\r\n                                                    <p class=\"cTMail-content\" style=\"font-size:14px;color:#333333;line-height:24px;margin:6px 0px 0px;word-wrap:break-word;word-break:break-all;\">\r\n                                                        <!-- 下面替换成自己的链接 --> <span title=\"\" style=\"font-size:16px;line-height:45px;display:block;background-color:#00A4FF;color:#FFFFFF;text-align:center;text-decoration:none;margin-top:20px;border-radius:3px;\"> Verification Code: {code} </span> </p>\r\n                                                    <p class=\"cTMail-content\" style=\"line-height:24px;margin:6px 0px 0px;overflow-wrap:break-word;word-break:break-all;\">\r\n                                                        <span style=\"color:#333333;font-size:14px;\"> <br /> This is a system email, please do not reply. We wish you a pleasant experience! </span> </p>\r\n                                                </td>\r\n                                                <!-- 右侧表格，设置右边距用的 -->\r\n                                                <td style=\"width:3.2%;max-width:30px;\"></td>\r\n                                            </tr>\r\n                                            </tbody>\r\n                                        </table>\r\n                                    </div>\r\n                                    <!-- 页面底部的推广 -->\r\n                                    <div id=\"cTMail-copy\" style=\"text-align:center;font-size:12px;line-height:18px;color:#999;\">\r\n                                        <table style=\"width:100%;font-weight:300;margin-bottom:10px;border-collapse:collapse;\">\r\n                                            <tbody>\r\n                                            <tr style=\"font-weight:300;\">\r\n                                                <!-- 左，左边距 -->\r\n                                                <td style=\"width:3.2%;max-width:30px;\"></td>\r\n                                                <!-- 中，正文 -->\r\n                                                <td style=\"max-width:540px;\">\r\n                                                    <p style=\"text-align:center;margin:20px auto 14px auto;font-size:12px;color:#999;\">\r\n                                                        <!--取消订阅-->\r\n                                                    </p>\r\n                                                    <!-- 可以加个图片，公众号二维码之类的 -->\r\n                                                    <p id=\"cTMail-rights\" style=\"max-width:100%;margin:auto;font-size:12px;color:#999;text-align:center;line-height:22px;\">\r\n                                                        {copyright}\r\n                                                    </p>\r\n                                                </td>\r\n                                                <!-- 右，右边距 -->\r\n                                                <td style=\"width:3.2%;max-width:30px;\"></td>\r\n                                            </tr>\r\n                                            </tbody>\r\n                                        </table>\r\n                                    </div>\r\n                                </td>\r\n                                <td style=\"width:3%;max-width:30px;\"></td>\r\n                            </tr>\r\n                            </tbody>\r\n                        </table>\r\n                    </div>\r\n                </div>\r\n          </span> </div>\r\n      </div>\r\n    </div>\r\n  </includetail>\r\n</div>', 1703310565, 1703310565, NULL);

-- ----------------------------
-- Table structure for vs_dramas_share
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_share`;
CREATE TABLE `vs_dramas_share`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL COMMENT '用户',
  `share_id` int(11) NOT NULL COMMENT '分享人',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '识别类型:index=默认分享,add=手动添加',
  `type_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '识别标识',
  `platform` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '识别平台',
  `share_platform` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分享来源',
  `from` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分享方式',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户分享' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_task
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_task`;
CREATE TABLE `vs_dramas_task`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `lang_id` int(11) NOT NULL DEFAULT 0 COMMENT '语言',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务标题',
  `desc` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务描述',
  `hook` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '事件',
  `type` enum('day','first') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务类型:first=首次,day=每天',
  `limit` int(11) NOT NULL DEFAULT 1 COMMENT '限制次数',
  `usable` int(11) NOT NULL COMMENT '奖励次数',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态:normal=启用,hidden=隐藏',
  `createtime` int(11) NOT NULL,
  `updatetime` int(11) NOT NULL,
  `deletetime` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_dramas_task
-- ----------------------------
INSERT INTO `vs_dramas_task` VALUES (1, 3, 1, '新用户注册', '新用户首次注册，免费赠送剧场积分！', 'user_register_after', 'first', 1, 100, 'normal', 1683948893, 1684918417, NULL);
INSERT INTO `vs_dramas_task` VALUES (2, 3, 1, '邀请新用户', '邀请新用户注册', 'share_success', 'day', 10, 100, 'normal', 1702016032, 1702016032, NULL);
INSERT INTO `vs_dramas_task` VALUES (3, 3, 4, '新用戶註冊', '新用戶首次注册，免費贈送劇場積分！', 'user_register_after', 'first', 1, 100, 'normal', 1683948893, 1702092939, NULL);
INSERT INTO `vs_dramas_task` VALUES (4, 3, 4, '邀請新用戶', '邀請新用戶註冊', 'share_success', 'day', 10, 100, 'normal', 1702016032, 1702092912, NULL);
INSERT INTO `vs_dramas_task` VALUES (5, 3, 3, 'Registration', 'New users can register for the first time and receive free theater points!', 'user_register_after', 'first', 1, 100, 'normal', 1683948893, 1702092989, NULL);
INSERT INTO `vs_dramas_task` VALUES (6, 3, 3, 'Invite new users', 'Inviting new users to register', 'share_success', 'day', 10, 100, 'normal', 1702016032, 1702093026, NULL);
INSERT INTO `vs_dramas_task` VALUES (7, 3, 5, 'ลงทะเบียนผู้ใช้ใหม่', 'สมัครสมาชิกครั้งแรกสำหรับผู้ใช้ใหม่ฟรีเครดิตโรงละคร!', 'user_register_after', 'first', 1, 100, 'normal', 1683948893, 1702093080, NULL);
INSERT INTO `vs_dramas_task` VALUES (8, 3, 5, 'เชิญผู้ใช้ใหม่', 'เชิญชวนผู้ใช้ใหม่ลงทะเบียน', 'share_success', 'day', 10, 100, 'normal', 1702016032, 1702093105, NULL);
INSERT INTO `vs_dramas_task` VALUES (9, 3, 7, 'Registro de nuevos usuarios', '¡¡ los nuevos usuarios se registran por primera vez y dan puntos de teatro gratis!', 'user_register_after', 'first', 1, 100, 'normal', 1683948893, 1702093176, NULL);
INSERT INTO `vs_dramas_task` VALUES (10, 3, 7, 'Invitar a nuevos usuarios', 'Invitar a nuevos usuarios a registrarse', 'share_success', 'day', 10, 100, 'normal', 1702016032, 1702093146, NULL);
INSERT INTO `vs_dramas_task` VALUES (11, 3, 8, 'تسجيل مستخدم جديد', ' المستخدمين الجدد المسجلين لأول مرة ، مجانا نقاط المسرح ! ', 'user_register_after', 'first', 1, 100, 'normal', 1683948893, 1702093240, NULL);
INSERT INTO `vs_dramas_task` VALUES (12, 3, 8, 'دعوة مستخدم جديد', 'دعوة مستخدم جديد للتسجيل', 'share_success', 'day', 10, 100, 'normal', 1702016032, 1702093275, NULL);
INSERT INTO `vs_dramas_task` VALUES (13, 3, 9, 'Đăng ký người dùng mới', 'Người dùng mới đăng ký lần đầu tiên và tặng điểm nhà hát miễn phí!', 'user_register_after', 'first', 1, 100, 'normal', 1683948893, 1702093310, NULL);
INSERT INTO `vs_dramas_task` VALUES (14, 3, 9, 'Mời người dùng mới', 'Mời người dùng mới đăng ký', 'share_success', 'day', 10, 100, 'normal', 1702016032, 1702093343, NULL);

-- ----------------------------
-- Table structure for vs_dramas_usable
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_usable`;
CREATE TABLE `vs_dramas_usable`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `lang_id` int(11) NOT NULL DEFAULT 0 COMMENT '语言',
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `image` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图片',
  `flag` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标识',
  `desc` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权益',
  `usable` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '总积分',
  `original_usable` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '原始积分',
  `give_usable` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '赠送积分',
  `price` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '总价格',
  `give_price` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '赠送金额',
  `first_price` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '首冲价格',
  `original_price` decimal(20, 2) NOT NULL COMMENT '划线价格',
  `status` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '是否启用:0=不启用,1=启用',
  `weigh` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `updatetime` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'AI次数套餐' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_dramas_usable
-- ----------------------------
INSERT INTO `vs_dramas_usable` VALUES (1, 3, 1, '套餐一', '', '特惠', '满足个人日常基础使用需求，无限制无期限随时使用。', '', 1500, 1000, 500, '0.01', '5', 0.00, 15.00, '1', 0, 1690792613, 1690792934);
INSERT INTO `vs_dramas_usable` VALUES (2, 3, 1, '套餐二', '', '', '满足个人日常基础使用需求，无限制无期限随时使用。', '', 7900, 6900, 1000, '79.9', '10', 0.00, 99.90, '1', 0, 1690792772, 1690792939);
INSERT INTO `vs_dramas_usable` VALUES (3, 3, 1, '套餐三', '', '超值', '满足个人日常基础使用需求，无限制无期限随时使用。', '', 9900, 6900, 3000, '89.9', '30', 0.00, 129.00, '1', 0, 1690792860, 1690792944);
INSERT INTO `vs_dramas_usable` VALUES (4, 3, 3, 'Package One', '', 'Special offer', 'Meets personal daily basic usage needs, unrestricted and unlimited for anytime use.', '', 1500, 1000, 500, '0.01', '5', 0.00, 15.00, '1', 0, 1690792613, 1690792934);
INSERT INTO `vs_dramas_usable` VALUES (5, 3, 3, 'Package Two', '', '', 'Meets personal daily basic usage needs, unrestricted and unlimited for anytime use.', '', 7900, 6900, 1000, '79.9', '10', 0.00, 99.90, '1', 0, 1690792772, 1690792939);
INSERT INTO `vs_dramas_usable` VALUES (6, 3, 3, 'Package Three', '', 'Special offer', 'Meets personal daily basic usage needs, unrestricted and unlimited for anytime use.', '', 9900, 6900, 3000, '89.9', '30', 0.00, 129.00, '1', 0, 1690792860, 1690792944);
INSERT INTO `vs_dramas_usable` VALUES (7, 3, 4, '套餐一', '', '特惠', '滿足個人日常基礎使用需求，無限制無期限隨時使用。', '', 1500, 1000, 500, '0.01', '5', 0.00, 15.00, '1', 0, 1690792613, 1690792934);
INSERT INTO `vs_dramas_usable` VALUES (8, 3, 4, '套餐二', '', '', '滿足個人日常基礎使用需求，無限制無期限隨時使用。', '', 7900, 6900, 1000, '79.9', '10', 0.00, 99.90, '1', 0, 1690792772, 1690792939);
INSERT INTO `vs_dramas_usable` VALUES (9, 3, 4, '套餐三', '', '超值', '滿足個人日常基礎使用需求，無限制無期限隨時使用。', '', 9900, 6900, 3000, '89.9', '30', 0.00, 129.00, '1', 0, 1690792860, 1690792944);
INSERT INTO `vs_dramas_usable` VALUES (10, 3, 5, 'แพ็คเกจหนึ่ง  ', '', 'โปรโมชั่นพิเศษ ', 'เพียงพอต่อความต้องการใช้งานประจำวันของบุคคล ไม่มีข้อจำกัดและไม่จำกัดเวลาในการใช้งานได้ทุกเมื่อ', '', 1500, 1000, 500, '0.01', '5', 0.00, 15.00, '1', 0, 1690792613, 1690792934);
INSERT INTO `vs_dramas_usable` VALUES (11, 3, 5, 'แพ็คเกจสอง ', '', '', 'เพียงพอต่อความต้องการใช้งานประจำวันของบุคคล ไม่มีข้อจำกัดและไม่จำกัดเวลาในการใช้งานได้ทุกเมื่อ', '', 7900, 6900, 1000, '79.9', '10', 0.00, 99.90, '1', 0, 1690792772, 1690792939);
INSERT INTO `vs_dramas_usable` VALUES (12, 3, 5, 'แพ็คเกจสาม  ', '', 'โปรโมชั่นพิเศษ ', 'เพียงพอต่อความต้องการใช้งานประจำวันของบุคคล ไม่มีข้อจำกัดและไม่จำกัดเวลาในการใช้งานได้ทุกเมื่อ', '', 9900, 6900, 3000, '89.9', '30', 0.00, 129.00, '1', 0, 1690792860, 1690792944);
INSERT INTO `vs_dramas_usable` VALUES (13, 3, 7, 'Paquete uno ', '', 'Oferta especial', 'Satisface las necesidades básicas de uso personal diario, sin restricciones ni límites de tiempo para utilizar en cualquier momento.', '', 1500, 1000, 500, '0.01', '5', 0.00, 15.00, '1', 0, 1690792613, 1690792934);
INSERT INTO `vs_dramas_usable` VALUES (14, 3, 7, 'Paquete dos ', '', '', 'Satisface las necesidades básicas de uso personal diario, sin restricciones ni límites de tiempo para utilizar en cualquier momento.', '', 7900, 6900, 1000, '79.9', '10', 0.00, 99.90, '1', 0, 1690792772, 1690792939);
INSERT INTO `vs_dramas_usable` VALUES (15, 3, 7, 'Paquete tres  ', '', 'Oferta especial', 'Satisface las necesidades básicas de uso personal diario, sin restricciones ni límites de tiempo para utilizar en cualquier momento.', '', 9900, 6900, 3000, '89.9', '30', 0.00, 129.00, '1', 0, 1690792860, 1690792944);
INSERT INTO `vs_dramas_usable` VALUES (16, 3, 8, 'الباقة الأولى (باقة واحدة)', '', 'عرض خاص ', 'تلبي احتياجات الاستخدام الأساسية اليومية للفرد، دون قيود أو حدود زمنية للاستخدام في أي وقت.', '', 1500, 1000, 500, '0.01', '5', 0.00, 15.00, '1', 0, 1690792613, 1690792934);
INSERT INTO `vs_dramas_usable` VALUES (17, 3, 8, 'الباقة الثانية (باقة اثنين)', '', '', 'تلبي احتياجات الاستخدام الأساسية اليومية للفرد، دون قيود أو حدود زمنية للاستخدام في أي وقت.', '', 7900, 6900, 1000, '79.9', '10', 0.00, 99.90, '1', 0, 1690792772, 1690792939);
INSERT INTO `vs_dramas_usable` VALUES (18, 3, 8, 'الباقة الثالثة (باقة ثلاثة)', '', 'عرض خاص ', 'تلبي احتياجات الاستخدام الأساسية اليومية للفرد، دون قيود أو حدود زمنية للاستخدام في أي وقت.', '', 9900, 6900, 3000, '89.9', '30', 0.00, 129.00, '1', 0, 1690792860, 1690792944);
INSERT INTO `vs_dramas_usable` VALUES (19, 3, 9, 'Gói 1', '', 'Ưu đãi đặc biệt', 'Đáp ứng nhu cầu sử dụng cơ bản hàng ngày cá nhân, không có hạn chế và không giới hạn thời gian sử dụng bất kỳ lúc nào.', '', 1500, 1000, 500, '0.01', '5', 0.00, 15.00, '1', 0, 1690792613, 1690792934);
INSERT INTO `vs_dramas_usable` VALUES (20, 3, 9, 'Gói 2', '', '', 'Đáp ứng nhu cầu sử dụng cơ bản hàng ngày cá nhân, không có hạn chế và không giới hạn thời gian sử dụng bất kỳ lúc nào.', '', 7900, 6900, 1000, '79.9', '10', 0.00, 99.90, '1', 0, 1690792772, 1690792939);
INSERT INTO `vs_dramas_usable` VALUES (21, 3, 9, 'Gói 3', '', 'Ưu đãi đặc biệt', 'Đáp ứng nhu cầu sử dụng cơ bản hàng ngày cá nhân, không có hạn chế và không giới hạn thời gian sử dụng bất kỳ lúc nào.', '', 9900, 6900, 3000, '89.9', '30', 0.00, 129.00, '1', 0, 1690792860, 1690792944);

-- ----------------------------
-- Table structure for vs_dramas_usable_order
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_usable_order`;
CREATE TABLE `vs_dramas_usable_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `usable_id` int(11) NOT NULL DEFAULT 0 COMMENT '充值套餐',
  `order_sn` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `user_id` int(11) NULL DEFAULT 0 COMMENT '用户',
  `usable` int(11) NULL DEFAULT 0 COMMENT '充值次数',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '订单状态:-2=交易关闭,-1=已取消,0=未支付,1=已支付,2=已完成',
  `total_fee` decimal(20, 2) NOT NULL COMMENT '支付金额',
  `pay_fee` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '实际支付金额',
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '货币',
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易单号',
  `payment_json` varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易原始数据',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单备注',
  `pay_type` enum('wechat','alipay','wallet','score','cryptocard','system','paypal','stripe') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式:wechat=微信支付,alipay=支付宝,wallet=钱包支付,score=积分支付,cryptocard=卡密兑换,system=管理员设置,paypal=PayPal,stripe=Stripe',
  `paytime` int(11) NULL DEFAULT NULL COMMENT '支付时间',
  `ext` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附加字段',
  `platform` enum('H5','Web','wxOfficialAccount','wxMiniProgram','App') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台:H5=H5,wxOfficialAccount=微信公众号,wxMiniProgram=微信小程序,Web=Web,App=APP',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'AI次数充值订单' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_user_bank
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_user_bank`;
CREATE TABLE `vs_dramas_user_bank`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `type` enum('bank','alipay','wechat') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账户类型:bank=银行卡,alipay=支付宝,wechat=微信',
  `real_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `bank_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行名',
  `card_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卡号',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '收款码',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '提现银行卡' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_user_cryptocard
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_user_cryptocard`;
CREATE TABLE `vs_dramas_user_cryptocard`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户',
  `cryptocard_id` int(11) NULL DEFAULT NULL COMMENT '卡密',
  `type` enum('vip','reseller','usable') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'usable' COMMENT '类型:vip=VIP套餐,reseller=分销商套餐,usable=剧场积分套餐',
  `order_id` int(11) NOT NULL DEFAULT 0 COMMENT '订单 id',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '使用时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户卡密记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_user_oauth
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_user_oauth`;
CREATE TABLE `vs_dramas_user_oauth`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '用户',
  `provider` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '厂商',
  `platform` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '平台',
  `unionid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '厂商ID',
  `openid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '平台ID',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(1) NULL DEFAULT 0 COMMENT '性别',
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '国家',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `headimgurl` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `logintime` int(11) NULL DEFAULT NULL COMMENT '登录时间',
  `logincount` int(11) NULL DEFAULT 0 COMMENT '累计登陆',
  `expire_in` int(11) NULL DEFAULT NULL COMMENT '过期周期(s)',
  `expiretime` int(11) NULL DEFAULT NULL COMMENT '过期时间',
  `session_key` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'session_key',
  `refresh_token` varchar(110) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'refresh_token',
  `access_token` varchar(110) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'access_token',
  `createtime` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(11) NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `openid`(`openid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方授权' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_user_wallet_apply
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_user_wallet_apply`;
CREATE TABLE `vs_dramas_user_wallet_apply`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL COMMENT '提现用户',
  `apply_sn` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提现单号',
  `apply_type` enum('bank','wechat','alipay') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款类型:bank=银行卡,wechat=微信零钱,alipay=支付宝',
  `money` decimal(20, 2) NOT NULL COMMENT '提现积分',
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货币标准符号',
  `exchange_rate` int(11) NOT NULL COMMENT '积分兑换比例',
  `pay_money` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '提现金额',
  `actual_money` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '实际到账',
  `charge_money` decimal(20, 2) NOT NULL COMMENT '手续费',
  `service_fee` decimal(10, 3) NULL DEFAULT NULL COMMENT '手续费率',
  `apply_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '打款信息',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '提现状态:-1=已拒绝,0=待审核,1=处理中,2=已处理',
  `platform` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台',
  `payment_json` varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易原始数据',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '申请时间',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '操作时间',
  `log` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '操作日志',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `apply_sn`(`apply_sn`) USING BTREE COMMENT '提现单号'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户提现' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_user_wallet_log
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_user_wallet_log`;
CREATE TABLE `vs_dramas_user_wallet_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志 id',
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户',
  `wallet` decimal(20, 2) NOT NULL COMMENT '变动金额',
  `wallet_type` enum('money','score','usable') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日志类型:money=余额,score=积分,usable=AI次数',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '变动类型',
  `before` decimal(20, 2) NOT NULL COMMENT '变动前',
  `after` decimal(20, 2) NOT NULL COMMENT '变动后',
  `item_id` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目 id',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `ext` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附加字段',
  `oper_type` enum('user','admin','system') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'user' COMMENT '操作人类型',
  `oper_id` int(11) NOT NULL DEFAULT 0 COMMENT '操作人',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '钱包日志' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_version
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_version`;
CREATE TABLE `vs_dramas_version`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `site_id` int(11) NOT NULL DEFAULT 0,
  `oldversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '包大小',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '强制更新',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(20) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(11) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态:normal=正常,hidden=隐藏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '版本表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_video
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_video`;
CREATE TABLE `vs_dramas_video`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL DEFAULT 0,
  `lang_id` int(11) NOT NULL DEFAULT 0 COMMENT '语言',
  `category_ids` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '分类',
  `area_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '地区',
  `year_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '年份',
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '副标题',
  `image` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '封面',
  `flags` set('hot','recommend') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标志:hot=热门,recommend=推荐',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '简介',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标签',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图文详情',
  `price` int(11) NOT NULL COMMENT '价格',
  `vprice` int(11) NOT NULL COMMENT 'VIP价格',
  `episodes` int(11) NOT NULL COMMENT '总集数',
  `score` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评分',
  `sales` int(11) NOT NULL DEFAULT 0 COMMENT '销量',
  `favorites` int(11) NOT NULL DEFAULT 0 COMMENT '收藏量',
  `views` int(11) NOT NULL DEFAULT 0 COMMENT '播放量',
  `shares` int(11) NOT NULL DEFAULT 0 COMMENT '转发量',
  `likes` int(11) NOT NULL DEFAULT 0 COMMENT '点赞量',
  `fake_views` int(11) NOT NULL DEFAULT 0 COMMENT '虚拟播放量',
  `fake_favorites` int(11) NOT NULL DEFAULT 0 COMMENT '虚拟收藏量',
  `fake_shares` int(11) NOT NULL DEFAULT 0 COMMENT '虚拟转发量',
  `fake_likes` int(11) NOT NULL DEFAULT 0 COMMENT '虚拟点赞量',
  `weigh` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `status` enum('up','down') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'up' COMMENT '商品状态:up=上架,down=下架',
  `copyright_id` int(11) NOT NULL DEFAULT 0 COMMENT '版权方',
  `createtime` int(11) NOT NULL COMMENT '添加时间',
  `updatetime` int(11) NOT NULL COMMENT '更新时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '短剧' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_dramas_video
-- ----------------------------
INSERT INTO `vs_dramas_video` VALUES (1, 3, 1, '30', 50, 46, '病娇摄政王', '宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。', 'https://mp4.nymaite.cn/s/%E7%97%85%E5%A8%87%E6%91%84%E6%94%BF%E7%8E%8B2979/1.jpg', 'hot,recommend', '宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。', '', '<span style=\"color:#333333;font-family:\"Helvetica Neue\", Helvetica, Arial, \"PingFang SC\", \"Hiragino Sans GB\", \"Microsoft YaHei\", \"WenQuanYi Micro Hei\", sans-serif, font-extend;font-size:14px;text-indent:28px;text-wrap:wrap;background-color:#FFFFFF;\">宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。</span>', 200, 0, 26, '9.9', 0, 0, 0, 0, 0, 0, 0, 0, 0, 2979, 'up', 1693451021, 1693463409, NULL);
INSERT INTO `vs_dramas_video` VALUES (2, 3, 3, '57', 50, 46, 'Yandere Regent King', '宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。', 'https://mp4.nymaite.cn/s/%E7%97%85%E5%A8%87%E6%91%84%E6%94%BF%E7%8E%8B2979/1.jpg', 'hot,recommend', '宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。', '', '<span style=\"color:#333333;font-family:\"Helvetica Neue\", Helvetica, Arial, \"PingFang SC\", \"Hiragino Sans GB\", \"Microsoft YaHei\", \"WenQuanYi Micro Hei\", sans-serif, font-extend;font-size:14px;text-indent:28px;text-wrap:wrap;background-color:#FFFFFF;\">宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。</span>', 200, 0, 26, '9.9', 0, 0, 0, 0, 0, 0, 0, 0, 0, 2979, 'up', 1693451021, 1693463409, NULL);
INSERT INTO `vs_dramas_video` VALUES (3, 3, 4, '73', 50, 46, '病嬌攝政王', '宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。', 'https://mp4.nymaite.cn/s/%E7%97%85%E5%A8%87%E6%91%84%E6%94%BF%E7%8E%8B2979/1.jpg', 'hot,recommend', '宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。', '', '<span style=\"color:#333333;font-family:\"Helvetica Neue\", Helvetica, Arial, \"PingFang SC\", \"Hiragino Sans GB\", \"Microsoft YaHei\", \"WenQuanYi Micro Hei\", sans-serif, font-extend;font-size:14px;text-indent:28px;text-wrap:wrap;background-color:#FFFFFF;\">宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。</span>', 200, 0, 26, '9.9', 0, 0, 0, 0, 0, 0, 0, 0, 0, 2979, 'up', 1693451021, 1693463409, NULL);
INSERT INTO `vs_dramas_video` VALUES (4, 3, 5, '65', 50, 46, ' สิ่งใจของพระบาทคน', '宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。', 'https://mp4.nymaite.cn/s/%E7%97%85%E5%A8%87%E6%91%84%E6%94%BF%E7%8E%8B2979/1.jpg', 'hot,recommend', '宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。', '', '<span style=\"color:#333333;font-family:\"Helvetica Neue\", Helvetica, Arial, \"PingFang SC\", \"Hiragino Sans GB\", \"Microsoft YaHei\", \"WenQuanYi Micro Hei\", sans-serif, font-extend;font-size:14px;text-indent:28px;text-wrap:wrap;background-color:#FFFFFF;\">宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。</span>', 200, 0, 26, '9.9', 0, 0, 0, 0, 0, 0, 0, 0, 0, 2979, 'up', 1690000000, 1690000000, NULL);
INSERT INTO `vs_dramas_video` VALUES (5, 3, 7, '80', 50, 46, 'El Pacto silencioso', '宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。', 'https://mp4.nymaite.cn/s/%E7%97%85%E5%A8%87%E6%91%84%E6%94%BF%E7%8E%8B2979/1.jpg', 'hot,recommend', '宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。', '', '<span style=\"color:#333333;font-family:\"Helvetica Neue\", Helvetica, Arial, \"PingFang SC\", \"Hiragino Sans GB\", \"Microsoft YaHei\", \"WenQuanYi Micro Hei\", sans-serif, font-extend;font-size:14px;text-indent:28px;text-wrap:wrap;background-color:#FFFFFF;\">宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。</span>', 200, 0, 26, '9.9', 0, 0, 0, 0, 0, 0, 0, 0, 0, 2979, 'up', 1690000000, 1690000000, NULL);
INSERT INTO `vs_dramas_video` VALUES (6, 3, 8, '89', 50, 46, ' أنا صغير الموهيب', '宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。', 'https://mp4.nymaite.cn/s/%E7%97%85%E5%A8%87%E6%91%84%E6%94%BF%E7%8E%8B2979/1.jpg', 'hot,recommend', '宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。', '', '<span style=\"color:#333333;font-family:\"Helvetica Neue\", Helvetica, Arial, \"PingFang SC\", \"Hiragino Sans GB\", \"Microsoft YaHei\", \"WenQuanYi Micro Hei\", sans-serif, font-extend;font-size:14px;text-indent:28px;text-wrap:wrap;background-color:#FFFFFF;\">宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。</span>', 200, 0, 26, '9.9', 0, 0, 0, 0, 0, 0, 0, 0, 0, 2979, 'up', 1690000000, 1690000000, NULL);
INSERT INTO `vs_dramas_video` VALUES (7, 3, 9, '98', 50, 46, 'Tôn trọng việc học tập.', '宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。', 'https://mp4.nymaite.cn/s/%E7%97%85%E5%A8%87%E6%91%84%E6%94%BF%E7%8E%8B2979/1.jpg', 'hot,recommend', '宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。', '', '<span style=\"color:#333333;font-family:\"Helvetica Neue\", Helvetica, Arial, \"PingFang SC\", \"Hiragino Sans GB\", \"Microsoft YaHei\", \"WenQuanYi Micro Hei\", sans-serif, font-extend;font-size:14px;text-indent:28px;text-wrap:wrap;background-color:#FFFFFF;\">宰相府嫡女月野，被自己青梅竹马与最疼爱的妹妹合伙陷害葬生火海，再次醒来，竟意外重生回到从前。既然上天再给一次机会，且看月野如何手撕负心汉，狂虐心机女，顺便撩个摄政王当夫君，走向人生巅峰。</span>', 200, 0, 26, '9.9', 0, 0, 0, 0, 0, 0, 0, 0, 0, 2979, 'up', 1690000000, 1690000000, NULL);

-- ----------------------------
-- Table structure for vs_dramas_video_episodes
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_video_episodes`;
CREATE TABLE `vs_dramas_video_episodes`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL DEFAULT 0,
  `lang_id` int(11) NOT NULL DEFAULT 0 COMMENT '语言',
  `vid` int(11) NOT NULL DEFAULT 0 COMMENT '短剧',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `image` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '封面',
  `video` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '视频',
  `duration` int(11) NOT NULL COMMENT '时长',
  `price` int(11) NOT NULL COMMENT '价格',
  `vprice` int(11) NOT NULL COMMENT 'VIP价格',
  `sales` int(11) NOT NULL DEFAULT 0 COMMENT '销量',
  `likes` int(11) NOT NULL DEFAULT 0 COMMENT '点赞量',
  `views` int(11) NOT NULL DEFAULT 0 COMMENT '播放量',
  `favorites` int(11) NOT NULL DEFAULT 0 COMMENT '收藏量',
  `shares` int(11) NOT NULL DEFAULT 0 COMMENT '转发量',
  `fake_likes` int(11) NOT NULL DEFAULT 0 COMMENT '虚拟点赞量',
  `fake_views` int(11) NOT NULL DEFAULT 0 COMMENT '虚拟播放量',
  `fake_favorites` int(11) NOT NULL DEFAULT 0 COMMENT '虚拟收藏量',
  `fake_shares` int(11) NOT NULL DEFAULT 0 COMMENT '虚拟转发量',
  `weigh` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '商品状态:normal=显示,hidden=隐藏',
  `updatetime` int(11) NOT NULL COMMENT '更新时间',
  `createtime` int(11) NOT NULL COMMENT '添加时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '剧集' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_dramas_video_episodes
-- ----------------------------
INSERT INTO `vs_dramas_video_episodes` VALUES (1, 3, 1, 1, '第1集', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.mp4', 95, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (2, 3, 1, 1, '第2集', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/2.mp4', 96, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (3, 3, 1, 1, '第3集', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/3.mp4', 97, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (4, 3, 1, 1, '第4集', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/4.mp4', 98, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (5, 3, 1, 1, '第5集', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/5.mp4', 99, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (6, 3, 1, 1, '第6集', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/6.mp4', 100, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (7, 3, 1, 1, '第7集', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/7.mp4', 101, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (8, 3, 1, 1, '第8集', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/8.mp4', 102, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (9, 3, 3, 2, 'Episode 1', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.mp4', 95, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (10, 3, 3, 2, 'Episode 2', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/2.mp4', 96, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (11, 3, 3, 2, 'Episode 3', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/3.mp4', 97, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (12, 3, 3, 2, 'Episode 4', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/4.mp4', 98, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (13, 3, 3, 2, 'Episode 5', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/5.mp4', 99, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (14, 3, 3, 2, 'Episode 6', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/6.mp4', 100, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (15, 3, 3, 2, 'Episode 7', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/7.mp4', 101, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (16, 3, 3, 2, 'Episode 8', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/8.mp4', 102, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (17, 3, 4, 3, 'Episode 1', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.mp4', 95, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (18, 3, 4, 3, 'Episode 2', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/2.mp4', 96, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (19, 3, 4, 3, 'Episode 3', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/3.mp4', 97, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (20, 3, 4, 3, 'Episode 4', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/4.mp4', 98, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (21, 3, 4, 3, 'Episode 5', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/5.mp4', 99, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (22, 3, 4, 3, 'Episode 6', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/6.mp4', 100, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (23, 3, 4, 3, 'Episode 7', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/7.mp4', 101, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (24, 3, 4, 3, 'Episode 8', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/8.mp4', 102, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (25, 3, 5, 4, 'Episode 1', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.mp4', 95, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (26, 3, 5, 4, 'Episode 2', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/2.mp4', 96, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (27, 3, 5, 4, 'Episode 3', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/3.mp4', 97, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (28, 3, 5, 4, 'Episode 4', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/4.mp4', 98, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (29, 3, 5, 4, 'Episode 5', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/5.mp4', 99, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (30, 3, 5, 4, 'Episode 6', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/6.mp4', 100, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (31, 3, 5, 4, 'Episode 7', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/7.mp4', 101, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (32, 3, 5, 4, 'Episode 8', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/8.mp4', 102, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (33, 3, 7, 5, 'Episode 1', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.mp4', 95, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (34, 3, 7, 5, 'Episode 2', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/2.mp4', 96, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (35, 3, 7, 5, 'Episode 3', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/3.mp4', 97, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (36, 3, 7, 5, 'Episode 4', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/4.mp4', 98, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (37, 3, 7, 5, 'Episode 5', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/5.mp4', 99, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (38, 3, 7, 5, 'Episode 6', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/6.mp4', 100, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (39, 3, 7, 5, 'Episode 7', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/7.mp4', 101, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (40, 3, 7, 5, 'Episode 8', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/8.mp4', 102, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (41, 3, 8, 6, 'Episode 1', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.mp4', 95, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (42, 3, 8, 6, 'Episode 2', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/2.mp4', 96, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (43, 3, 8, 6, 'Episode 3', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/3.mp4', 97, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (44, 3, 8, 6, 'Episode 4', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/4.mp4', 98, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (45, 3, 8, 6, 'Episode 5', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/5.mp4', 99, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (46, 3, 8, 6, 'Episode 6', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/6.mp4', 100, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (47, 3, 8, 6, 'Episode 7', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/7.mp4', 101, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (48, 3, 8, 6, 'Episode 8', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/8.mp4', 102, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (49, 3, 9, 7, 'Episode 1', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.mp4', 95, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (50, 3, 9, 7, 'Episode 2', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/2.mp4', 96, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (51, 3, 9, 7, 'Episode 3', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/3.mp4', 97, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (52, 3, 9, 7, 'Episode 4', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/4.mp4', 98, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (53, 3, 9, 7, 'Episode 5', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/5.mp4', 99, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (54, 3, 9, 7, 'Episode 6', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/6.mp4', 100, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (55, 3, 9, 7, 'Episode 7', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/7.mp4', 101, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);
INSERT INTO `vs_dramas_video_episodes` VALUES (56, 3, 9, 7, 'Episode 8', 'https://mp4.nymaite.cn/s/病娇摄政王2979/1.jpg', 'https://mp4.nymaite.cn/s/病娇摄政王2979/8.mp4', 102, 0, 0, 0, 0, 0, 0, 0, 2343, 3493, 124, 659, 0, 'normal', 1693531008, 1693531008, NULL);

-- ----------------------------
-- Table structure for vs_dramas_video_favorite
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_video_favorite`;
CREATE TABLE `vs_dramas_video_favorite`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL DEFAULT 0,
  `type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型:like=点赞,favorite=收藏',
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户',
  `vid` int(11) NOT NULL DEFAULT 0 COMMENT '短剧',
  `episode_id` int(11) NOT NULL DEFAULT 0 COMMENT '剧集',
  `createtime` int(11) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '收藏点赞' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_video_images
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_video_images`;
CREATE TABLE `vs_dramas_video_images`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL DEFAULT 0,
  `vid` int(11) NOT NULL COMMENT '短剧',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '壁纸名称',
  `image` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '壁纸图片',
  `views` int(11) NOT NULL DEFAULT 0 COMMENT '浏览量',
  `downloads` int(11) NOT NULL DEFAULT 0 COMMENT '下载量',
  `createtime` int(11) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '剧情壁纸' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_video_log
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_video_log`;
CREATE TABLE `vs_dramas_video_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL DEFAULT 0,
  `type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型:log=记录,favorite=追剧',
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户',
  `vid` int(11) NOT NULL DEFAULT 0 COMMENT '短剧',
  `episode_id` int(11) NOT NULL DEFAULT 0 COMMENT '剧集',
  `view_time` int(11) NOT NULL DEFAULT 0 COMMENT '观看时间',
  `createtime` int(11) NOT NULL COMMENT '添加时间',
  `updatetime` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '追剧记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_video_order
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_video_order`;
CREATE TABLE `vs_dramas_video_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `vid` int(11) NOT NULL DEFAULT 0 COMMENT '短剧',
  `episode_id` int(11) NOT NULL DEFAULT 0 COMMENT '剧集',
  `order_sn` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `user_id` int(11) NULL DEFAULT 0 COMMENT '用户',
  `total_fee` int(10) NOT NULL DEFAULT 0 COMMENT '支付积分',
  `platform` enum('H5','Web','wxOfficialAccount','wxMiniProgram','App') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台:H5=H5,wxOfficialAccount=微信公众号,wxMiniProgram=微信小程序,Web=Web,App=APP',
  `copyright_id` int(11) NOT NULL DEFAULT 0 COMMENT '版权方',
  `createtime` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `vid`(`user_id`, `vid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_video_performer
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_video_performer`;
CREATE TABLE `vs_dramas_video_performer`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL DEFAULT 0,
  `vid` int(11) NOT NULL DEFAULT 0 COMMENT '短剧',
  `type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型:director=导演,performer=演员',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
  `en_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '英文名',
  `avatar` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标签',
  `play` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '饰演',
  `profile` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '简介',
  `weigh` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `createtime` bigint(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '演员表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_dramas_video_performer
-- ----------------------------
INSERT INTO `vs_dramas_video_performer` VALUES (9, 3, 2981, 'director', '王宏博', 'wanghongbo', '/uploads/20230831/12f97dd83a52e092bed0685808d3f4c7.png', '', '', '', 0, 1693460687);
INSERT INTO `vs_dramas_video_performer` VALUES (10, 3, 2983, 'performer', '文鸿毅', 'wenhongyi', '/uploads/20230831/6ac28f5651d03c8686900362af76c118.jpg', '', '', '', 0, 1693460929);
INSERT INTO `vs_dramas_video_performer` VALUES (11, 3, 3005, 'performer', '张震', 'zhangzhen', '/uploads/20230901/dc5cb4c31f4192fb97e1108c45a206f1.jpg', '', '', '', 0, 1693556296);
INSERT INTO `vs_dramas_video_performer` VALUES (12, 3, 3011, 'performer', '杨硕', 'yangshuo', '/uploads/20230901/5c57e31ba999fcb9f5a5875ea773dc22.jpg', '', '', '', 0, 1693559631);
INSERT INTO `vs_dramas_video_performer` VALUES (13, 3, 3017, 'performer', '周子琪', 'zhouziqi', '/uploads/20230901/36496c1348b58225cbb0bc4bdd97fc13.jpg', '', '', '', 0, 1693790465);
INSERT INTO `vs_dramas_video_performer` VALUES (14, 3, 3018, 'performer', '周翊涛', 'zhoulingtao', '/uploads/20230901/36496c1348b58225cbb0bc4bdd97fc13.jpg', '', '', '', 0, 1693790751);
INSERT INTO `vs_dramas_video_performer` VALUES (15, 3, 3019, 'director', '王世荣', 'wangshirong', '/uploads/20230901/36496c1348b58225cbb0bc4bdd97fc13.jpg', '', '', '', 0, 1693791843);
INSERT INTO `vs_dramas_video_performer` VALUES (16, 3, 3020, 'performer', '内详', 'neixiang', '/uploads/20230901/36496c1348b58225cbb0bc4bdd97fc13.jpg', '', '', '', 0, 1693821252);

-- ----------------------------
-- Table structure for vs_dramas_vip
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_vip`;
CREATE TABLE `vs_dramas_vip`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `lang_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '语言',
  `type` enum('d','m','q','y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '充值类型:d=天,m=月,q=季,y=年',
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `image` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标识',
  `desc` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权益',
  `price` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '价格',
  `first_price` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '首冲价格',
  `original_price` decimal(20, 2) NOT NULL COMMENT '划线价格',
  `num` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '充值数量',
  `status` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '是否启用:0=不启用,1=启用',
  `weigh` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `updatetime` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户充值会员价格' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_dramas_vip
-- ----------------------------
INSERT INTO `vs_dramas_vip` VALUES (1, 3, 1, 'd', '天卡', '这是周卡', '不限制播放，点击开通获得更好的服务。', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '0.01', 0.01, 29.90, 1, '1', 0, 1666746972, 1701768095);
INSERT INTO `vs_dramas_vip` VALUES (2, 3, 1, 'm', '月卡', '这是月卡', '不限制播放次数，点击开通获得更好的服务。', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '28.00', 9.90, 58.00, 1, '1', 0, 1666747303, 1688636757);
INSERT INTO `vs_dramas_vip` VALUES (3, 3, 1, 'y', '年卡', '这是年卡', '不限制播放次数，点击开通获得更好的服务。', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '168.00', 69.90, 360.00, 1, '1', 0, 1666747351, 1688636763);
INSERT INTO `vs_dramas_vip` VALUES (4, 3, 3, 'd', 'Day pass', '这是周卡', 'Unrestricted playback, click to activate and enjoy better services.', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '0.01', 0.01, 29.90, 1, '1', 0, 1666746972, 1701768095);
INSERT INTO `vs_dramas_vip` VALUES (5, 3, 3, 'm', 'Monthly pass', '这是月卡', 'Unrestricted playback, click to activate and enjoy better services.', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '28.00', 9.90, 58.00, 1, '1', 0, 1666747303, 1688636757);
INSERT INTO `vs_dramas_vip` VALUES (6, 3, 3, 'y', 'Annual pass', '这是年卡', 'Unrestricted playback, click to activate and enjoy better services.', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '168.00', 69.90, 360.00, 1, '1', 0, 1666747351, 1688636763);
INSERT INTO `vs_dramas_vip` VALUES (7, 3, 4, 'd', '天卡', '这是周卡', '不限制播放，點擊開通獲取更好的服務。', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '0.01', 0.01, 29.90, 1, '1', 0, 1666746972, 1701768095);
INSERT INTO `vs_dramas_vip` VALUES (8, 3, 4, 'm', '月卡', '这是月卡', '不限制播放，點擊開通獲取更好的服務。', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '28.00', 9.90, 58.00, 1, '1', 0, 1666747303, 1688636757);
INSERT INTO `vs_dramas_vip` VALUES (9, 3, 4, 'y', '年卡', '这是年卡', '不限制播放，點擊開通獲取更好的服務。', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '168.00', 69.90, 360.00, 1, '1', 0, 1666747351, 1688636763);
INSERT INTO `vs_dramas_vip` VALUES (10, 3, 5, 'd', 'ข้อแรก: บัตรวัน', '这是周卡', 'การเล่นไว้เสมอ คลิกเพื่อเปิดใช้งานและรับบริการที่ดีกว่า', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '0.01', 0.01, 29.90, 1, '1', 0, 1666746972, 1701768095);
INSERT INTO `vs_dramas_vip` VALUES (11, 3, 5, 'm', 'ข้อสอง: บัตรเดือน', '这是月卡', 'การเล่นไว้เสมอ คลิกเพื่อเปิดใช้งานและรับบริการที่ดีกว่า', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '28.00', 9.90, 58.00, 1, '1', 0, 1666747303, 1688636757);
INSERT INTO `vs_dramas_vip` VALUES (12, 3, 5, 'y', 'ข้อสาม: บัตรปี', '这是年卡', 'การเล่นไว้เสมอ คลิกเพื่อเปิดใช้งานและรับบริการที่ดีกว่า', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '168.00', 69.90, 360.00, 1, '1', 0, 1666747351, 1688636763);
INSERT INTO `vs_dramas_vip` VALUES (13, 3, 7, 'd', 'Tarjeta de un día', '这是周卡', 'Sin restricciones de reproducción, haz clic para activar y obtener un mejor servicio.', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '0.01', 0.01, 29.90, 1, '1', 0, 1666746972, 1701768095);
INSERT INTO `vs_dramas_vip` VALUES (14, 3, 7, 'm', 'Tarjeta mensual', '这是月卡', 'Sin restricciones de reproducción, haz clic para activar y obtener un mejor servicio.', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '28.00', 9.90, 58.00, 1, '1', 0, 1666747303, 1688636757);
INSERT INTO `vs_dramas_vip` VALUES (15, 3, 7, 'y', 'Tarjeta anual', '这是年卡', 'Sin restricciones de reproducción, haz clic para activar y obtener un mejor servicio.', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '168.00', 69.90, 360.00, 1, '1', 0, 1666747351, 1688636763);
INSERT INTO `vs_dramas_vip` VALUES (16, 3, 8, 'd', 'بطاقة يومية', '这是周卡', 'غير مقيد بالتشغيل، انقر للتفعيل والحصول على خدمة أفضل.', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '0.01', 0.01, 29.90, 1, '1', 0, 1666746972, 1701768095);
INSERT INTO `vs_dramas_vip` VALUES (17, 3, 8, 'm', 'بطاقة شهرية', '这是月卡', 'غير مقيد بالتشغيل، انقر للتفعيل والحصول على خدمة أفضل.', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '28.00', 9.90, 58.00, 1, '1', 0, 1666747303, 1688636757);
INSERT INTO `vs_dramas_vip` VALUES (18, 3, 8, 'y', 'بطاقة سنوية', '这是年卡', 'غير مقيد بالتشغيل، انقر للتفعيل والحصول على خدمة أفضل.', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '168.00', 69.90, 360.00, 1, '1', 0, 1666747351, 1688636763);
INSERT INTO `vs_dramas_vip` VALUES (19, 3, 9, 'd', 'Thẻ ngày', '这是周卡', 'Không giới hạn phát, nhấp để đăng ký và nhận dịch vụ tốt hơn.', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '0.01', 0.01, 29.90, 1, '1', 0, 1666746972, 1701768095);
INSERT INTO `vs_dramas_vip` VALUES (20, 3, 9, 'm', 'Thẻ tháng', '这是月卡', 'Không giới hạn phát, nhấp để đăng ký và nhận dịch vụ tốt hơn.', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '28.00', 9.90, 58.00, 1, '1', 0, 1666747303, 1688636757);
INSERT INTO `vs_dramas_vip` VALUES (21, 3, 9, 'y', 'Thẻ năm', '这是年卡', 'Không giới hạn phát, nhấp để đăng ký và nhận dịch vụ tốt hơn.', '{\"VIP影视\":\"免费看\",\"收费影视\":\"优惠看\"}', '168.00', 69.90, 360.00, 1, '1', 0, 1666747351, 1688636763);

-- ----------------------------
-- Table structure for vs_dramas_vip_order
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_vip_order`;
CREATE TABLE `vs_dramas_vip_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `vip_id` int(11) NOT NULL DEFAULT 0 COMMENT 'VIP ID',
  `order_sn` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `user_id` int(11) NULL DEFAULT 0 COMMENT '用户',
  `times` int(11) NULL DEFAULT 0 COMMENT 'VIP时长',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '订单状态:-2=交易关闭,-1=已取消,0=未支付,1=已支付,2=已完成',
  `total_fee` decimal(20, 2) NOT NULL COMMENT '支付金额',
  `pay_fee` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '实际支付金额',
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '货币',
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易单号',
  `payment_json` varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易原始数据',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单备注',
  `pay_type` enum('wechat','alipay','wallet','score','cryptocard','system','paypal','stripe') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式:wechat=微信支付,alipay=支付宝,wallet=钱包支付,score=积分支付,cryptocard=卡密兑换,system=管理员设置,paypal=PayPal,stripe=Stripe',
  `paytime` int(11) NULL DEFAULT NULL COMMENT '支付时间',
  `ext` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附加字段',
  `platform` enum('H5','Web','wxOfficialAccount','wxMiniProgram','App') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台:H5=H5,wxOfficialAccount=微信公众号,wxMiniProgram=微信小程序,Web=Web,App=APP',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_wechat
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_wechat`;
CREATE TABLE `vs_dramas_wechat`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `site_id` int(11) NOT NULL DEFAULT 0 COMMENT '站点',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置类型',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `rules` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规则',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `updatetime` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信管理' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_ems
-- ----------------------------
DROP TABLE IF EXISTS `vs_ems`;
CREATE TABLE `vs_ems`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '事件',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '验证次数',
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '邮箱验证码表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_lang
-- ----------------------------
DROP TABLE IF EXISTS `vs_lang`;
CREATE TABLE `vs_lang`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `lang` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '语言标识',
  `lang_cn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '中文简称',
  `nation_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '电话国际区号',
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货币标准符号',
  `exchange_rate` int(11) NOT NULL COMMENT '积分兑换比例',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '语言包' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_lang
-- ----------------------------
INSERT INTO `vs_lang` VALUES (1, 'zh-cn', '中文简体', '86', 'CNY', 10000);
INSERT INTO `vs_lang` VALUES (3, 'en', '英文', '1', 'USD', 71000);
INSERT INTO `vs_lang` VALUES (4, 'zh-tw', '中文繁体', '85', 'HKD', 9100);
INSERT INTO `vs_lang` VALUES (5, 'taiyu', '泰语', '66', 'THP', 2000);
INSERT INTO `vs_lang` VALUES (7, 'xibanya', '西班牙语', '34', 'ESP', 500);
INSERT INTO `vs_lang` VALUES (8, 'alabo', '阿拉伯语', '97', 'SAR', 19000);
INSERT INTO `vs_lang` VALUES (9, 'yuenan', '越南语', '84', 'VND', 3);

-- ----------------------------
-- Table structure for vs_sites
-- ----------------------------
DROP TABLE IF EXISTS `vs_sites`;
CREATE TABLE `vs_sites`  (
  `site_id` int(11) NOT NULL COMMENT '站点ID',
  `sign` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '站点标识',
  `domain` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '站点域名',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态:normal=正常,hidden=隐藏',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '默认站点:0=否,1=是',
  `expiretime` bigint(20) NOT NULL COMMENT '过期时间',
  `createtime` bigint(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`site_id`) USING BTREE,
  UNIQUE INDEX `sign`(`sign`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '站点' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_sites
-- ----------------------------
INSERT INTO `vs_sites` VALUES (3, 'edum', '', 'normal', 1, 1732344731, 1700722372);

-- ----------------------------
-- Table structure for vs_sms
-- ----------------------------
DROP TABLE IF EXISTS `vs_sms`;
CREATE TABLE `vs_sms`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `lang` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '语言标识',
  `event` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '事件',
  `nation_code` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '86' COMMENT '国际区号',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '验证次数',
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `createtime` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '短信验证码表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_user
-- ----------------------------
DROP TABLE IF EXISTS `vs_user`;
CREATE TABLE `vs_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `site_id` int(11) NOT NULL DEFAULT 0 COMMENT '站点',
  `group_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '组别ID',
  `parent_user_id` int(11) NULL DEFAULT NULL COMMENT '邀请人',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `level` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '等级',
  `gender` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '格言',
  `money` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '余额',
  `score` int(11) NOT NULL DEFAULT 0 COMMENT '积分',
  `usable` int(11) NOT NULL DEFAULT 0 COMMENT '剧场积分',
  `successions` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '连续登录天数',
  `maxsuccessions` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '最大连续登录天数',
  `prevtime` bigint(20) NULL DEFAULT NULL COMMENT '上次登录时间',
  `logintime` bigint(20) NULL DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败次数',
  `joinip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '加入IP',
  `jointime` bigint(20) NULL DEFAULT NULL COMMENT '加入时间',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(20) NULL DEFAULT NULL COMMENT '更新时间',
  `vip_expiretime` bigint(20) NULL DEFAULT NULL COMMENT 'VIP到期时间',
  `token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'Token',
  `mode` enum('guest','user') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'guest' COMMENT '模式:guest=游客,user=用户',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  `verification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  INDEX `email`(`email`) USING BTREE,
  INDEX `mobile`(`mobile`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_user_group
-- ----------------------------
DROP TABLE IF EXISTS `vs_user_group`;
CREATE TABLE `vs_user_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) NOT NULL COMMENT '站点',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '权限节点',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(20) NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员组表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_user_group
-- ----------------------------
INSERT INTO `vs_user_group` VALUES (1, '默认组', '1,2,3,4,5,6,7,8,9,10,11,12', 1491635035, 1491635035, 'normal');

-- ----------------------------
-- Table structure for vs_user_money_log
-- ----------------------------
DROP TABLE IF EXISTS `vs_user_money_log`;
CREATE TABLE `vs_user_money_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `money` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '变更余额',
  `before` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '变更前余额',
  `after` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '变更后余额',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员余额变动表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_user_rule
-- ----------------------------
DROP TABLE IF EXISTS `vs_user_rule`;
CREATE TABLE `vs_user_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(11) NULL DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) NULL DEFAULT NULL COMMENT '是否菜单',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(20) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(11) NULL DEFAULT 0 COMMENT '权重',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员规则表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vs_user_rule
-- ----------------------------
INSERT INTO `vs_user_rule` VALUES (1, 0, 'frontend', 'Frontend', '', 1, 1705649641, 1706852373, 1, 'normal');
INSERT INTO `vs_user_rule` VALUES (2, 6, '/pages/home/index', 'Index', '', 1, 1705649713, 1706856252, 2, 'normal');
INSERT INTO `vs_user_rule` VALUES (3, 6, '/pages/home/user', 'User Center', '', 1, 1705649782, 1707034373, 3, 'normal');
INSERT INTO `vs_user_rule` VALUES (4, 5, '/pages/user/share/index', 'Share', NULL, 1, 1706860828, 1706860828, 4, 'normal');
INSERT INTO `vs_user_rule` VALUES (5, 1, 'user', 'User', '', 1, 1706855942, 1706855942, 12, 'normal');
INSERT INTO `vs_user_rule` VALUES (6, 1, 'drama', 'Drama', '', 1, 1706856239, 1706856239, 11, 'normal');
INSERT INTO `vs_user_rule` VALUES (7, 1, 'current', 'Current', '', 1, 1706856549, 1706856549, 5, 'normal');
INSERT INTO `vs_user_rule` VALUES (8, 1, 'video', 'Video', '', 1, 1706857527, 1706857527, 9, 'normal');
INSERT INTO `vs_user_rule` VALUES (10, 5, '/pages/user/integral/index', 'Wallet usable', '', 1, 1706857937, 1707034015, 10, 'normal');
INSERT INTO `vs_user_rule` VALUES (11, 1, 'market', 'Market', '', 1, 1706858038, 1706858038, 8, 'normal');
INSERT INTO `vs_user_rule` VALUES (12, 1, 'application', 'Application', '', 1, 1706858190, 1706858190, 6, 'normal');
INSERT INTO `vs_user_rule` VALUES (13, 7, '/pages/user/richtext', 'Richtext', '参数是协议id', 1, 1706858478, 1707035046, 14, 'normal');
INSERT INTO `vs_user_rule` VALUES (14, 7, '/pages/video/search', 'Search', '', 1, 1706858497, 1707034686, 26, 'normal');
INSERT INTO `vs_user_rule` VALUES (15, 7, '/pages/user/info/setting', 'Setting', '', 1, 1706858607, 1707034644, 13, 'normal');
INSERT INTO `vs_user_rule` VALUES (18, 11, '/pages/user/member/index', 'vip', '', 1, 1706858804, 1707034554, 18, 'normal');
INSERT INTO `vs_user_rule` VALUES (19, 11, '/pages/user/integral/recharge', 'Usable', '', 1, 1706858816, 1707034535, 19, 'normal');
INSERT INTO `vs_user_rule` VALUES (20, 12, '/pages/user/signin', 'User sign', '', 1, 1706858864, 1707034622, 20, 'normal');
INSERT INTO `vs_user_rule` VALUES (21, 5, '/pages/video/record?id=2', 'Video favorite', '', 1, 1706859362, 1707034054, 21, 'normal');
INSERT INTO `vs_user_rule` VALUES (22, 5, '/pages/video/record?id=1', 'Video log', '', 1, 1706859374, 1707034037, 22, 'normal');
INSERT INTO `vs_user_rule` VALUES (23, 6, '/pages/video/list', 'Category', '参数是分类id', 1, 1706859447, 1707034798, 23, 'normal');
INSERT INTO `vs_user_rule` VALUES (24, 5, '/pages/user/info/index', 'User profile', '', 1, 1706859597, 1707034277, 24, 'normal');
INSERT INTO `vs_user_rule` VALUES (25, 6, '/pages/home/video', 'Recommend', '', 1, 1706859656, 1707034099, 25, 'normal');
INSERT INTO `vs_user_rule` VALUES (26, 11, '/pages/user/dealer/index', 'Reseller', NULL, 1, 1706860828, 1706860828, 26, 'normal');
INSERT INTO `vs_user_rule` VALUES (27, 8, '/pages/video/list', 'Video list', '', 1, 1706860810, 1707034474, 27, 'normal');
INSERT INTO `vs_user_rule` VALUES (28, 8, '/pages/video/play', 'Video detail', '参数是剧的id', 1, 1706860828, 1707034223, 28, 'normal');

-- ----------------------------
-- Table structure for vs_user_score_log
-- ----------------------------
DROP TABLE IF EXISTS `vs_user_score_log`;
CREATE TABLE `vs_user_score_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `score` int(11) NOT NULL DEFAULT 0 COMMENT '变更积分',
  `before` int(11) NOT NULL DEFAULT 0 COMMENT '变更前积分',
  `after` int(11) NOT NULL DEFAULT 0 COMMENT '变更后积分',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员积分变动表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_user_token
-- ----------------------------
DROP TABLE IF EXISTS `vs_user_token`;
CREATE TABLE `vs_user_token`  (
  `token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Token',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `expiretime` bigint(20) NULL DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员Token表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_version
-- ----------------------------
DROP TABLE IF EXISTS `vs_version`;
CREATE TABLE `vs_version`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '包大小',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '强制更新',
  `createtime` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(20) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(11) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '版本表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_copyright
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_copyright`;
CREATE TABLE `vs_dramas_copyright`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '版权方名称',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '版权方图标',
  `intro` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '介绍',
  `ratio` decimal(20, 2) NOT NULL COMMENT '分润比例',
  `total_fee` int(11) NOT NULL DEFAULT 0 COMMENT '总积分',
  `rebate_fee` int(11) NOT NULL DEFAULT 0 COMMENT '分润积分',
  `weigh` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态:normal=显示,hidden=隐藏',
  `updatetime` int(11) NOT NULL COMMENT '更新时间',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '版权分润' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for vs_dramas_copyright_order
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_copyright_order`;
CREATE TABLE `vs_dramas_copyright_order`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `copyright_id` int(11) NOT NULL COMMENT '版权方',
  `order_id` int(11) NOT NULL COMMENT '追剧订单',
  `pay_fee` int(11) NOT NULL DEFAULT 0 COMMENT '支付积分',
  `rebate_fee` int(11) NOT NULL DEFAULT 0 COMMENT '分润积分',
  `ratio` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '分润比例',
  `updatetime` int(11) NOT NULL COMMENT '更新时间',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分润订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for vs_dramas_copyright_rebate
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_copyright_rebate`;
CREATE TABLE `vs_dramas_copyright_rebate`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `copyright_id` int(11) NOT NULL COMMENT '版权方',
  `fee` int(11) NOT NULL DEFAULT 0 COMMENT '提现积分',
  `rebate` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '提现分润',
  `updatetime` int(11) NOT NULL COMMENT '更新时间',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分润记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for vs_dramas_ad
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_ad`;
CREATE TABLE `vs_dramas_ad`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL COMMENT '站点',
  `lang_id` int(11) NOT NULL COMMENT '语言',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '广告标题',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '广告描述',
  `image` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '广告图片',
  `video` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '广告视频',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '广告富媒体',
  `redirect_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '广告链接',
  `createtime` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '广告内容' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_ad_log
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_ad_log`;
CREATE TABLE `vs_dramas_ad_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL COMMENT '站点',
  `user_id` int(11) NOT NULL COMMENT '用户',
  `ad_id` int(11) NOT NULL COMMENT '广告内容',
  `reward` int(11) NOT NULL COMMENT '金币奖励',
  `status` tinyint(1) NOT NULL COMMENT '状态:0=奖励未发放,1=奖励已发放',
  `createtime` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '广告记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vs_dramas_notification
-- ----------------------------
DROP TABLE IF EXISTS `vs_dramas_notification`;
CREATE TABLE `vs_dramas_notification`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `site_id` int(11) NOT NULL COMMENT '站点',
  `lang_id` int(11) NOT NULL DEFAULT 0 COMMENT '语言',
  `platform` enum('H5','App') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发送平台:H5=H5,App=APP',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告图片',
  `parsetpl` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '链接类型:0=外部,1=内部',
  `url_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '内链标题',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告链接',
  `starttime` int(11) NULL DEFAULT NULL COMMENT '开始时间',
  `endtime` int(11) NULL DEFAULT NULL COMMENT '结束时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态:0=关闭,1=启用',
  `weigh` int(11) NULL DEFAULT 0 COMMENT '权重',
  `createtime` int(11) NULL DEFAULT NULL,
  `updatetime` int(11) NULL DEFAULT NULL,
  `deletetime` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '公告通知' ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
