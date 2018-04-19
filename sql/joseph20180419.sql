/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : joseph

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-04-19 18:43:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text,
  `update_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------

-- ----------------------------
-- Table structure for extend_setting
-- ----------------------------
DROP TABLE IF EXISTS `extend_setting`;
CREATE TABLE `extend_setting` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `is_shield_contacter` tinyint(1) DEFAULT '1' COMMENT '是否屏蔽联系人',
  `is_shield_common_contacter` tinyint(1) DEFAULT '1' COMMENT '屏蔽共同联系人',
  `is_msg_preview` tinyint(1) DEFAULT '1' COMMENT '消息预览',
  `is_favour_msg` tinyint(1) DEFAULT '0' COMMENT '朋友圈得到‘赞’用私信通知',
  `is_shake` tinyint(1) DEFAULT '1' COMMENT '有消息是否震动',
  `is_open_circle` tinyint(1) DEFAULT '0' COMMENT '是否开放朋友圈',
  `is_wifi_auto_play` tinyint(1) DEFAULT '0' COMMENT '自动播放',
  `user_id` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of extend_setting
-- ----------------------------
INSERT INTO `extend_setting` VALUES ('1', '1', '1', '1', '0', '1', '0', '0', '1', null);

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES ('1', 'https://s1.ax1x.com/2018/04/10/CF0zgU.jpg', '2018-04-10 15:01:57', null);

-- ----------------------------
-- Table structure for match_info
-- ----------------------------
DROP TABLE IF EXISTS `match_info`;
CREATE TABLE `match_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  `level` tinyint(1) DEFAULT '0' COMMENT '0未有选择，1不喜欢，2喜欢，3超级',
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of match_info
-- ----------------------------
INSERT INTO `match_info` VALUES ('1', '1', '2', '1', '2018-04-19 17:10:16', '2018-04-19 17:42:22');
INSERT INTO `match_info` VALUES ('5', '67', '1', '2', '0000-00-00 00:00:00', null);
INSERT INTO `match_info` VALUES ('3', '1', '4', '1', '2018-04-19 17:42:55', '2018-04-19 17:42:59');
INSERT INTO `match_info` VALUES ('4', '1', '67', '2', '2018-04-19 17:43:09', '2018-04-19 18:31:32');

-- ----------------------------
-- Table structure for match_key
-- ----------------------------
DROP TABLE IF EXISTS `match_key`;
CREATE TABLE `match_key` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '匹配key',
  `key` varchar(20) CHARACTER SET utf8mb4 NOT NULL COMMENT 'id组装，小id_大id',
  `the_former` tinyint(1) DEFAULT '0' COMMENT '小的id计数器，0未有选择，1不喜欢，2喜欢，3超级',
  `the_latter` tinyint(1) DEFAULT '0' COMMENT '大的id计数器，1不喜欢，1喜欢，3超级',
  `is_match` tinyint(1) DEFAULT '0' COMMENT '是否匹配 ，1失败2成功',
  `update_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of match_key
-- ----------------------------

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `question_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `question_desc` varchar(255) DEFAULT NULL COMMENT '问题描述',
  `create_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  PRIMARY KEY (`question_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES ('1', '你喜欢吃饭吗？', '2018-04-10 15:20:45', null);

-- ----------------------------
-- Table structure for setting
-- ----------------------------
DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `distance` tinyint(1) DEFAULT '50' COMMENT '距离范围，单位km',
  `is_enlarge` tinyint(1) DEFAULT '1' COMMENT '是否放大，1放大',
  `sexual_orientation` tinyint(1) DEFAULT '0' COMMENT '性取向0不限 1男 2女 ',
  `age_orientation` tinyint(1) DEFAULT '24' COMMENT '年龄范围，从18以上',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of setting
-- ----------------------------
INSERT INTO `setting` VALUES ('1', '1', '50', '1', '0', '50');

-- ----------------------------
-- Table structure for third_app
-- ----------------------------
DROP TABLE IF EXISTS `third_app`;
CREATE TABLE `third_app` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `app_id` varchar(64) NOT NULL COMMENT '应用app_id',
  `app_secret` varchar(64) NOT NULL COMMENT '应用secret',
  `app_description` varchar(100) DEFAULT NULL COMMENT '应用程序描述',
  `scope` varchar(20) NOT NULL COMMENT '应用权限',
  `scope_description` varchar(100) DEFAULT NULL COMMENT '权限描述',
  `delete_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='访问API的各应用账号密码表';

-- ----------------------------
-- Records of third_app
-- ----------------------------
INSERT INTO `third_app` VALUES ('1', '13726271207', '###043c00e6c7ff021e8cc4d394d3264cb5', 'CMS', '32', 'Super', null, null);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) NOT NULL,
  `password` char(32) NOT NULL,
  `mobile` char(11) DEFAULT NULL,
  `gender` tinyint(1) DEFAULT '0' COMMENT '0未知 1男 2女',
  `birthday` datetime DEFAULT NULL,
  `like` int(11) DEFAULT '0' COMMENT '被喜欢个数',
  `vocation` varchar(20) DEFAULT NULL COMMENT '职业',
  `field` varchar(20) DEFAULT NULL COMMENT '工作领域',
  `come_from` varchar(20) DEFAULT NULL,
  `activity_areas` varchar(20) DEFAULT NULL COMMENT '经常出没',
  `signature` text CHARACTER SET utf8mb4 COMMENT '个人签名',
  `tag` varchar(100) DEFAULT NULL COMMENT '标签',
  `is_member` tinyint(1) DEFAULT '0' COMMENT '1会员',
  `create_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `activity_time` datetime DEFAULT NULL COMMENT '活跃时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '1正常2锁定',
  `openid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '2121', '', '13726271207', '1', '1992-02-29 00:00:00', '0', 'php', '互联网', '珠海', '珠海，澳门', '<p>dsadsadsa</p>', '傻', '0', '2018-04-10 14:44:11', null, '2018-04-19 16:22:51', null, '1', null);
INSERT INTO `user` VALUES ('2', '黑暗使者', '', null, '1', '1992-02-29 00:00:00', '0', null, null, null, null, null, null, '0', '2018-04-12 15:46:17', null, '2018-04-12 15:49:19', null, '1', null);
INSERT INTO `user` VALUES ('3', '白天使者', '', null, '0', '2008-12-29 15:53:17', '0', 'xx', '', null, null, null, null, '0', null, null, null, null, '1', null);
INSERT INTO `user` VALUES ('5', '我只是看帅哥的', '', null, '2', null, '0', null, null, null, null, null, null, '0', null, null, null, null, '1', null);

-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lon` varchar(50) DEFAULT '0' COMMENT '经度；',
  `lat` varchar(50) DEFAULT '0' COMMENT '纬度；',
  `address` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0' COMMENT '是否默认地址，1是',
  `update_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_address
-- ----------------------------
INSERT INTO `user_address` VALUES ('1', '113.5832319144', '22.2763968747', 'xxx', '1', '1', '2018-04-10 14:58:12', null);
INSERT INTO `user_address` VALUES ('2', '113.5584457895', '22.2383977463', 'yyy', '1', '0', '2018-04-10 14:58:16', null);
INSERT INTO `user_address` VALUES ('3', '113.5584457895', '22.2383977463', '珠海', '2', '1', null, null);
INSERT INTO `user_address` VALUES ('4', '113.5584457895', '22.2763968747', '珠海', '3', '1', null, null);
INSERT INTO `user_address` VALUES ('5', '113.5584457895', '22.2383977463', '珠海', '5', '1', null, null);

-- ----------------------------
-- Table structure for user_answer
-- ----------------------------
DROP TABLE IF EXISTS `user_answer`;
CREATE TABLE `user_answer` (
  `answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `qusetion_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `answer_desc` varchar(255) DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`answer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_answer
-- ----------------------------
INSERT INTO `user_answer` VALUES ('1', '1', '1', '我是中国人，当然喜欢', null, '2018-04-10 15:22:43');

-- ----------------------------
-- Table structure for user_friend
-- ----------------------------
DROP TABLE IF EXISTS `user_friend`;
CREATE TABLE `user_friend` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '本人id',
  `friend_id` int(11) NOT NULL DEFAULT '0' COMMENT '好友id',
  `friend_notes` varchar(20) DEFAULT NULL COMMENT '匿名备注',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '假删除标记',
  `deleted_desc` varchar(50) DEFAULT NULL COMMENT '删除原因',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_friend
-- ----------------------------
INSERT INTO `user_friend` VALUES ('1', '1', '67', null, '0', null, '2018-04-19 18:13:40');
INSERT INTO `user_friend` VALUES ('2', '1', '67', null, '0', null, '2018-04-19 18:31:07');
INSERT INTO `user_friend` VALUES ('3', '67', '1', null, '0', null, '2018-04-19 18:31:07');
INSERT INTO `user_friend` VALUES ('4', '1', '67', null, '0', null, '2018-04-19 18:31:23');
INSERT INTO `user_friend` VALUES ('5', '67', '1', null, '0', null, '2018-04-19 18:31:23');
INSERT INTO `user_friend` VALUES ('6', '1', '67', null, '0', null, '2018-04-19 18:31:26');
INSERT INTO `user_friend` VALUES ('7', '67', '1', null, '0', null, '2018-04-19 18:31:26');
INSERT INTO `user_friend` VALUES ('8', '1', '67', null, '0', null, '2018-04-19 18:31:32');
INSERT INTO `user_friend` VALUES ('9', '67', '1', null, '0', null, '2018-04-19 18:31:32');

-- ----------------------------
-- Table structure for user_image
-- ----------------------------
DROP TABLE IF EXISTS `user_image`;
CREATE TABLE `user_image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `img_id` int(11) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of user_image
-- ----------------------------
INSERT INTO `user_image` VALUES ('1', '1', 'https://s1.ax1x.com/2018/04/10/CF0zgU.jpg', '1', null, '32');
INSERT INTO `user_image` VALUES ('2', null, null, '1', null, null);
INSERT INTO `user_image` VALUES ('3', null, 'https://s1.ax1x.com/2018/04/10/CF0zgU.jpg', '3', null, '2');
INSERT INTO `user_image` VALUES ('4', null, null, '4', null, null);
INSERT INTO `user_image` VALUES ('5', null, null, '5', null, null);
INSERT INTO `user_image` VALUES ('6', null, 'https://s1.ax1x.com/2018/04/10/CF0zgU.jpg', '3', null, '1');

-- ----------------------------
-- Table structure for user_interest
-- ----------------------------
DROP TABLE IF EXISTS `user_interest`;
CREATE TABLE `user_interest` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `sport` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `music` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `food` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `movie` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `cartoon` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `travel` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of user_interest
-- ----------------------------
INSERT INTO `user_interest` VALUES ('1', '1', '蹦极', 'only you', '华莱士', '肖生克的救赎', '猫和老鼠', '西藏', '2018-04-10 15:03:19', '2018-04-10 15:03:30');

-- ----------------------------
-- Table structure for user_login_info
-- ----------------------------
DROP TABLE IF EXISTS `user_login_info`;
CREATE TABLE `user_login_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `ipaddr` int(10) unsigned NOT NULL COMMENT '用户登陆IP',
  `login_time` datetime NOT NULL COMMENT '用户登陆时间',
  `pass_wrong_time_status` tinyint(10) unsigned NOT NULL COMMENT '0 正确 2错误',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='登录次数统计';

-- ----------------------------
-- Records of user_login_info
-- ----------------------------
INSERT INTO `user_login_info` VALUES ('1', '1', '2130706433', '2018-04-17 16:02:09', '2');
INSERT INTO `user_login_info` VALUES ('2', '1', '2130706433', '2018-04-17 16:24:41', '0');
INSERT INTO `user_login_info` VALUES ('3', '1', '2130706433', '2018-04-17 16:24:44', '0');
INSERT INTO `user_login_info` VALUES ('4', '1', '2130706433', '2018-04-17 16:24:44', '0');
INSERT INTO `user_login_info` VALUES ('5', '1', '2130706433', '2018-04-17 16:24:45', '0');
INSERT INTO `user_login_info` VALUES ('6', '1', '2130706433', '2018-04-17 16:24:46', '0');
INSERT INTO `user_login_info` VALUES ('7', '1', '2130706433', '2018-04-17 16:26:00', '2');
INSERT INTO `user_login_info` VALUES ('8', '1', '2130706433', '2018-04-17 16:26:01', '2');
INSERT INTO `user_login_info` VALUES ('9', '1', '2130706433', '2018-04-17 16:26:02', '2');
INSERT INTO `user_login_info` VALUES ('10', '1', '2130706433', '2018-04-17 16:26:03', '2');
INSERT INTO `user_login_info` VALUES ('11', '1', '2130706433', '2018-04-17 16:26:04', '2');
