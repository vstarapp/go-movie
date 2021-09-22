/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 100131
 Source Host           : localhost:3306
 Source Schema         : db_gomovie

 Target Server Type    : MySQL
 Target Server Version : 100131
 File Encoding         : 65001

 Date: 22/09/2021 23:56:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_auth_casbin_rule
-- ----------------------------
DROP TABLE IF EXISTS `tb_auth_casbin_rule`;
CREATE TABLE `tb_auth_casbin_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ptype` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `v0` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `v1` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `v2` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '*',
  `v3` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `v4` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `v5` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_index`(`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_category`;
CREATE TABLE `tb_category`  (
  `cat_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `cat_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标志',
  `cat_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `cat_icon` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `cat_pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分类ID',
  `cat_sort` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序（同级有效）',
  `cat_display` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '可见性',
  `cat_meta_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `cat_keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '关键字',
  `cat_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `cat_created_at` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `cat_updated_at` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `cat_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态',
  `cat_navno` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否在导航显示',
  `cat_appno` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否在app显示',
  PRIMARY KEY (`cat_id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`cat_name`) USING BTREE,
  INDEX `pid`(`cat_pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_category
-- ----------------------------
INSERT INTO `tb_category` VALUES (1, 'film', '电影', 'icons-movie', 0, 0, 1, '', '', '', 1631771897, 1631771897, 0, 1, 0);
INSERT INTO `tb_category` VALUES (2, 'dongzuopian', '动作片', NULL, 1, 0, 1, '', '', '', 1631771897, 1631771897, 0, 1, 0);
INSERT INTO `tb_category` VALUES (3, 'aiqingpian', '爱情片', NULL, 1, 0, 1, '', '', '', 1631771897, 1631771897, 0, 1, 0);
INSERT INTO `tb_category` VALUES (5, 'kehuanpian', '科幻片', '', 1, 0, 1, '', '', '', 1631771897, 1631771897, 0, 0, 0);
INSERT INTO `tb_category` VALUES (6, 'kongbupian', '恐怖片', '', 1, 0, 1, '', '', '', 1631772274, 1631772274, 0, 0, 0);
INSERT INTO `tb_category` VALUES (7, 'zhanzhengpian', '战争片', '', 1, 0, 1, '', '', '', 1631773170, 1631773170, 0, 0, 0);
INSERT INTO `tb_category` VALUES (8, 'xijupian', '喜剧片', '', 1, 0, 1, '', '', '', 1631773196, 1631773196, 0, 0, 0);
INSERT INTO `tb_category` VALUES (9, 'juqingpian', '剧情片', '', 1, 0, 1, '', '', '', 1631773212, 1631773212, 0, 0, 0);
INSERT INTO `tb_category` VALUES (10, 'qingsepian', '情色片', '', 1, 0, 1, '', '', '', 1631773242, 1631773242, 0, 0, 0);
INSERT INTO `tb_category` VALUES (11, 'dianshiju', '电视剧', '', 0, 0, 1, '', '', '', 1631773279, 1631773279, 0, 0, 0);
INSERT INTO `tb_category` VALUES (12, 'guochanju', '国产剧', '', 11, 0, 1, '', '', '', 1631773472, 1631773472, 0, 0, 0);
INSERT INTO `tb_category` VALUES (17, 'tianwanju', '台湾剧', '', 11, 0, 1, '', '', '', 1631774217, 1631774217, 0, 0, 0);
INSERT INTO `tb_category` VALUES (18, 'oumeiju', '欧美剧', '', 11, 0, 1, '', '', '', 1631774281, 1631774281, 0, 0, 0);
INSERT INTO `tb_category` VALUES (19, 'ribenju', '日本剧', '', 11, 0, 1, '', '', '', 1631774307, 1631774307, 0, 0, 0);
INSERT INTO `tb_category` VALUES (20, 'xianggangju', '香港剧', '', 11, 0, 1, '', '', '', 1631774325, 1631774325, 0, 0, 0);
INSERT INTO `tb_category` VALUES (21, 'hanguoju', '韩国剧', '', 11, 0, 1, '', '', '', 1631774342, 1631774342, 0, 0, 0);
INSERT INTO `tb_category` VALUES (22, 'haiwaiju', '海外剧', '', 11, 0, 1, '', '', '', 1631774357, 1631774357, 0, 0, 0);

-- ----------------------------
-- Table structure for tb_celebrity
-- ----------------------------
DROP TABLE IF EXISTS `tb_celebrity`;
CREATE TABLE `tb_celebrity`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '中文名',
  `name_en` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '英文名',
  `alt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '条目页 URL',
  `avatars` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '影人头像，分别提供 420px x 600px(大)，140px x 200px(中) 70px x 100px(小)尺寸',
  `summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '简介',
  `gender` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `born_place` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '出生地',
  `professions` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '职业',
  `constellation` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '星座',
  `updated_at` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `created_at` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '影人条目信息' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_movie
-- ----------------------------
DROP TABLE IF EXISTS `tb_movie`;
CREATE TABLE `tb_movie`  (
  `mov_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mov_title` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `mov_area` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地区',
  `mov_category` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '电影类型',
  `mov_language` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '语言',
  `mov_year` year NULL DEFAULT NULL COMMENT '年份',
  `mov_cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '封面URL',
  `mov_display` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '可见性',
  `mov_position` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '推荐位',
  `mov_up` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '顶',
  `mov_down` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '踩',
  `mov_alias` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '别名',
  `mov_hits` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览数量',
  `mov_rate` decimal(2, 1) UNSIGNED NOT NULL DEFAULT 0.0 COMMENT '评分',
  `mov_rating_count` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评分人数',
  `mov_directors` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '导演',
  `mov_screen_writers` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '编剧',
  `mov_actors` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '演员',
  `mov_serialize` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '连载',
  `mov_updated_at` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `mov_created_at` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `mov_status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '状态',
  `mov_resource_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '来源',
  `mov_duration` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '时长',
  `mov_pubdate` date NULL DEFAULT NULL COMMENT '上映日期',
  `mov_pinyin` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '拼音',
  `mov_favorites_count` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '收藏人数',
  PRIMARY KEY (`mov_id`) USING BTREE,
  INDEX `title`(`mov_title`) USING BTREE,
  INDEX `area`(`mov_area`) USING BTREE,
  INDEX `language`(`mov_language`) USING BTREE,
  INDEX `year`(`mov_year`) USING BTREE,
  INDEX `status`(`mov_status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '影片表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_movie
-- ----------------------------
INSERT INTO `tb_movie` VALUES (1, '灵媒', '泰国', '', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 8.0, 0, '班庄·比辛达拿刚 ', ' ', '', '', 1631870686, 1631870686, 0, '', '', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (3, '灵媒', '泰国', '', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 9.0, 0, '班庄·比辛达拿刚', ' ', '', '', 1631984201, 1631984201, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (4, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '班庄·比辛达拿刚', ' ', '', '', 1632032782, 1632032782, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (5, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 9.9, 0, '班庄·比辛达拿刚', ' ', '', '', 1632046211, 1632046211, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (9, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '班庄·比辛达拿刚', ' ', '', '', 1632049726, 1632049726, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (10, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '[\"班庄·比辛达拿刚\"]', '', '', '', 1632069390, 1632069390, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (11, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '[\"班庄·比辛达拿刚\"]', '', '', '', 1632069808, 1632069808, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (12, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '', '', 1632069816, 1632069816, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (13, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632070347, 1632070347, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (14, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632114201, 1632114201, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (15, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632132518, 1632132518, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (16, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632132580, 1632132580, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (17, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632132605, 1632132605, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (18, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632132892, 1632132892, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (19, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632132968, 1632132968, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (20, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632133000, 1632133000, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (21, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, 'https://inews.gtimg.com/newsapp_ls/0/13982049517/0', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632133109, 1632133109, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (22, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, '/public/storage/uploaded/2021_09/c50abe5f23c8331eaff1607c99e85c8e.jpg', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632133168, 1632133168, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (23, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, '/storage/app/uploaded/2021_09/9795b19e739955abe5902b64eb6a68b3.jpg', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 4.0, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632138431, 1632138431, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (24, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, '/public/storage/app/uploaded/2021_09/f1a23e9ec5ebe0dcb48329d34bcfcd89.jpg', 1, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 6.0, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632154679, 1632154679, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (27, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, '/public/storage/app/uploaded/2021_09/60fcf8176f52b5621354217aca7ce462.jpg', 0, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.9, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632234149, 1632234149, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (28, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, '/public/storage/app/uploaded/2021_09/500244244e583f7d27466686171a7818.jpg', 0, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.0, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632234183, 1632234183, 0, '', '91分钟', '0000-00-00', '', 0);
INSERT INTO `tb_movie` VALUES (31, '灵媒', '泰国', '[{\"id\":7,\"name\":\"战争片\"},{\"id\":2,\"name\":\"动作片\"}]', '泰语', 2021, '/public/storage/app/uploaded/2021_09/25649b0435ff6e424ae21367d3c5a9b7.jpg', 0, 0, 0, 0, '萨满(台) 凶灵祭(港) 朗宗', 0, 7.0, 0, '[\"班庄·比辛达拿刚\"]', '[\"罗泓轸\",\"班庄·比辛达拿刚\"]', '[\"纳瑞拉·库尔蒙科尔佩特\",\"萨尼·乌托玛\",\"邦松·纳卡普\",\"Sirani Yankittikan\",\"Yasaka Chaisorn\",\"Arunee Wattana\",\"Thanutphon Boonsang\",\"Pakapol Srirongmuang\",\"Akkaradech Rattanawong\",\"Chatchawat Sanveang\",\"Yossawat Sittiwong\",\"Arnon Losiripanya\",\"Klangchon Chuekham\",\"Sayan Phiwchan\",\"Sakchai Yukhachen\"]', '', 1632235003, 1632235003, 0, '', '91分钟', '0000-00-00', '', 0);

-- ----------------------------
-- Table structure for tb_movie_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_movie_category`;
CREATE TABLE `tb_movie_category`  (
  `mct_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mct_category_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '类型ID',
  `mct_movie_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '电影ID',
  `mct_created_at` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
  `mct_updated_at` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`mct_id`) USING BTREE,
  INDEX `idx_movie_category_id`(`mct_movie_id`, `mct_category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '影片类型表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_movie_category
-- ----------------------------
INSERT INTO `tb_movie_category` VALUES (1, 7, 3, 1631984201, 1631984201);
INSERT INTO `tb_movie_category` VALUES (2, 2, 3, 1631984201, 1631984201);
INSERT INTO `tb_movie_category` VALUES (3, 7, 4, 1632032782, 1632032782);
INSERT INTO `tb_movie_category` VALUES (4, 2, 4, 1632032782, 1632032782);
INSERT INTO `tb_movie_category` VALUES (5, 7, 5, 1632046211, 1632046211);
INSERT INTO `tb_movie_category` VALUES (6, 2, 5, 1632046211, 1632046211);
INSERT INTO `tb_movie_category` VALUES (13, 7, 9, 1632049726, 1632049726);
INSERT INTO `tb_movie_category` VALUES (14, 2, 9, 1632049726, 1632049726);
INSERT INTO `tb_movie_category` VALUES (15, 7, 10, 1632069390, 1632069390);
INSERT INTO `tb_movie_category` VALUES (16, 2, 10, 1632069390, 1632069390);
INSERT INTO `tb_movie_category` VALUES (17, 7, 11, 1632069808, 1632069808);
INSERT INTO `tb_movie_category` VALUES (18, 2, 11, 1632069808, 1632069808);
INSERT INTO `tb_movie_category` VALUES (19, 7, 12, 1632069816, 1632069816);
INSERT INTO `tb_movie_category` VALUES (20, 2, 12, 1632069816, 1632069816);
INSERT INTO `tb_movie_category` VALUES (21, 7, 13, 1632070347, 1632070347);
INSERT INTO `tb_movie_category` VALUES (22, 2, 13, 1632070347, 1632070347);
INSERT INTO `tb_movie_category` VALUES (23, 7, 14, 1632114201, 1632114201);
INSERT INTO `tb_movie_category` VALUES (24, 2, 14, 1632114201, 1632114201);
INSERT INTO `tb_movie_category` VALUES (25, 7, 15, 1632132518, 1632132518);
INSERT INTO `tb_movie_category` VALUES (26, 2, 15, 1632132518, 1632132518);
INSERT INTO `tb_movie_category` VALUES (27, 7, 16, 1632132580, 1632132580);
INSERT INTO `tb_movie_category` VALUES (28, 2, 16, 1632132580, 1632132580);
INSERT INTO `tb_movie_category` VALUES (29, 7, 17, 1632132605, 1632132605);
INSERT INTO `tb_movie_category` VALUES (30, 2, 17, 1632132605, 1632132605);
INSERT INTO `tb_movie_category` VALUES (31, 7, 18, 1632132892, 1632132892);
INSERT INTO `tb_movie_category` VALUES (32, 2, 18, 1632132892, 1632132892);
INSERT INTO `tb_movie_category` VALUES (33, 7, 19, 1632132968, 1632132968);
INSERT INTO `tb_movie_category` VALUES (34, 2, 19, 1632132968, 1632132968);
INSERT INTO `tb_movie_category` VALUES (35, 7, 20, 1632133000, 1632133000);
INSERT INTO `tb_movie_category` VALUES (36, 2, 20, 1632133000, 1632133000);
INSERT INTO `tb_movie_category` VALUES (37, 7, 21, 1632133109, 1632133109);
INSERT INTO `tb_movie_category` VALUES (38, 2, 21, 1632133109, 1632133109);
INSERT INTO `tb_movie_category` VALUES (39, 7, 22, 1632133168, 1632133168);
INSERT INTO `tb_movie_category` VALUES (40, 2, 22, 1632133168, 1632133168);
INSERT INTO `tb_movie_category` VALUES (41, 7, 23, 1632138431, 1632138431);
INSERT INTO `tb_movie_category` VALUES (42, 2, 23, 1632138431, 1632138431);
INSERT INTO `tb_movie_category` VALUES (43, 7, 24, 1632154679, 1632154679);
INSERT INTO `tb_movie_category` VALUES (44, 2, 24, 1632154679, 1632154679);
INSERT INTO `tb_movie_category` VALUES (45, 7, 27, 1632234149, 1632234149);
INSERT INTO `tb_movie_category` VALUES (46, 2, 27, 1632234149, 1632234149);
INSERT INTO `tb_movie_category` VALUES (47, 7, 28, 1632234183, 1632234183);
INSERT INTO `tb_movie_category` VALUES (48, 2, 28, 1632234183, 1632234183);
INSERT INTO `tb_movie_category` VALUES (53, 7, 31, 1632235003, 1632235003);
INSERT INTO `tb_movie_category` VALUES (54, 2, 31, 1632235003, 1632235003);

-- ----------------------------
-- Table structure for tb_movie_comment
-- ----------------------------
DROP TABLE IF EXISTS `tb_movie_comment`;
CREATE TABLE `tb_movie_comment`  (
  `mcm_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `mcm_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `mcm_uid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `mcm_up` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否置顶',
  `mcm_pid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级id',
  `mcm_movie_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '电影id',
  `mcm_status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态 0-待审核，1-显示，2-隐藏',
  `mcm_client_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ipv6最长为128位',
  `mcm_created_at` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
  `mcm_updated_at` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`mcm_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '电影评论表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_movie_comment
-- ----------------------------
INSERT INTO `tb_movie_comment` VALUES (1, '很好看', 0, 0, 0, 1, 1, '::1', 1631954563, 1631954563);
INSERT INTO `tb_movie_comment` VALUES (2, '很好看', 0, 0, 0, 1, 1, '::1', 1631954604, 1631954604);
INSERT INTO `tb_movie_comment` VALUES (3, '很好看', 0, 0, 0, 1, 1, '::1', 1631954728, 1631954728);
INSERT INTO `tb_movie_comment` VALUES (4, '很好看', 0, 0, 0, 1, 1, '::1', 1631954751, 1631954751);
INSERT INTO `tb_movie_comment` VALUES (5, '很好看', 0, 0, 0, 1, 1, '::1', 1631955069, 1631955069);
INSERT INTO `tb_movie_comment` VALUES (6, '很好看', 0, 0, 0, 1, 1, '::1', 1631955362, 1631955362);
INSERT INTO `tb_movie_comment` VALUES (7, '很好看', 0, 0, 0, 1, 1, '::1', 1631955387, 1631955387);
INSERT INTO `tb_movie_comment` VALUES (8, '很好看', 0, 0, 0, 1, 1, '::1', 1631955737, 1631955737);
INSERT INTO `tb_movie_comment` VALUES (9, '很好看', 0, 0, 0, 1, 1, '::1', 1631955770, 1631955770);
INSERT INTO `tb_movie_comment` VALUES (10, '很好看', 0, 0, 0, 1, 1, '::1', 1631955886, 1631955886);
INSERT INTO `tb_movie_comment` VALUES (11, '很好看', 0, 0, 0, 1, 1, '::1', 1631955938, 1631955938);
INSERT INTO `tb_movie_comment` VALUES (12, '很好看', 0, 0, 0, 1, 1, '::1', 1631959507, 1631959507);
INSERT INTO `tb_movie_comment` VALUES (13, '很好看', 0, 0, 0, 1, 1, '::1', 1631959540, 1631959540);
INSERT INTO `tb_movie_comment` VALUES (14, '很好看', 0, 0, 0, 1, 1, '::1', 1631959570, 1631959570);
INSERT INTO `tb_movie_comment` VALUES (15, '很好看', 0, 0, 0, 1, 1, '::1', 1631959989, 1631959989);
INSERT INTO `tb_movie_comment` VALUES (16, '很好看', 0, 0, 0, 1, 1, '::1', 1631964213, 1631964213);
INSERT INTO `tb_movie_comment` VALUES (17, '很好看', 0, 0, 0, 1, 1, '127.0.0.1', 1631964480, 1631964480);
INSERT INTO `tb_movie_comment` VALUES (18, '很好看', 0, 0, 0, 1, 1, '::1', 1631964503, 1631964503);
INSERT INTO `tb_movie_comment` VALUES (19, '很好看', 0, 0, 0, 1, 1, '::1', 1631964545, 1631964545);
INSERT INTO `tb_movie_comment` VALUES (20, '很好看', 0, 0, 0, 1, 1, '::1', 1631964576, 1631964576);
INSERT INTO `tb_movie_comment` VALUES (21, '很好看', 0, 0, 0, 1, 1, '::1', 1631981772, 1631981772);
INSERT INTO `tb_movie_comment` VALUES (22, '很好看', 0, 0, 0, 1, 1, '::1', 1632235471, 1632235471);
INSERT INTO `tb_movie_comment` VALUES (23, 'hh很好看', 0, 0, 0, 1, 1, '::1', 1632235489, 1632235489);

-- ----------------------------
-- Table structure for tb_movie_text
-- ----------------------------
DROP TABLE IF EXISTS `tb_movie_text`;
CREATE TABLE `tb_movie_text`  (
  `mtx_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `mtx_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `mtx_movie_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '电影id',
  `mtx_created_at` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
  `mtx_updated_at` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`mtx_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '电影内容表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_movie_text
-- ----------------------------
INSERT INTO `tb_movie_text` VALUES (1, '讲述泰国乡村里一个受神启示世代相传的巫师家族三个月发生的故事。\n\n《灵媒》电影网友评论：\n1. 趴着睡容易猝死2. 我发现了我们亚洲女的是真的惨 以前只觉得东亚男权社会吃女人 没想到南亚也吃 你说说 这小姑娘得罪谁了 冤有头债有主 怎么这么不讲道理呢3. 小姑娘夜跑好像小猫咪哦 忍不住在吓人片段笑起来了 有点尴尬只好又多笑了几声4. 感觉也不是很恐怖吧 跟同题材的hereditary不能比5. 信仰越浓 生活越穷啊… 不过泰国农村的风光感觉也不错 就是本地人过得太穷了 当然也并不想去旅游 刷刷海岛就好6. 同去的朋友真心实意的以为这是一部纪录片 太惨了小孩 我宣布今天他是新加坡最可爱的人！7. 看完电影快12点 赶上了回家的末班地铁 幸福～\n\n灵媒\n\n伪纪录片的形式，甚至还直接出现了摄影师，看到后来“摄影师们”都那样了还在坚持拍摄甚至开夜视仪，让我不得不感慨他们的职业精神（bushi）。故事讲得真不错，但是其实还是进程中还是有很多断线，不知道是不是导演有意为之，诸如第一次开车路过的疑似尸体、谈话时候几次看上去要提到像“你觉得是谁干的”就切镜了，到后来也都没有再交代。最吓人的其实是仪式前的监视器视频，真到了仪式上反倒没有很恐怖了。最后加的一段Nim的告白我反倒觉得有点画蛇添足。看片尾字幕Orginial Story是罗泓轸，看起来他还真是对萨满的驱魔以及和其他宗教间的联结等等很感兴趣。\n\n灵媒\n\n恐怖個屁 ？泰國妹子被搞到骨骼驚奇全身髒兮兮超讚der !燈光設計很美 ，在家裡架設攝影機的情節是最恐怖的片段 ，讓我回想半夜HBO連播paranormal activy前三集不禁害我夢遺三頃 ！這群拍攝者不救活該死好 ，電影連帶安利一波松下eva攝影機+羅德機頭麥視聽效果多好 。結局加一星 ，有夠雞歪\n\n灵媒\n\n可以说是2021最佳恐怖片了，探讨信或不信的恐怖题材其实挺难呈现的，但是影片中层层递进，带着观众经历信仰一步一步缺失，体验事态一点一点变得失控，最后果不其然是一个bad ending，压抑。P.s.最后那几个家里摄像头拍到的镜头吓死人了??P.P.S.我在院线看的，宝子们不要管我要资源了靴靴配合～\n\n灵媒\n\n女主角的演技可以，暴露、乱性、吃生肉、食婴都有，中途有个极具视觉冲击的镜头是恐怖片的惯例，这放在没有那么抓马的纪录片视角来看还是足以吓到人的，男友觉得这部片后半部分有点像釜山行，ok...好吧 我觉得那个部分真的有够搞笑的 反正没有预期那种恐怖 没有什么吓到腿软有好奇心的放心大胆看就是了\n\n灵媒\n\n班庄老粉万分激动。第一次伪纪录片就交了满分作业！！不愧是拍出我恐怖片单最前的《鬼影》《死神的十字路口》《连体阴》《鬼乱5》《鬼夫》等作品的导演，Every faith can be challenged. 最可怕的是，灵媒都不知自己连接的神是否真的存在、是好是坏。这部恶灵真的超凶。\n\n灵媒\n\n泰韓合拍，微纪录片拍摄形式，前半部还不错，让人能很快信服这个故事，结果后面拉垮得很。。邪灵附体就是变丧尸嘛？摄影小哥也是很敬业，被丧尸咬遍体鳞伤还不掉转镜头拍摄自己穿肠破肚。和其他韩国丧尸片一样，最后都是一把火烧光光。前几天在豆瓣还8.1分，这些打分的人是没看过恐怖片吗？\n\n韩泰台合作的恐怖片真让人大饱眼福。前半段是非常写实细致的东南亚民俗体验，沉浸式体验，到了后半段的高潮你隐隐约约能感受到《哭声》里面细思极恐的体验感和最后喷涌而来的可怕高潮。这应该是近年来最好看的中邪和驱鬼类型题材，这个电影也贡献了教科书般的场面（但观看起来略有不适\n\n在新加坡看的，jump scare全场都有倒吸凉气然后大笑。除此之外真的不太恐怖，恶心更多。宁两次哭，第一次是看到神像的头被砍断在地的恸叫，第二次是哽咽着说可能神从来都没有附身于她，都让我触动。万物有灵，而神和鬼的差别可能也并不是那么大。\n\n(GV Plaza Sing) 吓得我脑壳疼。手持，长镜头，失焦等记录元素是否被滥用？当我们谈及记录时，居于首位的是记录的影像（具有记录元素的画面），还是记录影像的人（只在前半部分作为声音出现后半部分偶有出现的“摄影师”）？\n\n不喜欢伪纪录片，看着晕。摄影师好敬业，值得吗？没想到有裸露镜头，那不是好莱坞的套路嘛，泰国恐怖片也这么卷了吗？好几处jump scare十分可预期，基本就是3，2，1 ，boom。最后丧尸有点出戏\n\n手持风格 头晕脑胀 其实还不错 泰国鬼片传统 帅哥先死 这个帅到只能活在照片里 切掉某镜头可以引进内地 毕竟一个鬼没瞧见全凭主角演技 这故事真是 不要结婚生子 会全家不幸\n\n到尼姆无故在仪式前一天猝死，情况开始恶化崩毁，转为暴力血腥和不管做什么都无能为力的绝望，不仅主持驱魔仪式的法师和所有旗下弟子、敏和尼姆的家人们，\n\n如果你被绑架了，先冲镜头眨眨眼，在做二个后空翻，国际求救手势999次，再来段芭蕾舞，我看到了一定派人来救你\n\n女主角表演滿分！！全員演技在線！但結局團滅略顯浮誇～這是一個白衣阿贊拯救不了美少女的故事??拍得可真好啊！\n\n从纪录片的角度来说 这是非常成功的，从恐怖的角度也是不错的 剪辑很好很好...流畅，配乐喜欢...\n\n最后集体变丧尸的情节十分拉垮，前大半部分很喜欢；关于女萨满的这条线挺有深度的，其实可以多讲一些。\n\n[db:备用说明]', 2, 1631852978, 1631852978);
INSERT INTO `tb_movie_text` VALUES (2, '讲述泰国乡村里一个受神启示世代相传的巫师家族三个月发生的故事。\n\n《灵媒》电影网友评论：\n1. 趴着睡容易猝死2. 我发现了我们亚洲女的是真的惨 以前只觉得东亚男权社会吃女人 没想到南亚也吃 你说说 这小姑娘得罪谁了 冤有头债有主 怎么这么不讲道理呢3. 小姑娘夜跑好像小猫咪哦 忍不住在吓人片段笑起来了 有点尴尬只好又多笑了几声4. 感觉也不是很恐怖吧 跟同题材的hereditary不能比5. 信仰越浓 生活越穷啊… 不过泰国农村的风光感觉也不错 就是本地人过得太穷了 当然也并不想去旅游 刷刷海岛就好6. 同去的朋友真心实意的以为这是一部纪录片 太惨了小孩 我宣布今天他是新加坡最可爱的人！7. 看完电影快12点 赶上了回家的末班地铁 幸福～\n\n灵媒\n\n伪纪录片的形式，甚至还直接出现了摄影师，看到后来“摄影师们”都那样了还在坚持拍摄甚至开夜视仪，让我不得不感慨他们的职业精神（bushi）。故事讲得真不错，但是其实还是进程中还是有很多断线，不知道是不是导演有意为之，诸如第一次开车路过的疑似尸体、谈话时候几次看上去要提到像“你觉得是谁干的”就切镜了，到后来也都没有再交代。最吓人的其实是仪式前的监视器视频，真到了仪式上反倒没有很恐怖了。最后加的一段Nim的告白我反倒觉得有点画蛇添足。看片尾字幕Orginial Story是罗泓轸，看起来他还真是对萨满的驱魔以及和其他宗教间的联结等等很感兴趣。\n\n灵媒\n\n恐怖個屁 ？泰國妹子被搞到骨骼驚奇全身髒兮兮超讚der !燈光設計很美 ，在家裡架設攝影機的情節是最恐怖的片段 ，讓我回想半夜HBO連播paranormal activy前三集不禁害我夢遺三頃 ！這群拍攝者不救活該死好 ，電影連帶安利一波松下eva攝影機+羅德機頭麥視聽效果多好 。結局加一星 ，有夠雞歪\n\n灵媒\n\n可以说是2021最佳恐怖片了，探讨信或不信的恐怖题材其实挺难呈现的，但是影片中层层递进，带着观众经历信仰一步一步缺失，体验事态一点一点变得失控，最后果不其然是一个bad ending，压抑。P.s.最后那几个家里摄像头拍到的镜头吓死人了??P.P.S.我在院线看的，宝子们不要管我要资源了靴靴配合～\n\n灵媒\n\n女主角的演技可以，暴露、乱性、吃生肉、食婴都有，中途有个极具视觉冲击的镜头是恐怖片的惯例，这放在没有那么抓马的纪录片视角来看还是足以吓到人的，男友觉得这部片后半部分有点像釜山行，ok...好吧 我觉得那个部分真的有够搞笑的 反正没有预期那种恐怖 没有什么吓到腿软有好奇心的放心大胆看就是了\n\n灵媒\n\n班庄老粉万分激动。第一次伪纪录片就交了满分作业！！不愧是拍出我恐怖片单最前的《鬼影》《死神的十字路口》《连体阴》《鬼乱5》《鬼夫》等作品的导演，Every faith can be challenged. 最可怕的是，灵媒都不知自己连接的神是否真的存在、是好是坏。这部恶灵真的超凶。\n\n灵媒\n\n泰韓合拍，微纪录片拍摄形式，前半部还不错，让人能很快信服这个故事，结果后面拉垮得很。。邪灵附体就是变丧尸嘛？摄影小哥也是很敬业，被丧尸咬遍体鳞伤还不掉转镜头拍摄自己穿肠破肚。和其他韩国丧尸片一样，最后都是一把火烧光光。前几天在豆瓣还8.1分，这些打分的人是没看过恐怖片吗？\n\n韩泰台合作的恐怖片真让人大饱眼福。前半段是非常写实细致的东南亚民俗体验，沉浸式体验，到了后半段的高潮你隐隐约约能感受到《哭声》里面细思极恐的体验感和最后喷涌而来的可怕高潮。这应该是近年来最好看的中邪和驱鬼类型题材，这个电影也贡献了教科书般的场面（但观看起来略有不适\n\n在新加坡看的，jump scare全场都有倒吸凉气然后大笑。除此之外真的不太恐怖，恶心更多。宁两次哭，第一次是看到神像的头被砍断在地的恸叫，第二次是哽咽着说可能神从来都没有附身于她，都让我触动。万物有灵，而神和鬼的差别可能也并不是那么大。\n\n(GV Plaza Sing) 吓得我脑壳疼。手持，长镜头，失焦等记录元素是否被滥用？当我们谈及记录时，居于首位的是记录的影像（具有记录元素的画面），还是记录影像的人（只在前半部分作为声音出现后半部分偶有出现的“摄影师”）？\n\n不喜欢伪纪录片，看着晕。摄影师好敬业，值得吗？没想到有裸露镜头，那不是好莱坞的套路嘛，泰国恐怖片也这么卷了吗？好几处jump scare十分可预期，基本就是3，2，1 ，boom。最后丧尸有点出戏\n\n手持风格 头晕脑胀 其实还不错 泰国鬼片传统 帅哥先死 这个帅到只能活在照片里 切掉某镜头可以引进内地 毕竟一个鬼没瞧见全凭主角演技 这故事真是 不要结婚生子 会全家不幸\n\n到尼姆无故在仪式前一天猝死，情况开始恶化崩毁，转为暴力血腥和不管做什么都无能为力的绝望，不仅主持驱魔仪式的法师和所有旗下弟子、敏和尼姆的家人们，\n\n如果你被绑架了，先冲镜头眨眨眼，在做二个后空翻，国际求救手势999次，再来段芭蕾舞，我看到了一定派人来救你\n\n女主角表演滿分！！全員演技在線！但結局團滅略顯浮誇～這是一個白衣阿贊拯救不了美少女的故事??拍得可真好啊！\n\n从纪录片的角度来说 这是非常成功的，从恐怖的角度也是不错的 剪辑很好很好...流畅，配乐喜欢...\n\n最后集体变丧尸的情节十分拉垮，前大半部分很喜欢；关于女萨满的这条线挺有深度的，其实可以多讲一些。\n\n[db:备用说明]', 3, 1631853013, 1631853013);
INSERT INTO `tb_movie_text` VALUES (3, '讲述泰国乡村里一个受神启示世代相传的巫师家族三个月发生的故事。\n\n《灵媒》电影网友评论：\n1. 趴着睡容易猝死2. 我发现了我们亚洲女的是真的惨 以前只觉得东亚男权社会吃女人 没想到南亚也吃 你说说 这小姑娘得罪谁了 冤有头债有主 怎么这么不讲道理呢3. 小姑娘夜跑好像小猫咪哦 忍不住在吓人片段笑起来了 有点尴尬只好又多笑了几声4. 感觉也不是很恐怖吧 跟同题材的hereditary不能比5. 信仰越浓 生活越穷啊… 不过泰国农村的风光感觉也不错 就是本地人过得太穷了 当然也并不想去旅游 刷刷海岛就好6. 同去的朋友真心实意的以为这是一部纪录片 太惨了小孩 我宣布今天他是新加坡最可爱的人！7. 看完电影快12点 赶上了回家的末班地铁 幸福～\n\n灵媒\n\n伪纪录片的形式，甚至还直接出现了摄影师，看到后来“摄影师们”都那样了还在坚持拍摄甚至开夜视仪，让我不得不感慨他们的职业精神（bushi）。故事讲得真不错，但是其实还是进程中还是有很多断线，不知道是不是导演有意为之，诸如第一次开车路过的疑似尸体、谈话时候几次看上去要提到像“你觉得是谁干的”就切镜了，到后来也都没有再交代。最吓人的其实是仪式前的监视器视频，真到了仪式上反倒没有很恐怖了。最后加的一段Nim的告白我反倒觉得有点画蛇添足。看片尾字幕Orginial Story是罗泓轸，看起来他还真是对萨满的驱魔以及和其他宗教间的联结等等很感兴趣。\n\n灵媒\n\n恐怖個屁 ？泰國妹子被搞到骨骼驚奇全身髒兮兮超讚der !燈光設計很美 ，在家裡架設攝影機的情節是最恐怖的片段 ，讓我回想半夜HBO連播paranormal activy前三集不禁害我夢遺三頃 ！這群拍攝者不救活該死好 ，電影連帶安利一波松下eva攝影機+羅德機頭麥視聽效果多好 。結局加一星 ，有夠雞歪\n\n灵媒\n\n可以说是2021最佳恐怖片了，探讨信或不信的恐怖题材其实挺难呈现的，但是影片中层层递进，带着观众经历信仰一步一步缺失，体验事态一点一点变得失控，最后果不其然是一个bad ending，压抑。P.s.最后那几个家里摄像头拍到的镜头吓死人了??P.P.S.我在院线看的，宝子们不要管我要资源了靴靴配合～\n\n灵媒\n\n女主角的演技可以，暴露、乱性、吃生肉、食婴都有，中途有个极具视觉冲击的镜头是恐怖片的惯例，这放在没有那么抓马的纪录片视角来看还是足以吓到人的，男友觉得这部片后半部分有点像釜山行，ok...好吧 我觉得那个部分真的有够搞笑的 反正没有预期那种恐怖 没有什么吓到腿软有好奇心的放心大胆看就是了\n\n灵媒\n\n班庄老粉万分激动。第一次伪纪录片就交了满分作业！！不愧是拍出我恐怖片单最前的《鬼影》《死神的十字路口》《连体阴》《鬼乱5》《鬼夫》等作品的导演，Every faith can be challenged. 最可怕的是，灵媒都不知自己连接的神是否真的存在、是好是坏。这部恶灵真的超凶。\n\n灵媒\n\n泰韓合拍，微纪录片拍摄形式，前半部还不错，让人能很快信服这个故事，结果后面拉垮得很。。邪灵附体就是变丧尸嘛？摄影小哥也是很敬业，被丧尸咬遍体鳞伤还不掉转镜头拍摄自己穿肠破肚。和其他韩国丧尸片一样，最后都是一把火烧光光。前几天在豆瓣还8.1分，这些打分的人是没看过恐怖片吗？\n\n韩泰台合作的恐怖片真让人大饱眼福。前半段是非常写实细致的东南亚民俗体验，沉浸式体验，到了后半段的高潮你隐隐约约能感受到《哭声》里面细思极恐的体验感和最后喷涌而来的可怕高潮。这应该是近年来最好看的中邪和驱鬼类型题材，这个电影也贡献了教科书般的场面（但观看起来略有不适\n\n在新加坡看的，jump scare全场都有倒吸凉气然后大笑。除此之外真的不太恐怖，恶心更多。宁两次哭，第一次是看到神像的头被砍断在地的恸叫，第二次是哽咽着说可能神从来都没有附身于她，都让我触动。万物有灵，而神和鬼的差别可能也并不是那么大。\n\n(GV Plaza Sing) 吓得我脑壳疼。手持，长镜头，失焦等记录元素是否被滥用？当我们谈及记录时，居于首位的是记录的影像（具有记录元素的画面），还是记录影像的人（只在前半部分作为声音出现后半部分偶有出现的“摄影师”）？\n\n不喜欢伪纪录片，看着晕。摄影师好敬业，值得吗？没想到有裸露镜头，那不是好莱坞的套路嘛，泰国恐怖片也这么卷了吗？好几处jump scare十分可预期，基本就是3，2，1 ，boom。最后丧尸有点出戏\n\n手持风格 头晕脑胀 其实还不错 泰国鬼片传统 帅哥先死 这个帅到只能活在照片里 切掉某镜头可以引进内地 毕竟一个鬼没瞧见全凭主角演技 这故事真是 不要结婚生子 会全家不幸\n\n到尼姆无故在仪式前一天猝死，情况开始恶化崩毁，转为暴力血腥和不管做什么都无能为力的绝望，不仅主持驱魔仪式的法师和所有旗下弟子、敏和尼姆的家人们，\n\n如果你被绑架了，先冲镜头眨眨眼，在做二个后空翻，国际求救手势999次，再来段芭蕾舞，我看到了一定派人来救你\n\n女主角表演滿分！！全員演技在線！但結局團滅略顯浮誇～這是一個白衣阿贊拯救不了美少女的故事??拍得可真好啊！\n\n从纪录片的角度来说 这是非常成功的，从恐怖的角度也是不错的 剪辑很好很好...流畅，配乐喜欢...\n\n最后集体变丧尸的情节十分拉垮，前大半部分很喜欢；关于女萨满的这条线挺有深度的，其实可以多讲一些。\n\n[db:备用说明]', 4, 1631853087, 1631853087);
INSERT INTO `tb_movie_text` VALUES (4, '讲述泰国乡村里一个受神启示世代相传的巫师家族三个月发生的故事。\n\n《灵媒》电影网友评论：\n1. 趴着睡容易猝死2. 我发现了我们亚洲女的是真的惨 以前只觉得东亚男权社会吃女人 没想到南亚也吃 你说说 这小姑娘得罪谁了 冤有头债有主 怎么这么不讲道理呢3. 小姑娘夜跑好像小猫咪哦 忍不住在吓人片段笑起来了 有点尴尬只好又多笑了几声4. 感觉也不是很恐怖吧 跟同题材的hereditary不能比5. 信仰越浓 生活越穷啊… 不过泰国农村的风光感觉也不错 就是本地人过得太穷了 当然也并不想去旅游 刷刷海岛就好6. 同去的朋友真心实意的以为这是一部纪录片 太惨了小孩 我宣布今天他是新加坡最可爱的人！7. 看完电影快12点 赶上了回家的末班地铁 幸福～\n\n灵媒\n\n伪纪录片的形式，甚至还直接出现了摄影师，看到后来“摄影师们”都那样了还在坚持拍摄甚至开夜视仪，让我不得不感慨他们的职业精神（bushi）。故事讲得真不错，但是其实还是进程中还是有很多断线，不知道是不是导演有意为之，诸如第一次开车路过的疑似尸体、谈话时候几次看上去要提到像“你觉得是谁干的”就切镜了，到后来也都没有再交代。最吓人的其实是仪式前的监视器视频，真到了仪式上反倒没有很恐怖了。最后加的一段Nim的告白我反倒觉得有点画蛇添足。看片尾字幕Orginial Story是罗泓轸，看起来他还真是对萨满的驱魔以及和其他宗教间的联结等等很感兴趣。\n\n灵媒\n\n恐怖個屁 ？泰國妹子被搞到骨骼驚奇全身髒兮兮超讚der !燈光設計很美 ，在家裡架設攝影機的情節是最恐怖的片段 ，讓我回想半夜HBO連播paranormal activy前三集不禁害我夢遺三頃 ！這群拍攝者不救活該死好 ，電影連帶安利一波松下eva攝影機+羅德機頭麥視聽效果多好 。結局加一星 ，有夠雞歪\n\n灵媒\n\n可以说是2021最佳恐怖片了，探讨信或不信的恐怖题材其实挺难呈现的，但是影片中层层递进，带着观众经历信仰一步一步缺失，体验事态一点一点变得失控，最后果不其然是一个bad ending，压抑。P.s.最后那几个家里摄像头拍到的镜头吓死人了??P.P.S.我在院线看的，宝子们不要管我要资源了靴靴配合～\n\n灵媒\n\n女主角的演技可以，暴露、乱性、吃生肉、食婴都有，中途有个极具视觉冲击的镜头是恐怖片的惯例，这放在没有那么抓马的纪录片视角来看还是足以吓到人的，男友觉得这部片后半部分有点像釜山行，ok...好吧 我觉得那个部分真的有够搞笑的 反正没有预期那种恐怖 没有什么吓到腿软有好奇心的放心大胆看就是了\n\n灵媒\n\n班庄老粉万分激动。第一次伪纪录片就交了满分作业！！不愧是拍出我恐怖片单最前的《鬼影》《死神的十字路口》《连体阴》《鬼乱5》《鬼夫》等作品的导演，Every faith can be challenged. 最可怕的是，灵媒都不知自己连接的神是否真的存在、是好是坏。这部恶灵真的超凶。\n\n灵媒\n\n泰韓合拍，微纪录片拍摄形式，前半部还不错，让人能很快信服这个故事，结果后面拉垮得很。。邪灵附体就是变丧尸嘛？摄影小哥也是很敬业，被丧尸咬遍体鳞伤还不掉转镜头拍摄自己穿肠破肚。和其他韩国丧尸片一样，最后都是一把火烧光光。前几天在豆瓣还8.1分，这些打分的人是没看过恐怖片吗？\n\n韩泰台合作的恐怖片真让人大饱眼福。前半段是非常写实细致的东南亚民俗体验，沉浸式体验，到了后半段的高潮你隐隐约约能感受到《哭声》里面细思极恐的体验感和最后喷涌而来的可怕高潮。这应该是近年来最好看的中邪和驱鬼类型题材，这个电影也贡献了教科书般的场面（但观看起来略有不适\n\n在新加坡看的，jump scare全场都有倒吸凉气然后大笑。除此之外真的不太恐怖，恶心更多。宁两次哭，第一次是看到神像的头被砍断在地的恸叫，第二次是哽咽着说可能神从来都没有附身于她，都让我触动。万物有灵，而神和鬼的差别可能也并不是那么大。\n\n(GV Plaza Sing) 吓得我脑壳疼。手持，长镜头，失焦等记录元素是否被滥用？当我们谈及记录时，居于首位的是记录的影像（具有记录元素的画面），还是记录影像的人（只在前半部分作为声音出现后半部分偶有出现的“摄影师”）？\n\n不喜欢伪纪录片，看着晕。摄影师好敬业，值得吗？没想到有裸露镜头，那不是好莱坞的套路嘛，泰国恐怖片也这么卷了吗？好几处jump scare十分可预期，基本就是3，2，1 ，boom。最后丧尸有点出戏\n\n手持风格 头晕脑胀 其实还不错 泰国鬼片传统 帅哥先死 这个帅到只能活在照片里 切掉某镜头可以引进内地 毕竟一个鬼没瞧见全凭主角演技 这故事真是 不要结婚生子 会全家不幸\n\n到尼姆无故在仪式前一天猝死，情况开始恶化崩毁，转为暴力血腥和不管做什么都无能为力的绝望，不仅主持驱魔仪式的法师和所有旗下弟子、敏和尼姆的家人们，\n\n如果你被绑架了，先冲镜头眨眨眼，在做二个后空翻，国际求救手势999次，再来段芭蕾舞，我看到了一定派人来救你\n\n女主角表演滿分！！全員演技在線！但結局團滅略顯浮誇～這是一個白衣阿贊拯救不了美少女的故事??拍得可真好啊！\n\n从纪录片的角度来说 这是非常成功的，从恐怖的角度也是不错的 剪辑很好很好...流畅，配乐喜欢...\n\n最后集体变丧尸的情节十分拉垮，前大半部分很喜欢；关于女萨满的这条线挺有深度的，其实可以多讲一些。\n\n[db:备用说明]', 5, 1631853103, 1631853103);
INSERT INTO `tb_movie_text` VALUES (5, '讲述泰国乡村里一个受神启示世代相传的巫师家族三个月发生的故事。\n\n《灵媒》电影网友评论：\n1. 趴着睡容易猝死2. 我发现了我们亚洲女的是真的惨 以前只觉得东亚男权社会吃女人 没想到南亚也吃 你说说 这小姑娘得罪谁了 冤有头债有主 怎么这么不讲道理呢3. 小姑娘夜跑好像小猫咪哦 忍不住在吓人片段笑起来了 有点尴尬只好又多笑了几声4. 感觉也不是很恐怖吧 跟同题材的hereditary不能比5. 信仰越浓 生活越穷啊… 不过泰国农村的风光感觉也不错 就是本地人过得太穷了 当然也并不想去旅游 刷刷海岛就好6. 同去的朋友真心实意的以为这是一部纪录片 太惨了小孩 我宣布今天他是新加坡最可爱的人！7. 看完电影快12点 赶上了回家的末班地铁 幸福～\n\n灵媒\n\n伪纪录片的形式，甚至还直接出现了摄影师，看到后来“摄影师们”都那样了还在坚持拍摄甚至开夜视仪，让我不得不感慨他们的职业精神（bushi）。故事讲得真不错，但是其实还是进程中还是有很多断线，不知道是不是导演有意为之，诸如第一次开车路过的疑似尸体、谈话时候几次看上去要提到像“你觉得是谁干的”就切镜了，到后来也都没有再交代。最吓人的其实是仪式前的监视器视频，真到了仪式上反倒没有很恐怖了。最后加的一段Nim的告白我反倒觉得有点画蛇添足。看片尾字幕Orginial Story是罗泓轸，看起来他还真是对萨满的驱魔以及和其他宗教间的联结等等很感兴趣。\n\n灵媒\n\n恐怖個屁 ？泰國妹子被搞到骨骼驚奇全身髒兮兮超讚der !燈光設計很美 ，在家裡架設攝影機的情節是最恐怖的片段 ，讓我回想半夜HBO連播paranormal activy前三集不禁害我夢遺三頃 ！這群拍攝者不救活該死好 ，電影連帶安利一波松下eva攝影機+羅德機頭麥視聽效果多好 。結局加一星 ，有夠雞歪\n\n灵媒\n\n可以说是2021最佳恐怖片了，探讨信或不信的恐怖题材其实挺难呈现的，但是影片中层层递进，带着观众经历信仰一步一步缺失，体验事态一点一点变得失控，最后果不其然是一个bad ending，压抑。P.s.最后那几个家里摄像头拍到的镜头吓死人了??P.P.S.我在院线看的，宝子们不要管我要资源了靴靴配合～\n\n灵媒\n\n女主角的演技可以，暴露、乱性、吃生肉、食婴都有，中途有个极具视觉冲击的镜头是恐怖片的惯例，这放在没有那么抓马的纪录片视角来看还是足以吓到人的，男友觉得这部片后半部分有点像釜山行，ok...好吧 我觉得那个部分真的有够搞笑的 反正没有预期那种恐怖 没有什么吓到腿软有好奇心的放心大胆看就是了\n\n灵媒\n\n班庄老粉万分激动。第一次伪纪录片就交了满分作业！！不愧是拍出我恐怖片单最前的《鬼影》《死神的十字路口》《连体阴》《鬼乱5》《鬼夫》等作品的导演，Every faith can be challenged. 最可怕的是，灵媒都不知自己连接的神是否真的存在、是好是坏。这部恶灵真的超凶。\n\n灵媒\n\n泰韓合拍，微纪录片拍摄形式，前半部还不错，让人能很快信服这个故事，结果后面拉垮得很。。邪灵附体就是变丧尸嘛？摄影小哥也是很敬业，被丧尸咬遍体鳞伤还不掉转镜头拍摄自己穿肠破肚。和其他韩国丧尸片一样，最后都是一把火烧光光。前几天在豆瓣还8.1分，这些打分的人是没看过恐怖片吗？\n\n韩泰台合作的恐怖片真让人大饱眼福。前半段是非常写实细致的东南亚民俗体验，沉浸式体验，到了后半段的高潮你隐隐约约能感受到《哭声》里面细思极恐的体验感和最后喷涌而来的可怕高潮。这应该是近年来最好看的中邪和驱鬼类型题材，这个电影也贡献了教科书般的场面（但观看起来略有不适\n\n在新加坡看的，jump scare全场都有倒吸凉气然后大笑。除此之外真的不太恐怖，恶心更多。宁两次哭，第一次是看到神像的头被砍断在地的恸叫，第二次是哽咽着说可能神从来都没有附身于她，都让我触动。万物有灵，而神和鬼的差别可能也并不是那么大。\n\n(GV Plaza Sing) 吓得我脑壳疼。手持，长镜头，失焦等记录元素是否被滥用？当我们谈及记录时，居于首位的是记录的影像（具有记录元素的画面），还是记录影像的人（只在前半部分作为声音出现后半部分偶有出现的“摄影师”）？\n\n不喜欢伪纪录片，看着晕。摄影师好敬业，值得吗？没想到有裸露镜头，那不是好莱坞的套路嘛，泰国恐怖片也这么卷了吗？好几处jump scare十分可预期，基本就是3，2，1 ，boom。最后丧尸有点出戏\n\n手持风格 头晕脑胀 其实还不错 泰国鬼片传统 帅哥先死 这个帅到只能活在照片里 切掉某镜头可以引进内地 毕竟一个鬼没瞧见全凭主角演技 这故事真是 不要结婚生子 会全家不幸\n\n到尼姆无故在仪式前一天猝死，情况开始恶化崩毁，转为暴力血腥和不管做什么都无能为力的绝望，不仅主持驱魔仪式的法师和所有旗下弟子、敏和尼姆的家人们，\n\n如果你被绑架了，先冲镜头眨眨眼，在做二个后空翻，国际求救手势999次，再来段芭蕾舞，我看到了一定派人来救你\n\n女主角表演滿分！！全員演技在線！但結局團滅略顯浮誇～這是一個白衣阿贊拯救不了美少女的故事??拍得可真好啊！\n\n从纪录片的角度来说 这是非常成功的，从恐怖的角度也是不错的 剪辑很好很好...流畅，配乐喜欢...\n\n最后集体变丧尸的情节十分拉垮，前大半部分很喜欢；关于女萨满的这条线挺有深度的，其实可以多讲一些。\n\n[db:备用说明]', 1, 1631870686, 1631870686);
INSERT INTO `tb_movie_text` VALUES (6, '讲述', 3, 1631984201, 1631984201);
INSERT INTO `tb_movie_text` VALUES (7, '讲述', 4, 1632032782, 1632032782);
INSERT INTO `tb_movie_text` VALUES (8, '讲述', 5, 1632046211, 1632046211);
INSERT INTO `tb_movie_text` VALUES (12, '讲述', 9, 1632049726, 1632049726);
INSERT INTO `tb_movie_text` VALUES (13, '讲述', 10, 1632069390, 1632069390);
INSERT INTO `tb_movie_text` VALUES (14, '讲述', 11, 1632069808, 1632069808);
INSERT INTO `tb_movie_text` VALUES (15, '讲述', 12, 1632069816, 1632069816);
INSERT INTO `tb_movie_text` VALUES (16, '讲述', 13, 1632070347, 1632070347);
INSERT INTO `tb_movie_text` VALUES (17, '讲述', 14, 1632114201, 1632114201);
INSERT INTO `tb_movie_text` VALUES (18, '讲述', 15, 1632132518, 1632132518);
INSERT INTO `tb_movie_text` VALUES (19, '讲述', 16, 1632132580, 1632132580);
INSERT INTO `tb_movie_text` VALUES (20, '讲述', 17, 1632132605, 1632132605);
INSERT INTO `tb_movie_text` VALUES (21, '讲述', 18, 1632132892, 1632132892);
INSERT INTO `tb_movie_text` VALUES (22, '讲述', 19, 1632132968, 1632132968);
INSERT INTO `tb_movie_text` VALUES (23, '讲述', 20, 1632133000, 1632133000);
INSERT INTO `tb_movie_text` VALUES (24, '讲述', 21, 1632133109, 1632133109);
INSERT INTO `tb_movie_text` VALUES (25, '讲述', 22, 1632133168, 1632133168);
INSERT INTO `tb_movie_text` VALUES (26, '讲述', 23, 1632138431, 1632138431);
INSERT INTO `tb_movie_text` VALUES (27, '讲述', 24, 1632154679, 1632154679);
INSERT INTO `tb_movie_text` VALUES (28, '讲述', 27, 1632234149, 1632234149);
INSERT INTO `tb_movie_text` VALUES (29, '讲述', 28, 1632234183, 1632234183);
INSERT INTO `tb_movie_text` VALUES (31, '讲述', 31, 0, 0);

-- ----------------------------
-- Table structure for tb_movie_url
-- ----------------------------
DROP TABLE IF EXISTS `tb_movie_url`;
CREATE TABLE `tb_movie_url`  (
  `mul_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mul_movie_url` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mul_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'url标题',
  `mul_movie_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '电影ID',
  `mul_updated_at` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `mul_created_at` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`mul_id`) USING BTREE,
  INDEX `movie_id`(`mul_movie_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '影片地址表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_movie_url
-- ----------------------------
INSERT INTO `tb_movie_url` VALUES (1, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 9, 1632049726, 1632049726);
INSERT INTO `tb_movie_url` VALUES (2, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 9, 1632049726, 1632049726);
INSERT INTO `tb_movie_url` VALUES (3, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 10, 1632069390, 1632069390);
INSERT INTO `tb_movie_url` VALUES (4, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 10, 1632069390, 1632069390);
INSERT INTO `tb_movie_url` VALUES (5, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 11, 1632069808, 1632069808);
INSERT INTO `tb_movie_url` VALUES (6, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 11, 1632069808, 1632069808);
INSERT INTO `tb_movie_url` VALUES (7, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 12, 1632069816, 1632069816);
INSERT INTO `tb_movie_url` VALUES (8, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 12, 1632069816, 1632069816);
INSERT INTO `tb_movie_url` VALUES (9, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 13, 1632070347, 1632070347);
INSERT INTO `tb_movie_url` VALUES (10, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 13, 1632070347, 1632070347);
INSERT INTO `tb_movie_url` VALUES (11, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 14, 1632114201, 1632114201);
INSERT INTO `tb_movie_url` VALUES (12, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 14, 1632114201, 1632114201);
INSERT INTO `tb_movie_url` VALUES (13, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 15, 1632132518, 1632132518);
INSERT INTO `tb_movie_url` VALUES (14, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 15, 1632132518, 1632132518);
INSERT INTO `tb_movie_url` VALUES (15, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 16, 1632132580, 1632132580);
INSERT INTO `tb_movie_url` VALUES (16, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 16, 1632132580, 1632132580);
INSERT INTO `tb_movie_url` VALUES (17, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 17, 1632132605, 1632132605);
INSERT INTO `tb_movie_url` VALUES (18, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 17, 1632132605, 1632132605);
INSERT INTO `tb_movie_url` VALUES (19, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 18, 1632132892, 1632132892);
INSERT INTO `tb_movie_url` VALUES (20, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 18, 1632132892, 1632132892);
INSERT INTO `tb_movie_url` VALUES (21, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 19, 1632132968, 1632132968);
INSERT INTO `tb_movie_url` VALUES (22, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 19, 1632132968, 1632132968);
INSERT INTO `tb_movie_url` VALUES (23, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 20, 1632133000, 1632133000);
INSERT INTO `tb_movie_url` VALUES (24, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 20, 1632133000, 1632133000);
INSERT INTO `tb_movie_url` VALUES (25, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 21, 1632133109, 1632133109);
INSERT INTO `tb_movie_url` VALUES (26, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 21, 1632133109, 1632133109);
INSERT INTO `tb_movie_url` VALUES (27, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 22, 1632133168, 1632133168);
INSERT INTO `tb_movie_url` VALUES (28, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 22, 1632133168, 1632133168);
INSERT INTO `tb_movie_url` VALUES (29, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 23, 1632138431, 1632138431);
INSERT INTO `tb_movie_url` VALUES (30, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 23, 1632138431, 1632138431);
INSERT INTO `tb_movie_url` VALUES (31, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 24, 1632154679, 1632154679);
INSERT INTO `tb_movie_url` VALUES (32, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 24, 1632154679, 1632154679);
INSERT INTO `tb_movie_url` VALUES (33, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 27, 1632234149, 1632234149);
INSERT INTO `tb_movie_url` VALUES (34, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 27, 1632234149, 1632234149);
INSERT INTO `tb_movie_url` VALUES (35, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 28, 1632234183, 1632234183);
INSERT INTO `tb_movie_url` VALUES (36, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 28, 1632234183, 1632234183);
INSERT INTO `tb_movie_url` VALUES (37, 'https://pan.baidu.com/s/1dL-z7qQNzCma2hMbGork1w', '[网盘] 百度云网盘下载，密码：BDYS', 31, 1632235003, 1632235003);
INSERT INTO `tb_movie_url` VALUES (38, 'magnet:?xt=urn:btih:303689d9020e50f61de43d5aef9e533792cecd6a', '[磁力] THE MEDIUM.HD1080P.中字.亿万同人字幕组.MP4', 31, 1632235003, 1632235003);

-- ----------------------------
-- Table structure for tb_oauth_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `tb_oauth_access_tokens`;
CREATE TABLE `tb_oauth_access_tokens`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fr_user_id` int(11) NULL DEFAULT 0 COMMENT '外键:tb_users表id',
  `client_id` int(10) UNSIGNED NULL DEFAULT 1 COMMENT '普通用户的授权，默认为1',
  `token` varchar(600) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `action_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '' COMMENT 'login|refresh|reset表示token生成动作',
  `scopes` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '[*]' COMMENT '暂时预留,未启用',
  `revoked` tinyint(1) NULL DEFAULT 0 COMMENT '是否撤销',
  `client_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ipv6最长为128位',
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_access_tokens_user_id_index`(`fr_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_users
-- ----------------------------
DROP TABLE IF EXISTS `tb_users`;
CREATE TABLE `tb_users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '账号',
  `pass` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '密码',
  `real_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '姓名',
  `phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `remark` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `last_login_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login_ip` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '最近一次登录ip',
  `login_times` int(11) NULL DEFAULT 0 COMMENT '累计登录次数',
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
