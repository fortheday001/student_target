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

 Date: 20/09/2019 08:40:38
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of st_classes
-- ----------------------------
BEGIN;
INSERT INTO `st_classes` VALUES (12, '全栈-18级-12班-第3学期');
INSERT INTO `st_classes` VALUES (13, '全栈-18级-34班-第3学期');
COMMIT;

-- ----------------------------
-- Table structure for st_day_reports
-- ----------------------------
DROP TABLE IF EXISTS `st_day_reports`;
CREATE TABLE `st_day_reports` (
  `student_id` int(10) unsigned NOT NULL COMMENT '学生ID',
  `date` date NOT NULL COMMENT '提交日期',
  `content` varchar(7000) DEFAULT NULL COMMENT '日报内容',
  `plan` varchar(7000) DEFAULT NULL COMMENT '今日计划',
  PRIMARY KEY (`student_id`,`date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of st_day_reports
-- ----------------------------
BEGIN;
INSERT INTO `st_day_reports` VALUES (6, '2019-09-20', '已经学习会 insert', '学习 mysql');
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of st_questions
-- ----------------------------
BEGIN;
INSERT INTO `st_questions` VALUES (1, '能够说出 a 标签的用途。', '', '用来实现页面的跳转。', 1);
INSERT INTO `st_questions` VALUES (2, '能够说出阿里直播的流程', '', '1.开通直播服务 2.注册域名 3.生成直播、播放地址 4.使用 OBS 推流 5.使用 aliplayer 播放视频', 80);
INSERT INTO `st_questions` VALUES (3, '能够说出阿里点播的流程', '', '1.开通点播服务 2.开通 OSS 服务', 80);
INSERT INTO `st_questions` VALUES (4, '能够说出发邮件的流程', '', '1.开通邮件服务', 79);
INSERT INTO `st_questions` VALUES (5, '能够说出发短信的流程', '', '1.开通短信服务', 79);
INSERT INTO `st_questions` VALUES (6, '能够说出支付宝支付的流程', '', '', 78);
INSERT INTO `st_questions` VALUES (7, '能够说出微信支付的流程', '', '', 78);
INSERT INTO `st_questions` VALUES (8, '能够说出 SPU 和 SKU 的概念', '', '', 77);
INSERT INTO `st_questions` VALUES (9, 'RBAC 的表结构是？', '', '', 75);
INSERT INTO `st_questions` VALUES (10, '如何判断一个管理员所拥有的权限？', '', '', 75);
INSERT INTO `st_questions` VALUES (11, '无限级分类的实现原理是？', '', '', 74);
INSERT INTO `st_questions` VALUES (12, '无限级分类的表结构设计是？', '', '', 74);
INSERT INTO `st_questions` VALUES (13, '如何使用递归实现无限级分类？', '', '', 74);
INSERT INTO `st_questions` VALUES (14, '如何使用继承法实现无限级分类？', '', '', 74);
INSERT INTO `st_questions` VALUES (15, '说出至少2种数据传输的格式？', '', '', 72);
INSERT INTO `st_questions` VALUES (16, 'RESTFul API 接口的命名设计原则是？', '', '', 72);
INSERT INTO `st_questions` VALUES (17, '两个表之间有几种关系？', '', '', 69);
INSERT INTO `st_questions` VALUES (18, '使用浮动布局时，如何解决外层元收缩的问题？', '', '', 2);
INSERT INTO `st_questions` VALUES (19, '能够使用浮动布局实现左、中、右布局', '', '', 2);
INSERT INTO `st_questions` VALUES (20, '能够使用 flex 实现左中右布局', '', '', 2);
INSERT INTO `st_questions` VALUES (21, '能够说出固定定位的特点', '', '', 82);
INSERT INTO `st_questions` VALUES (22, '能够说出绝对定位的特点', '', '', 82);
INSERT INTO `st_questions` VALUES (23, '能够说出相对定位的特点', '', '', 82);
INSERT INTO `st_questions` VALUES (24, '能够说出在什么情况下，绝对定们会变成相对定位？相对谁定位？', '', '', 82);
INSERT INTO `st_questions` VALUES (25, 'id 选择器的特点？', '', '', 81);
INSERT INTO `st_questions` VALUES (26, '类选择器的特点？', '', '', 81);
INSERT INTO `st_questions` VALUES (27, '标签选择器的特点？', '', '', 81);
INSERT INTO `st_questions` VALUES (28, 'id、类、标签选择器的优先级是？', '', '', 81);
INSERT INTO `st_questions` VALUES (29, '父子选择器的特点？', '', '', 81);
INSERT INTO `st_questions` VALUES (30, 'div和span标签的区别和用途？', '', '', 1);
INSERT INTO `st_questions` VALUES (31, '过渡的主要用途是？', '', '', 7);
INSERT INTO `st_questions` VALUES (32, 'CSS 中 box-sizing 属性的用途是', '', '', 3);
INSERT INTO `st_questions` VALUES (33, 'CSS 中 padding 属性的用途是', '', '', 3);
INSERT INTO `st_questions` VALUES (34, 'CSS 中 margin 属性的用途是', '', '', 3);
INSERT INTO `st_questions` VALUES (35, 'CSS 中 border 属性的用途是', '', '', 3);
INSERT INTO `st_questions` VALUES (36, 'CSS 中 display 属性的用途是', '', '', 6);
INSERT INTO `st_questions` VALUES (37, 'CSS 中 display 属性常用的值是', '', '', 6);
INSERT INTO `st_questions` VALUES (38, '行级元素的特点', '', '', 6);
INSERT INTO `st_questions` VALUES (39, '块级元素的特点', '', '', 6);
INSERT INTO `st_questions` VALUES (40, '行级块元素的特点', '', '', 6);
INSERT INTO `st_questions` VALUES (41, '如何判断数组的长度', '', '', 10);
INSERT INTO `st_questions` VALUES (42, '如何向数组的最后添加一个元素', '', '', 10);
INSERT INTO `st_questions` VALUES (43, '如何把数组转成字符串', '', '', 10);
INSERT INTO `st_questions` VALUES (44, '如何删除数组中的一个元素', '', '', 10);
INSERT INTO `st_questions` VALUES (45, '如何查找数组中一个元素的下标', '', '', 10);
INSERT INTO `st_questions` VALUES (46, '如何判断一个数组中是否存在一个元素', '', '', 10);
INSERT INTO `st_questions` VALUES (47, 'JS 中都有哪几种数据类型？', '', '', 8);
INSERT INTO `st_questions` VALUES (48, 'JS 中每种数据类型的特点？', '', '', 8);
INSERT INTO `st_questions` VALUES (49, '什么是匿名函数？什么时候使用？', '', '', 14);
INSERT INTO `st_questions` VALUES (50, '什么是递归？你在实现什么功能时使用过？', '', '', 14);
INSERT INTO `st_questions` VALUES (51, '函数中 return 的用途是什么？', '', '', 14);
INSERT INTO `st_questions` VALUES (52, '函数参数在什么时候按引用传值？', '', '', 14);
INSERT INTO `st_questions` VALUES (53, '如何调用一个函数？', '', '', 14);
INSERT INTO `st_questions` VALUES (54, '如果函数中没有 return 那么这个函数的返回值是？', '', '', 14);
INSERT INTO `st_questions` VALUES (55, 'this 代表什么？什么时候用？', '', '', 12);
INSERT INTO `st_questions` VALUES (56, 'call 和 apply 的用途是什么？', '', '', 12);
INSERT INTO `st_questions` VALUES (57, 'call 和 apply 的区别是什么？', '', '', 12);
INSERT INTO `st_questions` VALUES (58, '如何把字符串转成数组？', '', '', 9);
INSERT INTO `st_questions` VALUES (59, '如何得到一个字符串的长度？', '', '', 9);
INSERT INTO `st_questions` VALUES (60, '如何查找一个字符串中是否保存某一个字符？', '', '', 9);
INSERT INTO `st_questions` VALUES (61, '如何在字符串中使用变量？', '', '', 9);
INSERT INTO `st_questions` VALUES (62, '如何连接多个字符串？', '', '', 9);
INSERT INTO `st_questions` VALUES (63, '如何替换一个字符串中的字符？', '', '', 9);
INSERT INTO `st_questions` VALUES (64, '如何截取字符串中的一段字符串？', '', '', 9);
INSERT INTO `st_questions` VALUES (65, '如何修改对象中一个属性的值？', '', '', 11);
INSERT INTO `st_questions` VALUES (66, '如何删除对象中的一个属性？', '', '', 11);
INSERT INTO `st_questions` VALUES (67, '如何通过变量名访问一个对象中的属性值？', '', '', 11);
INSERT INTO `st_questions` VALUES (68, '如何获取当前时间戳？', '', '', 13);
INSERT INTO `st_questions` VALUES (69, '如何获取当前的年份？', '', '', 13);
INSERT INTO `st_questions` VALUES (70, '如何获取当前的月份？', '', '', 13);
INSERT INTO `st_questions` VALUES (71, '如何获取当前的日期？', '', '', 13);
INSERT INTO `st_questions` VALUES (72, '如何获取随机数？', '', '', 13);
INSERT INTO `st_questions` VALUES (73, '如何向上取整？', '', '', 13);
INSERT INTO `st_questions` VALUES (74, '如何向下取整？', '', '', 13);
INSERT INTO `st_questions` VALUES (75, 'JS 操作样式时，属性名称有什么要求？', '', '', 17);
INSERT INTO `st_questions` VALUES (76, '如何通过 JS 设置一个元素在页面中的位置？', '', '', 17);
INSERT INTO `st_questions` VALUES (77, '如何通过 JS 设置一个元素的背景色？', '', '', 17);
INSERT INTO `st_questions` VALUES (78, 'JS 查找 DOM 元素有几种方法？', '', '', 15);
INSERT INTO `st_questions` VALUES (79, 'JS 如何根据 ID 查找元素', '', '', 15);
INSERT INTO `st_questions` VALUES (80, 'JS 如何根据 class 查找元素', '', '', 15);
INSERT INTO `st_questions` VALUES (81, '如何删除一个元素？', '', '', 16);
INSERT INTO `st_questions` VALUES (82, '如何创建一个元素？', '', '', 16);
INSERT INTO `st_questions` VALUES (83, '如何将一个新创建的元素添加到页面中？', '', '', 16);
INSERT INTO `st_questions` VALUES (84, '如何向一个元素中添加一个子元素？', '', '', 16);
INSERT INTO `st_questions` VALUES (85, '如何使用 JS 实现页面的跳转？', '', '', 19);
INSERT INTO `st_questions` VALUES (86, '如何使用 JS 返回上一个页面？', '', '', 19);
INSERT INTO `st_questions` VALUES (87, '如何使用 JS 刷新当前页面？', '', '', 19);
INSERT INTO `st_questions` VALUES (88, '能够说出 setTimeout 和 setInterval 的区别？', '', '', 20);
INSERT INTO `st_questions` VALUES (89, '如何清除一个定时器？', '', '', 20);
INSERT INTO `st_questions` VALUES (90, '能够说出异步程序的特点？', '', '', 20);
INSERT INTO `st_questions` VALUES (91, '使用 let 定义变量的特点？', '', '', 22);
INSERT INTO `st_questions` VALUES (92, '使用 const 定义常量的特点？', '', '', 22);
INSERT INTO `st_questions` VALUES (93, '如何拷贝一个对象？', '', '', 23);
INSERT INTO `st_questions` VALUES (94, '什么是对象解析？', '', '', 23);
INSERT INTO `st_questions` VALUES (95, 'Promise 是干什么用的？', '', '', 26);
INSERT INTO `st_questions` VALUES (96, '使用 Promise 封装异步操作？', '', '', 26);
INSERT INTO `st_questions` VALUES (97, '使用 async...await 将异步改写成同步？', '', '', 27);
INSERT INTO `st_questions` VALUES (98, 'Node 中 exports 和 module.exports 的区别？', '', '', 28);
INSERT INTO `st_questions` VALUES (99, '什么是 AJAX？', '', '', 21);
INSERT INTO `st_questions` VALUES (100, 'AJAX 是干什么用的？', '', '', 21);
INSERT INTO `st_questions` VALUES (101, '如何实现 AJAX？', '', '', 21);
INSERT INTO `st_questions` VALUES (102, '如果 npm 下载速度很慢，有什么解决办法？', '', '', 31);
INSERT INTO `st_questions` VALUES (103, '使用 npm 发布自定义模块的步骤？', '', '', 31);
INSERT INTO `st_questions` VALUES (104, '依赖包和开发依赖包的区别？', '', '', 31);
INSERT INTO `st_questions` VALUES (105, '如何安装开发依赖包？', '', '', 31);
INSERT INTO `st_questions` VALUES (106, '全局安装与本地安装的区别？', '', '', 31);
INSERT INTO `st_questions` VALUES (107, '全局安装的特点？', '', '', 31);
INSERT INTO `st_questions` VALUES (108, '本地安装的特点？', '', '', 31);
INSERT INTO `st_questions` VALUES (109, '{{ }} 的用途是？', '', '', 38);
INSERT INTO `st_questions` VALUES (110, 'v-model 的用途是？', '', '', 38);
INSERT INTO `st_questions` VALUES (111, 'v-if 的用途是？', '', '', 38);
INSERT INTO `st_questions` VALUES (112, 'v-show 的用途是？', '', '', 38);
INSERT INTO `st_questions` VALUES (113, 'v-on 的用途是？', '', '', 38);
INSERT INTO `st_questions` VALUES (114, 'v-bind 的用途是？', '', '', 38);
INSERT INTO `st_questions` VALUES (115, 'v-for 的用途是？', '', '', 38);
INSERT INTO `st_questions` VALUES (116, '生命周期方法的特点？', '', '', 39);
INSERT INTO `st_questions` VALUES (117, 'created 和 mounted 两个方法的用途？', '', '', 39);
INSERT INTO `st_questions` VALUES (118, '计算属性的特点？', '', '', 40);
INSERT INTO `st_questions` VALUES (119, '计算属性的用途？', '', '', 40);
INSERT INTO `st_questions` VALUES (120, '什么时候需要使用计算属性？', '', '', 40);
INSERT INTO `st_questions` VALUES (121, '什么是监听器？', '', '', 40);
INSERT INTO `st_questions` VALUES (122, '什么时候使用监听器？', '', '', 40);
INSERT INTO `st_questions` VALUES (123, '什么是深度监听？怎么使用？', '', '', 40);
INSERT INTO `st_questions` VALUES (124, '单文件组件有什么特点？', '', '', 41);
INSERT INTO `st_questions` VALUES (125, '组件属性的用途是？', '', '', 41);
INSERT INTO `st_questions` VALUES (126, '如何在组件中使用属性？', '', '', 41);
INSERT INTO `st_questions` VALUES (127, '如何定义属性的数据类型？', '', '', 41);
INSERT INTO `st_questions` VALUES (128, '组件事件的用途是？', '', '', 41);
INSERT INTO `st_questions` VALUES (129, '如何触发组件事件？', '', '', 41);
INSERT INTO `st_questions` VALUES (130, '组件插槽的用途是？', '', '', 41);
INSERT INTO `st_questions` VALUES (131, '匿名插槽和具名插槽的特点？', '', '', 41);
INSERT INTO `st_questions` VALUES (132, 'router-link 标签的用途？', '', '', 45);
INSERT INTO `st_questions` VALUES (133, 'router-view 标签的用途？', '', '', 45);
INSERT INTO `st_questions` VALUES (134, '嵌套路由的用法？', '', '', 45);
INSERT INTO `st_questions` VALUES (135, '路由守卫的用途？', '', '', 45);
INSERT INTO `st_questions` VALUES (136, 'vuex 中 state 的用途？', '', '', 46);
INSERT INTO `st_questions` VALUES (137, 'vuex 中 mutations 的用途？', '', '', 46);
INSERT INTO `st_questions` VALUES (138, 'vuex 中 getters 的用途？', '', '', 46);
INSERT INTO `st_questions` VALUES (139, 'vuex 中 actions 的用途？', '', '', 46);
INSERT INTO `st_questions` VALUES (140, 'vuex 中 命名空间 的用途？', '', '', 46);
INSERT INTO `st_questions` VALUES (141, '单文件组件特点？', '', '', 47);
INSERT INTO `st_questions` VALUES (142, '如何实现单文件组件？', '', '', 47);
INSERT INTO `st_questions` VALUES (143, '请求接口时 GET、POST、PUT、DELETE 四种方法的用途？', '', '', 48);
INSERT INTO `st_questions` VALUES (144, 'axios 中拦截器的用途？', '', '', 48);
INSERT INTO `st_questions` VALUES (145, '什么是 AJAX 跨域？如何实现 AJAX 跨域？', '', '', 48);
INSERT INTO `st_questions` VALUES (146, '调用接口传输数据时常用的数据结构？', '', '', 48);
INSERT INTO `st_questions` VALUES (147, '什么是协议？干什么用的？', '', '', 56);
INSERT INTO `st_questions` VALUES (148, 'HTTP 协议的基本格式？', '', '', 56);
INSERT INTO `st_questions` VALUES (149, '如何查看 HTTP 协议的内容？', '', '', 56);
INSERT INTO `st_questions` VALUES (150, 'Node 中 http 模块的用途？', '', '', 57);
INSERT INTO `st_questions` VALUES (151, '使用 http 模块启动 web 服务器流程？', '', '', 57);
INSERT INTO `st_questions` VALUES (152, 'Koa 的用途？', '', '', 58);
INSERT INTO `st_questions` VALUES (153, 'Koa 中 use 方法的用途？', '', '', 58);
INSERT INTO `st_questions` VALUES (154, 'Koa 中如何设置响应的数据？', '', '', 58);
INSERT INTO `st_questions` VALUES (155, 'Koa 中如何解析 body 中的数据？', '', '', 59);
INSERT INTO `st_questions` VALUES (156, 'Koa 中如何获取 URL 上查询字符串中的参数？', '', '', 59);
INSERT INTO `st_questions` VALUES (157, 'Koa 中如何解析 URL 中 path 上的参数？', '', '', 59);
INSERT INTO `st_questions` VALUES (158, '如何实现 AJAX 跨域？', '', '', 60);
INSERT INTO `st_questions` VALUES (159, '实现 AJAX 跨域有几种方法？', '', '', 60);
INSERT INTO `st_questions` VALUES (160, '如何上传文件？流程？', '', '', 61);
INSERT INTO `st_questions` VALUES (161, '为什么要进行图像的处理？', '', '', 61);
INSERT INTO `st_questions` VALUES (162, '一般网站中如何处理图像？', '', '', 61);
INSERT INTO `st_questions` VALUES (163, '什么是 JWT ？', '', '', 62);
INSERT INTO `st_questions` VALUES (164, 'JWT 是干什么用的？', '', '', 62);
INSERT INTO `st_questions` VALUES (165, '如何生成 JWT ？', '', '', 62);
INSERT INTO `st_questions` VALUES (166, '如何验证 JWT ？', '', '', 62);
INSERT INTO `st_questions` VALUES (167, '建表时常用的几种数据类型是什么？', '', '', 63);
INSERT INTO `st_questions` VALUES (168, 'char 和 varchar 如何选择？', '', '', 63);
INSERT INTO `st_questions` VALUES (169, 'int 和 tinyint 有什么区别？', '', '', 63);
INSERT INTO `st_questions` VALUES (170, '什么时候使用 tinyint ？', '', '', 63);
INSERT INTO `st_questions` VALUES (171, '如何使用 insert 批量插入数据？', '', '', 64);
INSERT INTO `st_questions` VALUES (172, 'replace into 的用途是？', '', '', 64);
INSERT INTO `st_questions` VALUES (173, '使用 update 修改数据的语句是？', '', '', 64);
INSERT INTO `st_questions` VALUES (174, '使用 delete 删除数据的语句是？', '', '', 64);
INSERT INTO `st_questions` VALUES (175, '一个完整的 SQL 都有哪些关键字？顺序是？', '', '', 65);
INSERT INTO `st_questions` VALUES (176, 'SQL 中 limit 的用途是？', '', '', 65);
INSERT INTO `st_questions` VALUES (177, 'SQL 中 having 的用途是？', '', '', 65);
INSERT INTO `st_questions` VALUES (178, 'SQL 中 group by 的用途是？', '', '', 65);
INSERT INTO `st_questions` VALUES (179, 'SQL 中 order by 的用途是？', '', '', 65);
INSERT INTO `st_questions` VALUES (180, '外连接和内连接的特点是？', '', '', 67);
INSERT INTO `st_questions` VALUES (181, 'left join 的连接语法是？', '', '', 67);
INSERT INTO `st_questions` VALUES (182, '两张表之间有几种关系？', '', '', 69);
INSERT INTO `st_questions` VALUES (183, '什么是外键？什么时候使用？', '', '', 69);
INSERT INTO `st_questions` VALUES (184, '什么是中间表？什么时候使用？', '', '', 69);
INSERT INTO `st_questions` VALUES (185, '请写出卖。。', 'a. xxx\nb.xx\nc..\n参数地址：http://www.baidu.com', 'adfdsaa. xxx\nb.xx\nc..\n参数地址：http://www.baidu.com', 90);
COMMIT;

-- ----------------------------
-- Table structure for st_steps
-- ----------------------------
DROP TABLE IF EXISTS `st_steps`;
CREATE TABLE `st_steps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `step_name` varchar(60) NOT NULL COMMENT '阶段名称',
  `step_desc` varchar(1200) NOT NULL COMMENT '阶段描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of st_steps
-- ----------------------------
BEGIN;
INSERT INTO `st_steps` VALUES (1, '01.第3学期第1阶段 - 能够独立完成小型项目', '独立完成是指：独立设计数据库，独立编写接口文档，独立编写后端接口程序，独立完成前端程序\n-- | -- \n小型项目是指：有登录功能、有简单的权限、有几个表的增、删、改、查、翻页、搜索');
INSERT INTO `st_steps` VALUES (2, '02.第3学期第2阶段 - 能够独立完成复杂的项目', '复杂的项目是指：拥有复杂业务逻辑的项目，如无限级分类、RBAC等，比如商城系统，视频直播、点播系统等。');
INSERT INTO `st_steps` VALUES (3, '03.第3学期第3阶段 - 能够使用 uniapp 实现前端项目', 'uniapp 是一个框架，基于 vue ，可以“写一套代码，编译出小程序、H5、android、ios 等多端的框架”。\n可以用来快速进行移动端的开发。');
COMMIT;

-- ----------------------------
-- Table structure for st_student_targets
-- ----------------------------
DROP TABLE IF EXISTS `st_student_targets`;
CREATE TABLE `st_student_targets` (
  `student_id` int(10) unsigned NOT NULL COMMENT '学生ID',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标ID',
  `isok` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否掌握',
  `ischk` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否审核',
  `opt_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
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
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of st_students
-- ----------------------------
BEGIN;
INSERT INTO `st_students` VALUES (6, '吴巧英', '123456', 12);
INSERT INTO `st_students` VALUES (7, '许邓璇', '123456', 12);
INSERT INTO `st_students` VALUES (8, '欧阳萱', '123456', 12);
INSERT INTO `st_students` VALUES (9, '陈思蒙', '123456', 12);
INSERT INTO `st_students` VALUES (10, '李晓雨', '123456', 12);
INSERT INTO `st_students` VALUES (11, '李玉娇', '123456', 12);
INSERT INTO `st_students` VALUES (12, '杜佳凝', '123456', 12);
INSERT INTO `st_students` VALUES (13, '贺晓燕', '123456', 12);
INSERT INTO `st_students` VALUES (14, '赵艳华', '123456', 12);
INSERT INTO `st_students` VALUES (15, '王永红', '123456', 12);
INSERT INTO `st_students` VALUES (16, '徐丹', '123456', 12);
INSERT INTO `st_students` VALUES (17, '刘少华', '123456', 12);
INSERT INTO `st_students` VALUES (18, '田玉月', '123456', 12);
INSERT INTO `st_students` VALUES (19, '刘会珍', '123456', 12);
INSERT INTO `st_students` VALUES (20, '袁美庆', '123456', 12);
INSERT INTO `st_students` VALUES (21, '包雅伦', '123456', 12);
INSERT INTO `st_students` VALUES (22, '李施莹', '123456', 12);
INSERT INTO `st_students` VALUES (23, '江山', '123456', 12);
INSERT INTO `st_students` VALUES (24, '周莹', '123456', 12);
INSERT INTO `st_students` VALUES (25, '董博文', '123456', 12);
INSERT INTO `st_students` VALUES (26, '车梦肖', '123456', 12);
INSERT INTO `st_students` VALUES (27, '夏克斌', '123456', 12);
INSERT INTO `st_students` VALUES (28, '梁国平', '123456', 12);
INSERT INTO `st_students` VALUES (29, '白钧午', '123456', 12);
INSERT INTO `st_students` VALUES (30, '王海龙', '123456', 12);
INSERT INTO `st_students` VALUES (31, '冯志浩', '123456', 12);
INSERT INTO `st_students` VALUES (32, '吴峰', '123456', 12);
INSERT INTO `st_students` VALUES (33, '杨易', '123456', 12);
INSERT INTO `st_students` VALUES (34, '刘一帆', '123456', 12);
INSERT INTO `st_students` VALUES (35, '颜豪', '123456', 12);
INSERT INTO `st_students` VALUES (36, '吴泽华', '123456', 12);
INSERT INTO `st_students` VALUES (37, '黄帅伟', '123456', 12);
INSERT INTO `st_students` VALUES (38, '师文博', '123456', 12);
INSERT INTO `st_students` VALUES (39, '王丁耀', '123456', 12);
INSERT INTO `st_students` VALUES (40, '王义', '123456', 12);
INSERT INTO `st_students` VALUES (41, '李铖', '123456', 12);
INSERT INTO `st_students` VALUES (42, '黄波', '123456', 12);
INSERT INTO `st_students` VALUES (43, '罗文', '123456', 12);
INSERT INTO `st_students` VALUES (44, '李俊', '123456', 12);
INSERT INTO `st_students` VALUES (45, '胡江浩', '123456', 12);
INSERT INTO `st_students` VALUES (46, '张朝唐', '123456', 12);
INSERT INTO `st_students` VALUES (47, '陈泽军', '123456', 12);
INSERT INTO `st_students` VALUES (48, '周云卓', '123456', 12);
INSERT INTO `st_students` VALUES (49, '张庭叙', '123456', 12);
INSERT INTO `st_students` VALUES (50, '张宇', '123456', 12);
INSERT INTO `st_students` VALUES (51, '艾久文', '123456', 12);
INSERT INTO `st_students` VALUES (52, '樊宝华', '123456', 12);
INSERT INTO `st_students` VALUES (53, '胡庆丰', '123456', 12);
INSERT INTO `st_students` VALUES (54, '霍尧遥', '123456', 12);
INSERT INTO `st_students` VALUES (55, '袁铭望', '123456', 12);
INSERT INTO `st_students` VALUES (56, '党元应', '123456', 12);
INSERT INTO `st_students` VALUES (57, '陈愷', '123456', 12);
INSERT INTO `st_students` VALUES (58, '吕博扬', '123456', 12);
INSERT INTO `st_students` VALUES (59, '李雨晨', '123456', 12);
INSERT INTO `st_students` VALUES (60, '冯景雪松', '123456', 12);
INSERT INTO `st_students` VALUES (61, '高浩', '123456', 12);
INSERT INTO `st_students` VALUES (62, '刘孝天', '123456', 12);
INSERT INTO `st_students` VALUES (63, '李波', '123456', 12);
INSERT INTO `st_students` VALUES (64, '刘晨思', '123456', 13);
INSERT INTO `st_students` VALUES (65, '孙楠', '123456', 13);
INSERT INTO `st_students` VALUES (66, '樊鲢莲', '123456', 13);
INSERT INTO `st_students` VALUES (67, '刘敏', '123456', 13);
INSERT INTO `st_students` VALUES (68, '马鑫鑫', '123456', 13);
INSERT INTO `st_students` VALUES (69, '任艳艳', '123456', 13);
INSERT INTO `st_students` VALUES (70, '贾炅辉', '123456', 13);
INSERT INTO `st_students` VALUES (71, '刘妍君', '123456', 13);
INSERT INTO `st_students` VALUES (72, '蒋婷', '123456', 13);
INSERT INTO `st_students` VALUES (73, '张冰雪', '123456', 13);
INSERT INTO `st_students` VALUES (74, '常可欣', '123456', 13);
INSERT INTO `st_students` VALUES (75, '巴木子', '123456', 13);
INSERT INTO `st_students` VALUES (76, '王慧丽', '123456', 13);
INSERT INTO `st_students` VALUES (77, '朱碧莹', '123456', 13);
INSERT INTO `st_students` VALUES (78, '马东', '123456', 13);
INSERT INTO `st_students` VALUES (79, '刘硕', '123456', 13);
INSERT INTO `st_students` VALUES (80, '李勇', '123456', 13);
INSERT INTO `st_students` VALUES (81, '吴晋龙', '123456', 13);
INSERT INTO `st_students` VALUES (82, '李远东', '123456', 13);
INSERT INTO `st_students` VALUES (83, '杨依亮', '123456', 13);
INSERT INTO `st_students` VALUES (84, '王永晨', '123456', 13);
INSERT INTO `st_students` VALUES (85, '郭程', '123456', 13);
INSERT INTO `st_students` VALUES (86, '龚玉辰', '123456', 13);
INSERT INTO `st_students` VALUES (87, '安政宁', '123456', 13);
INSERT INTO `st_students` VALUES (88, '王鹏为', '123456', 13);
INSERT INTO `st_students` VALUES (89, '肖乐融', '123456', 13);
INSERT INTO `st_students` VALUES (90, '舒榆衡', '123456', 13);
INSERT INTO `st_students` VALUES (91, '于景尧', '123456', 13);
INSERT INTO `st_students` VALUES (92, '李嘉鹏', '123456', 13);
INSERT INTO `st_students` VALUES (93, '邓鹏鑫', '123456', 13);
INSERT INTO `st_students` VALUES (94, '郭凯', '123456', 13);
INSERT INTO `st_students` VALUES (95, '钟林国', '123456', 13);
INSERT INTO `st_students` VALUES (96, '王明仁', '123456', 13);
INSERT INTO `st_students` VALUES (97, '高源', '123456', 13);
INSERT INTO `st_students` VALUES (98, '伍浙江', '123456', 13);
INSERT INTO `st_students` VALUES (99, '徐子笙', '123456', 13);
INSERT INTO `st_students` VALUES (100, '王熙钰', '123456', 13);
INSERT INTO `st_students` VALUES (101, '王永强', '123456', 13);
INSERT INTO `st_students` VALUES (102, '关瑞', '123456', 13);
INSERT INTO `st_students` VALUES (103, '李振龙', '123456', 13);
INSERT INTO `st_students` VALUES (104, '刘昌', '123456', 13);
INSERT INTO `st_students` VALUES (105, '刘帆', '123456', 13);
INSERT INTO `st_students` VALUES (106, '薛佳昊', '123456', 13);
INSERT INTO `st_students` VALUES (107, '李振宇', '123456', 13);
INSERT INTO `st_students` VALUES (108, '孙威', '123456', 13);
INSERT INTO `st_students` VALUES (109, '赵恒', '123456', 13);
INSERT INTO `st_students` VALUES (110, '张乃赫', '123456', 13);
INSERT INTO `st_students` VALUES (111, '王涛', '123456', 13);
INSERT INTO `st_students` VALUES (112, '雷名锴', '123456', 13);
INSERT INTO `st_students` VALUES (113, '叶建新', '123456', 13);
INSERT INTO `st_students` VALUES (114, '温凯', '123456', 13);
INSERT INTO `st_students` VALUES (115, '张建', '123456', 13);
INSERT INTO `st_students` VALUES (116, '王浩', '123456', 13);
INSERT INTO `st_students` VALUES (117, '陈泽凡', '123456', 13);
INSERT INTO `st_students` VALUES (118, '迟天宇', '123456', 13);
INSERT INTO `st_students` VALUES (119, '张奋强', '123456', 13);
INSERT INTO `st_students` VALUES (120, '施云岩', '123456', 13);
COMMIT;

-- ----------------------------
-- Table structure for st_targets
-- ----------------------------
DROP TABLE IF EXISTS `st_targets`;
CREATE TABLE `st_targets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(120) NOT NULL COMMENT '标题',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '类型，0：知识点 1：项目 2：情商',
  `category` varchar(60) DEFAULT '0' COMMENT '技术分类',
  `step_id` int(10) unsigned NOT NULL COMMENT '阶段ID',
  `description` varchar(600) DEFAULT NULL COMMENT '目标描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of st_targets
-- ----------------------------
BEGIN;
INSERT INTO `st_targets` VALUES (1, '能够说出常用的标签的功能及应用场景', 0, '01.HTML', 0, NULL);
INSERT INTO `st_targets` VALUES (2, '熟练掌握页面的布局', 0, '02.CSS', 0, NULL);
INSERT INTO `st_targets` VALUES (3, '熟练掌握盒子模型', 0, '02.CSS', 0, NULL);
INSERT INTO `st_targets` VALUES (4, '熟练掌握背景、字体、颜色', 0, '02.CSS', 0, NULL);
INSERT INTO `st_targets` VALUES (5, '熟练掌握移动端适配', 0, '02.CSS', 0, NULL);
INSERT INTO `st_targets` VALUES (6, '熟练掌握显示模式', 0, '02.CSS', 0, NULL);
INSERT INTO `st_targets` VALUES (7, '熟练掌握过渡', 0, '02.CSS', 0, NULL);
INSERT INTO `st_targets` VALUES (8, '熟练掌握变量、运算符、数据类型', 0, '03.JS基础语法', 0, NULL);
INSERT INTO `st_targets` VALUES (9, '熟练掌握字符串的操作', 0, '03.JS基础语法', 0, NULL);
INSERT INTO `st_targets` VALUES (10, '熟练掌握数组的操作', 0, '03.JS基础语法', 0, NULL);
INSERT INTO `st_targets` VALUES (11, '熟练掌握对象的操作', 0, '03.JS基础语法', 0, NULL);
INSERT INTO `st_targets` VALUES (12, '熟练掌握 this、call、apply 的用法', 0, '03.JS基础语法', 0, NULL);
INSERT INTO `st_targets` VALUES (13, '熟练掌握 Date 和 Math 对象的使用', 0, '03.JS基础语法', 0, NULL);
INSERT INTO `st_targets` VALUES (14, '熟练掌握函数、递归、匿名函数、闭包', 0, '03.JS基础语法', 0, NULL);
INSERT INTO `st_targets` VALUES (20, '熟练掌握定时器', 0, '06.异步操作', 0, NULL);
INSERT INTO `st_targets` VALUES (21, '熟练掌握 AJAX', 0, '06.异步操作', 0, NULL);
INSERT INTO `st_targets` VALUES (22, '熟练掌握 let、const 的使用', 0, '07.ES678', 0, NULL);
INSERT INTO `st_targets` VALUES (23, '熟练掌握 ES6 中对象的操作', 0, '07.ES678', 0, NULL);
INSERT INTO `st_targets` VALUES (26, '熟练掌握 Promise 对象的使用', 0, '07.ES678', 0, NULL);
INSERT INTO `st_targets` VALUES (27, '熟练掌握 async...await 的使用', 0, '07.ES678', 0, NULL);
INSERT INTO `st_targets` VALUES (28, '熟练掌握 Node 中的模块化技术', 0, '08.Node', 0, NULL);
INSERT INTO `st_targets` VALUES (29, '基本掌握 path、os、url、querystring 模块的使用', 0, '08.Node', 0, NULL);
INSERT INTO `st_targets` VALUES (30, '基本掌握 fs 模块的使用', 0, '08.Node', 0, NULL);
INSERT INTO `st_targets` VALUES (31, '熟练掌握 npm', 0, '09.npm', 0, NULL);
INSERT INTO `st_targets` VALUES (38, '熟练掌握模板指令', 0, '05.Vue', 1, NULL);
INSERT INTO `st_targets` VALUES (39, '熟练掌握生命周期方法', 0, '05.Vue', 1, NULL);
INSERT INTO `st_targets` VALUES (40, '熟练掌握计算属性和监听器', 0, '05.Vue', 1, NULL);
INSERT INTO `st_targets` VALUES (41, '熟练掌握 Vue 的组件', 0, '05.Vue', 1, NULL);
INSERT INTO `st_targets` VALUES (45, '熟练掌握 Vue Router', 0, '13.Vue SPA', 0, NULL);
INSERT INTO `st_targets` VALUES (46, '熟练掌握 Vuex', 0, '13.Vue SPA', 0, NULL);
INSERT INTO `st_targets` VALUES (47, '熟练掌握单文件组件', 0, '13.Vue SPA', 0, NULL);
INSERT INTO `st_targets` VALUES (48, '熟练掌握 axios 向接口发送请求', 0, '14.axios', 0, NULL);
INSERT INTO `st_targets` VALUES (56, '基本掌握 HTTP 协议', 0, '16.服务器端接口开发', 0, NULL);
INSERT INTO `st_targets` VALUES (57, '基本掌握 Node 中的 http 模块的使用', 0, '16.服务器端接口开发', 0, NULL);
INSERT INTO `st_targets` VALUES (58, '熟练掌握 Koa 的使用', 0, '16.服务器端接口开发', 0, NULL);
INSERT INTO `st_targets` VALUES (59, '熟练掌握 Koa 中请求数据解析的技术', 0, '16.服务器端接口开发', 0, NULL);
INSERT INTO `st_targets` VALUES (60, '熟练掌握 AJAX 跨域', 0, '16.服务器端接口开发', 0, NULL);
INSERT INTO `st_targets` VALUES (61, '熟练掌握文件上传和图像处理技术', 0, '16.服务器端接口开发', 0, NULL);
INSERT INTO `st_targets` VALUES (62, '熟练掌握 JWT 令牌技术', 0, '16.服务器端接口开发', 0, NULL);
INSERT INTO `st_targets` VALUES (63, '熟练掌握 MySQL 中的字段类型', 0, '17.MySQL', 0, NULL);
INSERT INTO `st_targets` VALUES (64, '熟练掌握单表的插入、修改、删除操作', 0, '17.MySQL', 0, NULL);
INSERT INTO `st_targets` VALUES (65, '熟练掌握单表的条件查询、分组查询、排序查询、翻页查询、聚合统计、过滤操作', 0, '17.MySQL', 0, NULL);
INSERT INTO `st_targets` VALUES (67, '熟练掌握多表查询', 0, '17.MySQL', 0, NULL);
INSERT INTO `st_targets` VALUES (69, '熟练掌握表间关系', 0, '17.MySQL', 0, NULL);
INSERT INTO `st_targets` VALUES (71, '熟练掌握接口命名的设计原则', 0, '18.RESTFul API', 0, NULL);
INSERT INTO `st_targets` VALUES (72, '熟练掌握接口数据传输的结构', 0, '18.RESTFul API', 0, NULL);
INSERT INTO `st_targets` VALUES (74, '熟练掌握无限级分类', 0, '19.常见业务', 0, NULL);
INSERT INTO `st_targets` VALUES (75, '熟练掌握 RBAC', 0, '19.常见业务', 0, NULL);
INSERT INTO `st_targets` VALUES (78, '熟练掌握支付接口的使用', 0, '19.常见业务', 0, NULL);
INSERT INTO `st_targets` VALUES (79, '熟练掌握邮件、短信接口的使用', 0, '19.常见业务', 0, NULL);
INSERT INTO `st_targets` VALUES (80, '熟练掌握直播、点播云服务的使用', 0, '19.常见业务', 0, NULL);
INSERT INTO `st_targets` VALUES (81, '熟练掌握 CSS 选择器', 0, '02.CSS', 0, NULL);
INSERT INTO `st_targets` VALUES (82, '熟练掌握定位技术', 0, '02.CSS', 0, NULL);
INSERT INTO `st_targets` VALUES (83, '学生日报管理系统', 1, '20.项目开发', 0, NULL);
INSERT INTO `st_targets` VALUES (84, '学生目标管理平台', 1, '20.项目开发', 0, NULL);
INSERT INTO `st_targets` VALUES (85, '在线商城系统', 1, '20.项目开发', 0, NULL);
INSERT INTO `st_targets` VALUES (86, '在线直播、点播系统', 1, '20.项目开发', 0, NULL);
INSERT INTO `st_targets` VALUES (87, '熟练掌握 MySQL 中的字段类型', 0, '01.MySQL', 1, NULL);
INSERT INTO `st_targets` VALUES (88, '实现日志表的 添加、修改、删除、查询、搜索、翻页、排序 操作', 1, '01.第一步 - 单表操作 （初级）', 1, NULL);
INSERT INTO `st_targets` VALUES (89, '能够独立创建一张表', 0, '01.MySQL', 1, NULL);
INSERT INTO `st_targets` VALUES (90, '熟练掌握 insert、update、delete、select 语句', 0, '01.MySQL', 1, NULL);
INSERT INTO `st_targets` VALUES (91, '熟练掌握 group by 分组的使用', 0, '01.MySQL', 1, NULL);
INSERT INTO `st_targets` VALUES (92, '能够说出翻页的实现原理', 0, '01.MySQL', 1, NULL);
INSERT INTO `st_targets` VALUES (93, '熟练掌握 order by 排序的使用', 0, '01.MySQL', 1, NULL);
INSERT INTO `st_targets` VALUES (94, '熟练掌握 where 的使用', 0, '01.MySQL', 1, NULL);
INSERT INTO `st_targets` VALUES (96, '能够说出 Node 和 Koa 的关系', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (97, '能够说出 Express 和 Koa 的关系', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (98, '能够使用 Koa 启动一个 Http 服务器', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (99, '能够说出什么是 http 协议', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (100, '能够说出 http 协议和 Koa 之间的关系', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (101, '能够说出 Koa 中的 use 方法是干什么用的', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (102, '能够说出在 Koa 中如何给客户端返回数据', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (103, '能够说出在 Koa 中如何接收客户端提交给服务器的数据', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (104, '客户端在给服务器提交数据时有哪几种形式', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (105, '路由是干什么用的？Koa 中实现路由的原理是？', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (106, 'Koa 中操作 MySQL 数据库可以使用哪个模块', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (107, 'Koa 中实现路由可以使用哪个模块', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (108, '什么是 AJAX 跨域？', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (109, '怎么解决 AJAX 跨域', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (110, '什么是 cors ？如何实现？', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (111, 'jwt 是什么？干什么用的？', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (112, '如何生成 jwt', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (113, '如何验证 jwt', 0, '02.Koa', 1, NULL);
INSERT INTO `st_targets` VALUES (119, 'postman 这个软件能用来干什么？', 0, '04.接口开发工具', 1, NULL);
INSERT INTO `st_targets` VALUES (120, 'postman 如何编写接口文档', 0, '04.接口开发工具', 1, NULL);
INSERT INTO `st_targets` VALUES (121, 'postman 中如何使用环境变量', 0, '04.接口开发工具', 1, NULL);
INSERT INTO `st_targets` VALUES (122, 'postman 中如何保存接口的返回结果？保存的目的是？', 0, '04.接口开发工具', 1, NULL);
INSERT INTO `st_targets` VALUES (123, '使用 postman 请求接口时，如何设置提交数据的格式', 0, '04.接口开发工具', 1, NULL);
INSERT INTO `st_targets` VALUES (124, '请求接口时一般有几种传数据的格式', 0, '04.接口开发工具', 1, NULL);
INSERT INTO `st_targets` VALUES (125, 'vue cli、vue router、vuex、babel、webpack、less、sass、npm、eslint分别是干什么用的？', 0, '05.Vue', 1, NULL);
INSERT INTO `st_targets` VALUES (126, 'vue router 是干什么用的', 0, '07.Vue Router', 1, NULL);
INSERT INTO `st_targets` VALUES (127, 'vuex 是干什么用的', 0, '08.Vuex', 1, NULL);
INSERT INTO `st_targets` VALUES (128, '能够根据文档使用 ElementUI 中的组件', 0, '05.Vue', 1, NULL);
INSERT INTO `st_targets` VALUES (129, '能够使用 axios 发送 get、post、delete、update 请求', 0, '06.axios', 1, NULL);
INSERT INTO `st_targets` VALUES (130, '使用 get、put、delete、post 方法请求服务器分别代表什么', 0, '03.RESTFul API', 1, NULL);
INSERT INTO `st_targets` VALUES (131, '能够使用 axios 的拦截器设置令牌', 0, '06.axios', 1, NULL);
INSERT INTO `st_targets` VALUES (132, 'router-link 标签的用途？', 0, '07.Vue Router', 1, NULL);
INSERT INTO `st_targets` VALUES (133, 'router-view 标签的用途？', 0, '07.Vue Router', 1, NULL);
INSERT INTO `st_targets` VALUES (134, '什么是 RESTFul API', 0, '03.RESTFul API', 1, NULL);
INSERT INTO `st_targets` VALUES (135, 'RESTFul API 中接口命名的建议有哪些', 0, '03.RESTFul API', 1, NULL);
INSERT INTO `st_targets` VALUES (136, '嵌套路由是干什么？什么时候用？怎么用？', 0, '07.Vue Router', 1, NULL);
INSERT INTO `st_targets` VALUES (137, '路由守卫是干什么？什么时候用？怎么用？', 0, '07.Vue Router', 1, NULL);
INSERT INTO `st_targets` VALUES (138, 'vuex 中 state、mutations、getters、actions 的用途？', 0, '08.Vuex', 1, NULL);
INSERT INTO `st_targets` VALUES (139, 'vuex 中的命名空间干什么用的？', 0, '08.Vuex', 1, NULL);
INSERT INTO `st_targets` VALUES (140, 'vuex 中的映射怎么用？干什么用的？', 0, '08.Vuex', 1, NULL);
INSERT INTO `st_targets` VALUES (141, 'el-table 组件干什么用的？怎么用？', 0, '09.Element UI', 1, NULL);
INSERT INTO `st_targets` VALUES (142, 'el-row 和 el-col 组件干什么用的？怎么用？', 0, '09.Element UI', 1, NULL);
INSERT INTO `st_targets` VALUES (143, 'el-form 组件干什么用的？怎么用？', 0, '09.Element UI', 1, NULL);
INSERT INTO `st_targets` VALUES (144, '$message 组件干什么用的？怎么用？', 0, '09.Element UI', 1, NULL);
INSERT INTO `st_targets` VALUES (145, '说出至少 10 个你用过的组件？', 0, '09.ElementUI', 1, NULL);
INSERT INTO `st_targets` VALUES (146, 'Vue 中父组件如何向子组件中传值?', 0, '05.Vue', 1, NULL);
INSERT INTO `st_targets` VALUES (147, 'Vue 中子组件如何向父组件中传值？', 0, '05.Vue', 1, NULL);
INSERT INTO `st_targets` VALUES (148, 'Vue 中使用一个组件的流程是？', 0, '05.Vue', 1, NULL);
INSERT INTO `st_targets` VALUES (149, 'Vue 中 v-on 和 v-bind 指令的简写是？', 0, '05.Vue', 1, NULL);
INSERT INTO `st_targets` VALUES (150, '能够实现注册、登录、退出功能', 1, '02.第二步 - 登录 （中级）', 1, NULL);
INSERT INTO `st_targets` VALUES (151, '1.登录用户可以发表日志  2. 登录用户可以修改、删除自己的日志 3. 未登录用户可以查看所有的日志', 1, '03.第三步 - 基本权限 （中级）', 1, NULL);
INSERT INTO `st_targets` VALUES (152, '1. 登录用户可以为别人的日志点赞 2. 一个用户只能点赞一个日志一次  3. 在日志详情页中可以看到点赞过的用户', 1, '04.第四步 - 点赞 （高级）', 1, NULL);
INSERT INTO `st_targets` VALUES (153, '1. 登录用户可以对商品进行评论 2. 未登录的用户只可以查看所有的评论', 1, '05.第五步 - 日志评论 （高级）', 1, NULL);
INSERT INTO `st_targets` VALUES (154, '1. 添加分类管理  2. 日志分类进行管理和查看', 1, '06.第六步 - 日志分类（扩展）', 1, NULL);
INSERT INTO `st_targets` VALUES (155, '日志排序榜', 1, '07.第七步 - 排行榜（初级）', 1, NULL);
INSERT INTO `st_targets` VALUES (156, '能够使用 left join ... on 进行连表查询', 0, '01.MySQL', 1, NULL);
INSERT INTO `st_targets` VALUES (157, '能够使用 left join ... on 、group by、count  在连表时对从表进行数据统计', 0, '01.MySQL', 1, NULL);
INSERT INTO `st_targets` VALUES (158, '能够分析出两个表之间关系？', 0, '01.MySQL', 1, NULL);
INSERT INTO `st_targets` VALUES (159, '能够说出外键和中间表的用途？', 0, '01.MySQL', 1, NULL);
INSERT INTO `st_targets` VALUES (160, '能够实现无限级分类功能', 1, '01.第一步 - 无限级（初级）', 2, NULL);
INSERT INTO `st_targets` VALUES (161, '能够实现 RBAC 功能', 1, '02.第二步 - 权限管理 （中级）', 2, NULL);
INSERT INTO `st_targets` VALUES (162, '能够实现商品信息管理', 1, '03.第三步 - SPU 和 SKU （高级）', 2, NULL);
INSERT INTO `st_targets` VALUES (163, '能够实现商品搜索功能', 1, '04.第四步 - 搜索 （高级）', 2, NULL);
INSERT INTO `st_targets` VALUES (164, '能够实现购物流程', 1, '05.第五步 - 购物 （高级）', 2, NULL);
INSERT INTO `st_targets` VALUES (165, '能够实现图片上传功能', 0, '01.图像处理', 2, NULL);
INSERT INTO `st_targets` VALUES (166, '能够为图片添加水印', 0, '01.图像处理', 2, NULL);
INSERT INTO `st_targets` VALUES (167, '能够为上传的图片生成缩略图', 0, '01.图像处理', 2, NULL);
INSERT INTO `st_targets` VALUES (168, '能够发短信', 0, '02.第三方接口调用', 2, NULL);
INSERT INTO `st_targets` VALUES (169, '能够发邮件', 0, '02.第三方接口调用', 2, NULL);
INSERT INTO `st_targets` VALUES (170, '能够实现微信支付', 0, '02.第三方接口调用', 2, NULL);
INSERT INTO `st_targets` VALUES (171, '能够实现支付宝支付', 0, '02.第三方接口调用', 2, NULL);
INSERT INTO `st_targets` VALUES (173, '能够实现注册、登录、找回密码、自动登录、重围密码、手机号码验证功能', 1, '06.第六步 - 会员注册（中级）', 2, NULL);
INSERT INTO `st_targets` VALUES (174, '能够说出无限级分类的实现原理', 0, '03.无限级分类', 2, NULL);
INSERT INTO `st_targets` VALUES (175, '能够说出递归法和继承法的实现原理', 0, '03.无限级分类', 2, NULL);
INSERT INTO `st_targets` VALUES (176, '能够根据分类 ID 获取出该分类的所有子分类的ID', 0, '03.无限级分类', 2, NULL);
INSERT INTO `st_targets` VALUES (177, '能够制作无限级分类的树形列表', 0, '03.无限级分类', 2, NULL);
INSERT INTO `st_targets` VALUES (178, '能够制作三级分类的级联下拉框', 0, '03.无限级分类', 2, NULL);
INSERT INTO `st_targets` VALUES (179, '能够说出 SPU 和 SKU 的区别？和用途？', 0, '04.商品模块', 2, NULL);
INSERT INTO `st_targets` VALUES (180, '能够说出商品的基本信息、商品品牌、商品属性、SKU、商品图片的用途和关系', 0, '04.商品模块', 2, NULL);
INSERT INTO `st_targets` VALUES (181, '能够使用富文本编辑器', 0, '04.商品模块', 2, NULL);
INSERT INTO `st_targets` VALUES (182, '能够制作出（除 SKU 之外）的商品管理功能', 0, '04.商品模块', 2, NULL);
INSERT INTO `st_targets` VALUES (183, '能够制作出商品的 SKU 管理功能（难~）', 0, '04.商品模块', 2, NULL);
INSERT INTO `st_targets` VALUES (184, '什么是 RBAC ？干什么用的？', 0, '05.RBAC', 2, NULL);
INSERT INTO `st_targets` VALUES (185, '能够说出实现 RBAC 的表结构', 0, '05.RBAC', 2, NULL);
INSERT INTO `st_targets` VALUES (186, '如何获取一个管理员所拥有的权限', 0, '05.RBAC', 2, NULL);
INSERT INTO `st_targets` VALUES (187, '如何判断一个管理员是否拥有一个权限', 0, '05.RBAC', 2, NULL);
INSERT INTO `st_targets` VALUES (188, '购物车的实现原理是什么', 0, '06.购物车', 2, NULL);
INSERT INTO `st_targets` VALUES (189, '购物车中的数据保存到数据库与不保存到数据库有什么要求和区别', 0, '06.购物车', 2, NULL);
INSERT INTO `st_targets` VALUES (190, '每件商品在加入到购物车时需要保存哪些信息', 0, '06.购物车', 2, NULL);
INSERT INTO `st_targets` VALUES (191, '什么是事务？干什么用的？怎么用？', 0, '08.下订单', 2, NULL);
INSERT INTO `st_targets` VALUES (192, '一般订单有哪些种状态', 0, '08.下订单', 2, NULL);
INSERT INTO `st_targets` VALUES (193, '保存订单信息需要几张表？都需要哪些字段', 0, '08.下订单', 2, NULL);
INSERT INTO `st_targets` VALUES (194, '有哪些原因会导致下订单失败', 0, '08.下订单', 2, NULL);
INSERT INTO `st_targets` VALUES (195, '订单表已经有id了，为什么还要生成订单号？生成订单号的算法是什么？为什么？', 0, '08.下订单', 2, NULL);
INSERT INTO `st_targets` VALUES (196, '用户注册的流程是（需要手机号码验证）？', 0, '07.用户注册', 2, NULL);
INSERT INTO `st_targets` VALUES (197, '重置密码的流程是？', 0, '07.用户注册', 2, NULL);
INSERT INTO `st_targets` VALUES (198, '实现自动登录的原理是？', 0, '07.用户注册', 2, NULL);
INSERT INTO `st_targets` VALUES (199, '下订单的流程是？', 0, '08.下订单', 2, NULL);
INSERT INTO `st_targets` VALUES (200, '根据分类搜索商品的流程是？', 0, '09.商品搜索', 2, NULL);
INSERT INTO `st_targets` VALUES (201, '根据销量对商品排序的SQL思路是？', 0, '09.商品搜索', 2, NULL);
INSERT INTO `st_targets` VALUES (202, '根据关键字搜索商品的流程？', 0, '09.商品搜索', 2, NULL);
INSERT INTO `st_targets` VALUES (203, '根据分类获取筛选品牌和筛选属性的流程', 0, '09.商品搜索', 2, NULL);
INSERT INTO `st_targets` VALUES (204, 'uniapp 是什么？干什么用的？什么时候使用？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (205, 'App.vue 和 main.js 文件的用途是？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (206, '应用生命周期、页面生命周期、组件生命周期的特点是？都是什么？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (207, '全局事件是什么？有什么用？怎么用？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (208, 'pages.json、manifest.json、uni.scss、vue-config.js、package.json 文件都是干什么用的？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (209, '能够在浏览器、手机、小程序中运行页面', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (210, '能够将程序发布到H5、手机 APP、微信小程序中', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (211, 'uniapp 中的路由如何定义？uniapp 中如何实现路由的跳转？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (212, 'uniapp 中路由有几种形式？不同形式的页面栈特点是？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (213, '因为 uniapp 的项目代码，可以同时编译运行在不同平台上，那么如何判断程序当前的运行平台？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (214, 'px 和 rpx 两种单位的区别？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (215, '如何为 body 设置样式？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (216, '如何设置全局样式和页面样式', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (217, '小程序平台下如何获取系统状态栏的高度？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (218, 'click 事件在 uniapp 中使用？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (219, '在一个页面中如何获取上一个页面中传过来的参数？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (220, '什么是条件编译？干什么用的？怎么用？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (221, '使用 uniapp 开发时 * 选择器有什么注意的？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (222, 'uniapp 中的标签和 html 中的标签对应关系是？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (223, 'js 中的 document、window、localstorage、cookie 对象能在 uniapp 中使用吗？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (224, '页面之间可以通过什么办法进行数据通信？', 0, '01.uniapp 基础', 3, NULL);
INSERT INTO `st_targets` VALUES (225, '如何在项目中使用字体图标？', 0, '01.uniapp 基础', 3, NULL);
COMMIT;

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

-- ----------------------------
-- Records of st_teachers
-- ----------------------------
BEGIN;
INSERT INTO `st_teachers` VALUES (3, 'admin', 'admin123321');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
