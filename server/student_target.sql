/*
 Navicat Premium Data Transfer

 Source Server         : mysql5.7-3306
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3306
 Source Schema         : student_target

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 12/09/2019 16:07:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for st_classes
-- ----------------------------
DROP TABLE IF EXISTS `st_classes`;
CREATE TABLE `st_classes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `class_name` varchar(60) NOT NULL COMMENT '班级名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for st_questions
-- ----------------------------
DROP TABLE IF EXISTS `st_questions`;
CREATE TABLE `st_questions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` varchar(120) NOT NULL COMMENT '问题',
  `options` varchar(300) DEFAULT NULL COMMENT '选项',
  `answer` varchar(300) NOT NULL COMMENT '答案',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for st_student_targets
-- ----------------------------
DROP TABLE IF EXISTS `st_student_targets`;
CREATE TABLE `st_student_targets` (
  `student_id` int(10) unsigned NOT NULL COMMENT '学生ID',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标ID',
  `isok` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否掌握',
  `ischk` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否审核',
  PRIMARY KEY (`student_id`,`target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for st_students
-- ----------------------------
DROP TABLE IF EXISTS `st_students`;
CREATE TABLE `st_students` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `stu_name` varchar(30) NOT NULL COMMENT '学生名称',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `class_id` int(10) unsigned NOT NULL COMMENT '班级ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for st_targets
-- ----------------------------
DROP TABLE IF EXISTS `st_targets`;
CREATE TABLE `st_targets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(120) NOT NULL COMMENT '标题',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型，0：知识点 1：项目 2：情商',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for st_teachers
-- ----------------------------
DROP TABLE IF EXISTS `st_teachers`;
CREATE TABLE `st_teachers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
