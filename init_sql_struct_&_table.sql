-- ----------------------------------- --
--  1.所有的金钱为分为单位                --
--  2.所有的id默认为自增                 --
--  3.所有的状态默认为正常(200）         --
-- ----------------------------------- --
DROP DATABASE IF EXISTS `online_course`;
CREATE DATABASE online_course;
use online_course;
-- 用户表
DROP TABLE IF EXISTS `online_course_user`;
CREATE TABLE `online_course_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `user_name` varchar(50)  NOT NULL COMMENT '用户的昵称',
  `user_password` varchar(16) NOT NULL COMMENT '用户密码',
  `user_phone` varchar(11) NOT NULL COMMENT '用户的手机号',
  `user_balance` int(11) NULL COMMENT '用户的余额',
  `user_bank_card_no` varchar(19) NOT NULL COMMENT '用户银行卡账号', -- 正常为16/17,信用卡为16,最长的为19
  `user_id_card_no` varchar(18) NOT NULL COMMENT '用户身份证号', -- 新版为18，老版为15
  `user_gmt_create_time` int(11) NOT NULL COMMENT '用户创建时间<格林威治>(20180607)',
  `user_status` int(11) DEFAULT 200 NULL COMMENT '用户的状态（删除为404,正常为200, etc）',
  `user_info` varchar(500) NULL COMMENT 'region、gender、age、interest_subject_ids、etc',
  `extra_info` varchar(300) NOT NULL DEFAULT '{}' COMMENT '一些额外信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- 上传视频者 / 讲师
DROP TABLE IF EXISTS `online_course_manager`;
CREATE TABLE `online_course_manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `manager_name` varchar(50)  NOT NULL COMMENT '管理者的昵称',
  `manager_password` varchar(16) NOT NULL COMMENT '管理者密码',
  `manager_phone` varchar(11) NOT NULL COMMENT '管理者的手机号',
  `manager_balance` int(11) NULL COMMENT '管理者的余额',
  `manager_bank_card_no` varchar(19) NULL COMMENT '管理者银行卡账号', -- 正常为16/17,信用卡为16,最长的为19
  `manager_id_card_no` varchar(18) NULL COMMENT '管理者身份证号', -- 新版为18，老版为15
  `manager_profession_no` varchar(18) NULL COMMENT '管理者教师资格证（上传视频时需绑定）' ,
  `manager_gmt_create_time` varchar(20) NOT NULL COMMENT '管理者创建时间<格林威治>(20180607)',
  `manager_status` int(11) NULL DEFAULT 200 COMMENT '管理者的状态（删除为404,正常为200, etc）',
  `manager_info` varchar(500) NULL COMMENT 'region、gender、age、interest_subject_ids、etc',
  `extra_info` varchar(300) NOT NULL DEFAULT '{}' COMMENT '一些额外信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- 后台管理员工
DROP TABLE IF EXISTS `online_course_admin`;
CREATE TABLE `online_course_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `admin_employee_no` int(11) NOT NULL COMMENT '后台人员工号',
  `admin_account` varchar(50)  NOT NULL COMMENT '后台人员的账号',
  `admin_password` varchar(16) NOT NULL COMMENT '后台人员密码',
  `admin_phone` varchar(11) NOT NULL COMMENT '后台人员的手机号',
  `admin_gmt_create_time` varchar(20) NOT NULL COMMENT '后台人员创建时间<格林威治>(20180607)',
  `admin_status` int(11) NULL DEFAULT 200 COMMENT '后台人员的状态（删除为404,正常为200, etc）',
  `admin_info` varchar(500) NULL COMMENT 'region、gender、age、interest_subject_ids、etc',
  `extra_info` varchar(300) NOT NULL DEFAULT '{}' COMMENT '一些额外信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- 课程：课程表
DROP TABLE IF EXISTS `online_course_course`;
CREATE TABLE `online_course_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `course_subject_id` varchar(100) NULL COMMENT '课程科目编号',
  `course_upload_manager_id` varchar(100) NOT NULL COMMENT '课程上传及维护者编号, 9999为系统',
  `course_name` varchar(50) NOT NULL COMMENT '课程名(具有唯一性)',
  `course_description` varchar(500) NOT NULL COMMENT '课程描述',
  `course_tags` varchar(11) NULL COMMENT '课程标签，json数组[tagId1, tagId2, ...]',
  `course_gmt_create_time` varchar(20) NOT NULL COMMENT '课程创建时间<格林威治>(20180607)',
  `course_status` int(11) NULL DEFAULT 200 COMMENT '课程的状态（删除为404,正常为200, etc）',
  `extra_info` varchar(300) NOT NULL DEFAULT '{}' COMMENT '一些额外信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- 课程：科目表
DROP TABLE IF EXISTS `online_course_subject`;
CREATE TABLE `online_course_subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `subject_name` varchar(100) NULL COMMENT '科目名称',
  `subject_upload_manager_id` varchar(100) NOT NULL COMMENT '课程上传及维护者编号, 9999为系统',
  `subject_status` int(11) DEFAULT 200 NULL COMMENT '课程的状态（删除为404,正常为200, etc）',
  `extra_info` varchar(300) NOT NULL DEFAULT '{}' COMMENT '一些额外信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- 订单
DROP TABLE IF EXISTS `online_course_order`;
CREATE TABLE `online_course_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `order_amount` int(11) NOT NULL COMMENT '订单总额（分为单位例如，100元为10,000）',
  `order_eraner_id` varchar(100) NOT NULL COMMENT '订单的收益者编号(与manger_id相关)',
  `order_cosumer_id` varchar(100) NOT NULL COMMENT '订单的消费者编号（与user_id相关）',
  `order_course_id` varchar(100) NOT NULL COMMENT '订单的课程编号',
  `order_timestamp_create_time` int(11) NOT NULL COMMENT '订单创建时间<时间戳>(15012303)',
  `order_gmt_create_time` varchar(20) NOT NULL COMMENT '订单创建时间<格林威治>(20180607)',
  `order_status` int(11) NULL DEFAULT 200 COMMENT '订单的状态（删除为404,正常为200, etc）',
  `order_progress` int(11) NULL DEFAULT 100 COMMENT '订单进行状态（CREATED:100, paid:200, error: 500, canceld: 304, etc）',
  `extra_info` varchar(300) NOT NULL DEFAULT '{}' COMMENT '一些额外信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- 评价
DROP TABLE IF EXISTS `online_course_comment`;
CREATE TABLE `online_course_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `comment_amount` int(11) NOT NULL COMMENT '评价总额（分为单位例如，100元为10,000）',
  `comment_owner_id` varchar(100) NOT NULL COMMENT '收益者编号(与manger_id相关)',
  `comment_commenter_id` varchar(100) NOT NULL COMMENT '消费者编号（与user_id相关）',
  `comment_course_id` varchar(100) NOT NULL COMMENT '评价的课程编号',
  `comment_content` varchar(500) NOT NULL COMMENT '评价的内容',
  `comment_gmt_create_time` varchar(20) NOT NULL COMMENT '评价创建时间<格林威治>(20180607)',
  `comment_status` int(11) DEFAULT 200 NULL COMMENT '课程的状态（删除为404,正常为200, etc）',
  `comment_star_level` int(11) NULL DEFAULT 5  COMMENT ' 评论星级（1-5, 5 is best)',
  `extra_info` varchar(300) NOT NULL DEFAULT '{}' COMMENT '一些额外信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;


