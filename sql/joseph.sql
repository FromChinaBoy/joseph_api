/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : joseph

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-04-10 16:44:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL,
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
  `id` int(11) NOT NULL,
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
-- Table structure for friend_key
-- ----------------------------
DROP TABLE IF EXISTS `friend_key`;
CREATE TABLE `friend_key` (
  `id` int(11) NOT NULL,
  `friend_key` varchar(20) NOT NULL COMMENT '好友关系key',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of friend_key
-- ----------------------------

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image` (
  `id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES ('1', 'https://s1.ax1x.com/2018/04/10/CF0zgU.jpg', '2018-04-10 15:01:57', null);

-- ----------------------------
-- Table structure for match_key
-- ----------------------------
DROP TABLE IF EXISTS `match_key`;
CREATE TABLE `match_key` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '匹配key',
  `key` varchar(20) CHARACTER SET utf8mb4 NOT NULL COMMENT 'id组装，小id_大id',
  `the_former` tinyint(1) DEFAULT '0' COMMENT '小的id计数器，0未有选择，1不喜欢，1喜欢，3超级',
  `the_latter` tinyint(1) DEFAULT '0' COMMENT '大的id计数器，1不喜欢，1喜欢，3超级',
  `is_match` tinyint(1) DEFAULT '0' COMMENT '是否匹配',
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
  `question_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `distance` tinyint(1) DEFAULT '50' COMMENT '距离范围，单位km',
  `is_enlarge` tinyint(1) DEFAULT '1' COMMENT '是否放大，1放大',
  `sexual_orientation` tinyint(1) DEFAULT '3' COMMENT '性取向 1男 2女 3不限',
  `age_orientation` tinyint(1) DEFAULT '24' COMMENT '年龄范围，从18以上',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of setting
-- ----------------------------
INSERT INTO `setting` VALUES ('1', '1', '50', '1', '127', '127');

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
  `signature` varchar(255) DEFAULT NULL COMMENT '个人签名',
  `tag` varchar(100) DEFAULT NULL COMMENT '标签',
  `is_member` tinyint(1) DEFAULT '0' COMMENT '1会员',
  `create_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1正常2锁定',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'zzhpeng', '', '13726271207', '1', '2018-04-10 14:41:58', null, 'php', '互联网', '珠海', '珠海，澳门', '你是猪吗？', '傻', '0', '2018-04-10 14:44:11', null, '2018-04-10 14:44:56', '1');

-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address` (
  `id` int(11) DEFAULT NULL,
  `lon` varchar(50) DEFAULT '0' COMMENT '经度；',
  `lat` varchar(50) DEFAULT '0' COMMENT '纬度；',
  `address` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0' COMMENT '是否默认地址，1是',
  `update_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_address
-- ----------------------------
INSERT INTO `user_address` VALUES ('1', '0', '0', 'xxx', '1', '0', '2018-04-10 14:58:12', null);
INSERT INTO `user_address` VALUES ('2', '0', '0', 'yyy', '1', '0', '2018-04-10 14:58:16', null);

-- ----------------------------
-- Table structure for user_answer
-- ----------------------------
DROP TABLE IF EXISTS `user_answer`;
CREATE TABLE `user_answer` (
  `answer_id` int(11) NOT NULL,
  `qusetion_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `answer_desc` varchar(255) DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`answer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_answer
-- ----------------------------
INSERT INTO `user_answer` VALUES ('1', '1', '1', '我是中国人，当然喜欢', null, '2018-04-10 15:22:43');

-- ----------------------------
-- Table structure for user_image
-- ----------------------------
DROP TABLE IF EXISTS `user_image`;
CREATE TABLE `user_image` (
  `id` int(11) NOT NULL,
  `img_id` int(11) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of user_image
-- ----------------------------
INSERT INTO `user_image` VALUES ('1', '1', 'https://s1.ax1x.com/2018/04/10/CF0zgU.jpg', '1', null, '32');

-- ----------------------------
-- Table structure for user_interest
-- ----------------------------
DROP TABLE IF EXISTS `user_interest`;
CREATE TABLE `user_interest` (
  `id` int(11) NOT NULL,
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
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of user_interest
-- ----------------------------
INSERT INTO `user_interest` VALUES ('1', '1', '蹦极', 'only you', '华莱士', '肖生克的救赎', '猫和老鼠', '西藏', '2018-04-10 15:03:19', '2018-04-10 15:03:30');
