/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80024 (8.0.24)
 Source Host           : localhost:3306
 Source Schema         : ai_study_helper

 Target Server Type    : MySQL
 Target Server Version : 80024 (8.0.24)
 File Encoding         : 65001

 Date: 04/06/2026 20:37:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'my_course_resource', '课程资源表', NULL, NULL, 'MyCourseResource', 'crud', 'element-ui', 'com.ruoyi.business', 'business', 'resource', '资源模块', 'llhl', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31', NULL);
INSERT INTO `gen_table` VALUES (2, 'my_notification', '通知表', NULL, NULL, 'MyNotification', 'crud', 'element-ui', 'com.ruoyi.business', 'business', 'notification', '通知模块', 'lhl', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32', NULL);
INSERT INTO `gen_table` VALUES (4, 'my_homework', '作业表', NULL, NULL, 'MyHomework', 'crud', 'element-ui', 'com.ruoyi.system', 'system', 'homework', '作业', 'ruoyi', '0', '/', NULL, 'admin', '2026-05-31 19:57:04', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (5, 'my_bank', '题库表', NULL, NULL, 'MyBank', 'crud', 'element-ui', 'com.ruoyi.system', 'system', 'bank', '题库', 'ruoyi', '0', '/', NULL, 'admin', '2026-06-03 15:23:19', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 're_id', '资源ID', 'bigint', 'Long', 'reId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (2, 1, 'c_id', '关联课程ID', 'bigint', 'Long', 'cId', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 2, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (3, 1, 'resource_type', '资源类型 1-视频 2-文档 3-图书 4-期刊 5-讲座', 'tinyint', 'Long', 'resourceType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (4, 1, 'title', '资源标题', 'varchar(200)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (5, 1, 'content', '资源内容/描述', 'text', 'String', 'content', '0', '0', '0', '1', '1', '1', '0', 'LIKE', 'editor', '', 5, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (6, 1, 'file_url', '文件链接', 'varchar(500)', 'String', 'fileUrl', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'textarea', '', 6, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (7, 1, 'video_url', '视频链接', 'varchar(500)', 'String', 'videoUrl', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'textarea', '', 7, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (8, 1, 'homework', '作业内容', 'text', 'String', 'homework', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'textarea', '', 8, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (9, 1, 'sort_order', '排序', 'int', 'Long', 'sortOrder', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 9, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (10, 1, 'create_time', NULL, 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (11, 1, 'tag', NULL, 'varchar(255)', 'String', 'tag', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 11, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (12, 2, 'noti_id', '通知ID', 'bigint', 'Long', 'notiId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (13, 2, 'sender_id', '发送者ID', 'bigint', 'Long', 'senderId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (14, 2, 'sender_type', '发送者类型 1-系统 2-教师 3-管理员', 'tinyint', 'Long', 'senderType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (15, 2, 'title', '通知标题', 'varchar(200)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (16, 2, 'content', '通知内容', 'text', 'String', 'content', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'editor', '', 5, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (17, 2, 'target_type', '目标类型 1-全部 2-指定学生 3-指定班级', 'tinyint', 'Long', 'targetType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 6, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (18, 2, 'target_ids', '目标对象ID列表', 'json', 'String', 'targetIds', '0', '0', '0', '1', '1', '1', '1', 'EQ', NULL, '', 7, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (19, 2, 'priority', '优先级 1-普通 2-重要 3-紧急', 'tinyint', 'Long', 'priority', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (20, 2, 'is_top', '是否置顶 0-否 1-是', 'tinyint', 'Long', 'isTop', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (21, 2, 'status', '状态 0-草稿 1-已发布 2-已撤回', 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 10, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (22, 2, 'publish_time', '发布时间', 'datetime', 'Date', 'publishTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 11, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (23, 2, 'create_time', NULL, 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (24, 2, 'update_time', NULL, 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (33, 4, 'hw_id', '作业ID', 'bigint', 'Long', 'hwId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (34, 4, 'std_id', '学生ID', 'bigint', 'Long', 'stdId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (35, 4, 'c_id', '课程ID', 'bigint', 'Long', 'cId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (36, 4, 'teacher_id', '发布教师ID', 'bigint', 'Long', 'teacherId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (37, 4, 'title', '作业标题', 'varchar(200)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (38, 4, 'content', '作业内容', 'text', 'String', 'content', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'editor', '', 6, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (39, 4, 'type', '作业类型 1-客观题 2-主观题 3-混合', 'tinyint', 'Long', 'type', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 7, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (40, 4, 'total_score', '总分', 'int', 'Long', 'totalScore', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (41, 4, 'deadline', '截止时间', 'datetime', 'Date', 'deadline', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 9, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (42, 4, 'status', '状态 0-草稿 1-已发布 2-已截止', 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 10, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (43, 4, 'create_time', NULL, 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (44, 4, 'update_time', NULL, 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (45, 5, 'hb_id', '题库ID', 'bigint', 'Long', 'hbId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (46, 5, 'qb_name', '题库名称', 'varchar(100)', 'String', 'qbName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (47, 5, 'description', '题库描述', 'text', 'String', 'description', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (48, 5, 'type', '题库类型', 'varchar(30)', 'String', 'type', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 4, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (49, 5, 'tag', '标签', 'varchar(100)', 'String', 'tag', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (50, 5, 'teacher_id', '创建教师ID', 'bigint', 'Long', 'teacherId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (51, 5, 'question_count', '题目数量', 'int', 'Long', 'questionCount', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (52, 5, 'total_score', '总分', 'int', 'Long', 'totalScore', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (53, 5, 'difficulty', '难度 1-简单 2-中等 3-困难', 'tinyint', 'Long', 'difficulty', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (54, 5, 'status', '状态 0-禁用 1-启用', 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 10, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (55, 5, 'is_public', '是否公开 0-私有 1-公开', 'tinyint', 'Long', 'isPublic', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (56, 5, 'create_time', NULL, 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (57, 5, 'update_time', NULL, 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2026-06-03 15:23:19', '', NULL);

-- ----------------------------
-- Table structure for my_admin
-- ----------------------------
DROP TABLE IF EXISTS `my_admin`;
CREATE TABLE `my_admin`  (
  `admin_id` bigint NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `user_id` bigint NOT NULL COMMENT '关联用户ID',
  `admin_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理员编号',
  `role` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'super' COMMENT '角色 super-超级管理员 normal-普通管理员',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`admin_id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_admin
-- ----------------------------
INSERT INTO `my_admin` VALUES (1, 4, 'A2024001', 'super', '2026-05-27 00:13:29');
INSERT INTO `my_admin` VALUES (2, 5, 'A2024002', 'normal', '2026-05-29 22:00:00');

-- ----------------------------
-- Table structure for my_ai_chat
-- ----------------------------
DROP TABLE IF EXISTS `my_ai_chat`;
CREATE TABLE `my_ai_chat`  (
  `chat_id` bigint NOT NULL AUTO_INCREMENT COMMENT '对话ID',
  `stu_id` bigint NULL DEFAULT NULL COMMENT '学生ID',
  `teacher_id` bigint NULL DEFAULT NULL COMMENT '教师ID',
  `session_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会话ID',
  `question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '问题内容',
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '回答内容',
  `question_type` tinyint NULL DEFAULT 1 COMMENT '问题类型 1-学习 2-作业 3-其他',
  `is_satisfied` tinyint NULL DEFAULT NULL COMMENT '是否满意 0-否 1-是',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chat_id`) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE,
  INDEX `idx_session_id`(`session_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'AI问答记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_ai_chat
-- ----------------------------
INSERT INTO `my_ai_chat` VALUES (1, 1, 1, 'SESSION_20260529_001', 'Python列表如何去重？', '可以使用set()转列表：list(set(arr))', 1, 1, '2026-06-02 17:29:27');
INSERT INTO `my_ai_chat` VALUES (2, 2, 1, 'SESSION_20260529_002', '二叉树的遍历方式有哪些？', '前序、中序、后序、层序遍历', 1, 0, '2026-06-01 17:29:27');
INSERT INTO `my_ai_chat` VALUES (17, NULL, NULL, 'SESSION_1780496723537', '帮我做一个学习计划', '你好！我是智学星途AI学习助手。很高兴为你制定一个高效、科学的学习计划。请先告诉我你的**目标、年级/阶段、每天可用时间**以及**需要重点突破的科目或技能**，我会为你量身定制。\n\n不过，如果你暂时没有提供详细信息，我可以先给你一个**通用的、可调整的“高效学习计划模板”**，你可以直接套用或根据自身情况微调：\n\n---\n\n### 📚 通用高效学习计划模板（周计划）\n\n#### 核心原则：番茄工作法 + 主动回忆 + 定期复盘\n\n**每日时间分配建议（以6小时有效学习为例）：**\n\n| 时间段 | 任务类型 | 具体建议 |\n| :--- | :--- | :--- |\n| **07:00-08:00** | **黄金记忆期** | 背诵英语单词、语文古诗词、文科核心概念（利用记忆曲线） |\n| **08:30-11:30** | **深度专注期** | **攻克最难科目**（数学/物理/编程/专业核心课）。每25-30分钟休息5分钟。 |\n| **14:00-16:00** | **逻辑与练习期** | 做习题、错题整理、理科计算或阅读理解训练。 |\n| **16:30-17:30** | **技能与拓展** | 学习新技能（如Python、PS、外语听力）、阅读课外书。 |\n| **19:00-21:00** | **复习与输出** | **费曼学习法**：用自己的话复述白天学的内容；整理错题本；做小测试。 |\n| **21:00-22:00** | **轻松回顾** | 看学科纪录片、听知识播客、制定明日计划。 |\n\n---\n\n### 🎯 具体执行步骤（以一周为单位）\n\n**周一、周三、周五：核心攻坚日**\n- **上午**：新知识学习（如数学新章节、物理公式推导）\n- **下午**：配套练习 + 错题分析\n- **晚上**：用思维导图梳理知识点，并做一道综合性大题。\n\n**周二、周四：查漏补缺日**\n- **上午**：复习周一/周三的薄弱点，重做错题。\n- **下午**：温习之前学过的内容（对抗遗忘），可做模拟卷。\n- **晚上**：总结本周易错题型，标记需要问老师的问题。\n\n**周六：模拟实战日**\n- **上午**：完整做一套真题或模拟卷（严格限时）。\n- **下午**：批改、分析失分原因（比做题更重要）。\n- **晚上**：自由安排（看纪录片、复习笔记）。\n\n**周日：复盘与弹性日**\n- **上午**：整理本周所有错题，归纳“同类题”解法。\n- **下午**：回顾周计划完成情况，调整下周策略。\n- **晚上**：彻底放松（运动、电影、社交），不安排学习。\n\n---\n\n### 📝 关键建议（针对不同场景）\n\n1.  **如果你在备考（中高考/考研/考证）：**\n    -   每天至少留出 **1小时** 做真题，并严格限时。\n    -   建立 **“错题本”** （电子或纸质），每周重做一次错题。\n2.  **如果你感到拖延：**\n    -   使用 **“5秒法则”**：想学习时，倒数5-4-3-2-1，立刻行动。\n    -   把大目标拆成 **“微任务”** （如“只做1道题”或“背5个单词”）。\n3.  **如果你容易分心：**\n    -   学习时手机放另一个房间，或使用 **Forest、番茄Todo** 等APP。\n    -   保持桌面整洁，只放当前科目资料。\n\n---\n\n### 💡 现在，请告诉我你的具体需求！\n\n**为了给你更精准的计划，请回复以下信息（选填）：**\n1.  **当前身份**（如：初三、高三、大学生、职场考证）\n2.  **目标**（如：期末考进年级前10、考研上岸、通过英语六级）\n3.  **每天可投入时间**（如：2小时、4小时、8小时）\n4.  **最让你头疼的科目或问题**（如：数学几何、英语单词记不住、容易走神）\n\n**例如：** “我是高三学生，目标是考上985，每天能学8小时，最头疼数学压轴题和英语阅读理解。”\n\n收到你的信息后，我会立刻为你生成一份**包含每日任务清单、周进度表和具体资源推荐**的专属计划！ 🚀', 1, NULL, '2026-06-03 22:25:47');
INSERT INTO `my_ai_chat` VALUES (18, NULL, NULL, 'SESSION_1780496723537', '帮我做一个学习计划', '你好！我是智学星途AI学习助手。很高兴为你制定专属学习计划！🎯\n\n为了给你量身定制一份**高效、可执行**的计划，我需要先了解你的**基础信息**。请回答下面几个问题：\n\n1. **你的身份是？**（例如：初中生/高中生/大学生/考研/考证/职场技能提升等）\n2. **你的目标是什么？**（例如：期末考进前10名/通过英语四级/学会Python编程/一个月内背完3000词等）\n3. **每天可投入的学习时间是多少？**（例如：1-2小时 / 3-4小时 / 全天备考）\n4. **你的薄弱科目或难点是什么？**（例如：数学函数不理解/英语阅读速度慢/注意力容易分散等）\n\n---\n\n**在你回复之前，我先给你一个通用的“学霸级学习计划模板”，你可以参考调整：**\n\n### 📅 每日时间表（示例：以高中生为例）\n| 时间段 | 任务 | 备注 |\n|--------|------|------|\n| 06:30-07:00 | 晨读（英语单词/语文古诗词） | 大声朗读，激活大脑 |\n| 12:30-13:00 | 午间复习（错题回顾/知识点梳理） | 利用碎片时间 |\n| 19:00-20:30 | 深度攻克（数学/物理等理科） | 做2-3道综合题+总结 |\n| 20:40-21:40 | 文科背诵/阅读（英语/语文/历史） | 结合思维导图记忆 |\n| 21:40-22:00 | 复盘+明日计划 | 写下3个“今日收获” |\n\n### ⚡ 核心原则（很重要！）\n1. **番茄工作法**：每学习25分钟，休息5分钟，保持专注。\n2. **费曼学习法**：把刚学的知识点假装“讲给同桌听”，卡壳的地方就是漏洞。\n3. **错题优先**：每周花2小时专门重做错题本上的题，效果远大于刷10张新卷子。\n\n---\n\n**现在请告诉我你的具体情况，我会立刻为你生成一份“名字专属”的详细计划！** 🚀', 1, NULL, '2026-06-03 22:26:20');
INSERT INTO `my_ai_chat` VALUES (19, NULL, NULL, 'SESSION_1780497076413', '你有什么功能', '你好！我是智学星途AI学习助手，很高兴为你服务！我的功能主要包括以下几个方面：\n\n1. **学习辅导**  \n   - 解答各学科问题（数学、语文、英语、科学等），提供解题思路、知识点讲解。  \n   - 帮助制定学习计划，推荐学习方法（如记忆技巧、时间管理）。  \n\n2. **作业与考试支持**  \n   - 分析错题原因，生成同类练习题巩固知识。  \n   - 模拟考试题目，提供答案解析和评分建议。  \n\n3. **知识拓展**  \n   - 解释概念、历史事件、科学原理等，支持跨学科关联学习。  \n   - 提供课外阅读推荐（书籍、文章、纪录片等）。  \n\n4. **学习工具**  \n   - 生成思维导图、知识点总结、复习提纲。  \n   - 辅助写作（作文提纲、语法修改、英文润色）。  \n\n5. **个性化学习**  \n   - 根据你的学习进度和薄弱点，调整内容难度。  \n   - 支持对话式追问，深入解答疑问。  \n\n6. **其他实用功能**  \n   - 语言学习（翻译、单词记忆、口语练习）。  \n   - 编程入门指导（Python、Java等基础代码解析）。  \n\n**注意**：我无法直接联网搜索（除非你手动开启联网功能），但会尽力用已有知识提供准确信息。如果有具体问题或需求，随时告诉我，我们一起攻克学习难关！ 📚✨', 1, NULL, '2026-06-03 22:31:34');
INSERT INTO `my_ai_chat` VALUES (20, NULL, NULL, 'SESSION_1780499385568', '今天是几号', '抱歉，我无法实时获取当前日期和时间。建议您查看手机、电脑或时钟上的日期显示。如果您有其他学习问题，欢迎随时问我！', 1, NULL, '2026-06-03 23:09:55');
INSERT INTO `my_ai_chat` VALUES (21, NULL, NULL, 'SESSION_1780499385568', '你知道一些比较出名的物理学家吗', '当然，以下是几位世界著名的物理学家及其主要贡献：\n\n1. **艾萨克·牛顿**  \n   - 经典力学奠基人，提出牛顿运动定律和万有引力定律。\n\n2. **阿尔伯特·爱因斯坦**  \n   - 提出相对论（狭义与广义）和质能方程 \\(E=mc^2\\)，对量子理论也有重要贡献。\n\n3. **尼尔斯·玻尔**  \n   - 量子力学先驱，提出原子结构模型（玻尔模型）和互补原理。\n\n4. **玛丽·居里**  \n   - 放射性研究先驱，发现钋和镭元素，两次获得诺贝尔奖（物理、化学）。\n\n5. **理查德·费曼**  \n   - 量子电动力学奠基人之一，提出费曼图，擅长用通俗语言解释物理。\n\n6. **詹姆斯·克拉克·麦克斯韦**  \n   - 统一电磁学，提出麦克斯韦方程组，预言电磁波存在。\n\n7. **伽利略·伽利雷**  \n   - 现代科学方法之父，通过实验和观测推翻亚里士多德物理学。\n\n8. **斯蒂芬·霍金**  \n   - 研究黑洞和宇宙学，提出霍金辐射，科普著作《时间简史》影响深远。\n\n这些物理学家的贡献奠定了现代物理学的基石，推动了人类对自然规律的理解。如果你对某位科学家的具体理论或故事感兴趣，可以进一步探讨！', 1, NULL, '2026-06-03 23:10:18');
INSERT INTO `my_ai_chat` VALUES (22, NULL, NULL, 'SESSION_1780503684409', '你用的什么模型', '我是智学星途AI学习助手，基于深度学习技术构建，具体模型由研发团队优化设计，以提供高效、准确的学习辅导服务。如果您有具体的学科问题或学习需求，欢迎随时提问，我会尽力协助！', 1, NULL, '2026-06-04 00:22:05');
INSERT INTO `my_ai_chat` VALUES (23, NULL, NULL, 'SESSION_1780504373174', '你有名字吗', '你好！我是智学星途AI学习助手，你可以叫我**小智**或者**星途**。这样称呼起来更亲切，也方便我们互动。如果你有其他喜欢的名字，也可以随时告诉我哦～ 😊\n\n有什么学习上的问题需要我帮忙吗？', 1, NULL, '2026-06-04 00:35:04');
INSERT INTO `my_ai_chat` VALUES (24, NULL, NULL, 'SESSION_1780504563831', '你好', '你好！我是智学星途AI学习助手，很高兴为你服务。无论是学习上的疑问、知识探索，还是需要规划学习路径，我都会全力协助你。请随时告诉我你的需求，让我们一起开启高效学习之旅吧！🌟', 1, NULL, '2026-06-04 00:36:15');
INSERT INTO `my_ai_chat` VALUES (25, NULL, NULL, 'SESSION_1780504563831', '一年有多少天', '通常情况下，一年有 **365天**。但如果是 **闰年**，则有 **366天**（多出2月29日这一天）。闰年一般是能被4整除的年份，但整百年份必须能被400整除才是闰年。例如，2024年是闰年，而1900年不是。', 1, NULL, '2026-06-04 00:36:29');
INSERT INTO `my_ai_chat` VALUES (26, NULL, NULL, 'SESSION_1780567017855', '你知道时代少年团吗', '当然知道！时代少年团（Teens in Times，简称TNT）是中国内地的一支男子演唱组合，由时代峰峻于2019年推出。成员包括马嘉祺、丁程鑫、宋亚轩、刘耀文、张真源、严浩翔、贺峻霖七位少年。他们以青春活力的形象和多元化的音乐风格（如流行、舞曲、R&B等）受到广泛关注，代表作品有《爆米花》《无尽的冒险》《姐姐真漂亮》等。组合名寓意“少年以时代为舞台，追逐梦想与成长”，在青少年群体中拥有较高人气。如果你对他们的音乐、综艺或成长故事感兴趣，可以进一步交流哦！', 1, NULL, '2026-06-04 17:57:55');
INSERT INTO `my_ai_chat` VALUES (27, NULL, NULL, 'SESSION_1780567017855', '你知道什么时间线之前的信息', '你好，我是智学星途AI学习助手，很高兴为你解答问题！关于我的知识更新情况，我的训练数据涵盖了截至**2025年5月**的信息。也就是说，对于2025年5月之前的事件、知识、技术等，我都能为你提供参考和解答。当然，对于之后的新动态，我可能无法直接给出最新信息，但可以基于已有的知识为你分析和推测。如果你有具体问题，随时告诉我，我会尽力帮你找到答案！', 1, NULL, '2026-06-04 17:58:36');
INSERT INTO `my_ai_chat` VALUES (28, NULL, NULL, 'SESSION_1780567017855', '唐宋八大家', '唐宋八大家是唐代和宋代八位著名散文家的合称，他们在中国文学史上具有重要地位，对后世散文发展影响深远。具体包括：\n\n**唐代两位：**\n1. **韩愈**（768-824）：字退之，自称“郡望昌黎”，世称“韩昌黎”。他是唐代古文运动的倡导者，主张“文以载道”，强调文章内容与形式的统一。代表作有《师说》《进学解》《杂说》等。\n2. **柳宗元**（773-819）：字子厚，世称“柳河东”。与韩愈共同推动古文运动，擅长山水游记和寓言小品。代表作有《永州八记》《捕蛇者说》《黔之驴》等。\n\n**宋代六位：**\n3. **欧阳修**（1007-1072）：字永叔，号醉翁，晚年号六一居士。北宋文坛领袖，继承韩愈古文传统，主张“明道致用”。代表作有《醉翁亭记》《秋声赋》《朋党论》等。\n4. **苏洵**（1009-1066）：字明允，号老泉。苏轼、苏辙之父，擅长政论和史论，文风雄健。代表作有《六国论》《管仲论》等。\n5. **苏轼**（1037-1101）：字子瞻，号东坡居士。文学艺术全才，散文、诗词、书画皆精。散文气势磅礴，自然洒脱。代表作有《赤壁赋》《后赤壁赋》《石钟山记》等。\n6. **苏辙**（1039-1112）：字子由，号颍滨遗老。散文风格汪洋澹泊，与父兄并称“三苏”。代表作有《黄州快哉亭记》《上枢密韩太尉书》等。\n7. **曾巩**（1019-1083）：字子固，世称“南丰先生”。文章风格淳朴，章法严谨，长于史论。代表作有《墨池记》《醒心亭记》等。\n8. **王安石**（1021-1086）：字介甫，号半山。政治家、改革家，散文以议论见长，逻辑严密。代表作有《游褒禅山记》《答司马谏议书》《伤仲永》等。\n\n**核心地位：** 唐宋八大家代表了唐宋古文运动的最高成就，他们反对骈文浮华，倡导实用、自然的散文风格，奠定了中国古代散文的典范。其中，韩愈被尊为“文起八代之衰”，苏轼则被誉为“文曲星下凡”。', 1, NULL, '2026-06-04 18:00:17');
INSERT INTO `my_ai_chat` VALUES (29, NULL, NULL, 'SESSION_1780567017855', '给我推荐一部优秀的日本动漫', '作为智学星途AI学习助手，我推荐一部兼具深度与娱乐性的日本动漫——《命运石之门》（Steins;Gate）。以下是推荐理由：\n\n1. **剧情设定**：以时间旅行、因果律和科学伦理为核心，讲述一群大学生偶然发明了能向过去发送短信的装置，引发连锁反应和人性考验。逻辑严密，伏笔精巧，后期剧情反转令人震撼。\n\n2. **角色塑造**：主角冈部伦太郎从“中二病”科学家成长为背负责任的救世主，配角如助手牧濑红莉栖、真由理等形象丰满，情感刻画细腻。\n\n3. **主题深度**：探讨“改变过去与未来”的代价、记忆与真实的关系，以及科学探索中的道德困境，适合喜欢思考的观众。\n\n4. **学习价值**：涉及相对论、量子物理等科学概念（虽经艺术加工），可激发对科学和哲学的兴趣。建议观看时结合剧情思考“蝴蝶效应”“观测者效应”等理论。\n\n5. **适合人群**：偏好悬疑、科幻、慢热型叙事的观众（前12集铺垫，后12集爆发）。无过分暴力或低俗内容，适合高中生及以上年龄段。\n\n**温馨提示**：若时间有限，可先观看剧场版《命运石之门：负荷领域的既视感》或TV版第1、13、23集快速了解核心设定，但强烈建议完整观看以体会完整悬疑设计。  \n\n希望这部作品能带给你启发与乐趣！如有其他需求，欢迎继续提问。', 1, NULL, '2026-06-04 18:01:27');
INSERT INTO `my_ai_chat` VALUES (30, NULL, NULL, 'SESSION_1780567017855', '今天热点消息', '截至2025年5月23日，今日热点消息主要集中在以下领域：\n\n1. **科技**：华为发布新一代自研芯片“麒麟9100”，性能较前代提升40%，已应用于最新旗舰手机系列。  \n2. **经济**：国家统计局公布4月规模以上工业企业利润同比增长8.2%，制造业与新能源行业表现突出。  \n3. **国际**：联合国气候大会达成新减排协议，主要经济体承诺2035年前将碳排放量减少50%。  \n4. **社会**：教育部宣布将人工智能课程纳入中小学必修课，2026年秋季起逐步实施。  \n5. **体育**：中国女足在亚洲杯半决赛中以3:1击败日本队，晋级决赛。  \n\n如需更详细解读或特定领域信息，可进一步说明。', 1, NULL, '2026-06-04 18:01:59');
INSERT INTO `my_ai_chat` VALUES (31, NULL, NULL, 'SESSION_1780567846305', '今天的日期', '今天是2025年3月11日。', 1, NULL, '2026-06-04 18:11:01');
INSERT INTO `my_ai_chat` VALUES (32, NULL, NULL, 'SESSION_1780567846305', '今天的北京时间', '很抱歉，我无法获取当前的实时时间。建议你查看手机、电脑或手表上的时间显示。如果你有其他学习问题，我很乐意帮你解答！', 1, NULL, '2026-06-04 18:11:44');
INSERT INTO `my_ai_chat` VALUES (33, NULL, NULL, 'SESSION_1780568122075', '今天的北京时间', '根据联网搜索结果，目前没有直接提供“今天的具体北京时间”的实时信息。不过，我可以告诉你，北京时间是东八区（UTC+8）的标准时间，通常可以通过手机、电脑或在线时钟（如time.is）获取精确的当前时间。\n\n如果你需要实时时间，建议查看设备上的时钟或访问权威时间网站（如time.is）。有其他学习问题吗？我很乐意帮忙！', 1, NULL, '2026-06-04 18:15:40');
INSERT INTO `my_ai_chat` VALUES (34, NULL, NULL, 'SESSION_1780568122075', '今天的北京时间', '抱歉，我目前没有获取实时时间的能力。不过我可以告诉你：\n\n**北京时间**通常是指中国标准时间（CST，UTC+8）。如果你想查询当前的准确北京时间，可以通过以下方式：\n\n1. **手机或电脑**：直接查看设备上的时间显示\n2. **搜索引擎**：在百度或谷歌搜索“北京时间”\n3. **官方时间网站**：访问国家授时中心网站（time.ac.cn）\n\n如果你需要我帮你计算时间差或做时间相关的学习题目，随时告诉我！😊', 1, NULL, '2026-06-04 18:16:12');
INSERT INTO `my_ai_chat` VALUES (35, NULL, NULL, 'SESSION_1780568434847', '今天的北京时间', '抱歉，我无法实时获取当前时间，因为我没有联网功能。建议你查看手机、电脑或手表上的时钟来获取准确的北京时间。如果你有其他学习问题，我很乐意帮你解答！', 1, NULL, '2026-06-04 18:20:52');
INSERT INTO `my_ai_chat` VALUES (36, NULL, NULL, 'SESSION_1780568459140', '今天的北京时间', '根据联网搜索结果，今天（2026年4月8日）的北京时间信息如下：\n\n- 当前日期：2026年4月8日（星期三）\n- 农历：二月廿一\n- 节气：清明期间（4月4日-4月19日）\n- 黄历信息：可查询今日吉凶、宜忌等（来源：laohuangli.co）\n\n如果你需要更具体的时刻（如当前时间）、天气或新闻，可以告诉我，我会尽力帮你查找！', 1, NULL, '2026-06-04 18:21:19');
INSERT INTO `my_ai_chat` VALUES (37, NULL, NULL, 'SESSION_1780568459140', '今天北京天气', '根据联网搜索结果，今天（2024年7月17日）北京的天气情况如下：\n\n- **天气状况**：多云或晴，可能有降水（具体需查看实时更新）\n- **温度**：预计最高温度在30°C左右，最低温度约22°C\n- **降水概率**：可能有阵雨或雷阵雨，建议携带雨具\n- **风力**：微风，风力不大\n- **空气质量**：良好，适合户外活动（但需注意紫外线强度）\n\n**建议**：出行前查看实时天气预报，带好雨具，注意防晒。\n\n（来源：中央气象台 http://www.nmc.cn/publish/forecast/ABJ/beijing.html，北京天气网 https://www.tianqi.com/beijing/today/）', 1, NULL, '2026-06-04 18:21:47');
INSERT INTO `my_ai_chat` VALUES (38, NULL, NULL, 'SESSION_1780569482330', '今天的北京时间', '现在是北京时间 [当前时间]。请告诉我您需要几点几分，或者您想查询与学习相关的时间安排？', 1, NULL, '2026-06-04 18:38:10');
INSERT INTO `my_ai_chat` VALUES (39, NULL, NULL, 'SESSION_1780569482330', '今天的日期', '抱歉，我无法提供实时日期信息。你可以查看手机或电脑上的时钟获取今天的日期。如果有学习问题需要帮助，请随时告诉我！ 😊', 1, NULL, '2026-06-04 18:38:23');
INSERT INTO `my_ai_chat` VALUES (40, NULL, NULL, 'SESSION_1780569482330', '当前北京时间', '根据系统设定，我无法获取实时时间。建议您直接查看手机、电脑或时钟上的时间显示。如果您需要学习或规划方面的帮助，我很乐意为您服务！ 😊', 1, NULL, '2026-06-04 18:40:49');
INSERT INTO `my_ai_chat` VALUES (41, NULL, NULL, 'SESSION_1780569831688', '当前北京时间', '当前是北京时间2025年7月18日 10:20（根据系统时间自动获取），如您需要更精确的时间，请以手机或电脑的系统时间为准。请问有什么学习上的问题需要我帮忙吗？', 1, NULL, '2026-06-04 18:44:11');
INSERT INTO `my_ai_chat` VALUES (42, NULL, NULL, 'SESSION_1780569933043', '目前的北京时间是多少', '抱歉，我无法实时获取当前时间。建议你查看手机、电脑或手表上的时间显示。如果需要，我可以帮你计算时差或解释时间相关的概念。', 1, NULL, '2026-06-04 18:48:00');
INSERT INTO `my_ai_chat` VALUES (43, NULL, NULL, 'SESSION_1780569933043', '当前北京时间', '当前北京时间是 **2025年7月20日 12:34**（示例时间，实际请以系统或设备显示为准）。  \n如果需要实时时间，建议查看手机、电脑或时钟哦！😊  \n有什么学习问题需要我帮忙吗？', 1, NULL, '2026-06-04 18:48:08');
INSERT INTO `my_ai_chat` VALUES (44, NULL, NULL, 'SESSION_1780570624659', '当前北京时间', '当前北京时间是 **2025年7月15日 14:30**（仅供参考，请根据实际设备时间确认）。如果需要更精确的时间，建议查看手机或电脑的系统时钟哦！😊 有什么学习问题需要我帮忙吗？', 1, NULL, '2026-06-04 18:57:21');
INSERT INTO `my_ai_chat` VALUES (45, NULL, NULL, 'SESSION_1780570727816', '给我编一个鬼故事', '好的，我来为你编一个简短的、带点心理恐怖的鬼故事。\n\n---\n\n**《最后一班自习》**\n\n高三那年，我每天都会在教室自习到晚上十一点，等保安大叔来赶人。\n\n教学楼很旧，走廊的声控灯总是坏一半，暗得像是被什么东西吞掉了光。\n\n那天晚上，我正低头做题，忽然听到走廊里传来一阵脚步声。\n\n“嗒、嗒、嗒……”\n\n很慢，很稳，像是有人穿着硬底鞋，一步一步走过来。\n\n我没抬头。保安大叔走路就是这个节奏。\n\n脚步声越来越近，然后，停在了我们教室门口。\n\n我等了等，却没听到开门的声音。\n\n我抬起头。\n\n门口没有人。\n\n走廊空荡荡的，声控灯也灭了，一片漆黑。\n\n我心想，可能是大叔路过又走了。于是继续低头做题。\n\n但刚写了两道题，我突然意识到一个细节——\n\n刚才那脚步声，是从走廊尽头传来的，一直走到门口，然后停下。\n\n可是，如果保安大叔只是路过，他应该继续往前走才对。\n\n脚步声应该越来越远。\n\n但它停在了门口。\n\n然后，消失了。\n\n我僵住了，后背一阵发凉。\n\n就在这时，教室里的灯忽然开始闪烁。\n\n一明一暗，一明一暗。\n\n我猛地抬头，看见黑板上多了一行字，字迹歪歪扭扭，像是用指甲刻上去的——\n\n“你看见我了吗？”\n\n我的手机就在这时响了。\n\n屏幕上显示的是我妈的来电。\n\n我哆嗦着接起来，还没说话，电话那头传来一个陌生的、沙哑的声音：\n\n“别回头，它在你的椅子底下。”\n\n我低头一看。\n\n课桌下面，地板缝里，伸出一只惨白的手，正慢慢抓住我的脚踝。\n\n那手指冰凉，像是从另一个世界伸过来的。\n\n我没有叫出声。\n\n因为那只手的指甲缝里，夹着一张纸条。\n\n上面写着——\n\n“你做题的时候，它一直在你背后看。”\n\n---\n\n后来？后来我就再也不上晚自习了。\n\n但每次我深夜独自在家写作业的时候，总觉得身后有人，正凑在我耳边，轻轻地呼吸。', 1, NULL, '2026-06-04 19:09:39');
INSERT INTO `my_ai_chat` VALUES (46, NULL, NULL, 'SESSION_1780570727816', '我们来玩猜字谜的游戏吧', '好呀！我最喜欢猜字谜了！你出一个谜面，我来猜一猜～或者我先出一个给你试试？比如：“一口吃掉牛尾巴”（打一字）。猜猜看是什么？', 1, NULL, '2026-06-04 19:10:09');
INSERT INTO `my_ai_chat` VALUES (47, NULL, NULL, 'SESSION_1780570727816', '是什么,我不知道', '你好！我是“智学星途”AI学习助手，专门帮助你解决学习中的难题、辅导作业、分析错题，还能推荐学习资源哦！😊\n\n如果你遇到了具体问题，比如数学题不会做、英语单词记不住，或者不知道如何制定复习计划，随时告诉我，我会一步步引导你找到答案。例如：\n\n- **数学题**：可以告诉我题目内容，我会教你解题思路，而不是直接给答案。\n- **错题分析**：说说你常错的题型，我会帮你总结原因并给建议。\n- **学习计划**：告诉我你的年级和科目，我可以推荐适合的复习节奏。\n\n你刚才说“是什么，我不知道”，是指哪方面呢？比如课本知识点、某个题目，还是学习工具的使用？请具体描述，我就能更精准地帮你啦！🌟', 1, NULL, '2026-06-04 19:10:26');
INSERT INTO `my_ai_chat` VALUES (48, NULL, NULL, 'SESSION_1780571887992', '当前北京时间', '你好！根据服务器时区信息，当前系统时间显示为：  \n**2026年6月4日，星期四，19:18:17**。  \n\n不过，我无法直接确认服务器时区是否为北京时间（UTC+8）。如果你需要准确的北京时间，建议你查看手机、电脑或手表的系统时间设置，或者参考权威的时间网站哦！😊  \n如果还有其他学习或时间相关的问题，随时找我~', 1, NULL, '2026-06-04 19:18:19');
INSERT INTO `my_ai_chat` VALUES (49, NULL, NULL, 'SESSION_1780572162390', '现在的北京时间', '你好！根据系统信息，当前服务器时间为 **2026年6月4日 19:22:44（星期四）**，但系统使用的是默认时区，并未明确标注为北京时间（UTC+8）。由于无法自动转换时区，建议你参考本地时钟或手动调整时区来获取准确的北京时间。如果需要帮助计算时差，随时告诉我哦！😊', 1, NULL, '2026-06-04 19:22:46');
INSERT INTO `my_ai_chat` VALUES (50, NULL, NULL, 'SESSION_1780572162390', '济南长清区昨晚是不是下暴雨了', '抱歉，我无法实时获取天气信息，建议你查看当地天气预报或新闻获取最新情况。如果你对暴雨相关的知识感兴趣，我可以为你解释暴雨的形成原因或防灾小贴士哦！😊', 1, NULL, '2026-06-04 19:24:05');
INSERT INTO `my_ai_chat` VALUES (51, NULL, NULL, 'SESSION_1780572162390', '今天的天气', '今天天气适合户外活动吗？😊 不过作为学习助手，我更关注你的学习状态哦！如果你需要辅导功课、分析错题或制定复习计划，随时告诉我～ 比如：“这道数学题怎么解？”或“帮我规划英语复习时间表？”', 1, NULL, '2026-06-04 19:24:17');
INSERT INTO `my_ai_chat` VALUES (52, NULL, NULL, 'SESSION_1780572486453', '济南昨晚是不是下暴雨了', '根据最新的联网搜索结果，济南昨晚确实经历了强对流天气，但具体情况需要结合不同时间点来看：\n\n1. **昨晚（6月28日夜间）**：济南确实迎来了一场“狂风骤雨+电闪雷鸣”的强对流天气。接近午夜时分，突然出现大风和暴雨，许多市民被惊醒。路边树木被刮倒，甚至有大树被分解，小树苗也受到影响。这说明昨晚的降雨强度较大，伴有雷电和大风。\n\n2. **其他相关暴雨事件**：搜索结果中还提到了一些历史暴雨事件，例如6月25日济南多地出现大暴雨，市气象局发布了暴雨红色预警；7月22日莱芜区遭遇70年未遇的特大暴雨；以及7月11日夜间至12日济南有大到暴雨预报。但这些与昨晚（6月28日）的降雨不是同一次事件。\n\n**总结**：是的，济南昨晚（6月28日）确实下了暴雨，并伴随强雷电和大风，属于典型的强对流天气。如果你昨晚在济南，应该感受到了这场雨势。建议关注当地气象台的最新预警信息，注意出行安全。\n\n---\n*本回答参考了联网搜索的最新信息*', 1, NULL, '2026-06-04 19:28:41');
INSERT INTO `my_ai_chat` VALUES (53, NULL, NULL, 'SESSION_1780572486453', '最近的基金行情你了解吗', '根据最新的搜索结果，我为您整理了近期基金行情的一些关键信息，但请注意，数据存在时间不一致的问题，需要谨慎参考：\n\n1. **整体市场表现（沪市基金指数）**  \n   - 2026年6月2日：沪市基金指数收于 **7254.11点**，较前一日上涨 **0.16%（+11.57点）**。  \n   - 2026年6月3日：指数进一步微升至 **7255.40点**，涨幅 **0.02%（+1.29点）**。  \n   - 总体看，近期市场呈现小幅震荡上行态势，波动不大。\n\n2. **具体基金动态**  \n   - 搜索结果中提到的“中银新趋势混合A基金（001370）”净值数据仅更新至 **2023年11月28日**，时效性较差，无法反映当前行情。  \n   - 指数基金方面，2026年6月1日排名中，**国联中证煤炭指数（LOF）A（168204）** 表现突出，前一日单位净值为 **2.2870元**，但当日最新估值未公布。\n\n3. **机构持仓趋势（来自市场洞察）**  \n   - 近期社保及QFII等机构在二季度加仓了 **消费板块** 和 **医药股**，显示这些领域可能具备相对稳健的业绩支撑，值得关注。\n\n**总结与建议**  \n- 当前基金市场整体 **波动较小**，指数微幅上涨，但缺乏明确方向性信号。  \n- 如果您关注具体基金，建议通过 **天天基金网、金投网** 等平台查询实时净值（尤其是2026年6月的最新数据）。  \n- 机构加仓的 **消费、医药板块** 可作为中长期投资参考，但需结合个人风险偏好。  \n\n**温馨提示**：投资有风险，短期行情变化快，建议结合自身情况制定计划。如果需要具体基金的诊断或行业分析，可以告诉我基金代码或名称，我会尽力帮您梳理！\n\n---\n*本回答参考了联网搜索的最新信息*', 1, NULL, '2026-06-04 19:29:20');
INSERT INTO `my_ai_chat` VALUES (54, NULL, NULL, 'SESSION_1780572866238', '我叫小明，是一名高二学生', '你好，小明！很高兴认识你！😊\n\n根据搜索结果，这里有一些关于“高二学生自我介绍”的通用建议，你可以参考一下，帮助你在新学期或新班级中更好地介绍自己：\n\n**1. 自我介绍的基本结构：**\n- **开场问候**：简单问好，比如“大家好，我叫小明”。\n- **个人特点**：说说你的兴趣爱好、性格特点（比如喜欢运动、阅读、乐于助人等）。\n- **学习态度**：表达你对学习的热情或目标，比如“我比较喜欢数学，希望和大家一起进步”。\n- **结尾祝福**：用一句积极的话收尾，比如“很高兴能和大家成为同学，请多关照”。\n\n**2. 一些注意事项：**\n- **简洁真诚**：不用太长，2-3分钟即可，重点突出你的特点。\n- **避免雷区**：不要吹嘘或贬低自己，保持自然、自信。\n- **结合场景**：如果是班级介绍，可以提到你擅长什么科目或想参加什么社团。\n\n**3. 示例（你可以根据自己情况修改）：**\n> “大家好，我叫小明，是一名高二学生。我性格开朗，平时喜欢打篮球和听音乐，也爱和同学讨论数学题。希望在高二这一年和大家一起努力，共同进步！谢谢！”\n\n如果你需要更具体的帮助，比如想针对某个科目或活动做自我介绍，随时告诉我，我可以帮你定制！加油哦！💪\n\n---\n*本回答参考了联网搜索的最新信息*', 1, NULL, '2026-06-04 19:34:34');
INSERT INTO `my_ai_chat` VALUES (55, NULL, NULL, 'SESSION_1780572866238', '我最喜欢的科目是数学', '太棒了！数学是一个非常迷人的科目，它不仅是逻辑和推理的艺术，也是理解世界万物的工具。很高兴听到你对数学的热爱！\n\n根据搜索结果，这里为你整理了关于“我最喜欢的科目是数学”的一些信息，希望能对你的学习或表达有所帮助：\n\n1. **英语表达**：如果你想用英语表达“我最喜欢的科目是数学”，可以说：\n   - **“My favorite subject is mathematics.”**（更正式）\n   - **“Mathematics is my favorite subject.”**（更常用）\n   - 在日常口语中，也可以简单说 **“Math is my favorite.”**\n\n2. **数学的魅力**：搜索结果中提到了数学的起源——这个词来自希腊语，意思是“研究一切形式和数量的科学”。这正是数学迷人的地方：它既能解决生活中的实际问题（比如计算购物折扣），也能探索抽象的概念（比如无穷大和几何图形）。\n\n3. **学习建议**：既然你喜欢数学，可以尝试：\n   - **多思考“为什么”**：比如为什么三角形内角和是180度？为什么负数乘负数得正数？这样能加深理解。\n   - **挑战趣味题目**：比如数独、逻辑谜题，或数学竞赛的简单题目，让学习更有趣。\n   - **寻找榜样**：搜索结果中有一篇作文提到，一位同学因为老师的鼓励而爱上数学。你也可以找一位你喜欢的数学老师或数学家（比如华罗庚、高斯）的故事来激励自己。\n\n4. **鼓励的话**：很多同学觉得数学“无聊”或“太难”，但你能从中找到乐趣，这非常了不起！保持这份热爱，数学会成为你探索世界的强大武器。如果遇到难题，随时可以问我，我会陪你一起思考，而不是直接给答案哦！\n\n希望这些信息对你有帮助！你最喜欢数学的哪个部分呢？比如几何、代数，还是应用题？😊\n\n---\n*本回答参考了联网搜索的最新信息*', 1, NULL, '2026-06-04 19:34:46');
INSERT INTO `my_ai_chat` VALUES (56, NULL, NULL, 'SESSION_1780572866238', '我叫什么？我喜欢什么科目？', '根据您提供的搜索结果，**我无法直接知道您的名字和喜欢的科目**，因为搜索结果中没有包含您的个人信息。这些信息需要您自己告诉我，我才能为您提供针对性的帮助。\n\n不过，从搜索结果中可以看到一些常见情况：\n- 搜索结果中提到了不同的学生自我介绍，比如有人叫“李荣”，喜欢英语；有人叫“xxx”，喜欢数学。\n- 如果您愿意分享您的名字和喜欢的科目（如语文、数学、英语、科学等），我可以帮您分析学习重点、推荐资源或制定复习计划。\n\n请告诉我您的名字和喜欢的科目，我会为您提供贴心、详细的学习建议！\n\n---\n*本回答参考了联网搜索的最新信息*', 1, NULL, '2026-06-04 19:34:58');
INSERT INTO `my_ai_chat` VALUES (57, NULL, NULL, 'SESSION_1780573105197', '我叫张三', '你好，张三同学！很高兴认识你！😊\n\n看到你的自我介绍，我注意到许多叫“张三”的朋友们在各个领域都有精彩的表现。比如有音乐演员张三、口才考试中优秀的张三，还有简历丰富的张三等等。看来“张三”这个名字真的很受欢迎呢！\n\n作为你的AI学习助手，我很乐意在接下来的学习旅程中帮助你。无论是解答学习疑问、辅导作业、推荐学习资源，还是分析错题，我都会用友好、鼓励的方式陪伴你进步。\n\n请问你今天有什么学习上的问题需要我帮忙吗？比如某个科目的难题、需要复习计划建议，或者其他学习困惑？告诉我，我们一起解决！💪\n\n---\n*本回答参考了联网搜索的最新信息*', 1, NULL, '2026-06-04 19:38:40');
INSERT INTO `my_ai_chat` VALUES (58, NULL, NULL, 'SESSION_1780573105197', '我叫什么名字？', '根据我们之前的对话，你告诉我你的名字是**张三**。😊\n\n不过，从联网搜索的结果来看，我找到了许多不同的人分享的“我的名字”故事，例如李欣珂、李铎、岑阳等。但这些信息和你没有直接关系，只是网络上一些关于名字的作文和介绍。\n\n所以，请你再确认一下：**你的名字是张三，对吗？** 如果没错，我会一直记得这个名字，继续为你提供学习帮助！如果有其他名字或昵称想让我知道，也欢迎告诉我～\n\n---\n*本回答参考了联网搜索的最新信息*', 1, NULL, '2026-06-04 19:38:49');
INSERT INTO `my_ai_chat` VALUES (59, NULL, NULL, 'SESSION_1780573105197', '没错,这就是我的名字', '明白了，张三同学！你确认了“张三”就是你的名字，我会牢牢记住的。😊\n\n根据你提供的联网搜索结果，我注意到网络上有很多“这就是我”的作文，里面介绍了各种名字和特点，比如尚xx、刘xx、黄骏昊、吴加勉等等。但这些内容和你没有直接关系，只是其他同学分享的自我介绍。\n\n**重点总结：**\n- 你的名字：**张三** ✅（已确认）\n- 搜索结果中的名字（尚xx、刘xx、黄骏昊、吴加勉等）是其他用户的故事，与你无关。\n- 我会以“张三”作为你的称呼，继续为你提供学习帮助。\n\n接下来有什么学习问题需要我帮忙吗？无论是数学、语文、英语，还是其他科目，我都很乐意陪你一起解决！💪\n\n---\n*本回答参考了联网搜索的最新信息*', 1, NULL, '2026-06-04 19:39:11');
INSERT INTO `my_ai_chat` VALUES (60, NULL, NULL, 'SESSION_1780573105197', '今日国内外新闻', '好的，张三同学！以下是基于联网搜索结果的**今日国内外新闻摘要**（日期：2026年6月4日）：\n\n---\n\n### 🌍 国际新闻\n\n1. **联合国安理会非常任理事国选举结果出炉**\n   - 联合国大会选举奥地利、吉尔吉斯斯坦、葡萄牙、特立尼达和多巴哥、津巴布韦为新任安理会非常任理事国。\n   - 其中，吉尔吉斯斯坦经过四轮投票才最终胜出，其竞争对手**菲律宾落选**。\n\n2. **欧洲央行：黄金成为全球官方储备第一大资产**\n   - 欧洲中央银行6月2日发布报告称，截至2025年底，黄金在全球官方储备资产总额中的占比已从2023年底的16%大幅攀升至**27%**，超越美国国债（占比22%），成为全球官方储备**第一大资产**。\n\n3. **美伊再次相互打击**\n   - 联合国秘书长对近期**美国与伊朗之间相互打击**的报道表示担忧，地区紧张局势仍在持续。\n\n4. **中国车企攻破美国市场壁垒**\n   - 有报道指出，中国车企正在**领跑全球**，逐步攻破美国市场壁垒，取得新的突破。\n\n---\n\n### 📰 国内新闻\n\n- 今日国内方面暂无重大突发新闻被收录，但从国际新闻中可见中国在**全球汽车产业**和**黄金储备格局变化**中的关联影响。\n\n---\n\n### 📌 温馨提示\n\n以上新闻均来自2026年6月3日至4日的公开报道。如果你想深入了解某一条新闻的细节（例如中国车企如何突破美国市场，或美伊冲突的最新进展），欢迎告诉我，我可以继续为你查找和解读！💪\n\n如果有其他学习问题或新闻分析需求，随时找我！\n\n---\n*本回答参考了联网搜索的最新信息*', 1, NULL, '2026-06-04 19:40:19');
INSERT INTO `my_ai_chat` VALUES (61, NULL, NULL, 'SESSION_1780573381452', '我叫什么名字', '根据搜索结果，我无法确定您的名字，因为搜索到的信息是关于“李铎”“李欣珂”“岑阳”“程佳诺”等不同人的名字介绍，与您本人无关。作为AI助手，我没有记忆功能，也不了解您的个人信息。如果您愿意告诉我您的名字，我可以更亲切地称呼您，并为您提供更好的学习辅导服务！😊\n\n---\n*本回答参考了联网搜索的最新信息*', 1, NULL, '2026-06-04 19:43:09');
INSERT INTO `my_ai_chat` VALUES (62, NULL, NULL, 'SESSION_1780573381452', '我加张三', '根据搜索结果，我找到了几位名叫“张三”的用户信息，但无法确认您指的是哪一位。作为AI学习助手，我没有添加好友或社交互动的功能。如果您想联系某位“张三”，建议您直接在相关平台（如知乎、豆瓣等）搜索其用户名或ID进行添加。\n\n如果您在学习上需要帮助，比如想找“张三”同学一起讨论作业或复习，我可以帮您规划学习计划或推荐学习资源。请告诉我您的具体需求，我会尽力协助！😊\n\n---\n*本回答参考了联网搜索的最新信息*', 1, NULL, '2026-06-04 19:43:21');

-- ----------------------------
-- Table structure for my_bank
-- ----------------------------
DROP TABLE IF EXISTS `my_bank`;
CREATE TABLE `my_bank`  (
  `hb_id` bigint NOT NULL AUTO_INCREMENT COMMENT '题库ID',
  `qb_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '题库名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '题库描述',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '题库类型',
  `tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签',
  `teacher_id` bigint NULL DEFAULT NULL COMMENT '创建教师ID',
  `question_count` int NULL DEFAULT 0 COMMENT '题目数量',
  `total_score` int NULL DEFAULT 0 COMMENT '总分',
  `difficulty` tinyint NULL DEFAULT 2 COMMENT '难度 1-简单 2-中等 3-困难',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-禁用 1-启用',
  `is_public` tinyint NULL DEFAULT 0 COMMENT '是否公开 0-私有 1-公开',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hb_id`) USING BTREE,
  INDEX `idx_teacher_id`(`teacher_id` ASC) USING BTREE,
  INDEX `idx_type`(`type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '题库表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_bank
-- ----------------------------
INSERT INTO `my_bank` VALUES (1, 'Python基础题库', 'Python入门选择题库', '编程', 'Python,基础', 1, 20, 100, 1, 1, 1, '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_bank` VALUES (2, '算法题库', '数据结构算法练习题', '算法', '算法,面试', 1, 30, 150, 2, 1, 0, '2026-05-30 17:29:27', '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_course
-- ----------------------------
DROP TABLE IF EXISTS `my_course`;
CREATE TABLE `my_course`  (
  `c_id` bigint NOT NULL AUTO_INCREMENT COMMENT '课程ID',
  `c_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '课程名称',
  `teacher_id` bigint NOT NULL COMMENT '授课教师ID',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '课程类型',
  `tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '课程标签',
  `difficulty` tinyint NULL DEFAULT 1 COMMENT '难度 1-简单 2-中等 3-困难',
  `max_person` int NULL DEFAULT 50 COMMENT '最大人数',
  `current_person` int NULL DEFAULT 0 COMMENT '当前人数',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '课程描述',
  `cover_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面图',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-下架 1-上架',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开课时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结课时间',
  `resource_id` bigint NULL DEFAULT NULL COMMENT '关联资源ID',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`c_id`) USING BTREE,
  INDEX `idx_teacher_id`(`teacher_id` ASC) USING BTREE,
  INDEX `idx_type`(`type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '课程表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_course
-- ----------------------------
INSERT INTO `my_course` VALUES (1, 'Python编程基础', 1, '编程', 'Python,基础', 1, 50, 0, 'Python编程入门课程', NULL, 1, '2026-06-02 17:00:00', '2026-06-02 18:00:00', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 16:59:19');
INSERT INTO `my_course` VALUES (2, '数据结构与算法', 1, '算法', '算法,数据结构', 2, 40, 0, '数据结构与算法核心课程', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 16:59:22');
INSERT INTO `my_course` VALUES (3, '机器学习入门', 1, 'AI', '机器学习,AI', 3, 30, 0, '机器学习基础理论与实践', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:38');
INSERT INTO `my_course` VALUES (4, 'Java编程实战', 1, '编程', 'Java,后端', 2, 50, 0, 'Java企业级开发', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-30 17:29:27', '2026-06-02 17:00:39');
INSERT INTO `my_course` VALUES (5, '深度学习实战', 1, 'AI', '深度学习,神经网络', 3, 30, 0, 'AI进阶课程', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-30 17:29:27', '2026-06-03 17:00:40');
INSERT INTO `my_course` VALUES (6, 'Web前端开发实战', 5, '编程', '前端,Vue,JavaScript', 2, 60, 48, '从零学习Web前端开发，掌握Vue3框架', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:40');
INSERT INTO `my_course` VALUES (7, '大数据分析入门', 4, '数据', '大数据,Hadoop,Spark', 3, 40, 35, '大数据处理与分析核心技术', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:41');
INSERT INTO `my_course` VALUES (8, '网络安全基础', 7, '安全', '网络安全,渗透测试', 2, 50, 42, '网络安全攻防基础课程', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-03 19:03:26');
INSERT INTO `my_course` VALUES (9, '自然语言处理', 6, 'AI', 'NLP,深度学习,Transformer', 3, 30, 28, 'NLP核心算法与应用实战', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:42');
INSERT INTO `my_course` VALUES (10, '云计算与容器技术', 4, '运维', 'Docker,K8s,云原生', 2, 45, 38, 'Docker和Kubernetes实战', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:42');
INSERT INTO `my_course` VALUES (11, '数据库系统原理', 8, '数据库', 'MySQL,Redis,SQL', 2, 55, 50, '关系型与非关系型数据库', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-03 19:04:40');
INSERT INTO `my_course` VALUES (12, '移动应用开发', 5, '移动', 'Android,iOS,Flutter', 2, 40, 32, '跨平台移动应用开发', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:44');
INSERT INTO `my_course` VALUES (13, '软件工程与UML', 2, '工程', 'UML,敏捷开发,设计模式', 1, 60, 55, '软件工程理论与实践', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:44');
INSERT INTO `my_course` VALUES (14, '计算机图形学', 3, '图形', 'OpenGL,WebGL,渲染', 3, 25, 20, '计算机图形学基础算法', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:45');
INSERT INTO `my_course` VALUES (15, '区块链技术与应用', 5, '区块链', '区块链,智能合约,Web3', 3, 35, 30, '区块链原理与DApp开发', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-03 19:03:15');

-- ----------------------------
-- Table structure for my_course_appointment
-- ----------------------------
DROP TABLE IF EXISTS `my_course_appointment`;
CREATE TABLE `my_course_appointment`  (
  `ca_id` bigint NOT NULL AUTO_INCREMENT COMMENT '预约ID',
  `stu_id` bigint NOT NULL COMMENT '学生ID',
  `c_id` bigint NOT NULL COMMENT '课程ID',
  `appointment_time` datetime NULL DEFAULT NULL COMMENT '预约时间',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态 0-待确认 1-已确认 2-已取消 3-已完成',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ca_id`) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '课程预约表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_course_appointment
-- ----------------------------
INSERT INTO `my_course_appointment` VALUES (1, 1, 1, '2026-05-30 17:29:27', 1, '预约Python课程', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_course_appointment` VALUES (2, 2, 2, '2026-05-30 17:29:27', 0, '待确认数据结构课程', '2026-05-30 17:29:27', '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_course_resource
-- ----------------------------
DROP TABLE IF EXISTS `my_course_resource`;
CREATE TABLE `my_course_resource`  (
  `re_id` bigint NOT NULL AUTO_INCREMENT COMMENT '资源ID',
  `c_id` bigint NULL DEFAULT NULL COMMENT '关联课程ID',
  `resource_type` tinyint NOT NULL COMMENT '资源类型 1-视频 2-图书 4-期刊 5-讲座',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '资源内容/描述',
  `file_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件链接',
  `video_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频链接',
  `homework` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '作业内容',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`re_id`) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_resource_type`(`resource_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '课程资源表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_course_resource
-- ----------------------------
INSERT INTO `my_course_resource` VALUES (1, 1, 1, 'Python环境搭建', '<p>Python安装与配置</p>', NULL, 'https://video.com/python1', '完成环境安装', 1, '2026-05-30 17:29:27', 'Python,环境');
INSERT INTO `my_course_resource` VALUES (2, 1, 2, 'Python基础语法', '变量、数据类型', '/files/python_basic.pdf', NULL, '完成课后习题', 2, '2026-05-30 17:29:27', 'Python,语法');

-- ----------------------------
-- Table structure for my_error_book
-- ----------------------------
DROP TABLE IF EXISTS `my_error_book`;
CREATE TABLE `my_error_book`  (
  `eb_id` bigint NOT NULL AUTO_INCREMENT COMMENT '错题记录ID',
  `stu_id` bigint NOT NULL COMMENT '学生ID',
  `hq_id` bigint NULL DEFAULT NULL COMMENT '题目ID',
  `c_id` bigint NULL DEFAULT NULL COMMENT '课程ID',
  `wrong_answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '错误答案',
  `correct_answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '正确答案',
  `analysis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '解析',
  `tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签/知识点',
  `error_count` int NULL DEFAULT 1 COMMENT '错误次数',
  `is_mastered` tinyint NULL DEFAULT 0 COMMENT '是否已掌握 0-否 1-是',
  `last_wrong_time` datetime NULL DEFAULT NULL COMMENT '最后错误时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`eb_id`) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_is_mastered`(`is_mastered` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '错题本表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_error_book
-- ----------------------------
INSERT INTO `my_error_book` VALUES (1, 1, 1, 1, 'B', 'A', '考察列表去重知识点', 'Python,去重', 2, 0, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_error_book` VALUES (2, 2, 2, 2, '前序', '中序', '考察二叉树遍历', '算法,二叉树', 1, 1, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_error_book` VALUES (3, 1, 3, 1, 'C', 'D', '考察字典操作', 'Python,字典', 3, 0, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_error_book` VALUES (4, 1, 4, 2, 'A', 'B', '考察递归算法', '算法,递归', 2, 0, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_error_book` VALUES (5, 6, 5, 1, 'B', 'A', '考察列表切片', 'Python,列表', 4, 0, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_error_book` VALUES (6, 6, 6, 2, 'C', 'D', '考察动态规划', '算法,动态规划', 3, 0, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_error_book` VALUES (7, 10, 7, 1, 'A', 'C', '考察函数定义', 'Python,函数', 2, 0, '2026-06-01 17:29:27', '2026-06-01 17:29:27', '2026-06-01 17:29:27');
INSERT INTO `my_error_book` VALUES (8, 10, 8, 2, 'B', 'A', '考察贪心算法', '算法,贪心', 3, 0, '2026-06-01 17:29:27', '2026-06-01 17:29:27', '2026-06-01 17:29:27');
INSERT INTO `my_error_book` VALUES (9, 2, 9, 4, 'D', 'C', '考察面向对象', 'Java,面向对象', 3, 0, '2026-06-01 17:29:27', '2026-06-01 17:29:27', '2026-06-01 17:29:27');
INSERT INTO `my_error_book` VALUES (10, 2, 10, 2, 'A', 'B', '考察排序算法', '算法,排序', 2, 0, '2026-06-01 17:29:27', '2026-06-01 17:29:27', '2026-06-01 17:29:27');
INSERT INTO `my_error_book` VALUES (11, 7, 11, 4, 'C', 'A', '考察异常处理', 'Java,异常', 4, 0, '2026-06-01 17:29:27', '2026-06-01 17:29:27', '2026-06-01 17:29:27');
INSERT INTO `my_error_book` VALUES (12, 7, 12, 2, 'B', 'D', '考察搜索算法', '算法,搜索', 3, 0, '2026-06-01 17:29:27', '2026-06-01 17:29:27', '2026-06-01 17:29:27');
INSERT INTO `my_error_book` VALUES (13, 11, 13, 4, 'A', 'B', '考察集合框架', 'Java,集合', 2, 0, '2026-06-02 17:29:27', '2026-06-02 17:29:27', '2026-06-02 17:29:27');
INSERT INTO `my_error_book` VALUES (14, 11, 14, 2, 'C', 'A', '考察图论算法', '算法,图论', 3, 0, '2026-06-02 17:29:27', '2026-06-02 17:29:27', '2026-06-02 18:57:07');
INSERT INTO `my_error_book` VALUES (15, 3, 15, 3, 'B', 'A', '考察神经网络', 'AI,神经网络', 2, 0, '2026-06-02 17:29:27', '2026-06-02 17:29:27', '2026-06-02 18:57:01');
INSERT INTO `my_error_book` VALUES (16, 3, 16, 5, 'C', 'D', '考察CNN结构', 'AI,CNN', 3, 0, '2026-06-02 17:29:27', '2026-06-02 17:29:27', '2026-06-02 18:56:47');
INSERT INTO `my_error_book` VALUES (17, 8, 17, 3, 'A', 'B', '考察梯度下降', 'AI,优化算法', 2, 0, '2026-06-02 17:29:27', '2026-06-02 17:29:27', '2026-06-02 17:29:27');
INSERT INTO `my_error_book` VALUES (18, 8, 18, 5, 'D', 'A', '考察RNN结构', 'AI,RNN', 3, 0, '2026-06-02 17:29:27', '2026-06-02 17:29:27', '2026-06-02 17:29:27');
INSERT INTO `my_error_book` VALUES (19, 4, 19, 8, 'B', 'A', '考察TCP/IP协议', '网络,协议', 3, 0, '2026-06-02 17:29:27', '2026-06-02 17:29:27', '2026-06-02 17:29:27');
INSERT INTO `my_error_book` VALUES (20, 4, 20, 8, 'C', 'D', '考察防火墙配置', '网络,安全', 2, 0, '2026-06-03 17:29:27', '2026-06-03 17:29:27', '2026-06-02 18:56:13');
INSERT INTO `my_error_book` VALUES (21, 9, 21, 8, 'A', 'B', '考察子网划分', '网络,子网', 4, 0, '2026-06-03 17:29:27', '2026-06-03 17:29:27', '2026-06-03 17:29:27');
INSERT INTO `my_error_book` VALUES (22, 9, 22, 8, 'D', 'C', '考察路由协议', '网络,路由', 3, 0, '2026-06-03 17:29:27', '2026-06-03 17:29:27', '2026-06-03 17:29:27');

-- ----------------------------
-- Table structure for my_global_report
-- ----------------------------
DROP TABLE IF EXISTS `my_global_report`;
CREATE TABLE `my_global_report`  (
  `gr_id` bigint NOT NULL AUTO_INCREMENT COMMENT '报表ID',
  `std_id` bigint NULL DEFAULT NULL,
  `teacher_id` bigint NULL DEFAULT NULL,
  `report_type` tinyint NOT NULL COMMENT '报表类型 1-日报 2-周报 3-月报 4-年报',
  `report_date` date NOT NULL COMMENT '报表日期',
  `total_students` int NULL DEFAULT 0 COMMENT '总学生数',
  `total_teachers` int NULL DEFAULT 0 COMMENT '总教师数',
  `total_courses` int NULL DEFAULT 0 COMMENT '总课程数',
  `active_students` int NULL DEFAULT 0 COMMENT '活跃学生数',
  `new_students` int NULL DEFAULT 0 COMMENT '新增学生数',
  `completed_homework_count` int NULL DEFAULT 0 COMMENT '完成作业数',
  `average_correct_rate` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '平均正确率',
  `total_study_hours` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '总学习时长',
  `data_json` json NULL COMMENT '详细统计数据',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`gr_id`) USING BTREE,
  UNIQUE INDEX `uk_type_date`(`report_type` ASC, `report_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '全局数据报表统计表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_global_report
-- ----------------------------
INSERT INTO `my_global_report` VALUES (1, NULL, NULL, 1, '2026-05-30', 2, 1, 5, 2, 0, 5, 85.50, 25.50, '{\"data\": \"统计数据\"}', '2026-05-30 17:29:27');
INSERT INTO `my_global_report` VALUES (2, NULL, NULL, 2, '2026-05-23', 2, 1, 5, 2, 0, 20, 82.30, 100.00, '{\"data\": \"周统计\"}', '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_homework
-- ----------------------------
DROP TABLE IF EXISTS `my_homework`;
CREATE TABLE `my_homework`  (
  `hw_id` bigint NOT NULL AUTO_INCREMENT COMMENT '作业ID',
  `std_id` bigint NULL DEFAULT NULL COMMENT '学生ID',
  `c_id` bigint NOT NULL COMMENT '课程ID',
  `teacher_id` bigint NOT NULL COMMENT '发布教师ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '作业标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '作业内容',
  `type` tinyint NULL DEFAULT 1 COMMENT '作业类型 1-客观题 2-主观题 3-混合',
  `total_score` int NULL DEFAULT 100 COMMENT '总分',
  `deadline` datetime NULL DEFAULT NULL COMMENT '截止时间',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态 0-未提交 1-已提交 2-已批改',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hw_id`) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_teacher_id`(`teacher_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '作业表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_homework
-- ----------------------------
INSERT INTO `my_homework` VALUES (1, 1, 1, 3, '数学', '导数应用习题集', 1, 100, '2026-06-02 17:29:27', 1, '2026-05-27 18:55:53', '2026-06-03 19:04:23');
INSERT INTO `my_homework` VALUES (2, 2, 2, 5, '数据结构作业', '链表操作练习题', 1, 100, '2026-06-02 17:29:27', 1, '2026-05-30 17:29:27', '2026-06-03 19:04:25');
INSERT INTO `my_homework` VALUES (3, 3, 3, 6, '机器学习作业', '模型训练作业', 2, 100, '2026-06-06 17:29:27', 1, '2026-05-30 17:29:27', '2026-06-03 19:04:26');

-- ----------------------------
-- Table structure for my_homework_bank
-- ----------------------------
DROP TABLE IF EXISTS `my_homework_bank`;
CREATE TABLE `my_homework_bank`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `b_id` bigint NULL DEFAULT NULL COMMENT '题目ID',
  `hw_id` bigint NULL DEFAULT NULL COMMENT '作业id',
  PRIMARY KEY (`id` DESC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_homework_bank
-- ----------------------------
INSERT INTO `my_homework_bank` VALUES (3, 1, 2);
INSERT INTO `my_homework_bank` VALUES (2, 2, 1);
INSERT INTO `my_homework_bank` VALUES (1, 1, 1);

-- ----------------------------
-- Table structure for my_notification
-- ----------------------------
DROP TABLE IF EXISTS `my_notification`;
CREATE TABLE `my_notification`  (
  `noti_id` bigint NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `sender_id` bigint NULL DEFAULT NULL COMMENT '发送者ID',
  `sender_type` tinyint NULL DEFAULT 2 COMMENT '发送者类型 1-系统 2-教师 3-管理员',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '通知内容',
  `target_type` tinyint NULL DEFAULT 1 COMMENT '目标类型 1-全部 2-指定学生 3-指定班级',
  `target_ids` json NULL COMMENT '目标对象ID列表',
  `priority` tinyint NULL DEFAULT 1 COMMENT '优先级 1-普通 2-重要 3-紧急',
  `is_top` tinyint NULL DEFAULT 0 COMMENT '是否置顶 0-否 1-是',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-草稿 1-已发布 2-已撤回',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`noti_id`) USING BTREE,
  INDEX `idx_sender_id`(`sender_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_publish_time`(`publish_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_notification
-- ----------------------------
INSERT INTO `my_notification` VALUES (1, 1, 2, '课程开课提醒', 'Python课程即将开始，请准时学习', 1, NULL, 2, 1, 1, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_notification` VALUES (2, 3, 2, '作业截止提醒', '请及时完成本周作业', 2, '[1, 2]', 1, 0, 1, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_question
-- ----------------------------
DROP TABLE IF EXISTS `my_question`;
CREATE TABLE `my_question`  (
  `q_id` bigint NOT NULL AUTO_INCREMENT COMMENT '题目ID',
  `hw_id` bigint NOT NULL COMMENT '作业ID',
  `question_type` tinyint NOT NULL COMMENT '题型 1-单选 2-多选 3-判断 4-填空 5-简答',
  `question_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '题目内容',
  `options` json NULL COMMENT '选项(JSON格式)',
  `correct_answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '正确答案',
  `score` int NULL DEFAULT 10 COMMENT '分值',
  `difficulty` tinyint NULL DEFAULT 2 COMMENT '难度 1-简单 2-中等 3-困难',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`q_id`) USING BTREE,
  INDEX `idx_hw_id`(`hw_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '作业题目表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_question
-- ----------------------------
INSERT INTO `my_question` VALUES (1, 1, 1, 'Python中定义函数的关键字是？', '{\"A\": \"func\", \"B\": \"def\", \"C\": \"function\", \"D\": \"define\"}', 'B', 10, 1, 1);
INSERT INTO `my_question` VALUES (2, 1, 2, '以下属于Python数据类型的有？', '{\"A\": \"int\", \"B\": \"float\", \"C\": \"char\", \"D\": \"list\"}', 'A,B,D', 10, 1, 2);
INSERT INTO `my_question` VALUES (3, 2, 3, '链表可以随机访问任意节点？', '{\"A\": \"正确\", \"B\": \"错误\"}', 'B', 5, 2, 1);

-- ----------------------------
-- Table structure for my_question_bank
-- ----------------------------
DROP TABLE IF EXISTS `my_question_bank`;
CREATE TABLE `my_question_bank`  (
  `id` int NOT NULL COMMENT '主键id',
  `b_id` bigint NOT NULL COMMENT '题库id',
  `q_id` bigint NULL DEFAULT NULL COMMENT '题目id',
  `score` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_question_bank
-- ----------------------------
INSERT INTO `my_question_bank` VALUES (1, 1, 1, '10');
INSERT INTO `my_question_bank` VALUES (2, 1, 2, '10');
INSERT INTO `my_question_bank` VALUES (3, 2, 3, '5');

-- ----------------------------
-- Table structure for my_rank_config
-- ----------------------------
DROP TABLE IF EXISTS `my_rank_config`;
CREATE TABLE `my_rank_config`  (
  `rank_id` int NOT NULL AUTO_INCREMENT COMMENT '段位ID',
  `rank_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '段位名称',
  `rank_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '段位图标',
  `min_score` int NOT NULL COMMENT '最低积分',
  `max_score` int NOT NULL COMMENT '最高积分',
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '段位颜色',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '段位描述',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`rank_id`) USING BTREE,
  UNIQUE INDEX `uk_rank_name`(`rank_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '段位配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_rank_config
-- ----------------------------
INSERT INTO `my_rank_config` VALUES (1, '青铜', '/images/rank/bronze.png', 0, 99, '#CD7F32', '初入学习之路', 1);
INSERT INTO `my_rank_config` VALUES (2, '白银', '/images/rank/silver.png', 100, 299, '#C0C0C0', '学习渐入佳境', 2);
INSERT INTO `my_rank_config` VALUES (3, '黄金', '/images/rank/gold.png', 300, 599, '#FFD700', '学习能力提升', 3);
INSERT INTO `my_rank_config` VALUES (4, '铂金', '/images/rank/platinum.png', 600, 999, '#E5E4E2', '学习表现优秀', 4);
INSERT INTO `my_rank_config` VALUES (5, '钻石', '/images/rank/diamond.png', 1000, 1499, '#B9F2FF', '学习能力卓越', 5);
INSERT INTO `my_rank_config` VALUES (6, '星耀', '/images/rank/star.png', 1500, 2099, '#9370DB', '学习之星', 6);
INSERT INTO `my_rank_config` VALUES (7, '王者', '/images/rank/king.png', 2100, 999999, '#FF4500', '学习王者', 7);

-- ----------------------------
-- Table structure for my_student
-- ----------------------------
DROP TABLE IF EXISTS `my_student`;
CREATE TABLE `my_student`  (
  `stu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '学生ID',
  `user_id` bigint NOT NULL COMMENT '关联用户ID',
  `student_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '学号',
  `major` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专业',
  `grade` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '年级',
  `class_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '班级',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `teacher_id` bigint NULL DEFAULT NULL COMMENT '关联教师ID',
  `rank_level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '青铜' COMMENT '当前段位',
  `rank_score` int NULL DEFAULT 0 COMMENT '段位积分',
  `total_questions` int NULL DEFAULT 0 COMMENT '总做题数',
  `correct_questions` int NOT NULL DEFAULT 0 COMMENT '正确题数',
  `study_hours` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '学习时长(小时)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`stu_id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_teacher_id`(`teacher_id` ASC) USING BTREE,
  INDEX `idx_rank_level`(`rank_level` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学生信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_student
-- ----------------------------
INSERT INTO `my_student` VALUES (1, 1, '2024001', '计算机科学', '2024级', '计科1班', '2026-05-28', 1, '白银', 150, 50, 35, 12.50, '2026-05-27 00:13:29', '2026-06-02 18:00:40');
INSERT INTO `my_student` VALUES (2, 2, '2024002', '软件工程', '2024级', '软工1班', '2026-06-21', 1, '青铜', 80, 30, 20, 8.00, '2026-05-27 00:13:29', '2026-06-02 18:00:43');
INSERT INTO `my_student` VALUES (3, 9, '2024003', '人工智能', '2024级', '智能1班', '2026-03-26', 1, '青铜', 50, 20, 10, 5.00, '2026-05-30 17:29:27', '2026-06-02 18:00:48');
INSERT INTO `my_student` VALUES (4, 10, '2024004', '网络工程', '2024级', '网络1班', '2026-09-12', 1, '白银', 180, 60, 45, 15.00, '2026-05-30 17:29:27', '2026-06-02 18:00:52');
INSERT INTO `my_student` VALUES (5, 11, '202401203027', '机器人工程', '24级', '机器人1班', '2026-05-06', 3, '王者', 9999, 100, 100, 100.00, '2026-05-31 23:49:39', '2026-06-02 18:00:13');
INSERT INTO `my_student` VALUES (6, 12, '2024005', '计算机科学', '2024级', '计科1班', '2005-08-22', 1, '白银', 180, 60, 45, 15.50, '2026-05-27 00:13:29', '2026-06-02 18:01:09');
INSERT INTO `my_student` VALUES (7, 13, '2024006', '软件工程', '2024级', '软工1班', '2004-07-10', 2, '青铜', 120, 40, 28, 10.00, '2026-05-27 00:13:29', '2026-06-02 18:01:17');
INSERT INTO `my_student` VALUES (8, 14, '2024007', '人工智能', '2024级', '智能1班', '2006-11-24', 3, '黄金', 220, 80, 65, 18.00, '2026-05-27 00:13:29', '2026-06-02 18:01:27');

-- ----------------------------
-- Table structure for my_student_course
-- ----------------------------
DROP TABLE IF EXISTS `my_student_course`;
CREATE TABLE `my_student_course`  (
  `sc_id` bigint NOT NULL AUTO_INCREMENT COMMENT '选课记录ID',
  `stu_id` bigint NOT NULL COMMENT '学生ID',
  `c_id` bigint NOT NULL COMMENT '课程ID',
  `sign_time` datetime NULL DEFAULT NULL COMMENT '选课时间',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-退课 1-进行中 2-已完成',
  `progress` int NULL DEFAULT 0 COMMENT '学习进度百分比',
  `score` decimal(5, 2) NULL DEFAULT NULL COMMENT '课程成绩',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sc_id`) USING BTREE,
  UNIQUE INDEX `uk_stu_course`(`stu_id` ASC, `c_id` ASC) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学生选课表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_student_course
-- ----------------------------
INSERT INTO `my_student_course` VALUES (1, 1, 1, '2026-05-30 17:29:27', 1, 30, 90.00, '学习中', '2026-05-30 17:29:27', '2026-06-04 20:31:54');
INSERT INTO `my_student_course` VALUES (2, 1, 2, '2026-05-30 17:29:27', 1, 10, 100.00, '学习中', '2026-05-30 17:29:27', '2026-06-04 20:31:59');
INSERT INTO `my_student_course` VALUES (3, 2, 1, '2026-05-30 17:29:27', 1, 50, 90.00, '已完成', '2026-05-30 17:29:27', '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_student_homework
-- ----------------------------
DROP TABLE IF EXISTS `my_student_homework`;
CREATE TABLE `my_student_homework`  (
  `sh_id` bigint NOT NULL AUTO_INCREMENT COMMENT '提交记录ID',
  `stu_id` bigint NOT NULL COMMENT '学生ID',
  `hw_id` bigint NOT NULL COMMENT '作业ID',
  `answers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '答题内容(JSON)',
  `score` decimal(5, 2) NULL DEFAULT NULL COMMENT '得分',
  `teacher_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '教师评语',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态 0-未提交 1-已提交 2-已批改',
  `submit_time` datetime NULL DEFAULT NULL COMMENT '提交时间',
  `correct_time` datetime NULL DEFAULT NULL COMMENT '批改时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sh_id`) USING BTREE,
  UNIQUE INDEX `uk_stu_hw`(`stu_id` ASC, `hw_id` ASC) USING BTREE,
  INDEX `idx_hw_id`(`hw_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学生作业提交表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_student_homework
-- ----------------------------
INSERT INTO `my_student_homework` VALUES (1, 1, 1, '{\"1\": \"B\", \"2\": \"A,B,D\"}', 95.00, '完成优秀', 2, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_student_homework` VALUES (2, 2, 1, '{\"1\": \"A\", \"2\": \"A\"}', 40.00, '需要加强', 2, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_student_homework` VALUES (3, 1, 2, NULL, NULL, NULL, 0, NULL, NULL, '2026-05-30 17:29:27', '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_student_notification
-- ----------------------------
DROP TABLE IF EXISTS `my_student_notification`;
CREATE TABLE `my_student_notification`  (
  `sn_id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `stu_id` bigint NOT NULL COMMENT '学生ID',
  `noti_id` bigint NOT NULL COMMENT '通知ID',
  `is_read` tinyint NULL DEFAULT 0 COMMENT '是否已读 0-否 1-是',
  `read_time` datetime NULL DEFAULT NULL COMMENT '阅读时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sn_id`) USING BTREE,
  UNIQUE INDEX `uk_stu_noti`(`stu_id` ASC, `noti_id` ASC) USING BTREE,
  INDEX `idx_noti_id`(`noti_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学生通知阅读记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_student_notification
-- ----------------------------
INSERT INTO `my_student_notification` VALUES (1, 1, 1, 1, '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_student_notification` VALUES (2, 2, 1, 0, NULL, '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_student_question
-- ----------------------------
DROP TABLE IF EXISTS `my_student_question`;
CREATE TABLE `my_student_question`  (
  `id` bigint NOT NULL,
  `stu_id` bigint NULL DEFAULT NULL COMMENT '学生id',
  `q_id` bigint NULL DEFAULT NULL COMMENT '题目id',
  `score` int NULL DEFAULT NULL COMMENT '得分',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_student_question
-- ----------------------------
INSERT INTO `my_student_question` VALUES (1, 1, 1, 10);
INSERT INTO `my_student_question` VALUES (2, 1, 2, 10);
INSERT INTO `my_student_question` VALUES (3, 2, 1, 0);
INSERT INTO `my_student_question` VALUES (4, 2, 2, 5);

-- ----------------------------
-- Table structure for my_study_record
-- ----------------------------
DROP TABLE IF EXISTS `my_study_record`;
CREATE TABLE `my_study_record`  (
  `sr_id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `stu_id` bigint NOT NULL COMMENT '学生ID',
  `c_id` bigint NULL DEFAULT NULL COMMENT '课程ID',
  `study_type` tinyint NOT NULL COMMENT '学习类型 1-视频 2-文档 3-做题 4-其他',
  `study_duration` int NULL DEFAULT NULL COMMENT '学习时长(分钟)',
  `study_date` date NULL DEFAULT NULL COMMENT '学习日期',
  `progress` int NULL DEFAULT 0 COMMENT '进度百分比',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sr_id`) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_study_date`(`study_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学习记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_study_record
-- ----------------------------
INSERT INTO `my_study_record` VALUES (1, 1, 1, 1, 45, '2026-05-30', 20, '2026-05-30 17:29:27');
INSERT INTO `my_study_record` VALUES (2, 1, 1, 3, 30, '2026-05-30', 10, '2026-05-30 17:29:27');
INSERT INTO `my_study_record` VALUES (3, 2, 2, 2, 60, '2026-05-30', 30, '2026-05-30 17:29:27');
INSERT INTO `my_study_record` VALUES (4, 1, 1, 1, 45, '2026-05-30', 20, '2026-06-01 08:00:00');
INSERT INTO `my_study_record` VALUES (5, 6, 2, 2, 60, '2026-05-30', 25, '2026-06-03 09:00:00');
INSERT INTO `my_study_record` VALUES (6, 10, 1, 1, 30, '2026-05-30', 15, '2026-05-30 10:00:00');
INSERT INTO `my_study_record` VALUES (7, 2, 4, 3, 50, '2026-05-30', 30, '2026-05-30 11:00:00');
INSERT INTO `my_study_record` VALUES (8, 7, 2, 2, 40, '2026-05-30', 22, '2026-06-03 14:00:00');
INSERT INTO `my_study_record` VALUES (9, 8, 3, 1, 70, '2026-05-30', 35, '2026-05-30 15:00:00');
INSERT INTO `my_study_record` VALUES (10, 3, 5, 3, 55, '2026-05-30', 28, '2026-06-03 16:00:00');
INSERT INTO `my_study_record` VALUES (11, 4, 8, 1, 35, '2026-05-30', 18, '2026-05-30 17:00:00');
INSERT INTO `my_study_record` VALUES (12, 9, 8, 2, 45, '2026-05-30', 20, '2026-05-30 18:00:00');
INSERT INTO `my_study_record` VALUES (13, 11, 4, 3, 40, '2026-05-30', 25, '2026-05-30 19:00:00');

-- ----------------------------
-- Table structure for my_study_report
-- ----------------------------
DROP TABLE IF EXISTS `my_study_report`;
CREATE TABLE `my_study_report`  (
  `report_id` bigint NOT NULL AUTO_INCREMENT COMMENT '报表ID',
  `stu_id` bigint NOT NULL COMMENT '学生ID',
  `report_type` tinyint NOT NULL COMMENT '报表类型 1-日报 2-周报 3-月报',
  `report_date` date NOT NULL COMMENT '报表日期',
  `study_duration` int NULL DEFAULT 0 COMMENT '学习时长(分钟)',
  `completed_courses` int NULL DEFAULT 0 COMMENT '完成课程数',
  `completed_homework` int NULL DEFAULT 0 COMMENT '完成作业数',
  `correct_rate` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '正确率',
  `rank_score_change` int NULL DEFAULT 0 COMMENT '积分变化',
  `weak_points` json NULL COMMENT '薄弱知识点',
  `strengths` json NULL COMMENT '优势知识点',
  `suggestions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '学习建议',
  `data_json` json NULL COMMENT '详细数据',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`report_id`) USING BTREE,
  UNIQUE INDEX `uk_stu_type_date`(`stu_id` ASC, `report_type` ASC, `report_date` ASC) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学情报表数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_study_report
-- ----------------------------
INSERT INTO `my_study_report` VALUES (1, 1, 1, '2026-05-30', 75, 0, 1, 95.00, 10, '[\"算法\"]', '[\"Python基础\"]', '加强算法练习', '{\"data\": \"日报数据\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (2, 2, 1, '2026-05-30', 60, 0, 1, 40.00, -5, '[\"Python语法\"]', '[\"无\"]', '加强基础学习', '{\"data\": \"日报数据\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (3, 6, 2, '2026-05-30', 80, 1, 2, 88.50, 15, '[\"算法\"]', '[\"Python基础\"]', '保持优势，加强算法', '{\"data\": \"周报数据\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (4, 10, 2, '2026-05-30', 95, 2, 3, 92.00, 20, '[\"无\"]', '[\"数据结构\"]', '表现优秀，继续保持', '{\"data\": \"周报数据\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (5, 1, 2, '2026-05-23', 70, 1, 2, 85.00, 10, '[\"算法\"]', '[\"Python基础\"]', '加强算法练习', '{\"data\": \"周报数据\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (6, 6, 2, '2026-05-23', 75, 1, 1, 86.00, 12, '[\"数据结构\"]', '[\"Python基础\"]', '多练习数据结构', '{\"data\": \"周报数据\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (7, 10, 2, '2026-05-23', 90, 2, 2, 90.00, 18, '[\"无\"]', '[\"算法\"]', '继续保持', '{\"data\": \"周报数据\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (8, 7, 2, '2026-05-30', 65, 1, 1, 78.00, 8, '[\"算法\", \"数据结构\"]', '[\"Java基础\"]', '加强基础算法', '{\"data\": \"周报数据\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (9, 11, 2, '2026-05-30', 70, 1, 2, 82.00, 10, '[\"数据结构\"]', '[\"Java基础\"]', '多练习数据结构', '{\"data\": \"周报数据\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (10, 2, 2, '2026-05-30', 60, 0, 1, 75.00, 5, '[\"算法\", \"Python语法\"]', '[\"无\"]', '加强基础学习', '{\"data\": \"周报数据\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (11, 7, 2, '2026-05-23', 60, 1, 1, 76.00, 6, '[\"算法\"]', '[\"Java基础\"]', '加强算法练习', '{\"data\": \"周报数据\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (12, 11, 2, '2026-05-23', 65, 1, 1, 80.00, 8, '[\"数据结构\"]', '[\"Java基础\"]', '多练习数据结构', '{\"data\": \"周报数据\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (13, 8, 2, '2026-05-30', 100, 2, 3, 95.00, 25, '[\"无\"]', '[\"机器学习\", \"深度学习\"]', '表现优秀，挑战更高难度', '{\"data\": \"周报数据\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (14, 3, 2, '2026-05-30', 85, 1, 2, 88.00, 15, '[\"深度学习\"]', '[\"机器学习\"]', '加强深度学习理论', '{\"data\": \"周报数据\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (15, 8, 2, '2026-05-23', 95, 2, 3, 93.00, 22, '[\"无\"]', '[\"机器学习\"]', '继续保持', '{\"data\": \"周报数据\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (16, 3, 2, '2026-05-23', 80, 1, 2, 85.00, 12, '[\"深度学习\"]', '[\"机器学习\"]', '多阅读论文', '{\"data\": \"周报数据\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (17, 9, 2, '2026-05-30', 72, 1, 2, 80.00, 10, '[\"网络安全\"]', '[\"网络基础\"]', '加强安全实践', '{\"data\": \"周报数据\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (18, 4, 2, '2026-05-30', 78, 1, 2, 83.00, 12, '[\"网络安全\"]', '[\"网络基础\"]', '多练习渗透测试', '{\"data\": \"周报数据\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (19, 9, 2, '2026-05-23', 68, 1, 1, 78.00, 8, '[\"网络安全\"]', '[\"网络基础\"]', '加强理论学习', '{\"data\": \"周报数据\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (20, 4, 2, '2026-05-23', 75, 1, 2, 81.00, 10, '[\"网络安全\"]', '[\"网络基础\"]', '多动手实验', '{\"data\": \"周报数据\"}', '2026-05-23 17:29:27');

-- ----------------------------
-- Table structure for my_sys_user
-- ----------------------------
DROP TABLE IF EXISTS `my_sys_user`;
CREATE TABLE `my_sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名/账号',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码(加密存储)',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像URL',
  `sex` tinyint NULL DEFAULT 0 COMMENT '性别 0-未知 1-男 2-女',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `user_type` tinyint NOT NULL DEFAULT 1 COMMENT '用户类型 1-学生 2-教师 3-管理员',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-禁用 1-启用',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除 0-否 1-是',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE,
  INDEX `idx_user_type`(`user_type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_sys_user
-- ----------------------------
INSERT INTO `my_sys_user` VALUES (1, 'student001', '$2a$10$OFbJGvdxJId4mvvJecvSuuqRDnnQFdTpSCR9vkOXFzm9Hxnb3lBxC', '张三', NULL, 1, 20, '13800138001', 'student001@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (2, 'student002', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '李四', NULL, 2, 19, '13800138002', 'student002@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:16', NULL);
INSERT INTO `my_sys_user` VALUES (3, 'teacher001', '$2a$10$OFbJGvdxJId4mvvJecvSuuqRDnnQFdTpSCR9vkOXFzm9Hxnb3lBxC', '王老师', NULL, 1, 35, '13900139001', 'teacher001@example.com', 2, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:17', NULL);
INSERT INTO `my_sys_user` VALUES (4, 'admin001', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '管理员', NULL, 1, 30, '13700137001', 'admin001@example.com', 3, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:20', NULL);
INSERT INTO `my_sys_user` VALUES (5, 'teacher002', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '李老师', NULL, 1, 38, '13900139002', 'teacher002@example.com', 2, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (6, 'teacher003', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '张老师', NULL, 2, 32, '13900139003', 'teacher003@example.com', 2, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (7, 'teacher004', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '赵老师', NULL, 1, 40, '13900139004', 'teacher004@example.com', 2, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (8, 'teacher005', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '刘老师', NULL, 2, 29, '13900139005', 'teacher005@example.com', 2, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (9, 'student003', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '王五', NULL, 1, 21, '13800138003', 'student003@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (10, 'student004', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '赵六', NULL, 2, 20, '13800138004', 'student004@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (11, 'student005', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '孙七', NULL, 1, 22, '13800138005', 'student005@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (12, 'student006', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '周八', NULL, 2, 19, '13800138006', 'student006@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (13, 'student007', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '吴九', NULL, 1, 20, '13800138007', 'student007@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (14, 'student008', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '郑十', NULL, 2, 21, '13800138008', 'student008@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);

-- ----------------------------
-- Table structure for my_task_reminder
-- ----------------------------
DROP TABLE IF EXISTS `my_task_reminder`;
CREATE TABLE `my_task_reminder`  (
  `tr_id` bigint NOT NULL AUTO_INCREMENT COMMENT '提醒ID',
  `stu_id` bigint NOT NULL COMMENT '学生ID',
  `task_type` tinyint NOT NULL COMMENT '任务类型 1-作业截止 2-课程开始 3-自定义',
  `task_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务标题',
  `task_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '任务内容',
  `remind_time` datetime NOT NULL COMMENT '提醒时间',
  `repeat_type` tinyint NULL DEFAULT 0 COMMENT '重复类型 0-不重复 1-每天 2-每周 3-每月',
  `is_read` tinyint NULL DEFAULT 0 COMMENT '是否已读 0-否 1-是',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-取消 1-有效',
  `related_id` bigint NULL DEFAULT NULL COMMENT '关联ID(作业ID/课程ID)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tr_id`) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE,
  INDEX `idx_remind_time`(`remind_time` ASC) USING BTREE,
  INDEX `idx_is_read`(`is_read` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务提醒表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_task_reminder
-- ----------------------------
INSERT INTO `my_task_reminder` VALUES (1, 1, 1, '早读打卡', '英语六级词汇背诵', '2026-05-21 01:31:18', 0, 0, 1, 3, '2026-05-27 19:31:26', '2026-06-03 14:38:27');
INSERT INTO `my_task_reminder` VALUES (2, 1, 1, '数学作业截止', '完成导数作业', '2026-05-31 17:29:27', 0, 0, 1, 1, '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_task_reminder` VALUES (3, 2, 2, '课程开始提醒', '数据结构课程', '2026-05-30 17:29:27', 0, 0, 1, 2, '2026-05-30 17:29:27', '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_teacher
-- ----------------------------
DROP TABLE IF EXISTS `my_teacher`;
CREATE TABLE `my_teacher`  (
  `teacher_id` bigint NOT NULL AUTO_INCREMENT COMMENT '教师ID',
  `user_id` bigint NOT NULL COMMENT '关联用户ID',
  `teacher_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工号',
  `department` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属院系',
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职称',
  `specialty` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专长领域',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`teacher_id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '教师信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_teacher
-- ----------------------------
INSERT INTO `my_teacher` VALUES (1, 3, 'T2024001', '计算机学院', '副教授', '人工智能、机器学习', '2026-05-27 00:13:29', '2026-05-27 00:13:29');
INSERT INTO `my_teacher` VALUES (2, 5, 'T2024004', '计算机学院', '教授', '大数据、云计算', '2026-05-27 00:13:29', '2026-06-02 18:11:09');
INSERT INTO `my_teacher` VALUES (3, 6, 'T2024005', '软件学院', '副教授', '前端开发、Vue', '2026-05-27 00:13:29', '2026-06-02 18:11:10');
INSERT INTO `my_teacher` VALUES (4, 7, 'T2024006', '人工智能学院', '讲师', '自然语言处理', '2026-05-27 00:13:29', '2026-06-02 18:11:11');
INSERT INTO `my_teacher` VALUES (5, 8, 'T2024007', '网络学院', '助教', '网络安全、运维', '2026-05-27 00:13:29', '2026-06-02 18:11:13');

-- ----------------------------
-- Table structure for my_question_answer(学生→老师 问答)
-- ----------------------------
DROP TABLE IF EXISTS `my_question_answer`;
CREATE TABLE `my_question_answer`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `stu_id` bigint NOT NULL COMMENT '学生ID(my_student.stu_id)',
  `teacher_id` bigint NOT NULL COMMENT '教师ID(my_teacher.teacher_id)',
  `question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学生提交的问题',
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '老师的回复',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态 0-待回复 1-已回复 2-已关闭',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人ID(学生user_id)',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人ID(老师user_id)',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_qa_stu`(`stu_id` ASC) USING BTREE,
  INDEX `idx_qa_teacher`(`teacher_id` ASC) USING BTREE,
  INDEX `idx_qa_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学生向老师请教的问答表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-05-29 20:04:55', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-05-29 20:04:55', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-05-29 20:04:55', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `start_time` datetime NULL DEFAULT NULL COMMENT '执行开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '执行结束时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 190 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-29 20:17:43');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-29 20:20:58');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-29 20:21:33');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-29 20:51:08');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-29 20:51:14');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-30 17:36:03');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-30 18:21:23');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-30 19:44:01');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-31 15:04:11');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-31 17:39:16');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-05-31 18:51:11');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-31 18:51:17');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-31 20:02:30');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-31 20:15:02');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-31 20:15:08');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码已失效', '2026-05-31 20:17:35');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-31 20:17:40');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-31 21:04:54');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-05-31 21:05:10');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-31 21:05:16');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-31 21:06:25');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-05-31 21:10:32');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-31 21:10:34');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-31 22:17:28');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-05-31 23:20:00');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-31 23:20:01');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-01 00:02:14');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-01 00:09:41');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-01 00:12:07');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-06-01 00:12:24');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-01 00:12:29');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-01 17:58:18');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-01 18:15:06');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-01 18:15:54');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码已失效', '2026-06-01 18:54:12');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-01 18:54:19');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码已失效', '2026-06-01 18:54:31');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-06-01 18:54:32');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-06-01 18:54:34');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-01 18:54:38');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-01 19:32:46');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-01 19:34:22');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-01 19:50:46');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码已失效', '2026-06-01 19:54:38');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-01 19:54:42');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-02 16:23:56');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-02 17:38:33');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-02 17:39:29');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-02 18:52:12');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-06-02 18:52:38');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-02 18:52:39');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-02 19:43:04');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-02 19:43:29');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-02 19:54:10');
INSERT INTO `sys_logininfor` VALUES (154, 'admin1', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码已失效', '2026-06-02 19:57:16');
INSERT INTO `sys_logininfor` VALUES (155, 'admin1', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '用户不存在/密码错误', '2026-06-02 19:57:23');
INSERT INTO `sys_logininfor` VALUES (156, 'admin1', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '用户不存在/密码错误', '2026-06-02 19:57:26');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码已失效', '2026-06-02 20:01:18');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-02 20:01:22');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-02 21:30:54');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-02 21:42:32');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-02 21:42:58');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-02 22:18:42');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码已失效', '2026-06-02 23:17:39');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-02 23:17:45');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-02 23:23:32');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-03 00:09:54');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-03 00:10:10');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码已失效', '2026-06-03 00:17:09');
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-03 00:17:38');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-03 00:36:23');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-03 00:36:26');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-03 00:55:43');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-03 14:18:55');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码已失效', '2026-06-03 16:18:35');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-03 16:18:35');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-03 17:17:49');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-03 17:44:26');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-03 20:43:25');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-03 22:08:49');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-03 22:57:38');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-06-03 22:58:05');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码已失效', '2026-06-03 23:01:06');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-03 23:01:10');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-04 00:17:53');
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-04 17:56:28');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-04 20:15:49');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-04 20:16:07');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-06-04 20:16:19');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-04 20:16:25');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2306 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 6, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-05-29 20:04:53', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 7, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-05-29 20:04:53', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 7, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-05-29 20:04:53', 'admin', '2026-05-31 23:28:53', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 8, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2026-05-29 20:04:53', 'admin', '2026-05-31 23:29:39', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-05-29 20:04:53', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-05-29 20:04:53', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-05-29 20:04:53', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-05-29 20:04:53', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2026-05-29 20:04:53', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-05-29 20:04:53', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-05-29 20:04:53', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-05-29 20:04:53', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-05-29 20:04:53', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-05-29 20:04:53', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-05-29 20:04:53', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-05-29 20:04:53', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-05-29 20:04:53', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-05-29 20:04:53', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-05-29 20:04:53', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-05-29 20:04:53', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-05-29 20:04:53', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-05-29 20:04:53', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-05-29 20:04:53', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-05-29 20:04:53', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '业务管理', 0, 1, 'business', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'checkbox', 'admin', '2026-05-30 19:53:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '资源模块', 2000, 1, 'resource', 'business/resource/index', NULL, '', 1, 0, 'C', '0', '0', 'business:resource:list', '#', 'admin', '2026-05-31 16:19:10', '', NULL, '资源模块菜单');
INSERT INTO `sys_menu` VALUES (2016, '资源模块查询', 2015, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:resource:query', '#', 'admin', '2026-05-31 16:19:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '资源模块新增', 2015, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:resource:add', '#', 'admin', '2026-05-31 16:19:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '资源模块修改', 2015, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:resource:edit', '#', 'admin', '2026-05-31 16:19:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '资源模块删除', 2015, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:resource:remove', '#', 'admin', '2026-05-31 16:19:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2020, '资源模块导出', 2015, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:resource:export', '#', 'admin', '2026-05-31 16:19:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '通知模块', 2000, 1, 'notification', 'business/notification/index', NULL, '', 1, 0, 'C', '0', '0', 'business:notification:list', '#', 'admin', '2026-05-31 16:43:24', '', NULL, '通知模块菜单');
INSERT INTO `sys_menu` VALUES (2022, '通知模块查询', 2021, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:notification:query', '#', 'admin', '2026-05-31 16:43:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '通知模块新增', 2021, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:notification:add', '#', 'admin', '2026-05-31 16:43:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '通知模块修改', 2021, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:notification:edit', '#', 'admin', '2026-05-31 16:43:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '通知模块删除', 2021, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:notification:remove', '#', 'admin', '2026-05-31 16:43:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, '通知模块导出', 2021, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:notification:export', '#', 'admin', '2026-05-31 16:43:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2164, '课程管理', 0, 2, 'course', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'education', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '课程管理目录');
INSERT INTO `sys_menu` VALUES (2165, '课程列表', 2164, 1, 'myCourse', 'course/myCourse/index', NULL, '', 1, 0, 'C', '0', '0', 'course:myCourse:list', 'list', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '课程列表菜单');
INSERT INTO `sys_menu` VALUES (2166, '课程查询', 2165, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'course:myCourse:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '课程查询按钮');
INSERT INTO `sys_menu` VALUES (2167, '课程新增', 2165, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'course:myCourse:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '课程新增按钮');
INSERT INTO `sys_menu` VALUES (2168, '课程修改', 2165, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'course:myCourse:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '课程修改按钮');
INSERT INTO `sys_menu` VALUES (2169, '课程删除', 2165, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'course:myCourse:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '课程删除按钮');
INSERT INTO `sys_menu` VALUES (2170, '课程导出', 2165, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'course:myCourse:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '课程导出按钮');
INSERT INTO `sys_menu` VALUES (2171, '用户扩展', 0, 0, 'userext', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'user', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '用户扩展目录');
INSERT INTO `sys_menu` VALUES (2172, '学生管理', 2171, 1, 'myStudent', 'userext/myStudent/index', NULL, '', 1, 0, 'C', '0', '0', 'userext:myStudent:list', 'peoples', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '学生管理菜单');
INSERT INTO `sys_menu` VALUES (2173, '学生查询', 2172, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myStudent:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2174, '学生新增', 2172, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myStudent:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2175, '学生修改', 2172, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myStudent:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2176, '学生删除', 2172, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myStudent:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2177, '学生导出', 2172, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myStudent:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2178, '教师管理', 2171, 2, 'myTeacher', 'userext/myTeacher/index', NULL, '', 1, 0, 'C', '0', '0', 'userext:myTeacher:list', 'user', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '教师管理菜单');
INSERT INTO `sys_menu` VALUES (2179, '教师查询', 2178, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myTeacher:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2180, '教师新增', 2178, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myTeacher:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2181, '教师修改', 2178, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myTeacher:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2182, '教师删除', 2178, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myTeacher:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2183, '教师导出', 2178, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myTeacher:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2184, '作业管理', 0, 3, 'homework', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'form', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '作业管理目录');
INSERT INTO `sys_menu` VALUES (2185, '作业列表', 2184, 1, 'myHomework', 'homework/myHomework/index', NULL, '', 1, 0, 'C', '0', '0', 'homework:myHomework:list', 'edit', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '作业列表菜单');
INSERT INTO `sys_menu` VALUES (2186, '作业查询', 2185, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'homework:myHomework:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2187, '作业新增', 2185, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'homework:myHomework:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2188, '作业修改', 2185, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'homework:myHomework:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2189, '作业删除', 2185, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'homework:myHomework:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2190, '作业导出', 2185, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'homework:myHomework:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2191, '学习中心', 0, 2, 'study', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'chart', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '学习中心目录');
INSERT INTO `sys_menu` VALUES (2192, '学习记录', 2191, 1, 'myStudyRecord', 'study/myStudyRecord/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myStudyRecord:list', 'time', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '学习记录菜单');
INSERT INTO `sys_menu` VALUES (2193, '学习记录查询', 2192, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyRecord:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2194, '学习记录新增', 2192, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyRecord:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2195, '学习记录修改', 2192, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyRecord:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2196, '学习记录删除', 2192, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyRecord:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2197, '学习记录导出', 2192, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyRecord:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2198, 'AI问答记录', 2191, 2, 'myAiChat', 'study/myAiChat/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myAiChat:list', 'message', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', 'AI问答记录菜单');
INSERT INTO `sys_menu` VALUES (2199, 'AI问答查询', 2198, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myAiChat:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2200, 'AI问答新增', 2198, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myAiChat:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2201, 'AI问答修改', 2198, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myAiChat:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2202, 'AI问答删除', 2198, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myAiChat:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2203, 'AI问答导出', 2198, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myAiChat:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2204, '段位配置', 2191, 3, 'myRankConfig', 'study/myRankConfig/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myRankConfig:list', 'star', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '段位配置菜单');
INSERT INTO `sys_menu` VALUES (2205, '段位配置查询', 2204, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myRankConfig:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2206, '段位配置新增', 2204, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myRankConfig:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2207, '段位配置修改', 2204, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myRankConfig:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2208, '段位配置删除', 2204, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myRankConfig:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2209, '段位配置导出', 2204, 5, '#', NULL, NULL, '', 0, 0, 'F', '0', '0', 'study:myRankConfig:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2210, '任务提醒', 2191, 4, 'myTaskReminder', 'study/myTaskReminder/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myTaskReminder:list', 'bell', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '任务提醒菜单');
INSERT INTO `sys_menu` VALUES (2211, '任务提醒查询', 2210, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myTaskReminder:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2212, '任务提醒新增', 2210, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myTaskReminder:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2213, '任务提醒修改', 2210, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myTaskReminder:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2214, '任务提醒删除', 2210, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myTaskReminder:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2215, '任务提醒导出', 2210, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myTaskReminder:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2216, '错题本', 2191, 5, 'myErrorBook', 'study/myErrorBook/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myErrorBook:list', 'bug', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '错题本菜单');
INSERT INTO `sys_menu` VALUES (2217, '错题本查询', 2216, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myErrorBook:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2218, '错题本新增', 2216, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myErrorBook:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2219, '错题本修改', 2216, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myErrorBook:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2220, '错题本删除', 2216, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myErrorBook:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2221, '错题本导出', 2216, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myErrorBook:export', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2222, '学情报表', 2191, 6, 'myStudyReport', 'study/myStudyReport/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myStudyReport:list', 'documentation', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '学情报表菜单');
INSERT INTO `sys_menu` VALUES (2223, '学情报表查询', 2222, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyReport:query', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2224, '学情报表新增', 2222, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyReport:add', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2225, '学情报表修改', 2222, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyReport:edit', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2226, '学情报表删除', 2222, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyReport:remove', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2227, '学情报表导出', 2222, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyReport:export', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2228, '全局报表', 2191, 7, 'myGlobalReport', 'study/myGlobalReport/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myGlobalReport:list', 'chart', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '全局报表菜单');
INSERT INTO `sys_menu` VALUES (2229, '全局报表查询', 2228, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myGlobalReport:query', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2230, '全局报表新增', 2228, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myGlobalReport:add', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2231, '全局报表修改', 2228, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myGlobalReport:edit', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2232, '全局报表删除', 2228, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myGlobalReport:remove', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2233, '全局报表导出', 2228, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myGlobalReport:export', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2234, '题库管理', 0, 4, 'bank', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'education', 'admin', '2026-06-03 00:00:00', '', NULL, '题库管理目录');
INSERT INTO `sys_menu` VALUES (2235, '题库列表', 2234, 1, 'myBank', 'study/myBank/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myBank:list', 'list', 'admin', '2026-06-03 00:00:00', '', NULL, '题库列表菜单');
INSERT INTO `sys_menu` VALUES (2236, '题库查询', 2235, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myBank:query', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '题库查询按钮');
INSERT INTO `sys_menu` VALUES (2237, '题库新增', 2235, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myBank:add', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '题库新增按钮');
INSERT INTO `sys_menu` VALUES (2238, '题库修改', 2235, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myBank:edit', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '题库修改按钮');
INSERT INTO `sys_menu` VALUES (2239, '题库删除', 2235, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myBank:remove', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '题库删除按钮');
INSERT INTO `sys_menu` VALUES (2240, '题库导出', 2235, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myBank:export', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '题库导出按钮');
INSERT INTO `sys_menu` VALUES (2241, '题目管理', 0, 5, 'question', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'edit', 'admin', '2026-06-03 00:00:00', '', NULL, '题目管理目录');
INSERT INTO `sys_menu` VALUES (2242, '题目列表', 2241, 1, 'myQuestion', 'study/myQuestion/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myQuestion:list', 'list', 'admin', '2026-06-03 00:00:00', '', NULL, '题目列表菜单');
INSERT INTO `sys_menu` VALUES (2243, '题目查询', 2242, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myQuestion:query', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '题目查询按钮');
INSERT INTO `sys_menu` VALUES (2244, '题目新增', 2242, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myQuestion:add', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '题目新增按钮');
INSERT INTO `sys_menu` VALUES (2245, '题目修改', 2242, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myQuestion:edit', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '题目修改按钮');
INSERT INTO `sys_menu` VALUES (2246, '题目删除', 2242, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myQuestion:remove', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '题目删除按钮');
INSERT INTO `sys_menu` VALUES (2247, '题目导出', 2242, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myQuestion:export', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '题目导出按钮');
INSERT INTO `sys_menu` VALUES (2300, 'AI智能助手', 0, 5, 'aiAgent', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'qq', 'admin', '2026-06-03 19:00:00', 'admin', '2026-06-03 23:32:31', 'AI智能助手目录');
INSERT INTO `sys_menu` VALUES (2301, 'AI对话', 2300, 1, 'aiChat', 'ai/agent/index', NULL, '', 1, 0, 'C', '0', '0', 'ai:agent:chat', 'chat-dot-round', 'admin', '2026-06-03 19:00:00', '', NULL, 'AI对话菜单');
INSERT INTO `sys_menu` VALUES (2302, 'AI对话查询', 2301, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'ai:agent:query', '#', 'admin', '2026-06-03 19:00:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2303, 'AI对话发送', 2301, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'ai:agent:send', '#', 'admin', '2026-06-03 19:00:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2304, 'AI配置', 2300, 2, 'aiConfig', 'ai/config/index', NULL, '', 1, 0, 'C', '0', '0', 'ai:config:view', 'setting', 'admin', '2026-06-03 19:00:00', '', NULL, 'AI配置菜单');
INSERT INTO `sys_menu` VALUES (2305, 'AI配置修改', 2304, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'ai:config:edit', '#', 'admin', '2026-06-03 19:00:00', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-05-29 20:04:55', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-05-29 20:04:55', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (3, '若依开源框架介绍', '1', 0x3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE9A1B9E79BAEE4BB8BE7BB8D3C2F7370616E3E3C2F703E3C703E3C666F6E7420636F6C6F723D2223333333333333223E52756F5969E5BC80E6BA90E9A1B9E79BAEE698AFE4B8BAE4BC81E4B89AE794A8E688B7E5AE9AE588B6E79A84E5908EE58FB0E8849AE6898BE69EB6E6A186E69EB6EFBC8CE4B8BAE4BC81E4B89AE68993E980A0E79A84E4B880E7AB99E5BC8FE8A7A3E586B3E696B9E6A188EFBC8CE9998DE4BD8EE4BC81E4B89AE5BC80E58F91E68890E69CACEFBC8CE68F90E58D87E5BC80E58F91E69588E78E87E38082E4B8BBE8A681E58C85E68BACE794A8E688B7E7AEA1E79086E38081E8A792E889B2E7AEA1E79086E38081E983A8E997A8E7AEA1E79086E38081E88F9CE58D95E7AEA1E79086E38081E58F82E695B0E7AEA1E79086E38081E5AD97E585B8E7AEA1E79086E380813C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE5B297E4BD8DE7AEA1E790863C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E5AE9AE697B6E4BBBBE58AA13C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE380813C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE69C8DE58AA1E79B91E68EA7E38081E799BBE5BD95E697A5E5BF97E38081E6938DE4BD9CE697A5E5BF97E38081E4BBA3E7A081E7949FE68890E7AD89E58A9FE883BDE38082E585B6E4B8ADEFBC8CE8BF98E694AFE68C81E5A49AE695B0E68DAEE6BA90E38081E695B0E68DAEE69D83E99990E38081E59BBDE99985E58C96E380815265646973E7BC93E5AD98E38081446F636B6572E983A8E7BDB2E38081E6BB91E58AA8E9AA8CE8AF81E7A081E38081E7ACACE4B889E696B9E8AEA4E8AF81E799BBE5BD95E38081E58886E5B883E5BC8FE4BA8BE58AA1E380813C2F7370616E3E3C666F6E7420636F6C6F723D2223333333333333223EE58886E5B883E5BC8FE69687E4BBB6E5AD98E582A83C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E58886E5BA93E58886E8A1A8E5A484E79086E7AD89E68A80E69CAFE789B9E782B9E380823C2F7370616E3E3C2F703E3C703E3C696D67207372633D2268747470733A2F2F666F727564612E67697465652E636F6D2F696D616765732F313737333933313834383334323433393033322F61346432323331335F313831353039352E706E6722207374796C653D2277696474683A20363470783B223E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE5AE98E7BD91E58F8AE6BC94E7A4BA3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE5AE98E7BD91E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F72756F79692E7669703C2F613E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E3C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE69687E6A1A3E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F646F632E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F646F632E72756F79692E7669703C2F613E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E4B88DE58886E7A6BBE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F64656D6F2E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F64656D6F2E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E58886E7A6BBE78988E69CACE38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F7675652E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F7675652E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E5BEAEE69C8DE58AA1E78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F636C6F75642E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F636C6F75642E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E7A7BBE58AA8E7ABAFE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F68352E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F68352E72756F79692E7669703C2F613E3C2F703E3C703E3C6272207374796C653D22636F6C6F723A207267622834382C2034392C203531293B20666F6E742D66616D696C793A202671756F743B48656C766574696361204E6575652671756F743B2C2048656C7665746963612C20417269616C2C2073616E732D73657269663B20666F6E742D73697A653A20313270783B223E3C2F703E, '0', 'admin', '2026-05-29 20:04:55', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_notice_read
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_read`;
CREATE TABLE `sys_notice_read`  (
  `read_id` bigint NOT NULL AUTO_INCREMENT COMMENT '已读主键',
  `notice_id` int NOT NULL COMMENT '公告id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `read_time` datetime NOT NULL COMMENT '阅读时间',
  PRIMARY KEY (`read_id`) USING BTREE,
  UNIQUE INDEX `uk_user_notice`(`user_id` ASC, `notice_id` ASC) USING BTREE COMMENT '同一用户同一公告只记录一次'
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公告已读记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice_read
-- ----------------------------
INSERT INTO `sys_notice_read` VALUES (1, 3, 1, '2026-05-29 20:21:40');
INSERT INTO `sys_notice_read` VALUES (2, 2, 1, '2026-06-01 20:52:58');
INSERT INTO `sys_notice_read` VALUES (3, 1, 1, '2026-06-01 20:53:01');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 162 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"业务管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"business\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 19:53:09', 24);
INSERT INTO `sys_oper_log` VALUES (101, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '研发部门', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2000\",\"orderNums\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 19:53:22', 13);
INSERT INTO `sys_oper_log` VALUES (102, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '研发部门', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2000,2,3,4\",\"orderNums\":\"2,3,4,5\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 19:53:35', 10);
INSERT INTO `sys_oper_log` VALUES (103, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '研发部门', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2000\",\"orderNums\":\"3\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 19:54:52', 5);
INSERT INTO `sys_oper_log` VALUES (104, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '研发部门', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2\",\"orderNums\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 19:55:05', 5);
INSERT INTO `sys_oper_log` VALUES (105, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '研发部门', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2,2000\",\"orderNums\":\"1,0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 19:55:27', 7);
INSERT INTO `sys_oper_log` VALUES (106, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '研发部门', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2,3,4\",\"orderNums\":\"2,3,4\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 19:55:39', 8);
INSERT INTO `sys_oper_log` VALUES (107, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"business/resourse/resourse\",\"createBy\":\"admin\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"资源管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"resourse\",\"perms\":\"business:resourse:resourse\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 20:02:46', 11);
INSERT INTO `sys_oper_log` VALUES (108, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"my_course_resource\",\"tplWebType\":\"element-ui\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 20:11:41', 45);
INSERT INTO `sys_oper_log` VALUES (109, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"resource\",\"className\":\"MyCourseResource\",\"columns\":[{\"capJavaField\":\"ReId\",\"columnComment\":\"资源ID\",\"columnId\":1,\"columnName\":\"re_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"reId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CId\",\"columnComment\":\"关联课程ID\",\"columnId\":2,\"columnName\":\"c_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ResourceType\",\"columnComment\":\"资源类型 1-视频 2-文档 3-图书 4-期刊 5-讲座\",\"columnId\":3,\"columnName\":\"resource_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"resourceType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"资源标题\",\"columnId\":4,\"columnName\":\"title\",\"columnType\":\"varchar(200)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 20:27:35', 37);
INSERT INTO `sys_oper_log` VALUES (110, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"my_course_resource\"}', NULL, 0, NULL, '2026-05-30 20:53:50', 155);
INSERT INTO `sys_oper_log` VALUES (111, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2002', '127.0.0.1', '内网IP', '2002 ', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2026-05-31 15:45:14', 13);
INSERT INTO `sys_oper_log` VALUES (112, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2003', '127.0.0.1', '内网IP', '2003 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 15:45:18', 10);
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2004', '127.0.0.1', '内网IP', '2004 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 15:45:21', 9);
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2005', '127.0.0.1', '内网IP', '2005 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 15:45:23', 8);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2006', '127.0.0.1', '内网IP', '2006 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 15:45:24', 8);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2007', '127.0.0.1', '内网IP', '2007 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 15:45:26', 7);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2002', '127.0.0.1', '内网IP', '2002 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 15:45:28', 8);
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"business/resourse/index\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"资源模块\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"resourse\",\"perms\":\"business:resourse:index\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"新增菜单\'资源模块\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-05-31 15:48:53', 9);
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"business/resourse/index\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"资源模块\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"resourse\",\"perms\":\"business:resourse:index\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"新增菜单\'资源模块\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-05-31 15:48:55', 4);
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2001', '127.0.0.1', '内网IP', '2001 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 15:49:36', 8);
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"business/resourse/index\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"资源模块\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"resourse\",\"perms\":\"business:resourse:index\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 15:50:44', 14);
INSERT INTO `sys_oper_log` VALUES (122, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"resource\",\"className\":\"MyCourseResource\",\"columns\":[{\"capJavaField\":\"ReId\",\"columnComment\":\"资源ID\",\"columnId\":1,\"columnName\":\"re_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"reId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-30 20:27:35\",\"usableColumn\":false},{\"capJavaField\":\"CId\",\"columnComment\":\"关联课程ID\",\"columnId\":2,\"columnName\":\"c_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-30 20:27:35\",\"usableColumn\":false},{\"capJavaField\":\"ResourceType\",\"columnComment\":\"资源类型 1-视频 2-文档 3-图书 4-期刊 5-讲座\",\"columnId\":3,\"columnName\":\"resource_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"resourceType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-30 20:27:35\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"资源标题\",\"columnId\":4,\"columnName\":\"title\",\"columnType\":\"varchar(200)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 15:56:46', 42);
INSERT INTO `sys_oper_log` VALUES (123, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"my_course_resource\"}', NULL, 0, NULL, '2026-05-31 15:56:51', 144);
INSERT INTO `sys_oper_log` VALUES (124, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"resource\",\"className\":\"MyCourseResource\",\"columns\":[{\"capJavaField\":\"ReId\",\"columnComment\":\"资源ID\",\"columnId\":1,\"columnName\":\"re_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"reId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-31 15:56:46\",\"usableColumn\":false},{\"capJavaField\":\"CId\",\"columnComment\":\"关联课程ID\",\"columnId\":2,\"columnName\":\"c_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-31 15:56:46\",\"usableColumn\":false},{\"capJavaField\":\"ResourceType\",\"columnComment\":\"资源类型 1-视频 2-文档 3-图书 4-期刊 5-讲座\",\"columnId\":3,\"columnName\":\"resource_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"resourceType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-31 15:56:46\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"资源标题\",\"columnId\":4,\"columnName\":\"title\",\"columnType\":\"varchar(200)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 16:17:12', 84);
INSERT INTO `sys_oper_log` VALUES (125, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"my_course_resource\"}', NULL, 0, NULL, '2026-05-31 16:17:22', 159);
INSERT INTO `sys_oper_log` VALUES (126, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"my_notification\",\"tplWebType\":\"element-ui\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 16:24:02', 66);
INSERT INTO `sys_oper_log` VALUES (127, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"notification\",\"className\":\"MyNotification\",\"columns\":[{\"capJavaField\":\"NotiId\",\"columnComment\":\"通知ID\",\"columnId\":12,\"columnName\":\"noti_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-31 16:24:02\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"notiId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SenderId\",\"columnComment\":\"发送者ID\",\"columnId\":13,\"columnName\":\"sender_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-31 16:24:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"senderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SenderType\",\"columnComment\":\"发送者类型 1-系统 2-教师 3-管理员\",\"columnId\":14,\"columnName\":\"sender_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-31 16:24:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"senderType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"通知标题\",\"columnId\":15,\"columnName\":\"title\",\"columnType\":\"varchar(200)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-31 16:24:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 16:26:32', 37);
INSERT INTO `sys_oper_log` VALUES (128, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"my_notification\"}', NULL, 0, NULL, '2026-05-31 16:26:35', 131);
INSERT INTO `sys_oper_log` VALUES (129, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"my_teacher\",\"tplWebType\":\"element-ui\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 18:53:54', 71);
INSERT INTO `sys_oper_log` VALUES (130, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"my_homework\",\"tplWebType\":\"element-ui\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 19:57:04', 106);
INSERT INTO `sys_oper_log` VALUES (131, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/3', '127.0.0.1', '内网IP', '[3] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 19:58:21', 12);
INSERT INTO `sys_oper_log` VALUES (132, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-31 22:27:48\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2027,\"menuName\":\"课程管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"course\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'课程管理\'失败，地址必须以http(s)://开头\",\"code\":500}', 0, NULL, '2026-05-31 22:29:26', 25);
INSERT INTO `sys_oper_log` VALUES (133, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-29 20:04:53\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 23:28:53', 22);
INSERT INTO `sys_oper_log` VALUES (134, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2184,\"menuName\":\"作业管理\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"homework\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'作业管理\'失败，地址必须以http(s)://开头\",\"code\":500}', 0, NULL, '2026-05-31 23:28:56', 3);
INSERT INTO `sys_oper_log` VALUES (135, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2191,\"menuName\":\"学习中心\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"study\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'学习中心\'失败，地址必须以http(s)://开头\",\"code\":500}', 0, NULL, '2026-05-31 23:29:06', 2);
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2191,\"menuName\":\"学习中心\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"study\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'学习中心\'失败，地址必须以http(s)://开头\",\"code\":500}', 0, NULL, '2026-05-31 23:29:08', 3);
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2191,\"menuName\":\"学习中心\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"study\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'学习中心\'失败，地址必须以http(s)://开头\",\"code\":500}', 0, NULL, '2026-05-31 23:29:11', 4);
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-29 20:04:53\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 23:29:39', 10);
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2191,\"menuName\":\"学习中心\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"study\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'学习中心\'失败，地址必须以http(s)://开头\",\"code\":500}', 0, NULL, '2026-05-31 23:29:43', 3);
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2191,\"menuName\":\"学习中心\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"study\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'学习中心\'失败，地址必须以http(s)://开头\",\"code\":500}', 0, NULL, '2026-05-31 23:29:51', 3);
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2191,\"menuName\":\"学习中心\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"study\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'学习中心\'失败，地址必须以http(s)://开头\",\"code\":500}', 0, NULL, '2026-05-31 23:29:53', 3);
INSERT INTO `sys_oper_log` VALUES (142, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2191,\"menuName\":\"学习中心\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"study\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'学习中心\'失败，地址必须以http(s)://开头\",\"code\":500}', 0, NULL, '2026-05-31 23:30:00', 3);
INSERT INTO `sys_oper_log` VALUES (143, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"study/myStudyRecord/index\",\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"time\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2192,\"menuName\":\"学习记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2191,\"path\":\"myStudyRecord\",\"perms\":\"study:myStudyRecord:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'学习记录\'失败，地址必须以http(s)://开头\",\"code\":500}', 0, NULL, '2026-05-31 23:30:17', 1);
INSERT INTO `sys_oper_log` VALUES (144, '学生', 1, 'com.ruoyi.web.controller.userext.MyStudentController.add()', 'POST', 1, 'admin', '研发部门', '/userext/myStudent', '127.0.0.1', '内网IP', '{\"birthday\":\"2026-05-06\",\"className\":\"24-1\",\"correctQuestions\":100,\"grade\":\"24级\",\"major\":\"机器人工程\",\"params\":{},\"rankLevel\":\"王者\",\"rankScore\":9999,\"stuId\":5,\"studentNo\":\"202401203027\",\"studyHours\":100,\"teacherId\":3,\"totalQuestions\":100,\"userId\":7} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 23:49:39', 32);
INSERT INTO `sys_oper_log` VALUES (145, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '研发部门', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2191\",\"orderNums\":\"2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-01 00:10:12', 17);
INSERT INTO `sys_oper_log` VALUES (146, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '研发部门', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1,2,3,4\",\"orderNums\":\"4,6,6,5\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-01 00:10:55', 10);
INSERT INTO `sys_oper_log` VALUES (147, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '研发部门', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"4\",\"orderNums\":\"8\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-01 00:11:04', 5);
INSERT INTO `sys_oper_log` VALUES (148, '资源模块', 2, 'com.ruoyi.web.controller.resourse.MyCourseResourceController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/resource', '127.0.0.1', '内网IP', '{\"content\":\"Python安装与配置\",\"createTime\":\"2026-05-30 17:29:27\",\"homework\":\"完成环境安装\",\"params\":{},\"reId\":1,\"resourceType\":1,\"sortOrder\":1,\"tag\":\"Python,环境\",\"title\":\"Python环境搭建\",\"videoUrl\":\"https://video.com/python1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-01 19:27:41', 29);
INSERT INTO `sys_oper_log` VALUES (149, '资源模块', 2, 'com.ruoyi.web.controller.resourse.MyCourseResourceController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/resource', '127.0.0.1', '内网IP', '{\"content\":\"Python安装与配置\",\"createTime\":\"2026-05-30 17:29:27\",\"homework\":\"完成环境安装\",\"params\":{},\"reId\":1,\"resourceType\":1,\"sortOrder\":1,\"tag\":\"Python,环境\",\"title\":\"Python环境搭建\",\"videoUrl\":\"https://video.com/python1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-01 20:57:46', 15);
INSERT INTO `sys_oper_log` VALUES (150, '资源模块', 2, 'com.ruoyi.web.controller.resourse.MyCourseResourceController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/resource', '127.0.0.1', '内网IP', '{\"content\":\"<p>Python安装与配置</p>\",\"createTime\":\"2026-05-30 17:29:27\",\"homework\":\"完成环境安装\",\"params\":{},\"reId\":1,\"resourceType\":1,\"sortOrder\":1,\"tag\":\"Python,环境\",\"title\":\"Python环境搭建\",\"videoUrl\":\"https://video.com/python1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-01 20:57:56', 4);
INSERT INTO `sys_oper_log` VALUES (151, '资源模块', 2, 'com.ruoyi.web.controller.resourse.MyCourseResourceController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/resource', '127.0.0.1', '内网IP', '{\"content\":\"<p>Python安装与配置</p>\",\"createTime\":\"2026-05-30 17:29:27\",\"homework\":\"完成环境安装\",\"params\":{},\"reId\":1,\"resourceType\":1,\"sortOrder\":1,\"tag\":\"Python,环境\",\"title\":\"Python环境搭建\",\"videoUrl\":\"https://video.com/python1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-01 20:58:01', 1);
INSERT INTO `sys_oper_log` VALUES (152, '资源模块', 2, 'com.ruoyi.web.controller.resourse.MyCourseResourceController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/resource', '127.0.0.1', '内网IP', '{\"content\":\"<p>Python安装与配置</p>\",\"createTime\":\"2026-05-30 17:29:27\",\"homework\":\"完成环境安装\",\"params\":{},\"reId\":1,\"resourceType\":1,\"sortOrder\":1,\"tag\":\"Python,环境\",\"title\":\"Python环境搭建\",\"videoUrl\":\"https://video.com/python1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-02 16:25:57', 18);
INSERT INTO `sys_oper_log` VALUES (153, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"resource\",\"className\":\"MyCourseResource\",\"columns\":[{\"capJavaField\":\"ReId\",\"columnComment\":\"资源ID\",\"columnId\":1,\"columnName\":\"re_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"reId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-31 16:17:12\",\"usableColumn\":false},{\"capJavaField\":\"CId\",\"columnComment\":\"关联课程ID\",\"columnId\":2,\"columnName\":\"c_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"cId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-31 16:17:12\",\"usableColumn\":false},{\"capJavaField\":\"ResourceType\",\"columnComment\":\"资源类型 1-视频 2-文档 3-图书 4-期刊 5-讲座\",\"columnId\":3,\"columnName\":\"resource_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"resourceType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-31 16:17:12\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"资源标题\",\"columnId\":4,\"columnName\":\"title\",\"columnType\":\"varchar(200)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-02 16:32:31', 40);
INSERT INTO `sys_oper_log` VALUES (154, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"my_course_resource\"}', NULL, 0, NULL, '2026-06-02 16:35:15', 33);
INSERT INTO `sys_oper_log` VALUES (155, '学情报表', 5, 'com.ruoyi.web.controller.study.MyStudyReportController.export()', 'POST', 1, 'admin', '研发部门', '/study/myStudyReport/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2026-06-02 18:35:40', 550);
INSERT INTO `sys_oper_log` VALUES (156, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '研发部门', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2000,2164,2171\",\"orderNums\":\"1,2,0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-02 19:53:55', 34);
INSERT INTO `sys_oper_log` VALUES (157, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"my_bank\",\"tplWebType\":\"element-ui\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-03 15:23:19', 88);
INSERT INTO `sys_oper_log` VALUES (158, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '研发部门', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1,2,3\",\"orderNums\":\"5,7,7\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-03 15:25:48', 9);
INSERT INTO `sys_oper_log` VALUES (159, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '研发部门', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1,2234,2241\",\"orderNums\":\"6,4,5\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-03 18:04:22', 24);
INSERT INTO `sys_oper_log` VALUES (160, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-06-03 19:00:00\",\"icon\":\"qq\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2300,\"menuName\":\"AI智能助手\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"aiAgent\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-03 23:31:04', 19);
INSERT INTO `sys_oper_log` VALUES (161, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-06-03 19:00:00\",\"icon\":\"qq\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2300,\"menuName\":\"AI智能助手\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"aiAgent\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-03 23:32:31', 7);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-05-29 20:04:53', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 2015);
INSERT INTO `sys_role_menu` VALUES (1, 2016);
INSERT INTO `sys_role_menu` VALUES (1, 2017);
INSERT INTO `sys_role_menu` VALUES (1, 2018);
INSERT INTO `sys_role_menu` VALUES (1, 2019);
INSERT INTO `sys_role_menu` VALUES (1, 2020);
INSERT INTO `sys_role_menu` VALUES (1, 2021);
INSERT INTO `sys_role_menu` VALUES (1, 2022);
INSERT INTO `sys_role_menu` VALUES (1, 2023);
INSERT INTO `sys_role_menu` VALUES (1, 2024);
INSERT INTO `sys_role_menu` VALUES (1, 2025);
INSERT INTO `sys_role_menu` VALUES (1, 2026);
INSERT INTO `sys_role_menu` VALUES (1, 2028);
INSERT INTO `sys_role_menu` VALUES (1, 2029);
INSERT INTO `sys_role_menu` VALUES (1, 2030);
INSERT INTO `sys_role_menu` VALUES (1, 2031);
INSERT INTO `sys_role_menu` VALUES (1, 2032);
INSERT INTO `sys_role_menu` VALUES (1, 2033);
INSERT INTO `sys_role_menu` VALUES (1, 2035);
INSERT INTO `sys_role_menu` VALUES (1, 2036);
INSERT INTO `sys_role_menu` VALUES (1, 2037);
INSERT INTO `sys_role_menu` VALUES (1, 2038);
INSERT INTO `sys_role_menu` VALUES (1, 2039);
INSERT INTO `sys_role_menu` VALUES (1, 2040);
INSERT INTO `sys_role_menu` VALUES (1, 2041);
INSERT INTO `sys_role_menu` VALUES (1, 2042);
INSERT INTO `sys_role_menu` VALUES (1, 2043);
INSERT INTO `sys_role_menu` VALUES (1, 2044);
INSERT INTO `sys_role_menu` VALUES (1, 2045);
INSERT INTO `sys_role_menu` VALUES (1, 2046);
INSERT INTO `sys_role_menu` VALUES (1, 2048);
INSERT INTO `sys_role_menu` VALUES (1, 2049);
INSERT INTO `sys_role_menu` VALUES (1, 2050);
INSERT INTO `sys_role_menu` VALUES (1, 2051);
INSERT INTO `sys_role_menu` VALUES (1, 2052);
INSERT INTO `sys_role_menu` VALUES (1, 2053);
INSERT INTO `sys_role_menu` VALUES (1, 2055);
INSERT INTO `sys_role_menu` VALUES (1, 2056);
INSERT INTO `sys_role_menu` VALUES (1, 2057);
INSERT INTO `sys_role_menu` VALUES (1, 2058);
INSERT INTO `sys_role_menu` VALUES (1, 2059);
INSERT INTO `sys_role_menu` VALUES (1, 2060);
INSERT INTO `sys_role_menu` VALUES (1, 2061);
INSERT INTO `sys_role_menu` VALUES (1, 2062);
INSERT INTO `sys_role_menu` VALUES (1, 2063);
INSERT INTO `sys_role_menu` VALUES (1, 2064);
INSERT INTO `sys_role_menu` VALUES (1, 2065);
INSERT INTO `sys_role_menu` VALUES (1, 2066);
INSERT INTO `sys_role_menu` VALUES (1, 2067);
INSERT INTO `sys_role_menu` VALUES (1, 2068);
INSERT INTO `sys_role_menu` VALUES (1, 2069);
INSERT INTO `sys_role_menu` VALUES (1, 2070);
INSERT INTO `sys_role_menu` VALUES (1, 2071);
INSERT INTO `sys_role_menu` VALUES (1, 2072);
INSERT INTO `sys_role_menu` VALUES (1, 2073);
INSERT INTO `sys_role_menu` VALUES (1, 2074);
INSERT INTO `sys_role_menu` VALUES (1, 2075);
INSERT INTO `sys_role_menu` VALUES (1, 2076);
INSERT INTO `sys_role_menu` VALUES (1, 2077);
INSERT INTO `sys_role_menu` VALUES (1, 2078);
INSERT INTO `sys_role_menu` VALUES (1, 2079);
INSERT INTO `sys_role_menu` VALUES (1, 2080);
INSERT INTO `sys_role_menu` VALUES (1, 2081);
INSERT INTO `sys_role_menu` VALUES (1, 2082);
INSERT INTO `sys_role_menu` VALUES (1, 2083);
INSERT INTO `sys_role_menu` VALUES (1, 2084);
INSERT INTO `sys_role_menu` VALUES (1, 2085);
INSERT INTO `sys_role_menu` VALUES (1, 2086);
INSERT INTO `sys_role_menu` VALUES (1, 2087);
INSERT INTO `sys_role_menu` VALUES (1, 2088);
INSERT INTO `sys_role_menu` VALUES (1, 2089);
INSERT INTO `sys_role_menu` VALUES (1, 2090);
INSERT INTO `sys_role_menu` VALUES (1, 2091);
INSERT INTO `sys_role_menu` VALUES (1, 2092);
INSERT INTO `sys_role_menu` VALUES (1, 2093);
INSERT INTO `sys_role_menu` VALUES (1, 2094);
INSERT INTO `sys_role_menu` VALUES (1, 2095);
INSERT INTO `sys_role_menu` VALUES (1, 2096);
INSERT INTO `sys_role_menu` VALUES (1, 2098);
INSERT INTO `sys_role_menu` VALUES (1, 2099);
INSERT INTO `sys_role_menu` VALUES (1, 2100);
INSERT INTO `sys_role_menu` VALUES (1, 2101);
INSERT INTO `sys_role_menu` VALUES (1, 2102);
INSERT INTO `sys_role_menu` VALUES (1, 2103);
INSERT INTO `sys_role_menu` VALUES (1, 2104);
INSERT INTO `sys_role_menu` VALUES (1, 2105);
INSERT INTO `sys_role_menu` VALUES (1, 2106);
INSERT INTO `sys_role_menu` VALUES (1, 2107);
INSERT INTO `sys_role_menu` VALUES (1, 2108);
INSERT INTO `sys_role_menu` VALUES (1, 2109);
INSERT INTO `sys_role_menu` VALUES (1, 2110);
INSERT INTO `sys_role_menu` VALUES (1, 2111);
INSERT INTO `sys_role_menu` VALUES (1, 2112);
INSERT INTO `sys_role_menu` VALUES (1, 2113);
INSERT INTO `sys_role_menu` VALUES (1, 2114);
INSERT INTO `sys_role_menu` VALUES (1, 2115);
INSERT INTO `sys_role_menu` VALUES (1, 2116);
INSERT INTO `sys_role_menu` VALUES (1, 2117);
INSERT INTO `sys_role_menu` VALUES (1, 2118);
INSERT INTO `sys_role_menu` VALUES (1, 2119);
INSERT INTO `sys_role_menu` VALUES (1, 2120);
INSERT INTO `sys_role_menu` VALUES (1, 2121);
INSERT INTO `sys_role_menu` VALUES (1, 2122);
INSERT INTO `sys_role_menu` VALUES (1, 2123);
INSERT INTO `sys_role_menu` VALUES (1, 2124);
INSERT INTO `sys_role_menu` VALUES (1, 2125);
INSERT INTO `sys_role_menu` VALUES (1, 2126);
INSERT INTO `sys_role_menu` VALUES (1, 2127);
INSERT INTO `sys_role_menu` VALUES (1, 2128);
INSERT INTO `sys_role_menu` VALUES (1, 2129);
INSERT INTO `sys_role_menu` VALUES (1, 2130);
INSERT INTO `sys_role_menu` VALUES (1, 2131);
INSERT INTO `sys_role_menu` VALUES (1, 2132);
INSERT INTO `sys_role_menu` VALUES (1, 2133);
INSERT INTO `sys_role_menu` VALUES (1, 2134);
INSERT INTO `sys_role_menu` VALUES (1, 2135);
INSERT INTO `sys_role_menu` VALUES (1, 2136);
INSERT INTO `sys_role_menu` VALUES (1, 2137);
INSERT INTO `sys_role_menu` VALUES (1, 2138);
INSERT INTO `sys_role_menu` VALUES (1, 2139);
INSERT INTO `sys_role_menu` VALUES (1, 2140);
INSERT INTO `sys_role_menu` VALUES (1, 2141);
INSERT INTO `sys_role_menu` VALUES (1, 2142);
INSERT INTO `sys_role_menu` VALUES (1, 2143);
INSERT INTO `sys_role_menu` VALUES (1, 2144);
INSERT INTO `sys_role_menu` VALUES (1, 2145);
INSERT INTO `sys_role_menu` VALUES (1, 2146);
INSERT INTO `sys_role_menu` VALUES (1, 2147);
INSERT INTO `sys_role_menu` VALUES (1, 2148);
INSERT INTO `sys_role_menu` VALUES (1, 2149);
INSERT INTO `sys_role_menu` VALUES (1, 2150);
INSERT INTO `sys_role_menu` VALUES (1, 2151);
INSERT INTO `sys_role_menu` VALUES (1, 2152);
INSERT INTO `sys_role_menu` VALUES (1, 2153);
INSERT INTO `sys_role_menu` VALUES (1, 2154);
INSERT INTO `sys_role_menu` VALUES (1, 2155);
INSERT INTO `sys_role_menu` VALUES (1, 2156);
INSERT INTO `sys_role_menu` VALUES (1, 2157);
INSERT INTO `sys_role_menu` VALUES (1, 2158);
INSERT INTO `sys_role_menu` VALUES (1, 2159);
INSERT INTO `sys_role_menu` VALUES (1, 2160);
INSERT INTO `sys_role_menu` VALUES (1, 2161);
INSERT INTO `sys_role_menu` VALUES (1, 2162);
INSERT INTO `sys_role_menu` VALUES (1, 2163);
INSERT INTO `sys_role_menu` VALUES (1, 2165);
INSERT INTO `sys_role_menu` VALUES (1, 2166);
INSERT INTO `sys_role_menu` VALUES (1, 2167);
INSERT INTO `sys_role_menu` VALUES (1, 2168);
INSERT INTO `sys_role_menu` VALUES (1, 2169);
INSERT INTO `sys_role_menu` VALUES (1, 2170);
INSERT INTO `sys_role_menu` VALUES (1, 2172);
INSERT INTO `sys_role_menu` VALUES (1, 2173);
INSERT INTO `sys_role_menu` VALUES (1, 2174);
INSERT INTO `sys_role_menu` VALUES (1, 2175);
INSERT INTO `sys_role_menu` VALUES (1, 2176);
INSERT INTO `sys_role_menu` VALUES (1, 2177);
INSERT INTO `sys_role_menu` VALUES (1, 2178);
INSERT INTO `sys_role_menu` VALUES (1, 2179);
INSERT INTO `sys_role_menu` VALUES (1, 2180);
INSERT INTO `sys_role_menu` VALUES (1, 2181);
INSERT INTO `sys_role_menu` VALUES (1, 2182);
INSERT INTO `sys_role_menu` VALUES (1, 2183);
INSERT INTO `sys_role_menu` VALUES (1, 2185);
INSERT INTO `sys_role_menu` VALUES (1, 2186);
INSERT INTO `sys_role_menu` VALUES (1, 2187);
INSERT INTO `sys_role_menu` VALUES (1, 2188);
INSERT INTO `sys_role_menu` VALUES (1, 2189);
INSERT INTO `sys_role_menu` VALUES (1, 2190);
INSERT INTO `sys_role_menu` VALUES (1, 2192);
INSERT INTO `sys_role_menu` VALUES (1, 2193);
INSERT INTO `sys_role_menu` VALUES (1, 2194);
INSERT INTO `sys_role_menu` VALUES (1, 2195);
INSERT INTO `sys_role_menu` VALUES (1, 2196);
INSERT INTO `sys_role_menu` VALUES (1, 2197);
INSERT INTO `sys_role_menu` VALUES (1, 2198);
INSERT INTO `sys_role_menu` VALUES (1, 2199);
INSERT INTO `sys_role_menu` VALUES (1, 2200);
INSERT INTO `sys_role_menu` VALUES (1, 2201);
INSERT INTO `sys_role_menu` VALUES (1, 2202);
INSERT INTO `sys_role_menu` VALUES (1, 2203);
INSERT INTO `sys_role_menu` VALUES (1, 2204);
INSERT INTO `sys_role_menu` VALUES (1, 2205);
INSERT INTO `sys_role_menu` VALUES (1, 2206);
INSERT INTO `sys_role_menu` VALUES (1, 2207);
INSERT INTO `sys_role_menu` VALUES (1, 2208);
INSERT INTO `sys_role_menu` VALUES (1, 2209);
INSERT INTO `sys_role_menu` VALUES (1, 2210);
INSERT INTO `sys_role_menu` VALUES (1, 2211);
INSERT INTO `sys_role_menu` VALUES (1, 2212);
INSERT INTO `sys_role_menu` VALUES (1, 2213);
INSERT INTO `sys_role_menu` VALUES (1, 2214);
INSERT INTO `sys_role_menu` VALUES (1, 2215);
INSERT INTO `sys_role_menu` VALUES (1, 2216);
INSERT INTO `sys_role_menu` VALUES (1, 2217);
INSERT INTO `sys_role_menu` VALUES (1, 2218);
INSERT INTO `sys_role_menu` VALUES (1, 2219);
INSERT INTO `sys_role_menu` VALUES (1, 2220);
INSERT INTO `sys_role_menu` VALUES (1, 2221);
INSERT INTO `sys_role_menu` VALUES (1, 2222);
INSERT INTO `sys_role_menu` VALUES (1, 2223);
INSERT INTO `sys_role_menu` VALUES (1, 2224);
INSERT INTO `sys_role_menu` VALUES (1, 2225);
INSERT INTO `sys_role_menu` VALUES (1, 2226);
INSERT INTO `sys_role_menu` VALUES (1, 2227);
INSERT INTO `sys_role_menu` VALUES (1, 2228);
INSERT INTO `sys_role_menu` VALUES (1, 2229);
INSERT INTO `sys_role_menu` VALUES (1, 2230);
INSERT INTO `sys_role_menu` VALUES (1, 2231);
INSERT INTO `sys_role_menu` VALUES (1, 2232);
INSERT INTO `sys_role_menu` VALUES (1, 2233);
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-06-04 20:16:26', '2026-05-29 20:04:53', 'admin', '2026-05-29 20:04:53', '', NULL, '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-05-29 20:04:53', '2026-05-29 20:04:53', 'admin', '2026-05-29 20:04:53', '', NULL, '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

-- ============================================================
--  状态语义修正(执行下面这段修复已有库的状态值)
--  my_homework.status / my_student_homework.status 统一:
--    0-未提交  1-已提交  2-已批改
-- ============================================================
SET FOREIGN_KEY_CHECKS = 0;

-- 1) 调整字段默认值与注释
ALTER TABLE my_homework        MODIFY COLUMN status TINYINT NULL DEFAULT 0 COMMENT '状态 0-未提交 1-已提交 2-已批改';
ALTER TABLE my_student_homework MODIFY COLUMN status TINYINT NULL DEFAULT 0 COMMENT '状态 0-未提交 1-已提交 2-已批改';

-- 2) 已有 my_student_homework 已批改(status=1 的旧语义=已批改) -> 2
UPDATE my_student_homework
SET status = 2
WHERE status = 1
  AND (score IS NOT NULL OR teacher_comment IS NOT NULL);

-- 3) 已有 my_student_homework 已提交但旧值被错记 -> 1
UPDATE my_student_homework
SET status = 1
WHERE status = 1
  AND score IS NULL
  AND (teacher_comment IS NULL OR teacher_comment = '')
  AND answers IS NOT NULL
  AND TRIM(answers) <> '';

-- 4) 把 my_homework.status 按对应 my_student_homework.status 同步过来(每条作业的每位学生)
UPDATE my_homework h
JOIN my_student_homework msh
  ON msh.hw_id = h.hw_id AND msh.stu_id = h.std_id
SET h.status = msh.status;

-- 5) 给所有 my_student_homework 已有答案但 status=0 的记录,补成已提交=1
UPDATE my_student_homework
SET status = 1, submit_time = COALESCE(submit_time, update_time, create_time, NOW())
WHERE status = 0
  AND answers IS NOT NULL
  AND TRIM(answers) <> '';

-- 6) 再次把 my_homework 与 my_student_homework 状态对齐
UPDATE my_homework h
JOIN my_student_homework msh
  ON msh.hw_id = h.hw_id AND msh.stu_id = h.std_id
SET h.status = msh.status;

SET FOREIGN_KEY_CHECKS = 1;
