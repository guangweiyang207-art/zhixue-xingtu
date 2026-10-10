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
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '缂栧彿',
  `table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '琛ㄥ悕绉?,
  `table_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '琛ㄦ弿杩?,
  `sub_table_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鍏宠仈瀛愯〃鐨勮〃鍚?,
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '瀛愯〃鍏宠仈鐨勫閿悕',
  `class_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '瀹炰綋绫诲悕绉?,
  `tpl_category` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'crud' COMMENT '浣跨敤鐨勬ā鏉匡紙crud鍗曡〃鎿嶄綔 tree鏍戣〃鎿嶄綔锛?,
  `tpl_web_type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍓嶇妯℃澘绫诲瀷锛坋lement-ui妯＄増 element-plus妯＄増锛?,
  `package_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鐢熸垚鍖呰矾寰?,
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鐢熸垚妯″潡鍚?,
  `business_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鐢熸垚涓氬姟鍚?,
  `function_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鐢熸垚鍔熻兘鍚?,
  `function_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鐢熸垚鍔熻兘浣滆€?,
  `gen_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '鐢熸垚浠ｇ爜鏂瑰紡锛?zip鍘嬬缉鍖?1鑷畾涔夎矾寰勶級',
  `gen_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/' COMMENT '鐢熸垚璺緞锛堜笉濉粯璁ら」鐩矾寰勶級',
  `options` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鍏跺畠鐢熸垚閫夐」',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍒涘缓鑰?,
  `create_time` datetime NULL DEFAULT NULL COMMENT '鍒涘缓鏃堕棿',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鏇存柊鑰?,
  `update_time` datetime NULL DEFAULT NULL COMMENT '鏇存柊鏃堕棿',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '澶囨敞',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '浠ｇ爜鐢熸垚涓氬姟琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'my_course_resource', '璇剧▼璧勬簮琛?, NULL, NULL, 'MyCourseResource', 'crud', 'element-ui', 'com.ruoyi.business', 'business', 'resource', '璧勬簮妯″潡', 'llhl', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31', NULL);
INSERT INTO `gen_table` VALUES (2, 'my_notification', '閫氱煡琛?, NULL, NULL, 'MyNotification', 'crud', 'element-ui', 'com.ruoyi.business', 'business', 'notification', '閫氱煡妯″潡', 'lhl', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32', NULL);
INSERT INTO `gen_table` VALUES (4, 'my_homework', '浣滀笟琛?, NULL, NULL, 'MyHomework', 'crud', 'element-ui', 'com.ruoyi.system', 'system', 'homework', '浣滀笟', 'ruoyi', '0', '/', NULL, 'admin', '2026-05-31 19:57:04', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (5, 'my_bank', '棰樺簱琛?, NULL, NULL, 'MyBank', 'crud', 'element-ui', 'com.ruoyi.system', 'system', 'bank', '棰樺簱', 'ruoyi', '0', '/', NULL, 'admin', '2026-06-03 15:23:19', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '缂栧彿',
  `table_id` bigint NULL DEFAULT NULL COMMENT '褰掑睘琛ㄧ紪鍙?,
  `column_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鍒楀悕绉?,
  `column_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鍒楁弿杩?,
  `column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鍒楃被鍨?,
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA绫诲瀷',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA瀛楁鍚?,
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏄惁涓婚敭锛?鏄級',
  `is_increment` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏄惁鑷锛?鏄級',
  `is_required` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏄惁蹇呭～锛?鏄級',
  `is_insert` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏄惁涓烘彃鍏ュ瓧娈碉紙1鏄級',
  `is_edit` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏄惁缂栬緫瀛楁锛?鏄級',
  `is_list` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏄惁鍒楄〃瀛楁锛?鏄級',
  `is_query` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏄惁鏌ヨ瀛楁锛?鏄級',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'EQ' COMMENT '鏌ヨ鏂瑰紡锛堢瓑浜庛€佷笉绛変簬銆佸ぇ浜庛€佸皬浜庛€佽寖鍥达級',
  `html_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏄剧ず绫诲瀷锛堟枃鏈銆佹枃鏈煙銆佷笅鎷夋銆佸閫夋銆佸崟閫夋銆佹棩鏈熸帶浠讹級',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '瀛楀吀绫诲瀷',
  `sort` int NULL DEFAULT NULL COMMENT '鎺掑簭',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍒涘缓鑰?,
  `create_time` datetime NULL DEFAULT NULL COMMENT '鍒涘缓鏃堕棿',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鏇存柊鑰?,
  `update_time` datetime NULL DEFAULT NULL COMMENT '鏇存柊鏃堕棿',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '浠ｇ爜鐢熸垚涓氬姟琛ㄥ瓧娈? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 're_id', '璧勬簮ID', 'bigint', 'Long', 'reId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (2, 1, 'c_id', '鍏宠仈璇剧▼ID', 'bigint', 'Long', 'cId', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 2, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (3, 1, 'resource_type', '璧勬簮绫诲瀷 1-瑙嗛 2-鏂囨。 3-鍥句功 4-鏈熷垔 5-璁插骇', 'tinyint', 'Long', 'resourceType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (4, 1, 'title', '璧勬簮鏍囬', 'varchar(200)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (5, 1, 'content', '璧勬簮鍐呭/鎻忚堪', 'text', 'String', 'content', '0', '0', '0', '1', '1', '1', '0', 'LIKE', 'editor', '', 5, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (6, 1, 'file_url', '鏂囦欢閾炬帴', 'varchar(500)', 'String', 'fileUrl', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'textarea', '', 6, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (7, 1, 'video_url', '瑙嗛閾炬帴', 'varchar(500)', 'String', 'videoUrl', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'textarea', '', 7, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (8, 1, 'homework', '浣滀笟鍐呭', 'text', 'String', 'homework', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'textarea', '', 8, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (9, 1, 'sort_order', '鎺掑簭', 'int', 'Long', 'sortOrder', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 9, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (10, 1, 'create_time', NULL, 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (11, 1, 'tag', NULL, 'varchar(255)', 'String', 'tag', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 11, 'admin', '2026-05-30 20:11:41', '', '2026-06-02 16:32:31');
INSERT INTO `gen_table_column` VALUES (12, 2, 'noti_id', '閫氱煡ID', 'bigint', 'Long', 'notiId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (13, 2, 'sender_id', '鍙戦€佽€匢D', 'bigint', 'Long', 'senderId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (14, 2, 'sender_type', '鍙戦€佽€呯被鍨?1-绯荤粺 2-鏁欏笀 3-绠＄悊鍛?, 'tinyint', 'Long', 'senderType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (15, 2, 'title', '閫氱煡鏍囬', 'varchar(200)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (16, 2, 'content', '閫氱煡鍐呭', 'text', 'String', 'content', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'editor', '', 5, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (17, 2, 'target_type', '鐩爣绫诲瀷 1-鍏ㄩ儴 2-鎸囧畾瀛︾敓 3-鎸囧畾鐝骇', 'tinyint', 'Long', 'targetType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 6, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (18, 2, 'target_ids', '鐩爣瀵硅薄ID鍒楄〃', 'json', 'String', 'targetIds', '0', '0', '0', '1', '1', '1', '1', 'EQ', NULL, '', 7, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (19, 2, 'priority', '浼樺厛绾?1-鏅€?2-閲嶈 3-绱ф€?, 'tinyint', 'Long', 'priority', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (20, 2, 'is_top', '鏄惁缃《 0-鍚?1-鏄?, 'tinyint', 'Long', 'isTop', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (21, 2, 'status', '鐘舵€?0-鑽夌 1-宸插彂甯?2-宸叉挙鍥?, 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 10, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (22, 2, 'publish_time', '鍙戝竷鏃堕棿', 'datetime', 'Date', 'publishTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 11, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (23, 2, 'create_time', NULL, 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (24, 2, 'update_time', NULL, 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2026-05-31 16:24:02', '', '2026-05-31 16:26:32');
INSERT INTO `gen_table_column` VALUES (33, 4, 'hw_id', '浣滀笟ID', 'bigint', 'Long', 'hwId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (34, 4, 'std_id', '瀛︾敓ID', 'bigint', 'Long', 'stdId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (35, 4, 'c_id', '璇剧▼ID', 'bigint', 'Long', 'cId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (36, 4, 'teacher_id', '鍙戝竷鏁欏笀ID', 'bigint', 'Long', 'teacherId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (37, 4, 'title', '浣滀笟鏍囬', 'varchar(200)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (38, 4, 'content', '浣滀笟鍐呭', 'text', 'String', 'content', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'editor', '', 6, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (39, 4, 'type', '浣滀笟绫诲瀷 1-瀹㈣棰?2-涓昏棰?3-娣峰悎', 'tinyint', 'Long', 'type', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 7, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (40, 4, 'total_score', '鎬诲垎', 'int', 'Long', 'totalScore', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (41, 4, 'deadline', '鎴鏃堕棿', 'datetime', 'Date', 'deadline', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 9, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (42, 4, 'status', '鐘舵€?0-鑽夌 1-宸插彂甯?2-宸叉埅姝?, 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 10, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (43, 4, 'create_time', NULL, 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (44, 4, 'update_time', NULL, 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2026-05-31 19:57:04', '', NULL);
INSERT INTO `gen_table_column` VALUES (45, 5, 'hb_id', '棰樺簱ID', 'bigint', 'Long', 'hbId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (46, 5, 'qb_name', '棰樺簱鍚嶇О', 'varchar(100)', 'String', 'qbName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (47, 5, 'description', '棰樺簱鎻忚堪', 'text', 'String', 'description', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (48, 5, 'type', '棰樺簱绫诲瀷', 'varchar(30)', 'String', 'type', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 4, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (49, 5, 'tag', '鏍囩', 'varchar(100)', 'String', 'tag', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (50, 5, 'teacher_id', '鍒涘缓鏁欏笀ID', 'bigint', 'Long', 'teacherId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (51, 5, 'question_count', '棰樼洰鏁伴噺', 'int', 'Long', 'questionCount', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (52, 5, 'total_score', '鎬诲垎', 'int', 'Long', 'totalScore', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (53, 5, 'difficulty', '闅惧害 1-绠€鍗?2-涓瓑 3-鍥伴毦', 'tinyint', 'Long', 'difficulty', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (54, 5, 'status', '鐘舵€?0-绂佺敤 1-鍚敤', 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 10, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (55, 5, 'is_public', '鏄惁鍏紑 0-绉佹湁 1-鍏紑', 'tinyint', 'Long', 'isPublic', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (56, 5, 'create_time', NULL, 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2026-06-03 15:23:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (57, 5, 'update_time', NULL, 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2026-06-03 15:23:19', '', NULL);

-- ----------------------------
-- Table structure for my_admin
-- ----------------------------
DROP TABLE IF EXISTS `my_admin`;
CREATE TABLE `my_admin`  (
  `admin_id` bigint NOT NULL AUTO_INCREMENT COMMENT '绠＄悊鍛業D',
  `user_id` bigint NOT NULL COMMENT '鍏宠仈鐢ㄦ埛ID',
  `admin_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '绠＄悊鍛樼紪鍙?,
  `role` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'super' COMMENT '瑙掕壊 super-瓒呯骇绠＄悊鍛?normal-鏅€氱鐞嗗憳',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`admin_id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '绠＄悊鍛樹俊鎭〃' ROW_FORMAT = DYNAMIC;

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
  `chat_id` bigint NOT NULL AUTO_INCREMENT COMMENT '瀵硅瘽ID',
  `stu_id` bigint NULL DEFAULT NULL COMMENT '瀛︾敓ID',
  `teacher_id` bigint NULL DEFAULT NULL COMMENT '鏁欏笀ID',
  `session_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浼氳瘽ID',
  `question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '闂鍐呭',
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '鍥炵瓟鍐呭',
  `question_type` tinyint NULL DEFAULT 1 COMMENT '闂绫诲瀷 1-瀛︿範 2-浣滀笟 3-鍏朵粬',
  `is_satisfied` tinyint NULL DEFAULT NULL COMMENT '鏄惁婊℃剰 0-鍚?1-鏄?,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chat_id`) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE,
  INDEX `idx_session_id`(`session_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'AI闂瓟璁板綍琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_ai_chat
-- ----------------------------
INSERT INTO `my_ai_chat` VALUES (1, 1, 1, 'SESSION_20260529_001', 'Python鍒楄〃濡備綍鍘婚噸锛?, '鍙互浣跨敤set()杞垪琛細list(set(arr))', 1, 1, '2026-06-02 17:29:27');
INSERT INTO `my_ai_chat` VALUES (2, 2, 1, 'SESSION_20260529_002', '浜屽弶鏍戠殑閬嶅巻鏂瑰紡鏈夊摢浜涳紵', '鍓嶅簭銆佷腑搴忋€佸悗搴忋€佸眰搴忛亶鍘?, 1, 0, '2026-06-01 17:29:27');
INSERT INTO `my_ai_chat` VALUES (17, NULL, NULL, 'SESSION_1780496723537', '甯垜鍋氫竴涓涔犺鍒?, '浣犲ソ锛佹垜鏄櫤瀛︽槦閫擜I瀛︿範鍔╂墜銆傚緢楂樺叴涓轰綘鍒跺畾涓€涓珮鏁堛€佺瀛︾殑瀛︿範璁″垝銆傝鍏堝憡璇夋垜浣犵殑**鐩爣銆佸勾绾?闃舵銆佹瘡澶╁彲鐢ㄦ椂闂?*浠ュ強**闇€瑕侀噸鐐圭獊鐮寸殑绉戠洰鎴栨妧鑳?*锛屾垜浼氫负浣犻噺韬畾鍒躲€俓n\n涓嶈繃锛屽鏋滀綘鏆傛椂娌℃湁鎻愪緵璇︾粏淇℃伅锛屾垜鍙互鍏堢粰浣犱竴涓?*閫氱敤鐨勩€佸彲璋冩暣鐨勨€滈珮鏁堝涔犺鍒掓ā鏉库€?*锛屼綘鍙互鐩存帴濂楃敤鎴栨牴鎹嚜韬儏鍐靛井璋冿細\n\n---\n\n### 馃摎 閫氱敤楂樻晥瀛︿範璁″垝妯℃澘锛堝懆璁″垝锛塡n\n#### 鏍稿績鍘熷垯锛氱暘鑼勫伐浣滄硶 + 涓诲姩鍥炲繂 + 瀹氭湡澶嶇洏\n\n**姣忔棩鏃堕棿鍒嗛厤寤鸿锛堜互6灏忔椂鏈夋晥瀛︿範涓轰緥锛夛細**\n\n| 鏃堕棿娈?| 浠诲姟绫诲瀷 | 鍏蜂綋寤鸿 |\n| :--- | :--- | :--- |\n| **07:00-08:00** | **榛勯噾璁板繂鏈?* | 鑳岃鑻辫鍗曡瘝銆佽鏂囧彜璇楄瘝銆佹枃绉戞牳蹇冩蹇碉紙鍒╃敤璁板繂鏇茬嚎锛?|\n| **08:30-11:30** | **娣卞害涓撴敞鏈?* | **鏀诲厠鏈€闅剧鐩?*锛堟暟瀛?鐗╃悊/缂栫▼/涓撲笟鏍稿績璇撅級銆傛瘡25-30鍒嗛挓浼戞伅5鍒嗛挓銆?|\n| **14:00-16:00** | **閫昏緫涓庣粌涔犳湡** | 鍋氫範棰樸€侀敊棰樻暣鐞嗐€佺悊绉戣绠楁垨闃呰鐞嗚В璁粌銆?|\n| **16:30-17:30** | **鎶€鑳戒笌鎷撳睍** | 瀛︿範鏂版妧鑳斤紙濡侾ython銆丳S銆佸璇惉鍔涳級銆侀槄璇昏澶栦功銆?|\n| **19:00-21:00** | **澶嶄範涓庤緭鍑?* | **璐规浖瀛︿範娉?*锛氱敤鑷繁鐨勮瘽澶嶈堪鐧藉ぉ瀛︾殑鍐呭锛涙暣鐞嗛敊棰樻湰锛涘仛灏忔祴璇曘€?|\n| **21:00-22:00** | **杞绘澗鍥為【** | 鐪嬪绉戠邯褰曠墖銆佸惉鐭ヨ瘑鎾銆佸埗瀹氭槑鏃ヨ鍒掋€?|\n\n---\n\n### 馃幆 鍏蜂綋鎵ц姝ラ锛堜互涓€鍛ㄤ负鍗曚綅锛塡n\n**鍛ㄤ竴銆佸懆涓夈€佸懆浜旓細鏍稿績鏀诲潥鏃?*\n- **涓婂崍**锛氭柊鐭ヨ瘑瀛︿範锛堝鏁板鏂扮珷鑺傘€佺墿鐞嗗叕寮忔帹瀵硷級\n- **涓嬪崍**锛氶厤濂楃粌涔?+ 閿欓鍒嗘瀽\n- **鏅氫笂**锛氱敤鎬濈淮瀵煎浘姊崇悊鐭ヨ瘑鐐癸紝骞跺仛涓€閬撶患鍚堟€уぇ棰樸€俓n\n**鍛ㄤ簩銆佸懆鍥涳細鏌ユ紡琛ョ己鏃?*\n- **涓婂崍**锛氬涔犲懆涓€/鍛ㄤ笁鐨勮杽寮辩偣锛岄噸鍋氶敊棰樸€俓n- **涓嬪崍**锛氭俯涔犱箣鍓嶅杩囩殑鍐呭锛堝鎶楅仐蹇橈級锛屽彲鍋氭ā鎷熷嵎銆俓n- **鏅氫笂**锛氭€荤粨鏈懆鏄撻敊棰樺瀷锛屾爣璁伴渶瑕侀棶鑰佸笀鐨勯棶棰樸€俓n\n**鍛ㄥ叚锛氭ā鎷熷疄鎴樻棩**\n- **涓婂崍**锛氬畬鏁村仛涓€濂楃湡棰樻垨妯℃嫙鍗凤紙涓ユ牸闄愭椂锛夈€俓n- **涓嬪崍**锛氭壒鏀广€佸垎鏋愬け鍒嗗師鍥狅紙姣斿仛棰樻洿閲嶈锛夈€俓n- **鏅氫笂**锛氳嚜鐢卞畨鎺掞紙鐪嬬邯褰曠墖銆佸涔犵瑪璁帮級銆俓n\n**鍛ㄦ棩锛氬鐩樹笌寮规€ф棩**\n- **涓婂崍**锛氭暣鐞嗘湰鍛ㄦ墍鏈夐敊棰橈紝褰掔撼鈥滃悓绫婚鈥濊В娉曘€俓n- **涓嬪崍**锛氬洖椤惧懆璁″垝瀹屾垚鎯呭喌锛岃皟鏁翠笅鍛ㄧ瓥鐣ャ€俓n- **鏅氫笂**锛氬交搴曟斁鏉撅紙杩愬姩銆佺數褰便€佺ぞ浜わ級锛屼笉瀹夋帓瀛︿範銆俓n\n---\n\n### 馃摑 鍏抽敭寤鸿锛堥拡瀵逛笉鍚屽満鏅級\n\n1.  **濡傛灉浣犲湪澶囪€冿紙涓珮鑰?鑰冪爺/鑰冭瘉锛夛細**\n    -   姣忓ぉ鑷冲皯鐣欏嚭 **1灏忔椂** 鍋氱湡棰橈紝骞朵弗鏍奸檺鏃躲€俓n    -   寤虹珛 **鈥滈敊棰樻湰鈥?* 锛堢數瀛愭垨绾歌川锛夛紝姣忓懆閲嶅仛涓€娆￠敊棰樸€俓n2.  **濡傛灉浣犳劅鍒版嫋寤讹細**\n    -   浣跨敤 **鈥?绉掓硶鍒欌€?*锛氭兂瀛︿範鏃讹紝鍊掓暟5-4-3-2-1锛岀珛鍒昏鍔ㄣ€俓n    -   鎶婂ぇ鐩爣鎷嗘垚 **鈥滃井浠诲姟鈥?* 锛堝鈥滃彧鍋?閬撻鈥濇垨鈥滆儗5涓崟璇嶁€濓級銆俓n3.  **濡傛灉浣犲鏄撳垎蹇冿細**\n    -   瀛︿範鏃舵墜鏈烘斁鍙︿竴涓埧闂达紝鎴栦娇鐢?**Forest銆佺暘鑼凾odo** 绛堿PP銆俓n    -   淇濇寔妗岄潰鏁存磥锛屽彧鏀惧綋鍓嶇鐩祫鏂欍€俓n\n---\n\n### 馃挕 鐜板湪锛岃鍛婅瘔鎴戜綘鐨勫叿浣撻渶姹傦紒\n\n**涓轰簡缁欎綘鏇寸簿鍑嗙殑璁″垝锛岃鍥炲浠ヤ笅淇℃伅锛堥€夊～锛夛細**\n1.  **褰撳墠韬唤**锛堝锛氬垵涓夈€侀珮涓夈€佸ぇ瀛︾敓銆佽亴鍦鸿€冭瘉锛塡n2.  **鐩爣**锛堝锛氭湡鏈€冭繘骞寸骇鍓?0銆佽€冪爺涓婂哺銆侀€氳繃鑻辫鍏骇锛塡n3.  **姣忓ぉ鍙姇鍏ユ椂闂?*锛堝锛?灏忔椂銆?灏忔椂銆?灏忔椂锛塡n4.  **鏈€璁╀綘澶寸柤鐨勭鐩垨闂**锛堝锛氭暟瀛﹀嚑浣曘€佽嫳璇崟璇嶈涓嶄綇銆佸鏄撹蛋绁烇級\n\n**渚嬪锛?* 鈥滄垜鏄珮涓夊鐢燂紝鐩爣鏄€冧笂985锛屾瘡澶╄兘瀛?灏忔椂锛屾渶澶寸柤鏁板鍘嬭酱棰樺拰鑻辫闃呰鐞嗚В銆傗€漒n\n鏀跺埌浣犵殑淇℃伅鍚庯紝鎴戜細绔嬪埢涓轰綘鐢熸垚涓€浠?*鍖呭惈姣忔棩浠诲姟娓呭崟銆佸懆杩涘害琛ㄥ拰鍏蜂綋璧勬簮鎺ㄨ崘**鐨勪笓灞炶鍒掞紒 馃殌', 1, NULL, '2026-06-03 22:25:47');
INSERT INTO `my_ai_chat` VALUES (18, NULL, NULL, 'SESSION_1780496723537', '甯垜鍋氫竴涓涔犺鍒?, '浣犲ソ锛佹垜鏄櫤瀛︽槦閫擜I瀛︿範鍔╂墜銆傚緢楂樺叴涓轰綘鍒跺畾涓撳睘瀛︿範璁″垝锛侌煄痋n\n涓轰簡缁欎綘閲忚韩瀹氬埗涓€浠?*楂樻晥銆佸彲鎵ц**鐨勮鍒掞紝鎴戦渶瑕佸厛浜嗚В浣犵殑**鍩虹淇℃伅**銆傝鍥炵瓟涓嬮潰鍑犱釜闂锛歕n\n1. **浣犵殑韬唤鏄紵**锛堜緥濡傦細鍒濅腑鐢?楂樹腑鐢?澶у鐢?鑰冪爺/鑰冭瘉/鑱屽満鎶€鑳芥彁鍗囩瓑锛塡n2. **浣犵殑鐩爣鏄粈涔堬紵**锛堜緥濡傦細鏈熸湯鑰冭繘鍓?0鍚?閫氳繃鑻辫鍥涚骇/瀛︿細Python缂栫▼/涓€涓湀鍐呰儗瀹?000璇嶇瓑锛塡n3. **姣忓ぉ鍙姇鍏ョ殑瀛︿範鏃堕棿鏄灏戯紵**锛堜緥濡傦細1-2灏忔椂 / 3-4灏忔椂 / 鍏ㄥぉ澶囪€冿級\n4. **浣犵殑钖勫急绉戠洰鎴栭毦鐐规槸浠€涔堬紵**锛堜緥濡傦細鏁板鍑芥暟涓嶇悊瑙?鑻辫闃呰閫熷害鎱?娉ㄦ剰鍔涘鏄撳垎鏁ｇ瓑锛塡n\n---\n\n**鍦ㄤ綘鍥炲涔嬪墠锛屾垜鍏堢粰浣犱竴涓€氱敤鐨勨€滃闇哥骇瀛︿範璁″垝妯℃澘鈥濓紝浣犲彲浠ュ弬鑰冭皟鏁达細**\n\n### 馃搮 姣忔棩鏃堕棿琛紙绀轰緥锛氫互楂樹腑鐢熶负渚嬶級\n| 鏃堕棿娈?| 浠诲姟 | 澶囨敞 |\n|--------|------|------|\n| 06:30-07:00 | 鏅ㄨ锛堣嫳璇崟璇?璇枃鍙よ瘲璇嶏級 | 澶у０鏈楄锛屾縺娲诲ぇ鑴?|\n| 12:30-13:00 | 鍗堥棿澶嶄範锛堥敊棰樺洖椤?鐭ヨ瘑鐐规⒊鐞嗭級 | 鍒╃敤纰庣墖鏃堕棿 |\n| 19:00-20:30 | 娣卞害鏀诲厠锛堟暟瀛?鐗╃悊绛夌悊绉戯級 | 鍋?-3閬撶患鍚堥+鎬荤粨 |\n| 20:40-21:40 | 鏂囩鑳岃/闃呰锛堣嫳璇?璇枃/鍘嗗彶锛?| 缁撳悎鎬濈淮瀵煎浘璁板繂 |\n| 21:40-22:00 | 澶嶇洏+鏄庢棩璁″垝 | 鍐欎笅3涓€滀粖鏃ユ敹鑾封€?|\n\n### 鈿?鏍稿績鍘熷垯锛堝緢閲嶈锛侊級\n1. **鐣寗宸ヤ綔娉?*锛氭瘡瀛︿範25鍒嗛挓锛屼紤鎭?鍒嗛挓锛屼繚鎸佷笓娉ㄣ€俓n2. **璐规浖瀛︿範娉?*锛氭妸鍒氬鐨勭煡璇嗙偣鍋囪鈥滆缁欏悓妗屽惉鈥濓紝鍗″３鐨勫湴鏂瑰氨鏄紡娲炪€俓n3. **閿欓浼樺厛**锛氭瘡鍛ㄨ姳2灏忔椂涓撻棬閲嶅仛閿欓鏈笂鐨勯锛屾晥鏋滆繙澶т簬鍒?0寮犳柊鍗峰瓙銆俓n\n---\n\n**鐜板湪璇峰憡璇夋垜浣犵殑鍏蜂綋鎯呭喌锛屾垜浼氱珛鍒讳负浣犵敓鎴愪竴浠解€滃悕瀛椾笓灞炩€濈殑璇︾粏璁″垝锛?* 馃殌', 1, NULL, '2026-06-03 22:26:20');
INSERT INTO `my_ai_chat` VALUES (19, NULL, NULL, 'SESSION_1780497076413', '浣犳湁浠€涔堝姛鑳?, '浣犲ソ锛佹垜鏄櫤瀛︽槦閫擜I瀛︿範鍔╂墜锛屽緢楂樺叴涓轰綘鏈嶅姟锛佹垜鐨勫姛鑳戒富瑕佸寘鎷互涓嬪嚑涓柟闈細\n\n1. **瀛︿範杈呭**  \n   - 瑙ｇ瓟鍚勫绉戦棶棰橈紙鏁板銆佽鏂囥€佽嫳璇€佺瀛︾瓑锛夛紝鎻愪緵瑙ｉ鎬濊矾銆佺煡璇嗙偣璁茶В銆? \n   - 甯姪鍒跺畾瀛︿範璁″垝锛屾帹鑽愬涔犳柟娉曪紙濡傝蹇嗘妧宸с€佹椂闂寸鐞嗭級銆? \n\n2. **浣滀笟涓庤€冭瘯鏀寔**  \n   - 鍒嗘瀽閿欓鍘熷洜锛岀敓鎴愬悓绫荤粌涔犻宸╁浐鐭ヨ瘑銆? \n   - 妯℃嫙鑰冭瘯棰樼洰锛屾彁渚涚瓟妗堣В鏋愬拰璇勫垎寤鸿銆? \n\n3. **鐭ヨ瘑鎷撳睍**  \n   - 瑙ｉ噴姒傚康銆佸巻鍙蹭簨浠躲€佺瀛﹀師鐞嗙瓑锛屾敮鎸佽法瀛︾鍏宠仈瀛︿範銆? \n   - 鎻愪緵璇惧闃呰鎺ㄨ崘锛堜功绫嶃€佹枃绔犮€佺邯褰曠墖绛夛級銆? \n\n4. **瀛︿範宸ュ叿**  \n   - 鐢熸垚鎬濈淮瀵煎浘銆佺煡璇嗙偣鎬荤粨銆佸涔犳彁绾层€? \n   - 杈呭姪鍐欎綔锛堜綔鏂囨彁绾层€佽娉曚慨鏀广€佽嫳鏂囨鼎鑹诧級銆? \n\n5. **涓€у寲瀛︿範**  \n   - 鏍规嵁浣犵殑瀛︿範杩涘害鍜岃杽寮辩偣锛岃皟鏁村唴瀹归毦搴︺€? \n   - 鏀寔瀵硅瘽寮忚拷闂紝娣卞叆瑙ｇ瓟鐤戦棶銆? \n\n6. **鍏朵粬瀹炵敤鍔熻兘**  \n   - 璇█瀛︿範锛堢炕璇戙€佸崟璇嶈蹇嗐€佸彛璇粌涔狅級銆? \n   - 缂栫▼鍏ラ棬鎸囧锛圥ython銆丣ava绛夊熀纭€浠ｇ爜瑙ｆ瀽锛夈€? \n\n**娉ㄦ剰**锛氭垜鏃犳硶鐩存帴鑱旂綉鎼滅储锛堥櫎闈炰綘鎵嬪姩寮€鍚仈缃戝姛鑳斤級锛屼絾浼氬敖鍔涚敤宸叉湁鐭ヨ瘑鎻愪緵鍑嗙‘淇℃伅銆傚鏋滄湁鍏蜂綋闂鎴栭渶姹傦紝闅忔椂鍛婅瘔鎴戯紝鎴戜滑涓€璧锋敾鍏嬪涔犻毦鍏筹紒 馃摎鉁?, 1, NULL, '2026-06-03 22:31:34');
INSERT INTO `my_ai_chat` VALUES (20, NULL, NULL, 'SESSION_1780499385568', '浠婂ぉ鏄嚑鍙?, '鎶辨瓑锛屾垜鏃犳硶瀹炴椂鑾峰彇褰撳墠鏃ユ湡鍜屾椂闂淬€傚缓璁偍鏌ョ湅鎵嬫満銆佺數鑴戞垨鏃堕挓涓婄殑鏃ユ湡鏄剧ず銆傚鏋滄偍鏈夊叾浠栧涔犻棶棰橈紝娆㈣繋闅忔椂闂垜锛?, 1, NULL, '2026-06-03 23:09:55');
INSERT INTO `my_ai_chat` VALUES (21, NULL, NULL, 'SESSION_1780499385568', '浣犵煡閬撲竴浜涙瘮杈冨嚭鍚嶇殑鐗╃悊瀛﹀鍚?, '褰撶劧锛屼互涓嬫槸鍑犱綅涓栫晫钁楀悕鐨勭墿鐞嗗瀹跺強鍏朵富瑕佽础鐚細\n\n1. **鑹捐惃鍏嬄风墰椤?*  \n   - 缁忓吀鍔涘濂犲熀浜猴紝鎻愬嚭鐗涢】杩愬姩瀹氬緥鍜屼竾鏈夊紩鍔涘畾寰嬨€俓n\n2. **闃垮皵浼壒路鐖卞洜鏂潶**  \n   - 鎻愬嚭鐩稿璁猴紙鐙箟涓庡箍涔夛級鍜岃川鑳芥柟绋?\\(E=mc^2\\)锛屽閲忓瓙鐞嗚涔熸湁閲嶈璐＄尞銆俓n\n3. **灏煎皵鏂风幓灏?*  \n   - 閲忓瓙鍔涘鍏堥┍锛屾彁鍑哄師瀛愮粨鏋勬ā鍨嬶紙鐜诲皵妯″瀷锛夊拰浜掕ˉ鍘熺悊銆俓n\n4. **鐜涗附路灞呴噷**  \n   - 鏀惧皠鎬х爺绌跺厛椹憋紝鍙戠幇閽嬪拰闀厓绱狅紝涓ゆ鑾峰緱璇鸿礉灏斿锛堢墿鐞嗐€佸寲瀛︼級銆俓n\n5. **鐞嗘煡寰仿疯垂鏇?*  \n   - 閲忓瓙鐢靛姩鍔涘濂犲熀浜轰箣涓€锛屾彁鍑鸿垂鏇煎浘锛屾搮闀跨敤閫氫織璇█瑙ｉ噴鐗╃悊銆俓n\n6. **瑭瑰鏂峰厠鎷夊厠路楹﹀厠鏂煢**  \n   - 缁熶竴鐢电瀛︼紝鎻愬嚭楹﹀厠鏂煢鏂圭▼缁勶紝棰勮█鐢电娉㈠瓨鍦ㄣ€俓n\n7. **浼藉埄鐣ヂ蜂冀鍒╅浄**  \n   - 鐜颁唬绉戝鏂规硶涔嬬埗锛岄€氳繃瀹為獙鍜岃娴嬫帹缈讳簹閲屽＋澶氬痉鐗╃悊瀛︺€俓n\n8. **鏂拏鑺烽湇閲?*  \n   - 鐮旂┒榛戞礊鍜屽畤瀹欏锛屾彁鍑洪湇閲戣緪灏勶紝绉戞櫘钁椾綔銆婃椂闂寸畝鍙层€嬪奖鍝嶆繁杩溿€俓n\n杩欎簺鐗╃悊瀛﹀鐨勮础鐚瀹氫簡鐜颁唬鐗╃悊瀛︾殑鍩虹煶锛屾帹鍔ㄤ簡浜虹被瀵硅嚜鐒惰寰嬬殑鐞嗚В銆傚鏋滀綘瀵规煇浣嶇瀛﹀鐨勫叿浣撶悊璁烘垨鏁呬簨鎰熷叴瓒ｏ紝鍙互杩涗竴姝ユ帰璁紒', 1, NULL, '2026-06-03 23:10:18');
INSERT INTO `my_ai_chat` VALUES (22, NULL, NULL, 'SESSION_1780503684409', '浣犵敤鐨勪粈涔堟ā鍨?, '鎴戞槸鏅哄鏄熼€擜I瀛︿範鍔╂墜锛屽熀浜庢繁搴﹀涔犳妧鏈瀯寤猴紝鍏蜂綋妯″瀷鐢辩爺鍙戝洟闃熶紭鍖栬璁★紝浠ユ彁渚涢珮鏁堛€佸噯纭殑瀛︿範杈呭鏈嶅姟銆傚鏋滄偍鏈夊叿浣撶殑瀛︾闂鎴栧涔犻渶姹傦紝娆㈣繋闅忔椂鎻愰棶锛屾垜浼氬敖鍔涘崗鍔╋紒', 1, NULL, '2026-06-04 00:22:05');
INSERT INTO `my_ai_chat` VALUES (23, NULL, NULL, 'SESSION_1780504373174', '浣犳湁鍚嶅瓧鍚?, '浣犲ソ锛佹垜鏄櫤瀛︽槦閫擜I瀛︿範鍔╂墜锛屼綘鍙互鍙垜**灏忔櫤**鎴栬€?*鏄熼€?*銆傝繖鏍风О鍛艰捣鏉ユ洿浜插垏锛屼篃鏂逛究鎴戜滑浜掑姩銆傚鏋滀綘鏈夊叾浠栧枩娆㈢殑鍚嶅瓧锛屼篃鍙互闅忔椂鍛婅瘔鎴戝摝锝?馃槉\n\n鏈変粈涔堝涔犱笂鐨勯棶棰橀渶瑕佹垜甯繖鍚楋紵', 1, NULL, '2026-06-04 00:35:04');
INSERT INTO `my_ai_chat` VALUES (24, NULL, NULL, 'SESSION_1780504563831', '浣犲ソ', '浣犲ソ锛佹垜鏄櫤瀛︽槦閫擜I瀛︿範鍔╂墜锛屽緢楂樺叴涓轰綘鏈嶅姟銆傛棤璁烘槸瀛︿範涓婄殑鐤戦棶銆佺煡璇嗘帰绱紝杩樻槸闇€瑕佽鍒掑涔犺矾寰勶紝鎴戦兘浼氬叏鍔涘崗鍔╀綘銆傝闅忔椂鍛婅瘔鎴戜綘鐨勯渶姹傦紝璁╂垜浠竴璧峰紑鍚珮鏁堝涔犱箣鏃呭惂锛侌煂?, 1, NULL, '2026-06-04 00:36:15');
INSERT INTO `my_ai_chat` VALUES (25, NULL, NULL, 'SESSION_1780504563831', '涓€骞存湁澶氬皯澶?, '閫氬父鎯呭喌涓嬶紝涓€骞存湁 **365澶?*銆備絾濡傛灉鏄?**闂板勾**锛屽垯鏈?**366澶?*锛堝鍑?鏈?9鏃ヨ繖涓€澶╋級銆傞棸骞翠竴鑸槸鑳借4鏁撮櫎鐨勫勾浠斤紝浣嗘暣鐧惧勾浠藉繀椤昏兘琚?00鏁撮櫎鎵嶆槸闂板勾銆備緥濡傦紝2024骞存槸闂板勾锛岃€?900骞翠笉鏄€?, 1, NULL, '2026-06-04 00:36:29');
INSERT INTO `my_ai_chat` VALUES (26, NULL, NULL, 'SESSION_1780567017855', '浣犵煡閬撴椂浠ｅ皯骞村洟鍚?, '褰撶劧鐭ラ亾锛佹椂浠ｅ皯骞村洟锛圱eens in Times锛岀畝绉癟NT锛夋槸涓浗鍐呭湴鐨勪竴鏀敺瀛愭紨鍞辩粍鍚堬紝鐢辨椂浠ｅ嘲宄讳簬2019骞存帹鍑恒€傛垚鍛樺寘鎷┈鍢夌ズ銆佷竵绋嬮懌銆佸畫浜氳僵銆佸垬鑰€鏂囥€佸紶鐪熸簮銆佷弗娴╃繑銆佽春宄婚湒涓冧綅灏戝勾銆備粬浠互闈掓槬娲诲姏鐨勫舰璞″拰澶氬厓鍖栫殑闊充箰椋庢牸锛堝娴佽銆佽垶鏇层€丷&B绛夛級鍙楀埌骞挎硾鍏虫敞锛屼唬琛ㄤ綔鍝佹湁銆婄垎绫宠姳銆嬨€婃棤灏界殑鍐掗櫓銆嬨€婂濮愮湡婕備寒銆嬬瓑銆傜粍鍚堝悕瀵撴剰鈥滃皯骞翠互鏃朵唬涓鸿垶鍙帮紝杩介€愭ⅵ鎯充笌鎴愰暱鈥濓紝鍦ㄩ潚灏戝勾缇や綋涓嫢鏈夎緝楂樹汉姘斻€傚鏋滀綘瀵逛粬浠殑闊充箰銆佺患鑹烘垨鎴愰暱鏁呬簨鎰熷叴瓒ｏ紝鍙互杩涗竴姝ヤ氦娴佸摝锛?, 1, NULL, '2026-06-04 17:57:55');
INSERT INTO `my_ai_chat` VALUES (27, NULL, NULL, 'SESSION_1780567017855', '浣犵煡閬撲粈涔堟椂闂寸嚎涔嬪墠鐨勪俊鎭?, '浣犲ソ锛屾垜鏄櫤瀛︽槦閫擜I瀛︿範鍔╂墜锛屽緢楂樺叴涓轰綘瑙ｇ瓟闂锛佸叧浜庢垜鐨勭煡璇嗘洿鏂版儏鍐碉紝鎴戠殑璁粌鏁版嵁娑电洊浜嗘埅鑷?*2025骞?鏈?*鐨勪俊鎭€備篃灏辨槸璇达紝瀵逛簬2025骞?鏈堜箣鍓嶇殑浜嬩欢銆佺煡璇嗐€佹妧鏈瓑锛屾垜閮借兘涓轰綘鎻愪緵鍙傝€冨拰瑙ｇ瓟銆傚綋鐒讹紝瀵逛簬涔嬪悗鐨勬柊鍔ㄦ€侊紝鎴戝彲鑳芥棤娉曠洿鎺ョ粰鍑烘渶鏂颁俊鎭紝浣嗗彲浠ュ熀浜庡凡鏈夌殑鐭ヨ瘑涓轰綘鍒嗘瀽鍜屾帹娴嬨€傚鏋滀綘鏈夊叿浣撻棶棰橈紝闅忔椂鍛婅瘔鎴戯紝鎴戜細灏藉姏甯綘鎵惧埌绛旀锛?, 1, NULL, '2026-06-04 17:58:36');
INSERT INTO `my_ai_chat` VALUES (28, NULL, NULL, 'SESSION_1780567017855', '鍞愬畫鍏ぇ瀹?, '鍞愬畫鍏ぇ瀹舵槸鍞愪唬鍜屽畫浠ｅ叓浣嶈憲鍚嶆暎鏂囧鐨勫悎绉帮紝浠栦滑鍦ㄤ腑鍥芥枃瀛﹀彶涓婂叿鏈夐噸瑕佸湴浣嶏紝瀵瑰悗涓栨暎鏂囧彂灞曞奖鍝嶆繁杩溿€傚叿浣撳寘鎷細\n\n**鍞愪唬涓や綅锛?*\n1. **闊╂剤**锛?68-824锛夛細瀛楅€€涔嬶紝鑷О鈥滈儭鏈涙槍榛庘€濓紝涓栫О鈥滈煩鏄岄粠鈥濄€備粬鏄攼浠ｅ彜鏂囪繍鍔ㄧ殑鍊″鑰咃紝涓诲紶鈥滄枃浠ヨ浇閬撯€濓紝寮鸿皟鏂囩珷鍐呭涓庡舰寮忕殑缁熶竴銆備唬琛ㄤ綔鏈夈€婂笀璇淬€嬨€婅繘瀛﹁В銆嬨€婃潅璇淬€嬬瓑銆俓n2. **鏌冲畻鍏?*锛?73-819锛夛細瀛楀瓙鍘氾紝涓栫О鈥滄煶娌充笢鈥濄€備笌闊╂剤鍏卞悓鎺ㄥ姩鍙ゆ枃杩愬姩锛屾搮闀垮北姘存父璁板拰瀵撹█灏忓搧銆備唬琛ㄤ綔鏈夈€婃案宸炲叓璁般€嬨€婃崟铔囪€呰銆嬨€婇粩涔嬮┐銆嬬瓑銆俓n\n**瀹嬩唬鍏綅锛?*\n3. **娆ч槼淇?*锛?007-1072锛夛細瀛楁案鍙旓紝鍙烽唹缈侊紝鏅氬勾鍙峰叚涓€灞呭＋銆傚寳瀹嬫枃鍧涢琚栵紝缁ф壙闊╂剤鍙ゆ枃浼犵粺锛屼富寮犫€滄槑閬撹嚧鐢ㄢ€濄€備唬琛ㄤ綔鏈夈€婇唹缈佷涵璁般€嬨€婄澹拌祴銆嬨€婃湅鍏氳銆嬬瓑銆俓n4. **鑻忔吹**锛?009-1066锛夛細瀛楁槑鍏侊紝鍙疯€佹硥銆傝嫃杞笺€佽嫃杈欎箣鐖讹紝鎿呴暱鏀胯鍜屽彶璁猴紝鏂囬闆勫仴銆備唬琛ㄤ綔鏈夈€婂叚鍥借銆嬨€婄浠茶銆嬬瓑銆俓n5. **鑻忚郊**锛?037-1101锛夛細瀛楀瓙鐬伙紝鍙蜂笢鍧″眳澹€傛枃瀛﹁壓鏈叏鎵嶏紝鏁ｆ枃銆佽瘲璇嶃€佷功鐢荤殕绮俱€傛暎鏂囨皵鍔跨绀达紝鑷劧娲掕劚銆備唬琛ㄤ綔鏈夈€婅丹澹佽祴銆嬨€婂悗璧ゅ璧嬨€嬨€婄煶閽熷北璁般€嬬瓑銆俓n6. **鑻忚緳**锛?039-1112锛夛細瀛楀瓙鐢憋紝鍙烽婊ㄩ仐鑰併€傛暎鏂囬鏍兼豹娲嬫竟娉婏紝涓庣埗鍏勫苟绉扳€滀笁鑻忊€濄€備唬琛ㄤ綔鏈夈€婇粍宸炲揩鍝変涵璁般€嬨€婁笂鏋㈠瘑闊╁お灏変功銆嬬瓑銆俓n7. **鏇惧珐**锛?019-1083锛夛細瀛楀瓙鍥猴紝涓栫О鈥滃崡涓板厛鐢熲€濄€傛枃绔犻鏍兼烦鏈达紝绔犳硶涓ヨ皑锛岄暱浜庡彶璁恒€備唬琛ㄤ綔鏈夈€婂ⅷ姹犺銆嬨€婇啋蹇冧涵璁般€嬬瓑銆俓n8. **鐜嬪畨鐭?*锛?021-1086锛夛細瀛椾粙鐢紝鍙峰崐灞便€傛斂娌诲銆佹敼闈╁锛屾暎鏂囦互璁瑙侀暱锛岄€昏緫涓ュ瘑銆備唬琛ㄤ綔鏈夈€婃父瑜掔灞辫銆嬨€婄瓟鍙搁┈璋忚涔︺€嬨€婁激浠叉案銆嬬瓑銆俓n\n**鏍稿績鍦颁綅锛?* 鍞愬畫鍏ぇ瀹朵唬琛ㄤ簡鍞愬畫鍙ゆ枃杩愬姩鐨勬渶楂樻垚灏憋紝浠栦滑鍙嶅楠堟枃娴崕锛屽€″瀹炵敤銆佽嚜鐒剁殑鏁ｆ枃椋庢牸锛屽瀹氫簡涓浗鍙や唬鏁ｆ枃鐨勫吀鑼冦€傚叾涓紝闊╂剤琚皧涓衡€滄枃璧峰叓浠ｄ箣琛扳€濓紝鑻忚郊鍒欒瑾変负鈥滄枃鏇叉槦涓嬪嚒鈥濄€?, 1, NULL, '2026-06-04 18:00:17');
INSERT INTO `my_ai_chat` VALUES (29, NULL, NULL, 'SESSION_1780567017855', '缁欐垜鎺ㄨ崘涓€閮ㄤ紭绉€鐨勬棩鏈姩婕?, '浣滀负鏅哄鏄熼€擜I瀛︿範鍔╂墜锛屾垜鎺ㄨ崘涓€閮ㄥ吋鍏锋繁搴︿笌濞变箰鎬х殑鏃ユ湰鍔ㄦ极鈥斺€斻€婂懡杩愮煶涔嬮棬銆嬶紙Steins;Gate锛夈€備互涓嬫槸鎺ㄨ崘鐞嗙敱锛歕n\n1. **鍓ф儏璁惧畾**锛氫互鏃堕棿鏃呰銆佸洜鏋滃緥鍜岀瀛︿鸡鐞嗕负鏍稿績锛岃杩颁竴缇ゅぇ瀛︾敓鍋剁劧鍙戞槑浜嗚兘鍚戣繃鍘诲彂閫佺煭淇＄殑瑁呯疆锛屽紩鍙戣繛閿佸弽搴斿拰浜烘€ц€冮獙銆傞€昏緫涓ュ瘑锛屼紡绗旂簿宸э紝鍚庢湡鍓ф儏鍙嶈浆浠や汉闇囨捈銆俓n\n2. **瑙掕壊濉戦€?*锛氫富瑙掑唸閮ㄤ鸡澶儙浠庘€滀腑浜岀梾鈥濈瀛﹀鎴愰暱涓鸿儗璐熻矗浠荤殑鏁戜笘涓伙紝閰嶈濡傚姪鎵嬬墽婵戠孩鑾夋爾銆佺湡鐢辩悊绛夊舰璞′赴婊★紝鎯呮劅鍒荤敾缁嗚吇銆俓n\n3. **涓婚娣卞害**锛氭帰璁ㄢ€滄敼鍙樿繃鍘讳笌鏈潵鈥濈殑浠ｄ环銆佽蹇嗕笌鐪熷疄鐨勫叧绯伙紝浠ュ強绉戝鎺㈢储涓殑閬撳痉鍥板锛岄€傚悎鍠滄鎬濊€冪殑瑙備紬銆俓n\n4. **瀛︿範浠峰€?*锛氭秹鍙婄浉瀵硅銆侀噺瀛愮墿鐞嗙瓑绉戝姒傚康锛堣櫧缁忚壓鏈姞宸ワ級锛屽彲婵€鍙戝绉戝鍜屽摬瀛︾殑鍏磋叮銆傚缓璁鐪嬫椂缁撳悎鍓ф儏鎬濊€冣€滆澊铦舵晥搴斺€濃€滆娴嬭€呮晥搴斺€濈瓑鐞嗚銆俓n\n5. **閫傚悎浜虹兢**锛氬亸濂芥偓鐤戙€佺骞汇€佹參鐑瀷鍙欎簨鐨勮浼楋紙鍓?2闆嗛摵鍨紝鍚?2闆嗙垎鍙戯級銆傛棤杩囧垎鏆村姏鎴栦綆淇楀唴瀹癸紝閫傚悎楂樹腑鐢熷強浠ヤ笂骞撮緞娈点€俓n\n**娓╅Θ鎻愮ず**锛氳嫢鏃堕棿鏈夐檺锛屽彲鍏堣鐪嬪墽鍦虹増銆婂懡杩愮煶涔嬮棬锛氳礋鑽烽鍩熺殑鏃㈣鎰熴€嬫垨TV鐗堢1銆?3銆?3闆嗗揩閫熶簡瑙ｆ牳蹇冭瀹氾紝浣嗗己鐑堝缓璁畬鏁磋鐪嬩互浣撲細瀹屾暣鎮枒璁捐銆? \n\n甯屾湜杩欓儴浣滃搧鑳藉甫缁欎綘鍚彂涓庝箰瓒ｏ紒濡傛湁鍏朵粬闇€姹傦紝娆㈣繋缁х画鎻愰棶銆?, 1, NULL, '2026-06-04 18:01:27');
INSERT INTO `my_ai_chat` VALUES (30, NULL, NULL, 'SESSION_1780567017855', '浠婂ぉ鐑偣娑堟伅', '鎴嚦2025骞?鏈?3鏃ワ紝浠婃棩鐑偣娑堟伅涓昏闆嗕腑鍦ㄤ互涓嬮鍩燂細\n\n1. **绉戞妧**锛氬崕涓哄彂甯冩柊涓€浠ｈ嚜鐮旇姱鐗団€滈簰楹?100鈥濓紝鎬ц兘杈冨墠浠ｆ彁鍗?0%锛屽凡搴旂敤浜庢渶鏂版棗鑸版墜鏈虹郴鍒椼€? \n2. **缁忔祹**锛氬浗瀹剁粺璁″眬鍏竷4鏈堣妯′互涓婂伐涓氫紒涓氬埄娑﹀悓姣斿闀?.2%锛屽埗閫犱笟涓庢柊鑳芥簮琛屼笟琛ㄧ幇绐佸嚭銆? \n3. **鍥介檯**锛氳仈鍚堝浗姘斿€欏ぇ浼氳揪鎴愭柊鍑忔帓鍗忚锛屼富瑕佺粡娴庝綋鎵胯2035骞村墠灏嗙⒊鎺掓斁閲忓噺灏?0%銆? \n4. **绀句細**锛氭暀鑲查儴瀹ｅ竷灏嗕汉宸ユ櫤鑳借绋嬬撼鍏ヤ腑灏忓蹇呬慨璇撅紝2026骞寸瀛ｈ捣閫愭瀹炴柦銆? \n5. **浣撹偛**锛氫腑鍥藉コ瓒冲湪浜氭床鏉崐鍐宠禌涓互3:1鍑昏触鏃ユ湰闃燂紝鏅嬬骇鍐宠禌銆? \n\n濡傞渶鏇磋缁嗚В璇绘垨鐗瑰畾棰嗗煙淇℃伅锛屽彲杩涗竴姝ヨ鏄庛€?, 1, NULL, '2026-06-04 18:01:59');
INSERT INTO `my_ai_chat` VALUES (31, NULL, NULL, 'SESSION_1780567846305', '浠婂ぉ鐨勬棩鏈?, '浠婂ぉ鏄?025骞?鏈?1鏃ャ€?, 1, NULL, '2026-06-04 18:11:01');
INSERT INTO `my_ai_chat` VALUES (32, NULL, NULL, 'SESSION_1780567846305', '浠婂ぉ鐨勫寳浜椂闂?, '寰堟姳姝夛紝鎴戞棤娉曡幏鍙栧綋鍓嶇殑瀹炴椂鏃堕棿銆傚缓璁綘鏌ョ湅鎵嬫満銆佺數鑴戞垨鎵嬭〃涓婄殑鏃堕棿鏄剧ず銆傚鏋滀綘鏈夊叾浠栧涔犻棶棰橈紝鎴戝緢涔愭剰甯綘瑙ｇ瓟锛?, 1, NULL, '2026-06-04 18:11:44');
INSERT INTO `my_ai_chat` VALUES (33, NULL, NULL, 'SESSION_1780568122075', '浠婂ぉ鐨勫寳浜椂闂?, '鏍规嵁鑱旂綉鎼滅储缁撴灉锛岀洰鍓嶆病鏈夌洿鎺ユ彁渚涒€滀粖澶╃殑鍏蜂綋鍖椾含鏃堕棿鈥濈殑瀹炴椂淇℃伅銆備笉杩囷紝鎴戝彲浠ュ憡璇変綘锛屽寳浜椂闂存槸涓滃叓鍖猴紙UTC+8锛夌殑鏍囧噯鏃堕棿锛岄€氬父鍙互閫氳繃鎵嬫満銆佺數鑴戞垨鍦ㄧ嚎鏃堕挓锛堝time.is锛夎幏鍙栫簿纭殑褰撳墠鏃堕棿銆俓n\n濡傛灉浣犻渶瑕佸疄鏃舵椂闂达紝寤鸿鏌ョ湅璁惧涓婄殑鏃堕挓鎴栬闂潈濞佹椂闂寸綉绔欙紙濡倀ime.is锛夈€傛湁鍏朵粬瀛︿範闂鍚楋紵鎴戝緢涔愭剰甯繖锛?, 1, NULL, '2026-06-04 18:15:40');
INSERT INTO `my_ai_chat` VALUES (34, NULL, NULL, 'SESSION_1780568122075', '浠婂ぉ鐨勫寳浜椂闂?, '鎶辨瓑锛屾垜鐩墠娌℃湁鑾峰彇瀹炴椂鏃堕棿鐨勮兘鍔涖€備笉杩囨垜鍙互鍛婅瘔浣狅細\n\n**鍖椾含鏃堕棿**閫氬父鏄寚涓浗鏍囧噯鏃堕棿锛圕ST锛孶TC+8锛夈€傚鏋滀綘鎯虫煡璇㈠綋鍓嶇殑鍑嗙‘鍖椾含鏃堕棿锛屽彲浠ラ€氳繃浠ヤ笅鏂瑰紡锛歕n\n1. **鎵嬫満鎴栫數鑴?*锛氱洿鎺ユ煡鐪嬭澶囦笂鐨勬椂闂存樉绀篭n2. **鎼滅储寮曟搸**锛氬湪鐧惧害鎴栬胺姝屾悳绱⑩€滃寳浜椂闂粹€漒n3. **瀹樻柟鏃堕棿缃戠珯**锛氳闂浗瀹舵巿鏃朵腑蹇冪綉绔欙紙time.ac.cn锛塡n\n濡傛灉浣犻渶瑕佹垜甯綘璁＄畻鏃堕棿宸垨鍋氭椂闂寸浉鍏崇殑瀛︿範棰樼洰锛岄殢鏃跺憡璇夋垜锛侌煒?, 1, NULL, '2026-06-04 18:16:12');
INSERT INTO `my_ai_chat` VALUES (35, NULL, NULL, 'SESSION_1780568434847', '浠婂ぉ鐨勫寳浜椂闂?, '鎶辨瓑锛屾垜鏃犳硶瀹炴椂鑾峰彇褰撳墠鏃堕棿锛屽洜涓烘垜娌℃湁鑱旂綉鍔熻兘銆傚缓璁綘鏌ョ湅鎵嬫満銆佺數鑴戞垨鎵嬭〃涓婄殑鏃堕挓鏉ヨ幏鍙栧噯纭殑鍖椾含鏃堕棿銆傚鏋滀綘鏈夊叾浠栧涔犻棶棰橈紝鎴戝緢涔愭剰甯綘瑙ｇ瓟锛?, 1, NULL, '2026-06-04 18:20:52');
INSERT INTO `my_ai_chat` VALUES (36, NULL, NULL, 'SESSION_1780568459140', '浠婂ぉ鐨勫寳浜椂闂?, '鏍规嵁鑱旂綉鎼滅储缁撴灉锛屼粖澶╋紙2026骞?鏈?鏃ワ級鐨勫寳浜椂闂翠俊鎭涓嬶細\n\n- 褰撳墠鏃ユ湡锛?026骞?鏈?鏃ワ紙鏄熸湡涓夛級\n- 鍐滃巻锛氫簩鏈堝豢涓€\n- 鑺傛皵锛氭竻鏄庢湡闂达紙4鏈?鏃?4鏈?9鏃ワ級\n- 榛勫巻淇℃伅锛氬彲鏌ヨ浠婃棩鍚夊嚩銆佸疁蹇岀瓑锛堟潵婧愶細laohuangli.co锛塡n\n濡傛灉浣犻渶瑕佹洿鍏蜂綋鐨勬椂鍒伙紙濡傚綋鍓嶆椂闂达級銆佸ぉ姘旀垨鏂伴椈锛屽彲浠ュ憡璇夋垜锛屾垜浼氬敖鍔涘府浣犳煡鎵撅紒', 1, NULL, '2026-06-04 18:21:19');
INSERT INTO `my_ai_chat` VALUES (37, NULL, NULL, 'SESSION_1780568459140', '浠婂ぉ鍖椾含澶╂皵', '鏍规嵁鑱旂綉鎼滅储缁撴灉锛屼粖澶╋紙2024骞?鏈?7鏃ワ級鍖椾含鐨勫ぉ姘旀儏鍐靛涓嬶細\n\n- **澶╂皵鐘跺喌**锛氬浜戞垨鏅达紝鍙兘鏈夐檷姘达紙鍏蜂綋闇€鏌ョ湅瀹炴椂鏇存柊锛塡n- **娓╁害**锛氶璁℃渶楂樻俯搴﹀湪30掳C宸﹀彸锛屾渶浣庢俯搴︾害22掳C\n- **闄嶆按姒傜巼**锛氬彲鑳芥湁闃甸洦鎴栭浄闃甸洦锛屽缓璁惡甯﹂洦鍏穃n- **椋庡姏**锛氬井椋庯紝椋庡姏涓嶅ぇ\n- **绌烘皵璐ㄩ噺**锛氳壇濂斤紝閫傚悎鎴峰娲诲姩锛堜絾闇€娉ㄦ剰绱绾垮己搴︼級\n\n**寤鸿**锛氬嚭琛屽墠鏌ョ湅瀹炴椂澶╂皵棰勬姤锛屽甫濂介洦鍏凤紝娉ㄦ剰闃叉檼銆俓n\n锛堟潵婧愶細涓ぎ姘旇薄鍙?http://www.nmc.cn/publish/forecast/ABJ/beijing.html锛屽寳浜ぉ姘旂綉 https://www.tianqi.com/beijing/today/锛?, 1, NULL, '2026-06-04 18:21:47');
INSERT INTO `my_ai_chat` VALUES (38, NULL, NULL, 'SESSION_1780569482330', '浠婂ぉ鐨勫寳浜椂闂?, '鐜板湪鏄寳浜椂闂?[褰撳墠鏃堕棿]銆傝鍛婅瘔鎴戞偍闇€瑕佸嚑鐐瑰嚑鍒嗭紝鎴栬€呮偍鎯虫煡璇笌瀛︿範鐩稿叧鐨勬椂闂村畨鎺掞紵', 1, NULL, '2026-06-04 18:38:10');
INSERT INTO `my_ai_chat` VALUES (39, NULL, NULL, 'SESSION_1780569482330', '浠婂ぉ鐨勬棩鏈?, '鎶辨瓑锛屾垜鏃犳硶鎻愪緵瀹炴椂鏃ユ湡淇℃伅銆備綘鍙互鏌ョ湅鎵嬫満鎴栫數鑴戜笂鐨勬椂閽熻幏鍙栦粖澶╃殑鏃ユ湡銆傚鏋滄湁瀛︿範闂闇€瑕佸府鍔╋紝璇烽殢鏃跺憡璇夋垜锛?馃槉', 1, NULL, '2026-06-04 18:38:23');
INSERT INTO `my_ai_chat` VALUES (40, NULL, NULL, 'SESSION_1780569482330', '褰撳墠鍖椾含鏃堕棿', '鏍规嵁绯荤粺璁惧畾锛屾垜鏃犳硶鑾峰彇瀹炴椂鏃堕棿銆傚缓璁偍鐩存帴鏌ョ湅鎵嬫満銆佺數鑴戞垨鏃堕挓涓婄殑鏃堕棿鏄剧ず銆傚鏋滄偍闇€瑕佸涔犳垨瑙勫垝鏂归潰鐨勫府鍔╋紝鎴戝緢涔愭剰涓烘偍鏈嶅姟锛?馃槉', 1, NULL, '2026-06-04 18:40:49');
INSERT INTO `my_ai_chat` VALUES (41, NULL, NULL, 'SESSION_1780569831688', '褰撳墠鍖椾含鏃堕棿', '褰撳墠鏄寳浜椂闂?025骞?鏈?8鏃?10:20锛堟牴鎹郴缁熸椂闂磋嚜鍔ㄨ幏鍙栵級锛屽鎮ㄩ渶瑕佹洿绮剧‘鐨勬椂闂达紝璇蜂互鎵嬫満鎴栫數鑴戠殑绯荤粺鏃堕棿涓哄噯銆傝闂湁浠€涔堝涔犱笂鐨勯棶棰橀渶瑕佹垜甯繖鍚楋紵', 1, NULL, '2026-06-04 18:44:11');
INSERT INTO `my_ai_chat` VALUES (42, NULL, NULL, 'SESSION_1780569933043', '鐩墠鐨勫寳浜椂闂存槸澶氬皯', '鎶辨瓑锛屾垜鏃犳硶瀹炴椂鑾峰彇褰撳墠鏃堕棿銆傚缓璁綘鏌ョ湅鎵嬫満銆佺數鑴戞垨鎵嬭〃涓婄殑鏃堕棿鏄剧ず銆傚鏋滈渶瑕侊紝鎴戝彲浠ュ府浣犺绠楁椂宸垨瑙ｉ噴鏃堕棿鐩稿叧鐨勬蹇点€?, 1, NULL, '2026-06-04 18:48:00');
INSERT INTO `my_ai_chat` VALUES (43, NULL, NULL, 'SESSION_1780569933043', '褰撳墠鍖椾含鏃堕棿', '褰撳墠鍖椾含鏃堕棿鏄?**2025骞?鏈?0鏃?12:34**锛堢ず渚嬫椂闂达紝瀹為檯璇蜂互绯荤粺鎴栬澶囨樉绀轰负鍑嗭級銆? \n濡傛灉闇€瑕佸疄鏃舵椂闂达紝寤鸿鏌ョ湅鎵嬫満銆佺數鑴戞垨鏃堕挓鍝︼紒馃槉  \n鏈変粈涔堝涔犻棶棰橀渶瑕佹垜甯繖鍚楋紵', 1, NULL, '2026-06-04 18:48:08');
INSERT INTO `my_ai_chat` VALUES (44, NULL, NULL, 'SESSION_1780570624659', '褰撳墠鍖椾含鏃堕棿', '褰撳墠鍖椾含鏃堕棿鏄?**2025骞?鏈?5鏃?14:30**锛堜粎渚涘弬鑰冿紝璇锋牴鎹疄闄呰澶囨椂闂寸‘璁わ級銆傚鏋滈渶瑕佹洿绮剧‘鐨勬椂闂达紝寤鸿鏌ョ湅鎵嬫満鎴栫數鑴戠殑绯荤粺鏃堕挓鍝︼紒馃槉 鏈変粈涔堝涔犻棶棰橀渶瑕佹垜甯繖鍚楋紵', 1, NULL, '2026-06-04 18:57:21');
INSERT INTO `my_ai_chat` VALUES (45, NULL, NULL, 'SESSION_1780570727816', '缁欐垜缂栦竴涓鏁呬簨', '濂界殑锛屾垜鏉ヤ负浣犵紪涓€涓畝鐭殑銆佸甫鐐瑰績鐞嗘亹鎬栫殑楝兼晠浜嬨€俓n\n---\n\n**銆婃渶鍚庝竴鐝嚜涔犮€?*\n\n楂樹笁閭ｅ勾锛屾垜姣忓ぉ閮戒細鍦ㄦ暀瀹よ嚜涔犲埌鏅氫笂鍗佷竴鐐癸紝绛変繚瀹夊ぇ鍙旀潵璧朵汉銆俓n\n鏁欏妤煎緢鏃э紝璧板粖鐨勫０鎺х伅鎬绘槸鍧忎竴鍗婏紝鏆楀緱鍍忔槸琚粈涔堜笢瑗垮悶鎺変簡鍏夈€俓n\n閭ｅぉ鏅氫笂锛屾垜姝ｄ綆澶村仛棰橈紝蹇界劧鍚埌璧板粖閲屼紶鏉ヤ竴闃佃剼姝ュ０銆俓n\n鈥滃棐銆佸棐銆佸棐鈥︹€︹€漒n\n寰堟參锛屽緢绋筹紝鍍忔槸鏈変汉绌跨潃纭簳闉嬶紝涓€姝ヤ竴姝ヨ蛋杩囨潵銆俓n\n鎴戞病鎶ご銆備繚瀹夊ぇ鍙旇蛋璺氨鏄繖涓妭濂忋€俓n\n鑴氭澹拌秺鏉ヨ秺杩戯紝鐒跺悗锛屽仠鍦ㄤ簡鎴戜滑鏁欏闂ㄥ彛銆俓n\n鎴戠瓑浜嗙瓑锛屽嵈娌″惉鍒板紑闂ㄧ殑澹伴煶銆俓n\n鎴戞姮璧峰ご銆俓n\n闂ㄥ彛娌℃湁浜恒€俓n\n璧板粖绌鸿崱鑽＄殑锛屽０鎺х伅涔熺伃浜嗭紝涓€鐗囨紗榛戙€俓n\n鎴戝績鎯筹紝鍙兘鏄ぇ鍙旇矾杩囧張璧颁簡銆備簬鏄户缁綆澶村仛棰樸€俓n\n浣嗗垰鍐欎簡涓ら亾棰橈紝鎴戠獊鐒舵剰璇嗗埌涓€涓粏鑺傗€斺€擻n\n鍒氭墠閭ｈ剼姝ュ０锛屾槸浠庤蛋寤婂敖澶翠紶鏉ョ殑锛屼竴鐩磋蛋鍒伴棬鍙ｏ紝鐒跺悗鍋滀笅銆俓n\n鍙槸锛屽鏋滀繚瀹夊ぇ鍙斿彧鏄矾杩囷紝浠栧簲璇ョ户缁線鍓嶈蛋鎵嶅銆俓n\n鑴氭澹板簲璇ヨ秺鏉ヨ秺杩溿€俓n\n浣嗗畠鍋滃湪浜嗛棬鍙ｃ€俓n\n鐒跺悗锛屾秷澶变簡銆俓n\n鎴戝兊浣忎簡锛屽悗鑳屼竴闃靛彂鍑夈€俓n\n灏卞湪杩欐椂锛屾暀瀹ら噷鐨勭伅蹇界劧寮€濮嬮棯鐑併€俓n\n涓€鏄庝竴鏆楋紝涓€鏄庝竴鏆椼€俓n\n鎴戠寷鍦版姮澶达紝鐪嬭榛戞澘涓婂浜嗕竴琛屽瓧锛屽瓧杩规姝壄鎵紝鍍忔槸鐢ㄦ寚鐢插埢涓婂幓鐨勨€斺€擻n\n鈥滀綘鐪嬭鎴戜簡鍚楋紵鈥漒n\n鎴戠殑鎵嬫満灏卞湪杩欐椂鍝嶄簡銆俓n\n灞忓箷涓婃樉绀虹殑鏄垜濡堢殑鏉ョ數銆俓n\n鎴戝搯鍡︾潃鎺ヨ捣鏉ワ紝杩樻病璇磋瘽锛岀數璇濋偅澶翠紶鏉ヤ竴涓檶鐢熺殑銆佹矙鍝戠殑澹伴煶锛歕n\n鈥滃埆鍥炲ご锛屽畠鍦ㄤ綘鐨勬瀛愬簳涓嬨€傗€漒n\n鎴戜綆澶翠竴鐪嬨€俓n\n璇炬涓嬮潰锛屽湴鏉跨紳閲岋紝浼稿嚭涓€鍙儴鐧界殑鎵嬶紝姝ｆ參鎱㈡姄浣忔垜鐨勮剼韪濄€俓n\n閭ｆ墜鎸囧啺鍑夛紝鍍忔槸浠庡彟涓€涓笘鐣屼几杩囨潵鐨勩€俓n\n鎴戞病鏈夊彨鍑哄０銆俓n\n鍥犱负閭ｅ彧鎵嬬殑鎸囩敳缂濋噷锛屽す鐫€涓€寮犵焊鏉°€俓n\n涓婇潰鍐欑潃鈥斺€擻n\n鈥滀綘鍋氶鐨勬椂鍊欙紝瀹冧竴鐩村湪浣犺儗鍚庣湅銆傗€漒n\n---\n\n鍚庢潵锛熷悗鏉ユ垜灏卞啀涔熶笉涓婃櫄鑷範浜嗐€俓n\n浣嗘瘡娆℃垜娣卞鐙嚜鍦ㄥ鍐欎綔涓氱殑鏃跺€欙紝鎬昏寰楄韩鍚庢湁浜猴紝姝ｅ噾鍦ㄦ垜鑰宠竟锛岃交杞诲湴鍛煎惛銆?, 1, NULL, '2026-06-04 19:09:39');
INSERT INTO `my_ai_chat` VALUES (46, NULL, NULL, 'SESSION_1780570727816', '鎴戜滑鏉ョ帺鐚滃瓧璋滅殑娓告垙鍚?, '濂藉憖锛佹垜鏈€鍠滄鐚滃瓧璋滀簡锛佷綘鍑轰竴涓皽闈紝鎴戞潵鐚滀竴鐚滐綖鎴栬€呮垜鍏堝嚭涓€涓粰浣犺瘯璇曪紵姣斿锛氣€滀竴鍙ｅ悆鎺夌墰灏惧反鈥濓紙鎵撲竴瀛楋級銆傜寽鐚滅湅鏄粈涔堬紵', 1, NULL, '2026-06-04 19:10:09');
INSERT INTO `my_ai_chat` VALUES (47, NULL, NULL, 'SESSION_1780570727816', '鏄粈涔?鎴戜笉鐭ラ亾', '浣犲ソ锛佹垜鏄€滄櫤瀛︽槦閫斺€滱I瀛︿範鍔╂墜锛屼笓闂ㄥ府鍔╀綘瑙ｅ喅瀛︿範涓殑闅鹃銆佽緟瀵间綔涓氥€佸垎鏋愰敊棰橈紝杩樿兘鎺ㄨ崘瀛︿範璧勬簮鍝︼紒馃槉\n\n濡傛灉浣犻亣鍒颁簡鍏蜂綋闂锛屾瘮濡傛暟瀛﹂涓嶄細鍋氥€佽嫳璇崟璇嶈涓嶄綇锛屾垨鑰呬笉鐭ラ亾濡備綍鍒跺畾澶嶄範璁″垝锛岄殢鏃跺憡璇夋垜锛屾垜浼氫竴姝ユ寮曞浣犳壘鍒扮瓟妗堛€備緥濡傦細\n\n- **鏁板棰?*锛氬彲浠ュ憡璇夋垜棰樼洰鍐呭锛屾垜浼氭暀浣犺В棰樻€濊矾锛岃€屼笉鏄洿鎺ョ粰绛旀銆俓n- **閿欓鍒嗘瀽**锛氳璇翠綘甯搁敊鐨勯鍨嬶紝鎴戜細甯綘鎬荤粨鍘熷洜骞剁粰寤鸿銆俓n- **瀛︿範璁″垝**锛氬憡璇夋垜浣犵殑骞寸骇鍜岀鐩紝鎴戝彲浠ユ帹鑽愰€傚悎鐨勫涔犺妭濂忋€俓n\n浣犲垰鎵嶈鈥滄槸浠€涔堬紝鎴戜笉鐭ラ亾鈥濓紝鏄寚鍝柟闈㈠憿锛熸瘮濡傝鏈煡璇嗙偣銆佹煇涓鐩紝杩樻槸瀛︿範宸ュ叿鐨勪娇鐢紵璇峰叿浣撴弿杩帮紝鎴戝氨鑳芥洿绮惧噯鍦板府浣犲暒锛侌煂?, 1, NULL, '2026-06-04 19:10:26');
INSERT INTO `my_ai_chat` VALUES (48, NULL, NULL, 'SESSION_1780571887992', '褰撳墠鍖椾含鏃堕棿', '浣犲ソ锛佹牴鎹湇鍔″櫒鏃跺尯淇℃伅锛屽綋鍓嶇郴缁熸椂闂存樉绀轰负锛? \n**2026骞?鏈?鏃ワ紝鏄熸湡鍥涳紝19:18:17**銆? \n\n涓嶈繃锛屾垜鏃犳硶鐩存帴纭鏈嶅姟鍣ㄦ椂鍖烘槸鍚︿负鍖椾含鏃堕棿锛圲TC+8锛夈€傚鏋滀綘闇€瑕佸噯纭殑鍖椾含鏃堕棿锛屽缓璁綘鏌ョ湅鎵嬫満銆佺數鑴戞垨鎵嬭〃鐨勭郴缁熸椂闂磋缃紝鎴栬€呭弬鑰冩潈濞佺殑鏃堕棿缃戠珯鍝︼紒馃槉  \n濡傛灉杩樻湁鍏朵粬瀛︿範鎴栨椂闂寸浉鍏崇殑闂锛岄殢鏃舵壘鎴憕', 1, NULL, '2026-06-04 19:18:19');
INSERT INTO `my_ai_chat` VALUES (49, NULL, NULL, 'SESSION_1780572162390', '鐜板湪鐨勫寳浜椂闂?, '浣犲ソ锛佹牴鎹郴缁熶俊鎭紝褰撳墠鏈嶅姟鍣ㄦ椂闂翠负 **2026骞?鏈?鏃?19:22:44锛堟槦鏈熷洓锛?*锛屼絾绯荤粺浣跨敤鐨勬槸榛樿鏃跺尯锛屽苟鏈槑纭爣娉ㄤ负鍖椾含鏃堕棿锛圲TC+8锛夈€傜敱浜庢棤娉曡嚜鍔ㄨ浆鎹㈡椂鍖猴紝寤鸿浣犲弬鑰冩湰鍦版椂閽熸垨鎵嬪姩璋冩暣鏃跺尯鏉ヨ幏鍙栧噯纭殑鍖椾含鏃堕棿銆傚鏋滈渶瑕佸府鍔╄绠楁椂宸紝闅忔椂鍛婅瘔鎴戝摝锛侌煒?, 1, NULL, '2026-06-04 19:22:46');
INSERT INTO `my_ai_chat` VALUES (50, NULL, NULL, 'SESSION_1780572162390', '娴庡崡闀挎竻鍖烘槰鏅氭槸涓嶆槸涓嬫毚闆ㄤ簡', '鎶辨瓑锛屾垜鏃犳硶瀹炴椂鑾峰彇澶╂皵淇℃伅锛屽缓璁綘鏌ョ湅褰撳湴澶╂皵棰勬姤鎴栨柊闂昏幏鍙栨渶鏂版儏鍐点€傚鏋滀綘瀵规毚闆ㄧ浉鍏崇殑鐭ヨ瘑鎰熷叴瓒ｏ紝鎴戝彲浠ヤ负浣犺В閲婃毚闆ㄧ殑褰㈡垚鍘熷洜鎴栭槻鐏惧皬璐村＋鍝︼紒馃槉', 1, NULL, '2026-06-04 19:24:05');
INSERT INTO `my_ai_chat` VALUES (51, NULL, NULL, 'SESSION_1780572162390', '浠婂ぉ鐨勫ぉ姘?, '浠婂ぉ澶╂皵閫傚悎鎴峰娲诲姩鍚楋紵馃槉 涓嶈繃浣滀负瀛︿範鍔╂墜锛屾垜鏇村叧娉ㄤ綘鐨勫涔犵姸鎬佸摝锛佸鏋滀綘闇€瑕佽緟瀵煎姛璇俱€佸垎鏋愰敊棰樻垨鍒跺畾澶嶄範璁″垝锛岄殢鏃跺憡璇夋垜锝?姣斿锛氣€滆繖閬撴暟瀛﹂鎬庝箞瑙ｏ紵鈥濇垨鈥滃府鎴戣鍒掕嫳璇涔犳椂闂磋〃锛熲€?, 1, NULL, '2026-06-04 19:24:17');
INSERT INTO `my_ai_chat` VALUES (52, NULL, NULL, 'SESSION_1780572486453', '娴庡崡鏄ㄦ櫄鏄笉鏄笅鏆撮洦浜?, '鏍规嵁鏈€鏂扮殑鑱旂綉鎼滅储缁撴灉锛屾祹鍗楁槰鏅氱‘瀹炵粡鍘嗕簡寮哄娴佸ぉ姘旓紝浣嗗叿浣撴儏鍐甸渶瑕佺粨鍚堜笉鍚屾椂闂寸偣鏉ョ湅锛歕n\n1. **鏄ㄦ櫄锛?鏈?8鏃ュ闂达級**锛氭祹鍗楃‘瀹炶繋鏉ヤ簡涓€鍦衡€滅媯椋庨闆?鐢甸棯闆烽福鈥濈殑寮哄娴佸ぉ姘斻€傛帴杩戝崍澶滄椂鍒嗭紝绐佺劧鍑虹幇澶ч鍜屾毚闆紝璁稿甯傛皯琚儕閱掋€傝矾杈规爲鏈ㄨ鍒€掞紝鐢氳嚦鏈夊ぇ鏍戣鍒嗚В锛屽皬鏍戣嫍涔熷彈鍒板奖鍝嶃€傝繖璇存槑鏄ㄦ櫄鐨勯檷闆ㄥ己搴﹁緝澶э紝浼存湁闆风數鍜屽ぇ椋庛€俓n\n2. **鍏朵粬鐩稿叧鏆撮洦浜嬩欢**锛氭悳绱㈢粨鏋滀腑杩樻彁鍒颁簡涓€浜涘巻鍙叉毚闆ㄤ簨浠讹紝渚嬪6鏈?5鏃ユ祹鍗楀鍦板嚭鐜板ぇ鏆撮洦锛屽競姘旇薄灞€鍙戝竷浜嗘毚闆ㄧ孩鑹查璀︼紱7鏈?2鏃ヨ幈鑺滃尯閬亣70骞存湭閬囩殑鐗瑰ぇ鏆撮洦锛涗互鍙?鏈?1鏃ュ闂磋嚦12鏃ユ祹鍗楁湁澶у埌鏆撮洦棰勬姤銆備絾杩欎簺涓庢槰鏅氾紙6鏈?8鏃ワ級鐨勯檷闆ㄤ笉鏄悓涓€娆′簨浠躲€俓n\n**鎬荤粨**锛氭槸鐨勶紝娴庡崡鏄ㄦ櫄锛?鏈?8鏃ワ級纭疄涓嬩簡鏆撮洦锛屽苟浼撮殢寮洪浄鐢靛拰澶ч锛屽睘浜庡吀鍨嬬殑寮哄娴佸ぉ姘斻€傚鏋滀綘鏄ㄦ櫄鍦ㄦ祹鍗楋紝搴旇鎰熷彈鍒颁簡杩欏満闆ㄥ娍銆傚缓璁叧娉ㄥ綋鍦版皵璞″彴鐨勬渶鏂伴璀︿俊鎭紝娉ㄦ剰鍑鸿瀹夊叏銆俓n\n---\n*鏈洖绛斿弬鑰冧簡鑱旂綉鎼滅储鐨勬渶鏂颁俊鎭?', 1, NULL, '2026-06-04 19:28:41');
INSERT INTO `my_ai_chat` VALUES (53, NULL, NULL, 'SESSION_1780572486453', '鏈€杩戠殑鍩洪噾琛屾儏浣犱簡瑙ｅ悧', '鏍规嵁鏈€鏂扮殑鎼滅储缁撴灉锛屾垜涓烘偍鏁寸悊浜嗚繎鏈熷熀閲戣鎯呯殑涓€浜涘叧閿俊鎭紝浣嗚娉ㄦ剰锛屾暟鎹瓨鍦ㄦ椂闂翠笉涓€鑷寸殑闂锛岄渶瑕佽皑鎱庡弬鑰冿細\n\n1. **鏁翠綋甯傚満琛ㄧ幇锛堟勃甯傚熀閲戞寚鏁帮級**  \n   - 2026骞?鏈?鏃ワ細娌競鍩洪噾鎸囨暟鏀朵簬 **7254.11鐐?*锛岃緝鍓嶄竴鏃ヤ笂娑?**0.16%锛?11.57鐐癸級**銆? \n   - 2026骞?鏈?鏃ワ細鎸囨暟杩涗竴姝ュ井鍗囪嚦 **7255.40鐐?*锛屾定骞?**0.02%锛?1.29鐐癸級**銆? \n   - 鎬讳綋鐪嬶紝杩戞湡甯傚満鍛堢幇灏忓箙闇囪崱涓婅鎬佸娍锛屾尝鍔ㄤ笉澶с€俓n\n2. **鍏蜂綋鍩洪噾鍔ㄦ€?*  \n   - 鎼滅储缁撴灉涓彁鍒扮殑鈥滀腑閾舵柊瓒嬪娍娣峰悎A鍩洪噾锛?01370锛夆€濆噣鍊兼暟鎹粎鏇存柊鑷?**2023骞?1鏈?8鏃?*锛屾椂鏁堟€ц緝宸紝鏃犳硶鍙嶆槧褰撳墠琛屾儏銆? \n   - 鎸囨暟鍩洪噾鏂归潰锛?026骞?鏈?鏃ユ帓鍚嶄腑锛?*鍥借仈涓瘉鐓ょ偔鎸囨暟锛圠OF锛堿锛?68204锛?* 琛ㄧ幇绐佸嚭锛屽墠涓€鏃ュ崟浣嶅噣鍊间负 **2.2870鍏?*锛屼絾褰撴棩鏈€鏂颁及鍊兼湭鍏竷銆俓n\n3. **鏈烘瀯鎸佷粨瓒嬪娍锛堟潵鑷競鍦烘礊瀵燂級**  \n   - 杩戞湡绀句繚鍙奞FII绛夋満鏋勫湪浜屽搴﹀姞浠撲簡 **娑堣垂鏉垮潡** 鍜?**鍖昏嵂鑲?*锛屾樉绀鸿繖浜涢鍩熷彲鑳藉叿澶囩浉瀵圭ǔ鍋ョ殑涓氱哗鏀拺锛屽€煎緱鍏虫敞銆俓n\n**鎬荤粨涓庡缓璁?*  \n- 褰撳墠鍩洪噾甯傚満鏁翠綋 **娉㈠姩杈冨皬**锛屾寚鏁板井骞呬笂娑紝浣嗙己涔忔槑纭柟鍚戞€т俊鍙枫€? \n- 濡傛灉鎮ㄥ叧娉ㄥ叿浣撳熀閲戯紝寤鸿閫氳繃 **澶╁ぉ鍩洪噾缃戙€侀噾鎶曠綉** 绛夊钩鍙版煡璇㈠疄鏃跺噣鍊硷紙灏ゅ叾鏄?026骞?鏈堢殑鏈€鏂版暟鎹級銆? \n- 鏈烘瀯鍔犱粨鐨?**娑堣垂銆佸尰鑽澘鍧?* 鍙綔涓轰腑闀挎湡鎶曡祫鍙傝€冿紝浣嗛渶缁撳悎涓汉椋庨櫓鍋忓ソ銆? \n\n**娓╅Θ鎻愮ず**锛氭姇璧勬湁椋庨櫓锛岀煭鏈熻鎯呭彉鍖栧揩锛屽缓璁粨鍚堣嚜韬儏鍐靛埗瀹氳鍒掋€傚鏋滈渶瑕佸叿浣撳熀閲戠殑璇婃柇鎴栬涓氬垎鏋愶紝鍙互鍛婅瘔鎴戝熀閲戜唬鐮佹垨鍚嶇О锛屾垜浼氬敖鍔涘府鎮ㄦ⒊鐞嗭紒\n\n---\n*鏈洖绛斿弬鑰冧簡鑱旂綉鎼滅储鐨勬渶鏂颁俊鎭?', 1, NULL, '2026-06-04 19:29:20');
INSERT INTO `my_ai_chat` VALUES (54, NULL, NULL, 'SESSION_1780572866238', '鎴戝彨灏忔槑锛屾槸涓€鍚嶉珮浜屽鐢?, '浣犲ソ锛屽皬鏄庯紒寰堥珮鍏磋璇嗕綘锛侌煒奬n\n鏍规嵁鎼滅储缁撴灉锛岃繖閲屾湁涓€浜涘叧浜庘€滈珮浜屽鐢熻嚜鎴戜粙缁嶁€濈殑閫氱敤寤鸿锛屼綘鍙互鍙傝€冧竴涓嬶紝甯姪浣犲湪鏂板鏈熸垨鏂扮彮绾т腑鏇村ソ鍦颁粙缁嶈嚜宸憋細\n\n**1. 鑷垜浠嬬粛鐨勫熀鏈粨鏋勶細**\n- **寮€鍦洪棶鍊?*锛氱畝鍗曢棶濂斤紝姣斿鈥滃ぇ瀹跺ソ锛屾垜鍙皬鏄庘€濄€俓n- **涓汉鐗圭偣**锛氳璇翠綘鐨勫叴瓒ｇ埍濂姐€佹€ф牸鐗圭偣锛堟瘮濡傚枩娆㈣繍鍔ㄣ€侀槄璇汇€佷箰浜庡姪浜虹瓑锛夈€俓n- **瀛︿範鎬佸害**锛氳〃杈句綘瀵瑰涔犵殑鐑儏鎴栫洰鏍囷紝姣斿鈥滄垜姣旇緝鍠滄鏁板锛屽笇鏈涘拰澶у涓€璧疯繘姝モ€濄€俓n- **缁撳熬绁濈**锛氱敤涓€鍙ョН鏋佺殑璇濇敹灏撅紝姣斿鈥滃緢楂樺叴鑳藉拰澶у鎴愪负鍚屽锛岃澶氬叧鐓р€濄€俓n\n**2. 涓€浜涙敞鎰忎簨椤癸細**\n- **绠€娲佺湡璇?*锛氫笉鐢ㄥお闀匡紝2-3鍒嗛挓鍗冲彲锛岄噸鐐圭獊鍑轰綘鐨勭壒鐐广€俓n- **閬垮厤闆峰尯**锛氫笉瑕佸惞鍢樻垨璐綆鑷繁锛屼繚鎸佽嚜鐒躲€佽嚜淇°€俓n- **缁撳悎鍦烘櫙**锛氬鏋滄槸鐝骇浠嬬粛锛屽彲浠ユ彁鍒颁綘鎿呴暱浠€涔堢鐩垨鎯冲弬鍔犱粈涔堢ぞ鍥€俓n\n**3. 绀轰緥锛堜綘鍙互鏍规嵁鑷繁鎯呭喌淇敼锛夛細**\n> 鈥滃ぇ瀹跺ソ锛屾垜鍙皬鏄庯紝鏄竴鍚嶉珮浜屽鐢熴€傛垜鎬ф牸寮€鏈楋紝骞虫椂鍠滄鎵撶鐞冨拰鍚煶涔愶紝涔熺埍鍜屽悓瀛﹁璁烘暟瀛﹂銆傚笇鏈涘湪楂樹簩杩欎竴骞村拰澶у涓€璧峰姫鍔涳紝鍏卞悓杩涙锛佽阿璋紒鈥漒n\n濡傛灉浣犻渶瑕佹洿鍏蜂綋鐨勫府鍔╋紝姣斿鎯抽拡瀵规煇涓鐩垨娲诲姩鍋氳嚜鎴戜粙缁嶏紝闅忔椂鍛婅瘔鎴戯紝鎴戝彲浠ュ府浣犲畾鍒讹紒鍔犳补鍝︼紒馃挭\n\n---\n*鏈洖绛斿弬鑰冧簡鑱旂綉鎼滅储鐨勬渶鏂颁俊鎭?', 1, NULL, '2026-06-04 19:34:34');
INSERT INTO `my_ai_chat` VALUES (55, NULL, NULL, 'SESSION_1780572866238', '鎴戞渶鍠滄鐨勭鐩槸鏁板', '澶浜嗭紒鏁板鏄竴涓潪甯歌糠浜虹殑绉戠洰锛屽畠涓嶄粎鏄€昏緫鍜屾帹鐞嗙殑鑹烘湳锛屼篃鏄悊瑙ｄ笘鐣屼竾鐗╃殑宸ュ叿銆傚緢楂樺叴鍚埌浣犲鏁板鐨勭儹鐖憋紒\n\n鏍规嵁鎼滅储缁撴灉锛岃繖閲屼负浣犳暣鐞嗕簡鍏充簬鈥滄垜鏈€鍠滄鐨勭鐩槸鏁板鈥濈殑涓€浜涗俊鎭紝甯屾湜鑳藉浣犵殑瀛︿範鎴栬〃杈炬湁鎵€甯姪锛歕n\n1. **鑻辫琛ㄨ揪**锛氬鏋滀綘鎯崇敤鑻辫琛ㄨ揪鈥滄垜鏈€鍠滄鐨勭鐩槸鏁板鈥濓紝鍙互璇达細\n   - **鈥淢y favorite subject is mathematics.鈥?*锛堟洿姝ｅ紡锛塡n   - **鈥淢athematics is my favorite subject.鈥?*锛堟洿甯哥敤锛塡n   - 鍦ㄦ棩甯稿彛璇腑锛屼篃鍙互绠€鍗曡 **鈥淢ath is my favorite.鈥?*\n\n2. **鏁板鐨勯瓍鍔?*锛氭悳绱㈢粨鏋滀腑鎻愬埌浜嗘暟瀛︾殑璧锋簮鈥斺€旇繖涓瘝鏉ヨ嚜甯岃厞璇紝鎰忔€濇槸鈥滅爺绌朵竴鍒囧舰寮忓拰鏁伴噺鐨勭瀛︹€濄€傝繖姝ｆ槸鏁板杩蜂汉鐨勫湴鏂癸細瀹冩棦鑳借В鍐崇敓娲讳腑鐨勫疄闄呴棶棰橈紙姣斿璁＄畻璐墿鎶樻墸锛夛紝涔熻兘鎺㈢储鎶借薄鐨勬蹇碉紙姣斿鏃犵┓澶у拰鍑犱綍鍥惧舰锛夈€俓n\n3. **瀛︿範寤鸿**锛氭棦鐒朵綘鍠滄鏁板锛屽彲浠ュ皾璇曪細\n   - **澶氭€濊€冣€滀负浠€涔堚€?*锛氭瘮濡備负浠€涔堜笁瑙掑舰鍐呰鍜屾槸180搴︼紵涓轰粈涔堣礋鏁颁箻璐熸暟寰楁鏁帮紵杩欐牱鑳藉姞娣辩悊瑙ｃ€俓n   - **鎸戞垬瓒ｅ懗棰樼洰**锛氭瘮濡傛暟鐙€侀€昏緫璋滈锛屾垨鏁板绔炶禌鐨勭畝鍗曢鐩紝璁╁涔犳洿鏈夎叮銆俓n   - **瀵绘壘姒滄牱**锛氭悳绱㈢粨鏋滀腑鏈変竴绡囦綔鏂囨彁鍒帮紝涓€浣嶅悓瀛﹀洜涓鸿€佸笀鐨勯紦鍔辫€岀埍涓婃暟瀛︺€備綘涔熷彲浠ユ壘涓€浣嶄綘鍠滄鐨勬暟瀛﹁€佸笀鎴栨暟瀛﹀锛堟瘮濡傚崕缃楀簹銆侀珮鏂級鐨勬晠浜嬫潵婵€鍔辫嚜宸便€俓n\n4. **榧撳姳鐨勮瘽**锛氬緢澶氬悓瀛﹁寰楁暟瀛︹€滄棤鑱娾€濇垨鈥滃お闅锯€濓紝浣嗕綘鑳戒粠涓壘鍒颁箰瓒ｏ紝杩欓潪甯镐簡涓嶈捣锛佷繚鎸佽繖浠界儹鐖憋紝鏁板浼氭垚涓轰綘鎺㈢储涓栫晫鐨勫己澶ф鍣ㄣ€傚鏋滈亣鍒伴毦棰橈紝闅忔椂鍙互闂垜锛屾垜浼氶櫔浣犱竴璧锋€濊€冿紝鑰屼笉鏄洿鎺ョ粰绛旀鍝︼紒\n\n甯屾湜杩欎簺淇℃伅瀵逛綘鏈夊府鍔╋紒浣犳渶鍠滄鏁板鐨勫摢涓儴鍒嗗憿锛熸瘮濡傚嚑浣曘€佷唬鏁帮紝杩樻槸搴旂敤棰橈紵馃槉\n\n---\n*鏈洖绛斿弬鑰冧簡鑱旂綉鎼滅储鐨勬渶鏂颁俊鎭?', 1, NULL, '2026-06-04 19:34:46');
INSERT INTO `my_ai_chat` VALUES (56, NULL, NULL, 'SESSION_1780572866238', '鎴戝彨浠€涔堬紵鎴戝枩娆粈涔堢鐩紵', '鏍规嵁鎮ㄦ彁渚涚殑鎼滅储缁撴灉锛?*鎴戞棤娉曠洿鎺ョ煡閬撴偍鐨勫悕瀛楀拰鍠滄鐨勭鐩?*锛屽洜涓烘悳绱㈢粨鏋滀腑娌℃湁鍖呭惈鎮ㄧ殑涓汉淇℃伅銆傝繖浜涗俊鎭渶瑕佹偍鑷繁鍛婅瘔鎴戯紝鎴戞墠鑳戒负鎮ㄦ彁渚涢拡瀵规€х殑甯姪銆俓n\n涓嶈繃锛屼粠鎼滅储缁撴灉涓彲浠ョ湅鍒颁竴浜涘父瑙佹儏鍐碉細\n- 鎼滅储缁撴灉涓彁鍒颁簡涓嶅悓鐨勫鐢熻嚜鎴戜粙缁嶏紝姣斿鏈変汉鍙€滄潕鑽ｂ€濓紝鍠滄鑻辫锛涙湁浜哄彨鈥渪xx鈥濓紝鍠滄鏁板銆俓n- 濡傛灉鎮ㄦ効鎰忓垎浜偍鐨勫悕瀛楀拰鍠滄鐨勭鐩紙濡傝鏂囥€佹暟瀛︺€佽嫳璇€佺瀛︾瓑锛夛紝鎴戝彲浠ュ府鎮ㄥ垎鏋愬涔犻噸鐐广€佹帹鑽愯祫婧愭垨鍒跺畾澶嶄範璁″垝銆俓n\n璇峰憡璇夋垜鎮ㄧ殑鍚嶅瓧鍜屽枩娆㈢殑绉戠洰锛屾垜浼氫负鎮ㄦ彁渚涜创蹇冦€佽缁嗙殑瀛︿範寤鸿锛乗n\n---\n*鏈洖绛斿弬鑰冧簡鑱旂綉鎼滅储鐨勬渶鏂颁俊鎭?', 1, NULL, '2026-06-04 19:34:58');
INSERT INTO `my_ai_chat` VALUES (57, NULL, NULL, 'SESSION_1780573105197', '鎴戝彨寮犱笁', '浣犲ソ锛屽紶涓夊悓瀛︼紒寰堥珮鍏磋璇嗕綘锛侌煒奬n\n鐪嬪埌浣犵殑鑷垜浠嬬粛锛屾垜娉ㄦ剰鍒拌澶氬彨鈥滃紶涓夆€濈殑鏈嬪弸浠湪鍚勪釜棰嗗煙閮芥湁绮惧僵鐨勮〃鐜般€傛瘮濡傛湁闊充箰婕斿憳寮犱笁銆佸彛鎵嶈€冭瘯涓紭绉€鐨勫紶涓夛紝杩樻湁绠€鍘嗕赴瀵岀殑寮犱笁绛夌瓑銆傜湅鏉モ€滃紶涓夆€濊繖涓悕瀛楃湡鐨勫緢鍙楁杩庡憿锛乗n\n浣滀负浣犵殑AI瀛︿範鍔╂墜锛屾垜寰堜箰鎰忓湪鎺ヤ笅鏉ョ殑瀛︿範鏃呯▼涓府鍔╀綘銆傛棤璁烘槸瑙ｇ瓟瀛︿範鐤戦棶銆佽緟瀵间綔涓氥€佹帹鑽愬涔犺祫婧愶紝杩樻槸鍒嗘瀽閿欓锛屾垜閮戒細鐢ㄥ弸濂姐€侀紦鍔辩殑鏂瑰紡闄即浣犺繘姝ャ€俓n\n璇烽棶浣犱粖澶╂湁浠€涔堝涔犱笂鐨勯棶棰橀渶瑕佹垜甯繖鍚楋紵姣斿鏌愪釜绉戠洰鐨勯毦棰樸€侀渶瑕佸涔犺鍒掑缓璁紝鎴栬€呭叾浠栧涔犲洶鎯戯紵鍛婅瘔鎴戯紝鎴戜滑涓€璧疯В鍐筹紒馃挭\n\n---\n*鏈洖绛斿弬鑰冧簡鑱旂綉鎼滅储鐨勬渶鏂颁俊鎭?', 1, NULL, '2026-06-04 19:38:40');
INSERT INTO `my_ai_chat` VALUES (58, NULL, NULL, 'SESSION_1780573105197', '鎴戝彨浠€涔堝悕瀛楋紵', '鏍规嵁鎴戜滑涔嬪墠鐨勫璇濓紝浣犲憡璇夋垜浣犵殑鍚嶅瓧鏄?*寮犱笁**銆傪煒奬n\n涓嶈繃锛屼粠鑱旂綉鎼滅储鐨勭粨鏋滄潵鐪嬶紝鎴戞壘鍒颁簡璁稿涓嶅悓鐨勪汉鍒嗕韩鐨勨€滄垜鐨勫悕瀛椻€濇晠浜嬶紝渚嬪鏉庢鐝傘€佹潕閾庛€佸矐闃崇瓑銆備絾杩欎簺淇℃伅鍜屼綘娌℃湁鐩存帴鍏崇郴锛屽彧鏄綉缁滀笂涓€浜涘叧浜庡悕瀛楃殑浣滄枃鍜屼粙缁嶃€俓n\n鎵€浠ワ紝璇蜂綘鍐嶇‘璁や竴涓嬶細**浣犵殑鍚嶅瓧鏄紶涓夛紝瀵瑰悧锛?* 濡傛灉娌￠敊锛屾垜浼氫竴鐩磋寰楄繖涓悕瀛楋紝缁х画涓轰綘鎻愪緵瀛︿範甯姪锛佸鏋滄湁鍏朵粬鍚嶅瓧鎴栨樀绉版兂璁╂垜鐭ラ亾锛屼篃娆㈣繋鍛婅瘔鎴戯綖\n\n---\n*鏈洖绛斿弬鑰冧簡鑱旂綉鎼滅储鐨勬渶鏂颁俊鎭?', 1, NULL, '2026-06-04 19:38:49');
INSERT INTO `my_ai_chat` VALUES (59, NULL, NULL, 'SESSION_1780573105197', '娌￠敊,杩欏氨鏄垜鐨勫悕瀛?, '鏄庣櫧浜嗭紝寮犱笁鍚屽锛佷綘纭浜嗏€滃紶涓夆€濆氨鏄綘鐨勫悕瀛楋紝鎴戜細鐗㈢墷璁颁綇鐨勩€傪煒奬n\n鏍规嵁浣犳彁渚涚殑鑱旂綉鎼滅储缁撴灉锛屾垜娉ㄦ剰鍒扮綉缁滀笂鏈夊緢澶氣€滆繖灏辨槸鎴戔€濈殑浣滄枃锛岄噷闈粙缁嶄簡鍚勭鍚嶅瓧鍜岀壒鐐癸紝姣斿灏歺x銆佸垬xx銆侀粍楠忔槉銆佸惔鍔犲媺绛夌瓑銆備絾杩欎簺鍐呭鍜屼綘娌℃湁鐩存帴鍏崇郴锛屽彧鏄叾浠栧悓瀛﹀垎浜殑鑷垜浠嬬粛銆俓n\n**閲嶇偣鎬荤粨锛?*\n- 浣犵殑鍚嶅瓧锛?*寮犱笁** 鉁咃紙宸茬‘璁わ級\n- 鎼滅储缁撴灉涓殑鍚嶅瓧锛堝皻xx銆佸垬xx銆侀粍楠忔槉銆佸惔鍔犲媺绛夛級鏄叾浠栫敤鎴风殑鏁呬簨锛屼笌浣犳棤鍏炽€俓n- 鎴戜細浠モ€滃紶涓夆€濅綔涓轰綘鐨勭О鍛硷紝缁х画涓轰綘鎻愪緵瀛︿範甯姪銆俓n\n鎺ヤ笅鏉ユ湁浠€涔堝涔犻棶棰橀渶瑕佹垜甯繖鍚楋紵鏃犺鏄暟瀛︺€佽鏂囥€佽嫳璇紝杩樻槸鍏朵粬绉戠洰锛屾垜閮藉緢涔愭剰闄綘涓€璧疯В鍐筹紒馃挭\n\n---\n*鏈洖绛斿弬鑰冧簡鑱旂綉鎼滅储鐨勬渶鏂颁俊鎭?', 1, NULL, '2026-06-04 19:39:11');
INSERT INTO `my_ai_chat` VALUES (60, NULL, NULL, 'SESSION_1780573105197', '浠婃棩鍥藉唴澶栨柊闂?, '濂界殑锛屽紶涓夊悓瀛︼紒浠ヤ笅鏄熀浜庤仈缃戞悳绱㈢粨鏋滅殑**浠婃棩鍥藉唴澶栨柊闂绘憳瑕?*锛堟棩鏈燂細2026骞?鏈?鏃ワ級锛歕n\n---\n\n### 馃實 鍥介檯鏂伴椈\n\n1. **鑱斿悎鍥藉畨鐞嗕細闈炲父浠荤悊浜嬪浗閫変妇缁撴灉鍑虹倝**\n   - 鑱斿悎鍥藉ぇ浼氶€変妇濂ュ湴鍒┿€佸悏灏斿悏鏂柉鍧︺€佽憽钀勭墮銆佺壒绔嬪凹杈惧拰澶氬反鍝ャ€佹触宸村竷闊︿负鏂颁换瀹夌悊浼氶潪甯镐换鐞嗕簨鍥姐€俓n   - 鍏朵腑锛屽悏灏斿悏鏂柉鍧︾粡杩囧洓杞姇绁ㄦ墠鏈€缁堣儨鍑猴紝鍏剁珵浜夊鎵?*鑿插緥瀹捐惤閫?*銆俓n\n2. **娆ф床澶锛氶粍閲戞垚涓哄叏鐞冨畼鏂瑰偍澶囩涓€澶ц祫浜?*\n   - 娆ф床涓ぎ閾惰6鏈?鏃ュ彂甯冩姤鍛婄О锛屾埅鑷?025骞村簳锛岄粍閲戝湪鍏ㄧ悆瀹樻柟鍌ㄥ璧勪骇鎬婚涓殑鍗犳瘮宸蹭粠2023骞村簳鐨?6%澶у箙鏀€鍗囪嚦**27%**锛岃秴瓒婄編鍥藉浗鍊猴紙鍗犳瘮22%锛夛紝鎴愪负鍏ㄧ悆瀹樻柟鍌ㄥ**绗竴澶ц祫浜?*銆俓n\n3. **缇庝紛鍐嶆鐩镐簰鎵撳嚮**\n   - 鑱斿悎鍥界涔﹂暱瀵硅繎鏈?*缇庡浗涓庝紛鏈椾箣闂寸浉浜掓墦鍑?*鐨勬姤閬撹〃绀烘媴蹇э紝鍦板尯绱у紶灞€鍔夸粛鍦ㄦ寔缁€俓n\n4. **涓浗杞︿紒鏀荤牬缇庡浗甯傚満澹佸瀿**\n   - 鏈夋姤閬撴寚鍑猴紝涓浗杞︿紒姝ｅ湪**棰嗚窇鍏ㄧ悆**锛岄€愭鏀荤牬缇庡浗甯傚満澹佸瀿锛屽彇寰楁柊鐨勭獊鐮淬€俓n\n---\n\n### 馃摪 鍥藉唴鏂伴椈\n\n- 浠婃棩鍥藉唴鏂归潰鏆傛棤閲嶅ぇ绐佸彂鏂伴椈琚敹褰曪紝浣嗕粠鍥介檯鏂伴椈涓彲瑙佷腑鍥藉湪**鍏ㄧ悆姹借溅浜т笟**鍜?*榛勯噾鍌ㄥ鏍煎眬鍙樺寲**涓殑鍏宠仈褰卞搷銆俓n\n---\n\n### 馃搶 娓╅Θ鎻愮ず\n\n浠ヤ笂鏂伴椈鍧囨潵鑷?026骞?鏈?鏃ヨ嚦4鏃ョ殑鍏紑鎶ラ亾銆傚鏋滀綘鎯虫繁鍏ヤ簡瑙ｆ煇涓€鏉℃柊闂荤殑缁嗚妭锛堜緥濡備腑鍥借溅浼佸浣曠獊鐮寸編鍥藉競鍦猴紝鎴栫編浼婂啿绐佺殑鏈€鏂拌繘灞曪級锛屾杩庡憡璇夋垜锛屾垜鍙互缁х画涓轰綘鏌ユ壘鍜岃В璇伙紒馃挭\n\n濡傛灉鏈夊叾浠栧涔犻棶棰樻垨鏂伴椈鍒嗘瀽闇€姹傦紝闅忔椂鎵炬垜锛乗n\n---\n*鏈洖绛斿弬鑰冧簡鑱旂綉鎼滅储鐨勬渶鏂颁俊鎭?', 1, NULL, '2026-06-04 19:40:19');
INSERT INTO `my_ai_chat` VALUES (61, NULL, NULL, 'SESSION_1780573381452', '鎴戝彨浠€涔堝悕瀛?, '鏍规嵁鎼滅储缁撴灉锛屾垜鏃犳硶纭畾鎮ㄧ殑鍚嶅瓧锛屽洜涓烘悳绱㈠埌鐨勪俊鎭槸鍏充簬鈥滄潕閾庘€濃€滄潕娆ｇ弬鈥濃€滃矐闃斥€濃€滅▼浣宠鈥濈瓑涓嶅悓浜虹殑鍚嶅瓧浠嬬粛锛屼笌鎮ㄦ湰浜烘棤鍏炽€備綔涓篈I鍔╂墜锛屾垜娌℃湁璁板繂鍔熻兘锛屼篃涓嶄簡瑙ｆ偍鐨勪釜浜轰俊鎭€傚鏋滄偍鎰挎剰鍛婅瘔鎴戞偍鐨勫悕瀛楋紝鎴戝彲浠ユ洿浜插垏鍦扮О鍛兼偍锛屽苟涓烘偍鎻愪緵鏇村ソ鐨勫涔犺緟瀵兼湇鍔★紒馃槉\n\n---\n*鏈洖绛斿弬鑰冧簡鑱旂綉鎼滅储鐨勬渶鏂颁俊鎭?', 1, NULL, '2026-06-04 19:43:09');
INSERT INTO `my_ai_chat` VALUES (62, NULL, NULL, 'SESSION_1780573381452', '鎴戝姞寮犱笁', '鏍规嵁鎼滅储缁撴灉锛屾垜鎵惧埌浜嗗嚑浣嶅悕鍙€滃紶涓夆€濈殑鐢ㄦ埛淇℃伅锛屼絾鏃犳硶纭鎮ㄦ寚鐨勬槸鍝竴浣嶃€備綔涓篈I瀛︿範鍔╂墜锛屾垜娌℃湁娣诲姞濂藉弸鎴栫ぞ浜や簰鍔ㄧ殑鍔熻兘銆傚鏋滄偍鎯宠仈绯绘煇浣嶁€滃紶涓夆€濓紝寤鸿鎮ㄧ洿鎺ュ湪鐩稿叧骞冲彴锛堝鐭ヤ箮銆佽眴鐡ｇ瓑锛夋悳绱㈠叾鐢ㄦ埛鍚嶆垨ID杩涜娣诲姞銆俓n\n濡傛灉鎮ㄥ湪瀛︿範涓婇渶瑕佸府鍔╋紝姣斿鎯虫壘鈥滃紶涓夆€濆悓瀛︿竴璧疯璁轰綔涓氭垨澶嶄範锛屾垜鍙互甯偍瑙勫垝瀛︿範璁″垝鎴栨帹鑽愬涔犺祫婧愩€傝鍛婅瘔鎴戞偍鐨勫叿浣撻渶姹傦紝鎴戜細灏藉姏鍗忓姪锛侌煒奬n\n---\n*鏈洖绛斿弬鑰冧簡鑱旂綉鎼滅储鐨勬渶鏂颁俊鎭?', 1, NULL, '2026-06-04 19:43:21');

-- ----------------------------
-- Table structure for my_bank
-- ----------------------------
DROP TABLE IF EXISTS `my_bank`;
CREATE TABLE `my_bank`  (
  `hb_id` bigint NOT NULL AUTO_INCREMENT COMMENT '棰樺簱ID',
  `qb_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '棰樺簱鍚嶇О',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '棰樺簱鎻忚堪',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '棰樺簱绫诲瀷',
  `tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鏍囩',
  `teacher_id` bigint NULL DEFAULT NULL COMMENT '鍒涘缓鏁欏笀ID',
  `question_count` int NULL DEFAULT 0 COMMENT '棰樼洰鏁伴噺',
  `total_score` int NULL DEFAULT 0 COMMENT '鎬诲垎',
  `difficulty` tinyint NULL DEFAULT 2 COMMENT '闅惧害 1-绠€鍗?2-涓瓑 3-鍥伴毦',
  `status` tinyint NULL DEFAULT 1 COMMENT '鐘舵€?0-绂佺敤 1-鍚敤',
  `is_public` tinyint NULL DEFAULT 0 COMMENT '鏄惁鍏紑 0-绉佹湁 1-鍏紑',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hb_id`) USING BTREE,
  INDEX `idx_teacher_id`(`teacher_id` ASC) USING BTREE,
  INDEX `idx_type`(`type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '棰樺簱琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_bank
-- ----------------------------
INSERT INTO `my_bank` VALUES (1, 'Python鍩虹棰樺簱', 'Python鍏ラ棬閫夋嫨棰樺簱', '缂栫▼', 'Python,鍩虹', 1, 20, 100, 1, 1, 1, '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_bank` VALUES (2, '绠楁硶棰樺簱', '鏁版嵁缁撴瀯绠楁硶缁冧範棰?, '绠楁硶', '绠楁硶,闈㈣瘯', 1, 30, 150, 2, 1, 0, '2026-05-30 17:29:27', '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_course
-- ----------------------------
DROP TABLE IF EXISTS `my_course`;
CREATE TABLE `my_course`  (
  `c_id` bigint NOT NULL AUTO_INCREMENT COMMENT '璇剧▼ID',
  `c_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '璇剧▼鍚嶇О',
  `teacher_id` bigint NOT NULL COMMENT '鎺堣鏁欏笀ID',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '璇剧▼绫诲瀷',
  `tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '璇剧▼鏍囩',
  `difficulty` tinyint NULL DEFAULT 1 COMMENT '闅惧害 1-绠€鍗?2-涓瓑 3-鍥伴毦',
  `max_person` int NULL DEFAULT 50 COMMENT '鏈€澶т汉鏁?,
  `current_person` int NULL DEFAULT 0 COMMENT '褰撳墠浜烘暟',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '璇剧▼鎻忚堪',
  `cover_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '灏侀潰鍥?,
  `status` tinyint NULL DEFAULT 1 COMMENT '鐘舵€?0-涓嬫灦 1-涓婃灦',
  `start_time` datetime NULL DEFAULT NULL COMMENT '寮€璇炬椂闂?,
  `end_time` datetime NULL DEFAULT NULL COMMENT '缁撹鏃堕棿',
  `resource_id` bigint NULL DEFAULT NULL COMMENT '鍏宠仈璧勬簮ID',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '澶囨敞',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`c_id`) USING BTREE,
  INDEX `idx_teacher_id`(`teacher_id` ASC) USING BTREE,
  INDEX `idx_type`(`type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '璇剧▼琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_course
-- ----------------------------
INSERT INTO `my_course` VALUES (1, 'Python缂栫▼鍩虹', 1, '缂栫▼', 'Python,鍩虹', 1, 50, 0, 'Python缂栫▼鍏ラ棬璇剧▼', NULL, 1, '2026-06-02 17:00:00', '2026-06-02 18:00:00', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 16:59:19');
INSERT INTO `my_course` VALUES (2, '鏁版嵁缁撴瀯涓庣畻娉?, 1, '绠楁硶', '绠楁硶,鏁版嵁缁撴瀯', 2, 40, 0, '鏁版嵁缁撴瀯涓庣畻娉曟牳蹇冭绋?, NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 16:59:22');
INSERT INTO `my_course` VALUES (3, '鏈哄櫒瀛︿範鍏ラ棬', 1, 'AI', '鏈哄櫒瀛︿範,AI', 3, 30, 0, '鏈哄櫒瀛︿範鍩虹鐞嗚涓庡疄璺?, NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:38');
INSERT INTO `my_course` VALUES (4, 'Java缂栫▼瀹炴垬', 1, '缂栫▼', 'Java,鍚庣', 2, 50, 0, 'Java浼佷笟绾у紑鍙?, NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-30 17:29:27', '2026-06-02 17:00:39');
INSERT INTO `my_course` VALUES (5, '娣卞害瀛︿範瀹炴垬', 1, 'AI', '娣卞害瀛︿範,绁炵粡缃戠粶', 3, 30, 0, 'AI杩涢樁璇剧▼', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-30 17:29:27', '2026-06-03 17:00:40');
INSERT INTO `my_course` VALUES (6, 'Web鍓嶇寮€鍙戝疄鎴?, 5, '缂栫▼', '鍓嶇,Vue,JavaScript', 2, 60, 48, '浠庨浂瀛︿範Web鍓嶇寮€鍙戯紝鎺屾彙Vue3妗嗘灦', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:40');
INSERT INTO `my_course` VALUES (7, '澶ф暟鎹垎鏋愬叆闂?, 4, '鏁版嵁', '澶ф暟鎹?Hadoop,Spark', 3, 40, 35, '澶ф暟鎹鐞嗕笌鍒嗘瀽鏍稿績鎶€鏈?, NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:41');
INSERT INTO `my_course` VALUES (8, '缃戠粶瀹夊叏鍩虹', 7, '瀹夊叏', '缃戠粶瀹夊叏,娓楅€忔祴璇?, 2, 50, 42, '缃戠粶瀹夊叏鏀婚槻鍩虹璇剧▼', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-03 19:03:26');
INSERT INTO `my_course` VALUES (9, '鑷劧璇█澶勭悊', 6, 'AI', 'NLP,娣卞害瀛︿範,Transformer', 3, 30, 28, 'NLP鏍稿績绠楁硶涓庡簲鐢ㄥ疄鎴?, NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:42');
INSERT INTO `my_course` VALUES (10, '浜戣绠椾笌瀹瑰櫒鎶€鏈?, 4, '杩愮淮', 'Docker,K8s,浜戝師鐢?, 2, 45, 38, 'Docker鍜孠ubernetes瀹炴垬', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:42');
INSERT INTO `my_course` VALUES (11, '鏁版嵁搴撶郴缁熷師鐞?, 8, '鏁版嵁搴?, 'MySQL,Redis,SQL', 2, 55, 50, '鍏崇郴鍨嬩笌闈炲叧绯诲瀷鏁版嵁搴?, NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-03 19:04:40');
INSERT INTO `my_course` VALUES (12, '绉诲姩搴旂敤寮€鍙?, 5, '绉诲姩', 'Android,iOS,Flutter', 2, 40, 32, '璺ㄥ钩鍙扮Щ鍔ㄥ簲鐢ㄥ紑鍙?, NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:44');
INSERT INTO `my_course` VALUES (13, '杞欢宸ョ▼涓嶶ML', 2, '宸ョ▼', 'UML,鏁忔嵎寮€鍙?璁捐妯″紡', 1, 60, 55, '杞欢宸ョ▼鐞嗚涓庡疄璺?, NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:44');
INSERT INTO `my_course` VALUES (14, '璁＄畻鏈哄浘褰㈠', 3, '鍥惧舰', 'OpenGL,WebGL,娓叉煋', 3, 25, 20, '璁＄畻鏈哄浘褰㈠鍩虹绠楁硶', NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-02 17:00:45');
INSERT INTO `my_course` VALUES (15, '鍖哄潡閾炬妧鏈笌搴旂敤', 5, '鍖哄潡閾?, '鍖哄潡閾?鏅鸿兘鍚堢害,Web3', 3, 35, 30, '鍖哄潡閾惧師鐞嗕笌DApp寮€鍙?, NULL, 1, '2026-06-02 17:00:00', '2026-06-04 17:58:23', NULL, NULL, '2026-05-27 00:13:29', '2026-06-03 19:03:15');

-- ----------------------------
-- Table structure for my_course_appointment
-- ----------------------------
DROP TABLE IF EXISTS `my_course_appointment`;
CREATE TABLE `my_course_appointment`  (
  `ca_id` bigint NOT NULL AUTO_INCREMENT COMMENT '棰勭害ID',
  `stu_id` bigint NOT NULL COMMENT '瀛︾敓ID',
  `c_id` bigint NOT NULL COMMENT '璇剧▼ID',
  `appointment_time` datetime NULL DEFAULT NULL COMMENT '棰勭害鏃堕棿',
  `status` tinyint NULL DEFAULT 0 COMMENT '鐘舵€?0-寰呯‘璁?1-宸茬‘璁?2-宸插彇娑?3-宸插畬鎴?,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '澶囨敞',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ca_id`) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '璇剧▼棰勭害琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_course_appointment
-- ----------------------------
INSERT INTO `my_course_appointment` VALUES (1, 1, 1, '2026-05-30 17:29:27', 1, '棰勭害Python璇剧▼', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_course_appointment` VALUES (2, 2, 2, '2026-05-30 17:29:27', 0, '寰呯‘璁ゆ暟鎹粨鏋勮绋?, '2026-05-30 17:29:27', '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_course_resource
-- ----------------------------
DROP TABLE IF EXISTS `my_course_resource`;
CREATE TABLE `my_course_resource`  (
  `re_id` bigint NOT NULL AUTO_INCREMENT COMMENT '璧勬簮ID',
  `c_id` bigint NULL DEFAULT NULL COMMENT '鍏宠仈璇剧▼ID',
  `resource_type` tinyint NOT NULL COMMENT '璧勬簮绫诲瀷 1-瑙嗛 2-鍥句功 4-鏈熷垔 5-璁插骇',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '璧勬簮鏍囬',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '璧勬簮鍐呭/鎻忚堪',
  `file_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鏂囦欢閾炬帴',
  `video_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '瑙嗛閾炬帴',
  `homework` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '浣滀笟鍐呭',
  `sort_order` int NULL DEFAULT 0 COMMENT '鎺掑簭',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`re_id`) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_resource_type`(`resource_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '璇剧▼璧勬簮琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_course_resource
-- ----------------------------
INSERT INTO `my_course_resource` VALUES (1, 1, 1, 'Python鐜鎼缓', '<p>Python瀹夎涓庨厤缃?/p>', NULL, 'https://video.com/python1', '瀹屾垚鐜瀹夎', 1, '2026-05-30 17:29:27', 'Python,鐜');
INSERT INTO `my_course_resource` VALUES (2, 1, 2, 'Python鍩虹璇硶', '鍙橀噺銆佹暟鎹被鍨?, '/files/python_basic.pdf', NULL, '瀹屾垚璇惧悗涔犻', 2, '2026-05-30 17:29:27', 'Python,璇硶');

-- ----------------------------
-- Table structure for my_error_book
-- ----------------------------
DROP TABLE IF EXISTS `my_error_book`;
CREATE TABLE `my_error_book`  (
  `eb_id` bigint NOT NULL AUTO_INCREMENT COMMENT '閿欓璁板綍ID',
  `stu_id` bigint NOT NULL COMMENT '瀛︾敓ID',
  `hq_id` bigint NULL DEFAULT NULL COMMENT '棰樼洰ID',
  `c_id` bigint NULL DEFAULT NULL COMMENT '璇剧▼ID',
  `wrong_answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '閿欒绛旀',
  `correct_answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '姝ｇ‘绛旀',
  `analysis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '瑙ｆ瀽',
  `tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鏍囩/鐭ヨ瘑鐐?,
  `error_count` int NULL DEFAULT 1 COMMENT '閿欒娆℃暟',
  `is_mastered` tinyint NULL DEFAULT 0 COMMENT '鏄惁宸叉帉鎻?0-鍚?1-鏄?,
  `last_wrong_time` datetime NULL DEFAULT NULL COMMENT '鏈€鍚庨敊璇椂闂?,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`eb_id`) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_is_mastered`(`is_mastered` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '閿欓鏈〃' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_error_book
-- ----------------------------
INSERT INTO `my_error_book` VALUES (1, 1, 1, 1, 'B', 'A', '鑰冨療鍒楄〃鍘婚噸鐭ヨ瘑鐐?, 'Python,鍘婚噸', 2, 0, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_error_book` VALUES (2, 2, 2, 2, '鍓嶅簭', '涓簭', '鑰冨療浜屽弶鏍戦亶鍘?, '绠楁硶,浜屽弶鏍?, 1, 1, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_error_book` VALUES (3, 1, 3, 1, 'C', 'D', '鑰冨療瀛楀吀鎿嶄綔', 'Python,瀛楀吀', 3, 0, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_error_book` VALUES (4, 1, 4, 2, 'A', 'B', '鑰冨療閫掑綊绠楁硶', '绠楁硶,閫掑綊', 2, 0, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_error_book` VALUES (5, 6, 5, 1, 'B', 'A', '鑰冨療鍒楄〃鍒囩墖', 'Python,鍒楄〃', 4, 0, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_error_book` VALUES (6, 6, 6, 2, 'C', 'D', '鑰冨療鍔ㄦ€佽鍒?, '绠楁硶,鍔ㄦ€佽鍒?, 3, 0, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_error_book` VALUES (7, 10, 7, 1, 'A', 'C', '鑰冨療鍑芥暟瀹氫箟', 'Python,鍑芥暟', 2, 0, '2026-06-01 17:29:27', '2026-06-01 17:29:27', '2026-06-01 17:29:27');
INSERT INTO `my_error_book` VALUES (8, 10, 8, 2, 'B', 'A', '鑰冨療璐績绠楁硶', '绠楁硶,璐績', 3, 0, '2026-06-01 17:29:27', '2026-06-01 17:29:27', '2026-06-01 17:29:27');
INSERT INTO `my_error_book` VALUES (9, 2, 9, 4, 'D', 'C', '鑰冨療闈㈠悜瀵硅薄', 'Java,闈㈠悜瀵硅薄', 3, 0, '2026-06-01 17:29:27', '2026-06-01 17:29:27', '2026-06-01 17:29:27');
INSERT INTO `my_error_book` VALUES (10, 2, 10, 2, 'A', 'B', '鑰冨療鎺掑簭绠楁硶', '绠楁硶,鎺掑簭', 2, 0, '2026-06-01 17:29:27', '2026-06-01 17:29:27', '2026-06-01 17:29:27');
INSERT INTO `my_error_book` VALUES (11, 7, 11, 4, 'C', 'A', '鑰冨療寮傚父澶勭悊', 'Java,寮傚父', 4, 0, '2026-06-01 17:29:27', '2026-06-01 17:29:27', '2026-06-01 17:29:27');
INSERT INTO `my_error_book` VALUES (12, 7, 12, 2, 'B', 'D', '鑰冨療鎼滅储绠楁硶', '绠楁硶,鎼滅储', 3, 0, '2026-06-01 17:29:27', '2026-06-01 17:29:27', '2026-06-01 17:29:27');
INSERT INTO `my_error_book` VALUES (13, 11, 13, 4, 'A', 'B', '鑰冨療闆嗗悎妗嗘灦', 'Java,闆嗗悎', 2, 0, '2026-06-02 17:29:27', '2026-06-02 17:29:27', '2026-06-02 17:29:27');
INSERT INTO `my_error_book` VALUES (14, 11, 14, 2, 'C', 'A', '鑰冨療鍥捐绠楁硶', '绠楁硶,鍥捐', 3, 0, '2026-06-02 17:29:27', '2026-06-02 17:29:27', '2026-06-02 18:57:07');
INSERT INTO `my_error_book` VALUES (15, 3, 15, 3, 'B', 'A', '鑰冨療绁炵粡缃戠粶', 'AI,绁炵粡缃戠粶', 2, 0, '2026-06-02 17:29:27', '2026-06-02 17:29:27', '2026-06-02 18:57:01');
INSERT INTO `my_error_book` VALUES (16, 3, 16, 5, 'C', 'D', '鑰冨療CNN缁撴瀯', 'AI,CNN', 3, 0, '2026-06-02 17:29:27', '2026-06-02 17:29:27', '2026-06-02 18:56:47');
INSERT INTO `my_error_book` VALUES (17, 8, 17, 3, 'A', 'B', '鑰冨療姊害涓嬮檷', 'AI,浼樺寲绠楁硶', 2, 0, '2026-06-02 17:29:27', '2026-06-02 17:29:27', '2026-06-02 17:29:27');
INSERT INTO `my_error_book` VALUES (18, 8, 18, 5, 'D', 'A', '鑰冨療RNN缁撴瀯', 'AI,RNN', 3, 0, '2026-06-02 17:29:27', '2026-06-02 17:29:27', '2026-06-02 17:29:27');
INSERT INTO `my_error_book` VALUES (19, 4, 19, 8, 'B', 'A', '鑰冨療TCP/IP鍗忚', '缃戠粶,鍗忚', 3, 0, '2026-06-02 17:29:27', '2026-06-02 17:29:27', '2026-06-02 17:29:27');
INSERT INTO `my_error_book` VALUES (20, 4, 20, 8, 'C', 'D', '鑰冨療闃茬伀澧欓厤缃?, '缃戠粶,瀹夊叏', 2, 0, '2026-06-03 17:29:27', '2026-06-03 17:29:27', '2026-06-02 18:56:13');
INSERT INTO `my_error_book` VALUES (21, 9, 21, 8, 'A', 'B', '鑰冨療瀛愮綉鍒掑垎', '缃戠粶,瀛愮綉', 4, 0, '2026-06-03 17:29:27', '2026-06-03 17:29:27', '2026-06-03 17:29:27');
INSERT INTO `my_error_book` VALUES (22, 9, 22, 8, 'D', 'C', '鑰冨療璺敱鍗忚', '缃戠粶,璺敱', 3, 0, '2026-06-03 17:29:27', '2026-06-03 17:29:27', '2026-06-03 17:29:27');

-- ----------------------------
-- Table structure for my_global_report
-- ----------------------------
DROP TABLE IF EXISTS `my_global_report`;
CREATE TABLE `my_global_report`  (
  `gr_id` bigint NOT NULL AUTO_INCREMENT COMMENT '鎶ヨ〃ID',
  `std_id` bigint NULL DEFAULT NULL,
  `teacher_id` bigint NULL DEFAULT NULL,
  `report_type` tinyint NOT NULL COMMENT '鎶ヨ〃绫诲瀷 1-鏃ユ姤 2-鍛ㄦ姤 3-鏈堟姤 4-骞存姤',
  `report_date` date NOT NULL COMMENT '鎶ヨ〃鏃ユ湡',
  `total_students` int NULL DEFAULT 0 COMMENT '鎬诲鐢熸暟',
  `total_teachers` int NULL DEFAULT 0 COMMENT '鎬绘暀甯堟暟',
  `total_courses` int NULL DEFAULT 0 COMMENT '鎬昏绋嬫暟',
  `active_students` int NULL DEFAULT 0 COMMENT '娲昏穬瀛︾敓鏁?,
  `new_students` int NULL DEFAULT 0 COMMENT '鏂板瀛︾敓鏁?,
  `completed_homework_count` int NULL DEFAULT 0 COMMENT '瀹屾垚浣滀笟鏁?,
  `average_correct_rate` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '骞冲潎姝ｇ‘鐜?,
  `total_study_hours` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '鎬诲涔犳椂闀?,
  `data_json` json NULL COMMENT '璇︾粏缁熻鏁版嵁',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`gr_id`) USING BTREE,
  UNIQUE INDEX `uk_type_date`(`report_type` ASC, `report_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '鍏ㄥ眬鏁版嵁鎶ヨ〃缁熻琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_global_report
-- ----------------------------
INSERT INTO `my_global_report` VALUES (1, NULL, NULL, 1, '2026-05-30', 2, 1, 5, 2, 0, 5, 85.50, 25.50, '{\"data\": \"缁熻鏁版嵁\"}', '2026-05-30 17:29:27');
INSERT INTO `my_global_report` VALUES (2, NULL, NULL, 2, '2026-05-23', 2, 1, 5, 2, 0, 20, 82.30, 100.00, '{\"data\": \"鍛ㄧ粺璁"}', '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_homework
-- ----------------------------
DROP TABLE IF EXISTS `my_homework`;
CREATE TABLE `my_homework`  (
  `hw_id` bigint NOT NULL AUTO_INCREMENT COMMENT '浣滀笟ID',
  `std_id` bigint NULL DEFAULT NULL COMMENT '瀛︾敓ID',
  `c_id` bigint NOT NULL COMMENT '璇剧▼ID',
  `teacher_id` bigint NOT NULL COMMENT '鍙戝竷鏁欏笀ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '浣滀笟鏍囬',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '浣滀笟鍐呭',
  `type` tinyint NULL DEFAULT 1 COMMENT '浣滀笟绫诲瀷 1-瀹㈣棰?2-涓昏棰?3-娣峰悎',
  `total_score` int NULL DEFAULT 100 COMMENT '鎬诲垎',
  `deadline` datetime NULL DEFAULT NULL COMMENT '鎴鏃堕棿',
  `status` tinyint NULL DEFAULT 0 COMMENT '鐘舵€?0-鏈彁浜?1-宸叉彁浜?2-宸叉壒鏀?,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hw_id`) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_teacher_id`(`teacher_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '浣滀笟琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_homework
-- ----------------------------
INSERT INTO `my_homework` VALUES (1, 1, 1, 3, '鏁板', '瀵兼暟搴旂敤涔犻闆?, 1, 100, '2026-06-02 17:29:27', 1, '2026-05-27 18:55:53', '2026-06-03 19:04:23');
INSERT INTO `my_homework` VALUES (2, 2, 2, 5, '鏁版嵁缁撴瀯浣滀笟', '閾捐〃鎿嶄綔缁冧範棰?, 1, 100, '2026-06-02 17:29:27', 1, '2026-05-30 17:29:27', '2026-06-03 19:04:25');
INSERT INTO `my_homework` VALUES (3, 3, 3, 6, '鏈哄櫒瀛︿範浣滀笟', '妯″瀷璁粌浣滀笟', 2, 100, '2026-06-06 17:29:27', 1, '2026-05-30 17:29:27', '2026-06-03 19:04:26');

-- ----------------------------
-- Table structure for my_homework_bank
-- ----------------------------
DROP TABLE IF EXISTS `my_homework_bank`;
CREATE TABLE `my_homework_bank`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `b_id` bigint NULL DEFAULT NULL COMMENT '棰樼洰ID',
  `hw_id` bigint NULL DEFAULT NULL COMMENT '浣滀笟id',
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
  `noti_id` bigint NOT NULL AUTO_INCREMENT COMMENT '閫氱煡ID',
  `sender_id` bigint NULL DEFAULT NULL COMMENT '鍙戦€佽€匢D',
  `sender_type` tinyint NULL DEFAULT 2 COMMENT '鍙戦€佽€呯被鍨?1-绯荤粺 2-鏁欏笀 3-绠＄悊鍛?,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '閫氱煡鏍囬',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '閫氱煡鍐呭',
  `target_type` tinyint NULL DEFAULT 1 COMMENT '鐩爣绫诲瀷 1-鍏ㄩ儴 2-鎸囧畾瀛︾敓 3-鎸囧畾鐝骇',
  `target_ids` json NULL COMMENT '鐩爣瀵硅薄ID鍒楄〃',
  `priority` tinyint NULL DEFAULT 1 COMMENT '浼樺厛绾?1-鏅€?2-閲嶈 3-绱ф€?,
  `is_top` tinyint NULL DEFAULT 0 COMMENT '鏄惁缃《 0-鍚?1-鏄?,
  `status` tinyint NULL DEFAULT 1 COMMENT '鐘舵€?0-鑽夌 1-宸插彂甯?2-宸叉挙鍥?,
  `publish_time` datetime NULL DEFAULT NULL COMMENT '鍙戝竷鏃堕棿',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`noti_id`) USING BTREE,
  INDEX `idx_sender_id`(`sender_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_publish_time`(`publish_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '閫氱煡琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_notification
-- ----------------------------
INSERT INTO `my_notification` VALUES (1, 1, 2, '璇剧▼寮€璇炬彁閱?, 'Python璇剧▼鍗冲皢寮€濮嬶紝璇峰噯鏃跺涔?, 1, NULL, 2, 1, 1, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_notification` VALUES (2, 3, 2, '浣滀笟鎴鎻愰啋', '璇峰強鏃跺畬鎴愭湰鍛ㄤ綔涓?, 2, '[1, 2]', 1, 0, 1, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_question
-- ----------------------------
DROP TABLE IF EXISTS `my_question`;
CREATE TABLE `my_question`  (
  `q_id` bigint NOT NULL AUTO_INCREMENT COMMENT '棰樼洰ID',
  `hw_id` bigint NOT NULL COMMENT '浣滀笟ID',
  `question_type` tinyint NOT NULL COMMENT '棰樺瀷 1-鍗曢€?2-澶氶€?3-鍒ゆ柇 4-濉┖ 5-绠€绛?,
  `question_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '棰樼洰鍐呭',
  `options` json NULL COMMENT '閫夐」(JSON鏍煎紡)',
  `correct_answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '姝ｇ‘绛旀',
  `score` int NULL DEFAULT 10 COMMENT '鍒嗗€?,
  `difficulty` tinyint NULL DEFAULT 2 COMMENT '闅惧害 1-绠€鍗?2-涓瓑 3-鍥伴毦',
  `sort_order` int NULL DEFAULT 0 COMMENT '鎺掑簭',
  PRIMARY KEY (`q_id`) USING BTREE,
  INDEX `idx_hw_id`(`hw_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '浣滀笟棰樼洰琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_question
-- ----------------------------
INSERT INTO `my_question` VALUES (1, 1, 1, 'Python涓畾涔夊嚱鏁扮殑鍏抽敭瀛楁槸锛?, '{\"A\": \"func\", \"B\": \"def\", \"C\": \"function\", \"D\": \"define\"}', 'B', 10, 1, 1);
INSERT INTO `my_question` VALUES (2, 1, 2, '浠ヤ笅灞炰簬Python鏁版嵁绫诲瀷鐨勬湁锛?, '{\"A\": \"int\", \"B\": \"float\", \"C\": \"char\", \"D\": \"list\"}', 'A,B,D', 10, 1, 2);
INSERT INTO `my_question` VALUES (3, 2, 3, '閾捐〃鍙互闅忔満璁块棶浠绘剰鑺傜偣锛?, '{\"A\": \"姝ｇ‘\", \"B\": \"閿欒\"}', 'B', 5, 2, 1);

-- ----------------------------
-- Table structure for my_question_bank
-- ----------------------------
DROP TABLE IF EXISTS `my_question_bank`;
CREATE TABLE `my_question_bank`  (
  `id` int NOT NULL COMMENT '涓婚敭id',
  `b_id` bigint NOT NULL COMMENT '棰樺簱id',
  `q_id` bigint NULL DEFAULT NULL COMMENT '棰樼洰id',
  `score` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鍒嗘暟',
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
  `rank_id` int NOT NULL AUTO_INCREMENT COMMENT '娈典綅ID',
  `rank_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '娈典綅鍚嶇О',
  `rank_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '娈典綅鍥炬爣',
  `min_score` int NOT NULL COMMENT '鏈€浣庣Н鍒?,
  `max_score` int NOT NULL COMMENT '鏈€楂樼Н鍒?,
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '娈典綅棰滆壊',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '娈典綅鎻忚堪',
  `sort_order` int NULL DEFAULT 0 COMMENT '鎺掑簭',
  PRIMARY KEY (`rank_id`) USING BTREE,
  UNIQUE INDEX `uk_rank_name`(`rank_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '娈典綅閰嶇疆琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_rank_config
-- ----------------------------
INSERT INTO `my_rank_config` VALUES (1, '闈掗摐', '/images/rank/bronze.png', 0, 99, '#CD7F32', '鍒濆叆瀛︿範涔嬭矾', 1);
INSERT INTO `my_rank_config` VALUES (2, '鐧介摱', '/images/rank/silver.png', 100, 299, '#C0C0C0', '瀛︿範娓愬叆浣冲', 2);
INSERT INTO `my_rank_config` VALUES (3, '榛勯噾', '/images/rank/gold.png', 300, 599, '#FFD700', '瀛︿範鑳藉姏鎻愬崌', 3);
INSERT INTO `my_rank_config` VALUES (4, '閾傞噾', '/images/rank/platinum.png', 600, 999, '#E5E4E2', '瀛︿範琛ㄧ幇浼樼', 4);
INSERT INTO `my_rank_config` VALUES (5, '閽荤煶', '/images/rank/diamond.png', 1000, 1499, '#B9F2FF', '瀛︿範鑳藉姏鍗撹秺', 5);
INSERT INTO `my_rank_config` VALUES (6, '鏄熻€€', '/images/rank/star.png', 1500, 2099, '#9370DB', '瀛︿範涔嬫槦', 6);
INSERT INTO `my_rank_config` VALUES (7, '鐜嬭€?, '/images/rank/king.png', 2100, 999999, '#FF4500', '瀛︿範鐜嬭€?, 7);

-- ----------------------------
-- Table structure for my_student
-- ----------------------------
DROP TABLE IF EXISTS `my_student`;
CREATE TABLE `my_student`  (
  `stu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '瀛︾敓ID',
  `user_id` bigint NOT NULL COMMENT '鍏宠仈鐢ㄦ埛ID',
  `student_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '瀛﹀彿',
  `major` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '涓撲笟',
  `grade` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '骞寸骇',
  `class_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鐝骇',
  `birthday` date NULL DEFAULT NULL COMMENT '鐢熸棩',
  `teacher_id` bigint NULL DEFAULT NULL COMMENT '鍏宠仈鏁欏笀ID',
  `rank_level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '闈掗摐' COMMENT '褰撳墠娈典綅',
  `rank_score` int NULL DEFAULT 0 COMMENT '娈典綅绉垎',
  `total_questions` int NULL DEFAULT 0 COMMENT '鎬诲仛棰樻暟',
  `correct_questions` int NOT NULL DEFAULT 0 COMMENT '姝ｇ‘棰樻暟',
  `study_hours` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '瀛︿範鏃堕暱(灏忔椂)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`stu_id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_teacher_id`(`teacher_id` ASC) USING BTREE,
  INDEX `idx_rank_level`(`rank_level` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '瀛︾敓淇℃伅琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_student
-- ----------------------------
INSERT INTO `my_student` VALUES (1, 1, '2024001', '璁＄畻鏈虹瀛?, '2024绾?, '璁＄1鐝?, '2026-05-28', 1, '鐧介摱', 150, 50, 35, 12.50, '2026-05-27 00:13:29', '2026-06-02 18:00:40');
INSERT INTO `my_student` VALUES (2, 2, '2024002', '杞欢宸ョ▼', '2024绾?, '杞伐1鐝?, '2026-06-21', 1, '闈掗摐', 80, 30, 20, 8.00, '2026-05-27 00:13:29', '2026-06-02 18:00:43');
INSERT INTO `my_student` VALUES (3, 9, '2024003', '浜哄伐鏅鸿兘', '2024绾?, '鏅鸿兘1鐝?, '2026-03-26', 1, '闈掗摐', 50, 20, 10, 5.00, '2026-05-30 17:29:27', '2026-06-02 18:00:48');
INSERT INTO `my_student` VALUES (4, 10, '2024004', '缃戠粶宸ョ▼', '2024绾?, '缃戠粶1鐝?, '2026-09-12', 1, '鐧介摱', 180, 60, 45, 15.00, '2026-05-30 17:29:27', '2026-06-02 18:00:52');
INSERT INTO `my_student` VALUES (5, 11, '202401203027', '鏈哄櫒浜哄伐绋?, '24绾?, '鏈哄櫒浜?鐝?, '2026-05-06', 3, '鐜嬭€?, 9999, 100, 100, 100.00, '2026-05-31 23:49:39', '2026-06-02 18:00:13');
INSERT INTO `my_student` VALUES (6, 12, '2024005', '璁＄畻鏈虹瀛?, '2024绾?, '璁＄1鐝?, '2005-08-22', 1, '鐧介摱', 180, 60, 45, 15.50, '2026-05-27 00:13:29', '2026-06-02 18:01:09');
INSERT INTO `my_student` VALUES (7, 13, '2024006', '杞欢宸ョ▼', '2024绾?, '杞伐1鐝?, '2004-07-10', 2, '闈掗摐', 120, 40, 28, 10.00, '2026-05-27 00:13:29', '2026-06-02 18:01:17');
INSERT INTO `my_student` VALUES (8, 14, '2024007', '浜哄伐鏅鸿兘', '2024绾?, '鏅鸿兘1鐝?, '2006-11-24', 3, '榛勯噾', 220, 80, 65, 18.00, '2026-05-27 00:13:29', '2026-06-02 18:01:27');

-- ----------------------------
-- Table structure for my_student_course
-- ----------------------------
DROP TABLE IF EXISTS `my_student_course`;
CREATE TABLE `my_student_course`  (
  `sc_id` bigint NOT NULL AUTO_INCREMENT COMMENT '閫夎璁板綍ID',
  `stu_id` bigint NOT NULL COMMENT '瀛︾敓ID',
  `c_id` bigint NOT NULL COMMENT '璇剧▼ID',
  `sign_time` datetime NULL DEFAULT NULL COMMENT '閫夎鏃堕棿',
  `status` tinyint NULL DEFAULT 1 COMMENT '鐘舵€?0-閫€璇?1-杩涜涓?2-宸插畬鎴?,
  `progress` int NULL DEFAULT 0 COMMENT '瀛︿範杩涘害鐧惧垎姣?,
  `score` decimal(5, 2) NULL DEFAULT NULL COMMENT '璇剧▼鎴愮哗',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '澶囨敞',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sc_id`) USING BTREE,
  UNIQUE INDEX `uk_stu_course`(`stu_id` ASC, `c_id` ASC) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '瀛︾敓閫夎琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_student_course
-- ----------------------------
INSERT INTO `my_student_course` VALUES (1, 1, 1, '2026-05-30 17:29:27', 1, 30, 90.00, '瀛︿範涓?, '2026-05-30 17:29:27', '2026-06-04 20:31:54');
INSERT INTO `my_student_course` VALUES (2, 1, 2, '2026-05-30 17:29:27', 1, 10, 100.00, '瀛︿範涓?, '2026-05-30 17:29:27', '2026-06-04 20:31:59');
INSERT INTO `my_student_course` VALUES (3, 2, 1, '2026-05-30 17:29:27', 1, 50, 90.00, '宸插畬鎴?, '2026-05-30 17:29:27', '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_student_homework
-- ----------------------------
DROP TABLE IF EXISTS `my_student_homework`;
CREATE TABLE `my_student_homework`  (
  `sh_id` bigint NOT NULL AUTO_INCREMENT COMMENT '鎻愪氦璁板綍ID',
  `stu_id` bigint NOT NULL COMMENT '瀛︾敓ID',
  `hw_id` bigint NOT NULL COMMENT '浣滀笟ID',
  `answers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '绛旈鍐呭(JSON)',
  `score` decimal(5, 2) NULL DEFAULT NULL COMMENT '寰楀垎',
  `teacher_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鏁欏笀璇勮',
  `status` tinyint NULL DEFAULT 0 COMMENT '鐘舵€?0-鏈彁浜?1-宸叉彁浜?2-宸叉壒鏀?,
  `submit_time` datetime NULL DEFAULT NULL COMMENT '鎻愪氦鏃堕棿',
  `correct_time` datetime NULL DEFAULT NULL COMMENT '鎵规敼鏃堕棿',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sh_id`) USING BTREE,
  UNIQUE INDEX `uk_stu_hw`(`stu_id` ASC, `hw_id` ASC) USING BTREE,
  INDEX `idx_hw_id`(`hw_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '瀛︾敓浣滀笟鎻愪氦琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_student_homework
-- ----------------------------
INSERT INTO `my_student_homework` VALUES (1, 1, 1, '{\"1\": \"B\", \"2\": \"A,B,D\"}', 95.00, '瀹屾垚浼樼', 2, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_student_homework` VALUES (2, 2, 1, '{\"1\": \"A\", \"2\": \"A\"}', 40.00, '闇€瑕佸姞寮?, 2, '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_student_homework` VALUES (3, 1, 2, NULL, NULL, NULL, 0, NULL, NULL, '2026-05-30 17:29:27', '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_student_notification
-- ----------------------------
DROP TABLE IF EXISTS `my_student_notification`;
CREATE TABLE `my_student_notification`  (
  `sn_id` bigint NOT NULL AUTO_INCREMENT COMMENT '璁板綍ID',
  `stu_id` bigint NOT NULL COMMENT '瀛︾敓ID',
  `noti_id` bigint NOT NULL COMMENT '閫氱煡ID',
  `is_read` tinyint NULL DEFAULT 0 COMMENT '鏄惁宸茶 0-鍚?1-鏄?,
  `read_time` datetime NULL DEFAULT NULL COMMENT '闃呰鏃堕棿',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sn_id`) USING BTREE,
  UNIQUE INDEX `uk_stu_noti`(`stu_id` ASC, `noti_id` ASC) USING BTREE,
  INDEX `idx_noti_id`(`noti_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '瀛︾敓閫氱煡闃呰璁板綍琛? ROW_FORMAT = DYNAMIC;

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
  `stu_id` bigint NULL DEFAULT NULL COMMENT '瀛︾敓id',
  `q_id` bigint NULL DEFAULT NULL COMMENT '棰樼洰id',
  `score` int NULL DEFAULT NULL COMMENT '寰楀垎',
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
  `sr_id` bigint NOT NULL AUTO_INCREMENT COMMENT '璁板綍ID',
  `stu_id` bigint NOT NULL COMMENT '瀛︾敓ID',
  `c_id` bigint NULL DEFAULT NULL COMMENT '璇剧▼ID',
  `study_type` tinyint NOT NULL COMMENT '瀛︿範绫诲瀷 1-瑙嗛 2-鏂囨。 3-鍋氶 4-鍏朵粬',
  `study_duration` int NULL DEFAULT NULL COMMENT '瀛︿範鏃堕暱(鍒嗛挓)',
  `study_date` date NULL DEFAULT NULL COMMENT '瀛︿範鏃ユ湡',
  `progress` int NULL DEFAULT 0 COMMENT '杩涘害鐧惧垎姣?,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sr_id`) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE,
  INDEX `idx_c_id`(`c_id` ASC) USING BTREE,
  INDEX `idx_study_date`(`study_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '瀛︿範璁板綍琛? ROW_FORMAT = DYNAMIC;

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
  `report_id` bigint NOT NULL AUTO_INCREMENT COMMENT '鎶ヨ〃ID',
  `stu_id` bigint NOT NULL COMMENT '瀛︾敓ID',
  `report_type` tinyint NOT NULL COMMENT '鎶ヨ〃绫诲瀷 1-鏃ユ姤 2-鍛ㄦ姤 3-鏈堟姤',
  `report_date` date NOT NULL COMMENT '鎶ヨ〃鏃ユ湡',
  `study_duration` int NULL DEFAULT 0 COMMENT '瀛︿範鏃堕暱(鍒嗛挓)',
  `completed_courses` int NULL DEFAULT 0 COMMENT '瀹屾垚璇剧▼鏁?,
  `completed_homework` int NULL DEFAULT 0 COMMENT '瀹屾垚浣滀笟鏁?,
  `correct_rate` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '姝ｇ‘鐜?,
  `rank_score_change` int NULL DEFAULT 0 COMMENT '绉垎鍙樺寲',
  `weak_points` json NULL COMMENT '钖勫急鐭ヨ瘑鐐?,
  `strengths` json NULL COMMENT '浼樺娍鐭ヨ瘑鐐?,
  `suggestions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '瀛︿範寤鸿',
  `data_json` json NULL COMMENT '璇︾粏鏁版嵁',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`report_id`) USING BTREE,
  UNIQUE INDEX `uk_stu_type_date`(`stu_id` ASC, `report_type` ASC, `report_date` ASC) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '瀛︽儏鎶ヨ〃鏁版嵁琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_study_report
-- ----------------------------
INSERT INTO `my_study_report` VALUES (1, 1, 1, '2026-05-30', 75, 0, 1, 95.00, 10, '[\"绠楁硶\"]', '[\"Python鍩虹\"]', '鍔犲己绠楁硶缁冧範', '{\"data\": \"鏃ユ姤鏁版嵁\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (2, 2, 1, '2026-05-30', 60, 0, 1, 40.00, -5, '[\"Python璇硶\"]', '[\"鏃燶"]', '鍔犲己鍩虹瀛︿範', '{\"data\": \"鏃ユ姤鏁版嵁\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (3, 6, 2, '2026-05-30', 80, 1, 2, 88.50, 15, '[\"绠楁硶\"]', '[\"Python鍩虹\"]', '淇濇寔浼樺娍锛屽姞寮虹畻娉?, '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (4, 10, 2, '2026-05-30', 95, 2, 3, 92.00, 20, '[\"鏃燶"]', '[\"鏁版嵁缁撴瀯\"]', '琛ㄧ幇浼樼锛岀户缁繚鎸?, '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (5, 1, 2, '2026-05-23', 70, 1, 2, 85.00, 10, '[\"绠楁硶\"]', '[\"Python鍩虹\"]', '鍔犲己绠楁硶缁冧範', '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (6, 6, 2, '2026-05-23', 75, 1, 1, 86.00, 12, '[\"鏁版嵁缁撴瀯\"]', '[\"Python鍩虹\"]', '澶氱粌涔犳暟鎹粨鏋?, '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (7, 10, 2, '2026-05-23', 90, 2, 2, 90.00, 18, '[\"鏃燶"]', '[\"绠楁硶\"]', '缁х画淇濇寔', '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (8, 7, 2, '2026-05-30', 65, 1, 1, 78.00, 8, '[\"绠楁硶\", \"鏁版嵁缁撴瀯\"]', '[\"Java鍩虹\"]', '鍔犲己鍩虹绠楁硶', '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (9, 11, 2, '2026-05-30', 70, 1, 2, 82.00, 10, '[\"鏁版嵁缁撴瀯\"]', '[\"Java鍩虹\"]', '澶氱粌涔犳暟鎹粨鏋?, '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (10, 2, 2, '2026-05-30', 60, 0, 1, 75.00, 5, '[\"绠楁硶\", \"Python璇硶\"]', '[\"鏃燶"]', '鍔犲己鍩虹瀛︿範', '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (11, 7, 2, '2026-05-23', 60, 1, 1, 76.00, 6, '[\"绠楁硶\"]', '[\"Java鍩虹\"]', '鍔犲己绠楁硶缁冧範', '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (12, 11, 2, '2026-05-23', 65, 1, 1, 80.00, 8, '[\"鏁版嵁缁撴瀯\"]', '[\"Java鍩虹\"]', '澶氱粌涔犳暟鎹粨鏋?, '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (13, 8, 2, '2026-05-30', 100, 2, 3, 95.00, 25, '[\"鏃燶"]', '[\"鏈哄櫒瀛︿範\", \"娣卞害瀛︿範\"]', '琛ㄧ幇浼樼锛屾寫鎴樻洿楂橀毦搴?, '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (14, 3, 2, '2026-05-30', 85, 1, 2, 88.00, 15, '[\"娣卞害瀛︿範\"]', '[\"鏈哄櫒瀛︿範\"]', '鍔犲己娣卞害瀛︿範鐞嗚', '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (15, 8, 2, '2026-05-23', 95, 2, 3, 93.00, 22, '[\"鏃燶"]', '[\"鏈哄櫒瀛︿範\"]', '缁х画淇濇寔', '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (16, 3, 2, '2026-05-23', 80, 1, 2, 85.00, 12, '[\"娣卞害瀛︿範\"]', '[\"鏈哄櫒瀛︿範\"]', '澶氶槄璇昏鏂?, '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (17, 9, 2, '2026-05-30', 72, 1, 2, 80.00, 10, '[\"缃戠粶瀹夊叏\"]', '[\"缃戠粶鍩虹\"]', '鍔犲己瀹夊叏瀹炶返', '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (18, 4, 2, '2026-05-30', 78, 1, 2, 83.00, 12, '[\"缃戠粶瀹夊叏\"]', '[\"缃戠粶鍩虹\"]', '澶氱粌涔犳笚閫忔祴璇?, '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-30 17:29:27');
INSERT INTO `my_study_report` VALUES (19, 9, 2, '2026-05-23', 68, 1, 1, 78.00, 8, '[\"缃戠粶瀹夊叏\"]', '[\"缃戠粶鍩虹\"]', '鍔犲己鐞嗚瀛︿範', '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-23 17:29:27');
INSERT INTO `my_study_report` VALUES (20, 4, 2, '2026-05-23', 75, 1, 2, 81.00, 10, '[\"缃戠粶瀹夊叏\"]', '[\"缃戠粶鍩虹\"]', '澶氬姩鎵嬪疄楠?, '{\"data\": \"鍛ㄦ姤鏁版嵁\"}', '2026-05-23 17:29:27');

-- ----------------------------
-- Table structure for my_sys_user
-- ----------------------------
DROP TABLE IF EXISTS `my_sys_user`;
CREATE TABLE `my_sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '鐢ㄦ埛ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '鐢ㄦ埛鍚?璐﹀彿',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '瀵嗙爜(鍔犲瘑瀛樺偍)',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鐪熷疄濮撳悕',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '澶村儚URL',
  `sex` tinyint NULL DEFAULT 0 COMMENT '鎬у埆 0-鏈煡 1-鐢?2-濂?,
  `age` int NULL DEFAULT NULL COMMENT '骞撮緞',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鎵嬫満鍙?,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '閭',
  `user_type` tinyint NOT NULL DEFAULT 1 COMMENT '鐢ㄦ埛绫诲瀷 1-瀛︾敓 2-鏁欏笀 3-绠＄悊鍛?,
  `status` tinyint NULL DEFAULT 1 COMMENT '鐘舵€?0-绂佺敤 1-鍚敤',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '鏄惁鍒犻櫎 0-鍚?1-鏄?,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '鏇存柊鏃堕棿',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '澶囨敞',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE,
  INDEX `idx_user_type`(`user_type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '绯荤粺鐢ㄦ埛琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_sys_user
-- ----------------------------
INSERT INTO `my_sys_user` VALUES (1, 'student001', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '寮犱笁', NULL, 1, 20, '13800138001', 'student001@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (2, 'student002', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '鏉庡洓', NULL, 2, 19, '13800138002', 'student002@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:16', NULL);
INSERT INTO `my_sys_user` VALUES (3, 'teacher001', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '鐜嬭€佸笀', NULL, 1, 35, '13900139001', 'teacher001@example.com', 2, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:17', NULL);
INSERT INTO `my_sys_user` VALUES (4, 'admin001', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '绠＄悊鍛?, NULL, 1, 30, '13700137001', 'admin001@example.com', 3, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:20', NULL);
INSERT INTO `my_sys_user` VALUES (5, 'teacher002', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '鏉庤€佸笀', NULL, 1, 38, '13900139002', 'teacher002@example.com', 2, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (6, 'teacher003', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '寮犺€佸笀', NULL, 2, 32, '13900139003', 'teacher003@example.com', 2, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (7, 'teacher004', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '璧佃€佸笀', NULL, 1, 40, '13900139004', 'teacher004@example.com', 2, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (8, 'teacher005', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '鍒樿€佸笀', NULL, 2, 29, '13900139005', 'teacher005@example.com', 2, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (9, 'student003', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '鐜嬩簲', NULL, 1, 21, '13800138003', 'student003@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (10, 'student004', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '璧靛叚', NULL, 2, 20, '13800138004', 'student004@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (11, 'student005', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '瀛欎竷', NULL, 1, 22, '13800138005', 'student005@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (12, 'student006', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '鍛ㄥ叓', NULL, 2, 19, '13800138006', 'student006@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (13, 'student007', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '鍚翠節', NULL, 1, 20, '13800138007', 'student007@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);
INSERT INTO `my_sys_user` VALUES (14, 'student008', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO', '閮戝崄', NULL, 2, 21, '13800138008', 'student008@example.com', 1, 1, 0, '2026-05-27 00:13:29', '2026-05-27 18:45:14', NULL);

-- ----------------------------
-- Table structure for my_task_reminder
-- ----------------------------
DROP TABLE IF EXISTS `my_task_reminder`;
CREATE TABLE `my_task_reminder`  (
  `tr_id` bigint NOT NULL AUTO_INCREMENT COMMENT '鎻愰啋ID',
  `stu_id` bigint NOT NULL COMMENT '瀛︾敓ID',
  `task_type` tinyint NOT NULL COMMENT '浠诲姟绫诲瀷 1-浣滀笟鎴 2-璇剧▼寮€濮?3-鑷畾涔?,
  `task_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '浠诲姟鏍囬',
  `task_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '浠诲姟鍐呭',
  `remind_time` datetime NOT NULL COMMENT '鎻愰啋鏃堕棿',
  `repeat_type` tinyint NULL DEFAULT 0 COMMENT '閲嶅绫诲瀷 0-涓嶉噸澶?1-姣忓ぉ 2-姣忓懆 3-姣忔湀',
  `is_read` tinyint NULL DEFAULT 0 COMMENT '鏄惁宸茶 0-鍚?1-鏄?,
  `status` tinyint NULL DEFAULT 1 COMMENT '鐘舵€?0-鍙栨秷 1-鏈夋晥',
  `related_id` bigint NULL DEFAULT NULL COMMENT '鍏宠仈ID(浣滀笟ID/璇剧▼ID)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tr_id`) USING BTREE,
  INDEX `idx_stu_id`(`stu_id` ASC) USING BTREE,
  INDEX `idx_remind_time`(`remind_time` ASC) USING BTREE,
  INDEX `idx_is_read`(`is_read` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '浠诲姟鎻愰啋琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_task_reminder
-- ----------------------------
INSERT INTO `my_task_reminder` VALUES (1, 1, 1, '鏃╄鎵撳崱', '鑻辫鍏骇璇嶆眹鑳岃', '2026-05-21 01:31:18', 0, 0, 1, 3, '2026-05-27 19:31:26', '2026-06-03 14:38:27');
INSERT INTO `my_task_reminder` VALUES (2, 1, 1, '鏁板浣滀笟鎴', '瀹屾垚瀵兼暟浣滀笟', '2026-05-31 17:29:27', 0, 0, 1, 1, '2026-05-30 17:29:27', '2026-05-30 17:29:27');
INSERT INTO `my_task_reminder` VALUES (3, 2, 2, '璇剧▼寮€濮嬫彁閱?, '鏁版嵁缁撴瀯璇剧▼', '2026-05-30 17:29:27', 0, 0, 1, 2, '2026-05-30 17:29:27', '2026-05-30 17:29:27');

-- ----------------------------
-- Table structure for my_teacher
-- ----------------------------
DROP TABLE IF EXISTS `my_teacher`;
CREATE TABLE `my_teacher`  (
  `teacher_id` bigint NOT NULL AUTO_INCREMENT COMMENT '鏁欏笀ID',
  `user_id` bigint NOT NULL COMMENT '鍏宠仈鐢ㄦ埛ID',
  `teacher_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '宸ュ彿',
  `department` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鎵€灞為櫌绯?,
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鑱岀О',
  `specialty` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '涓撻暱棰嗗煙',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`teacher_id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '鏁欏笀淇℃伅琛? ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of my_teacher
-- ----------------------------
INSERT INTO `my_teacher` VALUES (1, 3, 'T2024001', '璁＄畻鏈哄闄?, '鍓暀鎺?, '浜哄伐鏅鸿兘銆佹満鍣ㄥ涔?, '2026-05-27 00:13:29', '2026-05-27 00:13:29');
INSERT INTO `my_teacher` VALUES (2, 5, 'T2024004', '璁＄畻鏈哄闄?, '鏁欐巿', '澶ф暟鎹€佷簯璁＄畻', '2026-05-27 00:13:29', '2026-06-02 18:11:09');
INSERT INTO `my_teacher` VALUES (3, 6, 'T2024005', '杞欢瀛﹂櫌', '鍓暀鎺?, '鍓嶇寮€鍙戙€乂ue', '2026-05-27 00:13:29', '2026-06-02 18:11:10');
INSERT INTO `my_teacher` VALUES (4, 7, 'T2024006', '浜哄伐鏅鸿兘瀛﹂櫌', '璁插笀', '鑷劧璇█澶勭悊', '2026-05-27 00:13:29', '2026-06-02 18:11:11');
INSERT INTO `my_teacher` VALUES (5, 8, 'T2024007', '缃戠粶瀛﹂櫌', '鍔╂暀', '缃戠粶瀹夊叏銆佽繍缁?, '2026-05-27 00:13:29', '2026-06-02 18:11:13');

-- ----------------------------
-- Table structure for my_question_answer(瀛︾敓鈫掕€佸笀 闂瓟)
-- ----------------------------
DROP TABLE IF EXISTS `my_question_answer`;
CREATE TABLE `my_question_answer`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '涓婚敭ID',
  `stu_id` bigint NOT NULL COMMENT '瀛︾敓ID(my_student.stu_id)',
  `teacher_id` bigint NOT NULL COMMENT '鏁欏笀ID(my_teacher.teacher_id)',
  `question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '瀛︾敓鎻愪氦鐨勯棶棰?,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '鑰佸笀鐨勫洖澶?,
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '鐘舵€?0-寰呭洖澶?1-宸插洖澶?2-宸插叧闂?,
  `create_by` bigint NULL DEFAULT NULL COMMENT '鍒涘缓浜篒D(瀛︾敓user_id)',
  `update_by` bigint NULL DEFAULT NULL COMMENT '鏇存柊浜篒D(鑰佸笀user_id)',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '澶囨敞',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_qa_stu`(`stu_id` ASC) USING BTREE,
  INDEX `idx_qa_teacher`(`teacher_id` ASC) USING BTREE,
  INDEX `idx_qa_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '瀛︾敓鍚戣€佸笀璇锋暀鐨勯棶绛旇〃' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冨害鍚嶇О',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers琛╰rigger_name鐨勫閿?,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers琛╰rigger_group鐨勫閿?,
  `blob_data` blob NULL COMMENT '瀛樻斁鎸佷箙鍖朤rigger瀵硅薄',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Blob绫诲瀷鐨勮Е鍙戝櫒琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冨害鍚嶇О',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '鏃ュ巻鍚嶇О',
  `calendar` blob NOT NULL COMMENT '瀛樻斁鎸佷箙鍖朿alendar瀵硅薄',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '鏃ュ巻淇℃伅琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冨害鍚嶇О',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers琛╰rigger_name鐨勫閿?,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers琛╰rigger_group鐨勫閿?,
  `cron_expression` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'cron琛ㄨ揪寮?,
  `time_zone_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏃跺尯',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Cron绫诲瀷鐨勮Е鍙戝櫒琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冨害鍚嶇О',
  `entry_id` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冨害鍣ㄥ疄渚媔d',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers琛╰rigger_name鐨勫閿?,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers琛╰rigger_group鐨勫閿?,
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冨害鍣ㄥ疄渚嬪悕',
  `fired_time` bigint NOT NULL COMMENT '瑙﹀彂鐨勬椂闂?,
  `sched_time` bigint NOT NULL COMMENT '瀹氭椂鍣ㄥ埗瀹氱殑鏃堕棿',
  `priority` int NOT NULL COMMENT '浼樺厛绾?,
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '鐘舵€?,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浠诲姟鍚嶇О',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浠诲姟缁勫悕',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏄惁骞跺彂',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏄惁鎺ュ彈鎭㈠鎵ц',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '宸茶Е鍙戠殑瑙﹀彂鍣ㄨ〃' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冨害鍚嶇О',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '浠诲姟鍚嶇О',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '浠诲姟缁勫悕',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鐩稿叧浠嬬粛',
  `job_class_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '鎵ц浠诲姟绫诲悕绉?,
  `is_durable` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '鏄惁鎸佷箙鍖?,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '鏄惁骞跺彂',
  `is_update_data` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '鏄惁鏇存柊鏁版嵁',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '鏄惁鎺ュ彈鎭㈠鎵ц',
  `job_data` blob NULL COMMENT '瀛樻斁鎸佷箙鍖杍ob瀵硅薄',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '浠诲姟璇︾粏淇℃伅琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冨害鍚嶇О',
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '鎮茶閿佸悕绉?,
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '瀛樺偍鐨勬偛瑙傞攣淇℃伅琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冨害鍚嶇О',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers琛╰rigger_group鐨勫閿?,
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '鏆傚仠鐨勮Е鍙戝櫒琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冨害鍚嶇О',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '瀹炰緥鍚嶇О',
  `last_checkin_time` bigint NOT NULL COMMENT '涓婃妫€鏌ユ椂闂?,
  `checkin_interval` bigint NOT NULL COMMENT '妫€鏌ラ棿闅旀椂闂?,
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '璋冨害鍣ㄧ姸鎬佽〃' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冨害鍚嶇О',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers琛╰rigger_name鐨勫閿?,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers琛╰rigger_group鐨勫閿?,
  `repeat_count` bigint NOT NULL COMMENT '閲嶅鐨勬鏁扮粺璁?,
  `repeat_interval` bigint NOT NULL COMMENT '閲嶅鐨勯棿闅旀椂闂?,
  `times_triggered` bigint NOT NULL COMMENT '宸茬粡瑙﹀彂鐨勬鏁?,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '绠€鍗曡Е鍙戝櫒鐨勪俊鎭〃' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冨害鍚嶇О',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers琛╰rigger_name鐨勫閿?,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers琛╰rigger_group鐨勫閿?,
  `str_prop_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String绫诲瀷鐨則rigger鐨勭涓€涓弬鏁?,
  `str_prop_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String绫诲瀷鐨則rigger鐨勭浜屼釜鍙傛暟',
  `str_prop_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String绫诲瀷鐨則rigger鐨勭涓変釜鍙傛暟',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int绫诲瀷鐨則rigger鐨勭涓€涓弬鏁?,
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int绫诲瀷鐨則rigger鐨勭浜屼釜鍙傛暟',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long绫诲瀷鐨則rigger鐨勭涓€涓弬鏁?,
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long绫诲瀷鐨則rigger鐨勭浜屼釜鍙傛暟',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal绫诲瀷鐨則rigger鐨勭涓€涓弬鏁?,
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal绫诲瀷鐨則rigger鐨勭浜屼釜鍙傛暟',
  `bool_prop_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Boolean绫诲瀷鐨則rigger鐨勭涓€涓弬鏁?,
  `bool_prop_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Boolean绫诲瀷鐨則rigger鐨勭浜屼釜鍙傛暟',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '鍚屾鏈哄埗鐨勮閿佽〃' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冨害鍚嶇О',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '瑙﹀彂鍣ㄧ殑鍚嶅瓧',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '瑙﹀彂鍣ㄦ墍灞炵粍鐨勫悕瀛?,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details琛╦ob_name鐨勫閿?,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details琛╦ob_group鐨勫閿?,
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鐩稿叧浠嬬粛',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '涓婁竴娆¤Е鍙戞椂闂达紙姣锛?,
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '涓嬩竴娆¤Е鍙戞椂闂达紙榛樿涓?1琛ㄧず涓嶈Е鍙戯級',
  `priority` int NULL DEFAULT NULL COMMENT '浼樺厛绾?,
  `trigger_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '瑙﹀彂鍣ㄧ姸鎬?,
  `trigger_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '瑙﹀彂鍣ㄧ殑绫诲瀷',
  `start_time` bigint NOT NULL COMMENT '寮€濮嬫椂闂?,
  `end_time` bigint NULL DEFAULT NULL COMMENT '缁撴潫鏃堕棿',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏃ョ▼琛ㄥ悕绉?,
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '琛ュ伩鎵ц鐨勭瓥鐣?,
  `job_data` blob NULL COMMENT '瀛樻斁鎸佷箙鍖杍ob瀵硅薄',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '瑙﹀彂鍣ㄨ缁嗕俊鎭〃' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '鍙傛暟涓婚敭',
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍙傛暟鍚嶇О',
  `config_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍙傛暟閿悕',
  `config_value` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍙傛暟閿€?,
  `config_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '绯荤粺鍐呯疆锛圷鏄?N鍚︼級',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍒涘缓鑰?,
  `create_time` datetime NULL DEFAULT NULL COMMENT '鍒涘缓鏃堕棿',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鏇存柊鑰?,
  `update_time` datetime NULL DEFAULT NULL COMMENT '鏇存柊鏃堕棿',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '澶囨敞',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '鍙傛暟閰嶇疆琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '涓绘鏋堕〉-榛樿鐨偆鏍峰紡鍚嶇О', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '钃濊壊 skin-blue銆佺豢鑹?skin-green銆佺传鑹?skin-purple銆佺孩鑹?skin-red銆侀粍鑹?skin-yellow');
INSERT INTO `sys_config` VALUES (2, '鐢ㄦ埛绠＄悊-璐﹀彿鍒濆瀵嗙爜', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '鍒濆鍖栧瘑鐮?123456');
INSERT INTO `sys_config` VALUES (3, '涓绘鏋堕〉-渚ц竟鏍忎富棰?, 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '娣辫壊涓婚theme-dark锛屾祬鑹蹭富棰榯heme-light');
INSERT INTO `sys_config` VALUES (4, '璐﹀彿鑷姪-楠岃瘉鐮佸紑鍏?, 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '鏄惁寮€鍚獙璇佺爜鍔熻兘锛坱rue寮€鍚紝false鍏抽棴锛?);
INSERT INTO `sys_config` VALUES (5, '璐﹀彿鑷姪-鏄惁寮€鍚敤鎴锋敞鍐屽姛鑳?, 'sys.account.registerUser', 'false', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '鏄惁寮€鍚敞鍐岀敤鎴峰姛鑳斤紙true寮€鍚紝false鍏抽棴锛?);
INSERT INTO `sys_config` VALUES (6, '鐢ㄦ埛鐧诲綍-榛戝悕鍗曞垪琛?, 'sys.login.blackIPList', '', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '璁剧疆鐧诲綍IP榛戝悕鍗曢檺鍒讹紝澶氫釜鍖归厤椤逛互;鍒嗛殧锛屾敮鎸佸尮閰嶏紙*閫氶厤銆佺綉娈碉級');
INSERT INTO `sys_config` VALUES (7, '鐢ㄦ埛绠＄悊-鍒濆瀵嗙爜淇敼绛栫暐', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '0锛氬垵濮嬪瘑鐮佷慨鏀圭瓥鐣ュ叧闂紝娌℃湁浠讳綍鎻愮ず锛?锛氭彁閱掔敤鎴凤紝濡傛灉鏈慨鏀瑰垵濮嬪瘑鐮侊紝鍒欏湪鐧诲綍鏃跺氨浼氭彁閱掍慨鏀瑰瘑鐮佸璇濇');
INSERT INTO `sys_config` VALUES (8, '鐢ㄦ埛绠＄悊-璐﹀彿瀵嗙爜鏇存柊鍛ㄦ湡', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2026-05-29 20:04:55', '', NULL, '瀵嗙爜鏇存柊鍛ㄦ湡锛堝～鍐欐暟瀛楋紝鏁版嵁鍒濆鍖栧€间负0涓嶉檺鍒讹紝鑻ヤ慨鏀瑰繀椤讳负澶т簬0灏忎簬365鐨勬鏁存暟锛夛紝濡傛灉瓒呰繃杩欎釜鍛ㄦ湡鐧诲綍绯荤粺鏃讹紝鍒欏湪鐧诲綍鏃跺氨浼氭彁閱掍慨鏀瑰瘑鐮佸璇濇');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '閮ㄩ棬id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '鐖堕儴闂╥d',
  `ancestors` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '绁栫骇鍒楄〃',
  `dept_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '閮ㄩ棬鍚嶇О',
  `order_num` int NULL DEFAULT 0 COMMENT '鏄剧ず椤哄簭',
  `leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '璐熻矗浜?,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鑱旂郴鐢佃瘽',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '閭',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '閮ㄩ棬鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '鍒犻櫎鏍囧織锛?浠ｈ〃瀛樺湪 2浠ｈ〃鍒犻櫎锛?,
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍒涘缓鑰?,
  `create_time` datetime NULL DEFAULT NULL COMMENT '鍒涘缓鏃堕棿',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鏇存柊鑰?,
  `update_time` datetime NULL DEFAULT NULL COMMENT '鏇存柊鏃堕棿',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '閮ㄩ棬琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '鑻ヤ緷绉戞妧', 0, '鑻ヤ緷', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '娣卞湷鎬诲叕鍙?, 1, '鑻ヤ緷', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '闀挎矙鍒嗗叕鍙?, 2, '鑻ヤ緷', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '鐮斿彂閮ㄩ棬', 1, '鑻ヤ緷', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '甯傚満閮ㄩ棬', 2, '鑻ヤ緷', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '娴嬭瘯閮ㄩ棬', 3, '鑻ヤ緷', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '璐㈠姟閮ㄩ棬', 4, '鑻ヤ緷', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '杩愮淮閮ㄩ棬', 5, '鑻ヤ緷', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '甯傚満閮ㄩ棬', 1, '鑻ヤ緷', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '璐㈠姟閮ㄩ棬', 2, '鑻ヤ緷', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '瀛楀吀缂栫爜',
  `dict_sort` int NULL DEFAULT 0 COMMENT '瀛楀吀鎺掑簭',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '瀛楀吀鏍囩',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '瀛楀吀閿€?,
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '瀛楀吀绫诲瀷',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏍峰紡灞炴€э紙鍏朵粬鏍峰紡鎵╁睍锛?,
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '琛ㄦ牸鍥炴樉鏍峰紡',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '鏄惁榛樿锛圷鏄?N鍚︼級',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍒涘缓鑰?,
  `create_time` datetime NULL DEFAULT NULL COMMENT '鍒涘缓鏃堕棿',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鏇存柊鑰?,
  `update_time` datetime NULL DEFAULT NULL COMMENT '鏇存柊鏃堕棿',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '澶囨敞',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '瀛楀吀鏁版嵁琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '鐢?, '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鎬у埆鐢?);
INSERT INTO `sys_dict_data` VALUES (2, 2, '濂?, '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鎬у埆濂?);
INSERT INTO `sys_dict_data` VALUES (3, 3, '鏈煡', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鎬у埆鏈煡');
INSERT INTO `sys_dict_data` VALUES (4, 1, '鏄剧ず', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鏄剧ず鑿滃崟');
INSERT INTO `sys_dict_data` VALUES (5, 2, '闅愯棌', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '闅愯棌鑿滃崟');
INSERT INTO `sys_dict_data` VALUES (6, 1, '姝ｅ父', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '姝ｅ父鐘舵€?);
INSERT INTO `sys_dict_data` VALUES (7, 2, '鍋滅敤', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鍋滅敤鐘舵€?);
INSERT INTO `sys_dict_data` VALUES (8, 1, '姝ｅ父', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '姝ｅ父鐘舵€?);
INSERT INTO `sys_dict_data` VALUES (9, 2, '鏆傚仠', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鍋滅敤鐘舵€?);
INSERT INTO `sys_dict_data` VALUES (10, 1, '榛樿', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '榛樿鍒嗙粍');
INSERT INTO `sys_dict_data` VALUES (11, 2, '绯荤粺', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '绯荤粺鍒嗙粍');
INSERT INTO `sys_dict_data` VALUES (12, 1, '鏄?, 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '绯荤粺榛樿鏄?);
INSERT INTO `sys_dict_data` VALUES (13, 2, '鍚?, 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '绯荤粺榛樿鍚?);
INSERT INTO `sys_dict_data` VALUES (14, 1, '閫氱煡', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '閫氱煡');
INSERT INTO `sys_dict_data` VALUES (15, 2, '鍏憡', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鍏憡');
INSERT INTO `sys_dict_data` VALUES (16, 1, '姝ｅ父', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '姝ｅ父鐘舵€?);
INSERT INTO `sys_dict_data` VALUES (17, 2, '鍏抽棴', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鍏抽棴鐘舵€?);
INSERT INTO `sys_dict_data` VALUES (18, 99, '鍏朵粬', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鍏朵粬鎿嶄綔');
INSERT INTO `sys_dict_data` VALUES (19, 1, '鏂板', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鏂板鎿嶄綔');
INSERT INTO `sys_dict_data` VALUES (20, 2, '淇敼', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '淇敼鎿嶄綔');
INSERT INTO `sys_dict_data` VALUES (21, 3, '鍒犻櫎', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鍒犻櫎鎿嶄綔');
INSERT INTO `sys_dict_data` VALUES (22, 4, '鎺堟潈', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鎺堟潈鎿嶄綔');
INSERT INTO `sys_dict_data` VALUES (23, 5, '瀵煎嚭', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '瀵煎嚭鎿嶄綔');
INSERT INTO `sys_dict_data` VALUES (24, 6, '瀵煎叆', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '瀵煎叆鎿嶄綔');
INSERT INTO `sys_dict_data` VALUES (25, 7, '寮洪€€', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '寮洪€€鎿嶄綔');
INSERT INTO `sys_dict_data` VALUES (26, 8, '鐢熸垚浠ｇ爜', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鐢熸垚鎿嶄綔');
INSERT INTO `sys_dict_data` VALUES (27, 9, '娓呯┖鏁版嵁', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '娓呯┖鎿嶄綔');
INSERT INTO `sys_dict_data` VALUES (28, 1, '鎴愬姛', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '姝ｅ父鐘舵€?);
INSERT INTO `sys_dict_data` VALUES (29, 2, '澶辫触', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鍋滅敤鐘舵€?);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '瀛楀吀涓婚敭',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '瀛楀吀鍚嶇О',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '瀛楀吀绫诲瀷',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍒涘缓鑰?,
  `create_time` datetime NULL DEFAULT NULL COMMENT '鍒涘缓鏃堕棿',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鏇存柊鑰?,
  `update_time` datetime NULL DEFAULT NULL COMMENT '鏇存柊鏃堕棿',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '澶囨敞',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '瀛楀吀绫诲瀷琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '鐢ㄦ埛鎬у埆', 'sys_user_sex', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鐢ㄦ埛鎬у埆鍒楄〃');
INSERT INTO `sys_dict_type` VALUES (2, '鑿滃崟鐘舵€?, 'sys_show_hide', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鑿滃崟鐘舵€佸垪琛?);
INSERT INTO `sys_dict_type` VALUES (3, '绯荤粺寮€鍏?, 'sys_normal_disable', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '绯荤粺寮€鍏冲垪琛?);
INSERT INTO `sys_dict_type` VALUES (4, '浠诲姟鐘舵€?, 'sys_job_status', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '浠诲姟鐘舵€佸垪琛?);
INSERT INTO `sys_dict_type` VALUES (5, '浠诲姟鍒嗙粍', 'sys_job_group', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '浠诲姟鍒嗙粍鍒楄〃');
INSERT INTO `sys_dict_type` VALUES (6, '绯荤粺鏄惁', 'sys_yes_no', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '绯荤粺鏄惁鍒楄〃');
INSERT INTO `sys_dict_type` VALUES (7, '閫氱煡绫诲瀷', 'sys_notice_type', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '閫氱煡绫诲瀷鍒楄〃');
INSERT INTO `sys_dict_type` VALUES (8, '閫氱煡鐘舵€?, 'sys_notice_status', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '閫氱煡鐘舵€佸垪琛?);
INSERT INTO `sys_dict_type` VALUES (9, '鎿嶄綔绫诲瀷', 'sys_oper_type', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鎿嶄綔绫诲瀷鍒楄〃');
INSERT INTO `sys_dict_type` VALUES (10, '绯荤粺鐘舵€?, 'sys_common_status', '0', 'admin', '2026-05-29 20:04:55', '', NULL, '鐧诲綍鐘舵€佸垪琛?);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '浠诲姟ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '浠诲姟鍚嶇О',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '浠诲姟缁勫悕',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冪敤鐩爣瀛楃涓?,
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'cron鎵ц琛ㄨ揪寮?,
  `misfire_policy` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '3' COMMENT '璁″垝鎵ц閿欒绛栫暐锛?绔嬪嵆鎵ц 2鎵ц涓€娆?3鏀惧純鎵ц锛?,
  `concurrent` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '鏄惁骞跺彂鎵ц锛?鍏佽 1绂佹锛?,
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '鐘舵€侊紙0姝ｅ父 1鏆傚仠锛?,
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍒涘缓鑰?,
  `create_time` datetime NULL DEFAULT NULL COMMENT '鍒涘缓鏃堕棿',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鏇存柊鑰?,
  `update_time` datetime NULL DEFAULT NULL COMMENT '鏇存柊鏃堕棿',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '澶囨敞淇℃伅',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '瀹氭椂浠诲姟璋冨害琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '绯荤粺榛樿锛堟棤鍙傦級', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-05-29 20:04:55', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '绯荤粺榛樿锛堟湁鍙傦級', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-05-29 20:04:55', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '绯荤粺榛樿锛堝鍙傦級', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-05-29 20:04:55', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '浠诲姟鏃ュ織ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '浠诲姟鍚嶇О',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '浠诲姟缁勫悕',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '璋冪敤鐩爣瀛楃涓?,
  `job_message` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏃ュ織淇℃伅',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '鎵ц鐘舵€侊紙0姝ｅ父 1澶辫触锛?,
  `exception_info` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '寮傚父淇℃伅',
  `start_time` datetime NULL DEFAULT NULL COMMENT '鎵ц寮€濮嬫椂闂?,
  `end_time` datetime NULL DEFAULT NULL COMMENT '鎵ц缁撴潫鏃堕棿',
  `create_time` datetime NULL DEFAULT NULL COMMENT '鍒涘缓鏃堕棿',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '瀹氭椂浠诲姟璋冨害鏃ュ織琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '璁块棶ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鐢ㄦ埛璐﹀彿',
  `ipaddr` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鐧诲綍IP鍦板潃',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鐧诲綍鍦扮偣',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '娴忚鍣ㄧ被鍨?,
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鎿嶄綔绯荤粺',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '鐧诲綍鐘舵€侊紙0鎴愬姛 1澶辫触锛?,
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鎻愮ず娑堟伅',
  `login_time` datetime NULL DEFAULT NULL COMMENT '璁块棶鏃堕棿',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 190 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '绯荤粺璁块棶璁板綍' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-29 20:17:43');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-05-29 20:20:58');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-29 20:21:33');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-05-29 20:51:08');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-29 20:51:14');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-30 17:36:03');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-30 18:21:23');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-30 19:44:01');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-31 15:04:11');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-31 17:39:16');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮侀敊璇?, '2026-05-31 18:51:11');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-31 18:51:17');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-05-31 20:02:30');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-31 20:15:02');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-05-31 20:15:08');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮佸凡澶辨晥', '2026-05-31 20:17:35');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-31 20:17:40');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-05-31 21:04:54');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮侀敊璇?, '2026-05-31 21:05:10');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-31 21:05:16');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-05-31 21:06:25');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮侀敊璇?, '2026-05-31 21:10:32');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-31 21:10:34');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-31 22:17:28');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮侀敊璇?, '2026-05-31 23:20:00');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-05-31 23:20:01');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-01 00:02:14');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-01 00:09:41');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-01 00:12:07');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮侀敊璇?, '2026-06-01 00:12:24');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-01 00:12:29');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-01 17:58:18');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-01 18:15:06');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-01 18:15:54');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮佸凡澶辨晥', '2026-06-01 18:54:12');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-01 18:54:19');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮佸凡澶辨晥', '2026-06-01 18:54:31');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮侀敊璇?, '2026-06-01 18:54:32');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮侀敊璇?, '2026-06-01 18:54:34');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-01 18:54:38');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-01 19:32:46');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-01 19:34:22');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-01 19:50:46');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮佸凡澶辨晥', '2026-06-01 19:54:38');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-01 19:54:42');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-02 16:23:56');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-02 17:38:33');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-02 17:39:29');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-02 18:52:12');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮侀敊璇?, '2026-06-02 18:52:38');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-02 18:52:39');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-02 19:43:04');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-02 19:43:29');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-02 19:54:10');
INSERT INTO `sys_logininfor` VALUES (154, 'admin1', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮佸凡澶辨晥', '2026-06-02 19:57:16');
INSERT INTO `sys_logininfor` VALUES (155, 'admin1', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '鐢ㄦ埛涓嶅瓨鍦?瀵嗙爜閿欒', '2026-06-02 19:57:23');
INSERT INTO `sys_logininfor` VALUES (156, 'admin1', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '鐢ㄦ埛涓嶅瓨鍦?瀵嗙爜閿欒', '2026-06-02 19:57:26');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮佸凡澶辨晥', '2026-06-02 20:01:18');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-02 20:01:22');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-02 21:30:54');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-02 21:42:32');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-02 21:42:58');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-02 22:18:42');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮佸凡澶辨晥', '2026-06-02 23:17:39');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-02 23:17:45');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-02 23:23:32');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-03 00:09:54');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-03 00:10:10');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮佸凡澶辨晥', '2026-06-03 00:17:09');
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-03 00:17:38');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-03 00:36:23');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-03 00:36:26');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-03 00:55:43');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-03 14:18:55');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮佸凡澶辨晥', '2026-06-03 16:18:35');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-03 16:18:35');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-03 17:17:49');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-03 17:44:26');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-03 20:43:25');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-03 22:08:49');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-03 22:57:38');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮侀敊璇?, '2026-06-03 22:58:05');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '楠岃瘉鐮佸凡澶辨晥', '2026-06-03 23:01:06');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-03 23:01:10');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-04 00:17:53');
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-04 17:56:28');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-04 20:15:49');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-04 20:16:07');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '閫€鍑烘垚鍔?, '2026-06-04 20:16:19');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '鍐呯綉IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '鐧诲綍鎴愬姛', '2026-06-04 20:16:25');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '鑿滃崟ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '鑿滃崟鍚嶇О',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '鐖惰彍鍗旾D',
  `order_num` int NULL DEFAULT 0 COMMENT '鏄剧ず椤哄簭',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '璺敱鍦板潃',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缁勪欢璺緞',
  `query` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '璺敱鍙傛暟',
  `route_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '璺敱鍚嶇О',
  `is_frame` int NULL DEFAULT 1 COMMENT '鏄惁涓哄閾撅紙0鏄?1鍚︼級',
  `is_cache` int NULL DEFAULT 0 COMMENT '鏄惁缂撳瓨锛?缂撳瓨 1涓嶇紦瀛橈級',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鑿滃崟绫诲瀷锛圡鐩綍 C鑿滃崟 F鎸夐挳锛?,
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '鑿滃崟鐘舵€侊紙0鏄剧ず 1闅愯棌锛?,
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '鑿滃崟鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鏉冮檺鏍囪瘑',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '鑿滃崟鍥炬爣',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍒涘缓鑰?,
  `create_time` datetime NULL DEFAULT NULL COMMENT '鍒涘缓鏃堕棿',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鏇存柊鑰?,
  `update_time` datetime NULL DEFAULT NULL COMMENT '鏇存柊鏃堕棿',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '澶囨敞',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2306 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '鑿滃崟鏉冮檺琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '绯荤粺绠＄悊', 0, 6, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-05-29 20:04:53', '', NULL, '绯荤粺绠＄悊鐩綍');
INSERT INTO `sys_menu` VALUES (2, '绯荤粺鐩戞帶', 0, 7, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-05-29 20:04:53', '', NULL, '绯荤粺鐩戞帶鐩綍');
INSERT INTO `sys_menu` VALUES (3, '绯荤粺宸ュ叿', 0, 7, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-05-29 20:04:53', 'admin', '2026-05-31 23:28:53', '绯荤粺宸ュ叿鐩綍');
INSERT INTO `sys_menu` VALUES (4, '鑻ヤ緷瀹樼綉', 0, 8, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2026-05-29 20:04:53', 'admin', '2026-05-31 23:29:39', '鑻ヤ緷瀹樼綉鍦板潃');
INSERT INTO `sys_menu` VALUES (100, '鐢ㄦ埛绠＄悊', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-05-29 20:04:53', '', NULL, '鐢ㄦ埛绠＄悊鑿滃崟');
INSERT INTO `sys_menu` VALUES (101, '瑙掕壊绠＄悊', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-05-29 20:04:53', '', NULL, '瑙掕壊绠＄悊鑿滃崟');
INSERT INTO `sys_menu` VALUES (102, '鑿滃崟绠＄悊', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-05-29 20:04:53', '', NULL, '鑿滃崟绠＄悊鑿滃崟');
INSERT INTO `sys_menu` VALUES (103, '閮ㄩ棬绠＄悊', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-05-29 20:04:53', '', NULL, '閮ㄩ棬绠＄悊鑿滃崟');
INSERT INTO `sys_menu` VALUES (104, '宀椾綅绠＄悊', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2026-05-29 20:04:53', '', NULL, '宀椾綅绠＄悊鑿滃崟');
INSERT INTO `sys_menu` VALUES (105, '瀛楀吀绠＄悊', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-05-29 20:04:53', '', NULL, '瀛楀吀绠＄悊鑿滃崟');
INSERT INTO `sys_menu` VALUES (106, '鍙傛暟璁剧疆', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-05-29 20:04:53', '', NULL, '鍙傛暟璁剧疆鑿滃崟');
INSERT INTO `sys_menu` VALUES (107, '閫氱煡鍏憡', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-05-29 20:04:53', '', NULL, '閫氱煡鍏憡鑿滃崟');
INSERT INTO `sys_menu` VALUES (108, '鏃ュ織绠＄悊', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-05-29 20:04:53', '', NULL, '鏃ュ織绠＄悊鑿滃崟');
INSERT INTO `sys_menu` VALUES (109, '鍦ㄧ嚎鐢ㄦ埛', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-05-29 20:04:53', '', NULL, '鍦ㄧ嚎鐢ㄦ埛鑿滃崟');
INSERT INTO `sys_menu` VALUES (110, '瀹氭椂浠诲姟', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-05-29 20:04:53', '', NULL, '瀹氭椂浠诲姟鑿滃崟');
INSERT INTO `sys_menu` VALUES (111, '鏁版嵁鐩戞帶', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-05-29 20:04:53', '', NULL, '鏁版嵁鐩戞帶鑿滃崟');
INSERT INTO `sys_menu` VALUES (112, '鏈嶅姟鐩戞帶', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-05-29 20:04:53', '', NULL, '鏈嶅姟鐩戞帶鑿滃崟');
INSERT INTO `sys_menu` VALUES (113, '缂撳瓨鐩戞帶', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-05-29 20:04:53', '', NULL, '缂撳瓨鐩戞帶鑿滃崟');
INSERT INTO `sys_menu` VALUES (114, '缂撳瓨鍒楄〃', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-05-29 20:04:53', '', NULL, '缂撳瓨鍒楄〃鑿滃崟');
INSERT INTO `sys_menu` VALUES (115, '琛ㄥ崟鏋勫缓', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-05-29 20:04:53', '', NULL, '琛ㄥ崟鏋勫缓鑿滃崟');
INSERT INTO `sys_menu` VALUES (116, '浠ｇ爜鐢熸垚', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-05-29 20:04:53', '', NULL, '浠ｇ爜鐢熸垚鑿滃崟');
INSERT INTO `sys_menu` VALUES (117, '绯荤粺鎺ュ彛', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-05-29 20:04:53', '', NULL, '绯荤粺鎺ュ彛鑿滃崟');
INSERT INTO `sys_menu` VALUES (500, '鎿嶄綔鏃ュ織', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-05-29 20:04:53', '', NULL, '鎿嶄綔鏃ュ織鑿滃崟');
INSERT INTO `sys_menu` VALUES (501, '鐧诲綍鏃ュ織', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-05-29 20:04:53', '', NULL, '鐧诲綍鏃ュ織鑿滃崟');
INSERT INTO `sys_menu` VALUES (1000, '鐢ㄦ埛鏌ヨ', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '鐢ㄦ埛鏂板', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '鐢ㄦ埛淇敼', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '鐢ㄦ埛鍒犻櫎', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '鐢ㄦ埛瀵煎嚭', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '鐢ㄦ埛瀵煎叆', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '閲嶇疆瀵嗙爜', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '瑙掕壊鏌ヨ', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '瑙掕壊鏂板', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '瑙掕壊淇敼', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '瑙掕壊鍒犻櫎', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '瑙掕壊瀵煎嚭', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '鑿滃崟鏌ヨ', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '鑿滃崟鏂板', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '鑿滃崟淇敼', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '鑿滃崟鍒犻櫎', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '閮ㄩ棬鏌ヨ', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '閮ㄩ棬鏂板', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '閮ㄩ棬淇敼', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '閮ㄩ棬鍒犻櫎', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '宀椾綅鏌ヨ', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '宀椾綅鏂板', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '宀椾綅淇敼', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '宀椾綅鍒犻櫎', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '宀椾綅瀵煎嚭', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '瀛楀吀鏌ヨ', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '瀛楀吀鏂板', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '瀛楀吀淇敼', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '瀛楀吀鍒犻櫎', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '瀛楀吀瀵煎嚭', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '鍙傛暟鏌ヨ', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '鍙傛暟鏂板', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '鍙傛暟淇敼', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '鍙傛暟鍒犻櫎', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '鍙傛暟瀵煎嚭', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '鍏憡鏌ヨ', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '鍏憡鏂板', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '鍏憡淇敼', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '鍏憡鍒犻櫎', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '鎿嶄綔鏌ヨ', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '鎿嶄綔鍒犻櫎', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '鏃ュ織瀵煎嚭', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '鐧诲綍鏌ヨ', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '鐧诲綍鍒犻櫎', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '鏃ュ織瀵煎嚭', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '璐︽埛瑙ｉ攣', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '鍦ㄧ嚎鏌ヨ', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '鎵归噺寮洪€€', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '鍗曟潯寮洪€€', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '浠诲姟鏌ヨ', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '浠诲姟鏂板', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '浠诲姟淇敼', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '浠诲姟鍒犻櫎', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '鐘舵€佷慨鏀?, 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '浠诲姟瀵煎嚭', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '鐢熸垚鏌ヨ', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '鐢熸垚淇敼', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '鐢熸垚鍒犻櫎', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '瀵煎叆浠ｇ爜', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '棰勮浠ｇ爜', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '鐢熸垚浠ｇ爜', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-05-29 20:04:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '涓氬姟绠＄悊', 0, 1, 'business', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'checkbox', 'admin', '2026-05-30 19:53:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '璧勬簮妯″潡', 2000, 1, 'resource', 'business/resource/index', NULL, '', 1, 0, 'C', '0', '0', 'business:resource:list', '#', 'admin', '2026-05-31 16:19:10', '', NULL, '璧勬簮妯″潡鑿滃崟');
INSERT INTO `sys_menu` VALUES (2016, '璧勬簮妯″潡鏌ヨ', 2015, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:resource:query', '#', 'admin', '2026-05-31 16:19:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '璧勬簮妯″潡鏂板', 2015, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:resource:add', '#', 'admin', '2026-05-31 16:19:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '璧勬簮妯″潡淇敼', 2015, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:resource:edit', '#', 'admin', '2026-05-31 16:19:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '璧勬簮妯″潡鍒犻櫎', 2015, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:resource:remove', '#', 'admin', '2026-05-31 16:19:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2020, '璧勬簮妯″潡瀵煎嚭', 2015, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:resource:export', '#', 'admin', '2026-05-31 16:19:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '閫氱煡妯″潡', 2000, 1, 'notification', 'business/notification/index', NULL, '', 1, 0, 'C', '0', '0', 'business:notification:list', '#', 'admin', '2026-05-31 16:43:24', '', NULL, '閫氱煡妯″潡鑿滃崟');
INSERT INTO `sys_menu` VALUES (2022, '閫氱煡妯″潡鏌ヨ', 2021, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:notification:query', '#', 'admin', '2026-05-31 16:43:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '閫氱煡妯″潡鏂板', 2021, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:notification:add', '#', 'admin', '2026-05-31 16:43:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '閫氱煡妯″潡淇敼', 2021, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:notification:edit', '#', 'admin', '2026-05-31 16:43:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '閫氱煡妯″潡鍒犻櫎', 2021, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:notification:remove', '#', 'admin', '2026-05-31 16:43:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, '閫氱煡妯″潡瀵煎嚭', 2021, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:notification:export', '#', 'admin', '2026-05-31 16:43:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2164, '璇剧▼绠＄悊', 0, 2, 'course', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'education', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '璇剧▼绠＄悊鐩綍');
INSERT INTO `sys_menu` VALUES (2165, '璇剧▼鍒楄〃', 2164, 1, 'myCourse', 'course/myCourse/index', NULL, '', 1, 0, 'C', '0', '0', 'course:myCourse:list', 'list', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '璇剧▼鍒楄〃鑿滃崟');
INSERT INTO `sys_menu` VALUES (2166, '璇剧▼鏌ヨ', 2165, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'course:myCourse:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '璇剧▼鏌ヨ鎸夐挳');
INSERT INTO `sys_menu` VALUES (2167, '璇剧▼鏂板', 2165, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'course:myCourse:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '璇剧▼鏂板鎸夐挳');
INSERT INTO `sys_menu` VALUES (2168, '璇剧▼淇敼', 2165, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'course:myCourse:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '璇剧▼淇敼鎸夐挳');
INSERT INTO `sys_menu` VALUES (2169, '璇剧▼鍒犻櫎', 2165, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'course:myCourse:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '璇剧▼鍒犻櫎鎸夐挳');
INSERT INTO `sys_menu` VALUES (2170, '璇剧▼瀵煎嚭', 2165, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'course:myCourse:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '璇剧▼瀵煎嚭鎸夐挳');
INSERT INTO `sys_menu` VALUES (2171, '鐢ㄦ埛鎵╁睍', 0, 0, 'userext', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'user', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '鐢ㄦ埛鎵╁睍鐩綍');
INSERT INTO `sys_menu` VALUES (2172, '瀛︾敓绠＄悊', 2171, 1, 'myStudent', 'userext/myStudent/index', NULL, '', 1, 0, 'C', '0', '0', 'userext:myStudent:list', 'peoples', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '瀛︾敓绠＄悊鑿滃崟');
INSERT INTO `sys_menu` VALUES (2173, '瀛︾敓鏌ヨ', 2172, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myStudent:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2174, '瀛︾敓鏂板', 2172, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myStudent:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2175, '瀛︾敓淇敼', 2172, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myStudent:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2176, '瀛︾敓鍒犻櫎', 2172, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myStudent:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2177, '瀛︾敓瀵煎嚭', 2172, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myStudent:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2178, '鏁欏笀绠＄悊', 2171, 2, 'myTeacher', 'userext/myTeacher/index', NULL, '', 1, 0, 'C', '0', '0', 'userext:myTeacher:list', 'user', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '鏁欏笀绠＄悊鑿滃崟');
INSERT INTO `sys_menu` VALUES (2179, '鏁欏笀鏌ヨ', 2178, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myTeacher:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2180, '鏁欏笀鏂板', 2178, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myTeacher:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2181, '鏁欏笀淇敼', 2178, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myTeacher:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2182, '鏁欏笀鍒犻櫎', 2178, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myTeacher:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2183, '鏁欏笀瀵煎嚭', 2178, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'userext:myTeacher:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2184, '浣滀笟绠＄悊', 0, 3, 'homework', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'form', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '浣滀笟绠＄悊鐩綍');
INSERT INTO `sys_menu` VALUES (2185, '浣滀笟鍒楄〃', 2184, 1, 'myHomework', 'homework/myHomework/index', NULL, '', 1, 0, 'C', '0', '0', 'homework:myHomework:list', 'edit', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '浣滀笟鍒楄〃鑿滃崟');
INSERT INTO `sys_menu` VALUES (2186, '浣滀笟鏌ヨ', 2185, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'homework:myHomework:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2187, '浣滀笟鏂板', 2185, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'homework:myHomework:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2188, '浣滀笟淇敼', 2185, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'homework:myHomework:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2189, '浣滀笟鍒犻櫎', 2185, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'homework:myHomework:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2190, '浣滀笟瀵煎嚭', 2185, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'homework:myHomework:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2191, '瀛︿範涓績', 0, 2, 'study', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'chart', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '瀛︿範涓績鐩綍');
INSERT INTO `sys_menu` VALUES (2192, '瀛︿範璁板綍', 2191, 1, 'myStudyRecord', 'study/myStudyRecord/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myStudyRecord:list', 'time', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '瀛︿範璁板綍鑿滃崟');
INSERT INTO `sys_menu` VALUES (2193, '瀛︿範璁板綍鏌ヨ', 2192, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyRecord:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2194, '瀛︿範璁板綍鏂板', 2192, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyRecord:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2195, '瀛︿範璁板綍淇敼', 2192, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyRecord:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2196, '瀛︿範璁板綍鍒犻櫎', 2192, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyRecord:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2197, '瀛︿範璁板綍瀵煎嚭', 2192, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyRecord:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2198, 'AI闂瓟璁板綍', 2191, 2, 'myAiChat', 'study/myAiChat/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myAiChat:list', 'message', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', 'AI闂瓟璁板綍鑿滃崟');
INSERT INTO `sys_menu` VALUES (2199, 'AI闂瓟鏌ヨ', 2198, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myAiChat:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2200, 'AI闂瓟鏂板', 2198, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myAiChat:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2201, 'AI闂瓟淇敼', 2198, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myAiChat:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2202, 'AI闂瓟鍒犻櫎', 2198, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myAiChat:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2203, 'AI闂瓟瀵煎嚭', 2198, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myAiChat:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2204, '娈典綅閰嶇疆', 2191, 3, 'myRankConfig', 'study/myRankConfig/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myRankConfig:list', 'star', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '娈典綅閰嶇疆鑿滃崟');
INSERT INTO `sys_menu` VALUES (2205, '娈典綅閰嶇疆鏌ヨ', 2204, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myRankConfig:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2206, '娈典綅閰嶇疆鏂板', 2204, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myRankConfig:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2207, '娈典綅閰嶇疆淇敼', 2204, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myRankConfig:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2208, '娈典綅閰嶇疆鍒犻櫎', 2204, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myRankConfig:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2209, '娈典綅閰嶇疆瀵煎嚭', 2204, 5, '#', NULL, NULL, '', 0, 0, 'F', '0', '0', 'study:myRankConfig:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2210, '浠诲姟鎻愰啋', 2191, 4, 'myTaskReminder', 'study/myTaskReminder/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myTaskReminder:list', 'bell', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '浠诲姟鎻愰啋鑿滃崟');
INSERT INTO `sys_menu` VALUES (2211, '浠诲姟鎻愰啋鏌ヨ', 2210, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myTaskReminder:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2212, '浠诲姟鎻愰啋鏂板', 2210, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myTaskReminder:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2213, '浠诲姟鎻愰啋淇敼', 2210, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myTaskReminder:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2214, '浠诲姟鎻愰啋鍒犻櫎', 2210, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myTaskReminder:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2215, '浠诲姟鎻愰啋瀵煎嚭', 2210, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myTaskReminder:export', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2216, '閿欓鏈?, 2191, 5, 'myErrorBook', 'study/myErrorBook/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myErrorBook:list', 'bug', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '閿欓鏈彍鍗?);
INSERT INTO `sys_menu` VALUES (2217, '閿欓鏈煡璇?, 2216, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myErrorBook:query', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2218, '閿欓鏈柊澧?, 2216, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myErrorBook:add', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2219, '閿欓鏈慨鏀?, 2216, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myErrorBook:edit', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2220, '閿欓鏈垹闄?, 2216, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myErrorBook:remove', '#', 'admin', '2026-05-31 23:26:21', '', '2026-05-31 23:26:21', '');
INSERT INTO `sys_menu` VALUES (2221, '閿欓鏈鍑?, 2216, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myErrorBook:export', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2222, '瀛︽儏鎶ヨ〃', 2191, 6, 'myStudyReport', 'study/myStudyReport/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myStudyReport:list', 'documentation', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '瀛︽儏鎶ヨ〃鑿滃崟');
INSERT INTO `sys_menu` VALUES (2223, '瀛︽儏鎶ヨ〃鏌ヨ', 2222, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyReport:query', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2224, '瀛︽儏鎶ヨ〃鏂板', 2222, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyReport:add', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2225, '瀛︽儏鎶ヨ〃淇敼', 2222, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyReport:edit', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2226, '瀛︽儏鎶ヨ〃鍒犻櫎', 2222, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyReport:remove', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2227, '瀛︽儏鎶ヨ〃瀵煎嚭', 2222, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myStudyReport:export', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2228, '鍏ㄥ眬鎶ヨ〃', 2191, 7, 'myGlobalReport', 'study/myGlobalReport/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myGlobalReport:list', 'chart', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '鍏ㄥ眬鎶ヨ〃鑿滃崟');
INSERT INTO `sys_menu` VALUES (2229, '鍏ㄥ眬鎶ヨ〃鏌ヨ', 2228, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myGlobalReport:query', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2230, '鍏ㄥ眬鎶ヨ〃鏂板', 2228, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myGlobalReport:add', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2231, '鍏ㄥ眬鎶ヨ〃淇敼', 2228, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myGlobalReport:edit', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2232, '鍏ㄥ眬鎶ヨ〃鍒犻櫎', 2228, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myGlobalReport:remove', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2233, '鍏ㄥ眬鎶ヨ〃瀵煎嚭', 2228, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myGlobalReport:export', '#', 'admin', '2026-05-31 23:26:22', '', '2026-05-31 23:26:22', '');
INSERT INTO `sys_menu` VALUES (2234, '棰樺簱绠＄悊', 0, 4, 'bank', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'education', 'admin', '2026-06-03 00:00:00', '', NULL, '棰樺簱绠＄悊鐩綍');
INSERT INTO `sys_menu` VALUES (2235, '棰樺簱鍒楄〃', 2234, 1, 'myBank', 'study/myBank/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myBank:list', 'list', 'admin', '2026-06-03 00:00:00', '', NULL, '棰樺簱鍒楄〃鑿滃崟');
INSERT INTO `sys_menu` VALUES (2236, '棰樺簱鏌ヨ', 2235, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myBank:query', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '棰樺簱鏌ヨ鎸夐挳');
INSERT INTO `sys_menu` VALUES (2237, '棰樺簱鏂板', 2235, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myBank:add', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '棰樺簱鏂板鎸夐挳');
INSERT INTO `sys_menu` VALUES (2238, '棰樺簱淇敼', 2235, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myBank:edit', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '棰樺簱淇敼鎸夐挳');
INSERT INTO `sys_menu` VALUES (2239, '棰樺簱鍒犻櫎', 2235, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myBank:remove', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '棰樺簱鍒犻櫎鎸夐挳');
INSERT INTO `sys_menu` VALUES (2240, '棰樺簱瀵煎嚭', 2235, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myBank:export', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '棰樺簱瀵煎嚭鎸夐挳');
INSERT INTO `sys_menu` VALUES (2241, '棰樼洰绠＄悊', 0, 5, 'question', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'edit', 'admin', '2026-06-03 00:00:00', '', NULL, '棰樼洰绠＄悊鐩綍');
INSERT INTO `sys_menu` VALUES (2242, '棰樼洰鍒楄〃', 2241, 1, 'myQuestion', 'study/myQuestion/index', NULL, '', 1, 0, 'C', '0', '0', 'study:myQuestion:list', 'list', 'admin', '2026-06-03 00:00:00', '', NULL, '棰樼洰鍒楄〃鑿滃崟');
INSERT INTO `sys_menu` VALUES (2243, '棰樼洰鏌ヨ', 2242, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myQuestion:query', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '棰樼洰鏌ヨ鎸夐挳');
INSERT INTO `sys_menu` VALUES (2244, '棰樼洰鏂板', 2242, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myQuestion:add', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '棰樼洰鏂板鎸夐挳');
INSERT INTO `sys_menu` VALUES (2245, '棰樼洰淇敼', 2242, 3, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myQuestion:edit', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '棰樼洰淇敼鎸夐挳');
INSERT INTO `sys_menu` VALUES (2246, '棰樼洰鍒犻櫎', 2242, 4, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myQuestion:remove', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '棰樼洰鍒犻櫎鎸夐挳');
INSERT INTO `sys_menu` VALUES (2247, '棰樼洰瀵煎嚭', 2242, 5, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'study:myQuestion:export', '#', 'admin', '2026-06-03 00:00:00', '', NULL, '棰樼洰瀵煎嚭鎸夐挳');
INSERT INTO `sys_menu` VALUES (2300, 'AI鏅鸿兘鍔╂墜', 0, 5, 'aiAgent', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'qq', 'admin', '2026-06-03 19:00:00', 'admin', '2026-06-03 23:32:31', 'AI鏅鸿兘鍔╂墜鐩綍');
INSERT INTO `sys_menu` VALUES (2301, 'AI瀵硅瘽', 2300, 1, 'aiChat', 'ai/agent/index', NULL, '', 1, 0, 'C', '0', '0', 'ai:agent:chat', 'chat-dot-round', 'admin', '2026-06-03 19:00:00', '', NULL, 'AI瀵硅瘽鑿滃崟');
INSERT INTO `sys_menu` VALUES (2302, 'AI瀵硅瘽鏌ヨ', 2301, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'ai:agent:query', '#', 'admin', '2026-06-03 19:00:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2303, 'AI瀵硅瘽鍙戦€?, 2301, 2, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'ai:agent:send', '#', 'admin', '2026-06-03 19:00:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2304, 'AI閰嶇疆', 2300, 2, 'aiConfig', 'ai/config/index', NULL, '', 1, 0, 'C', '0', '0', 'ai:config:view', 'setting', 'admin', '2026-06-03 19:00:00', '', NULL, 'AI閰嶇疆鑿滃崟');
INSERT INTO `sys_menu` VALUES (2305, 'AI閰嶇疆淇敼', 2304, 1, '#', NULL, NULL, '', 1, 0, 'F', '0', '0', 'ai:config:edit', '#', 'admin', '2026-06-03 19:00:00', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '鍏憡ID',
  `notice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '鍏憡鏍囬',
  `notice_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '鍏憡绫诲瀷锛?閫氱煡 2鍏憡锛?,
  `notice_content` longblob NULL COMMENT '鍏憡鍐呭',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '鍏憡鐘舵€侊紙0姝ｅ父 1鍏抽棴锛?,
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍒涘缓鑰?,
  `create_time` datetime NULL DEFAULT NULL COMMENT '鍒涘缓鏃堕棿',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鏇存柊鑰?,
  `update_time` datetime NULL DEFAULT NULL COMMENT '鏇存柊鏃堕棿',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '澶囨敞',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '閫氱煡鍏憡琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '娓╅Θ鎻愰啋锛?018-07-01 鑻ヤ緷鏂扮増鏈彂甯冨暒', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-05-29 20:04:55', '', NULL, '绠＄悊鍛?);
INSERT INTO `sys_notice` VALUES (2, '缁存姢閫氱煡锛?018-07-01 鑻ヤ緷绯荤粺鍑屾櫒缁存姢', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-05-29 20:04:55', '', NULL, '绠＄悊鍛?);
INSERT INTO `sys_notice` VALUES (3, '鑻ヤ緷寮€婧愭鏋朵粙缁?, '1', 0x3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE9A1B9E79BAEE4BB8BE7BB8D3C2F7370616E3E3C2F703E3C703E3C666F6E7420636F6C6F723D2223333333333333223E52756F5969E5BC80E6BA90E9A1B9E79BAEE698AFE4B8BAE4BC81E4B89AE794A8E688B7E5AE9AE588B6E79A84E5908EE58FB0E8849AE6898BE69EB6E6A186E69EB6EFBC8CE4B8BAE4BC81E4B89AE68993E980A0E79A84E4B880E7AB99E5BC8FE8A7A3E586B3E696B9E6A188EFBC8CE9998DE4BD8EE4BC81E4B89AE5BC80E58F91E68890E69CACEFBC8CE68F90E58D87E5BC80E58F91E69588E78E87E38082E4B8BBE8A681E58C85E68BACE794A8E688B7E7AEA1E79086E38081E8A792E889B2E7AEA1E79086E38081E983A8E997A8E7AEA1E79086E38081E88F9CE58D95E7AEA1E79086E38081E58F82E695B0E7AEA1E79086E38081E5AD97E585B8E7AEA1E79086E380813C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE5B297E4BD8DE7AEA1E790863C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E5AE9AE697B6E4BBBBE58AA13C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE380813C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE69C8DE58AA1E79B91E68EA7E38081E799BBE5BD95E697A5E5BF97E38081E6938DE4BD9CE697A5E5BF97E38081E4BBA3E7A081E7949FE68890E7AD89E58A9FE883BDE38082E585B6E4B8ADEFBC8CE8BF98E694AFE68C81E5A49AE695B0E68DAEE6BA90E38081E695B0E68DAEE69D83E99990E38081E59BBDE99985E58C96E380815265646973E7BC93E5AD98E38081446F636B6572E983A8E7BDB2E38081E6BB91E58AA8E9AA8CE8AF81E7A081E38081E7ACACE4B889E696B9E8AEA4E8AF81E799BBE5BD95E38081E58886E5B883E5BC8FE4BA8BE58AA1E380813C2F7370616E3E3C666F6E7420636F6C6F723D2223333333333333223EE58886E5B883E5BC8FE69687E4BBB6E5AD98E582A83C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E58886E5BA93E58886E8A1A8E5A484E79086E7AD89E68A80E69CAFE789B9E782B9E380823C2F7370616E3E3C2F703E3C703E3C696D67207372633D2268747470733A2F2F666F727564612E67697465652E636F6D2F696D616765732F313737333933313834383334323433393033322F61346432323331335F313831353039352E706E6722207374796C653D2277696474683A20363470783B223E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE5AE98E7BD91E58F8AE6BC94E7A4BA3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE5AE98E7BD91E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F72756F79692E7669703C2F613E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E3C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE69687E6A1A3E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F646F632E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F646F632E72756F79692E7669703C2F613E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E4B88DE58886E7A6BBE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F64656D6F2E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F64656D6F2E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E58886E7A6BBE78988E69CACE38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F7675652E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F7675652E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E5BEAEE69C8DE58AA1E78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F636C6F75642E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F636C6F75642E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E7A7BBE58AA8E7ABAFE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F68352E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F68352E72756F79692E7669703C2F613E3C2F703E3C703E3C6272207374796C653D22636F6C6F723A207267622834382C2034392C203531293B20666F6E742D66616D696C793A202671756F743B48656C766574696361204E6575652671756F743B2C2048656C7665746963612C20417269616C2C2073616E732D73657269663B20666F6E742D73697A653A20313270783B223E3C2F703E, '0', 'admin', '2026-05-29 20:04:55', '', NULL, '绠＄悊鍛?);

-- ----------------------------
-- Table structure for sys_notice_read
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_read`;
CREATE TABLE `sys_notice_read`  (
  `read_id` bigint NOT NULL AUTO_INCREMENT COMMENT '宸茶涓婚敭',
  `notice_id` int NOT NULL COMMENT '鍏憡id',
  `user_id` bigint NOT NULL COMMENT '鐢ㄦ埛id',
  `read_time` datetime NOT NULL COMMENT '闃呰鏃堕棿',
  PRIMARY KEY (`read_id`) USING BTREE,
  UNIQUE INDEX `uk_user_notice`(`user_id` ASC, `notice_id` ASC) USING BTREE COMMENT '鍚屼竴鐢ㄦ埛鍚屼竴鍏憡鍙褰曚竴娆?
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '鍏憡宸茶璁板綍琛? ROW_FORMAT = Dynamic;

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
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '鏃ュ織涓婚敭',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '妯″潡鏍囬',
  `business_type` int NULL DEFAULT 0 COMMENT '涓氬姟绫诲瀷锛?鍏跺畠 1鏂板 2淇敼 3鍒犻櫎锛?,
  `method` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鏂规硶鍚嶇О',
  `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '璇锋眰鏂瑰紡',
  `operator_type` int NULL DEFAULT 0 COMMENT '鎿嶄綔绫诲埆锛?鍏跺畠 1鍚庡彴鐢ㄦ埛 2鎵嬫満绔敤鎴凤級',
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鎿嶄綔浜哄憳',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '閮ㄩ棬鍚嶇О',
  `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '璇锋眰URL',
  `oper_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '涓绘満鍦板潃',
  `oper_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鎿嶄綔鍦扮偣',
  `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '璇锋眰鍙傛暟',
  `json_result` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '杩斿洖鍙傛暟',
  `status` int NULL DEFAULT 0 COMMENT '鎿嶄綔鐘舵€侊紙0姝ｅ父 1寮傚父锛?,
  `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '閿欒娑堟伅',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '鎿嶄綔鏃堕棿',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '娑堣€楁椂闂?,
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 162 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '鎿嶄綔鏃ュ織璁板綍' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '鑿滃崟绠＄悊', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"涓氬姟绠＄悊\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"business\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-30 19:53:09', 24);
INSERT INTO `sys_oper_log` VALUES (101, '淇濆瓨鑿滃崟鎺掑簭', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/updateSort', '127.0.0.1', '鍐呯綉IP', '{\"menuIds\":\"2000\",\"orderNums\":\"1\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-30 19:53:22', 13);
INSERT INTO `sys_oper_log` VALUES (102, '淇濆瓨鑿滃崟鎺掑簭', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/updateSort', '127.0.0.1', '鍐呯綉IP', '{\"menuIds\":\"2000,2,3,4\",\"orderNums\":\"2,3,4,5\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-30 19:53:35', 10);
INSERT INTO `sys_oper_log` VALUES (103, '淇濆瓨鑿滃崟鎺掑簭', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/updateSort', '127.0.0.1', '鍐呯綉IP', '{\"menuIds\":\"2000\",\"orderNums\":\"3\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-30 19:54:52', 5);
INSERT INTO `sys_oper_log` VALUES (104, '淇濆瓨鑿滃崟鎺掑簭', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/updateSort', '127.0.0.1', '鍐呯綉IP', '{\"menuIds\":\"2\",\"orderNums\":\"0\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-30 19:55:05', 5);
INSERT INTO `sys_oper_log` VALUES (105, '淇濆瓨鑿滃崟鎺掑簭', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/updateSort', '127.0.0.1', '鍐呯綉IP', '{\"menuIds\":\"2,2000\",\"orderNums\":\"1,0\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-30 19:55:27', 7);
INSERT INTO `sys_oper_log` VALUES (106, '淇濆瓨鑿滃崟鎺掑簭', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/updateSort', '127.0.0.1', '鍐呯綉IP', '{\"menuIds\":\"2,3,4\",\"orderNums\":\"2,3,4\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-30 19:55:39', 8);
INSERT INTO `sys_oper_log` VALUES (107, '鑿滃崟绠＄悊', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"component\":\"business/resourse/resourse\",\"createBy\":\"admin\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"璧勬簮绠＄悊\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"resourse\",\"perms\":\"business:resourse:resourse\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-30 20:02:46', 11);
INSERT INTO `sys_oper_log` VALUES (108, '浠ｇ爜鐢熸垚', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen/importTable', '127.0.0.1', '鍐呯綉IP', '{\"tables\":\"my_course_resource\",\"tplWebType\":\"element-ui\"}', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-30 20:11:41', 45);
INSERT INTO `sys_oper_log` VALUES (109, '浠ｇ爜鐢熸垚', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen', '127.0.0.1', '鍐呯綉IP', '{\"businessName\":\"resource\",\"className\":\"MyCourseResource\",\"columns\":[{\"capJavaField\":\"ReId\",\"columnComment\":\"璧勬簮ID\",\"columnId\":1,\"columnName\":\"re_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"reId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CId\",\"columnComment\":\"鍏宠仈璇剧▼ID\",\"columnId\":2,\"columnName\":\"c_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ResourceType\",\"columnComment\":\"璧勬簮绫诲瀷 1-瑙嗛 2-鏂囨。 3-鍥句功 4-鏈熷垔 5-璁插骇\",\"columnId\":3,\"columnName\":\"resource_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"resourceType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"璧勬簮鏍囬\",\"columnId\":4,\"columnName\":\"title\",\"columnType\":\"varchar(200)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-30 20:27:35', 37);
INSERT INTO `sys_oper_log` VALUES (110, '浠ｇ爜鐢熸垚', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen/batchGenCode', '127.0.0.1', '鍐呯綉IP', '{\"tables\":\"my_course_resource\"}', NULL, 0, NULL, '2026-05-30 20:53:50', 155);
INSERT INTO `sys_oper_log` VALUES (111, '鑿滃崟绠＄悊', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/2002', '127.0.0.1', '鍐呯綉IP', '2002 ', '{\"msg\":\"瀛樺湪瀛愯彍鍗?涓嶅厑璁稿垹闄",\"code\":601}', 0, NULL, '2026-05-31 15:45:14', 13);
INSERT INTO `sys_oper_log` VALUES (112, '鑿滃崟绠＄悊', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/2003', '127.0.0.1', '鍐呯綉IP', '2003 ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 15:45:18', 10);
INSERT INTO `sys_oper_log` VALUES (113, '鑿滃崟绠＄悊', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/2004', '127.0.0.1', '鍐呯綉IP', '2004 ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 15:45:21', 9);
INSERT INTO `sys_oper_log` VALUES (114, '鑿滃崟绠＄悊', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/2005', '127.0.0.1', '鍐呯綉IP', '2005 ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 15:45:23', 8);
INSERT INTO `sys_oper_log` VALUES (115, '鑿滃崟绠＄悊', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/2006', '127.0.0.1', '鍐呯綉IP', '2006 ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 15:45:24', 8);
INSERT INTO `sys_oper_log` VALUES (116, '鑿滃崟绠＄悊', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/2007', '127.0.0.1', '鍐呯綉IP', '2007 ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 15:45:26', 7);
INSERT INTO `sys_oper_log` VALUES (117, '鑿滃崟绠＄悊', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/2002', '127.0.0.1', '鍐呯綉IP', '2002 ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 15:45:28', 8);
INSERT INTO `sys_oper_log` VALUES (118, '鑿滃崟绠＄悊', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"component\":\"business/resourse/index\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"璧勬簮妯″潡\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"resourse\",\"perms\":\"business:resourse:index\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"鏂板鑿滃崟\'璧勬簮妯″潡\'澶辫触锛岃矾鐢卞悕绉版垨鍦板潃宸插瓨鍦╘",\"code\":500}', 0, NULL, '2026-05-31 15:48:53', 9);
INSERT INTO `sys_oper_log` VALUES (119, '鑿滃崟绠＄悊', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"component\":\"business/resourse/index\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"璧勬簮妯″潡\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"resourse\",\"perms\":\"business:resourse:index\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"鏂板鑿滃崟\'璧勬簮妯″潡\'澶辫触锛岃矾鐢卞悕绉版垨鍦板潃宸插瓨鍦╘",\"code\":500}', 0, NULL, '2026-05-31 15:48:55', 4);
INSERT INTO `sys_oper_log` VALUES (120, '鑿滃崟绠＄悊', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/2001', '127.0.0.1', '鍐呯綉IP', '2001 ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 15:49:36', 8);
INSERT INTO `sys_oper_log` VALUES (121, '鑿滃崟绠＄悊', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"component\":\"business/resourse/index\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"璧勬簮妯″潡\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"resourse\",\"perms\":\"business:resourse:index\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 15:50:44', 14);
INSERT INTO `sys_oper_log` VALUES (122, '浠ｇ爜鐢熸垚', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen', '127.0.0.1', '鍐呯綉IP', '{\"businessName\":\"resource\",\"className\":\"MyCourseResource\",\"columns\":[{\"capJavaField\":\"ReId\",\"columnComment\":\"璧勬簮ID\",\"columnId\":1,\"columnName\":\"re_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"reId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-30 20:27:35\",\"usableColumn\":false},{\"capJavaField\":\"CId\",\"columnComment\":\"鍏宠仈璇剧▼ID\",\"columnId\":2,\"columnName\":\"c_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-30 20:27:35\",\"usableColumn\":false},{\"capJavaField\":\"ResourceType\",\"columnComment\":\"璧勬簮绫诲瀷 1-瑙嗛 2-鏂囨。 3-鍥句功 4-鏈熷垔 5-璁插骇\",\"columnId\":3,\"columnName\":\"resource_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"resourceType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-30 20:27:35\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"璧勬簮鏍囬\",\"columnId\":4,\"columnName\":\"title\",\"columnType\":\"varchar(200)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 15:56:46', 42);
INSERT INTO `sys_oper_log` VALUES (123, '浠ｇ爜鐢熸垚', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen/batchGenCode', '127.0.0.1', '鍐呯綉IP', '{\"tables\":\"my_course_resource\"}', NULL, 0, NULL, '2026-05-31 15:56:51', 144);
INSERT INTO `sys_oper_log` VALUES (124, '浠ｇ爜鐢熸垚', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen', '127.0.0.1', '鍐呯綉IP', '{\"businessName\":\"resource\",\"className\":\"MyCourseResource\",\"columns\":[{\"capJavaField\":\"ReId\",\"columnComment\":\"璧勬簮ID\",\"columnId\":1,\"columnName\":\"re_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"reId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-31 15:56:46\",\"usableColumn\":false},{\"capJavaField\":\"CId\",\"columnComment\":\"鍏宠仈璇剧▼ID\",\"columnId\":2,\"columnName\":\"c_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-31 15:56:46\",\"usableColumn\":false},{\"capJavaField\":\"ResourceType\",\"columnComment\":\"璧勬簮绫诲瀷 1-瑙嗛 2-鏂囨。 3-鍥句功 4-鏈熷垔 5-璁插骇\",\"columnId\":3,\"columnName\":\"resource_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"resourceType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-31 15:56:46\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"璧勬簮鏍囬\",\"columnId\":4,\"columnName\":\"title\",\"columnType\":\"varchar(200)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 16:17:12', 84);
INSERT INTO `sys_oper_log` VALUES (125, '浠ｇ爜鐢熸垚', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen/batchGenCode', '127.0.0.1', '鍐呯綉IP', '{\"tables\":\"my_course_resource\"}', NULL, 0, NULL, '2026-05-31 16:17:22', 159);
INSERT INTO `sys_oper_log` VALUES (126, '浠ｇ爜鐢熸垚', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen/importTable', '127.0.0.1', '鍐呯綉IP', '{\"tables\":\"my_notification\",\"tplWebType\":\"element-ui\"}', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 16:24:02', 66);
INSERT INTO `sys_oper_log` VALUES (127, '浠ｇ爜鐢熸垚', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen', '127.0.0.1', '鍐呯綉IP', '{\"businessName\":\"notification\",\"className\":\"MyNotification\",\"columns\":[{\"capJavaField\":\"NotiId\",\"columnComment\":\"閫氱煡ID\",\"columnId\":12,\"columnName\":\"noti_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-31 16:24:02\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"notiId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SenderId\",\"columnComment\":\"鍙戦€佽€匢D\",\"columnId\":13,\"columnName\":\"sender_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-31 16:24:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"senderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SenderType\",\"columnComment\":\"鍙戦€佽€呯被鍨?1-绯荤粺 2-鏁欏笀 3-绠＄悊鍛榎",\"columnId\":14,\"columnName\":\"sender_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-31 16:24:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"senderType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"閫氱煡鏍囬\",\"columnId\":15,\"columnName\":\"title\",\"columnType\":\"varchar(200)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-31 16:24:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 16:26:32', 37);
INSERT INTO `sys_oper_log` VALUES (128, '浠ｇ爜鐢熸垚', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen/batchGenCode', '127.0.0.1', '鍐呯綉IP', '{\"tables\":\"my_notification\"}', NULL, 0, NULL, '2026-05-31 16:26:35', 131);
INSERT INTO `sys_oper_log` VALUES (129, '浠ｇ爜鐢熸垚', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen/importTable', '127.0.0.1', '鍐呯綉IP', '{\"tables\":\"my_teacher\",\"tplWebType\":\"element-ui\"}', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 18:53:54', 71);
INSERT INTO `sys_oper_log` VALUES (130, '浠ｇ爜鐢熸垚', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen/importTable', '127.0.0.1', '鍐呯綉IP', '{\"tables\":\"my_homework\",\"tplWebType\":\"element-ui\"}', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 19:57:04', 106);
INSERT INTO `sys_oper_log` VALUES (131, '浠ｇ爜鐢熸垚', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen/3', '127.0.0.1', '鍐呯綉IP', '[3] ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 19:58:21', 12);
INSERT INTO `sys_oper_log` VALUES (132, '鑿滃崟绠＄悊', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"createTime\":\"2026-05-31 22:27:48\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2027,\"menuName\":\"璇剧▼绠＄悊\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"course\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"淇敼鑿滃崟\'璇剧▼绠＄悊\'澶辫触锛屽湴鍧€蹇呴』浠ttp(s)://寮€澶碶",\"code\":500}', 0, NULL, '2026-05-31 22:29:26', 25);
INSERT INTO `sys_oper_log` VALUES (133, '鑿滃崟绠＄悊', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"createTime\":\"2026-05-29 20:04:53\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"绯荤粺宸ュ叿\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 23:28:53', 22);
INSERT INTO `sys_oper_log` VALUES (134, '鑿滃崟绠＄悊', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2184,\"menuName\":\"浣滀笟绠＄悊\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"homework\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"淇敼鑿滃崟\'浣滀笟绠＄悊\'澶辫触锛屽湴鍧€蹇呴』浠ttp(s)://寮€澶碶",\"code\":500}', 0, NULL, '2026-05-31 23:28:56', 3);
INSERT INTO `sys_oper_log` VALUES (135, '鑿滃崟绠＄悊', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2191,\"menuName\":\"瀛︿範涓績\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"study\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"淇敼鑿滃崟\'瀛︿範涓績\'澶辫触锛屽湴鍧€蹇呴』浠ttp(s)://寮€澶碶",\"code\":500}', 0, NULL, '2026-05-31 23:29:06', 2);
INSERT INTO `sys_oper_log` VALUES (136, '鑿滃崟绠＄悊', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2191,\"menuName\":\"瀛︿範涓績\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"study\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"淇敼鑿滃崟\'瀛︿範涓績\'澶辫触锛屽湴鍧€蹇呴』浠ttp(s)://寮€澶碶",\"code\":500}', 0, NULL, '2026-05-31 23:29:08', 3);
INSERT INTO `sys_oper_log` VALUES (137, '鑿滃崟绠＄悊', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2191,\"menuName\":\"瀛︿範涓績\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"study\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"淇敼鑿滃崟\'瀛︿範涓績\'澶辫触锛屽湴鍧€蹇呴』浠ttp(s)://寮€澶碶",\"code\":500}', 0, NULL, '2026-05-31 23:29:11', 4);
INSERT INTO `sys_oper_log` VALUES (138, '鑿滃崟绠＄悊', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"createTime\":\"2026-05-29 20:04:53\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"鑻ヤ緷瀹樼綉\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 23:29:39', 10);
INSERT INTO `sys_oper_log` VALUES (139, '鑿滃崟绠＄悊', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2191,\"menuName\":\"瀛︿範涓績\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"study\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"淇敼鑿滃崟\'瀛︿範涓績\'澶辫触锛屽湴鍧€蹇呴』浠ttp(s)://寮€澶碶",\"code\":500}', 0, NULL, '2026-05-31 23:29:43', 3);
INSERT INTO `sys_oper_log` VALUES (140, '鑿滃崟绠＄悊', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2191,\"menuName\":\"瀛︿範涓績\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"study\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"淇敼鑿滃崟\'瀛︿範涓績\'澶辫触锛屽湴鍧€蹇呴』浠ttp(s)://寮€澶碶",\"code\":500}', 0, NULL, '2026-05-31 23:29:51', 3);
INSERT INTO `sys_oper_log` VALUES (141, '鑿滃崟绠＄悊', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2191,\"menuName\":\"瀛︿範涓績\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"study\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"淇敼鑿滃崟\'瀛︿範涓績\'澶辫触锛屽湴鍧€蹇呴』浠ttp(s)://寮€澶碶",\"code\":500}', 0, NULL, '2026-05-31 23:29:53', 3);
INSERT INTO `sys_oper_log` VALUES (142, '鑿滃崟绠＄悊', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2191,\"menuName\":\"瀛︿範涓績\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"study\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"淇敼鑿滃崟\'瀛︿範涓績\'澶辫触锛屽湴鍧€蹇呴』浠ttp(s)://寮€澶碶",\"code\":500}', 0, NULL, '2026-05-31 23:30:00', 3);
INSERT INTO `sys_oper_log` VALUES (143, '鑿滃崟绠＄悊', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"component\":\"study/myStudyRecord/index\",\"createTime\":\"2026-05-31 23:26:21\",\"icon\":\"time\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2192,\"menuName\":\"瀛︿範璁板綍\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2191,\"path\":\"myStudyRecord\",\"perms\":\"study:myStudyRecord:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"淇敼鑿滃崟\'瀛︿範璁板綍\'澶辫触锛屽湴鍧€蹇呴』浠ttp(s)://寮€澶碶",\"code\":500}', 0, NULL, '2026-05-31 23:30:17', 1);
INSERT INTO `sys_oper_log` VALUES (144, '瀛︾敓', 1, 'com.ruoyi.web.controller.userext.MyStudentController.add()', 'POST', 1, 'admin', '鐮斿彂閮ㄩ棬', '/userext/myStudent', '127.0.0.1', '鍐呯綉IP', '{\"birthday\":\"2026-05-06\",\"className\":\"24-1\",\"correctQuestions\":100,\"grade\":\"24绾",\"major\":\"鏈哄櫒浜哄伐绋媆",\"params\":{},\"rankLevel\":\"鐜嬭€匼",\"rankScore\":9999,\"stuId\":5,\"studentNo\":\"202401203027\",\"studyHours\":100,\"teacherId\":3,\"totalQuestions\":100,\"userId\":7} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-05-31 23:49:39', 32);
INSERT INTO `sys_oper_log` VALUES (145, '淇濆瓨鑿滃崟鎺掑簭', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/updateSort', '127.0.0.1', '鍐呯綉IP', '{\"menuIds\":\"2191\",\"orderNums\":\"2\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-01 00:10:12', 17);
INSERT INTO `sys_oper_log` VALUES (146, '淇濆瓨鑿滃崟鎺掑簭', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/updateSort', '127.0.0.1', '鍐呯綉IP', '{\"menuIds\":\"1,2,3,4\",\"orderNums\":\"4,6,6,5\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-01 00:10:55', 10);
INSERT INTO `sys_oper_log` VALUES (147, '淇濆瓨鑿滃崟鎺掑簭', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/updateSort', '127.0.0.1', '鍐呯綉IP', '{\"menuIds\":\"4\",\"orderNums\":\"8\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-01 00:11:04', 5);
INSERT INTO `sys_oper_log` VALUES (148, '璧勬簮妯″潡', 2, 'com.ruoyi.web.controller.resourse.MyCourseResourceController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/business/resource', '127.0.0.1', '鍐呯綉IP', '{\"content\":\"Python瀹夎涓庨厤缃甛",\"createTime\":\"2026-05-30 17:29:27\",\"homework\":\"瀹屾垚鐜瀹夎\",\"params\":{},\"reId\":1,\"resourceType\":1,\"sortOrder\":1,\"tag\":\"Python,鐜\",\"title\":\"Python鐜鎼缓\",\"videoUrl\":\"https://video.com/python1\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-01 19:27:41', 29);
INSERT INTO `sys_oper_log` VALUES (149, '璧勬簮妯″潡', 2, 'com.ruoyi.web.controller.resourse.MyCourseResourceController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/business/resource', '127.0.0.1', '鍐呯綉IP', '{\"content\":\"Python瀹夎涓庨厤缃甛",\"createTime\":\"2026-05-30 17:29:27\",\"homework\":\"瀹屾垚鐜瀹夎\",\"params\":{},\"reId\":1,\"resourceType\":1,\"sortOrder\":1,\"tag\":\"Python,鐜\",\"title\":\"Python鐜鎼缓\",\"videoUrl\":\"https://video.com/python1\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-01 20:57:46', 15);
INSERT INTO `sys_oper_log` VALUES (150, '璧勬簮妯″潡', 2, 'com.ruoyi.web.controller.resourse.MyCourseResourceController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/business/resource', '127.0.0.1', '鍐呯綉IP', '{\"content\":\"<p>Python瀹夎涓庨厤缃?/p>\",\"createTime\":\"2026-05-30 17:29:27\",\"homework\":\"瀹屾垚鐜瀹夎\",\"params\":{},\"reId\":1,\"resourceType\":1,\"sortOrder\":1,\"tag\":\"Python,鐜\",\"title\":\"Python鐜鎼缓\",\"videoUrl\":\"https://video.com/python1\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-01 20:57:56', 4);
INSERT INTO `sys_oper_log` VALUES (151, '璧勬簮妯″潡', 2, 'com.ruoyi.web.controller.resourse.MyCourseResourceController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/business/resource', '127.0.0.1', '鍐呯綉IP', '{\"content\":\"<p>Python瀹夎涓庨厤缃?/p>\",\"createTime\":\"2026-05-30 17:29:27\",\"homework\":\"瀹屾垚鐜瀹夎\",\"params\":{},\"reId\":1,\"resourceType\":1,\"sortOrder\":1,\"tag\":\"Python,鐜\",\"title\":\"Python鐜鎼缓\",\"videoUrl\":\"https://video.com/python1\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-01 20:58:01', 1);
INSERT INTO `sys_oper_log` VALUES (152, '璧勬簮妯″潡', 2, 'com.ruoyi.web.controller.resourse.MyCourseResourceController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/business/resource', '127.0.0.1', '鍐呯綉IP', '{\"content\":\"<p>Python瀹夎涓庨厤缃?/p>\",\"createTime\":\"2026-05-30 17:29:27\",\"homework\":\"瀹屾垚鐜瀹夎\",\"params\":{},\"reId\":1,\"resourceType\":1,\"sortOrder\":1,\"tag\":\"Python,鐜\",\"title\":\"Python鐜鎼缓\",\"videoUrl\":\"https://video.com/python1\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-02 16:25:57', 18);
INSERT INTO `sys_oper_log` VALUES (153, '浠ｇ爜鐢熸垚', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen', '127.0.0.1', '鍐呯綉IP', '{\"businessName\":\"resource\",\"className\":\"MyCourseResource\",\"columns\":[{\"capJavaField\":\"ReId\",\"columnComment\":\"璧勬簮ID\",\"columnId\":1,\"columnName\":\"re_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"reId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-31 16:17:12\",\"usableColumn\":false},{\"capJavaField\":\"CId\",\"columnComment\":\"鍏宠仈璇剧▼ID\",\"columnId\":2,\"columnName\":\"c_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"cId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-31 16:17:12\",\"usableColumn\":false},{\"capJavaField\":\"ResourceType\",\"columnComment\":\"璧勬簮绫诲瀷 1-瑙嗛 2-鏂囨。 3-鍥句功 4-鏈熷垔 5-璁插骇\",\"columnId\":3,\"columnName\":\"resource_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"resourceType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-05-31 16:17:12\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"璧勬簮鏍囬\",\"columnId\":4,\"columnName\":\"title\",\"columnType\":\"varchar(200)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-30 20:11:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-02 16:32:31', 40);
INSERT INTO `sys_oper_log` VALUES (154, '浠ｇ爜鐢熸垚', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen/batchGenCode', '127.0.0.1', '鍐呯綉IP', '{\"tables\":\"my_course_resource\"}', NULL, 0, NULL, '2026-06-02 16:35:15', 33);
INSERT INTO `sys_oper_log` VALUES (155, '瀛︽儏鎶ヨ〃', 5, 'com.ruoyi.web.controller.study.MyStudyReportController.export()', 'POST', 1, 'admin', '鐮斿彂閮ㄩ棬', '/study/myStudyReport/export', '127.0.0.1', '鍐呯綉IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2026-06-02 18:35:40', 550);
INSERT INTO `sys_oper_log` VALUES (156, '淇濆瓨鑿滃崟鎺掑簭', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/updateSort', '127.0.0.1', '鍐呯綉IP', '{\"menuIds\":\"2000,2164,2171\",\"orderNums\":\"1,2,0\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-02 19:53:55', 34);
INSERT INTO `sys_oper_log` VALUES (157, '浠ｇ爜鐢熸垚', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '鐮斿彂閮ㄩ棬', '/tool/gen/importTable', '127.0.0.1', '鍐呯綉IP', '{\"tables\":\"my_bank\",\"tplWebType\":\"element-ui\"}', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-03 15:23:19', 88);
INSERT INTO `sys_oper_log` VALUES (158, '淇濆瓨鑿滃崟鎺掑簭', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/updateSort', '127.0.0.1', '鍐呯綉IP', '{\"menuIds\":\"1,2,3\",\"orderNums\":\"5,7,7\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-03 15:25:48', 9);
INSERT INTO `sys_oper_log` VALUES (159, '淇濆瓨鑿滃崟鎺掑簭', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu/updateSort', '127.0.0.1', '鍐呯綉IP', '{\"menuIds\":\"1,2234,2241\",\"orderNums\":\"6,4,5\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-03 18:04:22', 24);
INSERT INTO `sys_oper_log` VALUES (160, '鑿滃崟绠＄悊', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"createTime\":\"2026-06-03 19:00:00\",\"icon\":\"qq\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2300,\"menuName\":\"AI鏅鸿兘鍔╂墜\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"aiAgent\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-03 23:31:04', 19);
INSERT INTO `sys_oper_log` VALUES (161, '鑿滃崟绠＄悊', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '鐮斿彂閮ㄩ棬', '/system/menu', '127.0.0.1', '鍐呯綉IP', '{\"children\":[],\"createTime\":\"2026-06-03 19:00:00\",\"icon\":\"qq\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2300,\"menuName\":\"AI鏅鸿兘鍔╂墜\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"aiAgent\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"鎿嶄綔鎴愬姛\",\"code\":200}', 0, NULL, '2026-06-03 23:32:31', 7);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '宀椾綅ID',
  `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '宀椾綅缂栫爜',
  `post_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '宀椾綅鍚嶇О',
  `post_sort` int NOT NULL COMMENT '鏄剧ず椤哄簭',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍒涘缓鑰?,
  `create_time` datetime NULL DEFAULT NULL COMMENT '鍒涘缓鏃堕棿',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鏇存柊鑰?,
  `update_time` datetime NULL DEFAULT NULL COMMENT '鏇存柊鏃堕棿',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '澶囨敞',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '宀椾綅淇℃伅琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '钁ｄ簨闀?, 1, '0', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '椤圭洰缁忕悊', 2, '0', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '浜哄姏璧勬簮', 3, '0', 'admin', '2026-05-29 20:04:53', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '鏅€氬憳宸?, 4, '0', 'admin', '2026-05-29 20:04:53', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '瑙掕壊ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '瑙掕壊鍚嶇О',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '瑙掕壊鏉冮檺瀛楃涓?,
  `role_sort` int NOT NULL COMMENT '鏄剧ず椤哄簭',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '鏁版嵁鑼冨洿锛?锛氬叏閮ㄦ暟鎹潈闄?2锛氳嚜瀹氭暟鎹潈闄?3锛氭湰閮ㄩ棬鏁版嵁鏉冮檺 4锛氭湰閮ㄩ棬鍙婁互涓嬫暟鎹潈闄愶級',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '鑿滃崟鏍戦€夋嫨椤规槸鍚﹀叧鑱旀樉绀?,
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '閮ㄩ棬鏍戦€夋嫨椤规槸鍚﹀叧鑱旀樉绀?,
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '瑙掕壊鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '鍒犻櫎鏍囧織锛?浠ｈ〃瀛樺湪 2浠ｈ〃鍒犻櫎锛?,
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍒涘缓鑰?,
  `create_time` datetime NULL DEFAULT NULL COMMENT '鍒涘缓鏃堕棿',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鏇存柊鑰?,
  `update_time` datetime NULL DEFAULT NULL COMMENT '鏇存柊鏃堕棿',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '澶囨敞',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '瑙掕壊淇℃伅琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '瓒呯骇绠＄悊鍛?, 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL, '瓒呯骇绠＄悊鍛?);
INSERT INTO `sys_role` VALUES (2, '鏅€氳鑹?, 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-05-29 20:04:53', '', NULL, '鏅€氳鑹?);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '瑙掕壊ID',
  `dept_id` bigint NOT NULL COMMENT '閮ㄩ棬ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '瑙掕壊鍜岄儴闂ㄥ叧鑱旇〃' ROW_FORMAT = Dynamic;

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
  `role_id` bigint NOT NULL COMMENT '瑙掕壊ID',
  `menu_id` bigint NOT NULL COMMENT '鑿滃崟ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '瑙掕壊鍜岃彍鍗曞叧鑱旇〃' ROW_FORMAT = Dynamic;

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
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '鐢ㄦ埛ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '閮ㄩ棬ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '鐢ㄦ埛璐﹀彿',
  `nick_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '鐢ㄦ埛鏄电О',
  `user_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '00' COMMENT '鐢ㄦ埛绫诲瀷锛?0绯荤粺鐢ㄦ埛锛?,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鐢ㄦ埛閭',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鎵嬫満鍙风爜',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '鐢ㄦ埛鎬у埆锛?鐢?1濂?2鏈煡锛?,
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '澶村儚鍦板潃',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '瀵嗙爜',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '璐﹀彿鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '鍒犻櫎鏍囧織锛?浠ｈ〃瀛樺湪 2浠ｈ〃鍒犻櫎锛?,
  `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鏈€鍚庣櫥褰旾P',
  `login_date` datetime NULL DEFAULT NULL COMMENT '鏈€鍚庣櫥褰曟椂闂?,
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '瀵嗙爜鏈€鍚庢洿鏂版椂闂?,
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鍒涘缓鑰?,
  `create_time` datetime NULL DEFAULT NULL COMMENT '鍒涘缓鏃堕棿',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '鏇存柊鑰?,
  `update_time` datetime NULL DEFAULT NULL COMMENT '鏇存柊鏃堕棿',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '澶囨敞',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '鐢ㄦ埛淇℃伅琛? ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '鑻ヤ緷', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-06-04 20:16:26', '2026-05-29 20:04:53', 'admin', '2026-05-29 20:04:53', '', NULL, '绠＄悊鍛?);
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '鑻ヤ緷', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-05-29 20:04:53', '2026-05-29 20:04:53', 'admin', '2026-05-29 20:04:53', '', NULL, '娴嬭瘯鍛?);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '鐢ㄦ埛ID',
  `post_id` bigint NOT NULL COMMENT '宀椾綅ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '鐢ㄦ埛涓庡矖浣嶅叧鑱旇〃' ROW_FORMAT = Dynamic;

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
  `user_id` bigint NOT NULL COMMENT '鐢ㄦ埛ID',
  `role_id` bigint NOT NULL COMMENT '瑙掕壊ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '鐢ㄦ埛鍜岃鑹插叧鑱旇〃' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

-- ============================================================
--  鐘舵€佽涔変慨姝?鎵ц涓嬮潰杩欐淇宸叉湁搴撶殑鐘舵€佸€?
--  my_homework.status / my_student_homework.status 缁熶竴:
--    0-鏈彁浜? 1-宸叉彁浜? 2-宸叉壒鏀?
-- ============================================================
SET FOREIGN_KEY_CHECKS = 0;

-- 1) 璋冩暣瀛楁榛樿鍊间笌娉ㄩ噴
ALTER TABLE my_homework        MODIFY COLUMN status TINYINT NULL DEFAULT 0 COMMENT '鐘舵€?0-鏈彁浜?1-宸叉彁浜?2-宸叉壒鏀?;
ALTER TABLE my_student_homework MODIFY COLUMN status TINYINT NULL DEFAULT 0 COMMENT '鐘舵€?0-鏈彁浜?1-宸叉彁浜?2-宸叉壒鏀?;

-- 2) 宸叉湁 my_student_homework 宸叉壒鏀?status=1 鐨勬棫璇箟=宸叉壒鏀? -> 2
UPDATE my_student_homework
SET status = 2
WHERE status = 1
  AND (score IS NOT NULL OR teacher_comment IS NOT NULL);

-- 3) 宸叉湁 my_student_homework 宸叉彁浜や絾鏃у€艰閿欒 -> 1
UPDATE my_student_homework
SET status = 1
WHERE status = 1
  AND score IS NULL
  AND (teacher_comment IS NULL OR teacher_comment = '')
  AND answers IS NOT NULL
  AND TRIM(answers) <> '';

-- 4) 鎶?my_homework.status 鎸夊搴?my_student_homework.status 鍚屾杩囨潵(姣忔潯浣滀笟鐨勬瘡浣嶅鐢?
UPDATE my_homework h
JOIN my_student_homework msh
  ON msh.hw_id = h.hw_id AND msh.stu_id = h.std_id
SET h.status = msh.status;

-- 5) 缁欐墍鏈?my_student_homework 宸叉湁绛旀浣?status=0 鐨勮褰?琛ユ垚宸叉彁浜?1
UPDATE my_student_homework
SET status = 1, submit_time = COALESCE(submit_time, update_time, create_time, NOW())
WHERE status = 0
  AND answers IS NOT NULL
  AND TRIM(answers) <> '';

-- 6) 鍐嶆鎶?my_homework 涓?my_student_homework 鐘舵€佸榻?
UPDATE my_homework h
JOIN my_student_homework msh
  ON msh.hw_id = h.hw_id AND msh.stu_id = h.std_id
SET h.status = msh.status;

SET FOREIGN_KEY_CHECKS = 1;
