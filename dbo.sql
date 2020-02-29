
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sq_173cms` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `sq_173cms`;

/*Table structure for table `activate_info` */

DROP TABLE IF EXISTS `activate_info`;

CREATE TABLE `activate_info` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `activate_info` */

/*Table structure for table `api_info` */

DROP TABLE IF EXISTS `api_info`;

CREATE TABLE `api_info` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `sort` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `leixing` varchar(50) DEFAULT NULL,
  `diqu` varchar(50) DEFAULT NULL,
  `nianfen` varchar(50) DEFAULT NULL,
  `zhuangtai` varchar(50) DEFAULT NULL,
  `zifei` varchar(50) DEFAULT NULL,
  `xingqi` varchar(50) DEFAULT NULL,
  `type_id` varchar(50) DEFAULT NULL,
  `field` varchar(50) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `select_video` int(11) DEFAULT NULL,
  `kandian` varchar(100) DEFAULT NULL,
  `zongjishu` varchar(100) DEFAULT NULL,
  `shangyingnianfen` varchar(100) DEFAULT NULL,
  `fengge` varchar(100) DEFAULT NULL,
  `shengyou` varchar(100) DEFAULT NULL,
  `rank_type` varchar(50) DEFAULT NULL,
  `cache_time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `api_info` */

/*Table structure for table `channel_info` */

DROP TABLE IF EXISTS `channel_info`;

CREATE TABLE `channel_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  `template` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `channel_info` */

/*Table structure for table `collection_info` */

DROP TABLE IF EXISTS `collection_info`;

CREATE TABLE `collection_info` (
  `id` int(11) NOT NULL,
  `media_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `collection_info` */

/*Table structure for table `comment_info` */

DROP TABLE IF EXISTS `comment_info`;

CREATE TABLE `comment_info` (
  `id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `update_time` datetime NOT NULL,
  `login_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `comment_info` */

/*Table structure for table `email_info` */

DROP TABLE IF EXISTS `email_info`;

CREATE TABLE `email_info` (
  `id` int(11) NOT NULL,
  `smtp` varchar(50) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `email_info` */

/*Table structure for table `field_info` */

DROP TABLE IF EXISTS `field_info`;

CREATE TABLE `field_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  `input_type` varchar(50) NOT NULL,
  `var_name` varchar(50) NOT NULL,
  `content` longtext,
  `type` varchar(50) DEFAULT NULL,
  `is_allow_edit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `field_info` */

insert  into `field_info`(`id`,`name`,`sort`,`input_type`,`var_name`,`content`,`type`,`is_allow_edit`) values (7,'海报',1,'image','haibao','','system',NULL),(8,'小封面',1,'image','fengmian','','system',NULL),(12,'简介',1,'textarea','jianjie','','system',NULL),(13,'标题',1,'text','biaoti','','system',NULL),(17,'看点',1,'text','kandian','	<div class=\'unit\'>		<div class=\'left\'>			<p class=\'subtitle\'>看点</p>		</div>		<div class=\'right\'>		<input type=\'text\' class=\'text\' name=\'kandian\' value=\'\' />		</div>		<span class=\'clearfix\'></span>	</div>','user',NULL),(20,'总集数',2,'number','zongjishu','	<div class=\'unit\'>		<div class=\'left\'>			<p class=\'subtitle\'>总集数</p>		</div>		<div class=\'right\'>		<input type=\'text\' class=\'text\' name=\'zongjishu\' data-type=\"空|正整数\" error-msg=\"正整数格式错误\" value=\'\' />		</div>		<span class=\'clearfix\'></span>	</div>','user',NULL),(21,'别名',1,'text','bieming','','system',NULL),(23,'媒体主键',1,'text','media_id',NULL,'system',NULL),(24,'分类id',1,'text','type_id',NULL,'system',NULL),(25,'媒体状态',1,'text','status',NULL,'system',NULL),(26,'更新时间',1,'text','update_time',NULL,'system',NULL),(27,'标签',1,'text','tag',NULL,'system',NULL),(28,'主键',1,'text','id',NULL,'system',NULL),(32,'接口字段',1,'text','field',NULL,'system',NULL),(33,'接口名称',1,'text','name',NULL,'system',NULL),(34,'接口排序',1,'text','sort',NULL,'system',NULL),(35,'接口类型',1,'text','type',NULL,'system',NULL),(45,'大封面',1,'image','dafengmian',NULL,'system',NULL);

/*Table structure for table `field_profile_info` */

DROP TABLE IF EXISTS `field_profile_info`;

CREATE TABLE `field_profile_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `field_profile_info` */

/*Table structure for table `group_info` */

DROP TABLE IF EXISTS `group_info`;

CREATE TABLE `group_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `power` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `group_info` */

insert  into `group_info`(`id`,`name`,`power`,`type`,`sort`) values (1,'管理员',255,'system',1),(2,'注册用户',1,'system',3);

/*Table structure for table `history_info` */

DROP TABLE IF EXISTS `history_info`;

CREATE TABLE `history_info` (
  `id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `history_info` */

/*Table structure for table `media_info` */

DROP TABLE IF EXISTS `media_info`;

CREATE TABLE `media_info` (
  `media_id` int(11) NOT NULL,
  `update_time` datetime NOT NULL,
  `status` int(11) NOT NULL,
  `haibao` varchar(200) DEFAULT NULL,
  `fengmian` varchar(200) DEFAULT NULL,
  `biaoti` varchar(100) DEFAULT NULL,
  `kandian` varchar(50) DEFAULT NULL,
  `jianjie` text,
  `tag` varchar(100) DEFAULT NULL,
  `zongjishu` varchar(50) DEFAULT NULL,
  `bieming` varchar(200) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `dafengmian` varchar(200) DEFAULT NULL,
  `has_video` int(11) DEFAULT NULL,
  PRIMARY KEY (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `media_info` */

/*Table structure for table `nav_info` */

DROP TABLE IF EXISTS `nav_info`;

CREATE TABLE `nav_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `link` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  `is_index` int(11) NOT NULL,
  `is_use` int(11) NOT NULL,
  `channel_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `nav_info` */

insert  into `nav_info`(`id`,`name`,`link`,`type`,`sort`,`is_index`,`is_use`,`channel_id`) values (1,'首页','portal/index.action','system',0,1,1,NULL);

/*Table structure for table `player_info` */

DROP TABLE IF EXISTS `player_info`;

CREATE TABLE `player_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `content` text,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `player_info` */

/*Table structure for table `qiniu_info` */

DROP TABLE IF EXISTS `qiniu_info`;

CREATE TABLE `qiniu_info` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `ak` varchar(100) DEFAULT NULL,
  `sk` varchar(100) DEFAULT NULL,
  `bucket` varchar(50) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `compress` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `domain` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `qiniu_info` */

insert  into `qiniu_info`(`id`,`type`,`ak`,`sk`,`bucket`,`width`,`height`,`compress`,`name`,`domain`) values (1,'haibao','','','',400,600,0,'海报',''),(2,'fengmian','','','',320,180,0,'小封面',''),(7,'content','','','',0,0,0,'照片',''),(10,'touxiang','','','',200,200,0,'头像',''),(11,'dafengmian','','','',492,319,0,'大封面','');

/*Table structure for table `reply_info` */

DROP TABLE IF EXISTS `reply_info`;

CREATE TABLE `reply_info` (
  `id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `login_name` varchar(50) NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `to_login_name` varchar(50) NOT NULL,
  `update_time` datetime NOT NULL,
  `content` text NOT NULL,
  `video_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `reply_info` */

/*Table structure for table `seo_info` */

DROP TABLE IF EXISTS `seo_info`;

CREATE TABLE `seo_info` (
  `id` int(11) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `keywords` varchar(200) DEFAULT NULL,
  `description` text,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `seo_info` */

insert  into `seo_info`(`id`,`title`,`keywords`,`description`,`type`) values (1,'','','','index'),(2,'','','','list'),(3,'','',NULL,'play'),(4,'','',NULL,'profile');

/*Table structure for table `slide_info` */

DROP TABLE IF EXISTS `slide_info`;

CREATE TABLE `slide_info` (
  `id` int(11) NOT NULL,
  `api_id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `summary` varchar(100) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `sort` int(11) NOT NULL,
  `thumbnail` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `slide_info` */

/*Table structure for table `star_info` */

DROP TABLE IF EXISTS `star_info`;

CREATE TABLE `star_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `alias` varchar(50) DEFAULT NULL,
  `sex` varchar(50) NOT NULL,
  `region` varchar(50) DEFAULT NULL,
  `blood` varchar(50) DEFAULT NULL,
  `birthday` varchar(50) DEFAULT NULL,
  `constellation` varchar(50) DEFAULT NULL,
  `occupation` varchar(50) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `introduction` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `star_info` */

/*Table structure for table `tag_info` */

DROP TABLE IF EXISTS `tag_info`;

CREATE TABLE `tag_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `tag_info` */

/*Table structure for table `template_info` */

DROP TABLE IF EXISTS `template_info`;

CREATE TABLE `template_info` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `template_info` */

insert  into `template_info`(`id`,`type`,`name`) values (1,'pc','default'),(2,'m','default');

/*Table structure for table `type_field` */

DROP TABLE IF EXISTS `type_field`;

CREATE TABLE `type_field` (
  `id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `is_screen` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  `is_required` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `type_field` */

/*Table structure for table `type_info` */

DROP TABLE IF EXISTS `type_info`;

CREATE TABLE `type_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  `profile_template` varchar(50) DEFAULT NULL,
  `play_template` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `type_info` */

/*Table structure for table `user_info` */

DROP TABLE IF EXISTS `user_info`;

CREATE TABLE `user_info` (
  `id` int(11) NOT NULL,
  `login_name` varchar(50) NOT NULL,
  `pass_word` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `register_time` datetime NOT NULL,
  `register_ip` varchar(50) DEFAULT NULL,
  `last_login_time` datetime NOT NULL,
  `last_login_ip` varchar(50) DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `user_info` */

insert  into `user_info`(`id`,`login_name`,`pass_word`,`email`,`register_time`,`register_ip`,`last_login_time`,`last_login_ip`,`status`) values (1,'admin','96e79218965eb72c92a549dd5a330112','123456@qq.com','2018-03-07 16:16:00','hidden','2018-03-07 16:16:00','hidden',1);

/*Table structure for table `user_profile_info` */

DROP TABLE IF EXISTS `user_profile_info`;

CREATE TABLE `user_profile_info` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `sign_personal` varchar(255) DEFAULT NULL,
  `point` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `user_profile_info` */

insert  into `user_profile_info`(`id`,`user_id`,`group_id`,`avatar`,`sign_personal`,`point`) values (1,1,1,'','',0);

/*Table structure for table `video_info` */

DROP TABLE IF EXISTS `video_info`;

CREATE TABLE `video_info` (
  `video_id` int(11) NOT NULL,
  `media_id` int(11) NOT NULL,
  `num` varchar(50) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `view_count` int(11) NOT NULL,
  `player_id` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `remark` text,
  `power` int(11) DEFAULT NULL,
  `point` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `view_count_day` int(11) DEFAULT NULL,
  `view_count_week` int(11) DEFAULT NULL,
  `view_count_month` int(11) DEFAULT NULL,
  `view_count_year` int(11) DEFAULT NULL,
  PRIMARY KEY (`video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `video_info` */

/*Table structure for table `web_info` */

DROP TABLE IF EXISTS `web_info`;

CREATE TABLE `web_info` (
  `name` varchar(255) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `record_number` varchar(50) DEFAULT NULL,
  `statistical_code` text,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `web_info` */

insert  into `web_info`(`name`,`domain`,`email`,`record_number`,`statistical_code`,`id`) values (NULL,NULL,NULL,NULL,NULL,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
