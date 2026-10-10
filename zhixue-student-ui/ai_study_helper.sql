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

 Date: 02/06/2026 23:30:49
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for my_admin
-- ----------------------------
DROP TABLE IF EXISTS `my_admin`;
CREATE TABLE `my_admin`  (
  `admin_id` bigint NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `user_id` bigint NOT NULL COMMENT '关联用户ID',
  `admin_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '管理员编号',
  `role` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'super' COMMENT '角色 super-超级管理员 normal-普通管理员',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`admin_id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_admin
-- ----------------------------
INSERT INTO `my_admin` VALUES (1, 4, 'A2024001', 'super', '2026-05-27 00:13:29');

-- ----------------------------
-- Table structure for my_ai_chat
-- ----------------------------
DROP TABLE IF EXISTS `my_ai_chat`;
CREATE TABLE `my_ai_chat`  (
  `chat_id` bigint NOT NULL AUTO_INCREMENT COMMENT '对话ID',
  `stu_id` bigint NULL DEFAULT NULL COMMENT '学生ID',
  `teacher_id` bigint NULL DEFAULT NULL COMMENT '教师ID',
  `session_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会话ID',
  `question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '问题内容',
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '回答内容',
  `question_type` tinyint NULL DEFAULT 1 COMMENT '问题类型 1-学习 2-作业 3-其他',
  `is_satisfied` tinyint NULL DEFAULT NULL COMMENT '是否满意 0-否 1-是',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chat_id`) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE,
  INDEX `idx_session_id`(`session_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'AI问答记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_ai_chat
-- ----------------------------
INSERT INTO `my_ai_chat` VALUES (1, 1, NULL, 'S20260501', '牛顿第一定律是什么？', '牛顿第一定律，又称惯性定律：任何物体都要保持匀速直线运动或静止状态，直到外力迫使它改变运动状态为止。', 1, 1, '2026-06-01 17:15:37');
INSERT INTO `my_ai_chat` VALUES (2, 1, NULL, 'S20260501', '可以举个例子吗？', '比如行驶中的汽车突然刹车时，乘客会向前倾倒，就是因为身体要保持原来的运动状态（惯性）。', 1, 1, '2026-06-01 17:15:37');
INSERT INTO `my_ai_chat` VALUES (3, 1, NULL, 'S20260502', '压强怎么计算？', '压强P=F/S，其中F是压力(单位N)，S是受力面积(单位m²)，压强单位是帕斯卡(Pa)。1Pa=1N/m²。', 1, 1, '2026-06-01 17:15:37');
INSERT INTO `my_ai_chat` VALUES (4, 2, NULL, 'S20260503', '英语\"because\"和\"because of\"的区别？', 'because是连词，后面接完整的句子；because of是介词短语，后面接名词/代词/动名词。例如：I stayed home because it was raining. / I stayed home because of the rain.', 1, 0, '2026-06-01 17:15:37');

-- ----------------------------
-- Table structure for my_bank
-- ----------------------------
DROP TABLE IF EXISTS `my_bank`;
CREATE TABLE `my_bank`  (
  `hb_id` bigint NOT NULL AUTO_INCREMENT COMMENT '题库ID',
  `qb_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '题库名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '题库描述',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '题库类型',
  `tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签',
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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '题库表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_bank
-- ----------------------------
INSERT INTO `my_bank` VALUES (1, '初中物理力学题库', '涵盖牛顿定律、压强、浮力等基础力学题目', 'physics', '物理,力学', 2, 30, 300, 2, 1, 1, '2026-06-01 17:15:38', '2026-06-01 17:15:38');
INSERT INTO `my_bank` VALUES (2, '初中英语语法题库', '时态、语态、从句等基础语法练习', 'english', '英语,语法', 3, 25, 250, 2, 1, 1, '2026-06-01 17:15:38', '2026-06-01 17:15:38');
INSERT INTO `my_bank` VALUES (3, '初中数学函数题库', '一次函数、二次函数、反比例函数', 'math', '数学,函数', 4, 40, 400, 2, 1, 1, '2026-06-01 17:15:38', '2026-06-01 17:15:38');
INSERT INTO `my_bank` VALUES (4, '初中化学基础题库', '元素周期表、化学式、化学反应', 'chemistry', '化学,基础', 2, 20, 200, 1, 1, 1, '2026-06-01 17:15:38', '2026-06-01 17:15:38');

-- ----------------------------
-- Table structure for my_course
-- ----------------------------
DROP TABLE IF EXISTS `my_course`;
CREATE TABLE `my_course`  (
  `c_id` bigint NOT NULL AUTO_INCREMENT COMMENT '课程ID',
  `c_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程名称',
  `teacher_id` bigint NOT NULL COMMENT '授课教师ID',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '课程类型',
  `tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '课程标签',
  `difficulty` tinyint NULL DEFAULT 1 COMMENT '难度 1-简单 2-中等 3-困难',
  `max_person` int NULL DEFAULT 50 COMMENT '最大人数',
  `current_person` int NULL DEFAULT 0 COMMENT '当前人数',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '课程描述',
  `cover_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-下架 1-上架',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开课时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结课时间',
  `resource_id` bigint NULL DEFAULT NULL COMMENT '关联资源ID',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`c_id`) USING BTREE,
  INDEX `idx_teacher_id`(`teacher_id` ASC) USING BTREE,
  INDEX `idx_type`(`type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课程表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_course
-- ----------------------------
INSERT INTO `my_course` VALUES (1, '初中物理：力学基础突破', 2, 'physics', '物理,力学,初中', 2, 30, 24, '系统讲解初中物理力学基础知识，涵盖牛顿定律、压强、浮力等核心考点', '/images/course/physics_01.jpg', 1, '2026-06-01 14:00:00', '2026-08-30 15:30:00', 1, '周六 14:00-15:30 · 张明老师 · 12课时', '2026-05-27 00:13:29', '2026-05-29 10:00:00');
INSERT INTO `my_course` VALUES (2, '英语口语：模拟面试实战', 3, 'english', '英语,口语,面试', 2, 20, 12, '全英文模拟面试场景，提升口语表达与听力理解能力', '/images/course/english_01.jpg', 1, '2026-06-02 10:00:00', '2026-08-31 11:30:00', 5, '周日 10:00-11:30 · 王蕾老师 · 8课时', '2026-05-27 00:13:29', '2026-05-29 10:00:00');
INSERT INTO `my_course` VALUES (3, '高中数学：函数专题精讲', 4, 'math', '数学,函数,专题', 2, 40, 35, '深入讲解一次函数、二次函数、反比例函数等核心知识点', '/images/course/math_01.jpg', 1, '2026-06-05 19:00:00', '2026-09-30 20:30:00', 3, '周五 19:00-20:30 · 陈伟老师 · 15课时', '2026-05-27 00:13:29', '2026-05-29 10:00:00');
INSERT INTO `my_course` VALUES (4, '初中化学：元素周期表入门', 2, 'chemistry', '化学,元素周期表,初中', 1, 25, 18, '趣味学习元素周期表，掌握常见元素性质与化学反应', '/images/course/chemistry_01.jpg', 1, '2026-06-03 16:00:00', '2026-08-31 17:30:00', 6, '周六 16:00-17:30 · 张明老师 · 10课时', '2026-05-27 00:13:29', '2026-05-29 10:00:00');
INSERT INTO `my_course` VALUES (5, '高二数学：立体几何深度解析', 4, 'math', '数学,立体几何,高二', 3, 35, 30, '系统讲解空间几何体、点线面位置关系、空间向量等立体几何核心内容', '/images/course/math_02.jpg', 1, '2026-06-06 19:00:00', '2026-09-30 21:00:00', 4, '周六 19:00-21:00 · 陈伟老师 · 16课时', '2026-05-30 10:00:00', '2026-05-30 10:00:00');
INSERT INTO `my_course` VALUES (6, '英语语法：时态语态全攻略', 3, 'english', '英语,语法,时态', 2, 25, 22, '全面讲解英语十六大时态及被动语态，搭配真题实战演练', '/images/course/english_02.jpg', 1, '2026-06-07 10:00:00', '2026-09-29 11:30:00', 5, '周日 10:00-11:30 · 王蕾老师 · 10课时', '2026-05-30 10:00:00', '2026-05-30 10:00:00');
INSERT INTO `my_course` VALUES (7, '物理竞赛：电学专题特训', 2, 'physics', '物理,电学,竞赛', 3, 15, 14, '针对物理竞赛的电学专题训练，涵盖电路分析、电磁感应等进阶内容', '/images/course/physics_02.jpg', 1, '2026-06-10 14:00:00', '2026-09-25 16:00:00', 2, '周三 14:00-16:00 · 张明老师 · 8课时', '2026-05-30 10:00:00', '2026-05-30 10:00:00');
INSERT INTO `my_course` VALUES (8, '高三数学：导数与压轴题突破', 4, 'math', '数学,导数,压轴题', 3, 20, 0, '专攻高考数学压轴题，系统讲解导数应用、数列不等式等高难度考点', '/images/course/math_03.jpg', 1, '2026-06-15 19:00:00', '2026-09-30 21:00:00', 4, '周一 19:00-21:00 · 陈伟老师 · 12课时', '2026-05-30 10:00:00', '2026-05-30 10:00:00');
INSERT INTO `my_course` VALUES (9, '初中英语：完形填空专项训练', 3, 'english', '英语,完形填空,初中', 1, 25, 0, '针对中考完形填空题型进行专项突破训练，提升阅读理解与词汇运用能力', '/images/course/english_03.jpg', 1, '2026-06-12 16:00:00', '2026-09-27 17:30:00', 9, '周四 16:00-17:30 · 王蕾老师 · 8课时', '2026-05-30 10:00:00', '2026-05-30 10:00:00');
INSERT INTO `my_course` VALUES (10, '趣味化学：生活中的化学实验', 2, 'chemistry', '化学,实验,趣味', 1, 30, 0, '通过趣味实验学习生活中的化学知识，培养科学思维与动手能力', '/images/course/chemistry_02.jpg', 1, '2026-06-14 09:00:00', '2026-09-28 10:30:00', 10, '周日 09:00-10:30 · 张明老师 · 10课时', '2026-05-30 10:00:00', '2026-05-30 10:00:00');

-- ----------------------------
-- Table structure for my_course_appointment
-- ----------------------------
DROP TABLE IF EXISTS `my_course_appointment`;
CREATE TABLE `my_course_appointment`  (
  `ca_id` bigint NOT NULL AUTO_INCREMENT COMMENT '预约ID',
  `stu_id` bigint NOT NULL COMMENT '学生ID',
  `stu_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学号',
  `c_id` bigint NOT NULL COMMENT '课程ID',
  `appointment_time` datetime NULL DEFAULT NULL COMMENT '预约时间',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态 0-待确认 1-已确认 2-已取消 3-已完成',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ca_id`) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课程预约表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_course_appointment
-- ----------------------------
INSERT INTO `my_course_appointment` VALUES (1, 1, NULL, 1, '2026-05-20 14:00:00', 1, '已确认预约：物理力学基础突破', '2026-05-18 10:30:00', '2026-06-01 17:15:36');
INSERT INTO `my_course_appointment` VALUES (2, 1, NULL, 2, '2026-05-22 10:00:00', 1, '已确认预约：英语口语面试实战', '2026-05-19 14:00:00', '2026-06-01 17:15:36');
INSERT INTO `my_course_appointment` VALUES (3, 1, NULL, 3, '2026-05-25 19:00:00', 1, '已确认预约：函数专题精讲', '2026-05-21 09:15:00', '2026-06-01 17:15:36');
INSERT INTO `my_course_appointment` VALUES (4, 1, NULL, 4, '2026-05-28 16:00:00', 0, '待确认预约：化学元素周期表', '2026-05-26 11:00:00', '2026-06-01 17:15:36');
INSERT INTO `my_course_appointment` VALUES (5, 2, NULL, 1, '2026-05-20 14:00:00', 1, '已确认预约', '2026-05-17 16:30:00', '2026-06-01 17:15:36');
INSERT INTO `my_course_appointment` VALUES (6, 2, NULL, 3, '2026-05-21 19:00:00', 1, '已确认预约：函数专题精讲', '2026-05-20 10:00:00', '2026-06-01 17:15:37');
INSERT INTO `my_course_appointment` VALUES (7, 2, NULL, 4, '2026-05-29 16:00:00', 0, '待确认预约：化学元素周期表', '2026-05-27 14:00:00', '2026-06-01 17:15:37');

-- ----------------------------
-- Table structure for my_course_resource
-- ----------------------------
DROP TABLE IF EXISTS `my_course_resource`;
CREATE TABLE `my_course_resource`  (
  `re_id` bigint NOT NULL AUTO_INCREMENT COMMENT '资源ID',
  `c_id` bigint NULL DEFAULT NULL COMMENT '关联课程ID',
  `resource_type` tinyint NOT NULL COMMENT '资源类型 1-视频 2-图书 3-期刊 4-讲座',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '资源标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '资源内容/描述',
  `file_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件链接',
  `video_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '视频链接',
  `homework` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '作业内容',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`re_id`) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_resource_type`(`resource_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课程资源表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_course_resource
-- ----------------------------
INSERT INTO `my_course_resource` VALUES (11, 1, 1, '牛顿定律精讲视频', '牛顿第一、二、三定律详细讲解', NULL, '/video/physics/newton.mp4', NULL, 1, '2026-06-01 17:15:36', '物理,力学');
INSERT INTO `my_course_resource` VALUES (12, 1, 2, '压强与浮力练习题', '压强计算与浮力应用练习题集', '/file/physics/pressure_exercise.pdf', NULL, NULL, 2, '2026-06-01 17:15:36', '物理,压强');
INSERT INTO `my_course_resource` VALUES (13, 3, 1, '一次函数图像解析', '一次函数图像性质与绘制方法', NULL, '/video/math/linear_func.mp4', NULL, 1, '2026-06-01 17:15:36', '数学,函数');
INSERT INTO `my_course_resource` VALUES (14, 3, 2, '二次函数综合练习', '二次函数顶点式与一般式互化练习', '/file/math/quadratic_exercise.pdf', NULL, NULL, 2, '2026-06-01 17:15:36', '数学,二次函数');
INSERT INTO `my_course_resource` VALUES (15, 2, 1, '英语面试对话模拟', '全英文模拟面试场景对话', NULL, '/video/english/interview.mp4', NULL, 1, '2026-06-01 17:15:36', '英语,口语');
INSERT INTO `my_course_resource` VALUES (16, 4, 1, '元素周期表记忆技巧', '前20号元素趣味记忆法', NULL, '/video/chemistry/periodic.mp4', NULL, 1, '2026-06-01 17:15:36', '化学,元素周期表');
INSERT INTO `my_course_resource` VALUES (17, 7, 1, '电路分析基础视频', '串并联电路分析与欧姆定律应用', NULL, '/video/physics/circuit.mp4', NULL, 1, '2026-06-01 17:15:36', '物理,电学');
INSERT INTO `my_course_resource` VALUES (18, 7, 2, '电磁感应专题练习', '电磁感应定律计算与综合应用', '/file/physics/electromagnetic.pdf', NULL, NULL, 2, '2026-06-01 17:15:36', '物理,电磁');
INSERT INTO `my_course_resource` VALUES (19, 5, 1, '空间向量精讲视频', '空间向量坐标运算与几何应用', NULL, '/video/math/vector.mp4', NULL, 1, '2026-06-01 17:15:36', '数学,立体几何');
INSERT INTO `my_course_resource` VALUES (20, 6, 1, '时态语法精讲视频', '十六大时态系统梳理与对比', NULL, '/video/english/tenses.mp4', NULL, 1, '2026-06-01 17:15:36', '英语,语法');
INSERT INTO `my_course_resource` VALUES (21, 1, 1, '牛顿第一定律精讲', '牛顿第一定律的详细讲解与实验演示', NULL, '/videos/physics/newton1.mp4', NULL, 1, '2026-06-01 17:15:37', '物理,力学');
INSERT INTO `my_course_resource` VALUES (22, 1, 1, '压强计算专题', '压强P=F/S公式推导与典型例题', NULL, '/videos/physics/pressure.mp4', NULL, 2, '2026-06-01 17:15:37', '物理,压强');
INSERT INTO `my_course_resource` VALUES (23, 1, 2, '力学基础知识点总结', '力学章节重点知识归纳PDF', NULL, '/files/physics/mechanics_summary.pdf', '完成课后练习题P32-35', 3, '2026-06-01 17:15:37', '物理,力学');
INSERT INTO `my_course_resource` VALUES (24, 1, 5, '物理学家故事讲座', '牛顿、阿基米德等物理学家的故事', NULL, NULL, NULL, 4, '2026-06-01 17:15:37', '物理,科普');
INSERT INTO `my_course_resource` VALUES (25, 2, 1, '英语口语发音技巧', '元音辅音发音标准教学视频', NULL, '/videos/english/pronunciation.mp4', NULL, 1, '2026-06-01 17:15:37', '英语,口语');
INSERT INTO `my_course_resource` VALUES (26, 2, 2, '面试常用句型汇总', '模拟面试高频句型PDF', NULL, '/files/english/interview_sentences.pdf', '用所学句型写一段自我介绍', 2, '2026-06-01 17:15:37', '英语,面试');
INSERT INTO `my_course_resource` VALUES (27, 2, 4, '英语学习方法期刊', '英语学习策略与技巧', NULL, NULL, NULL, 3, '2026-06-01 17:15:37', '英语,方法');
INSERT INTO `my_course_resource` VALUES (28, 3, 1, '一次函数图像与性质', '一次函数y=kx+b的图像特点解析', NULL, '/videos/math/linear_function.mp4', NULL, 1, '2026-06-01 17:15:37', '数学,函数');
INSERT INTO `my_course_resource` VALUES (29, 3, 1, '二次函数顶点式', '二次函数顶点式的推导与应用', NULL, '/videos/math/quadratic.mp4', NULL, 2, '2026-06-01 17:15:37', '数学,函数');
INSERT INTO `my_course_resource` VALUES (30, 3, 2, '函数专题练习题集', '精选函数练习题含答案解析', NULL, '/files/math/function_exercises.pdf', '完成函数练习题1-15题', 3, '2026-06-01 17:15:37', '数学,函数');
INSERT INTO `my_course_resource` VALUES (31, 3, 5, '数学思维训练讲座', '如何培养数学逻辑思维', NULL, NULL, NULL, 4, '2026-06-01 17:15:37', '数学,思维');
INSERT INTO `my_course_resource` VALUES (32, 4, 1, '元素周期表记忆法', '趣味记忆前20号元素', NULL, '/videos/chemistry/periodic.mp4', NULL, 1, '2026-06-01 17:15:37', '化学,元素');
INSERT INTO `my_course_resource` VALUES (33, 4, 2, '常见元素性质一览', '元素性质对比表格', NULL, '/files/chemistry/elements.pdf', '默写前20号元素符号', 2, '2026-06-01 17:15:37', '化学,元素');

-- ----------------------------
-- Table structure for my_error_book
-- ----------------------------
DROP TABLE IF EXISTS `my_error_book`;
CREATE TABLE `my_error_book`  (
  `eb_id` bigint NOT NULL AUTO_INCREMENT COMMENT '错题记录ID',
  `stu_id` bigint NOT NULL COMMENT '学生ID',
  `hq_id` bigint NULL DEFAULT NULL COMMENT '题目ID',
  `c_id` bigint NULL DEFAULT NULL COMMENT '课程ID',
  `wrong_answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '错误答案',
  `correct_answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '正确答案',
  `analysis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '解析',
  `tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签/知识点',
  `error_count` int NULL DEFAULT 1 COMMENT '错误次数',
  `is_mastered` tinyint NULL DEFAULT 0 COMMENT '是否已掌握 0-否 1-是',
  `last_wrong_time` datetime NULL DEFAULT NULL COMMENT '最后错误时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`eb_id`) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_is_mastered`(`is_mastered` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '错题本表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_error_book
-- ----------------------------
INSERT INTO `my_error_book` VALUES (1, 1, NULL, 3, 'x=-2', 'x=2', '解析：3(x-2)+5=2x+1 → 3x-6+5=2x+1 → 3x-1=2x+1 → x=2', 'math,方程', 2, 0, '2025-05-24 10:30:00', '2025-05-24 10:30:00', '2026-06-01 17:15:36');
INSERT INTO `my_error_book` VALUES (2, 1, NULL, 3, 'x=4', 'x=2', '解析：3(x-2)+5=2x+1 → 3x-6+5=2x+1 → 3x-1=2x+1 → x=2', 'math,方程', 1, 0, '2025-05-23 15:20:00', '2025-05-23 15:20:00', '2026-06-01 17:15:36');
INSERT INTO `my_error_book` VALUES (3, 1, NULL, 1, '10N', '10N', '解析：F=ma=2kg×5m/s²=10N', 'physics,力学', 1, 0, '2025-05-22 14:00:00', '2025-05-22 14:00:00', '2026-06-01 17:15:36');
INSERT INTO `my_error_book` VALUES (4, 1, NULL, 2, 'are', 'is', '解析：The news 作主语视为单数，谓语动词用 is', 'english,语法', 3, 0, '2025-05-25 09:00:00', '2025-05-25 09:00:00', '2026-06-01 17:15:36');
INSERT INTO `my_error_book` VALUES (5, 1, NULL, 3, 'y=2x', 'y=2x+1', '解析：斜率 k=2，过点(0,1)得 b=1，所以 y=2x+1', 'math,函数', 1, 0, '2025-05-21 11:30:00', '2025-05-21 11:30:00', '2026-06-01 17:15:36');
INSERT INTO `my_error_book` VALUES (6, 1, NULL, 1, '0.5', '0.8', '解析：ρ=m/V=40g/50cm³=0.8g/cm³', 'physics,密度', 2, 0, '2025-05-20 16:00:00', '2025-05-20 16:00:00', '2026-06-01 17:15:36');
INSERT INTO `my_error_book` VALUES (7, 1, NULL, 2, 'readed', 'read', '解析：read的过去式与过去分词均为read（读音变化），属于不规则动词', 'english,语法', 2, 0, '2025-05-26 14:00:00', '2025-05-26 14:00:00', '2026-06-01 17:15:37');
INSERT INTO `my_error_book` VALUES (8, 1, NULL, 3, 'x=-3', 'x=3', '解析：2x+1=7 → 2x=6 → x=3', 'math,方程', 1, 0, '2025-05-27 09:00:00', '2025-05-27 09:00:00', '2026-06-01 17:15:37');
INSERT INTO `my_error_book` VALUES (9, 1, NULL, 1, '不变', '变大', '解析：液体压强P=ρgh，深度h增大，压强P增大', 'physics,压强', 2, 0, '2025-05-27 15:30:00', '2025-05-27 15:30:00', '2026-06-01 17:15:37');
INSERT INTO `my_error_book` VALUES (10, 1, NULL, 2, 'go', 'went', '解析：句子时态为一般过去时（yesterday），go的过去式是went', 'english,语法', 1, 0, '2025-05-28 10:00:00', '2025-05-28 10:00:00', '2026-06-01 17:15:37');
INSERT INTO `my_error_book` VALUES (11, 1, NULL, 4, 'H', 'He', '解析：第2号元素是氦(He)，氢(H)是第1号', 'chemistry,元素', 1, 0, '2025-05-28 16:00:00', '2025-05-28 16:00:00', '2026-06-01 17:15:37');
INSERT INTO `my_error_book` VALUES (12, 1, NULL, 3, '增大', '减小', '解析：反比例函数y=k/x中，当k<0时，y随x增大而增大。若k>0，则y随x增大而减小', 'math,函数', 3, 0, '2025-05-29 08:00:00', '2025-05-29 08:00:00', '2026-06-01 17:15:37');
INSERT INTO `my_error_book` VALUES (13, 1, NULL, 3, 'x=5', 'x=5', '解析：2(x-3)=4 → 2x-6=4 → 2x=10 → x=5', 'math,方程', 2, 1, '2025-05-10 10:00:00', '2025-05-10 10:00:00', '2026-06-01 17:15:37');
INSERT INTO `my_error_book` VALUES (14, 1, NULL, 1, '1000', '1000', '解析：1kg=1000g，单位换算', 'physics,单位', 1, 1, '2025-05-08 14:00:00', '2025-05-08 14:00:00', '2026-06-01 17:15:37');
INSERT INTO `my_error_book` VALUES (15, 1, NULL, 1, '增大', '增大', '解析：摩擦力大小与压力大小和接触面粗糙程度有关', 'physics,力学', 1, 1, '2025-05-05 09:00:00', '2025-05-05 09:00:00', '2026-06-01 17:15:37');
INSERT INTO `my_error_book` VALUES (16, 2, NULL, 1, '20N', '10N', '解析：F=ma=2×5=10N，注意公式运用', 'physics,力学', 2, 0, '2025-05-26 11:00:00', '2025-05-26 11:00:00', '2026-06-01 17:15:37');

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '全局数据报表统计表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_global_report
-- ----------------------------
INSERT INTO `my_global_report` VALUES (1, NULL, NULL, 2, '2026-05-31', 2, 3, 4, 2, 0, 5, 78.50, 36.50, '{\"top_course\": \"初中物理：力学基础突破\", \"top_student\": \"陈小明\", \"total_appointments\": 7}', '2026-06-01 17:15:38');
INSERT INTO `my_global_report` VALUES (2, NULL, NULL, 3, '2026-05-01', 2, 3, 4, 2, 2, 12, 82.00, 200.00, '{\"new_courses\": [\"初中化学：元素周期表入门\"], \"monthly_active_rate\": \"100%\"}', '2026-06-01 17:15:38');

-- ----------------------------
-- Table structure for my_homework
-- ----------------------------
DROP TABLE IF EXISTS `my_homework`;
CREATE TABLE `my_homework`  (
  `hw_id` bigint NOT NULL AUTO_INCREMENT COMMENT '作业ID',
  `std_id` bigint NULL DEFAULT NULL COMMENT '学生ID',
  `c_id` bigint NOT NULL COMMENT '课程ID',
  `teacher_id` bigint NOT NULL COMMENT '发布教师ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '作业标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '作业内容',
  `type` tinyint NULL DEFAULT 1 COMMENT '作业类型 1-客观题 2-主观题 3-混合',
  `total_score` int NULL DEFAULT 100 COMMENT '总分',
  `deadline` datetime NULL DEFAULT NULL COMMENT '截止时间',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-未提交 1-已提交 2-已批改',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hw_id`) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_teacher_id`(`teacher_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '作业表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_homework
-- ----------------------------
INSERT INTO `my_homework` VALUES (1, 1, 1, 2, '物理力学单元测试', '牛顿定律与压强基础练习题', 1, 100, '2026-06-05 23:59:59', 0, '2026-05-20 10:00:00', '2026-06-02 22:27:37');
INSERT INTO `my_homework` VALUES (2, 1, 1, 2, '浮力专题作业', '阿基米德原理应用与计算', 1, 100, '2026-06-12 23:59:59', 1, '2026-05-22 14:00:00', '2026-06-01 20:49:05');
INSERT INTO `my_homework` VALUES (3, 1, 2, 3, '英语口语练习一', '自我介绍与日常对话模拟', 2, 100, '2026-06-08 23:59:59', 1, '2026-05-21 09:00:00', '2026-06-01 20:49:06');
INSERT INTO `my_homework` VALUES (4, 2, 2, 3, '英语听力理解', '短对话与长对话听力练习', 1, 100, '2026-06-15 23:59:59', 1, '2026-05-23 11:00:00', '2026-06-01 20:49:07');
INSERT INTO `my_homework` VALUES (5, 3, 3, 4, '一次函数练习题', '一次函数图像与性质', 1, 100, '2026-06-03 23:59:59', 1, '2026-05-19 15:00:00', '2026-06-01 20:49:08');
INSERT INTO `my_homework` VALUES (6, 4, 3, 4, '二次函数综合', '二次函数顶点式与一般式互化', 1, 100, '2026-06-10 23:59:59', 2, '2026-05-20 08:00:00', '2026-06-01 20:49:08');
INSERT INTO `my_homework` VALUES (7, 5, 4, 2, '元素周期表默写', '前20号元素名称与符号', 1, 100, '2026-06-06 23:59:59', 1, '2026-05-24 16:00:00', '2026-06-01 20:49:10');

-- ----------------------------
-- Table structure for my_homework_bank
-- ----------------------------
DROP TABLE IF EXISTS `my_homework_bank`;
CREATE TABLE `my_homework_bank`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `b_id` bigint NULL DEFAULT NULL COMMENT '题目ID',
  `hw_id` bigint NULL DEFAULT NULL COMMENT '作业id',
  PRIMARY KEY (`id` DESC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_homework_bank
-- ----------------------------
INSERT INTO `my_homework_bank` VALUES (7, 4, 7);
INSERT INTO `my_homework_bank` VALUES (6, 3, 6);
INSERT INTO `my_homework_bank` VALUES (5, 3, 5);
INSERT INTO `my_homework_bank` VALUES (4, 2, 4);
INSERT INTO `my_homework_bank` VALUES (3, 2, 3);
INSERT INTO `my_homework_bank` VALUES (2, 1, 2);
INSERT INTO `my_homework_bank` VALUES (1, 1, 1);

-- ----------------------------
-- Table structure for my_notification
-- ----------------------------
DROP TABLE IF EXISTS `my_notification`;
CREATE TABLE `my_notification`  (
  `noti_id` bigint NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `sender_id` bigint NULL DEFAULT NULL COMMENT '发送者ID',
  `sender_type` tinyint NULL DEFAULT 2 COMMENT '发送者类型 1-系统 2-教师 3-管理员',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '通知标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '通知内容',
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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_notification
-- ----------------------------
INSERT INTO `my_notification` VALUES (1, 3, 2, '物理课调课通知', '本周六的物理课因老师参加教研活动，调整至周日下午14:00', 1, NULL, 2, 1, 1, '2026-05-25 08:00:00', '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_notification` VALUES (2, 3, 2, '力学作业已批改', '力学单元测试作业已批改完成，请查看得分和评语', 2, NULL, 1, 0, 1, '2026-05-26 10:00:00', '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_notification` VALUES (3, 4, 3, '系统更新通知', '学习平台将于本周日凌晨2:00-4:00进行系统升级维护', 1, NULL, 1, 0, 1, '2026-05-27 09:00:00', '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_notification` VALUES (4, 3, 2, '期中考试安排', '物理期中考试定于6月15日进行，请同学们提前复习', 1, NULL, 3, 1, 1, '2026-05-28 15:00:00', '2026-06-01 17:15:37', '2026-06-01 17:15:37');

-- ----------------------------
-- Table structure for my_question
-- ----------------------------
DROP TABLE IF EXISTS `my_question`;
CREATE TABLE `my_question`  (
  `q_id` bigint NOT NULL AUTO_INCREMENT COMMENT '题目ID',
  `hw_id` bigint NOT NULL COMMENT '作业ID',
  `question_type` tinyint NOT NULL COMMENT '题型 1-单选 2-多选 3-判断 4-填空 5-简答',
  `question_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '题目内容',
  `options` json NULL COMMENT '选项(JSON格式)',
  `correct_answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '正确答案',
  `score` int NULL DEFAULT 10 COMMENT '分值',
  `difficulty` tinyint NULL DEFAULT 2 COMMENT '难度 1-简单 2-中等 3-困难',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`q_id`) USING BTREE,
  INDEX `idx_hw_id`(`hw_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '作业题目表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_question
-- ----------------------------
INSERT INTO `my_question` VALUES (1, 1, 1, '牛顿第一定律又被称为？', '[\"惯性定律\", \"万有引力定律\", \"作用力与反作用力定律\", \"能量守恒定律\"]', 'A', 10, 1, 0);
INSERT INTO `my_question` VALUES (2, 1, 1, '压强的国际单位是？', '[\"牛顿(N)\", \"帕斯卡(Pa)\", \"焦耳(J)\", \"瓦特(W)\"]', 'B', 10, 1, 0);
INSERT INTO `my_question` VALUES (3, 1, 4, '一个质量为2kg的物体，受到10N的力，加速度为___m/s²', NULL, '5', 10, 2, 0);
INSERT INTO `my_question` VALUES (4, 1, 5, '请简述牛顿第三定律的内容', NULL, '两个物体之间的作用力和反作用力总是大小相等、方向相反、作用在同一条直线上', 20, 2, 0);
INSERT INTO `my_question` VALUES (5, 2, 1, '阿基米德原理的内容是？', '[\"物体在液体中受到的浮力等于物体排开液体的重力\", \"物体在液体中受到的浮力等于物体的重力\", \"浮力与深度成正比\", \"浮力与物体密度成正比\"]', 'A', 10, 2, 0);
INSERT INTO `my_question` VALUES (6, 2, 4, '一个物体在水中排开水的体积为0.5m³，水的密度为1000kg/m³，则浮力大小为___N（g取10N/kg）', NULL, '5000', 10, 3, 0);
INSERT INTO `my_question` VALUES (7, 2, 3, '铁块在水中会下沉，说明铁块没有受到浮力', NULL, '×', 10, 1, 0);
INSERT INTO `my_question` VALUES (8, 3, 5, '请用英语做一段不少于50词的自我介绍', NULL, 'Hello everyone, my name is...', 30, 1, 0);
INSERT INTO `my_question` VALUES (9, 5, 4, '一次函数y=2x+3的图像与y轴的交点坐标为(0,___)', NULL, '3', 10, 1, 0);
INSERT INTO `my_question` VALUES (10, 5, 1, '一次函数y=kx+b中，当k>0时，图像是？', '[\"上升直线\", \"下降直线\", \"水平线\", \"竖直线\"]', 'A', 10, 1, 0);
INSERT INTO `my_question` VALUES (11, 5, 5, '已知一次函数y=3x-6，求与x轴和y轴的交点坐标', NULL, '与x轴交点(2,0)，与y轴交点(0,-6)', 20, 2, 0);
INSERT INTO `my_question` VALUES (12, 6, 1, '二次函数y=x²-4x+3的顶点坐标是？', '[\"(2,-1)\", \"(-2,1)\", \"(2,1)\", \"(-2,-1)\"]', 'A', 10, 2, 0);
INSERT INTO `my_question` VALUES (13, 6, 4, '二次函数y=2(x-1)²+3的对称轴为x=___', NULL, '1', 10, 2, 0);
INSERT INTO `my_question` VALUES (14, 6, 3, '二次函数的图像一定是抛物线', NULL, '√', 10, 1, 0);

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
INSERT INTO `my_question_bank` VALUES (3, 1, 3, '10');
INSERT INTO `my_question_bank` VALUES (4, 1, 6, '10');
INSERT INTO `my_question_bank` VALUES (5, 2, 18, '10');
INSERT INTO `my_question_bank` VALUES (6, 3, 9, '10');
INSERT INTO `my_question_bank` VALUES (7, 3, 10, '10');
INSERT INTO `my_question_bank` VALUES (8, 3, 11, '20');
INSERT INTO `my_question_bank` VALUES (9, 3, 12, '10');
INSERT INTO `my_question_bank` VALUES (10, 3, 13, '10');

-- ----------------------------
-- Table structure for my_rank_config
-- ----------------------------
DROP TABLE IF EXISTS `my_rank_config`;
CREATE TABLE `my_rank_config`  (
  `rank_id` int NOT NULL AUTO_INCREMENT COMMENT '段位ID',
  `rank_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '段位名称',
  `rank_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '段位图标',
  `min_score` int NOT NULL COMMENT '最低积分',
  `max_score` int NOT NULL COMMENT '最高积分',
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '段位颜色',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '段位描述',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`rank_id`) USING BTREE,
  UNIQUE INDEX `uk_rank_name`(`rank_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '段位配置表' ROW_FORMAT = DYNAMIC;

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
  `student_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学号',
  `major` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专业/学校',
  `grade` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '年级',
  `class_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '班级',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `teacher_id` bigint NULL DEFAULT NULL COMMENT '关联教师ID',
  `rank_level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '青铜' COMMENT '当前段位',
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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学生信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_student
-- ----------------------------
INSERT INTO `my_student` VALUES (1, 1, '2024001', '晨曦中学', '初二年级', '初二(3)班', NULL, 2, '黄金 III', 750, 320, 275, 36.50, '2026-05-27 00:13:29', '2026-05-29 10:00:00');
INSERT INTO `my_student` VALUES (2, 2, '2024002', '软件工程', '2024级', '软工1班', NULL, 3, '青铜', 80, 30, 20, 8.00, '2026-05-27 00:13:29', '2026-05-27 00:13:29');

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
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sc_id`) USING BTREE,
  UNIQUE INDEX `uk_stu_course`(`stu_id` ASC, `c_id` ASC) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学生选课表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_student_course
-- ----------------------------
INSERT INTO `my_student_course` VALUES (1, 1, 1, '2025-03-01 09:00:00', 1, 66, NULL, '物理力学 - 已上8/12课时', '2025-03-01 09:00:00', '2026-06-01 17:15:36');
INSERT INTO `my_student_course` VALUES (2, 1, 2, '2025-04-01 10:00:00', 1, 75, NULL, '英语口语 - 已上6/8课时', '2025-04-01 10:00:00', '2026-06-01 17:15:36');
INSERT INTO `my_student_course` VALUES (3, 1, 3, '2025-02-20 14:00:00', 2, 100, 92.50, '函数专题 - 已完结', '2025-02-20 14:00:00', '2026-06-01 17:15:36');
INSERT INTO `my_student_course` VALUES (4, 1, 4, '2025-05-01 16:00:00', 1, 30, NULL, '化学元素 - 已上3/10课时', '2025-05-01 16:00:00', '2026-06-01 17:15:36');
INSERT INTO `my_student_course` VALUES (5, 2, 1, '2025-03-10 09:00:00', 1, 50, NULL, '物理力学 - 已上6/12课时', '2025-03-10 09:00:00', '2026-06-01 17:15:36');
INSERT INTO `my_student_course` VALUES (6, 2, 2, '2025-04-05 10:00:00', 1, 40, NULL, '英语口语 - 已上4/8课时', '2025-04-05 10:00:00', '2026-06-01 17:15:37');
INSERT INTO `my_student_course` VALUES (7, 2, 3, '2025-03-15 14:00:00', 2, 100, 78.00, '函数专题 - 已完结', '2025-03-15 14:00:00', '2026-06-01 17:15:37');

-- ----------------------------
-- Table structure for my_student_homework
-- ----------------------------
DROP TABLE IF EXISTS `my_student_homework`;
CREATE TABLE `my_student_homework`  (
  `sh_id` bigint NOT NULL AUTO_INCREMENT COMMENT '提交记录ID',
  `stu_id` bigint NOT NULL COMMENT '学生ID',
  `hw_id` bigint NOT NULL COMMENT '作业ID',
  `answers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `score` decimal(5, 2) NULL DEFAULT NULL COMMENT '得分',
  `teacher_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '教师评语',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态 0-未提交 1-已提交 2-已批改',
  `submit_time` datetime NULL DEFAULT NULL COMMENT '提交时间',
  `correct_time` datetime NULL DEFAULT NULL COMMENT '批改时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sh_id`) USING BTREE,
  UNIQUE INDEX `uk_stu_hw`(`stu_id` ASC, `hw_id` ASC) USING BTREE,
  INDEX `idx_hw_id`(`hw_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学生作业提交表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_student_homework
-- ----------------------------
INSERT INTO `my_student_homework` VALUES (1, 1, 1, '', 88.00, '整体不错，注意第三定律的完整表述', 2, '2026-05-25 20:00:00', '2026-05-26 10:00:00', '2026-06-01 17:15:37', '2026-06-02 23:01:26');
INSERT INTO `my_student_homework` VALUES (2, 1, 3, '{\"q1\": \"Hello everyone, I am Chen Xiaoming. I am 15 years old and I like physics very much. I hope to learn more knowledge here.\"}', 85.00, '表达流畅，可以增加一些词汇多样性', 2, '2026-05-26 19:30:00', '2026-05-27 14:00:00', '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_student_homework` VALUES (3, 1, 5, '{\"q1\": \"3\", \"q2\": \"A\", \"q3\": \"与x轴交点(2,0)，与y轴交点(0,-6)\"}', 95.00, '计算准确，思路清晰', 2, '2026-05-22 21:00:00', '2026-05-23 09:00:00', '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_student_homework` VALUES (4, 1, 7, '{\"q1\": \"H、He、Li、Be、B、C、N、O、F、Ne、Na、Mg、Al、Si、P、S、Cl、Ar、K、Ca\"}', 90.00, '前20号元素全对，继续保持', 2, '2026-05-28 18:00:00', '2026-05-29 10:00:00', '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_student_homework` VALUES (5, 2, 1, '{\"q1\": \"A\", \"q2\": \"B\", \"q3\": \"4\", \"q4\": \"作用力与反作用力\"}', 75.00, '第三题计算有误，建议再复习公式', 2, '2026-05-25 22:00:00', '2026-05-26 11:00:00', '2026-06-01 17:15:37', '2026-06-01 17:15:37');

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学生通知阅读记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_student_notification
-- ----------------------------
INSERT INTO `my_student_notification` VALUES (1, 1, 1, 1, '2026-05-25 12:00:00', '2026-06-01 17:15:37');
INSERT INTO `my_student_notification` VALUES (2, 1, 2, 1, '2026-05-26 20:00:00', '2026-06-01 17:15:37');
INSERT INTO `my_student_notification` VALUES (3, 1, 3, 0, NULL, '2026-06-01 17:15:37');
INSERT INTO `my_student_notification` VALUES (4, 1, 4, 1, '2026-05-28 18:00:00', '2026-06-01 17:15:37');
INSERT INTO `my_student_notification` VALUES (5, 2, 1, 1, '2026-05-25 14:00:00', '2026-06-01 17:15:37');
INSERT INTO `my_student_notification` VALUES (6, 2, 4, 0, NULL, '2026-06-01 17:15:37');

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
INSERT INTO `my_student_question` VALUES (3, 1, 3, 8);
INSERT INTO `my_student_question` VALUES (4, 1, 4, 15);
INSERT INTO `my_student_question` VALUES (5, 1, 9, 10);
INSERT INTO `my_student_question` VALUES (6, 1, 10, 10);
INSERT INTO `my_student_question` VALUES (7, 1, 11, 18);
INSERT INTO `my_student_question` VALUES (8, 1, 12, 10);
INSERT INTO `my_student_question` VALUES (9, 1, 13, 10);
INSERT INTO `my_student_question` VALUES (10, 2, 1, 10);
INSERT INTO `my_student_question` VALUES (11, 2, 2, 10);
INSERT INTO `my_student_question` VALUES (12, 2, 3, 5);
INSERT INTO `my_student_question` VALUES (13, 2, 4, 10);

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
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学习记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_study_record
-- ----------------------------
INSERT INTO `my_study_record` VALUES (1, 1, 1, 1, 120, '2026-05-25', 0, '2026-05-25 10:00:00');
INSERT INTO `my_study_record` VALUES (2, 1, 3, 3, 90, '2026-05-26', 0, '2026-05-26 10:00:00');
INSERT INTO `my_study_record` VALUES (3, 1, 1, 1, 150, '2026-05-27', 0, '2026-05-27 10:00:00');
INSERT INTO `my_study_record` VALUES (4, 1, 2, 2, 60, '2026-05-28', 0, '2026-05-28 10:00:00');
INSERT INTO `my_study_record` VALUES (5, 1, 3, 3, 180, '2026-05-29', 0, '2026-05-29 10:00:00');
INSERT INTO `my_study_record` VALUES (6, 1, 1, 1, 90, '2026-05-30', 0, '2026-05-30 10:00:00');
INSERT INTO `my_study_record` VALUES (7, 1, 2, 2, 60, '2026-05-31', 0, '2026-05-31 10:00:00');
INSERT INTO `my_study_record` VALUES (8, 1, 3, 3, 45, '2025-05-24', 0, '2025-05-24 10:30:00');
INSERT INTO `my_study_record` VALUES (9, 1, 1, 1, 60, '2025-05-23', 0, '2025-05-23 20:30:00');
INSERT INTO `my_study_record` VALUES (10, 1, 2, 4, 30, '2025-05-23', 0, '2025-05-23 15:00:00');
INSERT INTO `my_study_record` VALUES (11, 1, 1, 4, 40, '2025-05-22', 0, '2025-05-22 10:00:00');
INSERT INTO `my_study_record` VALUES (12, 1, 3, 3, 60, '2025-05-21', 0, '2025-05-21 14:00:00');
INSERT INTO `my_study_record` VALUES (13, 1, 2, 3, 50, '2025-05-20', 0, '2025-05-20 16:00:00');
INSERT INTO `my_study_record` VALUES (14, 1, 2, 2, 45, '2026-05-18', 0, '2026-05-18 09:00:00');
INSERT INTO `my_study_record` VALUES (15, 1, 1, 1, 90, '2026-05-19', 0, '2026-05-19 10:00:00');
INSERT INTO `my_study_record` VALUES (16, 1, 3, 3, 60, '2026-05-20', 0, '2026-05-20 15:00:00');
INSERT INTO `my_study_record` VALUES (17, 1, 4, 4, 30, '2026-05-21', 0, '2026-05-21 16:00:00');
INSERT INTO `my_study_record` VALUES (18, 2, 1, 1, 60, '2026-05-25', 0, '2026-05-25 14:00:00');
INSERT INTO `my_study_record` VALUES (19, 2, 3, 3, 45, '2026-05-26', 0, '2026-05-26 15:00:00');
INSERT INTO `my_study_record` VALUES (20, 2, 1, 1, 90, '2026-05-27', 0, '2026-05-27 10:00:00');
INSERT INTO `my_study_record` VALUES (21, 2, 2, 2, 30, '2026-05-28', 0, '2026-05-28 16:00:00');

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
  `suggestions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '学习建议',
  `data_json` json NULL COMMENT '详细数据',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`report_id`) USING BTREE,
  UNIQUE INDEX `uk_stu_type_date`(`stu_id` ASC, `report_type` ASC, `report_date` ASC) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学情报表数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_study_report
-- ----------------------------
INSERT INTO `my_study_report` VALUES (1, 1, 1, '2026-05-31', 120, 0, 0, 75.00, 10, '[\"英语语法\", \"物理浮力计算\"]', '[\"一次函数\", \"力学基础\"]', '建议加强英语时态练习和浮力计算', NULL, '2026-06-01 17:15:38');
INSERT INTO `my_study_report` VALUES (2, 1, 2, '2026-05-31', 750, 0, 2, 82.50, 65, '[\"英语不规则动词\", \"化学元素符号\"]', '[\"数学函数\", \"物理牛顿定律\"]', '本周学习状态良好，继续保持！化学元素记忆可多用口诀法', NULL, '2026-06-01 17:15:38');
INSERT INTO `my_study_report` VALUES (3, 1, 3, '2026-05-01', 3000, 1, 8, 85.00, 280, '[\"英语听力\", \"化学反应方程式\"]', '[\"物理力学\", \"数学函数\"]', '本月完成1门课程（函数专题），整体进步明显，下月重点突破英语听力', NULL, '2026-06-01 17:15:38');
INSERT INTO `my_study_report` VALUES (4, 2, 1, '2026-05-31', 90, 0, 0, 65.00, 5, '[\"物理公式运用\", \"数学函数\"]', '[\"基础概念理解\"]', '建议多做练习题巩固公式记忆', NULL, '2026-06-01 17:15:38');
INSERT INTO `my_study_report` VALUES (5, 2, 2, '2026-05-31', 450, 0, 1, 70.00, 25, '[\"物理计算题\", \"英语语法\"]', '[\"基础概念\"]', '本周学习时长较少，建议制定固定学习计划', NULL, '2026-06-01 17:15:38');

-- ----------------------------
-- Table structure for my_sys_user
-- ----------------------------
DROP TABLE IF EXISTS `my_sys_user`;
CREATE TABLE `my_sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名/账号',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码(加密存储)',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像URL',
  `sex` tinyint NULL DEFAULT 0 COMMENT '性别 0-未知 1-男 2-女',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `user_type` tinyint NOT NULL DEFAULT 1 COMMENT '用户类型 1-学生 2-教师 3-管理员',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-禁用 1-启用',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除 0-否 1-是',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE,
  INDEX `idx_user_type`(`user_type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_sys_user
-- ----------------------------
INSERT INTO `my_sys_user` VALUES (1, 'student001', '123456', '陈小明', NULL, 1, 15, '13812345678', 'chenxm@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-06-01 20:44:42', '晨曦中学 初二(3)班学生');
INSERT INTO `my_sys_user` VALUES (2, 'student002', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '李四', NULL, 2, 19, '13800138002', 'student002@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:16', NULL);
INSERT INTO `my_sys_user` VALUES (3, 'teacher001', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '王老师', NULL, 1, 35, '13900139001', 'teacher001@example.com', 2, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:17', NULL);
INSERT INTO `my_sys_user` VALUES (4, 'admin001', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '管理员', NULL, 1, 30, '13700137001', 'admin001@example.com', 3, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:20', NULL);
INSERT INTO `my_sys_user` VALUES (5, 'teacher002', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '张明', NULL, 1, 35, '13900139002', 'teacher002@example.com', 2, 1, 0, '2026-05-29 10:00:00', '2026-05-29 10:00:00', '物理教研组教师');
INSERT INTO `my_sys_user` VALUES (6, 'teacher003', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '王蕾', NULL, 1, 32, '13900139003', 'teacher003@example.com', 2, 1, 0, '2026-05-29 10:00:00', '2026-05-29 10:00:00', '英语教研组教师');
INSERT INTO `my_sys_user` VALUES (7, 'teacher004', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '陈伟', NULL, 1, 40, '13900139004', 'teacher004@example.com', 2, 1, 0, '2026-05-29 10:00:00', '2026-05-29 10:00:00', '数学教研组教师');

-- ----------------------------
-- Table structure for my_task_reminder
-- ----------------------------
DROP TABLE IF EXISTS `my_task_reminder`;
CREATE TABLE `my_task_reminder`  (
  `tr_id` bigint NOT NULL AUTO_INCREMENT COMMENT '提醒ID',
  `stu_id` bigint NOT NULL COMMENT '学生ID',
  `task_type` tinyint NOT NULL COMMENT '任务类型 1-作业截止 2-课程开始 3-自定义',
  `task_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务标题',
  `task_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '任务内容',
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
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务提醒表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_task_reminder
-- ----------------------------
INSERT INTO `my_task_reminder` VALUES (2, 1, 2, '物理课程提醒', '周六下午物理课', '2026-06-01 13:30:00', 2, 0, 1, 1, '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_task_reminder` VALUES (3, 1, 3, '数学作业截止', '完成函数练习册P25-28', '2026-05-30 20:00:00', 0, 0, 1, NULL, '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_task_reminder` VALUES (4, 1, 1, '晨读时间', '英语单词背诵 30分钟', '2026-05-30 07:00:00', 1, 0, 1, NULL, '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_task_reminder` VALUES (5, 1, 2, '数学预习', '预习下一章函数内容', '2026-05-30 14:30:00', 2, 0, 1, 3, '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_task_reminder` VALUES (6, 1, 2, '晚自习提醒', '复习今日所学内容', '2026-05-30 19:00:00', 1, 0, 0, NULL, '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_task_reminder` VALUES (7, 1, 3, '明日计划', '制定第二天的学习计划', '2026-05-30 21:00:00', 1, 0, 1, NULL, '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_task_reminder` VALUES (8, 1, 1, '英语作业提交', '完成英语口语练习并提交', '2026-06-01 20:00:00', 0, 0, 1, 3, '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_task_reminder` VALUES (9, 1, 1, '化学作业提交', '元素周期表默写作业', '2026-06-03 20:00:00', 0, 0, 1, 7, '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_task_reminder` VALUES (10, 1, 2, '英语课程提醒', '周日上午10点英语口语课', '2026-06-01 09:00:00', 2, 0, 1, 2, '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_task_reminder` VALUES (11, 1, 2, '化学课程提醒', '周六下午4点化学课', '2026-06-01 15:00:00', 2, 0, 1, 4, '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_task_reminder` VALUES (12, 1, 3, '复习计划', '复习本周所学物理和数学知识点', '2026-06-01 19:00:00', 2, 0, 1, NULL, '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_task_reminder` VALUES (13, 2, 2, '物理课程提醒', '周六下午物理课', '2026-06-01 13:00:00', 2, 0, 1, 1, '2026-06-01 17:15:37', '2026-06-01 17:15:37');
INSERT INTO `my_task_reminder` VALUES (14, 2, 1, '函数作业提交', '二次函数综合练习', '2026-06-07 23:59:00', 0, 0, 1, 6, '2026-06-01 17:15:37', '2026-06-01 17:15:37');

-- ----------------------------
-- Table structure for my_teacher
-- ----------------------------
DROP TABLE IF EXISTS `my_teacher`;
CREATE TABLE `my_teacher`  (
  `teacher_id` bigint NOT NULL AUTO_INCREMENT COMMENT '教师ID',
  `user_id` bigint NOT NULL COMMENT '关联用户ID',
  `teacher_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工号',
  `department` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所属院系',
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职称',
  `specialty` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专长领域',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`teacher_id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '教师信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_teacher
-- ----------------------------
INSERT INTO `my_teacher` VALUES (1, 3, 'T2024001', '计算机学院', '副教授', '人工智能、机器学习', '2026-05-27 00:13:29', '2026-05-27 00:13:29');
INSERT INTO `my_teacher` VALUES (2, 5, 'T2024002', '物理教研组', '高级教师', '初中物理力学、电学', '2026-05-29 10:00:00', '2026-05-29 10:00:00');
INSERT INTO `my_teacher` VALUES (3, 6, 'T2024003', '英语教研组', '特级教师', '英语口语、语法教学', '2026-05-29 10:00:00', '2026-05-29 10:00:00');
INSERT INTO `my_teacher` VALUES (4, 7, 'T2024004', '数学教研组', '高级教师', '函数、几何专题', '2026-05-29 10:00:00', '2026-05-29 10:00:00');

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日历信息表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '调度器状态表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 134 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-29 20:17:43');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-29 20:20:58');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-29 20:21:33');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-29 20:51:08');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-29 20:51:14');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 15:23:13');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 15:24:40');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 15:27:09');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '1', '验证码错误', '2026-06-01 15:31:17');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 15:31:21');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 15:54:42');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 15:58:17');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 16:01:57');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 16:20:13');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '1', '验证码已失效', '2026-06-01 16:36:45');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 16:36:49');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '1', '验证码已失效', '2026-06-01 16:46:23');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 16:46:25');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '1', '验证码已失效', '2026-06-01 17:06:01');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '1', '验证码错误', '2026-06-01 17:06:05');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '1', '验证码错误', '2026-06-01 17:06:09');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 17:06:13');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '1', '验证码错误', '2026-06-01 17:07:02');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 17:07:08');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 17:16:00');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 18:38:04');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 18:54:22');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 18:59:18');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 19:03:00');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 19:08:12');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 19:09:13');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 19:41:01');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '登录成功', '2026-06-01 19:44:10');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'WeChat 8.0.5', 'iOS 15.0', '0', '退出成功', '2026-06-01 20:09:55');

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
) ENGINE = InnoDB AUTO_INCREMENT = 2000 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-05-29 20:04:53', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-05-29 20:04:53', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-05-29 20:04:53', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2026-05-29 20:04:53', '', NULL, '若依官网地址');
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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公告已读记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice_read
-- ----------------------------
INSERT INTO `sys_notice_read` VALUES (1, 3, 1, '2026-05-29 20:21:40');

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
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
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
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-06-01 19:44:10', '2026-05-29 20:04:53', 'admin', '2026-05-29 20:04:53', '', NULL, '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-05-29 20:04:53', '2026-05-29 20:04:53', 'admin', '2026-05-29 20:04:53', '', NULL, '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
