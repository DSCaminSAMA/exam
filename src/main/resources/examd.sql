/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 5.7.18-log : Database - exam
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`exam` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `exam`;

/*Table structure for table `t_exam_paper` */

DROP TABLE IF EXISTS `t_exam_paper`;

CREATE TABLE `t_exam_paper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '试卷名称',
  `subject_id` int(11) DEFAULT NULL COMMENT '学科',
  `paper_type` int(11) DEFAULT NULL COMMENT '试卷类型( 1固定试卷  2临时试卷 3班级试卷 4.时段试卷 5.推送试卷)',
  `grade_level` int(11) DEFAULT NULL COMMENT '级别',
  `score` int(11) DEFAULT NULL COMMENT '试卷总分(千分制)',
  `question_count` int(11) DEFAULT NULL COMMENT '题目数量',
  `suggest_time` int(11) DEFAULT NULL COMMENT '建议时长(分钟)',
  `limit_start_time` datetime DEFAULT NULL COMMENT '时段试卷 开始时间',
  `limit_end_time` datetime DEFAULT NULL COMMENT '时段试卷 结束时间',
  `frame_text_content_id` int(11) DEFAULT NULL COMMENT '试卷框架 内容为JSON',
  `create_user` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `task_exam_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `t_exam_paper` */

insert  into `t_exam_paper`(`id`,`name`,`subject_id`,`paper_type`,`grade_level`,`score`,`question_count`,`suggest_time`,`limit_start_time`,`limit_end_time`,`frame_text_content_id`,`create_user`,`create_time`,`deleted`,`task_exam_id`) values 
(1,'固定试卷',59,1,12,70,2,20,NULL,NULL,3,2,'2019-09-07 06:59:14','\0',NULL),
(2,'测试1',1,1,1,70,2,60,NULL,NULL,5,2,'2019-10-09 16:23:08','\0',NULL),
(3,'测试卷',1,1,1,500,10,30,NULL,NULL,80,2,'2019-10-31 15:34:48','\0',NULL),
(4,'测试',1,1,1,40,1,2,NULL,NULL,82,2,'2019-11-04 15:09:50','\0',NULL),
(5,'我的第一个试卷',1,1,1,450,9,60,NULL,NULL,86,2,'2019-11-09 13:08:23','\0',NULL);

/*Table structure for table `t_exam_paper_answer` */

DROP TABLE IF EXISTS `t_exam_paper_answer`;

CREATE TABLE `t_exam_paper_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_paper_id` int(11) DEFAULT NULL,
  `paper_name` varchar(255) DEFAULT NULL COMMENT '试卷名称',
  `paper_type` int(11) DEFAULT NULL COMMENT '试卷类型( 1固定试卷  2临时试卷 3班级试卷 4.时段试卷 )',
  `subject_id` int(11) DEFAULT NULL COMMENT '学科',
  `system_score` int(11) DEFAULT NULL COMMENT '系统判定得分',
  `user_score` int(11) DEFAULT NULL COMMENT '最终得分(千分制)',
  `paper_score` int(11) DEFAULT NULL COMMENT '试卷总分',
  `question_correct` int(11) DEFAULT NULL COMMENT '做对题目数量',
  `question_count` int(11) DEFAULT NULL COMMENT '题目总数量',
  `do_time` int(11) DEFAULT NULL COMMENT '做题时间(秒)',
  `status` int(11) DEFAULT NULL COMMENT '试卷状态(1待判分 2完成)',
  `create_user` int(11) DEFAULT NULL COMMENT '学生',
  `create_time` datetime DEFAULT NULL COMMENT '提交时间',
  `task_exam_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `t_exam_paper_answer` */

insert  into `t_exam_paper_answer`(`id`,`exam_paper_id`,`paper_name`,`paper_type`,`subject_id`,`system_score`,`user_score`,`paper_score`,`question_correct`,`question_count`,`do_time`,`status`,`create_user`,`create_time`,`task_exam_id`) values 
(1,1,'固定试卷',1,59,30,60,70,1,2,4,2,1,'2019-09-07 07:07:09',NULL);

/*Table structure for table `t_exam_paper_question_customer_answer` */

DROP TABLE IF EXISTS `t_exam_paper_question_customer_answer`;

CREATE TABLE `t_exam_paper_question_customer_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL COMMENT '题目Id',
  `exam_paper_id` int(11) DEFAULT NULL COMMENT '答案Id',
  `exam_paper_answer_id` int(11) DEFAULT NULL,
  `question_type` int(11) DEFAULT NULL COMMENT '题型',
  `subject_id` int(11) DEFAULT NULL COMMENT '学科',
  `customer_score` int(11) DEFAULT NULL COMMENT '得分',
  `question_score` int(11) DEFAULT NULL COMMENT '题目原始分数',
  `question_text_content_id` int(11) DEFAULT NULL COMMENT '问题内容',
  `answer` varchar(255) DEFAULT NULL COMMENT '做题答案',
  `text_content_id` int(11) DEFAULT NULL COMMENT '做题内容',
  `do_right` bit(1) DEFAULT NULL COMMENT '是否正确',
  `create_user` int(11) DEFAULT NULL COMMENT '做题人',
  `create_time` datetime DEFAULT NULL,
  `item_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `t_exam_paper_question_customer_answer` */

insert  into `t_exam_paper_question_customer_answer`(`id`,`question_id`,`exam_paper_id`,`exam_paper_answer_id`,`question_type`,`subject_id`,`customer_score`,`question_score`,`question_text_content_id`,`answer`,`text_content_id`,`do_right`,`create_user`,`create_time`,`item_order`) values 
(1,1,1,1,1,59,30,30,1,'B',NULL,'',1,'2019-09-07 07:07:09',1),
(2,2,1,1,4,59,30,40,2,NULL,4,'\0',1,'2019-09-07 07:07:09',2);

/*Table structure for table `t_message` */

DROP TABLE IF EXISTS `t_message`;

CREATE TABLE `t_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `content` varchar(500) DEFAULT NULL COMMENT '内容',
  `create_time` datetime DEFAULT NULL,
  `send_user_id` int(11) DEFAULT NULL COMMENT '发送者用户ID',
  `send_user_name` varchar(255) DEFAULT NULL COMMENT '发送者用户名',
  `send_real_name` varchar(255) DEFAULT NULL COMMENT '发送者真实姓名',
  `receive_user_count` int(11) DEFAULT NULL COMMENT '接收人数',
  `read_count` int(11) DEFAULT NULL COMMENT '已读人数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `t_message` */

insert  into `t_message`(`id`,`title`,`content`,`create_time`,`send_user_id`,`send_user_name`,`send_real_name`,`receive_user_count`,`read_count`) values 
(1,'分为非','分为分为','2019-09-07 06:59:59',2,'admin','管理员',1,1);

/*Table structure for table `t_message_user` */

DROP TABLE IF EXISTS `t_message_user`;

CREATE TABLE `t_message_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` int(11) DEFAULT NULL COMMENT '消息内容ID',
  `receive_user_id` int(11) DEFAULT NULL COMMENT '接收人ID',
  `receive_user_name` varchar(255) DEFAULT NULL COMMENT '接收人用户名',
  `receive_real_name` varchar(255) DEFAULT NULL COMMENT '接收人真实姓名',
  `readed` bit(1) DEFAULT NULL COMMENT '是否已读',
  `create_time` datetime DEFAULT NULL,
  `read_time` datetime DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `t_message_user` */

insert  into `t_message_user`(`id`,`message_id`,`receive_user_id`,`receive_user_name`,`receive_real_name`,`readed`,`create_time`,`read_time`) values 
(1,1,1,'student','学生','','2019-09-07 06:59:59','2019-09-07 07:06:50');

/*Table structure for table `t_question` */

DROP TABLE IF EXISTS `t_question`;

CREATE TABLE `t_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_type` int(11) DEFAULT NULL COMMENT '1.单选题  2.多选题  3.判断题 4.填空题 5.简答题',
  `subject_id` int(11) DEFAULT NULL COMMENT '学科',
  `score` int(11) DEFAULT NULL COMMENT '题目总分(千分制)',
  `grade_level` int(11) DEFAULT NULL COMMENT '级别',
  `difficult` int(11) DEFAULT NULL COMMENT '题目难度',
  `correct` varchar(255) DEFAULT NULL COMMENT '正确答案',
  `info_text_content_id` int(11) DEFAULT NULL COMMENT '题目  填空、 题干、解析、答案等信息',
  `create_user` int(11) DEFAULT NULL COMMENT '创建人',
  `status` int(11) DEFAULT NULL COMMENT '1.正常',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `deleted` bit(1) DEFAULT NULL,
  `knowledge_point` varchar(255) DEFAULT NULL COMMENT '知识点',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `t_question` */

insert  into `t_question`(`id`,`question_type`,`subject_id`,`score`,`grade_level`,`difficult`,`correct`,`info_text_content_id`,`create_user`,`status`,`create_time`,`deleted`,`knowledge_point`) values 
(1,1,1,30,1,4,'B',1,2,1,'2019-09-07 06:58:04','\0',NULL),
(2,4,1,40,1,4,'gregr&nbsp;',2,2,1,'2019-09-07 06:58:44','\0',NULL),
(3,1,1,50,1,3,'C',6,2,1,'2019-10-28 10:19:59','\0',NULL),
(4,1,1,50,1,3,'C',7,2,1,'2019-10-28 10:23:16','\0',NULL),
(5,1,1,50,1,3,'A',8,2,1,'2019-10-28 13:13:55','\0',NULL),
(6,1,1,50,1,3,'A',9,2,1,'2019-10-28 13:51:54','\0',NULL),
(7,1,1,50,1,3,'C',10,2,1,'2019-10-28 14:00:05','\0',NULL),
(8,1,1,50,1,3,'A',11,2,1,'2019-10-28 14:08:29','\0',NULL),
(9,1,1,50,1,3,'C',12,2,1,'2019-10-28 14:12:21','\0',NULL),
(10,1,1,50,1,3,'B',13,2,1,'2019-10-28 14:14:08','\0',NULL),
(11,1,1,50,1,3,'B',14,2,1,'2019-10-28 14:15:38','\0',NULL),
(12,1,1,50,1,3,'D',15,2,1,'2019-10-28 14:17:37','\0',NULL),
(13,1,1,50,1,3,'A',16,2,1,'2019-10-28 14:22:12','\0',NULL),
(14,1,1,50,1,3,'A',17,2,1,'2019-10-28 14:23:28','\0',NULL),
(15,1,1,50,1,3,'D',18,2,1,'2019-10-28 14:25:58','\0',NULL),
(16,2,1,50,1,3,'A',19,2,1,'2019-10-28 15:03:55','\0',NULL),
(17,2,1,50,1,3,'A',20,2,1,'2019-10-28 15:10:40','\0',NULL),
(18,2,1,50,1,3,'B',21,2,1,'2019-10-28 15:11:12','\0',NULL),
(19,2,1,50,1,3,'B',22,2,1,'2019-10-28 15:12:33','\0',NULL),
(20,2,1,50,1,3,'A',23,2,1,'2019-10-28 15:13:03','\0',NULL),
(21,2,1,50,1,3,'B',24,2,1,'2019-10-28 15:13:34','\0',NULL),
(22,2,1,50,1,3,'A',25,2,1,'2019-10-28 15:13:58','\0',NULL),
(23,2,1,50,1,3,'A',26,2,1,'2019-10-28 15:17:11','\0',NULL),
(24,2,1,50,1,3,'A',27,2,1,'2019-10-28 15:17:51','\0',NULL),
(25,2,1,50,1,3,'A',28,2,1,'2019-10-28 15:18:23','\0',NULL),
(26,2,1,50,1,3,'B',29,2,1,'2019-10-28 15:18:58','\0',NULL),
(27,2,1,50,1,3,'B',30,2,1,'2019-10-28 15:19:28','\0',NULL),
(28,2,1,50,1,3,'B',31,2,1,'2019-10-28 15:19:53','\0',NULL),
(29,2,1,50,1,3,'A',32,2,1,'2019-10-28 15:20:19','\0',NULL),
(30,1,1,50,1,3,'A',33,2,1,'2019-10-28 15:32:41','\0',NULL),
(31,1,1,50,1,3,'B',34,2,1,'2019-10-28 15:44:05','\0',NULL),
(32,1,1,50,1,3,'B',35,2,1,'2019-10-28 15:45:00','\0',NULL),
(33,8,1,50,1,3,'A,C,D',36,2,1,'2019-10-28 15:46:08','\0',NULL),
(34,1,1,50,1,3,'B',37,2,1,'2019-10-28 15:47:03','\0',NULL),
(35,1,1,50,1,3,'D',38,2,1,'2019-10-28 15:48:02','\0',NULL),
(36,1,1,50,1,3,'A',39,2,1,'2019-10-28 15:49:18','\0',NULL),
(37,8,1,50,1,3,'A,B,D',40,2,1,'2019-10-28 15:50:16','\0',NULL),
(38,1,1,50,1,3,'C',41,2,1,'2019-10-28 15:55:24','\0',NULL),
(39,1,1,50,1,3,'B',42,2,1,'2019-10-28 15:56:34','\0',NULL),
(40,1,1,50,1,3,'C',43,2,1,'2019-10-28 15:57:32','\0',NULL),
(41,8,1,50,1,3,'A,B,D',44,2,1,'2019-10-28 15:58:34','\0',NULL),
(42,2,1,50,1,3,'A',45,2,1,'2019-10-28 16:00:43','\0',NULL),
(43,2,1,50,1,3,'B',46,2,1,'2019-10-28 16:01:10','\0',NULL),
(44,2,1,50,1,3,'A',47,2,1,'2019-10-28 16:02:39','\0',NULL),
(45,2,1,50,1,3,'A',48,2,1,'2019-10-28 16:03:03','\0',NULL),
(46,2,1,50,1,3,'B',49,2,1,'2019-10-28 16:03:32','\0',NULL),
(47,2,1,50,1,3,'B',50,2,1,'2019-10-28 16:04:06','\0',NULL),
(48,2,1,50,1,3,'A',51,2,1,'2019-10-28 16:38:53','\0',NULL),
(49,2,1,50,1,3,'A',52,2,1,'2019-10-28 16:39:25','\0',NULL),
(50,2,1,50,1,4,'A',53,2,1,'2019-10-28 16:39:49','\0',NULL),
(51,2,1,50,1,3,'A',54,2,1,'2019-10-28 16:40:16','\0',NULL),
(52,2,1,50,1,3,'A',55,2,1,'2019-10-28 16:40:37','\0',NULL),
(53,2,1,50,1,3,'B',56,2,1,'2019-10-28 16:41:05','\0',NULL),
(54,1,1,50,1,3,'C',57,2,1,'2019-10-28 16:46:40','\0',NULL),
(55,1,1,50,1,3,'C',58,2,1,'2019-10-28 16:47:48','\0',NULL),
(56,1,1,50,1,3,'A',59,2,1,'2019-10-28 16:49:34','\0',NULL),
(57,1,1,50,1,3,'C',60,2,1,'2019-10-28 16:51:44','\0',NULL),
(58,1,1,50,1,3,'D',61,2,1,'2019-10-28 16:52:48','\0',NULL),
(59,1,1,50,1,3,'A',62,2,1,'2019-10-28 16:54:18','\0',NULL),
(60,1,1,50,1,3,'B',63,2,1,'2019-10-28 16:55:08','\0',NULL),
(61,1,1,50,1,3,'C',64,2,1,'2019-10-28 16:56:39','\0',NULL),
(62,1,1,50,1,3,'B',65,2,1,'2019-10-28 16:57:33','\0',NULL),
(63,1,1,50,1,3,'C',66,2,1,'2019-10-28 16:58:24','\0',NULL),
(64,8,1,50,1,3,'A,B',67,2,1,'2019-10-28 16:59:34','\0',NULL),
(65,1,1,50,1,3,'C',68,2,1,'2019-10-28 17:10:17','\0',NULL),
(66,1,1,50,1,3,'A',69,2,1,'2019-10-28 17:12:37','\0',NULL),
(67,1,1,50,1,3,'D',70,2,1,'2019-10-28 17:17:09','\0','大大大'),
(68,8,1,50,1,3,'A,C,D',71,2,1,'2019-10-28 17:29:27','\0',NULL),
(69,8,1,50,1,3,'A,B',72,2,1,'2019-10-28 17:30:28','\0',NULL),
(70,1,1,50,1,3,'A',73,2,1,'2019-10-28 17:32:58','\0',NULL),
(71,1,1,50,1,3,'B',74,2,1,'2019-10-28 17:34:17','\0','帆帆帆帆'),
(72,1,1,20,1,3,'A',75,2,1,'2019-10-29 13:14:12','','啊啊啊啊'),
(74,6,1,50,1,3,'aa',79,2,1,'2019-10-29 16:58:23','','ddd'),
(75,6,1,40,1,4,'aaaa',81,2,1,'2019-11-04 15:05:09','','测试'),
(76,6,1,50,1,3,'啊啊啊',83,2,1,'2019-11-08 08:27:24','','测试'),
(77,1,1,40,1,3,'B',84,2,1,'2019-11-08 09:07:23','','测试'),
(78,8,1,40,1,3,'A,B',85,2,1,'2019-11-08 12:19:12','','测试'),
(79,1,1,40,1,3,'B',87,2,1,'2019-11-09 14:18:56','','测试');

/*Table structure for table `t_subject` */

DROP TABLE IF EXISTS `t_subject`;

CREATE TABLE `t_subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '语文 数学 英语 等',
  `level` int(11) DEFAULT NULL COMMENT '年级 (1-12) 小学 初中 高中  大学',
  `level_name` varchar(255) DEFAULT NULL COMMENT '一年级、二年级等',
  `item_order` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `t_subject` */

insert  into `t_subject`(`id`,`name`,`level`,`level_name`,`item_order`) values 
(1,'数字电路',1,'大一',NULL);

/*Table structure for table `t_task_exam` */

DROP TABLE IF EXISTS `t_task_exam`;

CREATE TABLE `t_task_exam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `grade_level` int(11) DEFAULT NULL COMMENT '级别',
  `frame_text_content_id` int(11) DEFAULT NULL COMMENT '任务框架 内容为JSON',
  `create_user` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `create_user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `t_task_exam` */

/*Table structure for table `t_task_exam_customer_answer` */

DROP TABLE IF EXISTS `t_task_exam_customer_answer`;

CREATE TABLE `t_task_exam_customer_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_exam_id` int(11) DEFAULT NULL,
  `create_user` int(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `text_content_id` int(11) DEFAULT NULL COMMENT '任务完成情况(Json)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `t_task_exam_customer_answer` */

/*Table structure for table `t_text_content` */

DROP TABLE IF EXISTS `t_text_content`;

CREATE TABLE `t_text_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `t_text_content` */

insert  into `t_text_content`(`id`,`content`,`create_time`) values 
(1,'{\"titleContent\":\"<p class=\\\"ueditor-p\\\">单选题单选题单选题单选题</p>\",\"analyze\":\"单选题\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"单选题\",\"score\":null},{\"prefix\":\"B\",\"content\":\"单选题\",\"score\":null},{\"prefix\":\"C\",\"content\":\"单选题\",\"score\":null}],\"correct\":\"B\"}','2019-09-07 06:58:04'),
(2,'{\"titleContent\":\"填空题<span class=\\\"gapfilling-span 60e3a2c5-7d2e-4651-82f5-1a33818d3dba\\\">1</span>分为非<span class=\\\"gapfilling-span 5242aa1d-87b3-42be-b827-b3e5c38e6e31\\\">2</span>分为非\",\"analyze\":\"gregr&nbsp;\",\"questionItemObjects\":[{\"prefix\":\"1\",\"content\":\"fdsf\",\"score\":20},{\"prefix\":\"2\",\"content\":\"gfd\",\"score\":20}],\"correct\":\"gregr&nbsp;\"}','2019-09-07 06:58:44'),
(3,'[{\"name\":\"一、题目测试\",\"questionItems\":[{\"id\":1,\"itemOrder\":1},{\"id\":2,\"itemOrder\":2}]}]','2019-09-07 06:59:14'),
(4,'[\"few\",\"greg\"]','2019-09-07 07:07:09'),
(5,'[{\"name\":\"单选题\",\"questionItems\":[{\"id\":1,\"itemOrder\":1}]},{\"name\":\"化简计算题\",\"questionItems\":[{\"id\":2,\"itemOrder\":2}]}]','2019-10-09 16:23:08'),
(6,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">相同为0，不同为1，它的逻辑关系是</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">或逻辑</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">异逻辑</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">异或逻辑</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<p class=\\\"MsoListParagraph\\\" style=\\\"margin-left: 28px; text-indent: 0px; line-height: 150%;\\\"><span style=\\\"font-size:16px;line-height:150%;font-family: 宋体\\\">同或逻辑</span></p>\",\"score\":null}],\"correct\":\"C\"}','2019-10-28 10:19:59'),
(7,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">若输入变量A和B全为1时，输出为1，则其输入、输出关系为</span>\",\"analyze\":\"<p>无</p>\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">同或</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">异或</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">与</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">或非</span>\",\"score\":null}],\"correct\":\"C\"}','2019-10-28 10:23:16'),
(8,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">在<span style=\\\"text-decoration:underline;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>情况下，函数</span><span style=\\\"font-size:14px;font-family:&#39;Calibri&#39;,sans-serif\\\"><span style=\\\"position:relative;top:3px\\\">F = AB + (\\\\overline A&nbsp; + C)(B + D\\\\overline E )</span></span><span style=\\\"font-size:14px;font-family:宋体\\\">的逻辑值为</span><span style=\\\"font-size:14px;font-family:&#39;Calibri&#39;,sans-serif\\\">1</span><span style=\\\"font-size: 14px; font-family: 宋体;\\\">。</span>\",\"analyze\":\"<p>无</p>\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">输入全为0</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">A</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">和B同时为1</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">C</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">和D同时为1</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">输入全为1</span>\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 13:13:55'),
(9,'{\"titleContent\":\"一个8位二进制数，能够表示的最大无符号整数是\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"255\",\"score\":null},{\"prefix\":\"B\",\"content\":\"216\",\"score\":null},{\"prefix\":\"C\",\"content\":\"16\",\"score\":null},{\"prefix\":\"D\",\"content\":\"64\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 13:51:54'),
(10,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">逻辑函数F（A,B,C）=$A\\\\overline B C + BC + A\\\\overline C $</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">的最小项表达式为</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<p class=\\\"ueditor-p\\\">F={{\\\\sum }_{m}}0267</p>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"F={{\\\\sum }_{m}}256\",\"score\":null},{\"prefix\":\"C\",\"content\":\"F={{\\\\sum }_{m}}234567\",\"score\":null},{\"prefix\":\"D\",\"content\":\"F={{\\\\sum }_{m}}2345\",\"score\":null}],\"correct\":\"C\"}','2019-10-28 14:00:05'),
(11,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">四变量函数F(A,B,C,D)的最小项m<sub>13</sub>为</span>\",\"analyze\":\"<p>无</p>\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">AB</span><span style=\\\"font-size:14px;font-family:&#39;Calibri&#39;,sans-serif\\\"><span style=\\\"position:relative;top:4px\\\">$C$</span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">D</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<p class=\\\"ueditor-p\\\"><span style=\\\"font-family: 宋体;\\\"><span style=\\\"font-family: 宋体;\\\">$\\\\overline{A}$</span>BC</span><span style=\\\"font-family: 宋体;\\\">$\\\\overline{D}$</span></p>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">ABC$\\\\overline{D}$</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-family: 宋体;\\\">AB$\\\\overline{C}$<span style=\\\"font-family: 宋体;\\\">$\\\\overline{D}$</span></span>\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 14:08:29'),
(12,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">已知</span><span style=\\\"font-size:14px;font-family:&#39;Calibri&#39;,sans-serif\\\"><span style=\\\"position:relative;top:3px\\\">$Y=A\\\\overline{B}+B+\\\\overline{A}B$</span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">下列结果中正确的是</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<p class=\\\"ueditor-p\\\"><span style=\\\"font-size:16px;font-family: 宋体\\\">Y</span><span style=\\\"font-size:16px;font-family:宋体\\\">＝A</span></p>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">Y</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">＝B</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">Y</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">＝A＋B</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">Y=$\\\\odot $</span>\",\"score\":null}],\"correct\":\"C\"}','2019-10-28 14:12:21'),
(13,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">逻辑函数的对偶函数为<span style=\\\"text-decoration:underline;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"$\\\\left( \\\\overline{A}+\\\\overline{B} \\\\right)\\\\left( \\\\overline{C}+D \\\\right)$\",\"score\":null},{\"prefix\":\"B\",\"content\":\"$\\\\left( A+B \\\\right)\\\\left( C+\\\\overline{D} \\\\right)$\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<p class=\\\"ueditor-p\\\">$\\\\overline{A}\\\\overline{B}+\\\\overline{C}D$</p>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"$AB+\\\\overline{C}D$\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 14:14:08'),
(14,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">格雷码的重要特点是，当计数增加时，有<span style=\\\"text-decoration:underline;\\\">&nbsp;&nbsp;&nbsp; </span>位数字状态发生变化。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"2\",\"score\":null},{\"prefix\":\"B\",\"content\":\"1\",\"score\":null},{\"prefix\":\"C\",\"content\":\"4\",\"score\":null},{\"prefix\":\"D\",\"content\":\"8\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 14:15:38'),
(15,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">以下表达式中符合逻辑运算规则的是<span style=\\\"text-decoration:underline;\\\">&nbsp;&nbsp;&nbsp; </span>。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"$C\\\\cdot C={{C}^{2}}$\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">1+1=10</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">0&lt;1</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">A+1=1</span>\",\"score\":null}],\"correct\":\"D\"}','2019-10-28 14:17:37'),
(16,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">对于三变量的逻辑函数，若约束条件是A</span><span style=\\\"font-size:14px;font-family:&#39;Calibri&#39;,sans-serif\\\"><span style=\\\"position:relative;top:3px\\\">$AB+C$</span></span><span style=\\\"font-size:16px;font-family: 宋体\\\">B=0</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">，则无关项为<span style=\\\"text-decoration:underline;\\\">&nbsp; </span>个</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"2\",\"score\":null},{\"prefix\":\"B\",\"content\":\"4\",\"score\":null},{\"prefix\":\"C\",\"content\":\"6\",\"score\":null},{\"prefix\":\"D\",\"content\":\"8\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 14:22:12'),
(17,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">逻辑函数的表示方法中具有唯一性的是<span style=\\\"text-decoration:underline;\\\">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 14px; font-family: 宋体;\\\">真值表</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">表达式</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">表达式</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">卡诺图</span>\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 14:23:28'),
(18,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">已知逻辑函数</span><span style=\\\"font-size:14px;font-family:&#39;Calibri&#39;,sans-serif\\\"><span style=\\\"position:relative;top:3px\\\">$Y=AB+\\\\overline{A}C+\\\\overline{B}C$</span></span><span style=\\\"font-size:14px;font-family:宋体\\\">，与其相等的函数是</span><span style=\\\"text-decoration:underline;\\\"><span style=\\\"font-size: 14px;font-family:&#39;Calibri&#39;,sans-serif\\\">&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-size: 14px; font-family: 宋体;\\\">。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"AB\",\"score\":null},{\"prefix\":\"B\",\"content\":\"$AB+\\\\overline{A}C$\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<p class=\\\"ueditor-p\\\">$AB+\\\\overline{B}C$</p>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"AB+C\",\"score\":null}],\"correct\":\"D\"}','2019-10-28 14:25:58'),
(19,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">逻辑变量的取值只有1和0，表示两种完全对立的逻辑状态。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 15:03:55'),
(20,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">“与非”逻辑运算结果为“</span><span style=\\\"font-size: 16px;font-family:&#39;Calibri&#39;,sans-serif\\\">0</span><span style=\\\"font-size:16px;font-family: 宋体\\\">”的条件是该与项的变量都输入“</span><span style=\\\"font-size:16px;font-family:&#39;Calibri&#39;,sans-serif\\\">1</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">”。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 15:10:40'),
(21,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">逻辑变量的取值，1比0大。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 15:11:12'),
(22,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">因为逻辑表达式A+B+AB=A+B成立，所以AB=0成立。</span>\",\"analyze\":\"无<br/><br/>\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 15:12:33'),
(23,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">在卡诺图化简中，对于无关项所对应的的逻辑函数值，既可看作1，也可看作0</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 15:13:03'),
(24,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family: &#39;Calibri&#39;,sans-serif\\\">n</span><span style=\\\"font-size:16px;font-family: 宋体\\\">变量的全部最小项之和为</span><span style=\\\"font-size: 16px;font-family:&#39;Calibri&#39;,sans-serif\\\">0</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 15:13:34'),
(25,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family: &#39;Calibri&#39;,sans-serif\\\">n</span><span style=\\\"font-size:16px;font-family: 宋体\\\">变量的全部最大项的积为</span><span style=\\\"font-size: 16px;font-family:&#39;Calibri&#39;,sans-serif\\\">0</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 15:13:58'),
(26,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family: &#39;Calibri&#39;,sans-serif\\\">8421</span><span style=\\\"font-size:16px;font-family: 宋体\\\">码和</span><span style=\\\"font-size:16px;font-family:&#39;Calibri&#39;,sans-serif\\\">2421</span><span style=\\\"font-size:16px;font-family: 宋体\\\">码是有权码，余</span><span style=\\\"font-size:16px;font-family:&#39;Calibri&#39;,sans-serif\\\">3</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">码和格雷码属于无权码。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 15:17:11'),
(27,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">十进制整数转换为非十进制时，采用“除基取余”的方法；十进制小数转换为非十进制数时，采用“乘基取整”的方法。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 15:17:51'),
(28,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">异或函数和同或函数在逻辑上互为反函数。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 15:18:23'),
(29,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">将</span><span style=\\\"font-size:16px;font-family:&#39;Calibri&#39;,sans-serif\\\">2018</span><span style=\\\"font-size:16px;font-family: 宋体\\\">个</span><span style=\\\"font-size:16px;font-family:&#39;Calibri&#39;,sans-serif\\\">“1”</span><span style=\\\"font-size:16px;font-family: 宋体\\\">异或起来的结果是</span><span style=\\\"font-size:16px;font-family:&#39;Calibri&#39;,sans-serif\\\">0</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 15:18:58'),
(30,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">逻辑函数的表示方法中具有唯一性的是逻辑图。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 15:19:28'),
(31,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family: &#39;Calibri&#39;,sans-serif\\\">8.8421</span><span style=\\\"font-size:16px;font-family: 宋体\\\">码、</span><span style=\\\"font-size:16px;font-family:&#39;Calibri&#39;,sans-serif\\\">2421</span><span style=\\\"font-size:16px;font-family: 宋体\\\">码和余</span><span style=\\\"font-size:16px;font-family:&#39;Calibri&#39;,sans-serif\\\">3</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">码都是有权码。</span>\",\"analyze\":\"无&nbsp;\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 15:19:53'),
(32,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">卡诺图中为</span><span style=\\\"font-size:16px;font-family:&#39;Calibri&#39;,sans-serif\\\">1</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">的方格均表示逻辑函数的的一个最小项。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 15:20:19'),
(33,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">当TTL门电路输入端对地接电阻R=10k 时，相当于此端</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">接逻辑“1”</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">接逻辑“0”</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">接0.4V电压</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">逻辑不定</span>\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 15:32:41'),
(34,'{\"titleContent\":\"<p class=\\\"ueditor-p\\\" style=\\\"text-align: justify;\\\"><span style=\\\"font-size: 16px; font-family: 宋体;\\\">二输入异或门的输出完成F=$A$,则多余输入端</span></p>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">全部接高电平</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">只需一个接高电平即可</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">全部接地电平</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">只需一个接地即可</span>\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 15:44:05'),
(35,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">能实现线与功能的逻辑器件是</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">TTL</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">与非门</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">集电极开路门</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">三态逻辑门</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">CMOS</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">逻辑门</span>\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 15:45:00'),
(36,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">CMOS</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">集成电路与TTL集成电路相比，突出的优点是</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">微功耗</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">高速度</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">高抗干扰能力</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">电源范围宽</span>\",\"score\":null}],\"correct\":\"\"}','2019-10-28 15:46:08'),
(37,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">多个<span style=\\\"text-decoration:underline;\\\"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;输出端可以直接连接在一起实现“线与”逻辑功能。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">基本 TTL 门电路</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">集电极开路门</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">基本 CMOS 门电路</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">JK </span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">触发器</span>\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 15:47:03'),
(38,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">TTL </span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">三态门有三种状态，分别是 0 态、1 态和<span style=\\\"text-decoration:underline;\\\">&nbsp;&nbsp;&nbsp; </span>&nbsp;。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">不定态</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">任意态</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">暂稳态</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">高阻态</span>\",\"score\":null}],\"correct\":\"D\"}','2019-10-28 15:48:02'),
(39,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">当</span><span style=\\\"font-size:16px;font-family:&#39;Calibri&#39;,sans-serif\\\">TTL</span><span style=\\\"font-size:16px;font-family: 宋体\\\">门电路输入端对地接电阻</span><span style=\\\"font-size: 16px;font-family:&#39;Calibri&#39;,sans-serif\\\">R=10kΩ</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">时，相当于此端</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">接逻辑</span><span style=\\\"font-size: 16px; font-family: Calibri, sans-serif;\\\">“1”</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">接逻辑</span><span style=\\\"font-size: 16px; font-family: Calibri, sans-serif;\\\">“0”</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">接</span><span style=\\\"font-size:16px;font-family:&#39;Calibri&#39;,sans-serif\\\">0.4V</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">电压</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">逻辑不定</span>\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 15:49:18'),
(40,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">三态门输出高阻状态时，<span style=\\\"text-decoration:underline;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>是正确的说法。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">用电压表测量指针</span><span style=\\\"font-size: 14px; font-family: 宋体;\\\">不动</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">相当于悬空</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">电压不高不低</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">测量电阻指针不动</span>\",\"score\":null}],\"correct\":\"\"}','2019-10-28 15:50:16'),
(41,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">对于TTL与非门闲置输入端的处理，不可以<span style=\\\"text-decoration:underline;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 。</span></span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">接电源</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">通过电阻接电源</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">接地</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">与有用输入端并联</span>\",\"score\":null}],\"correct\":\"C\"}','2019-10-28 15:55:24'),
(42,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">三极管作为开关时，工作区域是</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">饱和区、放大区</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<p class=\\\"MsoListParagraph\\\" style=\\\"margin-left: 28px; text-indent: 0px; line-height: 150%;\\\"><span style=\\\"font-size:16px;line-height:150%;font-family: 宋体\\\">放大区、击穿区</span></p>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">饱和区、截止区</span>\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 15:56:34'),
(43,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">某集成电路芯片，查手册知其最大输出低电平U<sub>OL(MAX)</sub>=0.5V，最大输入低电平U<sub>IL(MAX)</sub>=0.8V，最小输出高电平U<sub>OH(MIN)</sub>=2.7V，最小输入高电平U<sub>IL(MIN)</sub>=2.0V，则其低电平噪声容限=<span style=\\\"text-decoration:underline;\\\">&nbsp;&nbsp;&nbsp;&nbsp; </span>。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">0.4V</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">0.6V</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">0.3V</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">1.2V</span>\",\"score\":null}],\"correct\":\"C\"}','2019-10-28 15:57:32'),
(44,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">对于TTL与非门闲置输入端的处理，可以</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">接电源</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">通过电阻3kΩ接电源</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">接地</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">与有用输入端并联</span>\",\"score\":null}],\"correct\":\"\"}','2019-10-28 15:58:34'),
(45,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">普通的逻辑门电路的输出端不可以并联在一起，否则可能损坏器件。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 16:00:43'),
(46,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">将两个或两个以上的普通TTL</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">“与非”门的输出端直接相连，可以实现线与功能。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 16:01:10'),
(47,'{\"titleContent\":\"<span style=\\\"font-family: 宋体, SimSun;\\\"><span style=\\\"font-size:16px;font-family: 宋体\\\">TTL</span><span style=\\\"font-size:16px;font-family:宋体\\\">集电极开路门的输出端可以相连并实现线与功能。</span></span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 16:02:39'),
(48,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">集成与非门的扇出系数反映了该与非门带同类负载的能力。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 16:03:03'),
(49,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">将二个或二个以上的普通 TTL 与非门的输出端直接相连，可实现线与。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 16:03:32'),
(50,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">三态门的三种状态分别为：高电平、低电平、不高不低的电压。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 16:04:06'),
(51,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">TTL OC</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">门（集电极开路门）的输出端可以直接相连，实现线与。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 16:38:53'),
(52,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">当TTL与非门的输入端悬空时相当于输入为逻辑1。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 16:39:25'),
(53,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">TTL</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">集电极开路门输出为１时由外接电源和电阻提供输出电流。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 16:39:49'),
(54,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">CMOS OD</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">门（漏极开路门）的输出端可以直接相连，实现线与。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 16:40:16'),
(55,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">CMOS</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">或非门与TTL或非门的逻辑功能完全相同。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 16:40:37'),
(56,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">二极管和三极管在数字电路中可工作在放大区、饱和区和截止区。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"是\",\"score\":null},{\"prefix\":\"B\",\"content\":\"否\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 16:41:05'),
(57,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family: 宋体\\\">8</span><span style=\\\"font-size:16px;font-family:宋体\\\">线—3线优先编码器的输入为I<sub>0</sub></span><span style=\\\"font-size:16px;font-family:宋体\\\">～</span><span style=\\\"font-size:16px;font-family:宋体\\\">I<sub>7</sub> </span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">，当优先级别最高的I<sub>7</sub>有效时，其输出$\\\\overline {{Y_2}}&nbsp; \\\\bullet \\\\overline {{Y_1}}&nbsp; \\\\bullet \\\\overline {{Y_0}} $的值是</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">111</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">010</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体; color: blue;\\\">000</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">101</span>\",\"score\":null}],\"correct\":\"C\"}','2019-10-28 16:46:40'),
(58,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">十六路数据选择器的地址输入（选择控制）端有几个。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"16\",\"score\":null},{\"prefix\":\"B\",\"content\":\"8\",\"score\":null},{\"prefix\":\"C\",\"content\":\"4\",\"score\":null},{\"prefix\":\"D\",\"content\":\"2\",\"score\":null}],\"correct\":\"C\"}','2019-10-28 16:47:48'),
(59,'{\"titleContent\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">已知74LS138译码器的输入三个使能端（ST<sub>A</sub>=1，<span style=\\\"position:relative;top:3px\\\">$\\\\overline {S{T_A}}&nbsp; = \\\\overline {S{T_B}}&nbsp; = 0$</span>）时，地址码A<sub>2</sub>A<sub>1</sub>A<sub>0</sub>=011，则输出 Y<sub>7</sub> ～Y<sub>0</sub>是</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体; color: blue;\\\">11110111</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">10111111</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">11111101</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">11111111</span>\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 16:49:34'),
(60,'{\"titleContent\":\"<span style=\\\"font-size:16px;font-family:宋体\\\">实现表达式</span><span style=\\\"font-size:16px;font-family:&#39;Times New Roman&#39;,serif\\\"><span style=\\\"position:relative;top:4px\\\">$\\\\bar ABCD + A\\\\bar BCD + AB\\\\bar C\\\\bar D$</span>,</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">需要一个或门和</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">一个与门</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">三个与门</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"color: #000000;\\\"><span style=\\\"font-size: 16px; font-family: 宋体;\\\"></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">三个与门和四个反相器</span></span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体;\\\">三个与门和三个反相器</span>\",\"score\":null}],\"correct\":\"C\"}','2019-10-28 16:51:44'),
(61,'{\"titleContent\":\"<span style=\\\"font-size: 16px;font-family: 宋体\\\">在下列逻辑电路中，不是组合逻辑电路的有</span><span style=\\\"text-decoration:underline;\\\"><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 12pt; font-family: 宋体;\\\">译码器</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 12pt; font-family: 宋体;\\\">编码器</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 12pt; font-family: 宋体;\\\">全加器</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"寄存器\",\"score\":null}],\"correct\":\"D\"}','2019-10-28 16:52:48'),
(62,'{\"titleContent\":\"<span style=\\\"font-size: 16px;font-family: 宋体\\\">四选一数据选择器的数据输出</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">Y</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">与数据输入</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">X<sub>i</sub></span><span style=\\\"font-size: 16px;font-family: 宋体\\\">和地址码</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">A<sub>i</sub></span><span style=\\\"font-size: 16px;font-family: 宋体\\\">之间的逻辑表达式为</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">Y=<span style=\\\"text-decoration:underline;\\\">&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">。</span>\",\"analyze\":\"<p>无<br/></p>\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"${\\\\overline A _1}{\\\\overline A _0}{X_0} + {\\\\overline A _1}{A_0}{X_1} + {A_1}{\\\\overline A _0}{X_2} + {A_1}{A_0}{X_3}$\",\"score\":null},{\"prefix\":\"B\",\"content\":\"${\\\\overline A _1}{\\\\overline A _0}{X_0}$\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<p class=\\\"ueditor-p\\\">${\\\\overline A _1}{A_0}{X_1}$</p>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"${A_1}{A_0}{X_3}$\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 16:54:18'),
(63,'{\"titleContent\":\"<span style=\\\"font-size: 16px;font-family: 宋体\\\">若在编码器中有</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">50</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">个编码对象，则要求输出二进制代码位数为</span><span style=\\\"text-decoration:underline;\\\"><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">&nbsp;&nbsp; </span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">位。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"5\",\"score\":null},{\"prefix\":\"B\",\"content\":\"6\",\"score\":null},{\"prefix\":\"C\",\"content\":\"10\",\"score\":null},{\"prefix\":\"D\",\"content\":\"50\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 16:55:08'),
(64,'{\"titleContent\":\"<span style=\\\"font-size: 16px;font-family: 宋体\\\">一个</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">8</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">选一数据选择器的数据输入端有</span><span style=\\\"text-decoration:underline;\\\"><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">个。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"1\",\"score\":null},{\"prefix\":\"B\",\"content\":\"2\",\"score\":null},{\"prefix\":\"C\",\"content\":\"3\",\"score\":null},{\"prefix\":\"D\",\"content\":\"4\",\"score\":null},{\"prefix\":\"E\",\"content\":\"8\",\"score\":null}],\"correct\":\"C\"}','2019-10-28 16:56:39'),
(65,'{\"titleContent\":\"<span style=\\\"font-size: 16px;font-family: 宋体\\\">八路数据分配器，其地址输入端有</span><span style=\\\"text-decoration:underline;\\\"><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">个。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"1\",\"score\":null},{\"prefix\":\"B\",\"content\":\"2\",\"score\":null},{\"prefix\":\"C\",\"content\":\"3\",\"score\":null},{\"prefix\":\"D\",\"content\":\"4\",\"score\":null},{\"prefix\":\"E\",\"content\":\"8\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 16:57:33'),
(66,'{\"titleContent\":\"<span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">101</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">键盘的编码器输出</span><span style=\\\"text-decoration:underline;\\\"><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">位二进制代码。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"2\",\"score\":null},{\"prefix\":\"B\",\"content\":\"6\",\"score\":null},{\"prefix\":\"C\",\"content\":\"7\",\"score\":null},{\"prefix\":\"D\",\"content\":\"8\",\"score\":null}],\"correct\":\"C\"}','2019-10-28 16:58:24'),
(67,'{\"titleContent\":\"<span style=\\\"font-size: 16px;font-family: 宋体\\\">以下电路中，加以适当辅助门电路，</span><span style=\\\"text-decoration:underline;\\\"><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">适于实现单输出组合逻辑电路。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体; color: #000000;\\\"><span style=\\\"font-size: 16px; font-family: 宋体; color: #000000;\\\"></span>二进制译码器</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体; color: #000000;\\\">数据选择器</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 12pt; font-family: 宋体;\\\">数值比较器</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 12pt; font-family: 宋体;\\\">七段显示译码器</span>\",\"score\":null}],\"correct\":\"\"}','2019-10-28 16:59:34'),
(68,'{\"titleContent\":\"<span style=\\\"font-size: 16px;font-family: 宋体\\\">用三线</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">-</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">八线译码器</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">74LS138</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">实现原码输出的</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">8</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">路数据分配器，应</span><span style=\\\"text-decoration:underline;\\\"><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">。</span>\",\"analyze\":\"<p>无</p>\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size:16px;font-family: &#39;Times New Roman&#39;,serif;color:blue\\\">$S{T_A}$=1</span><span style=\\\"font-size:16px;font-family:宋体;color:blue\\\">，$\\\\overline {S{T_B}} $</span><span style=\\\"font-size:16px;font-family:&#39;Times New Roman&#39;,serif;color:blue\\\">=D</span><span style=\\\"font-size:16px;font-family:宋体;color:blue\\\">，$\\\\overline {S{T_C}} $</span><span style=\\\"font-size:16px;font-family:&#39;Times New Roman&#39;,serif;color:blue\\\">=0</span><span style=\\\"font-size: 16px; font-family: &quot;Times New Roman&quot;, serif;\\\">&nbsp;</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<p class=\\\"ueditor-p\\\"><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">$S{T_A}$=1</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">，</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">$\\\\overline {S{T_B}} $=D</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">，</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">$\\\\overline {S{T_C}} $=D</span></p>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-family: &quot;Times New Roman&quot;, serif;\\\">$S{T_A}$=1</span><span style=\\\"font-family: 宋体;\\\">，</span><span style=\\\"font-family: &quot;Times New Roman&quot;, serif;\\\">$\\\\overline {S{T_B}} $=0</span><span style=\\\"font-family: 宋体;\\\">，</span><span style=\\\"font-family: &quot;Times New Roman&quot;, serif;\\\">$\\\\overline {S{T_C}} $=D</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-family: &quot;Times New Roman&quot;, serif;\\\">$S{T_A}$=D</span><span style=\\\"font-family: 宋体;\\\">，</span><span style=\\\"font-family: &quot;Times New Roman&quot;, serif;\\\">$\\\\overline {S{T_B}} $=0</span><span style=\\\"font-family: 宋体;\\\">，</span><span style=\\\"font-family: &quot;Times New Roman&quot;, serif;\\\">$\\\\overline {S{T_C}} $=0</span>\",\"score\":null}],\"correct\":\"C\"}','2019-10-28 17:10:17'),
(69,'{\"titleContent\":\"<span style=\\\"font-size: 16px;font-family: 宋体\\\">用四选一数据选择器实现函数</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\"><span style=\\\"position:relative;top:8px\\\">${\\\\rm{Y = }}{A_1}{A_0} + \\\\overline {{A_1}} {A_0}$</span></span><span style=\\\"font-size: 16px;font-family: 宋体\\\">，应使</span><span style=\\\"text-decoration:underline;\\\"><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"color: #000000;\\\"><span style=\\\"font-size: 16px; font-family: &quot;Times New Roman&quot;, serif;\\\">&nbsp;D<sub>0</sub>=D<sub>2</sub>=0</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">，</span><span style=\\\"font-size: 16px; font-family: &quot;Times New Roman&quot;, serif;\\\">D<sub>1</sub>=D<sub>3</sub>=1</span></span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">D<sub>0</sub>=D<sub>2</sub>=1</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">，</span><span style=\\\"font-size: 16px; font-family: &quot;Times New Roman&quot;, serif;\\\">D<sub>1</sub>=D<sub>3</sub>=0</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">D<sub>0</sub>=D<sub>1</sub>=0</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">，</span><span style=\\\"font-size: 16px; font-family: &quot;Times New Roman&quot;, serif;\\\">D<sub>2</sub>=D<sub>3</sub>=1</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">D<sub>0</sub>=D<sub>1</sub>=1</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">，</span><span style=\\\"font-size: 16px; font-family: &quot;Times New Roman&quot;, serif;\\\">D<sub>2</sub>=D<sub>3</sub>=0</span>\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 17:12:37'),
(70,'{\"titleContent\":\"<span style=\\\"font-size: 16px;font-family: 宋体\\\">下列各函数等式中无冒险现象的函数式有</span><span style=\\\"text-decoration:underline;\\\"><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"$F = \\\\overline B \\\\overline C&nbsp; + AC + \\\\overline A B$\",\"score\":null},{\"prefix\":\"B\",\"content\":\"$F = \\\\overline A \\\\overline C&nbsp; + BC + A\\\\overline B $\",\"score\":null},{\"prefix\":\"C\",\"content\":\"$F = \\\\overline A \\\\overline C&nbsp; + BC + A\\\\overline B&nbsp; + \\\\overline A B$\",\"score\":null},{\"prefix\":\"D\",\"content\":\"$F = \\\\overline B \\\\overline C&nbsp; + AC + \\\\overline A B + BC + A\\\\overline B&nbsp; + \\\\overline A \\\\overline C $\",\"score\":null},{\"prefix\":\"E\",\"content\":\"$F = \\\\overline B \\\\overline C&nbsp; + AC + \\\\overline A B + A\\\\overline B $\",\"score\":null}],\"correct\":\"D\"}','2019-10-28 17:17:09'),
(71,'{\"titleContent\":\"<span style=\\\"font-family: 宋体;\\\">函数</span><span style=\\\"font-family: &quot;Times New Roman&quot;, serif;\\\">$F = \\\\overline A C + AB + \\\\overline B \\\\overline C $</span><span style=\\\"font-family: 宋体;\\\">，当变量的取值为</span><span style=\\\"text-decoration-line: underline;\\\"><span style=\\\"font-family: &quot;Times New Roman&quot;, serif;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span style=\\\"font-family: 宋体;\\\">时，将出现冒险现象。</span>\",\"analyze\":\"无<br/>\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: &quot;Times New Roman&quot;, serif; color: #000000;\\\">B=C=1</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: &quot;Times New Roman&quot;, serif;\\\">B=C=0</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"color: #000000;\\\"><span style=\\\"font-size: 16px; font-family: &quot;Times New Roman&quot;, serif;\\\">A=1</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">，</span><span style=\\\"font-size: 16px; font-family: &quot;Times New Roman&quot;, serif;\\\">C=0</span></span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"color: #000000;\\\"><span style=\\\"font-size: 16px; font-family: &quot;Times New Roman&quot;, serif;\\\">A=0</span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">，</span><span style=\\\"font-size: 16px; font-family: &quot;Times New Roman&quot;, serif;\\\">B=0</span></span>\",\"score\":null}],\"correct\":\"\"}','2019-10-28 17:29:27'),
(72,'{\"titleContent\":\"<span style=\\\"font-size: 16px;font-family: 宋体\\\">组合逻辑电路消除竞争冒险的方法有</span><span style=\\\"text-decoration:underline;\\\"><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体; color: #000000;\\\">修改逻辑设计</span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"font-size: 16px; font-family: 宋体; color: #000000;\\\">在输出端接入滤波电容</span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 12pt; font-family: 宋体;\\\">后级加缓冲电路</span>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 12pt; font-family: 宋体;\\\">屏蔽输入信号的尖峰干扰</span>\",\"score\":null}],\"correct\":\"\"}','2019-10-28 17:30:28'),
(73,'{\"titleContent\":\"<span style=\\\"font-size: 16px;font-family: 宋体\\\">用三线</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">-</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">八线译码器</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">74LS138</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">和辅助门电路实现逻辑函数</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">Y=${A_2} + \\\\overline {{A_2}} \\\\overline {{A_1}} $</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">，应</span><span style=\\\"text-decoration:underline;\\\"><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">&nbsp;&nbsp; </span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">。</span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<span style=\\\"color: #000000;\\\"><span style=\\\"font-size: 16px; font-family: 宋体;\\\">用与非门，$Y{\\\\rm{ = }}\\\\overline {\\\\overline {{Y_0}} \\\\overline {{Y_1}} \\\\overline {{Y_4}} \\\\overline {{Y_5}} \\\\overline {{Y_6}} \\\\overline {{Y_7}} } $</span></span>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<span style=\\\"color: #000000;\\\"><span style=\\\"font-size: 16px; font-family: 宋体;\\\">用与门，$Y{\\\\rm{ = }}\\\\overline {{Y_2}} \\\\overline {{Y_3}} $</span></span>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<span style=\\\"font-size: 12pt; font-family: 宋体;\\\">用或门，</span>$Y{\\\\rm{ = }}\\\\overline {{Y_2}}&nbsp; + \\\\overline {{Y_3}} $\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<span style=\\\"font-size: 12pt; font-family: 宋体;\\\">用或门，</span>$Y{\\\\rm{ = }}\\\\overline {{Y_0}}&nbsp; + \\\\overline {{Y_1}}&nbsp; + \\\\overline {{Y_4}}&nbsp; + \\\\overline {{Y_5}}&nbsp; + \\\\overline {{Y_6}}&nbsp; + \\\\overline {{Y_7}} $\",\"score\":null}],\"correct\":\"A\"}','2019-10-28 17:32:58'),
(74,'{\"titleContent\":\"<span style=\\\"font-size: 16px;font-family: 宋体\\\">3线—</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">8</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">线译码器</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\">74HC138</span><span style=\\\"font-size: 16px;font-family: 宋体\\\">，当片选信号</span><span style=\\\"font-size: 16px;font-family: &#39;Times New Roman&#39;, serif\\\"><span style=\\\"position:relative;top:8px\\\">$S{T_A}\\\\overline {S{T_B}} \\\\overline {ST_C^{}} $</span></span><span style=\\\"font-size: 16px; font-family: 宋体;\\\">为（）时，芯片被选通<img src=\\\"http://image.alvisu.com/FsDsaB4f32UsRsCQ8XnZgiSDUsuz\\\" title=\\\"\\\" alt=\\\"image.png\\\"/></span>\",\"analyze\":\"无\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"010\",\"score\":null},{\"prefix\":\"B\",\"content\":\"100\",\"score\":null},{\"prefix\":\"C\",\"content\":\"001\",\"score\":null},{\"prefix\":\"D\",\"content\":\"101\",\"score\":null}],\"correct\":\"B\"}','2019-10-28 17:34:17'),
(75,'{\"titleContent\":\"踩踩踩踩踩\",\"analyze\":\"从\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"1\",\"score\":null},{\"prefix\":\"B\",\"content\":\"2\",\"score\":null}],\"correct\":\"A\"}','2019-10-29 13:14:12'),
(79,'{\"titleContent\":\"av\",\"analyze\":\"cac\",\"questionItemObjects\":[],\"correct\":\"aa\"}','2019-10-29 16:58:23'),
(80,'[{\"name\":\"填空题\",\"questionItems\":[{\"id\":71,\"itemOrder\":1},{\"id\":67,\"itemOrder\":2},{\"id\":70,\"itemOrder\":3},{\"id\":66,\"itemOrder\":4},{\"id\":65,\"itemOrder\":5}]},{\"name\":\"判断题\",\"questionItems\":[{\"id\":49,\"itemOrder\":6},{\"id\":50,\"itemOrder\":7},{\"id\":51,\"itemOrder\":8},{\"id\":52,\"itemOrder\":9},{\"id\":53,\"itemOrder\":10}]}]','2019-10-31 15:34:48'),
(81,'{\"titleContent\":\"dwaiiwcacjwaacw\",\"analyze\":\"aa\",\"questionItemObjects\":[],\"correct\":\"aaaa\"}','2019-11-04 15:05:09'),
(82,'[{\"name\":\"大大大大大大\",\"questionItems\":[{\"id\":75,\"itemOrder\":1}]}]','2019-11-04 15:09:50'),
(83,'{\"titleContent\":\"<img src=\\\"http://image.alvisu.com/Fnlkw8bPzp-LCNBAnRBaTxgHbThz\\\" alt=\\\"96a2e4368f859ea8dff617e397da170f.jpg\\\"/>\",\"analyze\":\"啊啊\",\"questionItemObjects\":[],\"correct\":\"啊啊啊\"}','2019-11-08 08:27:24'),
(84,'{\"titleContent\":\"&nbsp;踩踩踩\",\"analyze\":\"测试\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"<p>测试</p>\",\"score\":null},{\"prefix\":\"B\",\"content\":\"<p>踩踩踩</p>\",\"score\":null},{\"prefix\":\"C\",\"content\":\"<p>踩踩踩</p>\",\"score\":null},{\"prefix\":\"D\",\"content\":\"<p>草草草草</p>\",\"score\":null}],\"correct\":\"B\"}','2019-11-08 09:07:23'),
(85,'{\"titleContent\":\"<span style=\\\"color: #000000;\\\"><strong>的参数的长度</strong></span>\",\"analyze\":\"超出\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"啊啊啊啊\",\"score\":null},{\"prefix\":\"B\",\"content\":\"啊啊啊&nbsp;\",\"score\":null},{\"prefix\":\"C\",\"content\":\"啊&nbsp; &nbsp;\",\"score\":null},{\"prefix\":\"D\",\"content\":\"啊擦擦擦\",\"score\":null}],\"correct\":\"A,B\"}','2019-11-08 12:19:12'),
(86,'[{\"name\":\"单选题\",\"questionItems\":[{\"id\":71,\"itemOrder\":1},{\"id\":70,\"itemOrder\":2},{\"id\":67,\"itemOrder\":3}]},{\"name\":\"判断题\",\"questionItems\":[{\"id\":51,\"itemOrder\":4},{\"id\":53,\"itemOrder\":5},{\"id\":52,\"itemOrder\":6}]},{\"name\":\"多选题\",\"questionItems\":[{\"id\":68,\"itemOrder\":7},{\"id\":69,\"itemOrder\":8},{\"id\":64,\"itemOrder\":9}]}]','2019-11-09 13:08:23'),
(87,'{\"titleContent\":\"&nbsp; 擦啊擦\",\"analyze\":\"擦擦\",\"questionItemObjects\":[{\"prefix\":\"A\",\"content\":\"擦擦\",\"score\":null},{\"prefix\":\"B\",\"content\":\"踩踩踩\",\"score\":null},{\"prefix\":\"C\",\"content\":\"擦擦擦传达出哇\",\"score\":null},{\"prefix\":\"D\",\"content\":\"擦擦擦\",\"score\":null}],\"correct\":\"B\"}','2019-11-09 14:18:56');

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_uuid` varchar(36) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL,
  `real_name` varchar(255) DEFAULT NULL COMMENT '真实姓名',
  `age` int(11) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL COMMENT '1.男 2女',
  `birth_day` datetime DEFAULT NULL,
  `user_level` int(11) DEFAULT NULL COMMENT '学生年级(1-12)',
  `phone` varchar(255) DEFAULT NULL,
  `role` int(11) DEFAULT NULL COMMENT '1.学生 2.老师 3.管理员',
  `status` int(11) DEFAULT NULL COMMENT '1.启用 2禁用',
  `image_path` varchar(255) DEFAULT NULL COMMENT '头像地址',
  `create_time` datetime DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `last_active_time` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL COMMENT '是否删除',
  `wx_open_id` varchar(255) DEFAULT NULL COMMENT '微信openId',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `t_user` */

insert  into `t_user`(`id`,`user_uuid`,`user_name`,`password`,`real_name`,`age`,`sex`,`birth_day`,`user_level`,`phone`,`role`,`status`,`image_path`,`create_time`,`modify_time`,`last_active_time`,`deleted`,`wx_open_id`) values 
(1,'d2d29da2-dcb3-4013-b874-727626236f47','student','D1AGFL+Gx37t0NPG4d6biYP5Z31cNbwhK5w1lUeiHB2zagqbk8efYfSjYoh1Z/j1dkiRjHU+b0EpwzCh8IGsksJjzD65ci5LsnodQVf4Uj6D3pwoscXGqmkjjpzvSJbx42swwNTA+QoDU8YLo7JhtbUK2X0qCjFGpd+8eJ5BGvk=','学生',17,1,'2019-09-07 18:54:40',12,'15007133738',1,1,NULL,'2019-09-07 18:55:02',NULL,NULL,'\0','oaWyB4kWcyKeJ441iQcnJXm14Uhg'),
(2,'52045f5f-a13f-4ccc-93dd-f7ee8270ad4c','admin','D1AGFL+Gx37t0NPG4d6biYP5Z31cNbwhK5w1lUeiHB2zagqbk8efYfSjYoh1Z/j1dkiRjHU+b0EpwzCh8IGsksJjzD65ci5LsnodQVf4Uj6D3pwoscXGqmkjjpzvSJbx42swwNTA+QoDU8YLo7JhtbUK2X0qCjFGpd+8eJ5BGvk=','管理员',30,1,'2019-09-07 18:56:07',NULL,NULL,3,1,NULL,'2019-09-07 18:56:21',NULL,NULL,'\0',NULL),
(3,'52379b13-5c01-43f9-a427-899ae57989c0','alvis','fnanT3ob78rUADLF8Mky+N29gFyP5952C861ONTSn0A9n8VXU414aSqIVghU+YOVc6UHltxMM+AVymdZPssw+zIUiJtbWu4+zYH4iDfpIHyJW1Tb01IVs3nJPId5YMVWd9rMBBkavA73zOjdwkm13HcV98bFMxyhIqoNuuWdCSY=','alvis',NULL,NULL,NULL,1,NULL,1,1,NULL,'2019-09-07 06:54:49',NULL,'2019-09-07 06:54:49','\0',NULL),
(4,'4e182be9-3ee0-45a4-8329-fd79aee3b8e2','teacher','gnxWX0fbEkBdGdGekIkBBm5ssCe6RS+RayLnsuFj7yG0I3uHUDCvwaAMJpR8w9cJxGMQ5KOkgcCgpG9uOX3bnIaT6zP9owhGU6c71LDQO9xjyrZRYPu89FrcqeU3DFo05Z8rxlEQxzjMCTgu421CoN4zCUDSij7I3i74Ktlql7w=','32',NULL,NULL,NULL,NULL,NULL,2,1,NULL,'2019-09-07 06:56:28','2019-10-09 16:24:36','2019-09-07 06:56:28','\0',NULL),
(5,'f0cfa3c5-7131-48af-a2be-b8c792018daa','bbbvc','kc0DETYvKgh9AYyb2oV+b7Z9+DOrcrAbp5F/KMFCtLE5hPyhXy7kHqksNEcCvsPgW2jygkGF6Gfj5iyhRwA/fhacW/LR7+8zOGUQ3hyejPygLW+H2VEkUVnV/LlkD5ge7chqAdBRUkU7uW6MoFGscPL1oTTLusjE5e1hRmHkdWQ=','2323',NULL,NULL,NULL,NULL,NULL,3,1,NULL,'2019-09-07 06:57:16',NULL,'2019-09-07 06:57:16','\0',NULL);

/*Table structure for table `t_user_event_log` */

DROP TABLE IF EXISTS `t_user_event_log`;

CREATE TABLE `t_user_event_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名',
  `real_name` varchar(255) DEFAULT NULL COMMENT '真实姓名',
  `content` text COMMENT '内容',
  `create_time` datetime DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `t_user_event_log` */

insert  into `t_user_event_log`(`id`,`user_id`,`user_name`,`real_name`,`content`,`create_time`) values 
(1,1,'student','学生','student 登录了学之思考试系统','2019-09-07 06:49:23'),
(2,2,'admin','管理员','admin 登录了学之思考试系统','2019-09-07 06:51:35'),
(3,2,'admin','管理员','admin 登出了学之思考试系统','2019-09-07 07:00:38'),
(4,1,'student','学生','student 登录了学之思考试系统','2019-09-07 07:00:44'),
(5,1,'student','学生','student 提交试卷：固定试卷 得分：3 耗时：4 秒','2019-09-07 07:07:09'),
(6,1,'student','学生','student 批改试卷：固定试卷 得分：6','2019-09-07 07:07:20'),
(7,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-08 14:54:37'),
(8,2,'admin','管理员','admin 登出了学之思考试系统','2019-10-09 16:24:40'),
(9,4,'teacher','32','teacher 登录了学之思考试系统','2019-10-09 16:24:52'),
(10,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-09 16:24:57'),
(11,2,'admin','管理员','admin 登出了学之思考试系统','2019-10-09 16:27:15'),
(12,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-09 16:27:17'),
(13,2,'admin','管理员','admin 登出了学之思考试系统','2019-10-10 01:19:54'),
(14,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-10 01:19:56'),
(15,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-12 02:53:26'),
(16,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-16 12:24:44'),
(17,2,'admin','管理员','admin 登出了学之思考试系统','2019-10-16 12:29:44'),
(18,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-16 12:29:45'),
(19,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-16 12:30:08'),
(20,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-16 12:35:06'),
(21,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-21 03:27:57'),
(22,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-21 11:51:41'),
(23,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-22 13:48:00'),
(24,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-27 09:35:42'),
(25,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-28 03:59:37'),
(26,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-28 05:39:03'),
(27,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-28 05:39:08'),
(28,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-28 16:37:25'),
(29,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-29 12:20:32'),
(30,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-29 16:55:19'),
(31,2,'admin','管理员','admin 登录了学之思考试系统','2019-10-31 14:54:15'),
(32,2,'admin','管理员','admin 登录了学之思考试系统','2019-11-02 05:13:52'),
(33,2,'admin','管理员','admin 登录了学之思考试系统','2019-11-03 08:20:03'),
(34,2,'admin','管理员','admin 登录了学之思考试系统','2019-11-04 12:54:06'),
(35,2,'admin','管理员','admin 登录了学之思考试系统','2019-11-04 15:04:34'),
(36,2,'admin','管理员','admin 登录了学之思考试系统','2019-11-06 07:44:05');

/*Table structure for table `t_user_token` */

DROP TABLE IF EXISTS `t_user_token`;

CREATE TABLE `t_user_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(36) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT '用户Id',
  `wx_open_id` varchar(255) DEFAULT NULL COMMENT '微信openId',
  `create_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `t_user_token` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
