CREATE DATABASE cdms DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE cdms;
/*
Navicat MySQL Data Transfer

Source Server         : 172.18.10.18
Source Server Version : 50626
Source Host           : 172.18.10.18:3306
Source Database       : desktop_test

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2015-12-16 17:03:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `back_up_detail`
-- ----------------------------
DROP TABLE IF EXISTS `back_up_detail`;
CREATE TABLE `back_up_detail` (
  `id` varchar(32) NOT NULL DEFAULT '',
  `display_name` varchar(100) DEFAULT NULL,
  `status` int(1) DEFAULT '1' COMMENT '1：成功\r\n2：失败\r\n3 : 过期 4:正在备份 5：正在恢复  6:正在备份其他版本',
  `back_up_time` varchar(17) DEFAULT NULL COMMENT '备份时间',
  `create_time` varchar(17) DEFAULT NULL,
  `host_id` varchar(32) DEFAULT NULL,
  `type` int(10) DEFAULT NULL COMMENT '0：桌面云主机备份 1：云服务器主机备份',
  `mode` int(11) DEFAULT NULL,
  `disk` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of back_up_detail
-- ----------------------------
 
-- ----------------------------
-- Table structure for `bandwidth_package_option`
-- ----------------------------
DROP TABLE IF EXISTS `bandwidth_package_option`;
CREATE TABLE `bandwidth_package_option` (
  `id` char(32) NOT NULL,
  `min` decimal(20,0) DEFAULT NULL COMMENT '单位为bps',
  `max` decimal(20,0) DEFAULT NULL COMMENT '单位为bps',
  `create_time` char(17) DEFAULT NULL,
  `modified_time` char(17) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='带宽参数选项表';

-- ----------------------------
-- Records of bandwidth_package_option
-- ----------------------------

-- ----------------------------
-- Table structure for `blacklist`
-- ----------------------------
DROP TABLE IF EXISTS `blacklist`;
CREATE TABLE `blacklist` (
  `rule_id` varchar(32) NOT NULL,
  `rule_name` varchar(50) DEFAULT NULL COMMENT '规则名',
  `rule_ip` varchar(50) DEFAULT NULL COMMENT 'ip或ip网段',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blacklist
-- ----------------------------
 
-- ----------------------------
-- Table structure for `box_real_info`
-- ----------------------------
DROP TABLE IF EXISTS `box_real_info`;
CREATE TABLE `box_real_info` (
  `mac` varchar(32) NOT NULL DEFAULT '',
  `user_id` varchar(32) NOT NULL DEFAULT '',
  `user_name` varchar(50) DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `hardware_version` varchar(50) DEFAULT NULL,
  `gateway` varchar(100) DEFAULT NULL,
  `software_version` varchar(50) DEFAULT NULL,
  `subnet_mask` varchar(15) DEFAULT NULL,
  `last_login_time` varchar(17) DEFAULT NULL COMMENT '上次登录时间',
  `last_alive_time` varchar(17) DEFAULT NULL,
  `last_logout_time` varchar(17) DEFAULT NULL COMMENT '上次注销时间',
  `cumulative_online_time` bigint(21) DEFAULT '0' COMMENT '累计在线时长(单位：毫秒)',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of box_real_info
-- ----------------------------
 
-- ----------------------------
-- Table structure for `client_message`
-- ----------------------------
DROP TABLE IF EXISTS `client_message`;
CREATE TABLE `client_message` (
  `id` varchar(32) NOT NULL,
  `create_time` varchar(17) DEFAULT NULL COMMENT '反馈时间',
  `content` varchar(500) DEFAULT NULL COMMENT '反馈内容',
  `status` int(11) DEFAULT NULL COMMENT '状态 1:已读 2：未读',
  `type` int(11) DEFAULT NULL COMMENT '类型 1：故障反馈 2：意见建议 3：其它',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of client_message
-- ----------------------------

-- ----------------------------
-- Table structure for `cloud_disk`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_disk`;
CREATE TABLE `cloud_disk` (
  `id` varchar(32) NOT NULL,
  `real_disk_id` varchar(36) DEFAULT NULL COMMENT '对应后台真实云存储的uuid',
  `disk_pool_id` varchar(32) DEFAULT NULL COMMENT '资源池ID',
  `snapshot_pool_id` varchar(32) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `name` varchar(100) DEFAULT NULL COMMENT '机器名',
  `account` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL COMMENT '可以为明文',
  `disk` decimal(30,0) DEFAULT NULL COMMENT '系统磁盘容量，以字节为单位',
  `running_status` int(11) DEFAULT NULL COMMENT '运行状态：\r\n            1: 关机\r\n            2: 启动\r\n            3: 告警\r\n            4: 故障',
  `status` int(11) DEFAULT NULL COMMENT '状态：\r\n            1: 正常\r\n            2: 停机\r\n            3：欠费\r\n            4：永久停机，已删除',
  `inner_ip` varchar(15) DEFAULT NULL COMMENT '内网监控地址ip',
  `inner_port` int(11) DEFAULT NULL COMMENT '内网监控地址端口',
  `outer_ip` varchar(15) DEFAULT NULL COMMENT '公网监控地址ip',
  `outer_port` int(11) DEFAULT NULL COMMENT '公网监控地址端口',
  `create_time` varchar(17) DEFAULT NULL COMMENT '云硬盘创建成功的时间',
  `inactivate_time` varchar(17) DEFAULT NULL COMMENT '停机时间',
  `reactivate_time` varchar(17) DEFAULT NULL COMMENT '停机恢复的时间',
  `monthly_price` decimal(10,2) DEFAULT NULL,
  `region` int(11) DEFAULT NULL COMMENT '地域：\r\n            1：广州\r\n            2：成都\r\n            3：北京\r\n            4：香港',
  `ip` varchar(15) DEFAULT NULL COMMENT '网关',
  `iqn` varchar(128) DEFAULT NULL,
  `type` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_disk
-- ---------------------------- 
-- ----------------------------
-- Table structure for `cloud_host`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_host`;
CREATE TABLE `cloud_host` (
  `id` char(32) NOT NULL,
  `real_host_id` char(36) DEFAULT NULL COMMENT '对应后台真实云主机的uuid',
  `user_id` char(32) DEFAULT NULL COMMENT '用户ID',
  `warehouse_id` char(32) DEFAULT NULL COMMENT '所属仓库ID，与cloud_host_warehouse关联',
  `host_name` varchar(100) DEFAULT NULL COMMENT '机器名',
  `display_name` varchar(100) DEFAULT NULL COMMENT '云主机显示名称',
  `account` varchar(100) DEFAULT NULL COMMENT '系统用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '系统密码',
  `cpu_core` int(11) DEFAULT NULL COMMENT 'cpu核心数量',
  `memory` decimal(20,0) DEFAULT NULL COMMENT '内存，以字节为单位',
  `sys_image_id` char(32) DEFAULT NULL COMMENT '操作镜像id',
  `sys_disk` decimal(30,0) DEFAULT NULL COMMENT '系统磁盘容量，以字节为单位',
  `data_disk` decimal(30,0) DEFAULT NULL COMMENT '数据磁盘容量，以字节为单位',
  `bandwidth` decimal(20,0) DEFAULT NULL COMMENT '网络带宽，单位bps',
  `running_status` int(11) DEFAULT NULL COMMENT '运行状态：1: 关机 2: 启动 3: 告警 4: 故障',
  `status` int(11) DEFAULT '0' COMMENT '状态：0:未创建1: 创建中 2:创建成功 3:创建失败 ',
  `inner_ip` varchar(15) DEFAULT NULL COMMENT '内网监控地址ip',
  `inner_port` int(11) DEFAULT NULL COMMENT '内网监控地址端口',
  `sys_image_name` varchar(100) DEFAULT NULL COMMENT '镜像名',
  `create_time` char(17) DEFAULT NULL COMMENT '云主机创建成功的时间',
  `modified_time` char(17) DEFAULT NULL,
  `outer_ip` varchar(15) DEFAULT NULL,
  `outer_port` int(11) DEFAULT NULL,
  `assign_time` varchar(17) DEFAULT NULL,
  `type` int(2) DEFAULT '1' COMMENT '1：云桌面 2：云服务器 3：专属云',
  `is_auto_start` int(2) DEFAULT '1' COMMENT '1:创建完成自动启动 2：手动',
  `pool_id` varchar(32) DEFAULT NULL,
  `vpc_ip` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='云主机表';

-- ----------------------------
-- Records of cloud_host
-- ----------------------------
 
-- ----------------------------
-- Table structure for `cloud_host_config_model`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_host_config_model`;
CREATE TABLE `cloud_host_config_model` (
  `id` char(32) NOT NULL COMMENT 'ID',
  `name` varchar(100) DEFAULT NULL COMMENT '云主机类型名称',
  `cpu_core` int(11) DEFAULT NULL COMMENT 'cpu核心数量',
  `memory` decimal(20,0) DEFAULT NULL COMMENT '内存，以字节为单位',
  `sys_image_id` char(32) DEFAULT NULL COMMENT '操作镜像id',
  `sys_disk` decimal(30,0) DEFAULT NULL COMMENT '系统磁盘容量，以字节为单位',
  `data_disk` decimal(30,0) DEFAULT NULL COMMENT '数据磁盘容量，以字节为单位',
  `bandwidth` decimal(20,0) DEFAULT NULL COMMENT '网络带宽，单位bps',
  `sys_image_name` varchar(100) DEFAULT NULL COMMENT '镜像名',
  `create_time` char(17) DEFAULT NULL COMMENT '云主机创建成功的时间',
  `modified_time` char(17) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `support_h264` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='云主机类型：创建模版';

-- ----------------------------
-- Records of cloud_host_config_model
-- ----------------------------
 
-- ----------------------------
-- Table structure for `cloud_host_open_port`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_host_open_port`;
CREATE TABLE `cloud_host_open_port` (
  `id` varchar(32) NOT NULL,
  `host_id` varchar(32) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `outer_port` int(11) DEFAULT NULL,
  `server_port` int(11) DEFAULT NULL,
  `protocol` int(11) DEFAULT '1',
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_host_open_port
-- ---------------------------- 

-- ----------------------------
-- Table structure for `cloud_host_warehouse`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_host_warehouse`;
CREATE TABLE `cloud_host_warehouse` (
  `id` char(32) NOT NULL COMMENT 'ID',
  `cloud_host_config_model_id` char(32) DEFAULT NULL COMMENT '主机类型ID，与cloud_host_config_model关联',
  `name` varchar(100) DEFAULT NULL COMMENT '仓库名称',
  `total_amount` int(11) DEFAULT '0' COMMENT '数量',
  `remain_amount` int(11) DEFAULT '0' COMMENT '未分配数量',
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  `modify_time` char(17) DEFAULT NULL COMMENT '更新时间',
  `assigned_amount` int(4) DEFAULT '0' COMMENT '已分配数量',
  `check_time` varchar(6) DEFAULT NULL COMMENT '检查时间',
  `minimum` int(2) DEFAULT '0' COMMENT '最小库存',
  `pool_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='云主机仓库';

-- ----------------------------
-- Records of cloud_host_warehouse
-- ----------------------------
 
-- ----------------------------
-- Table structure for `cpu_package_option`
-- ----------------------------
DROP TABLE IF EXISTS `cpu_package_option`;
CREATE TABLE `cpu_package_option` (
  `id` char(32) NOT NULL,
  `core` int(11) DEFAULT NULL COMMENT 'cpu核数',
  `sort` int(11) DEFAULT NULL COMMENT '排序序号',
  `create_time` char(17) DEFAULT NULL,
  `modified_time` char(17) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CPU参数选项';

-- ----------------------------
-- Records of cpu_package_option
-- ----------------------------

-- ----------------------------
-- Table structure for `dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `id` varchar(32) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `value` varchar(100) DEFAULT NULL,
  `create_time` varchar(17) DEFAULT NULL,
  `modify_time` varchar(17) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES ('1', 'product_name', '云桌面管理中心', null, '20151216164914849');
INSERT INTO `dictionary` VALUES ('2', 'init_user', 'false', null, '20151210142955471');
INSERT INTO `dictionary` VALUES ('3', 'chunk_size', '524288000', null, '20151217152959808');

-- ----------------------------
-- Table structure for `disk_package_option`
-- ----------------------------
DROP TABLE IF EXISTS `disk_package_option`;
CREATE TABLE `disk_package_option` (
  `id` char(32) NOT NULL,
  `min` decimal(30,0) DEFAULT NULL COMMENT '单位为GB',
  `max` decimal(30,0) DEFAULT NULL COMMENT '单位为GB',
  `create_time` char(17) DEFAULT NULL,
  `modified_time` char(17) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='磁盘参数选项';

-- ----------------------------
-- Records of disk_package_option
-- ----------------------------

-- ----------------------------
-- Table structure for `email_config`
-- ----------------------------
DROP TABLE IF EXISTS `email_config`;
CREATE TABLE `email_config` (
  `id` char(32) NOT NULL DEFAULT '',
  `name` varchar(45) DEFAULT NULL,
  `sender` varchar(45) DEFAULT NULL,
  `sender_address` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `create_time` char(17) DEFAULT NULL,
  `modified_time` char(17) DEFAULT NULL,
  `protocol` varchar(20) DEFAULT NULL,
  `host` varchar(20) DEFAULT NULL,
  `is_auth` int(10) DEFAULT NULL,
  `port` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of email_config
-- ----------------------------
INSERT INTO `email_config` VALUES ('b323eaca749d46d1a66c9627e917d14a', '系统邮件通知', 'ZhiCloud', 'services@zhicloud.com', 'zykj1215', '20150813192331848', '20150817225850102', 'smtp', 'smtp.exmail.qq.com', '1', '25');

-- ----------------------------
-- Table structure for `email_template`
-- ----------------------------
DROP TABLE IF EXISTS `email_template`;
CREATE TABLE `email_template` (
  `id` char(32) NOT NULL DEFAULT '',
  `config_id` char(32) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `recipient` varchar(100) DEFAULT NULL,
  `subject` varchar(45) DEFAULT NULL,
  `content` text,
  `create_time` char(17) DEFAULT NULL,
  `modified_time` char(17) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of email_template
-- ----------------------------
INSERT INTO `email_template` VALUES ('2ee13be8900b40f2851c542494a70b3f', 'b323eaca749d46d1a66c9627e917d14a', '用户手动重置密码', 'lshaowei@zhicloud.com', '致云Zhicloud邮箱验证', '<p>您好！</p><div>由于您忘记了您的登录信息，所以您收到了这封邮件！以下是为您手动重置的密码</div><div>${password}</div><div><br></div><div>请勿把这封邮件泄露给他人！</div><div>致云科技感谢您的支持！</div>', '20151025180151858', '20151025180151858', 'INFO_RESET_PASSWORD_MANUAL');
INSERT INTO `email_template` VALUES ('67220c088fb64410baf13b236d04ddb8', 'b323eaca749d46d1a66c9627e917d14a', 'web监控恢复邮件模板', 'lshaowei@zhicloud.com', '云端在线恢复', '<p>	管理员，您好：</p><p>	以下设备已恢复正常：</p><p>	${content}</p>', '20150730114041903', '20150804095924849', 'MONITOR_RULE_RECOVER');
INSERT INTO `email_template` VALUES ('8c9396c257974bbe8b8d05a064d04c29', 'b323eaca749d46d1a66c9627e917d14a', '用户随机重置密码', 'lshaowei@zhicloud.com', '致云Zhicloud邮箱验证', '您好！<div>由于您忘记了您的登录信息，所以您收到了这封邮件！以下是为您提供的随机新密码</div><div>${password}</div><div><br></div><div>请勿把这封邮件泄露给他人！</div><div>致云科技感谢您的支持！</div>', '20151025175904816', '20151025182642536', 'INFO_RESET_PASSWORD_RANDOM');
INSERT INTO `email_template` VALUES ('91824d1e344e4b51a708f57aa057ec51', 'b323eaca749d46d1a66c9627e917d14a', 'web监控故障邮件模板', 'lshaowei@zhicloud.com', '云端在线故障通知', '<p>	管理员，您好：</p><p>	以下${type}存在故障：</p><p>	${content}</p><p>	请及时排查解决。</p>', '20150723095616741', '20150804095446702', 'MONITOR_RULE_ERROR');
INSERT INTO `email_template` VALUES ('933c641322144d18a4faf64a9eef440d', 'b323eaca749d46d1a66c9627e917d14a', '管理员注册通知模板', 'lshaowei@zhicloud.com', '管理员注册通知', '<p>\n	<p style=\"font-family:\'sans serif\', tahoma, verdana, helvetica;font-size:12px;\">\n		尊敬的用户：\n	</p>\n	<p style=\"font-family:\'sans serif\', tahoma, verdana, helvetica;font-size:12px;\">\n		您好！\n	</p>\n	<p style=\"font-family:\'sans serif\', tahoma, verdana, helvetica;font-size:12px;\">\n		<span style=\"line-height:1.5;\">&nbsp;&nbsp;&nbsp;&nbsp;管理员已为您创建了账户，用户名：${name} 密码：${password},</span>\n	</p>\n	<p style=\"font-family:\'sans serif\', tahoma, verdana, helvetica;font-size:12px;\">\n		&nbsp;&nbsp;&nbsp;&nbsp;点击下面的链接即可进入系统：\n	</p>\n	<p style=\"font-family:\'sans serif\', tahoma, verdana, helvetica;font-size:12px;\">\n		&nbsp;&nbsp;&nbsp;&nbsp;${url}\n	</p>\n</p>\n<div>\n	您也可以将地址复制到浏览器进行访问。\n</div>', '20150901143629694', '20150901143629694', 'INFO_ADMIN_REGISTER');
INSERT INTO `email_template` VALUES ('c3e5aa68c3bb42b5af12f9d05f7443f3', 'b323eaca749d46d1a66c9627e917d14a', 'web监控告警通知模板', 'lshaowei@zhicloud.com', '云端在线告警数据', '<p>	管理员，您好：</p><p>	以下是今天告警${type}的汇总数据：</p><p>	${content}</p><p>	请及时排查解决。</p>', '20150723095801760', '20150804095526448', 'MONITOR_RULE_WARN');
INSERT INTO `email_template` VALUES ('c856ae0ad41941ec81fc1a4901a81044', 'b323eaca749d46d1a66c9627e917d14a', '终端用户注册通知模板', 'lshaowei@zhicloud.com', '终端用户注册通知', '<div style=\"font-family:\'Helvetica Neue\';font-size:14px;\">\n	<p style=\"font-family:\'sans serif\', tahoma, verdana, helvetica;font-size:12px;\">\n		尊敬的用户：</p><p style=\"font-family:\'sans serif\', tahoma, verdana, helvetica;font-size:12px;\"><span style=\"line-height: 1.42857143;\">您好！</span></p>\n	<p style=\"font-family:\'sans serif\', tahoma, verdana, helvetica;font-size:12px;\">\n		管理员已为您创建了账户：用户名：${name} 密码：${password}.\n	</p>\n</div>', '20150901143812318', '20150906085332626', 'INFO_REGISTER');
INSERT INTO `email_template` VALUES ('dc53d038b88049bbbf412c46581572ed', 'b323eaca749d46d1a66c9627e917d14a', 'web监控定时通知模板', 'lshaowei@zhicloud.com', '云端在线定时通知', '<p>	管理员，您好：</p><p>	以下是今天${type}的定时汇总数据：</p><p>	${content}</p><p>	请注意查收。</p>', '20150723100009738', '20150804095513622', 'MONITOR_RULE_FIXTIME');

-- ----------------------------
-- Table structure for `host_tenant_relationship`
-- ----------------------------
DROP TABLE IF EXISTS `host_tenant_relationship`;
CREATE TABLE `host_tenant_relationship` (
  `host_id` varchar(32) NOT NULL DEFAULT '' COMMENT '主机id',
  `tenant_id` varchar(32) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of host_tenant_relationship
-- ---------------------------- 
-- ----------------------------
-- Table structure for `host_timer_relationship`
-- ----------------------------
DROP TABLE IF EXISTS `host_timer_relationship`;
CREATE TABLE `host_timer_relationship` (
  `id` varchar(32) NOT NULL DEFAULT '',
  `host_id` varchar(32) DEFAULT NULL COMMENT '加入到定时任务的主机id',
  `last_back_up_time` varchar(17) DEFAULT NULL COMMENT '上次备份时间，用于判断本次该不该取出来备份',
  `timer_key` varchar(50) DEFAULT NULL COMMENT '表示属于哪种定时器：1、定时备份定时器 back_up_timer  2、开机定时器 startup_timer 3、关机定时器 shutdonw_timer',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of host_timer_relationship
-- ---------------------------- 
-- ----------------------------
-- Table structure for `image_upload_address`
-- ----------------------------
DROP TABLE IF EXISTS `image_upload_address`;
CREATE TABLE `image_upload_address` (
  `service_name` varchar(50) NOT NULL COMMENT 'SS服务名，不能为空且唯一，不能修改',
  `local_ip` varchar(50) NOT NULL COMMENT '内网传输IP，不能为空',
  `local_port` int(11) NOT NULL COMMENT '内网传输Port，不能为空',
  `public_ip` varchar(50) DEFAULT NULL COMMENT '外网传输IP，可以为空',
  `public_port` int(11) DEFAULT NULL COMMENT '外网传输Port，可以为空',
  `service_enable` tinyint(4) DEFAULT NULL COMMENT '是否启用该镜像服务，不能为空 1 启用 0禁用',
  `description` varchar(100) DEFAULT NULL COMMENT '自定义描述信息，可以为空',
  PRIMARY KEY (`service_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='镜像服务地址数据表';

-- ----------------------------
-- Records of image_upload_address
-- ----------------------------
 
-- ----------------------------
-- Table structure for `man_system_group`
-- ----------------------------
DROP TABLE IF EXISTS `man_system_group`;
CREATE TABLE `man_system_group` (
  `billid` varchar(32) NOT NULL DEFAULT '' COMMENT '主键',
  `name` varchar(100) DEFAULT NULL COMMENT '称名',
  `insert_date` datetime DEFAULT NULL COMMENT '创建日期',
  `insert_user` varchar(32) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`billid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_system_group
-- ---------------------------- 
-- ----------------------------
-- Table structure for `man_system_log`
-- ----------------------------
DROP TABLE IF EXISTS `man_system_log`;
CREATE TABLE `man_system_log` (
  `billid` varchar(32) NOT NULL DEFAULT '' COMMENT '主键',
  `operateid` varchar(32) DEFAULT NULL COMMENT '操作ID',
  `content` varchar(200) DEFAULT NULL COMMENT '志日内容',
  `operate_date` datetime DEFAULT NULL,
  `type` varchar(1) DEFAULT NULL COMMENT '志日类型 1 用户日志',
  PRIMARY KEY (`billid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_system_log
-- ---------------------------- 
-- ----------------------------
-- Table structure for `man_system_menu`
-- ----------------------------
DROP TABLE IF EXISTS `man_system_menu`;
CREATE TABLE `man_system_menu` (
  `billid` varchar(32) NOT NULL COMMENT '主键',
  `menuname` varchar(40) DEFAULT NULL COMMENT '菜单名称',
  `linkname` varchar(200) DEFAULT NULL COMMENT '链接路径',
  `status` varchar(1) DEFAULT NULL COMMENT '状态',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `parentid` varchar(32) DEFAULT NULL COMMENT '父菜单ID',
  `sort` int(9) DEFAULT NULL COMMENT '排序',
  `insert_date` datetime DEFAULT NULL COMMENT '创建日期',
  `insert_user` varchar(32) DEFAULT NULL COMMENT '创建人',
  `cssname` varchar(100) DEFAULT NULL COMMENT '菜单图标样式',
  PRIMARY KEY (`billid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_system_menu
-- ----------------------------
INSERT INTO `man_system_menu` VALUES ('45ebe6a728dc4614be68c7a4c6439860', '资源监控', '', '0', '', '', '0', '2015-07-06 10:07:04', 'superadmin', 'fa fa-tachometer');
INSERT INTO `man_system_menu` VALUES ('e6c99ddb1ddd4745aa45fbd535fbf553', '全局实时状态', '/paltform/all', '0', '', '45ebe6a728dc4614be68c7a4c6439860', '1', '2015-07-06 10:07:52', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('5a5757c77546493e827906240cb0d0ef', '服务管理', '/mypaltform/service', '0', '', '45ebe6a728dc4614be68c7a4c6439860', '2', '2015-07-28 15:03:33', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('e203749c741e4de3af03506b4397001c', '资源配置', '', '0', '', '', '1', '2015-07-16 17:06:17', 'superadmin', 'fa fa-list');
INSERT INTO `man_system_menu` VALUES ('857088edb2274a999c27abf183ad20cb', '计算资源池管理', '/cdrpm/all', '0', '', 'e203749c741e4de3af03506b4397001c', '2', '2015-07-16 17:09:23', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('892905cc9ec34eb4bfc9abaf58cdb234', '地址资源池管理', '/ipresourcepool/all', '0', '', 'e203749c741e4de3af03506b4397001c', '3', '2015-07-16 17:10:16', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('54f3aaa54bf44502ad16193c16d34c73', '存储资源池管理', '/storageresourcepool/all', '0', '', 'e203749c741e4de3af03506b4397001c', '5', '2015-07-16 17:08:14', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('ba4f42e82ad14badaeb99cd4791770b8', '云桌面组件管理', '', '0', '', '', '2', '2015-06-01 11:19:49', 'superadmin', 'fa fa-desktop');
INSERT INTO `man_system_menu` VALUES ('759959f6b369499e91432a4043d4dc38', '主机仓库管理', '/warehouse/all', '0', '', 'ba4f42e82ad14badaeb99cd4791770b8', '1', '2015-06-01 14:12:05', 'superadmin', null);
INSERT INTO `man_system_menu` VALUES ('9768223b00cc4cd59c076bb658226acf', '主机系统镜像管理', '/image/imagelist', '0', '', 'ba4f42e82ad14badaeb99cd4791770b8', '2', '2015-06-01 14:11:15', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('4b86b66ea33c47fb8bc46b6a8a346608', '终端盒子资产管理', '/box/list', '0', '', 'ba4f42e82ad14badaeb99cd4791770b8', '3', '2015-06-24 09:21:58', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('59f6e91280924b628a9340415cd6bc6d', '盒子固件升级', '/version/list', '0', '', 'ba4f42e82ad14badaeb99cd4791770b8', '5', '2015-06-11 11:09:53', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('15c851b13dae40e69a89fbe160cd9825', '光盘镜像管理', '/isoimage/all', '0', '', 'ba4f42e82ad14badaeb99cd4791770b8', '2', '2015-11-20 09:52:53', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('1ed4c45cecaf4032b1036445fca49434', '共享存储管理', '/sharedmemory/manage', '0', '', 'e203749c741e4de3af03506b4397001c', '7', '2015-10-10 11:44:45', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('810c22a1ac794dc5acc9e2f549bd3026', '黑名单管理', '/blacklist/all', '0', '', 'e203749c741e4de3af03506b4397001c', '10', '2015-12-11 09:41:41', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('b87b6f0fa2594abea67eaffd0296d016', '白名单管理', '/whitelist/all', '0', '', 'e203749c741e4de3af03506b4397001c', '11', '2015-12-11 09:43:12', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('312b28a8ce3c4c6a8ea58c6afd7bbf06', '云桌面用户管理', '', '0', '', '', '4', '2015-06-03 09:51:16', 'superadmin', 'fa fa-users');
INSERT INTO `man_system_menu` VALUES ('144bdf779b0841ebb9f4a4a3b572e0ee', '群组信息', '/group/all', '0', '', '312b28a8ce3c4c6a8ea58c6afd7bbf06', '1', '2015-06-03 09:55:25', 'superadmin', null);
INSERT INTO `man_system_menu` VALUES ('af3232443a8b4dc8b1ad1b99897e70bb', '终端用户管理', '/user/list', '0', 'qaq', '312b28a8ce3c4c6a8ea58c6afd7bbf06', '2', '2015-06-03 10:42:14', 'superadmin', null);
INSERT INTO `man_system_menu` VALUES ('48a243915beb43f8ad653bb65c712a36', '系统管理', '', '0', '', '', '9', '2015-06-01 14:16:09', 'superadmin', 'fa fa-th-large');
INSERT INTO `man_system_menu` VALUES ('48e1b6902c08455abdeebfc06c6ed39a', '用户管理', '/transform/useradmin/index', '0', '', '48a243915beb43f8ad653bb65c712a36', '1', '2015-06-01 14:18:29', 'superadmin', null);
INSERT INTO `man_system_menu` VALUES ('31bf73d5a87f464595438de6fe9c365e', '角色管理', '/transform/roleadmin/index', '0', '', '48a243915beb43f8ad653bb65c712a36', '2', '2015-06-01 14:19:03', 'superadmin', null);
INSERT INTO `man_system_menu` VALUES ('e77e14cc46e54d969015491e43785304', '角色组管理', '/transform/groupadmin/index', '0', '', '48a243915beb43f8ad653bb65c712a36', '3', '2015-06-01 14:19:35', 'superadmin', null);
INSERT INTO `man_system_menu` VALUES ('b8e302cd82fa40718ca2cfd7fe72684e', '功能菜单维护', '/transform/menuadmin/index', '0', '', '48a243915beb43f8ad653bb65c712a36', '4', '2015-06-01 14:20:11', 'superadmin', null);
INSERT INTO `man_system_menu` VALUES ('523c6d9feeb744daa5481d1132739859', '功能权限维护', '/transform/rightadmin/index', '0', '', '48a243915beb43f8ad653bb65c712a36', '5', '2015-06-01 14:20:44', 'superadmin', null);
INSERT INTO `man_system_menu` VALUES ('2c724bd1196f4ec98aa9b94836ac5f73', '终端消息管理', '', '0', '', '', '5', '2015-08-28 15:00:28', 'superadmin', 'fa fa-list-alt');
INSERT INTO `man_system_menu` VALUES ('2c3698d8e89440fe908ddaa9f726044c', '反馈信息管理', '/clientmessage/all', '0', '', '2c724bd1196f4ec98aa9b94836ac5f73', '1', '2015-08-28 15:01:48', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('8cef1134437f4cabad4fd28879adf344', '客户端消息推送', '/terminalinfo/add', '0', '', '2c724bd1196f4ec98aa9b94836ac5f73', '2', '2015-09-01 16:15:21', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('8d5cb01452224294bb41c8f80a63889a', '告警规则管理', '/syswarn/rulelist', '0', '', '45ebe6a728dc4614be68c7a4c6439860', '3', '2015-08-13 14:35:46', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('cba6d9e38a044a45b7d8b32245c24335', '总体概况分析', '/monitor/areaquery', '0', '', '45ebe6a728dc4614be68c7a4c6439860', '4', '2015-08-17 16:37:36', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('e2421762e21248da9fa3d387855ea789', '机房信息监控', '/monitor/roomquery', '0', '', '45ebe6a728dc4614be68c7a4c6439860', '5', '2015-08-18 14:58:52', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('4bec936599af42b38dbcd002ded6ed2c', '机架信息监控', '/monitor/rackquery', '0', '', '45ebe6a728dc4614be68c7a4c6439860', '6', '2015-08-18 15:52:39', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('d315492ec49f480582b765ab765edba7', '服务器信息监控', '/monitor/serverquery', '0', '', '45ebe6a728dc4614be68c7a4c6439860', '7', '2015-08-18 15:53:34', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('d607aa7c9849470c9b6600a5058e74ea', '云主机信息监控', '/monitor/hostquery', '0', '', '45ebe6a728dc4614be68c7a4c6439860', '8', '2015-08-18 15:54:08', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('6d3fd494900f4cc0a595578539d061b2', '资源池信息监控', '/monitor/resourcequery', '0', '', '45ebe6a728dc4614be68c7a4c6439860', '9', '2015-08-19 10:28:30', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('cb2fe5765f224d68aaa4d787177a2d31', '备份和恢复', '/backresume/detailmanage', '0', '', 'ba4f42e82ad14badaeb99cd4791770b8', '6', '2015-08-12 14:27:40', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('f988de5af8394f70aca1300fbb161fdb', '预启动管理', '/dtsettimeoperation/manage', '0', '预启动', 'ba4f42e82ad14badaeb99cd4791770b8', '7', '2015-08-05 10:07:29', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('c918a5eb0f0d4d1d9842ea30e11d69be', '智能路由例外规则管理', '/rule/all', '0', '', 'e203749c741e4de3af03506b4397001c', '6', '2015-08-21 09:46:19', 'badbb77a6ff94f53b1a0677d0eb1a20e', '');
INSERT INTO `man_system_menu` VALUES ('35f20ca9ec6549588846c42203021515', '主机配置', '/chcm/all', '0', '', 'e203749c741e4de3af03506b4397001c', '1', '2015-08-21 09:30:34', 'badbb77a6ff94f53b1a0677d0eb1a20e', '');
INSERT INTO `man_system_menu` VALUES ('2606ee52b0b54595bb124dd4264f95cf', '系统设置', '/transform/system/index', '0', '', 'e203749c741e4de3af03506b4397001c', '8', '2015-08-21 09:47:07', 'badbb77a6ff94f53b1a0677d0eb1a20e', '');
INSERT INTO `man_system_menu` VALUES ('c295224601b146c19499801cb079b7c3', '消息服务管理', '/message/manage', '0', '消息服务管理', 'e203749c741e4de3af03506b4397001c', '7', '2015-08-13 15:50:02', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('e323828636cc48c9b8a8ac5f7cc62720', '终端盒子实时情况', '/boxrealinfo/list', '0', '', 'ba4f42e82ad14badaeb99cd4791770b8', '4', '2015-08-07 10:58:25', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('fe422eb3198e468ea84eba6a343afa92', '日志审计', '', '0', '', '', '8', '2015-08-18 16:50:33', 'superadmin', 'fa fa-book');
INSERT INTO `man_system_menu` VALUES ('69769a362947412caffaeb6b1fb4acd4', '操作日志', '/operlog/all', '0', '', 'fe422eb3198e468ea84eba6a343afa92', '1', '2015-08-18 16:51:31', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('a8cb182804804a8cb10495d37c3fbe7c', '登录管理', '', '0', '', '', '7', '2015-05-13 16:26:19', 'superadmin', 'fa fa-arrows');
INSERT INTO `man_system_menu` VALUES ('fa02fdc9b3004d5986ab4218606f27e2', '基本信息', '/transform/baseinfo/beforeupdateuser', '0', '', 'a8cb182804804a8cb10495d37c3fbe7c', '1', '2015-05-13 16:26:46', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('a6d8470d649e469a96eadab7f4ee723e', '修改密码', '/transform/updatepass/beforeupdatepassword', '0', '', 'a8cb182804804a8cb10495d37c3fbe7c', '2', '2015-05-13 16:26:55', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('473d53e02b644b889518a147582106c3', '端口资源池管理', '/portresourcepool/all', '0', '', 'e203749c741e4de3af03506b4397001c', '4', '2015-11-04 17:25:16', 'superadmin', '');
INSERT INTO `man_system_menu` VALUES ('8025fa0599324bcaa71be319c7444d36', '上传镜像地址管理', '/image_upload_address/all', '0', '', 'e203749c741e4de3af03506b4397001c', '12', '2015-12-16 15:24:43', '8a657f4639e84b7382e828057c90ec00', '');

-- ----------------------------
-- Table structure for `man_system_menuright`
-- ----------------------------
DROP TABLE IF EXISTS `man_system_menuright`;
CREATE TABLE `man_system_menuright` (
  `billid` varchar(32) NOT NULL COMMENT '主键',
  `rightid` varchar(32) DEFAULT NULL COMMENT '功能权限ID',
  `menuid` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`billid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_system_menuright
-- ----------------------------
INSERT INTO `man_system_menuright` VALUES ('27d85ed3d6194b80bcc5e3fe201ef173', '5c43901bdbe64f668c0ce9d89c9d0a98', '48e1b6902c08455abdeebfc06c6ed39a');
INSERT INTO `man_system_menuright` VALUES ('ae6e0b64e4714eb5b7e12081a2ca336b', 'faede2e9fbc940039388532046ecabec', '48e1b6902c08455abdeebfc06c6ed39a');
INSERT INTO `man_system_menuright` VALUES ('20d5c48d27694d4e9422be7d0b0e50bd', '72b235d689e84da2a3ebfab1a33cabed', '48e1b6902c08455abdeebfc06c6ed39a');
INSERT INTO `man_system_menuright` VALUES ('86acd0938c1e43ecadc515c86798712c', '346157dc12374226b98f5efff3c75f1d', '48e1b6902c08455abdeebfc06c6ed39a');
INSERT INTO `man_system_menuright` VALUES ('8115b58535a647ad9f46afa5a3e428aa', '86af3354931945cea7c1ca6cde252dca', '48e1b6902c08455abdeebfc06c6ed39a');
INSERT INTO `man_system_menuright` VALUES ('0ae7f436426345d7b2d2e8af7264823e', 'f39cb4857db84ad0b42043e999862194', '48e1b6902c08455abdeebfc06c6ed39a');
INSERT INTO `man_system_menuright` VALUES ('cbb19656b5f040cd9b18bf7892755d90', '283478a357934dc09fb29d93962e567b', '48e1b6902c08455abdeebfc06c6ed39a');
INSERT INTO `man_system_menuright` VALUES ('c860bdc0bb8649b89b9dddee25b0ff5d', '5fad4ab000504287a989ec89896f4c39', '31bf73d5a87f464595438de6fe9c365e');
INSERT INTO `man_system_menuright` VALUES ('b41fc855c6024ff1940bfad486cd1b71', 'd8f9f335ee15485daf40422496067121', '31bf73d5a87f464595438de6fe9c365e');
INSERT INTO `man_system_menuright` VALUES ('a7f4cc0a31bc46e386d8c5df2e9ad3f1', 'c0617bf3971f4a13baff3da046c46f03', '31bf73d5a87f464595438de6fe9c365e');
INSERT INTO `man_system_menuright` VALUES ('bd26183379d243d0a9b77ab9068e8f25', '7e50391f625c4f0da5e4a14c994a8a7a', '31bf73d5a87f464595438de6fe9c365e');
INSERT INTO `man_system_menuright` VALUES ('235a324566f94b99ad433c21f3270ccd', '6d1d59bbc4dc42a8ae45fb483e2cb174', 'e77e14cc46e54d969015491e43785304');
INSERT INTO `man_system_menuright` VALUES ('baa5a5be68474a06b455f406d787db34', '178f7a60edf940f19d7b2aaad1978605', 'e77e14cc46e54d969015491e43785304');
INSERT INTO `man_system_menuright` VALUES ('97b2b9a6e59c4a8ab1b617d97ef7d347', 'd21aeafd3a9b461ab6f690de229f3081', 'e77e14cc46e54d969015491e43785304');
INSERT INTO `man_system_menuright` VALUES ('c5157dfa86b245d89d7fb489192585df', 'ab519fb8b44442639f887dae58919214', 'e77e14cc46e54d969015491e43785304');
INSERT INTO `man_system_menuright` VALUES ('7c3eae2e712a4eadb93cfdb7ddd1b4d6', '964efea9602b462ca53389c8dd7a4b2e', 'e77e14cc46e54d969015491e43785304');
INSERT INTO `man_system_menuright` VALUES ('7a46d8e706f64e4da196bcb4f3857a03', 'a6141b3aedc846a2a23c8b53e9cac8ab', 'b8e302cd82fa40718ca2cfd7fe72684e');
INSERT INTO `man_system_menuright` VALUES ('7c26783c2fda451f911525b0fdec61f9', 'f568b71a4da24efb9497cbcff276ceeb', 'b8e302cd82fa40718ca2cfd7fe72684e');
INSERT INTO `man_system_menuright` VALUES ('e780b52117084164bd9d41e3b51dc79c', '1b637d0a8cbe41bea64d1a51e3c2860d', 'b8e302cd82fa40718ca2cfd7fe72684e');
INSERT INTO `man_system_menuright` VALUES ('960ea4aa3cf648ccb6a5f28c419f27df', 'ae8d349abf434484a10ded19c27cac12', 'b8e302cd82fa40718ca2cfd7fe72684e');
INSERT INTO `man_system_menuright` VALUES ('0b3869c32e4149bc94eba525d6d9a72a', '202f4514a4064c3298e2c4066f97e904', 'b8e302cd82fa40718ca2cfd7fe72684e');
INSERT INTO `man_system_menuright` VALUES ('d2b919b45fe246c4b89fcd5c4234cf99', '32141cc562994125bee6be9eb516a1a2', 'af3232443a8b4dc8b1ad1b99897e70bb');
INSERT INTO `man_system_menuright` VALUES ('069c8c910d9642139b40774b66694ef9', 'df76dcc9c71c493da0b4cc70cd44c9a5', 'af3232443a8b4dc8b1ad1b99897e70bb');
INSERT INTO `man_system_menuright` VALUES ('fc13c391d1e2490aa553c0e6585bfc38', '94c44e9ff3a844658a97c09b55162232', '144bdf779b0841ebb9f4a4a3b572e0ee');
INSERT INTO `man_system_menuright` VALUES ('e09453c750e54f6e9827ea491ee3bcae', '795f2725daaa4eacbf42ff0b0b61f1c4', '144bdf779b0841ebb9f4a4a3b572e0ee');
INSERT INTO `man_system_menuright` VALUES ('ced3bfd146d844b6b2cb2a2e948b22f6', '5a11b581ee1f4fce8716f40ca5ea308d', '144bdf779b0841ebb9f4a4a3b572e0ee');
INSERT INTO `man_system_menuright` VALUES ('6f86a47889a640d0b78ee90c4324f774', '1879047193f8442ea695525030d89fbe', '144bdf779b0841ebb9f4a4a3b572e0ee');
INSERT INTO `man_system_menuright` VALUES ('ef81fab918c144a093bbdfaab2c229ba', '9886acfc8d8c4ed38f66a18f46223dd0', '144bdf779b0841ebb9f4a4a3b572e0ee');
INSERT INTO `man_system_menuright` VALUES ('5c0d985cacba4102a7089d7f7ece0625', '725b1a12844148b2a1bec1488b7be33f', '144bdf779b0841ebb9f4a4a3b572e0ee');
INSERT INTO `man_system_menuright` VALUES ('9abaf6e727f74d589d4967b00809b82e', '54dff6650cb4414ea4f633a134f40a13', '48e1b6902c08455abdeebfc06c6ed39a');
INSERT INTO `man_system_menuright` VALUES ('f39fdb21211e41fe822c5af42e7a5a48', '6b10ac4e85484c6ab811f58595039a78', '31bf73d5a87f464595438de6fe9c365e');
INSERT INTO `man_system_menuright` VALUES ('8eedc9f977e44a66916f9e76d404dad1', '7ded595561314ba6b20cb091c8448799', '8d5cb01452224294bb41c8f80a63889a');
INSERT INTO `man_system_menuright` VALUES ('bf6689e7c9a14d30bfe9783d1ed482be', 'f52d3f6af13e47a99a27c85b0a29cb8e', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('035db663601f43168ca971f84eb17858', 'f2e86e0fdd20472c8e55622be24943dc', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('0f1aa346d0ca4bdd8fcaf59da9d5de79', '174a45b6405f4209a058d9391ded6a3c', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('45b81240f8624628a6112666e0e29fa7', '2112837c32aa4b75b092ea1df0b3efc4', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('db56a96f13394b6b9357c72ac27873d1', '67e947d10be442a19cabf12df54b9ee7', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('8a719ada74cd448ca816499bbee70576', '054bfba832404fef93c4c1a66f3d8d18', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('c9816f0392a94f76a468416e2cef42ca', 'fe98e63455694d5b95ebb24449a03434', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('2723ca8be2f745368d8f6961b3d81daf', '3e52bb2e56a74df5bbe72613ed2031b2', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('db0f5bdf09884c64ba80430215fd0674', '10100245cfe7409ca42fa8b300042e8e', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('5c55418d73534002a4160f1369c16d52', 'fe5ec96ffa264f35a32d17149abeeb25', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('c26337ae7fc9422b921ac03ff3c48b65', 'c9d87dfd307f4e9682c7c6882065d40f', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('6fc9bdf1abab46d0856577b0c363f904', '413f22902b9a48c0bc88daf9e861adc2', '59f6e91280924b628a9340415cd6bc6d');
INSERT INTO `man_system_menuright` VALUES ('437b928da59b460c8fd00bde8aa7932e', '19d734c1502444ff8cbddf7dd98b7ad2', '59f6e91280924b628a9340415cd6bc6d');
INSERT INTO `man_system_menuright` VALUES ('078d0a3bf4184206822ef23b77297399', 'baaa372a9aef495da4c3d360a679a1de', '59f6e91280924b628a9340415cd6bc6d');
INSERT INTO `man_system_menuright` VALUES ('a363a9c75ab145bb99575d9029e67457', '32f97a0e26ef407e93f7ff9044f7caa0', '9768223b00cc4cd59c076bb658226acf');
INSERT INTO `man_system_menuright` VALUES ('cab1a09aab0c43178f2d35edeadf50e7', 'b9bec728d5bd4ff785f3f9af1bae1088', '4b86b66ea33c47fb8bc46b6a8a346608');
INSERT INTO `man_system_menuright` VALUES ('f941816da2c64d3d99d3d41c14997ba4', 'f8a19e41522c4a6e98a800faa0bf7db4', '4b86b66ea33c47fb8bc46b6a8a346608');
INSERT INTO `man_system_menuright` VALUES ('4033170b87ed4922a4988c393da53a16', '446ebacd2add4fa994bfd8aefdd04ab9', '4b86b66ea33c47fb8bc46b6a8a346608');
INSERT INTO `man_system_menuright` VALUES ('67bd79b0552046e88292008cb9b845c9', 'cb98cb53e4824939bf9d946ca7a411ec', '4b86b66ea33c47fb8bc46b6a8a346608');
INSERT INTO `man_system_menuright` VALUES ('824d058edff34bc78a1e8d6216dcb8f3', 'e9f12ae18edf4e6a814ea12309bef0b5', '4b86b66ea33c47fb8bc46b6a8a346608');
INSERT INTO `man_system_menuright` VALUES ('5f4f280f9bbc4b7d889a40f7442cac5a', '6d2dc8b96c744cfdaef68fb155eab49e', '4b86b66ea33c47fb8bc46b6a8a346608');
INSERT INTO `man_system_menuright` VALUES ('4efb45d97e4547cfb20262b266676521', '04dc5168fd9248168117ade23abb4e0b', '15c851b13dae40e69a89fbe160cd9825');
INSERT INTO `man_system_menuright` VALUES ('4a734f1c30c040d3b19626e1f038339a', 'ecb376ddfbeb42ff9745896e733dc825', '15c851b13dae40e69a89fbe160cd9825');
INSERT INTO `man_system_menuright` VALUES ('5f4546b20fad476d9c73248fee71a7c0', '2dfecdbcdd324b419f06f745ee539d51', '15c851b13dae40e69a89fbe160cd9825');
INSERT INTO `man_system_menuright` VALUES ('b83c452da9ea4780924543a7127104e1', 'a217c57c0a384e23ac8e5f58114ec704', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('9b90c9b6ad804a7ba3682bfeac142f80', '5d98e0510da34e9985d0553052b471c4', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('c61646e75e964e7790cb90cd05807c03', '1101a5f030dc4f3c98609a0dc338ffcd', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('575e7e9b43f9455abece77af42dd2f7c', '525af5ca011142a0aee13d82731e8abb', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('7a1ac9d32d494bc694497b381ec772dc', '9c9c12ddd5dd453fac2f192ea573f0d3', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('e5726b2ea7e64375a5622813b9833ade', 'e6f721a93d03458b9627e55960907093', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('25a5502994844da99e95693c8cc6a615', '99beb0c7a9cc446685402198aec070e8', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('4246b0e7420b48e7a1c41f3820b8ab75', '56ac203a1d0f4efdb44307d450d6ccbf', '2c3698d8e89440fe908ddaa9f726044c');
INSERT INTO `man_system_menuright` VALUES ('3fa3ff08961f4ad0b02ef1bca41e45af', '72d747a0a7e34031a00986307f32a77e', 'd607aa7c9849470c9b6600a5058e74ea');
INSERT INTO `man_system_menuright` VALUES ('5c7f73726b2e4208865a8bac5072be37', 'e5b5caad68fc4ef78f527024823ff3b7', 'd607aa7c9849470c9b6600a5058e74ea');
INSERT INTO `man_system_menuright` VALUES ('061ce09270d44cb2a4b38724733a5b7d', '7c808148ec314071a471d9a346934edb', 'd315492ec49f480582b765ab765edba7');
INSERT INTO `man_system_menuright` VALUES ('f2e0ed6bf2874ab49607c82a2d075825', '8cb01c896ceb4958acc42ee8e2c75160', '523c6d9feeb744daa5481d1132739859');
INSERT INTO `man_system_menuright` VALUES ('347c7f01ba6e4a488b04fc13fa9e6883', '91f613d71c0248719bfda20d6078451f', '523c6d9feeb744daa5481d1132739859');
INSERT INTO `man_system_menuright` VALUES ('54201d4e753b4333919acff345f622ea', '96ef90d6924b4eada11ccfb6afffda12', '523c6d9feeb744daa5481d1132739859');
INSERT INTO `man_system_menuright` VALUES ('26503f063be94b9ebe1cfece6ba72436', '322c915e28d94b199a9812dfb1d0a1af', '523c6d9feeb744daa5481d1132739859');
INSERT INTO `man_system_menuright` VALUES ('8be7ef44f99c44fab874e458f89d4a08', '48ff985e27d747708d219b25d9a2c1a4', 'cb2fe5765f224d68aaa4d787177a2d31');
INSERT INTO `man_system_menuright` VALUES ('03b324eb5e7f43169a3c3b8c9955ddf0', '05e08abf5cc54451b726fcd3bdac6440', 'cb2fe5765f224d68aaa4d787177a2d31');
INSERT INTO `man_system_menuright` VALUES ('147ccb1833814416a36e915acd5a759a', '0e4dd7973dfe447ca10fd49a50e2f39b', 'cb2fe5765f224d68aaa4d787177a2d31');
INSERT INTO `man_system_menuright` VALUES ('73b0392d0f4444c3b8c2829eb599a1f2', '576580557619459690df93b28d5610fd', 'cb2fe5765f224d68aaa4d787177a2d31');
INSERT INTO `man_system_menuright` VALUES ('98a76b0d3cf14804a17ddeef5f3b7e66', 'df433f74debc40cea1dd0bae782ffeb3', 'cb2fe5765f224d68aaa4d787177a2d31');
INSERT INTO `man_system_menuright` VALUES ('51debb6e74a948f680857b50aa76720f', 'ef6a48aaf6974c21828c6b733a81e25b', '892905cc9ec34eb4bfc9abaf58cdb234');
INSERT INTO `man_system_menuright` VALUES ('743ce1e8ed204bb6934e1cc61432cfc1', 'b00a0f0a7df2480db8e68170bda70e5d', '892905cc9ec34eb4bfc9abaf58cdb234');
INSERT INTO `man_system_menuright` VALUES ('b07d38cda0804b20a7c109416fb053b8', 'ff9f60af71ea4cceb7f07e5f3a3210a6', '892905cc9ec34eb4bfc9abaf58cdb234');
INSERT INTO `man_system_menuright` VALUES ('cb4103d90dea4ec5872b2d2fd97a955f', '2a7525e411554d28bd497c5a2eb64b71', '892905cc9ec34eb4bfc9abaf58cdb234');
INSERT INTO `man_system_menuright` VALUES ('3297eea5b86b45ccbf9d99c48f22edd6', '31fd5f75e2624fce989ed84ccba0f391', '892905cc9ec34eb4bfc9abaf58cdb234');
INSERT INTO `man_system_menuright` VALUES ('dbf917e6b2c34483995266d496fbec5b', '0ab48c3205574859b3e6a32377c77b1a', '892905cc9ec34eb4bfc9abaf58cdb234');
INSERT INTO `man_system_menuright` VALUES ('2976d30ab2594d3ba58799f7786ee3cf', 'c94c5e54bbcd4170acea7550726b39f0', '892905cc9ec34eb4bfc9abaf58cdb234');
INSERT INTO `man_system_menuright` VALUES ('dd813985ed224c7eaf066e5b2cd73a49', 'bbb2324d766f4698aa724c1f7fe211fd', 'fa02fdc9b3004d5986ab4218606f27e2');
INSERT INTO `man_system_menuright` VALUES ('c8f0ca96b5244c5bb6d35f12585d06df', 'a3c5949c561b496c8ba0e0177515b2db', 'a6d8470d649e469a96eadab7f4ee723e');
INSERT INTO `man_system_menuright` VALUES ('22bf8e9a43584fc8a858d20ac33c2bb5', '5ffcbe16ff3644da851a1c024b0746d2', '9768223b00cc4cd59c076bb658226acf');
INSERT INTO `man_system_menuright` VALUES ('9227de8c750941e6bc339befe61cc3ca', 'f85cdcc5cf7847d4a7e83be1ae3cb44c', '9768223b00cc4cd59c076bb658226acf');
INSERT INTO `man_system_menuright` VALUES ('4c48d4511672497697ab1fa50e909901', 'fa4b8f5fcda9439a859ac735202e8190', '9768223b00cc4cd59c076bb658226acf');
INSERT INTO `man_system_menuright` VALUES ('0eccad20ee714847a9871dd4403e8294', '57362032eca142dd8d93c24b0cd681a5', '9768223b00cc4cd59c076bb658226acf');
INSERT INTO `man_system_menuright` VALUES ('091d53b7b19d479f8d9bee5f7e2d0398', 'b65f8696b7e645359459c880d6c9426b', '5a5757c77546493e827906240cb0d0ef');
INSERT INTO `man_system_menuright` VALUES ('4f3768d26d104a9eae28638d7b93f20b', '4bb1c4cda79440ceb4dee0de5923dd01', 'e6c99ddb1ddd4745aa45fbd535fbf553');
INSERT INTO `man_system_menuright` VALUES ('ae82ac3f264349d0aae347c6dae2a666', '2b81b384b4814db4badb1aa4d845e689', '54f3aaa54bf44502ad16193c16d34c73');
INSERT INTO `man_system_menuright` VALUES ('9165731848964c9f8f967510fd7f0a3e', 'd2611ddf35ca4c46bbf61e536ad66c0f', '54f3aaa54bf44502ad16193c16d34c73');
INSERT INTO `man_system_menuright` VALUES ('be26bd464ec541668d7765cf41559334', '15ef4db83a214046ae4c097fd0611612', '54f3aaa54bf44502ad16193c16d34c73');
INSERT INTO `man_system_menuright` VALUES ('9d3c523832a7446b8663e257042d08be', '5c019b45d3894a36a9dc9c3225afca52', 'af3232443a8b4dc8b1ad1b99897e70bb');
INSERT INTO `man_system_menuright` VALUES ('44dd50e94c2c4fb8bcb582524304d873', '50a89f6a952c463ead60858dfaa2e9b3', 'af3232443a8b4dc8b1ad1b99897e70bb');
INSERT INTO `man_system_menuright` VALUES ('b510ac7a647d4e60a1a1ed0db701dabd', '99a683848e0b4281acbc8635d8fff236', 'af3232443a8b4dc8b1ad1b99897e70bb');
INSERT INTO `man_system_menuright` VALUES ('41a9ee593a5a44809e8735388ca9b560', 'f0caa36f28fa44998cbb1ea5f8d6cfb1', 'af3232443a8b4dc8b1ad1b99897e70bb');
INSERT INTO `man_system_menuright` VALUES ('685560f315d94fb1a2d74175b6515b0d', 'd8d667f74aa04461b506604959a61bbe', 'af3232443a8b4dc8b1ad1b99897e70bb');
INSERT INTO `man_system_menuright` VALUES ('0834960811304fbf8c97701a912cf492', '7adf67673d9c441f96b1ac0664604ecd', 'af3232443a8b4dc8b1ad1b99897e70bb');
INSERT INTO `man_system_menuright` VALUES ('37597460a3e84c9e91e0d38ba80f81b1', '417416748bef4aabae6aa5a33283d6fd', 'af3232443a8b4dc8b1ad1b99897e70bb');
INSERT INTO `man_system_menuright` VALUES ('81bf9bd7e1ac4ba18fa567693a74fc72', '2d205294001b462dac6c498835495cc5', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('9326003d73ac4b1b80333cabb4c930d0', '5cb7e110f6e84e7bbb09ddc9c3406131', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('d959805e80f5448aa2338ae5a9878a19', 'e5e8f7ca99364510a819d0b24a17d3ef', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('44beb88c363f4c1f9ac49fe3e1dee2af', '1e563b75d3bc40a39fa87c635bb96b7c', 'af3232443a8b4dc8b1ad1b99897e70bb');
INSERT INTO `man_system_menuright` VALUES ('323c55533dd64bcfa467e78408e72447', 'cd90029c507a46288cb3dab122fe5a99', '8d5cb01452224294bb41c8f80a63889a');
INSERT INTO `man_system_menuright` VALUES ('9b68095748fa4558a565ccdb42687bcf', 'd746c6128e2a441d9cce1fbd03e99d7f', 'cb2fe5765f224d68aaa4d787177a2d31');
INSERT INTO `man_system_menuright` VALUES ('39379c11853941dab1b15df078bdd095', 'e340abc3fd4440d8bc3ce8f812d6444f', 'cba6d9e38a044a45b7d8b32245c24335');
INSERT INTO `man_system_menuright` VALUES ('b863fbeee36a4f9f9e991aae02451786', '89724babbda149a7a593f929e02dfdb8', 'd315492ec49f480582b765ab765edba7');
INSERT INTO `man_system_menuright` VALUES ('8f6ab43b2a20489f9cd590f774ab416a', '8bc17e445a5f499883dc904af3090271', 'c918a5eb0f0d4d1d9842ea30e11d69be');
INSERT INTO `man_system_menuright` VALUES ('7e17634880f74c5da2fcbc20dc006017', '80e5fe2926e642af88d9c372f872244c', '2606ee52b0b54595bb124dd4264f95cf');
INSERT INTO `man_system_menuright` VALUES ('a5de0f5d56aa48ceab7c8bf20635d7e6', 'acae2be888974a2b9f56d4406248978f', '2606ee52b0b54595bb124dd4264f95cf');
INSERT INTO `man_system_menuright` VALUES ('9d170269cae54897b497fc3e3fbb262b', 'a07c8a4bc20744bfb421f2932565a58a', '6d3fd494900f4cc0a595578539d061b2');
INSERT INTO `man_system_menuright` VALUES ('d9266812ec4b4aab8c0fc3e14cad7e4a', '22be649cfe8d4957b073fb29f8c760fb', '4bec936599af42b38dbcd002ded6ed2c');
INSERT INTO `man_system_menuright` VALUES ('d70401edeb424b58b1ee18303ff87505', 'c6e51e318e4b4e40a5178fde4fb34fe4', 'e2421762e21248da9fa3d387855ea789');
INSERT INTO `man_system_menuright` VALUES ('048a4721a4be4853a938664d4f9cedfd', 'f015b3e302cc4d5c95e55352b5889ea7', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('1233ee1d3630413a825c33d149ad21af', 'cc83f0cbaadb4df4a2e23b0a6542a76e', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('0f5342f21e514e18b814897caa2d6cb6', '9736ec8c6ef845539cf43a805eeb0ff5', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('74d41b1a9cf24b0c8100d3065fa5a571', '96d7b25b175d4a449b8f003885bee83b', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('7e65e95a62eb45a69f8dd5c62c7ae1d6', 'dca0cdc16c3b4569b7f352a39746b3d1', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('45246f1b2497480eb9aa55235acae902', '93296cf76664425c872611c07ce3a495', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('0449d37212ae44d5928e222225c3f0e9', '7f75f02fcb2748fb88c863a93b722f61', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('d67f0260ccd54d959a40c4806bda4ad1', 'fc9c749ec4a249518c0df349727ce2c7', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('78320bbf7c30421c869f4bb2741c6f49', 'b5652eefc7f6424abdc18105eb4c3417', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('6b9c34dbdb2a49d2b80dfe90381990d4', 'db2d66544baa4343ad66dfe4a1e74c17', '35f20ca9ec6549588846c42203021515');
INSERT INTO `man_system_menuright` VALUES ('196d5ed4a8634fb39e24ddb523579407', '666f5c429dd44e7ba40ba88e93af3dbf', '35f20ca9ec6549588846c42203021515');
INSERT INTO `man_system_menuright` VALUES ('ad4f8a0ddf41438e9b81924ae46c1f91', '47372ce4d3994f31b8eb5b340c854ad6', '35f20ca9ec6549588846c42203021515');
INSERT INTO `man_system_menuright` VALUES ('dd0f046de60e4b0a85001ffb14f50a20', '02451e999a704cc6abbf848398bc2179', '35f20ca9ec6549588846c42203021515');
INSERT INTO `man_system_menuright` VALUES ('fd002f07ba014fa582bf1460be15674e', '76387096f41c48ab9e05690ae5845778', 'e323828636cc48c9b8a8ac5f7cc62720');
INSERT INTO `man_system_menuright` VALUES ('86095f74ecb541d987cb4b820f7bfdef', '689f66fe61d44e149db93fea869ea4f9', '8d5cb01452224294bb41c8f80a63889a');
INSERT INTO `man_system_menuright` VALUES ('844203076694407ba86fb907812c3831', '7ed0d74a704944fc9c2296732dbf313a', '8d5cb01452224294bb41c8f80a63889a');
INSERT INTO `man_system_menuright` VALUES ('d3684474805a4554915a6ece8d2d561b', 'ad696cf1cd87410db7f850972d5891f3', '8d5cb01452224294bb41c8f80a63889a');
INSERT INTO `man_system_menuright` VALUES ('3dd91d306de1477da98540f5ac9605cf', '9ffd8eac54ac4c5fad0a080bb0b1d8af', 'cb2fe5765f224d68aaa4d787177a2d31');
INSERT INTO `man_system_menuright` VALUES ('4f2049ec601547a69e89aab5698ab1a5', 'a8d0806bb00d4c789bf635b2d728408f', '2c3698d8e89440fe908ddaa9f726044c');
INSERT INTO `man_system_menuright` VALUES ('9e51308c83d44cbaad41d40349d29fc6', '81ccfdf56ae448639722beeea69c60d9', '2c3698d8e89440fe908ddaa9f726044c');
INSERT INTO `man_system_menuright` VALUES ('623430e7ee35484cb8840f0da717b3ec', '75e8c259de624d8ea76ca4891b5708ff', 'c918a5eb0f0d4d1d9842ea30e11d69be');
INSERT INTO `man_system_menuright` VALUES ('0cb9e59a63d24f0198ce440feac976df', 'a46e31c1b54742d78fa04776353a3bec', 'c918a5eb0f0d4d1d9842ea30e11d69be');
INSERT INTO `man_system_menuright` VALUES ('f571d79fcfc54a09be9394af7c323c4b', '82bdce3798b5425fb69504cc63198746', 'f988de5af8394f70aca1300fbb161fdb');
INSERT INTO `man_system_menuright` VALUES ('b6f58749f0c04a3eb3adf107adab71c8', 'b438319e58524ee8b65682d88f3efa32', 'f988de5af8394f70aca1300fbb161fdb');
INSERT INTO `man_system_menuright` VALUES ('129d4c6982664ee39f24bcdf25e02400', '1a47f37ab63a48fab21d1370988e4599', 'f988de5af8394f70aca1300fbb161fdb');
INSERT INTO `man_system_menuright` VALUES ('82b03ca2281d4240b952c013560fe28a', 'abd4636cfb57415b9461e8d12576761a', 'f988de5af8394f70aca1300fbb161fdb');
INSERT INTO `man_system_menuright` VALUES ('4a2e805d8a2b418491244fc26bfddb45', '6ae3ff26e64b4ebfb3f465aa45a2d6e0', 'f988de5af8394f70aca1300fbb161fdb');
INSERT INTO `man_system_menuright` VALUES ('3e776ce8251446bf94ae5b0ad59a1b4f', '7a9412dc6cbf4e46ba4de8e0f6bffd5e', 'f988de5af8394f70aca1300fbb161fdb');
INSERT INTO `man_system_menuright` VALUES ('46764afac1a44b01a0d3c27fc484ceb6', 'ed5942c478024b83b2bfd8df0e318159', 'f988de5af8394f70aca1300fbb161fdb');
INSERT INTO `man_system_menuright` VALUES ('16410abfa4be490ba7cccc794b827f8a', '0a277a91aabc4b93bdcb790424d17fa0', 'f988de5af8394f70aca1300fbb161fdb');
INSERT INTO `man_system_menuright` VALUES ('129221491af3479395feac9833f9cc2a', '6242e4cd98bb452ab4afd721b63435ca', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('3fe18920b0a6405ca646474cbbd8a4e0', '0dfb50c5926e410083e0a2aae18fb684', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('72478a6b4d824c008ff4020df2c77085', '24ed1bbb1a7f4cbc97e86b096bee0525', 'af3232443a8b4dc8b1ad1b99897e70bb');
INSERT INTO `man_system_menuright` VALUES ('4ea5adb1d6c24ecbab1240e2bdfb8894', '5b1a51e8b79c4edb87fcbe0b1e4bd708', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('170c73c8b4e44a63b896061a407c35d2', '18dc5e4dace54e12924fd8430a3c3c9f', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('c083e743f4dd4925b3de03e7b509b705', '99d22f72650a4b178a6231054e951f55', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('818c807b961a481e8b5dd54877880114', 'db55d589eac24c8fad369d6fc01dbd26', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('14ee53da45fb41379f77aeb6c9181f02', '448f9c05f8484731b57cacf5b53c1a13', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('9c0e19d958174843878d36fc04386818', '10d8fa08979a49f1879d056e2cbe27e0', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('98720df019f84dd6b7ee85e5871687dd', '0b9d75ac797c4eae87658c1867dcafb8', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('916428a0e11546c195fd98d6e07d989b', 'd06ee02c1fc3498ba10309c1d74a128e', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('e02bee6d70f249f587427f729fa7286f', '6ef7917106b0460c9fcbe7345db9de2a', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('45c30f4c134c4a519ae550906543c73b', 'c8bbed2b94784752b6b5f67c4937a9e7', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('79b222398fd74f61bfd2ad23f72dabff', '55ee2d629a6d4191b5eb0f08a8796dc0', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('6bbd5e339a754926bcd514ab3e661aa8', '2f11bb1c8c3342868ee93d3acccd813a', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('ba6c87f925e94474b348a0434cf89055', 'b4c8f52b81be4ea0a85f136a26ec597d', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('4aa765fe44cb4615944caa8e84080e3c', '96bc6b139372441b8456a0d255dbb5ca', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('b9c39d9a588c4ee88c52322d9c1d9d91', '46510ac45c4c423aa9c0655026652a9c', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('78bbc1eefa654c218ca86e0a34be657d', 'c3c03501f6bb4bccb6f6bfff4651bacc', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('9126869e17be40d8a96b56e55d621c4b', '217281846f0f4fcc818cc81fb9bbbfd3', '8cef1134437f4cabad4fd28879adf344');
INSERT INTO `man_system_menuright` VALUES ('fe8be30b8f3d4e8792b692808ea162c7', 'c3dc81b82ae34e9a8a05d0d00b519516', '8cef1134437f4cabad4fd28879adf344');
INSERT INTO `man_system_menuright` VALUES ('4128d384e0fc4fb29d8040688a56c595', '520f211ff9aa42969b20d76d9eee4f98', '8cef1134437f4cabad4fd28879adf344');
INSERT INTO `man_system_menuright` VALUES ('6717ccb7e6344ad59f1d7fe69d92f104', '4f72edd47ab7413bae2cc49ea9c4c901', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('0a3d9982e04c4664b561d8bf7994af9c', '697dd6649227483694dabaa4c394b609', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('6b5272777ab345038563e644514532e8', '2a9dd69254094a31b1bd86281024c43b', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('8c81175884764de393519eccc4073168', 'b41b81ba3ad64d7f8e6bd47930376763', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('ce287a2c8e5841f09f2219f423f6dd54', 'cf07ab7dff4a49fdbac21fa7acba1a36', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('6b8f9fc2144d448f9ba566256f3d3fbb', '0ddbcc8d592a4a1dac8839dd5c17fa50', '5a5757c77546493e827906240cb0d0ef');
INSERT INTO `man_system_menuright` VALUES ('090bfb94d2374f1ead64faf147677757', 'b8294cc396864c9a8a9bcb07c6437444', '473d53e02b644b889518a147582106c3');
INSERT INTO `man_system_menuright` VALUES ('5994d92b3ffe43daafd474978a85b9d7', 'a83adbb9f9234f019b80da106c9faab2', '473d53e02b644b889518a147582106c3');
INSERT INTO `man_system_menuright` VALUES ('ae8f7a6ec7c24dd8be8ad2aa90218a59', '10774c546ce8435cbcc7067f9d81b383', '473d53e02b644b889518a147582106c3');
INSERT INTO `man_system_menuright` VALUES ('9942e0f732e142d49740bb7887cedd5c', 'bc80e6eb9df941f6a05d123893d4a6df', '473d53e02b644b889518a147582106c3');
INSERT INTO `man_system_menuright` VALUES ('a1b2d7f71e324c018055f5c3760548d0', '691dfda1d01d4fe5991cca31451b2114', '473d53e02b644b889518a147582106c3');
INSERT INTO `man_system_menuright` VALUES ('a72adc98448040fda164ff572e1ffbe9', 'dfe6c84b78034076ad8d2f1b674aad85', '473d53e02b644b889518a147582106c3');
INSERT INTO `man_system_menuright` VALUES ('06b592ef8036410c83ab457bd492ba26', '4d8ca3376f7549f38dea72db1391160d', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('ba6d42f50cf44821a10727c99e6d9dd7', 'a639de8dbea74a44afd4dc7408c528da', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('d26d30f563484b3c870b91072d3403ee', '1c565e49fddb4620862bf7f2ff43f6ad', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('2d61077f51ac4007bbdbd41cb66fce1d', '4a4c88a543c944808d78a778c6548931', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('f660e0a730744fffb8332fc6e63e66b9', '4cd5c7ae44874141a1e6f882c1904efb', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('ba61c72a5c744ef980401e879dc2fa27', 'd6f3cecf68594026a540fb1b9892d662', '1ed4c45cecaf4032b1036445fca49434');
INSERT INTO `man_system_menuright` VALUES ('f08467b57362487391e904dcbe02bb6d', 'a9447e00efd747a3b99d96031960fa58', '1ed4c45cecaf4032b1036445fca49434');
INSERT INTO `man_system_menuright` VALUES ('c2beab3473bb4f19b652d0fa9143e05b', '93725cd38fe34937ae7cad3adece5d8e', '1ed4c45cecaf4032b1036445fca49434');
INSERT INTO `man_system_menuright` VALUES ('5df9104a35484c64a245e271b2cf2fc8', '38fb8471e60c4c67a240932cda8b2348', '1ed4c45cecaf4032b1036445fca49434');
INSERT INTO `man_system_menuright` VALUES ('6ceba33e9c564d64a06f31cdee38a20b', 'a14617acbe8742ad9b9ef096b37be865', '1ed4c45cecaf4032b1036445fca49434');
INSERT INTO `man_system_menuright` VALUES ('c598a41e967a44e18d47c94f42bb2061', '2ca3f7e3d3f6471e923961eb0004d2d4', 'c295224601b146c19499801cb079b7c3');
INSERT INTO `man_system_menuright` VALUES ('1d28c44ee02049c8bf43211491a863b3', '3d2e7e3f573e46ebaf1df371c00ef819', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('148ee1d135f1405cafc51d48523dc33c', 'c8224ebaea954e0daaa618c2d5e1afd2', '810c22a1ac794dc5acc9e2f549bd3026');
INSERT INTO `man_system_menuright` VALUES ('0902e8f5d96340a9bbd81717eb2e2bd2', 'fbf3be2225524c808c264c04daab57ed', '810c22a1ac794dc5acc9e2f549bd3026');
INSERT INTO `man_system_menuright` VALUES ('e9d0dc064d5a4612a4ffd3a98c417ac1', 'f90c9c3fdc6e4d4896233bd61f995ea6', '810c22a1ac794dc5acc9e2f549bd3026');
INSERT INTO `man_system_menuright` VALUES ('b75cb8bb2a304e67b7b889bd101114dd', '224c8141e35a4d36ad199f222d7098c9', '810c22a1ac794dc5acc9e2f549bd3026');
INSERT INTO `man_system_menuright` VALUES ('523f16c1c32e4412a9b93c6763e332ac', 'df7882a453754fdca9c2b889f2af3573', 'b87b6f0fa2594abea67eaffd0296d016');
INSERT INTO `man_system_menuright` VALUES ('fa0dc791f71c4e39aa7f758ccf09e9cf', 'd950bcd4843047ae9d3caa0476566b16', 'b87b6f0fa2594abea67eaffd0296d016');
INSERT INTO `man_system_menuright` VALUES ('96592d96dab2444d9b820d30aaa00eeb', '42b60ff9857f45988e5f75f006b75374', 'b87b6f0fa2594abea67eaffd0296d016');
INSERT INTO `man_system_menuright` VALUES ('74243d8c5a9a44a8adf51e382da6fa08', '32fdcefadd034f21b320add993fabd63', 'b87b6f0fa2594abea67eaffd0296d016');
INSERT INTO `man_system_menuright` VALUES ('faee5ca5ffca4d6aad7285fc74c159cc', 'de77045af1634dbb9f5fda0b426d76d1', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('d5991d4db81e451fa4036c2f25dc51a4', '380be447d80842c48e85778ea0119d3b', '857088edb2274a999c27abf183ad20cb');
INSERT INTO `man_system_menuright` VALUES ('4cda1ec51e5c473a9400630e4e7d1776', 'c103304b19e54157b59aa95f98a91f5e', '759959f6b369499e91432a4043d4dc38');
INSERT INTO `man_system_menuright` VALUES ('86f62dd22db44d7385eb183ec2471937', '8eab6f0754f5448280ff48101e14d0f3', '15c851b13dae40e69a89fbe160cd9825');
INSERT INTO `man_system_menuright` VALUES ('e1bce956a16d4fbdb858c7b62754586e', 'd07e373785f34c71aa9ec20d1c927a2c', '9768223b00cc4cd59c076bb658226acf');
INSERT INTO `man_system_menuright` VALUES ('5b471cb1e99d4e5ebc29c13c46211cf2', 'fa8fcd254ca8495fbc82f4f28bc685aa', '8025fa0599324bcaa71be319c7444d36');
INSERT INTO `man_system_menuright` VALUES ('d7d14691544d490cb47f7a3cc5fc6b37', 'ab9dbd62408c445e91b048231eff5597', '8025fa0599324bcaa71be319c7444d36');
INSERT INTO `man_system_menuright` VALUES ('02576cd16bd4449f88d6592e6d19bb95', 'cffb5982df074d0b9c2e2ba38c73f5b8', '8025fa0599324bcaa71be319c7444d36');
INSERT INTO `man_system_menuright` VALUES ('607347906f5a4a4cb282b3b6dc20740a', '7f435f2c6bb7495fb1425ca32e99b7d8', '8025fa0599324bcaa71be319c7444d36');

-- ----------------------------
-- Table structure for `man_system_right`
-- ----------------------------
DROP TABLE IF EXISTS `man_system_right`;
CREATE TABLE `man_system_right` (
  `billid` varchar(32) NOT NULL COMMENT '主键',
  `code` varchar(100) DEFAULT NULL COMMENT '编码',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `insert_date` datetime DEFAULT NULL COMMENT '创建日期',
  `insert_user` varchar(32) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`billid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_system_right
-- ----------------------------
INSERT INTO `man_system_right` VALUES ('5c43901bdbe64f668c0ce9d89c9d0a98', 'transform_user_add', '用户管理新增', '2015-05-14 09:33:44', 'superadmin');
INSERT INTO `man_system_right` VALUES ('faede2e9fbc940039388532046ecabec', 'transform_user_modify', '用户管理修改', '2015-05-14 09:33:56', 'superadmin');
INSERT INTO `man_system_right` VALUES ('72b235d689e84da2a3ebfab1a33cabed', 'transform_user_delete', '用户管理删除', '2015-05-14 09:34:04', 'superadmin');
INSERT INTO `man_system_right` VALUES ('5fad4ab000504287a989ec89896f4c39', 'transform_role_add', '角色管理新增', '2015-05-14 09:34:15', 'superadmin');
INSERT INTO `man_system_right` VALUES ('d8f9f335ee15485daf40422496067121', 'transform_role_modify', '角色管理修改', '2015-05-14 09:34:25', 'superadmin');
INSERT INTO `man_system_right` VALUES ('c0617bf3971f4a13baff3da046c46f03', 'transform_role_delete', '角色管理删除', '2015-05-14 09:34:32', 'superadmin');
INSERT INTO `man_system_right` VALUES ('d21aeafd3a9b461ab6f690de229f3081', 'transform_group_add', '角色组管理新增', '2015-05-14 09:34:42', 'superadmin');
INSERT INTO `man_system_right` VALUES ('6d1d59bbc4dc42a8ae45fb483e2cb174', 'transform_group_modify', '角色组管理修改', '2015-05-14 09:34:50', 'superadmin');
INSERT INTO `man_system_right` VALUES ('178f7a60edf940f19d7b2aaad1978605', 'transform_group_delete', '角色组管理删除', '2015-05-14 09:34:59', 'superadmin');
INSERT INTO `man_system_right` VALUES ('1b637d0a8cbe41bea64d1a51e3c2860d', 'transform_menu_add', '功能菜单维护新增', '2015-05-14 09:35:31', 'superadmin');
INSERT INTO `man_system_right` VALUES ('a6141b3aedc846a2a23c8b53e9cac8ab', 'transform_menu_modify', '功能菜单维护修改', '2015-05-14 09:35:41', 'superadmin');
INSERT INTO `man_system_right` VALUES ('f568b71a4da24efb9497cbcff276ceeb', 'transform_menu_delete', '功能菜单维护删除', '2015-05-14 09:35:54', 'superadmin');
INSERT INTO `man_system_right` VALUES ('322c915e28d94b199a9812dfb1d0a1af', 'transform_right_add', '功能权限维护新增', '2015-05-14 09:36:12', 'superadmin');
INSERT INTO `man_system_right` VALUES ('96ef90d6924b4eada11ccfb6afffda12', 'transform_right_modify', '功能权限维护修改', '2015-05-14 09:36:49', 'superadmin');
INSERT INTO `man_system_right` VALUES ('91f613d71c0248719bfda20d6078451f', 'transform_right_delete', '功能权限维护删除', '2015-05-14 09:36:57', 'superadmin');
INSERT INTO `man_system_right` VALUES ('346157dc12374226b98f5efff3c75f1d', 'transform_user_query', '用户管理查询', '2015-05-14 09:37:14', 'superadmin');
INSERT INTO `man_system_right` VALUES ('7e50391f625c4f0da5e4a14c994a8a7a', 'transform_role_query', '角色管理查询', '2015-05-14 09:37:20', 'superadmin');
INSERT INTO `man_system_right` VALUES ('ab519fb8b44442639f887dae58919214', 'transform_group_query', '角色组管理查询', '2015-05-14 09:37:37', 'superadmin');
INSERT INTO `man_system_right` VALUES ('ae8d349abf434484a10ded19c27cac12', 'transform_menu_query', '功能菜单维护查询', '2015-05-14 09:38:07', 'superadmin');
INSERT INTO `man_system_right` VALUES ('8cb01c896ceb4958acc42ee8e2c75160', 'transform_right_query', '功能权限维护查询', '2015-05-14 09:38:17', 'superadmin');
INSERT INTO `man_system_right` VALUES ('6b10ac4e85484c6ab811f58595039a78', 'transform_role_setright', '角色管理设置权限', '2015-05-19 16:49:51', 'superadmin');
INSERT INTO `man_system_right` VALUES ('964efea9602b462ca53389c8dd7a4b2e', 'transform_group_setright', '角色组管理设置权限', '2015-05-19 17:18:13', 'superadmin');
INSERT INTO `man_system_right` VALUES ('86af3354931945cea7c1ca6cde252dca', 'transform_user_changepassword', '用户管理修改密码', '2015-05-21 15:13:31', 'superadmin');
INSERT INTO `man_system_right` VALUES ('f39cb4857db84ad0b42043e999862194', 'transform_user_resetpassword', '用户管理重置密码', '2015-05-28 15:45:05', 'superadmin');
INSERT INTO `man_system_right` VALUES ('283478a357934dc09fb29d93962e567b', 'transform_user_setstatus', '用户管理设置状态权限', '2015-06-02 15:00:10', 'superadmin');
INSERT INTO `man_system_right` VALUES ('54dff6650cb4414ea4f633a134f40a13', 'transform_user_setusbstatus', '用户管理设置USB权限', '2015-06-02 15:00:35', 'superadmin');
INSERT INTO `man_system_right` VALUES ('02451e999a704cc6abbf848398bc2179', 'desktop_type_query', '桌面云主机配置查询', '2015-06-04 17:32:06', 'superadmin');
INSERT INTO `man_system_right` VALUES ('47372ce4d3994f31b8eb5b340c854ad6', 'desktop_type_add', '桌面云主机配置新增', '2015-06-04 17:32:29', 'superadmin');
INSERT INTO `man_system_right` VALUES ('666f5c429dd44e7ba40ba88e93af3dbf', 'desktop_type_modify', '桌面云主机配置修改', '2015-06-04 17:32:53', 'superadmin');
INSERT INTO `man_system_right` VALUES ('db2d66544baa4343ad66dfe4a1e74c17', 'desktop_type_delete', '桌面云主机配置删除', '2015-06-04 17:34:47', 'superadmin');
INSERT INTO `man_system_right` VALUES ('32f97a0e26ef407e93f7ff9044f7caa0', 'desktop_image_query', '桌面云镜像查询', '2015-06-04 17:35:15', 'superadmin');
INSERT INTO `man_system_right` VALUES ('5ffcbe16ff3644da851a1c024b0746d2', 'desktop_image_add', '桌面云镜像新增', '2015-06-04 17:35:54', 'superadmin');
INSERT INTO `man_system_right` VALUES ('f85cdcc5cf7847d4a7e83be1ae3cb44c', 'desktop_image_modify', '桌面云镜像修改', '2015-06-04 17:36:11', 'superadmin');
INSERT INTO `man_system_right` VALUES ('fa4b8f5fcda9439a859ac735202e8190', 'desktop_image_delete', '桌面云镜像删除', '2015-06-04 17:36:38', 'superadmin');
INSERT INTO `man_system_right` VALUES ('f52d3f6af13e47a99a27c85b0a29cb8e', 'desktop_warehouse_query', '桌面云仓库查询', '2015-06-04 17:37:15', 'superadmin');
INSERT INTO `man_system_right` VALUES ('f2e86e0fdd20472c8e55622be24943dc', 'desktop_warehouse_add', '桌面云仓库新增', '2015-06-04 17:37:36', 'superadmin');
INSERT INTO `man_system_right` VALUES ('174a45b6405f4209a058d9391ded6a3c', 'desktop_warehouse_modify', '桌面云仓库修改', '2015-06-04 17:37:59', 'superadmin');
INSERT INTO `man_system_right` VALUES ('2112837c32aa4b75b092ea1df0b3efc4', 'desktop_warehouse_delete', '桌面云仓库删除', '2015-06-04 17:38:28', 'superadmin');
INSERT INTO `man_system_right` VALUES ('67e947d10be442a19cabf12df54b9ee7', 'desktop_warehouse_detail', '桌面云仓库详情', '2015-06-04 17:38:46', 'superadmin');
INSERT INTO `man_system_right` VALUES ('054bfba832404fef93c4c1a66f3d8d18', 'desktop_warehouse_add_host_amount', '桌面云增加仓库库存', '2015-06-04 17:39:09', 'superadmin');
INSERT INTO `man_system_right` VALUES ('fe98e63455694d5b95ebb24449a03434', 'desktop_warehouse_allocate', '桌面云仓库分配', '2015-06-04 17:39:25', 'superadmin');
INSERT INTO `man_system_right` VALUES ('3e52bb2e56a74df5bbe72613ed2031b2', 'desktop_warehouse_host_allocate', '桌面云仓库主机分配', '2015-06-04 17:39:42', 'superadmin');
INSERT INTO `man_system_right` VALUES ('10100245cfe7409ca42fa8b300042e8e', 'desktop_warehouse_host_start', '桌面云仓库主机开机', '2015-06-04 17:40:03', 'superadmin');
INSERT INTO `man_system_right` VALUES ('fe5ec96ffa264f35a32d17149abeeb25', 'desktop_warehouse_host_stop', '桌面云仓库主机关机', '2015-06-04 17:40:24', 'superadmin');
INSERT INTO `man_system_right` VALUES ('c9d87dfd307f4e9682c7c6882065d40f', 'desktop_warehouse_host_shut_down', '桌面云仓库主机强制关机', '2015-06-04 17:40:44', 'superadmin');
INSERT INTO `man_system_right` VALUES ('a217c57c0a384e23ac8e5f58114ec704', 'desktop_warehouse_host_restart', '桌面云主机重启', '2015-06-04 17:41:02', 'superadmin');
INSERT INTO `man_system_right` VALUES ('5d98e0510da34e9985d0553052b471c4', 'desktop_warehouse_host_delete', '桌面云主机删除', '2015-06-04 17:41:18', 'superadmin');
INSERT INTO `man_system_right` VALUES ('1101a5f030dc4f3c98609a0dc338ffcd', 'desktop_warehouse_host_detail', '桌面云主机详情', '2015-06-04 17:41:37', 'superadmin');
INSERT INTO `man_system_right` VALUES ('1879047193f8442ea695525030d89fbe', 'desktop_group_query', '桌面云群组查询', '2015-06-04 17:42:23', 'superadmin');
INSERT INTO `man_system_right` VALUES ('5a11b581ee1f4fce8716f40ca5ea308d', 'desktop_group_add', '桌面云群组新增', '2015-06-04 17:42:43', 'superadmin');
INSERT INTO `man_system_right` VALUES ('795f2725daaa4eacbf42ff0b0b61f1c4', 'desktop_group_modify', '桌面云群组修改', '2015-06-04 17:43:15', 'superadmin');
INSERT INTO `man_system_right` VALUES ('94c44e9ff3a844658a97c09b55162232', 'desktop_group_delete', '桌面云群组删除', '2015-06-04 17:43:33', 'superadmin');
INSERT INTO `man_system_right` VALUES ('9886acfc8d8c4ed38f66a18f46223dd0', 'desktop_group_member_manage', '桌面云群组成员管理', '2015-06-04 17:43:53', 'superadmin');
INSERT INTO `man_system_right` VALUES ('725b1a12844148b2a1bec1488b7be33f', 'desktop_group_member_modify', '桌面云群组成员修改', '2015-06-04 17:45:17', 'superadmin');
INSERT INTO `man_system_right` VALUES ('32141cc562994125bee6be9eb516a1a2', 'desktop_user_query', '桌面云用户查询', '2015-06-04 17:45:34', 'superadmin');
INSERT INTO `man_system_right` VALUES ('df76dcc9c71c493da0b4cc70cd44c9a5', 'desktop_user_upload_excel_add_users', '桌面云用户Excel导入', '2015-06-04 17:46:08', 'superadmin');
INSERT INTO `man_system_right` VALUES ('5c019b45d3894a36a9dc9c3225afca52', 'desktop_user_modify', '桌面云用户修改', '2015-06-04 17:46:46', 'superadmin');
INSERT INTO `man_system_right` VALUES ('50a89f6a952c463ead60858dfaa2e9b3', 'desktop_user_delete', '桌面云删除用户', '2015-06-04 17:47:08', 'superadmin');
INSERT INTO `man_system_right` VALUES ('99a683848e0b4281acbc8635d8fff236', 'desktop_user_allocate_host', '桌面云用户分配主机', '2015-06-04 17:47:37', 'superadmin');
INSERT INTO `man_system_right` VALUES ('f0caa36f28fa44998cbb1ea5f8d6cfb1', 'desktop_user_reset_password', '桌面云重置用户密码', '2015-06-04 17:47:59', 'superadmin');
INSERT INTO `man_system_right` VALUES ('d8d667f74aa04461b506604959a61bbe', 'desktop_user_modify_usb', '桌面云修改用户USB', '2015-06-04 17:48:16', 'superadmin');
INSERT INTO `man_system_right` VALUES ('7adf67673d9c441f96b1ac0664604ecd', 'desktop_user_modify_status', '桌面云修改用户状态', '2015-06-04 17:48:43', 'superadmin');
INSERT INTO `man_system_right` VALUES ('417416748bef4aabae6aa5a33283d6fd', 'desktop_user_detail', '桌面云查看用户详情', '2015-06-04 17:48:57', 'superadmin');
INSERT INTO `man_system_right` VALUES ('baaa372a9aef495da4c3d360a679a1de', 'desktop_terminal_version_query', '盒子固件升级版本查询', '2015-06-04 17:49:15', 'superadmin');
INSERT INTO `man_system_right` VALUES ('19d734c1502444ff8cbddf7dd98b7ad2', 'desktop_terminal_version_add', '盒子固件升级版本新增', '2015-06-04 17:49:36', 'superadmin');
INSERT INTO `man_system_right` VALUES ('413f22902b9a48c0bc88daf9e861adc2', 'desktop_terminal_version_delete', '盒子固件升级版本删除', '2015-06-04 17:49:53', 'superadmin');
INSERT INTO `man_system_right` VALUES ('202f4514a4064c3298e2c4066f97e904', 'transform_menu_right', '功能菜单设置权限', '2015-06-05 10:46:31', 'superadmin');
INSERT INTO `man_system_right` VALUES ('57362032eca142dd8d93c24b0cd681a5', 'desktop_image_type_modify', '桌面云镜像修改用途', '2015-06-18 18:11:59', 'superadmin');
INSERT INTO `man_system_right` VALUES ('b9bec728d5bd4ff785f3f9af1bae1088', 'terminal_box_query', '终端盒子查询', '2015-06-24 09:22:28', 'superadmin');
INSERT INTO `man_system_right` VALUES ('6d2dc8b96c744cfdaef68fb155eab49e', 'terminal_box_modify', '终端盒子修改', '2015-06-24 20:08:25', 'superadmin');
INSERT INTO `man_system_right` VALUES ('e9f12ae18edf4e6a814ea12309bef0b5', 'terminal_box_add', '新增终端盒子', '2015-06-24 20:08:43', 'superadmin');
INSERT INTO `man_system_right` VALUES ('cb98cb53e4824939bf9d946ca7a411ec', 'terminal_box_delete', '终端盒子删除', '2015-06-24 20:09:03', 'superadmin');
INSERT INTO `man_system_right` VALUES ('446ebacd2add4fa994bfd8aefdd04ab9', 'terminal_box_allocate', '终端盒子分配', '2015-06-24 20:09:25', 'superadmin');
INSERT INTO `man_system_right` VALUES ('f8a19e41522c4a6e98a800faa0bf7db4', 'terminal_box_release', '终端盒子回收', '2015-06-24 20:09:40', 'superadmin');
INSERT INTO `man_system_right` VALUES ('a14617acbe8742ad9b9ef096b37be865', 'shared_memory_available', '共享存储设为可用', '2015-11-20 10:18:09', 'superadmin');
INSERT INTO `man_system_right` VALUES ('3d2e7e3f573e46ebaf1df371c00ef819', 'desktop_warehouse_host_update_displayname', '修改仓库主机显示名', '2015-11-20 14:46:49', 'superadmin');
INSERT INTO `man_system_right` VALUES ('224c8141e35a4d36ad199f222d7098c9', 'blacklist_manage', '黑名单管理', '2015-12-11 11:29:48', 'superadmin');
INSERT INTO `man_system_right` VALUES ('f015b3e302cc4d5c95e55352b5889ea7', 'desktop_resource_pool_query', '云桌面资源池管理', '2015-07-13 15:24:04', 'superadmin');
INSERT INTO `man_system_right` VALUES ('cc83f0cbaadb4df4a2e23b0a6542a76e', 'desktop_resource_node_query', '云桌面资源节点管理', '2015-07-13 15:26:47', 'superadmin');
INSERT INTO `man_system_right` VALUES ('9736ec8c6ef845539cf43a805eeb0ff5', 'desktop_resource_host_query', '云桌面资源池主机查询', '2015-07-13 15:27:10', 'superadmin');
INSERT INTO `man_system_right` VALUES ('96d7b25b175d4a449b8f003885bee83b', 'desktop_resource_pool_add', '云桌面主机资源池添加', '2015-07-13 15:30:17', 'superadmin');
INSERT INTO `man_system_right` VALUES ('525af5ca011142a0aee13d82731e8abb', 'desktop_back_up_manage_query', '桌面云主机备份页面', '2015-07-14 10:14:52', 'superadmin');
INSERT INTO `man_system_right` VALUES ('9c9c12ddd5dd453fac2f192ea573f0d3', 'desktop_back_up_manage_add', '桌面云主机新增备份', '2015-07-14 10:15:07', 'superadmin');
INSERT INTO `man_system_right` VALUES ('e6f721a93d03458b9627e55960907093', 'desktop_back_up_manage_resume', '桌面云主机备份恢复', '2015-07-14 10:17:43', 'superadmin');
INSERT INTO `man_system_right` VALUES ('4bb1c4cda79440ceb4dee0de5923dd01', 'plat_resource_manage', '平台资源监控', '2015-07-14 10:53:12', 'superadmin');
INSERT INTO `man_system_right` VALUES ('99beb0c7a9cc446685402198aec070e8', 'desktop_disk_manage_query', '云桌面主机磁盘管理', '2015-07-14 15:04:06', 'superadmin');
INSERT INTO `man_system_right` VALUES ('2d205294001b462dac6c498835495cc5', 'desktop_disk_manage_add', '云桌面主机磁盘添加', '2015-07-14 15:04:26', 'superadmin');
INSERT INTO `man_system_right` VALUES ('5cb7e110f6e84e7bbb09ddc9c3406131', 'desktop_disk_manage_delete', '云桌面主机磁盘删除', '2015-07-14 15:04:47', 'superadmin');
INSERT INTO `man_system_right` VALUES ('acae2be888974a2b9f56d4406248978f', 'transform_system_address', '系统配置', '2015-07-14 16:44:23', 'superadmin');
INSERT INTO `man_system_right` VALUES ('80e5fe2926e642af88d9c372f872244c', 'transform_system_update', '系统配置修改', '2015-07-14 16:44:40', 'superadmin');
INSERT INTO `man_system_right` VALUES ('15ef4db83a214046ae4c097fd0611612', 'storage_resource_pool_query', '存储资源池查询', '2015-07-16 17:30:17', 'superadmin');
INSERT INTO `man_system_right` VALUES ('d2611ddf35ca4c46bbf61e536ad66c0f', 'storage_resource_pool_node_query', '存储资源池节点查询', '2015-07-16 17:30:33', 'superadmin');
INSERT INTO `man_system_right` VALUES ('2b81b384b4814db4badb1aa4d845e689', 'storage_resource_pool_node_delete', '存储资源池节点删除', '2015-07-16 17:30:50', 'superadmin');
INSERT INTO `man_system_right` VALUES ('c94c5e54bbcd4170acea7550726b39f0', 'ip_resource_pool_query', '地址资源池查询', '2015-07-16 17:31:34', 'superadmin');
INSERT INTO `man_system_right` VALUES ('8bc17e445a5f499883dc904af3090271', 'intelligent_router_query', '智能路由例外规则查询', '2015-07-27 09:51:20', 'superadmin');
INSERT INTO `man_system_right` VALUES ('75e8c259de624d8ea76ca4891b5708ff', 'intelligent_router_add', '智能路由例外规则添加', '2015-07-27 09:52:02', 'superadmin');
INSERT INTO `man_system_right` VALUES ('a46e31c1b54742d78fa04776353a3bec', 'intelligent_router_remove', '智能路由例外规则删除', '2015-07-27 09:52:42', 'superadmin');
INSERT INTO `man_system_right` VALUES ('4d8ca3376f7549f38dea72db1391160d', 'desktop_warehouse_check_time', '设置仓库最小库存检查时间', '2015-07-27 10:19:51', 'superadmin');
INSERT INTO `man_system_right` VALUES ('0ab48c3205574859b3e6a32377c77b1a', 'ip_resource_pool_add', '地址资源池添加', '2015-07-27 13:53:47', 'superadmin');
INSERT INTO `man_system_right` VALUES ('31fd5f75e2624fce989ed84ccba0f391', 'ip_resource_pool_remove', '地址资源池移除', '2015-07-27 13:54:37', 'superadmin');
INSERT INTO `man_system_right` VALUES ('2a7525e411554d28bd497c5a2eb64b71', 'ip_resource_pool_detail_query', '地址资源查询', '2015-07-28 12:57:51', 'superadmin');
INSERT INTO `man_system_right` VALUES ('ff9f60af71ea4cceb7f07e5f3a3210a6', 'ip_resource_pool_detail_add', '地址资源添加', '2015-07-28 12:58:14', 'superadmin');
INSERT INTO `man_system_right` VALUES ('b00a0f0a7df2480db8e68170bda70e5d', 'ip_resource_pool_detail_remove', '地址资源删除', '2015-07-28 12:58:51', 'superadmin');
INSERT INTO `man_system_right` VALUES ('ef6a48aaf6974c21828c6b733a81e25b', 'ip_resource_pool_detail_move', '地址资源迁移', '2015-07-28 12:59:08', 'superadmin');
INSERT INTO `man_system_right` VALUES ('b65f8696b7e645359459c880d6c9426b', 'plat_service_manage', '服务管理', '2015-07-28 17:25:44', 'superadmin');
INSERT INTO `man_system_right` VALUES ('48ff985e27d747708d219b25d9a2c1a4', 'desktop_set_time_back_up_manage', '桌面云定时备份管理查看', '2015-07-31 10:39:46', 'superadmin');
INSERT INTO `man_system_right` VALUES ('05e08abf5cc54451b726fcd3bdac6440', 'desktop_set_time_back_up_update', '桌面云定时备份管理修改', '2015-07-31 10:40:06', 'superadmin');
INSERT INTO `man_system_right` VALUES ('0e4dd7973dfe447ca10fd49a50e2f39b', 'desktop_set_time_back_up_host_manage', '桌面云定时备份主机管理查看', '2015-07-31 10:40:26', 'superadmin');
INSERT INTO `man_system_right` VALUES ('576580557619459690df93b28d5610fd', 'desktop_set_time_back_up_host_update', '桌面云定时备份主机管理修改', '2015-07-31 10:40:47', 'superadmin');
INSERT INTO `man_system_right` VALUES ('df433f74debc40cea1dd0bae782ffeb3', 'desktop_set_time_back_up_detail_manage', '桌面云定时备份记录查看', '2015-07-31 10:41:09', 'superadmin');
INSERT INTO `man_system_right` VALUES ('bbb2324d766f4698aa724c1f7fe211fd', 'transform_admin_moduser', '登录管理修改基本信息', '2015-07-31 10:51:56', 'superadmin');
INSERT INTO `man_system_right` VALUES ('a3c5949c561b496c8ba0e0177515b2db', 'transform_admin_changepass', '登录管理修改密码', '2015-07-31 10:52:14', 'superadmin');
INSERT INTO `man_system_right` VALUES ('1e563b75d3bc40a39fa87c635bb96b7c', 'desktop_user_add', '终端用户新增', '2015-08-04 10:48:53', 'superadmin');
INSERT INTO `man_system_right` VALUES ('82bdce3798b5425fb69504cc63198746', 'desktop_set_time_operation_manage', '定时操作查看', '2015-08-05 10:12:17', 'superadmin');
INSERT INTO `man_system_right` VALUES ('b438319e58524ee8b65682d88f3efa32', 'desktop_set_time_operation_update', '新增或者是更新定时操作任务', '2015-08-05 10:12:48', 'superadmin');
INSERT INTO `man_system_right` VALUES ('d746c6128e2a441d9cce1fbd03e99d7f', 'desktop_back_and_resume_resume', '桌面云备份和恢复-恢复', '2015-08-13 11:20:58', 'superadmin');
INSERT INTO `man_system_right` VALUES ('1a47f37ab63a48fab21d1370988e4599', 'desktop_set_time_operation_host_update', '更新参与定时操作任务的云主机', '2015-08-05 10:16:09', 'superadmin');
INSERT INTO `man_system_right` VALUES ('cd90029c507a46288cb3dab122fe5a99', 'monitor_warn_query', '监控—告警规则查询', '2015-08-13 14:37:43', 'superadmin');
INSERT INTO `man_system_right` VALUES ('dca0cdc16c3b4569b7f352a39746b3d1', 'desktop_resource_pool_host_start', '云桌面计算资源池主机开机', '2015-08-06 10:07:21', 'superadmin');
INSERT INTO `man_system_right` VALUES ('93296cf76664425c872611c07ce3a495', 'desktop_resource_pool_host_stop', '云桌面计算资源池主机关机', '2015-08-06 10:07:56', 'superadmin');
INSERT INTO `man_system_right` VALUES ('7f75f02fcb2748fb88c863a93b722f61', 'desktop_resource_pool_host_halt', '云桌面计算资源池主机强制关机', '2015-08-06 10:08:19', 'superadmin');
INSERT INTO `man_system_right` VALUES ('fc9c749ec4a249518c0df349727ce2c7', 'desktop_resource_pool_host_restart', '云桌面计算资源池主机重启', '2015-08-06 10:08:43', 'superadmin');
INSERT INTO `man_system_right` VALUES ('b5652eefc7f6424abdc18105eb4c3417', 'desktop_resource_pool_host_changetodesktop', '云桌面计算资源池主机添加进桌面仓库', '2015-08-06 10:09:51', 'superadmin');
INSERT INTO `man_system_right` VALUES ('76387096f41c48ab9e05690ae5845778', 'terminal_box_realinfo_query', '终端盒子实时运行情况', '2015-08-07 11:00:24', 'superadmin');
INSERT INTO `man_system_right` VALUES ('689f66fe61d44e149db93fea869ea4f9', 'monitor_warn_add', '监控—告警规则新增', '2015-08-13 14:38:03', 'superadmin');
INSERT INTO `man_system_right` VALUES ('7ed0d74a704944fc9c2296732dbf313a', 'monitor_warn_modify', '监控—告警规则修改', '2015-08-13 14:38:23', 'superadmin');
INSERT INTO `man_system_right` VALUES ('ad696cf1cd87410db7f850972d5891f3', 'monitor_warn_delete', '监控—告警规则删除', '2015-08-13 14:39:05', 'superadmin');
INSERT INTO `man_system_right` VALUES ('9ffd8eac54ac4c5fad0a080bb0b1d8af', 'desktop_back_and_resume_manualbackup', '桌面云备份和恢复-手动备份', '2015-08-13 15:45:36', 'badbb77a6ff94f53b1a0677d0eb1a20e');
INSERT INTO `man_system_right` VALUES ('5b1a51e8b79c4edb87fcbe0b1e4bd708', 'message_email_config_query', '邮件配置查询', '2015-08-13 16:07:15', 'superadmin');
INSERT INTO `man_system_right` VALUES ('18dc5e4dace54e12924fd8430a3c3c9f', 'message_email_config_add', '邮件配置添加', '2015-08-13 16:07:42', 'superadmin');
INSERT INTO `man_system_right` VALUES ('99d22f72650a4b178a6231054e951f55', 'message_email_config_mod', '邮件配置修改', '2015-08-13 16:08:05', 'superadmin');
INSERT INTO `man_system_right` VALUES ('db55d589eac24c8fad369d6fc01dbd26', 'message_email_config_remove', '邮件配置删除', '2015-08-13 16:08:20', 'superadmin');
INSERT INTO `man_system_right` VALUES ('448f9c05f8484731b57cacf5b53c1a13', 'message_email_template_query', '邮件模板查看', '2015-08-14 08:48:26', 'superadmin');
INSERT INTO `man_system_right` VALUES ('10d8fa08979a49f1879d056e2cbe27e0', 'message_email_template_add', '邮件模板添加', '2015-08-14 08:48:47', 'superadmin');
INSERT INTO `man_system_right` VALUES ('0b9d75ac797c4eae87658c1867dcafb8', 'message_email_template_mod', '邮件模板修改', '2015-08-14 08:49:08', 'superadmin');
INSERT INTO `man_system_right` VALUES ('d06ee02c1fc3498ba10309c1d74a128e', 'message_email_template_remove', '邮件模板删除', '2015-08-14 08:49:20', 'superadmin');
INSERT INTO `man_system_right` VALUES ('6ef7917106b0460c9fcbe7345db9de2a', 'message_sms_config_query', '短信配置查看', '2015-08-14 08:52:43', 'superadmin');
INSERT INTO `man_system_right` VALUES ('c8bbed2b94784752b6b5f67c4937a9e7', 'message_sms_config_add', '短信配置添加', '2015-08-14 08:53:01', 'superadmin');
INSERT INTO `man_system_right` VALUES ('55ee2d629a6d4191b5eb0f08a8796dc0', 'message_sms_config_mod', '短信配置修改', '2015-08-14 08:58:41', 'superadmin');
INSERT INTO `man_system_right` VALUES ('2f11bb1c8c3342868ee93d3acccd813a', 'message_sms_config_remove', '短信配置删除', '2015-08-14 08:58:58', 'superadmin');
INSERT INTO `man_system_right` VALUES ('b4c8f52b81be4ea0a85f136a26ec597d', 'message_sms_template_query', '短信模板查看', '2015-08-14 09:00:42', 'superadmin');
INSERT INTO `man_system_right` VALUES ('96bc6b139372441b8456a0d255dbb5ca', 'message_sms_template_add', '短信模板添加', '2015-08-14 09:01:03', 'superadmin');
INSERT INTO `man_system_right` VALUES ('46510ac45c4c423aa9c0655026652a9c', 'message_sms_template_mod', '短信模板修改', '2015-08-14 09:02:27', 'superadmin');
INSERT INTO `man_system_right` VALUES ('c3c03501f6bb4bccb6f6bfff4651bacc', 'message_sms_template_remove', '短信模板删除', '2015-08-14 09:03:38', 'superadmin');
INSERT INTO `man_system_right` VALUES ('a639de8dbea74a44afd4dc7408c528da', 'message_record_query', '消息记录查看', '2015-08-14 09:12:57', 'superadmin');
INSERT INTO `man_system_right` VALUES ('7ded595561314ba6b20cb091c8448799', 'monitor_warn_value', '监控—编辑规则内容', '2015-08-14 11:03:31', 'superadmin');
INSERT INTO `man_system_right` VALUES ('e340abc3fd4440d8bc3ce8f812d6444f', 'monitor_area_query', '区域监控查询', '2015-08-17 16:23:31', 'superadmin');
INSERT INTO `man_system_right` VALUES ('c6e51e318e4b4e40a5178fde4fb34fe4', 'monitor_room_query', '机房监控查询', '2015-08-17 16:23:57', 'superadmin');
INSERT INTO `man_system_right` VALUES ('22be649cfe8d4957b073fb29f8c760fb', 'monitor_rack_query', '机架监控查询', '2015-08-17 16:24:21', 'superadmin');
INSERT INTO `man_system_right` VALUES ('7c808148ec314071a471d9a346934edb', 'monitor_server_query', '服务器监控查询', '2015-08-17 16:24:55', 'superadmin');
INSERT INTO `man_system_right` VALUES ('72d747a0a7e34031a00986307f32a77e', 'monitor_host_query', '云主机监控查询', '2015-08-17 16:25:23', 'superadmin');
INSERT INTO `man_system_right` VALUES ('a07c8a4bc20744bfb421f2932565a58a', 'monitor_resource_query', '资源管理监控查询', '2015-08-17 16:27:02', 'superadmin');
INSERT INTO `man_system_right` VALUES ('e5e8f7ca99364510a819d0b24a17d3ef', 'desktop_flush_disk_image', '桌面云主机重装系统', '2015-09-28 16:04:01', 'superadmin');
INSERT INTO `man_system_right` VALUES ('abd4636cfb57415b9461e8d12576761a', 'desktop_set_time_startup_query', '桌面云定时开机查看', '2015-08-19 16:26:23', 'superadmin');
INSERT INTO `man_system_right` VALUES ('6ae3ff26e64b4ebfb3f465aa45a2d6e0', 'desktop_set_time_shutdown_query', '桌面云定时关机查看', '2015-08-19 16:27:08', 'superadmin');
INSERT INTO `man_system_right` VALUES ('7a9412dc6cbf4e46ba4de8e0f6bffd5e', 'desktop_set_time_startup_host_query', '桌面云定时开机云主机查看', '2015-08-19 16:27:23', 'superadmin');
INSERT INTO `man_system_right` VALUES ('ed5942c478024b83b2bfd8df0e318159', 'desktop_set_time_shutdown_host_query', '桌面云定时关机云主机查看', '2015-08-19 16:27:39', 'superadmin');
INSERT INTO `man_system_right` VALUES ('0a277a91aabc4b93bdcb790424d17fa0', 'desktop_set_time_operation_detail_query', '桌面云定时操作记录查看', '2015-08-19 16:27:56', 'superadmin');
INSERT INTO `man_system_right` VALUES ('520f211ff9aa42969b20d76d9eee4f98', 'terminal_box_info_push_query', '终端消息推送查询', '2015-09-09 10:06:45', 'superadmin');
INSERT INTO `man_system_right` VALUES ('c3dc81b82ae34e9a8a05d0d00b519516', 'terminal_box_info_push_add', '终端消息推送消息新增', '2015-09-09 10:07:16', 'superadmin');
INSERT INTO `man_system_right` VALUES ('217281846f0f4fcc818cc81fb9bbbfd3', 'terminal_box_info_push_delete', '终端消息推送消息删除', '2015-09-09 10:07:36', 'superadmin');
INSERT INTO `man_system_right` VALUES ('89724babbda149a7a593f929e02dfdb8', 'monitor_system_shield_server', '服务器监控屏蔽', '2015-08-26 14:13:56', 'superadmin');
INSERT INTO `man_system_right` VALUES ('e5b5caad68fc4ef78f527024823ff3b7', 'monitor_system_shield_host', '云主机监控屏蔽', '2015-08-26 14:17:34', 'superadmin');
INSERT INTO `man_system_right` VALUES ('81ccfdf56ae448639722beeea69c60d9', 'client_message_manage', '反馈消息管理', '2015-09-28 17:04:48', 'superadmin');
INSERT INTO `man_system_right` VALUES ('a8d0806bb00d4c789bf635b2d728408f', 'client_message_delete', '反馈消息删除', '2015-09-28 17:05:02', 'superadmin');
INSERT INTO `man_system_right` VALUES ('56ac203a1d0f4efdb44307d450d6ccbf', 'client_message_mark', '反馈消息标记已读', '2015-09-28 17:05:29', 'superadmin');
INSERT INTO `man_system_right` VALUES ('6242e4cd98bb452ab4afd721b63435ca', 'desktop_resource_pool_mod', '云桌面主机资源池修改', '2015-09-29 17:07:05', 'superadmin');
INSERT INTO `man_system_right` VALUES ('0dfb50c5926e410083e0a2aae18fb684', 'desktop_resource_pool_remove', '云桌面主机资源池删除', '2015-09-29 17:07:27', 'superadmin');
INSERT INTO `man_system_right` VALUES ('c103304b19e54157b59aa95f98a91f5e', 'desktop_host_start_from_iso', '云桌面主机从光盘启动', '2015-12-16 10:29:33', '8a657f4639e84b7382e828057c90ec00');
INSERT INTO `man_system_right` VALUES ('cf07ab7dff4a49fdbac21fa7acba1a36', 'desktop_resource_node_disabledisk', '本地磁盘禁用', '2015-10-22 11:28:01', 'superadmin');
INSERT INTO `man_system_right` VALUES ('b41b81ba3ad64d7f8e6bd47930376763', 'desktop_resource_node_enabledisk', '本地磁盘启用', '2015-10-22 11:27:47', 'superadmin');
INSERT INTO `man_system_right` VALUES ('2a9dd69254094a31b1bd86281024c43b', 'desktop_resource_node_mount', '磁盘挂载', '2015-10-22 11:27:33', 'superadmin');
INSERT INTO `man_system_right` VALUES ('697dd6649227483694dabaa4c394b609', 'desktop_resource_node_unmount', '磁盘取消挂载', '2015-10-22 11:27:21', 'superadmin');
INSERT INTO `man_system_right` VALUES ('4f72edd47ab7413bae2cc49ea9c4c901', 'desktop_resource_node_device', '查询磁盘挂载', '2015-10-22 11:27:07', 'superadmin');
INSERT INTO `man_system_right` VALUES ('0ddbcc8d592a4a1dac8839dd5c17fa50', 'plat_service_manage_mod', '服务修改', '2015-11-03 18:45:14', 'superadmin');
INSERT INTO `man_system_right` VALUES ('dfe6c84b78034076ad8d2f1b674aad85', 'port_resource_pool_query', '端口资源池查询', '2015-11-04 17:26:39', 'superadmin');
INSERT INTO `man_system_right` VALUES ('691dfda1d01d4fe5991cca31451b2114', 'port_resource_pool_add', '端口资源池创建', '2015-11-04 17:26:59', 'superadmin');
INSERT INTO `man_system_right` VALUES ('bc80e6eb9df941f6a05d123893d4a6df', 'port_resource_pool_remove', '端口资源池删除', '2015-11-04 17:27:18', 'superadmin');
INSERT INTO `man_system_right` VALUES ('10774c546ce8435cbcc7067f9d81b383', 'port_resource_pool_detail_query', '端口资源查询', '2015-11-04 17:27:31', 'superadmin');
INSERT INTO `man_system_right` VALUES ('a83adbb9f9234f019b80da106c9faab2', 'port_resource_pool_detail_add', '端口资源添加', '2015-11-04 17:27:49', 'superadmin');
INSERT INTO `man_system_right` VALUES ('b8294cc396864c9a8a9bcb07c6437444', 'port_resource_pool_detail_remove', '端口资源移除', '2015-11-04 17:28:08', 'superadmin');
INSERT INTO `man_system_right` VALUES ('4a4c88a543c944808d78a778c6548931', 'desktop_warehouse_host_diagram', '云主机资源监控', '2015-11-11 15:32:05', 'superadmin');
INSERT INTO `man_system_right` VALUES ('2ca3f7e3d3f6471e923961eb0004d2d4', 'message_record_remove', '删除发送记录', '2015-11-12 09:31:41', 'superadmin');
INSERT INTO `man_system_right` VALUES ('24ed1bbb1a7f4cbc97e86b096bee0525', 'desktop_user_host_diagram', '用户主机资源监控', '2015-11-12 16:33:38', 'superadmin');
INSERT INTO `man_system_right` VALUES ('1c565e49fddb4620862bf7f2ff43f6ad', 'desktop_warehouse_host_modify', '云桌面主机配置修改', '2015-11-16 17:53:30', 'superadmin');
INSERT INTO `man_system_right` VALUES ('4cd5c7ae44874141a1e6f882c1904efb', 'desktop_warehouse_set_maxconcurrent', '主机仓库设置最大并发数', '2015-11-17 17:43:16', 'superadmin');
INSERT INTO `man_system_right` VALUES ('04dc5168fd9248168117ade23abb4e0b', 'iso_image_add', '光盘镜像新增', '2015-11-20 09:55:18', 'superadmin');
INSERT INTO `man_system_right` VALUES ('ecb376ddfbeb42ff9745896e733dc825', 'iso_image_query', '光盘镜像查询', '2015-11-20 09:56:20', 'superadmin');
INSERT INTO `man_system_right` VALUES ('2dfecdbcdd324b419f06f745ee539d51', 'iso_image_delete', '光盘镜像删除', '2015-11-20 09:56:40', 'superadmin');
INSERT INTO `man_system_right` VALUES ('d6f3cecf68594026a540fb1b9892d662', 'shared_memory_query', '共享存储查询', '2015-10-10 11:42:49', 'superadmin');
INSERT INTO `man_system_right` VALUES ('a9447e00efd747a3b99d96031960fa58', 'shared_memory_add', '共享存储新增', '2015-10-10 11:43:06', 'superadmin');
INSERT INTO `man_system_right` VALUES ('93725cd38fe34937ae7cad3adece5d8e', 'shared_memory_update', '共享存储修改', '2015-10-10 11:43:23', 'superadmin');
INSERT INTO `man_system_right` VALUES ('38fb8471e60c4c67a240932cda8b2348', 'shared_memory_delete', '共享存储删除', '2015-10-10 11:43:38', 'superadmin');
INSERT INTO `man_system_right` VALUES ('f90c9c3fdc6e4d4896233bd61f995ea6', 'blacklist_manage_add', '黑名单添加', '2015-12-11 11:30:01', 'superadmin');
INSERT INTO `man_system_right` VALUES ('fbf3be2225524c808c264c04daab57ed', 'blacklist_manage_update', '黑名单修改', '2015-12-11 11:30:15', 'superadmin');
INSERT INTO `man_system_right` VALUES ('c8224ebaea954e0daaa618c2d5e1afd2', 'blacklist_manage_delete', '黑名单删除', '2015-12-11 11:30:32', 'superadmin');
INSERT INTO `man_system_right` VALUES ('32fdcefadd034f21b320add993fabd63', 'whitelist_manage', '白名单管理', '2015-12-11 11:30:46', 'superadmin');
INSERT INTO `man_system_right` VALUES ('42b60ff9857f45988e5f75f006b75374', 'whitelist_manage_add', '白名单添加', '2015-12-11 11:31:02', 'superadmin');
INSERT INTO `man_system_right` VALUES ('d950bcd4843047ae9d3caa0476566b16', 'whitelist_manage_update', '白名单修改', '2015-12-11 11:31:15', 'superadmin');
INSERT INTO `man_system_right` VALUES ('df7882a453754fdca9c2b889f2af3573', 'whitelist_manage_delete', '白名单删除', '2015-12-11 11:31:31', 'superadmin');
INSERT INTO `man_system_right` VALUES ('de77045af1634dbb9f5fda0b426d76d1', 'desktop_resource_node_add', '云桌面资源池添加节点', '2015-12-15 16:49:23', '8a657f4639e84b7382e828057c90ec00');
INSERT INTO `man_system_right` VALUES ('380be447d80842c48e85778ea0119d3b', 'desktop_resource_node_delete', '云桌面资源池删除节点', '2015-12-15 17:10:53', '8a657f4639e84b7382e828057c90ec00');
INSERT INTO `man_system_right` VALUES ('d07e373785f34c71aa9ec20d1c927a2c', 'disk_image_upload', '磁盘镜像上传', '2015-12-16 15:12:01', '8a657f4639e84b7382e828057c90ec00');
INSERT INTO `man_system_right` VALUES ('8eab6f0754f5448280ff48101e14d0f3', 'iso_image_upload', '光盘镜像上传', '2015-12-16 15:12:22', '8a657f4639e84b7382e828057c90ec00');
INSERT INTO `man_system_right` VALUES ('7f435f2c6bb7495fb1425ca32e99b7d8', 'image_upload_address_query', '上传地址查询', '2015-12-16 15:23:03', '8a657f4639e84b7382e828057c90ec00');
INSERT INTO `man_system_right` VALUES ('cffb5982df074d0b9c2e2ba38c73f5b8', 'image_upload_address_add', '新增上传地址', '2015-12-16 15:23:15', '8a657f4639e84b7382e828057c90ec00');
INSERT INTO `man_system_right` VALUES ('ab9dbd62408c445e91b048231eff5597', 'image_upload_address_mod', '修改上传地址', '2015-12-16 15:23:30', '8a657f4639e84b7382e828057c90ec00');
INSERT INTO `man_system_right` VALUES ('fa8fcd254ca8495fbc82f4f28bc685aa', 'image_upload_address_delete', '删除上传地址', '2015-12-16 15:23:54', '8a657f4639e84b7382e828057c90ec00');

-- ----------------------------
-- Table structure for `man_system_role`
-- ----------------------------
DROP TABLE IF EXISTS `man_system_role`;
CREATE TABLE `man_system_role` (
  `billid` varchar(32) NOT NULL COMMENT '主键',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `code` varchar(100) DEFAULT NULL COMMENT '编码',
  `insert_date` datetime DEFAULT NULL COMMENT '创建日期',
  `insert_user` varchar(32) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`billid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_system_role
-- ----------------------------
INSERT INTO `man_system_role` VALUES ('fe23ba0cb85b40e7880c63d5326e3181', '超级管理员', 'administrator', '2015-12-10 14:13:41', 'superadmin');

-- ----------------------------
-- Table structure for `man_system_rolegroup`
-- ----------------------------
DROP TABLE IF EXISTS `man_system_rolegroup`;
CREATE TABLE `man_system_rolegroup` (
  `billid` varchar(32) NOT NULL DEFAULT '' COMMENT '主键',
  `roleid` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `groupid` varchar(32) DEFAULT NULL COMMENT '色角组ID',
  PRIMARY KEY (`billid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_system_rolegroup
-- ---------------------------- 
-- ----------------------------
-- Table structure for `man_system_rolemenu`
-- ----------------------------
DROP TABLE IF EXISTS `man_system_rolemenu`;
CREATE TABLE `man_system_rolemenu` (
  `billid` varchar(32) NOT NULL COMMENT '主键',
  `menuid` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `roleid` varchar(32) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`billid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_system_rolemenu
-- ----------------------------
INSERT INTO `man_system_rolemenu` VALUES ('2a7674abcefd4c209f0226d07da3b9fa', 'b8e302cd82fa40718ca2cfd7fe72684e', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('38631fd86411446081bf82b75231d9a0', 'e77e14cc46e54d969015491e43785304', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('b1ca04da564747b49df7e90118c0d188', '31bf73d5a87f464595438de6fe9c365e', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('45eb4f81a7f545f3b3e57dd2c6eefba9', '48e1b6902c08455abdeebfc06c6ed39a', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('00d79f5a98864d659f7033de37f3cacb', '48a243915beb43f8ad653bb65c712a36', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('33551b3161d140f2a5d0c4dd9372a7ea', '69769a362947412caffaeb6b1fb4acd4', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('2907da3d2c8142b590081f688e444ec8', 'fe422eb3198e468ea84eba6a343afa92', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('610a812109c0474b93545cd72ca89db6', 'a6d8470d649e469a96eadab7f4ee723e', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('5c9f64217cad4a698ebd7a8a25cf1194', 'fa02fdc9b3004d5986ab4218606f27e2', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('3c63ce3aedc34a8da27a439bbee81dd7', 'a8cb182804804a8cb10495d37c3fbe7c', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('e1758bd933984500b2d1c1cc3a7e634e', '8cef1134437f4cabad4fd28879adf344', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('ec073458d5cb4021bba9deb25af18d0e', '2c3698d8e89440fe908ddaa9f726044c', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('540a83cd7114489a8a27fbc801b64df5', '2c724bd1196f4ec98aa9b94836ac5f73', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('399c6f029c68465283faa71232624e68', 'af3232443a8b4dc8b1ad1b99897e70bb', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('14c841175b744ac29a0b9fe30011751f', '144bdf779b0841ebb9f4a4a3b572e0ee', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('151bc05bd25c41ef9e742231730e15f6', '312b28a8ce3c4c6a8ea58c6afd7bbf06', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('c09c98a70ced47b5b7572fe0d229e27e', 'f988de5af8394f70aca1300fbb161fdb', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('56dadc617fd8441abd2dabc1d16d4e0e', 'cb2fe5765f224d68aaa4d787177a2d31', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('45e9f721c5ee4216b25656afc2a830ff', '59f6e91280924b628a9340415cd6bc6d', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('e5953e685d6047808ed6a2cd34523cb4', 'e323828636cc48c9b8a8ac5f7cc62720', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('e2423e701ecf491aa86c1450f7d5a0f0', '4b86b66ea33c47fb8bc46b6a8a346608', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('b1e29d1e8ee04a709eecdbb1592e5983', '9768223b00cc4cd59c076bb658226acf', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('407e0a629bf94cb09a2323b0486b3dce', '15c851b13dae40e69a89fbe160cd9825', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('bd96ac4318b645508976c92059b57328', '759959f6b369499e91432a4043d4dc38', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('2275b19bcf66439797266afe5f2486ce', 'ba4f42e82ad14badaeb99cd4791770b8', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('6f6d6d19de934ff5b18053084c85def2', '8025fa0599324bcaa71be319c7444d36', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('1ee05371e1844bdfbcb1c9de0ab003d9', 'b87b6f0fa2594abea67eaffd0296d016', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('41fd502fd5a9411db784366dbb929460', '810c22a1ac794dc5acc9e2f549bd3026', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('292689261a2e445182fa1d1f38b7c0f6', '2606ee52b0b54595bb124dd4264f95cf', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('01d8a2f50f684deb9ca41f1f8c1edc83', 'c295224601b146c19499801cb079b7c3', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('1768e3b2a73b4e12b1df2a169b6b1b9d', '1ed4c45cecaf4032b1036445fca49434', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('8b8af207e10a4892bd3b084e843c609e', 'c918a5eb0f0d4d1d9842ea30e11d69be', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('803b825c2166457c85ad5ce423b084f5', '54f3aaa54bf44502ad16193c16d34c73', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('d340a73051104aa6a7d36b7f45f7195a', '473d53e02b644b889518a147582106c3', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('47d6aa9323bd4ff8bbf3f64107291145', '892905cc9ec34eb4bfc9abaf58cdb234', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('e07a64483f004d22a1f288911e07a73b', '857088edb2274a999c27abf183ad20cb', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('aab2f2395a784fcbb39a07f54bd5597f', '35f20ca9ec6549588846c42203021515', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('fcd3dfc36adf468a9cc68843d4ac22b7', 'e203749c741e4de3af03506b4397001c', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('3971d9d23f8c473bb3f9c481fa3f77a7', '6d3fd494900f4cc0a595578539d061b2', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('57a131c039d245a0bf7ca94eb4313424', 'd607aa7c9849470c9b6600a5058e74ea', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('e98214475cd1492a90fbff4c5eb32d61', 'd315492ec49f480582b765ab765edba7', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('95c58037f2e146c3b2800cebc867de41', '4bec936599af42b38dbcd002ded6ed2c', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('fec4cae4aec34d52a614428c93147108', 'e2421762e21248da9fa3d387855ea789', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('e18d0672476e413088acb7ea9360bb60', 'cba6d9e38a044a45b7d8b32245c24335', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('fea54843fbee4d65953b2c996f9e58be', '8d5cb01452224294bb41c8f80a63889a', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('d95ceaf1e53d4fb5ba97d19680c13b9f', '5a5757c77546493e827906240cb0d0ef', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('dacdf60362d84ccdb358adbfa21e3729', 'e6c99ddb1ddd4745aa45fbd535fbf553', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('65a3728cb1e7498d9a4b05fbdaa34074', '45ebe6a728dc4614be68c7a4c6439860', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('b94f6a1546d24f2c86b415f16e6cdf37', 'all', 'fe23ba0cb85b40e7880c63d5326e3181');
INSERT INTO `man_system_rolemenu` VALUES ('cebcbb38122d447595545733c3c47195', '523c6d9feeb744daa5481d1132739859', 'fe23ba0cb85b40e7880c63d5326e3181');

-- ----------------------------
-- Table structure for `man_system_roleright`
-- ----------------------------
DROP TABLE IF EXISTS `man_system_roleright`;
CREATE TABLE `man_system_roleright` (
  `billid` varchar(32) NOT NULL COMMENT '主键',
  `roleid` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `rightid` varchar(32) DEFAULT NULL COMMENT '限权ID',
  PRIMARY KEY (`billid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_system_roleright
-- ----------------------------
INSERT INTO `man_system_roleright` VALUES ('214bb4d6004242049206d69067e747c0', 'fe23ba0cb85b40e7880c63d5326e3181', '1b637d0a8cbe41bea64d1a51e3c2860d');
INSERT INTO `man_system_roleright` VALUES ('496f6eb9198f4b3facc569fb11db4645', 'fe23ba0cb85b40e7880c63d5326e3181', 'a6141b3aedc846a2a23c8b53e9cac8ab');
INSERT INTO `man_system_roleright` VALUES ('a7fc2b75b03a4ff7ac3b1253b38a3975', 'fe23ba0cb85b40e7880c63d5326e3181', 'f568b71a4da24efb9497cbcff276ceeb');
INSERT INTO `man_system_roleright` VALUES ('a44b138b156e4c0e95a0c204ce9eecc6', 'fe23ba0cb85b40e7880c63d5326e3181', 'ae8d349abf434484a10ded19c27cac12');
INSERT INTO `man_system_roleright` VALUES ('3f3fc7186e89419e9eaad21056c75a26', 'fe23ba0cb85b40e7880c63d5326e3181', '202f4514a4064c3298e2c4066f97e904');
INSERT INTO `man_system_roleright` VALUES ('9d19131b3f4c467e812c6944b95a08c0', 'fe23ba0cb85b40e7880c63d5326e3181', 'd21aeafd3a9b461ab6f690de229f3081');
INSERT INTO `man_system_roleright` VALUES ('a17e977644ee4c3d8fffe9d1e7ad135a', 'fe23ba0cb85b40e7880c63d5326e3181', '6d1d59bbc4dc42a8ae45fb483e2cb174');
INSERT INTO `man_system_roleright` VALUES ('82962bd24eb942708b819fac39546b9b', 'fe23ba0cb85b40e7880c63d5326e3181', '178f7a60edf940f19d7b2aaad1978605');
INSERT INTO `man_system_roleright` VALUES ('9ea449f9ec914f6ea745a3bbb10fb4e2', 'fe23ba0cb85b40e7880c63d5326e3181', 'ab519fb8b44442639f887dae58919214');
INSERT INTO `man_system_roleright` VALUES ('9d635ebf2f2f44b69da938e9b9aa72f5', 'fe23ba0cb85b40e7880c63d5326e3181', '964efea9602b462ca53389c8dd7a4b2e');
INSERT INTO `man_system_roleright` VALUES ('71ab40bcdafd4b05841e047da4a52809', 'fe23ba0cb85b40e7880c63d5326e3181', '5fad4ab000504287a989ec89896f4c39');
INSERT INTO `man_system_roleright` VALUES ('3502b9138400410498e9a1c4bce24df3', 'fe23ba0cb85b40e7880c63d5326e3181', 'd8f9f335ee15485daf40422496067121');
INSERT INTO `man_system_roleright` VALUES ('b347d6c4afd241a096d58d88d19398f7', 'fe23ba0cb85b40e7880c63d5326e3181', 'c0617bf3971f4a13baff3da046c46f03');
INSERT INTO `man_system_roleright` VALUES ('0224c0235bbf44b0a749e56c78a075ba', 'fe23ba0cb85b40e7880c63d5326e3181', '7e50391f625c4f0da5e4a14c994a8a7a');
INSERT INTO `man_system_roleright` VALUES ('2fa219aeacdc4e039fa5078a52af3806', 'fe23ba0cb85b40e7880c63d5326e3181', '6b10ac4e85484c6ab811f58595039a78');
INSERT INTO `man_system_roleright` VALUES ('195a227a6f8d409cbd0f2b1b21229088', 'fe23ba0cb85b40e7880c63d5326e3181', '5c43901bdbe64f668c0ce9d89c9d0a98');
INSERT INTO `man_system_roleright` VALUES ('c14bbbd223cf4b498382395941e646b8', 'fe23ba0cb85b40e7880c63d5326e3181', 'faede2e9fbc940039388532046ecabec');
INSERT INTO `man_system_roleright` VALUES ('152b061c450f4786853681f5bc6f2000', 'fe23ba0cb85b40e7880c63d5326e3181', '72b235d689e84da2a3ebfab1a33cabed');
INSERT INTO `man_system_roleright` VALUES ('07ff908e36de4a4db6a2270da0c6c408', 'fe23ba0cb85b40e7880c63d5326e3181', '346157dc12374226b98f5efff3c75f1d');
INSERT INTO `man_system_roleright` VALUES ('3145eebf4adb4fe2a594803c1477c84d', 'fe23ba0cb85b40e7880c63d5326e3181', '86af3354931945cea7c1ca6cde252dca');
INSERT INTO `man_system_roleright` VALUES ('d5fe52de4c134ad8b2e08095797dd8b3', 'fe23ba0cb85b40e7880c63d5326e3181', 'f39cb4857db84ad0b42043e999862194');
INSERT INTO `man_system_roleright` VALUES ('ad63e2a3aca446bd98ff0e65e58be4b2', 'fe23ba0cb85b40e7880c63d5326e3181', '283478a357934dc09fb29d93962e567b');
INSERT INTO `man_system_roleright` VALUES ('bc6b78a71f6447ef98890529cf00aa88', 'fe23ba0cb85b40e7880c63d5326e3181', '54dff6650cb4414ea4f633a134f40a13');
INSERT INTO `man_system_roleright` VALUES ('16a58865c5e8467a9900c82f86eb462a', 'fe23ba0cb85b40e7880c63d5326e3181', 'a3c5949c561b496c8ba0e0177515b2db');
INSERT INTO `man_system_roleright` VALUES ('9355634580a64caa82cc18f4848bfad1', 'fe23ba0cb85b40e7880c63d5326e3181', 'bbb2324d766f4698aa724c1f7fe211fd');
INSERT INTO `man_system_roleright` VALUES ('1e8b9ba217dd407bad9a398a105a6b8b', 'fe23ba0cb85b40e7880c63d5326e3181', '520f211ff9aa42969b20d76d9eee4f98');
INSERT INTO `man_system_roleright` VALUES ('f18f09db3d63432bb0d23c6ef2be8867', 'fe23ba0cb85b40e7880c63d5326e3181', 'c3dc81b82ae34e9a8a05d0d00b519516');
INSERT INTO `man_system_roleright` VALUES ('676bb059fae4484b83667f0501d060c6', 'fe23ba0cb85b40e7880c63d5326e3181', '217281846f0f4fcc818cc81fb9bbbfd3');
INSERT INTO `man_system_roleright` VALUES ('f4b8180007134b4e883e0a07727fbcf7', 'fe23ba0cb85b40e7880c63d5326e3181', '81ccfdf56ae448639722beeea69c60d9');
INSERT INTO `man_system_roleright` VALUES ('c002aa0f194c479cbfa7287ace38fca0', 'fe23ba0cb85b40e7880c63d5326e3181', 'a8d0806bb00d4c789bf635b2d728408f');
INSERT INTO `man_system_roleright` VALUES ('474e0331703d40cc85683940b891fd43', 'fe23ba0cb85b40e7880c63d5326e3181', '56ac203a1d0f4efdb44307d450d6ccbf');
INSERT INTO `man_system_roleright` VALUES ('a0babd4a33a94655be620dbea2a8a8e8', 'fe23ba0cb85b40e7880c63d5326e3181', '32141cc562994125bee6be9eb516a1a2');
INSERT INTO `man_system_roleright` VALUES ('b5fde77d3e49482382de0660a43712ce', 'fe23ba0cb85b40e7880c63d5326e3181', 'df76dcc9c71c493da0b4cc70cd44c9a5');
INSERT INTO `man_system_roleright` VALUES ('8cef16fec2564de9b15e7dfb8262e88f', 'fe23ba0cb85b40e7880c63d5326e3181', '5c019b45d3894a36a9dc9c3225afca52');
INSERT INTO `man_system_roleright` VALUES ('7919b5496cc543758c3239719f5a3da1', 'fe23ba0cb85b40e7880c63d5326e3181', '50a89f6a952c463ead60858dfaa2e9b3');
INSERT INTO `man_system_roleright` VALUES ('14bf1d0f35f94de8b6d99fe32d8ee573', 'fe23ba0cb85b40e7880c63d5326e3181', '99a683848e0b4281acbc8635d8fff236');
INSERT INTO `man_system_roleright` VALUES ('fb03ad6a1b5c44adadafd095aaed04ae', 'fe23ba0cb85b40e7880c63d5326e3181', 'f0caa36f28fa44998cbb1ea5f8d6cfb1');
INSERT INTO `man_system_roleright` VALUES ('53448b95617a4526a6388be00d8bec56', 'fe23ba0cb85b40e7880c63d5326e3181', 'd8d667f74aa04461b506604959a61bbe');
INSERT INTO `man_system_roleright` VALUES ('abd7e98361b440659e6819ad04b9f74c', 'fe23ba0cb85b40e7880c63d5326e3181', '7adf67673d9c441f96b1ac0664604ecd');
INSERT INTO `man_system_roleright` VALUES ('e9d743debf15418187423ccbd3e56f5b', 'fe23ba0cb85b40e7880c63d5326e3181', '417416748bef4aabae6aa5a33283d6fd');
INSERT INTO `man_system_roleright` VALUES ('f6a8de9fdf804ec5a01e909c4e94c90f', 'fe23ba0cb85b40e7880c63d5326e3181', '1e563b75d3bc40a39fa87c635bb96b7c');
INSERT INTO `man_system_roleright` VALUES ('70c9d6e1725747619e35a305a8cf5344', 'fe23ba0cb85b40e7880c63d5326e3181', '24ed1bbb1a7f4cbc97e86b096bee0525');
INSERT INTO `man_system_roleright` VALUES ('f9f8f935d14f477ea93ab24cc7c0a025', 'fe23ba0cb85b40e7880c63d5326e3181', '1879047193f8442ea695525030d89fbe');
INSERT INTO `man_system_roleright` VALUES ('480acb44508447978f1db1dea51ca55a', 'fe23ba0cb85b40e7880c63d5326e3181', '5a11b581ee1f4fce8716f40ca5ea308d');
INSERT INTO `man_system_roleright` VALUES ('7402e6a14f3d48679f369c19a2593661', 'fe23ba0cb85b40e7880c63d5326e3181', '795f2725daaa4eacbf42ff0b0b61f1c4');
INSERT INTO `man_system_roleright` VALUES ('c8fa950782e54600ba17bb0e58230f15', 'fe23ba0cb85b40e7880c63d5326e3181', '94c44e9ff3a844658a97c09b55162232');
INSERT INTO `man_system_roleright` VALUES ('71c717876aa444df88d94fbba663541d', 'fe23ba0cb85b40e7880c63d5326e3181', '9886acfc8d8c4ed38f66a18f46223dd0');
INSERT INTO `man_system_roleright` VALUES ('5bb2d8b5aeb944b28ce90deb1123f473', 'fe23ba0cb85b40e7880c63d5326e3181', '725b1a12844148b2a1bec1488b7be33f');
INSERT INTO `man_system_roleright` VALUES ('9894e082c8a4426aa389f204267a1a44', 'fe23ba0cb85b40e7880c63d5326e3181', '82bdce3798b5425fb69504cc63198746');
INSERT INTO `man_system_roleright` VALUES ('83175065aa424f4bbde4c2d8afa4fc87', 'fe23ba0cb85b40e7880c63d5326e3181', 'b438319e58524ee8b65682d88f3efa32');
INSERT INTO `man_system_roleright` VALUES ('159f065896d548269d2153914cd995f5', 'fe23ba0cb85b40e7880c63d5326e3181', '1a47f37ab63a48fab21d1370988e4599');
INSERT INTO `man_system_roleright` VALUES ('bcd8f0d682954ef0855d05b5702fd671', 'fe23ba0cb85b40e7880c63d5326e3181', 'abd4636cfb57415b9461e8d12576761a');
INSERT INTO `man_system_roleright` VALUES ('408c50165c99478c9db6e936d1267cb4', 'fe23ba0cb85b40e7880c63d5326e3181', '6ae3ff26e64b4ebfb3f465aa45a2d6e0');
INSERT INTO `man_system_roleright` VALUES ('197ca1a460024ee295a3cb49dfb34644', 'fe23ba0cb85b40e7880c63d5326e3181', '7a9412dc6cbf4e46ba4de8e0f6bffd5e');
INSERT INTO `man_system_roleright` VALUES ('3e8178f07f604b8a8b1c12b749819d1c', 'fe23ba0cb85b40e7880c63d5326e3181', 'ed5942c478024b83b2bfd8df0e318159');
INSERT INTO `man_system_roleright` VALUES ('11330e7e982c40a59d4dc1ca192c7bc3', 'fe23ba0cb85b40e7880c63d5326e3181', '0a277a91aabc4b93bdcb790424d17fa0');
INSERT INTO `man_system_roleright` VALUES ('e7bc9e6e64464f7db486b9300cda1545', 'fe23ba0cb85b40e7880c63d5326e3181', '48ff985e27d747708d219b25d9a2c1a4');
INSERT INTO `man_system_roleright` VALUES ('7f8b8ff6aa9a4751a6cb081eef7dc1f2', 'fe23ba0cb85b40e7880c63d5326e3181', '05e08abf5cc54451b726fcd3bdac6440');
INSERT INTO `man_system_roleright` VALUES ('958efb8f8c3a4d99a436d7c57322deca', 'fe23ba0cb85b40e7880c63d5326e3181', '0e4dd7973dfe447ca10fd49a50e2f39b');
INSERT INTO `man_system_roleright` VALUES ('dbe2c1c155884e0382f0634a5fb1cb19', 'fe23ba0cb85b40e7880c63d5326e3181', '576580557619459690df93b28d5610fd');
INSERT INTO `man_system_roleright` VALUES ('64d3d8c58dda4be8a4ae4490eb54f749', 'fe23ba0cb85b40e7880c63d5326e3181', 'df433f74debc40cea1dd0bae782ffeb3');
INSERT INTO `man_system_roleright` VALUES ('bb5bb01ff344437eb5ffaa8559662e66', 'fe23ba0cb85b40e7880c63d5326e3181', 'd746c6128e2a441d9cce1fbd03e99d7f');
INSERT INTO `man_system_roleright` VALUES ('4a06286230ea4221bbf55c3d65a05033', 'fe23ba0cb85b40e7880c63d5326e3181', '9ffd8eac54ac4c5fad0a080bb0b1d8af');
INSERT INTO `man_system_roleright` VALUES ('bd845d1a7e18445ea539a4a57af86cca', 'fe23ba0cb85b40e7880c63d5326e3181', 'baaa372a9aef495da4c3d360a679a1de');
INSERT INTO `man_system_roleright` VALUES ('f8611a4f09a54520adeb11220487ccd5', 'fe23ba0cb85b40e7880c63d5326e3181', '19d734c1502444ff8cbddf7dd98b7ad2');
INSERT INTO `man_system_roleright` VALUES ('55276364107d42cdbac3207b9896ca03', 'fe23ba0cb85b40e7880c63d5326e3181', '413f22902b9a48c0bc88daf9e861adc2');
INSERT INTO `man_system_roleright` VALUES ('240dd95ff7ca49879b698c62d05080b7', 'fe23ba0cb85b40e7880c63d5326e3181', '76387096f41c48ab9e05690ae5845778');
INSERT INTO `man_system_roleright` VALUES ('1a4b7974a2724d499fe6bbbb14fc7fbd', 'fe23ba0cb85b40e7880c63d5326e3181', 'b9bec728d5bd4ff785f3f9af1bae1088');
INSERT INTO `man_system_roleright` VALUES ('023593e46ada4ab2a1ee30d306ac87b0', 'fe23ba0cb85b40e7880c63d5326e3181', '6d2dc8b96c744cfdaef68fb155eab49e');
INSERT INTO `man_system_roleright` VALUES ('7e5ee706ec7140d09a5ef4451a0e299f', 'fe23ba0cb85b40e7880c63d5326e3181', 'e9f12ae18edf4e6a814ea12309bef0b5');
INSERT INTO `man_system_roleright` VALUES ('6928c33c9fc84b2383f01087e9fbc8fa', 'fe23ba0cb85b40e7880c63d5326e3181', 'cb98cb53e4824939bf9d946ca7a411ec');
INSERT INTO `man_system_roleright` VALUES ('e37237b844484cbaa4eeb179ef4cc3ab', 'fe23ba0cb85b40e7880c63d5326e3181', '446ebacd2add4fa994bfd8aefdd04ab9');
INSERT INTO `man_system_roleright` VALUES ('71f9b9fe4ec4462fa3708e20c01055ca', 'fe23ba0cb85b40e7880c63d5326e3181', 'f8a19e41522c4a6e98a800faa0bf7db4');
INSERT INTO `man_system_roleright` VALUES ('8f0a717832ce48a093cf9c717bbe8a92', 'fe23ba0cb85b40e7880c63d5326e3181', '32f97a0e26ef407e93f7ff9044f7caa0');
INSERT INTO `man_system_roleright` VALUES ('37ed42287c734184aab0a43f5dcb6bc0', 'fe23ba0cb85b40e7880c63d5326e3181', '5ffcbe16ff3644da851a1c024b0746d2');
INSERT INTO `man_system_roleright` VALUES ('abbd9c791be84d419b17fdb04b2a9231', 'fe23ba0cb85b40e7880c63d5326e3181', 'f85cdcc5cf7847d4a7e83be1ae3cb44c');
INSERT INTO `man_system_roleright` VALUES ('caea03f87f0c4b7dbcc132ed17b87529', 'fe23ba0cb85b40e7880c63d5326e3181', 'fa4b8f5fcda9439a859ac735202e8190');
INSERT INTO `man_system_roleright` VALUES ('d36f9e7bd6c04aeda97354ea22867a4e', 'fe23ba0cb85b40e7880c63d5326e3181', '57362032eca142dd8d93c24b0cd681a5');
INSERT INTO `man_system_roleright` VALUES ('5d2f0a651d87402598add081a8262583', 'fe23ba0cb85b40e7880c63d5326e3181', 'd07e373785f34c71aa9ec20d1c927a2c');
INSERT INTO `man_system_roleright` VALUES ('3f9648f0dc4f4d738c2658e77232477f', 'fe23ba0cb85b40e7880c63d5326e3181', '04dc5168fd9248168117ade23abb4e0b');
INSERT INTO `man_system_roleright` VALUES ('fbd79fe6a5b8496e9eff92e66d928a60', 'fe23ba0cb85b40e7880c63d5326e3181', 'ecb376ddfbeb42ff9745896e733dc825');
INSERT INTO `man_system_roleright` VALUES ('f01ccee0a67548e3af3f4e211a678dd0', 'fe23ba0cb85b40e7880c63d5326e3181', '2dfecdbcdd324b419f06f745ee539d51');
INSERT INTO `man_system_roleright` VALUES ('98690d0f1877465a8dc4bedaec0f3024', 'fe23ba0cb85b40e7880c63d5326e3181', '8eab6f0754f5448280ff48101e14d0f3');
INSERT INTO `man_system_roleright` VALUES ('f151c2e56c824581ba369b311a381382', 'fe23ba0cb85b40e7880c63d5326e3181', 'f52d3f6af13e47a99a27c85b0a29cb8e');
INSERT INTO `man_system_roleright` VALUES ('d6a3e2d9bace4d83a1f5e0fbc8dd43a3', 'fe23ba0cb85b40e7880c63d5326e3181', 'f2e86e0fdd20472c8e55622be24943dc');
INSERT INTO `man_system_roleright` VALUES ('752faa7ee5b446348d8e601a53620ee7', 'fe23ba0cb85b40e7880c63d5326e3181', '174a45b6405f4209a058d9391ded6a3c');
INSERT INTO `man_system_roleright` VALUES ('a60df0b295b24f9bbb8a5b7b55aae95a', 'fe23ba0cb85b40e7880c63d5326e3181', '2112837c32aa4b75b092ea1df0b3efc4');
INSERT INTO `man_system_roleright` VALUES ('43a4e944ea0f41c4a8cea3c7f252fe39', 'fe23ba0cb85b40e7880c63d5326e3181', '67e947d10be442a19cabf12df54b9ee7');
INSERT INTO `man_system_roleright` VALUES ('4326cf9b632649c28f459453f2d318d6', 'fe23ba0cb85b40e7880c63d5326e3181', '054bfba832404fef93c4c1a66f3d8d18');
INSERT INTO `man_system_roleright` VALUES ('b409478fe29144d18d8209cc1b27d05d', 'fe23ba0cb85b40e7880c63d5326e3181', 'fe98e63455694d5b95ebb24449a03434');
INSERT INTO `man_system_roleright` VALUES ('df7d89304a6944efbae0d8954f5363b0', 'fe23ba0cb85b40e7880c63d5326e3181', '3e52bb2e56a74df5bbe72613ed2031b2');
INSERT INTO `man_system_roleright` VALUES ('24d638f35f234ad1ad1e72e4faa78124', 'fe23ba0cb85b40e7880c63d5326e3181', '10100245cfe7409ca42fa8b300042e8e');
INSERT INTO `man_system_roleright` VALUES ('0b536903b35248c681854e271f7fc22b', 'fe23ba0cb85b40e7880c63d5326e3181', 'fe5ec96ffa264f35a32d17149abeeb25');
INSERT INTO `man_system_roleright` VALUES ('99fa4e93eb6142caa1ccbf1a96fe4456', 'fe23ba0cb85b40e7880c63d5326e3181', 'c9d87dfd307f4e9682c7c6882065d40f');
INSERT INTO `man_system_roleright` VALUES ('16931416129f43ecb7dbc57c0a990f9a', 'fe23ba0cb85b40e7880c63d5326e3181', 'a217c57c0a384e23ac8e5f58114ec704');
INSERT INTO `man_system_roleright` VALUES ('08d64d2836e045d98be582a782e39bcb', 'fe23ba0cb85b40e7880c63d5326e3181', '5d98e0510da34e9985d0553052b471c4');
INSERT INTO `man_system_roleright` VALUES ('2f93133b28984af5b65dee1a2d2b2461', 'fe23ba0cb85b40e7880c63d5326e3181', '1101a5f030dc4f3c98609a0dc338ffcd');
INSERT INTO `man_system_roleright` VALUES ('017a1af0502e410b95862968cb9066cc', 'fe23ba0cb85b40e7880c63d5326e3181', '525af5ca011142a0aee13d82731e8abb');
INSERT INTO `man_system_roleright` VALUES ('bd2d8673f215433cb9135f33f36c92f7', 'fe23ba0cb85b40e7880c63d5326e3181', '9c9c12ddd5dd453fac2f192ea573f0d3');
INSERT INTO `man_system_roleright` VALUES ('ee0affd36c204e3a888a3b4c202f2171', 'fe23ba0cb85b40e7880c63d5326e3181', 'e6f721a93d03458b9627e55960907093');
INSERT INTO `man_system_roleright` VALUES ('fb64c45267ff49169857eb969c1e955f', 'fe23ba0cb85b40e7880c63d5326e3181', '99beb0c7a9cc446685402198aec070e8');
INSERT INTO `man_system_roleright` VALUES ('cb51621fc64b4ce6be612206323857d3', 'fe23ba0cb85b40e7880c63d5326e3181', '2d205294001b462dac6c498835495cc5');
INSERT INTO `man_system_roleright` VALUES ('f02568f21b3f409ca0e9992cbb732aba', 'fe23ba0cb85b40e7880c63d5326e3181', '5cb7e110f6e84e7bbb09ddc9c3406131');
INSERT INTO `man_system_roleright` VALUES ('95610dc3c3fc49039587ad6f0db90be1', 'fe23ba0cb85b40e7880c63d5326e3181', '4d8ca3376f7549f38dea72db1391160d');
INSERT INTO `man_system_roleright` VALUES ('8e8367e13b8449cb858501466ced4245', 'fe23ba0cb85b40e7880c63d5326e3181', 'e5e8f7ca99364510a819d0b24a17d3ef');
INSERT INTO `man_system_roleright` VALUES ('1f466592a45b4950bdb8505da7c4c397', 'fe23ba0cb85b40e7880c63d5326e3181', '4a4c88a543c944808d78a778c6548931');
INSERT INTO `man_system_roleright` VALUES ('f2731844b8e9450180b1e62806ba28e5', 'fe23ba0cb85b40e7880c63d5326e3181', '1c565e49fddb4620862bf7f2ff43f6ad');
INSERT INTO `man_system_roleright` VALUES ('34f966c676e64d08bf380def18ea15f0', 'fe23ba0cb85b40e7880c63d5326e3181', '4cd5c7ae44874141a1e6f882c1904efb');
INSERT INTO `man_system_roleright` VALUES ('1f5c958d77dc4d6ba4835ee40c5223ab', 'fe23ba0cb85b40e7880c63d5326e3181', '3d2e7e3f573e46ebaf1df371c00ef819');
INSERT INTO `man_system_roleright` VALUES ('9a3cd580c23b44d48aa415d11a5156ce', 'fe23ba0cb85b40e7880c63d5326e3181', 'c103304b19e54157b59aa95f98a91f5e');
INSERT INTO `man_system_roleright` VALUES ('e0791c62527140e5914bce3ee9e3d355', 'fe23ba0cb85b40e7880c63d5326e3181', '7f435f2c6bb7495fb1425ca32e99b7d8');
INSERT INTO `man_system_roleright` VALUES ('881eb61f4ab24b28a9ea6f05a50b2a42', 'fe23ba0cb85b40e7880c63d5326e3181', 'cffb5982df074d0b9c2e2ba38c73f5b8');
INSERT INTO `man_system_roleright` VALUES ('49bd9c5776db459c8a8240cf7e339e0a', 'fe23ba0cb85b40e7880c63d5326e3181', 'ab9dbd62408c445e91b048231eff5597');
INSERT INTO `man_system_roleright` VALUES ('0b1f75abeb6a413481be4801c9d622eb', 'fe23ba0cb85b40e7880c63d5326e3181', 'fa8fcd254ca8495fbc82f4f28bc685aa');
INSERT INTO `man_system_roleright` VALUES ('87fa7d6d03e2412a8fe43c28f1a10f02', 'fe23ba0cb85b40e7880c63d5326e3181', '32fdcefadd034f21b320add993fabd63');
INSERT INTO `man_system_roleright` VALUES ('daae5135ce354f7b8dcbcf2424201074', 'fe23ba0cb85b40e7880c63d5326e3181', '42b60ff9857f45988e5f75f006b75374');
INSERT INTO `man_system_roleright` VALUES ('5266ce9430a04bb5a6c7a77698cdfe4e', 'fe23ba0cb85b40e7880c63d5326e3181', 'd950bcd4843047ae9d3caa0476566b16');
INSERT INTO `man_system_roleright` VALUES ('a15e8a58a42c4f698ec6db78df52807c', 'fe23ba0cb85b40e7880c63d5326e3181', 'df7882a453754fdca9c2b889f2af3573');
INSERT INTO `man_system_roleright` VALUES ('7a852d181fba4ea1ba1bdde0febe9fc3', 'fe23ba0cb85b40e7880c63d5326e3181', '224c8141e35a4d36ad199f222d7098c9');
INSERT INTO `man_system_roleright` VALUES ('2460b0eac4e74cfe90a826b8c46e018d', 'fe23ba0cb85b40e7880c63d5326e3181', 'f90c9c3fdc6e4d4896233bd61f995ea6');
INSERT INTO `man_system_roleright` VALUES ('2a082e0ce778440f8b32d13ea72f048f', 'fe23ba0cb85b40e7880c63d5326e3181', 'fbf3be2225524c808c264c04daab57ed');
INSERT INTO `man_system_roleright` VALUES ('e4de5fb7d49c401ba642ba8f9b8939ed', 'fe23ba0cb85b40e7880c63d5326e3181', 'c8224ebaea954e0daaa618c2d5e1afd2');
INSERT INTO `man_system_roleright` VALUES ('97fa8b9093044a69951726a5ff8830c4', 'fe23ba0cb85b40e7880c63d5326e3181', 'acae2be888974a2b9f56d4406248978f');
INSERT INTO `man_system_roleright` VALUES ('3af644790162410e9e219f7e506de4be', 'fe23ba0cb85b40e7880c63d5326e3181', '80e5fe2926e642af88d9c372f872244c');
INSERT INTO `man_system_roleright` VALUES ('43288660406c4438b3d6b53e80a91007', 'fe23ba0cb85b40e7880c63d5326e3181', '5b1a51e8b79c4edb87fcbe0b1e4bd708');
INSERT INTO `man_system_roleright` VALUES ('1ed260b501a445a189cd04c23de3d9fe', 'fe23ba0cb85b40e7880c63d5326e3181', '18dc5e4dace54e12924fd8430a3c3c9f');
INSERT INTO `man_system_roleright` VALUES ('f7d5222ecab64395b34c871b36f2d2ad', 'fe23ba0cb85b40e7880c63d5326e3181', '99d22f72650a4b178a6231054e951f55');
INSERT INTO `man_system_roleright` VALUES ('e306b3f7565944f0a58d0f607cf9a313', 'fe23ba0cb85b40e7880c63d5326e3181', 'db55d589eac24c8fad369d6fc01dbd26');
INSERT INTO `man_system_roleright` VALUES ('e7b4e3eaddd2435eb1626257566b4332', 'fe23ba0cb85b40e7880c63d5326e3181', '448f9c05f8484731b57cacf5b53c1a13');
INSERT INTO `man_system_roleright` VALUES ('ffd31c97f68f4578b74aae86b2186444', 'fe23ba0cb85b40e7880c63d5326e3181', '10d8fa08979a49f1879d056e2cbe27e0');
INSERT INTO `man_system_roleright` VALUES ('59e00c422ece418b8a12d5d7755a1bb7', 'fe23ba0cb85b40e7880c63d5326e3181', '0b9d75ac797c4eae87658c1867dcafb8');
INSERT INTO `man_system_roleright` VALUES ('19f01780309d4fdd8c6e09202773734c', 'fe23ba0cb85b40e7880c63d5326e3181', 'd06ee02c1fc3498ba10309c1d74a128e');
INSERT INTO `man_system_roleright` VALUES ('0b30671863684a5491c9cdd45ea818a5', 'fe23ba0cb85b40e7880c63d5326e3181', '6ef7917106b0460c9fcbe7345db9de2a');
INSERT INTO `man_system_roleright` VALUES ('362a1836dddc4b1ca9731b2a3dabe0b7', 'fe23ba0cb85b40e7880c63d5326e3181', 'c8bbed2b94784752b6b5f67c4937a9e7');
INSERT INTO `man_system_roleright` VALUES ('f3bd53accb8e43539d36315319c715eb', 'fe23ba0cb85b40e7880c63d5326e3181', '55ee2d629a6d4191b5eb0f08a8796dc0');
INSERT INTO `man_system_roleright` VALUES ('3da747336df24b989873ab580b301090', 'fe23ba0cb85b40e7880c63d5326e3181', '2f11bb1c8c3342868ee93d3acccd813a');
INSERT INTO `man_system_roleright` VALUES ('937708650e454df09a0ee2e6278e2425', 'fe23ba0cb85b40e7880c63d5326e3181', 'b4c8f52b81be4ea0a85f136a26ec597d');
INSERT INTO `man_system_roleright` VALUES ('2bd2748c910a439fa957867794d66955', 'fe23ba0cb85b40e7880c63d5326e3181', '96bc6b139372441b8456a0d255dbb5ca');
INSERT INTO `man_system_roleright` VALUES ('1d60305f11384915be8e9613b2dccd1e', 'fe23ba0cb85b40e7880c63d5326e3181', '46510ac45c4c423aa9c0655026652a9c');
INSERT INTO `man_system_roleright` VALUES ('c47b56a059b04c7598138706b39d98c0', 'fe23ba0cb85b40e7880c63d5326e3181', 'c3c03501f6bb4bccb6f6bfff4651bacc');
INSERT INTO `man_system_roleright` VALUES ('b5152d2e4a634a478526ec2290307f33', 'fe23ba0cb85b40e7880c63d5326e3181', 'a639de8dbea74a44afd4dc7408c528da');
INSERT INTO `man_system_roleright` VALUES ('024a658a2aa24f619d897c38ac1af207', 'fe23ba0cb85b40e7880c63d5326e3181', '2ca3f7e3d3f6471e923961eb0004d2d4');
INSERT INTO `man_system_roleright` VALUES ('48f75ab984f5421593d8dbbcdf9af4d7', 'fe23ba0cb85b40e7880c63d5326e3181', 'd6f3cecf68594026a540fb1b9892d662');
INSERT INTO `man_system_roleright` VALUES ('e02e4dc96e3f4163b459d34f4756f725', 'fe23ba0cb85b40e7880c63d5326e3181', 'a9447e00efd747a3b99d96031960fa58');
INSERT INTO `man_system_roleright` VALUES ('d5149e1164b94c7d9b5126f040d77f4f', 'fe23ba0cb85b40e7880c63d5326e3181', '93725cd38fe34937ae7cad3adece5d8e');
INSERT INTO `man_system_roleright` VALUES ('d81f1013a0444d1aa9f737116f9c61ac', 'fe23ba0cb85b40e7880c63d5326e3181', '38fb8471e60c4c67a240932cda8b2348');
INSERT INTO `man_system_roleright` VALUES ('f34cfc308d564c6f9b016e5c87f49e26', 'fe23ba0cb85b40e7880c63d5326e3181', 'a14617acbe8742ad9b9ef096b37be865');
INSERT INTO `man_system_roleright` VALUES ('9d32d6efdade401badd8b8e5a04ca9c7', 'fe23ba0cb85b40e7880c63d5326e3181', '8bc17e445a5f499883dc904af3090271');
INSERT INTO `man_system_roleright` VALUES ('b1b180e5b64b452eba04af62f6040db5', 'fe23ba0cb85b40e7880c63d5326e3181', '75e8c259de624d8ea76ca4891b5708ff');
INSERT INTO `man_system_roleright` VALUES ('6f1da46013e1410ab18aeeb74bcb3ad8', 'fe23ba0cb85b40e7880c63d5326e3181', 'a46e31c1b54742d78fa04776353a3bec');
INSERT INTO `man_system_roleright` VALUES ('2645459973bf4512b52e2ded9a4b22b6', 'fe23ba0cb85b40e7880c63d5326e3181', '15ef4db83a214046ae4c097fd0611612');
INSERT INTO `man_system_roleright` VALUES ('12ede24463324b588cd0cc0765d4734e', 'fe23ba0cb85b40e7880c63d5326e3181', 'd2611ddf35ca4c46bbf61e536ad66c0f');
INSERT INTO `man_system_roleright` VALUES ('98871b07a5504c008435ba443caf15ef', 'fe23ba0cb85b40e7880c63d5326e3181', '2b81b384b4814db4badb1aa4d845e689');
INSERT INTO `man_system_roleright` VALUES ('618da3689f3040258425ba075d352246', 'fe23ba0cb85b40e7880c63d5326e3181', 'dfe6c84b78034076ad8d2f1b674aad85');
INSERT INTO `man_system_roleright` VALUES ('b8613c6e826443f9852629ee219657c8', 'fe23ba0cb85b40e7880c63d5326e3181', '691dfda1d01d4fe5991cca31451b2114');
INSERT INTO `man_system_roleright` VALUES ('c7e215b3eb254b6fac2f715b544b54e9', 'fe23ba0cb85b40e7880c63d5326e3181', 'bc80e6eb9df941f6a05d123893d4a6df');
INSERT INTO `man_system_roleright` VALUES ('d414b29aa92c4db3b2bf3401dc5675eb', 'fe23ba0cb85b40e7880c63d5326e3181', '10774c546ce8435cbcc7067f9d81b383');
INSERT INTO `man_system_roleright` VALUES ('691d932d6b9e4e0da9da9bf826213446', 'fe23ba0cb85b40e7880c63d5326e3181', 'a83adbb9f9234f019b80da106c9faab2');
INSERT INTO `man_system_roleright` VALUES ('a1883785c15b4488b372bd86b75d2f57', 'fe23ba0cb85b40e7880c63d5326e3181', 'b8294cc396864c9a8a9bcb07c6437444');
INSERT INTO `man_system_roleright` VALUES ('256e05a8a1cd44c8847415b5c4659529', 'fe23ba0cb85b40e7880c63d5326e3181', 'c94c5e54bbcd4170acea7550726b39f0');
INSERT INTO `man_system_roleright` VALUES ('5867140cc79d46c59baf982f06fd6635', 'fe23ba0cb85b40e7880c63d5326e3181', '0ab48c3205574859b3e6a32377c77b1a');
INSERT INTO `man_system_roleright` VALUES ('55175ed945c949ab879a1026e2aa418f', 'fe23ba0cb85b40e7880c63d5326e3181', '31fd5f75e2624fce989ed84ccba0f391');
INSERT INTO `man_system_roleright` VALUES ('59f62dfc89134663a054e43ea702be31', 'fe23ba0cb85b40e7880c63d5326e3181', '2a7525e411554d28bd497c5a2eb64b71');
INSERT INTO `man_system_roleright` VALUES ('892b66182f4142e78f7db8210fccbe74', 'fe23ba0cb85b40e7880c63d5326e3181', 'ff9f60af71ea4cceb7f07e5f3a3210a6');
INSERT INTO `man_system_roleright` VALUES ('77fb2dfb7ea44569b8ba1c325a4ff16b', 'fe23ba0cb85b40e7880c63d5326e3181', 'b00a0f0a7df2480db8e68170bda70e5d');
INSERT INTO `man_system_roleright` VALUES ('0f87369b895d4a8a9c7b7c2678262770', 'fe23ba0cb85b40e7880c63d5326e3181', 'ef6a48aaf6974c21828c6b733a81e25b');
INSERT INTO `man_system_roleright` VALUES ('9caac6011747406aad7b1cd31b93358d', 'fe23ba0cb85b40e7880c63d5326e3181', 'f015b3e302cc4d5c95e55352b5889ea7');
INSERT INTO `man_system_roleright` VALUES ('4522d14ba70f4b76ae0f07b2ae58cf1e', 'fe23ba0cb85b40e7880c63d5326e3181', 'cc83f0cbaadb4df4a2e23b0a6542a76e');
INSERT INTO `man_system_roleright` VALUES ('fbc6646f747a4140861dd510db86abf6', 'fe23ba0cb85b40e7880c63d5326e3181', '9736ec8c6ef845539cf43a805eeb0ff5');
INSERT INTO `man_system_roleright` VALUES ('edf5f381efc44c06b0132cbf63e9ab5f', 'fe23ba0cb85b40e7880c63d5326e3181', '96d7b25b175d4a449b8f003885bee83b');
INSERT INTO `man_system_roleright` VALUES ('bd86e8057b7346abae643c2e07a1fc9a', 'fe23ba0cb85b40e7880c63d5326e3181', 'dca0cdc16c3b4569b7f352a39746b3d1');
INSERT INTO `man_system_roleright` VALUES ('5a0820f708c943a5913c430593706a3d', 'fe23ba0cb85b40e7880c63d5326e3181', '93296cf76664425c872611c07ce3a495');
INSERT INTO `man_system_roleright` VALUES ('55ef0e5af0794bd699be968f5431bcd9', 'fe23ba0cb85b40e7880c63d5326e3181', '7f75f02fcb2748fb88c863a93b722f61');
INSERT INTO `man_system_roleright` VALUES ('80428a52855440f98e99543f0e0fc0cf', 'fe23ba0cb85b40e7880c63d5326e3181', 'fc9c749ec4a249518c0df349727ce2c7');
INSERT INTO `man_system_roleright` VALUES ('69759dd1e5924086ad793449bdc606b3', 'fe23ba0cb85b40e7880c63d5326e3181', 'b5652eefc7f6424abdc18105eb4c3417');
INSERT INTO `man_system_roleright` VALUES ('193d205afbfe4a9f8d9cf6a0d14e4c00', 'fe23ba0cb85b40e7880c63d5326e3181', '6242e4cd98bb452ab4afd721b63435ca');
INSERT INTO `man_system_roleright` VALUES ('637606e8cbc74ae78e29a2d7d0d9f384', 'fe23ba0cb85b40e7880c63d5326e3181', '0dfb50c5926e410083e0a2aae18fb684');
INSERT INTO `man_system_roleright` VALUES ('4f0274fb7e4f414dbf826183d1b112c4', 'fe23ba0cb85b40e7880c63d5326e3181', '4f72edd47ab7413bae2cc49ea9c4c901');
INSERT INTO `man_system_roleright` VALUES ('dab5323a67d5402e8127d6301f726085', 'fe23ba0cb85b40e7880c63d5326e3181', '697dd6649227483694dabaa4c394b609');
INSERT INTO `man_system_roleright` VALUES ('2fc0a0c8c6c749df84925a486b2b02b2', 'fe23ba0cb85b40e7880c63d5326e3181', '2a9dd69254094a31b1bd86281024c43b');
INSERT INTO `man_system_roleright` VALUES ('40b9069585114b8c9f0d80617c67c1e6', 'fe23ba0cb85b40e7880c63d5326e3181', 'b41b81ba3ad64d7f8e6bd47930376763');
INSERT INTO `man_system_roleright` VALUES ('2405130cf89d45c198e309ee42a32c6a', 'fe23ba0cb85b40e7880c63d5326e3181', 'cf07ab7dff4a49fdbac21fa7acba1a36');
INSERT INTO `man_system_roleright` VALUES ('0eb76f5ee7254ceaa7d4e2372dc53bb9', 'fe23ba0cb85b40e7880c63d5326e3181', 'de77045af1634dbb9f5fda0b426d76d1');
INSERT INTO `man_system_roleright` VALUES ('391f609c16bb44a1bfa0c3b693ae6df4', 'fe23ba0cb85b40e7880c63d5326e3181', '380be447d80842c48e85778ea0119d3b');
INSERT INTO `man_system_roleright` VALUES ('a47b50d634cc48ae836e7c28f3034a48', 'fe23ba0cb85b40e7880c63d5326e3181', '02451e999a704cc6abbf848398bc2179');
INSERT INTO `man_system_roleright` VALUES ('2dff8b88433d4c3894f0bcccb65ab5ec', 'fe23ba0cb85b40e7880c63d5326e3181', '47372ce4d3994f31b8eb5b340c854ad6');
INSERT INTO `man_system_roleright` VALUES ('8281d5194f034c5ab494df28a3490670', 'fe23ba0cb85b40e7880c63d5326e3181', '666f5c429dd44e7ba40ba88e93af3dbf');
INSERT INTO `man_system_roleright` VALUES ('b0b4e2e8f05443408546454df84f4461', 'fe23ba0cb85b40e7880c63d5326e3181', 'db2d66544baa4343ad66dfe4a1e74c17');
INSERT INTO `man_system_roleright` VALUES ('e045f4a10a954d3d8e6f28b9648318f5', 'fe23ba0cb85b40e7880c63d5326e3181', 'a07c8a4bc20744bfb421f2932565a58a');
INSERT INTO `man_system_roleright` VALUES ('501c2be3610e4a4184b5dc52e92ae219', 'fe23ba0cb85b40e7880c63d5326e3181', '72d747a0a7e34031a00986307f32a77e');
INSERT INTO `man_system_roleright` VALUES ('a37e74c523b34816b0cc371210116e63', 'fe23ba0cb85b40e7880c63d5326e3181', 'e5b5caad68fc4ef78f527024823ff3b7');
INSERT INTO `man_system_roleright` VALUES ('f61fdc61d33549c68008d645269ca52d', 'fe23ba0cb85b40e7880c63d5326e3181', '7c808148ec314071a471d9a346934edb');
INSERT INTO `man_system_roleright` VALUES ('a7ad85ae655e4b3fbe6fa7eb84eca7d7', 'fe23ba0cb85b40e7880c63d5326e3181', '89724babbda149a7a593f929e02dfdb8');
INSERT INTO `man_system_roleright` VALUES ('135dd873abfb4f33bf21b717f4114acc', 'fe23ba0cb85b40e7880c63d5326e3181', '22be649cfe8d4957b073fb29f8c760fb');
INSERT INTO `man_system_roleright` VALUES ('db40d19d5eef49f88a677ed2a382a0b1', 'fe23ba0cb85b40e7880c63d5326e3181', 'c6e51e318e4b4e40a5178fde4fb34fe4');
INSERT INTO `man_system_roleright` VALUES ('4dd6d187cb144833bc8fad12c67c081f', 'fe23ba0cb85b40e7880c63d5326e3181', 'e340abc3fd4440d8bc3ce8f812d6444f');
INSERT INTO `man_system_roleright` VALUES ('d0e3cb8d6ace4b36986469e42e483564', 'fe23ba0cb85b40e7880c63d5326e3181', 'cd90029c507a46288cb3dab122fe5a99');
INSERT INTO `man_system_roleright` VALUES ('a7bc1002f4d747a987519ee15cec7aa2', 'fe23ba0cb85b40e7880c63d5326e3181', '689f66fe61d44e149db93fea869ea4f9');
INSERT INTO `man_system_roleright` VALUES ('402ebf5983ac493d8f2dd9195765d0c6', 'fe23ba0cb85b40e7880c63d5326e3181', '7ed0d74a704944fc9c2296732dbf313a');
INSERT INTO `man_system_roleright` VALUES ('45eed29871814c1d89439ff234ed4446', 'fe23ba0cb85b40e7880c63d5326e3181', 'ad696cf1cd87410db7f850972d5891f3');
INSERT INTO `man_system_roleright` VALUES ('21c2e31435e54c9daa789b977d2017a9', 'fe23ba0cb85b40e7880c63d5326e3181', '7ded595561314ba6b20cb091c8448799');
INSERT INTO `man_system_roleright` VALUES ('6e6fc07412ea4bd6ba454b7d2b352bb0', 'fe23ba0cb85b40e7880c63d5326e3181', 'b65f8696b7e645359459c880d6c9426b');
INSERT INTO `man_system_roleright` VALUES ('c54ed43e984c4b8bb5d9c10d527b8d75', 'fe23ba0cb85b40e7880c63d5326e3181', '0ddbcc8d592a4a1dac8839dd5c17fa50');
INSERT INTO `man_system_roleright` VALUES ('94a48bc98a494995964bd6369ae39c9c', 'fe23ba0cb85b40e7880c63d5326e3181', '4bb1c4cda79440ceb4dee0de5923dd01');
INSERT INTO `man_system_roleright` VALUES ('84c86e8c9b9b4a01ab1ab832b9d4bea6', 'fe23ba0cb85b40e7880c63d5326e3181', '8cb01c896ceb4958acc42ee8e2c75160');
INSERT INTO `man_system_roleright` VALUES ('f436576d842b49ba9e1546d8ffd94678', 'fe23ba0cb85b40e7880c63d5326e3181', '91f613d71c0248719bfda20d6078451f');
INSERT INTO `man_system_roleright` VALUES ('e8508bfaa4474b30a14d52b219755f34', 'fe23ba0cb85b40e7880c63d5326e3181', '96ef90d6924b4eada11ccfb6afffda12');
INSERT INTO `man_system_roleright` VALUES ('5f1220fff47a4f2b82d0b7e80a155461', 'fe23ba0cb85b40e7880c63d5326e3181', '322c915e28d94b199a9812dfb1d0a1af');

-- ----------------------------
-- Table structure for `man_system_user`
-- ----------------------------
DROP TABLE IF EXISTS `man_system_user`;
CREATE TABLE `man_system_user` (
  `billid` varchar(32) NOT NULL COMMENT '主键',
  `usercount` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '账号',
  `password` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '密码, sha1加密',
  `email` varchar(100) NOT NULL COMMENT '邮箱',
  `telphone` varchar(20) NOT NULL COMMENT '电话',
  `status` int(1) NOT NULL COMMENT '状态 0 正常 1 停用 9 删除',
  `insert_date` datetime DEFAULT NULL COMMENT '创建日期',
  `insert_user` varchar(32) DEFAULT NULL COMMENT '创建人',
  `usb_status` int(11) DEFAULT '0' COMMENT 'USB开启状态：0:未开启 1:开启',
  `displayname` varchar(100) DEFAULT NULL COMMENT '显示名称',
  `user_type` int(1) DEFAULT NULL COMMENT '用户类型',
  PRIMARY KEY (`billid`),
  UNIQUE KEY `usercount` (`usercount`),
  UNIQUE KEY `usercount_2` (`usercount`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_system_user
-- ----------------------------
 
-- ----------------------------
-- Table structure for `man_system_usergroup`
-- ----------------------------
DROP TABLE IF EXISTS `man_system_usergroup`;
CREATE TABLE `man_system_usergroup` (
  `billid` varchar(32) NOT NULL DEFAULT '' COMMENT '主键',
  `userid` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `groupid` varchar(32) DEFAULT NULL COMMENT '角色组ID',
  PRIMARY KEY (`billid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_system_usergroup
-- ---------------------------- 
-- ----------------------------
-- Table structure for `man_system_userrole`
-- ----------------------------
DROP TABLE IF EXISTS `man_system_userrole`;
CREATE TABLE `man_system_userrole` (
  `billid` varchar(32) NOT NULL DEFAULT '' COMMENT '主键',
  `userid` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `roleid` varchar(32) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`billid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_system_userrole
-- ----------------------------
 
-- ----------------------------
-- Table structure for `memory_package_option`
-- ----------------------------
DROP TABLE IF EXISTS `memory_package_option`;
CREATE TABLE `memory_package_option` (
  `id` char(32) NOT NULL,
  `memory` decimal(20,0) DEFAULT NULL COMMENT '内存，以字节为单位',
  `label` varchar(10) DEFAULT NULL COMMENT '内存对应的label，如：512MB、1GB、2GB',
  `sort` decimal(20,0) DEFAULT NULL COMMENT '排序序号',
  `create_time` char(17) DEFAULT NULL,
  `modified_time` char(17) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='内存参数选项';

-- ----------------------------
-- Records of memory_package_option
-- ----------------------------

-- ----------------------------
-- Table structure for `message_record`
-- ----------------------------
DROP TABLE IF EXISTS `message_record`;
CREATE TABLE `message_record` (
  `id` char(32) DEFAULT NULL,
  `sender_address` varchar(45) DEFAULT NULL,
  `recipient_address` varchar(255) DEFAULT NULL,
  `content` text,
  `create_time` char(17) DEFAULT NULL,
  `type` int(10) DEFAULT '0',
  `sms_state` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message_record
-- ----------------------------
 
-- ----------------------------
-- Table structure for `monitor_server`
-- ----------------------------
DROP TABLE IF EXISTS `monitor_server`;
CREATE TABLE `monitor_server` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `areaid` varchar(32) DEFAULT NULL COMMENT '区域ID',
  `roomid` varchar(32) DEFAULT NULL COMMENT '机房ID',
  `rackid` varchar(32) DEFAULT NULL COMMENT '机架ID',
  `serverid` varchar(50) DEFAULT NULL COMMENT '服务器ID',
  `servername` varchar(200) DEFAULT NULL COMMENT '服务器名',
  `cpu_usage` float(20,0) DEFAULT NULL COMMENT 'cpu利用率',
  `memory_usage` float(20,0) DEFAULT NULL COMMENT '内存利用率',
  `disk_usage` float(20,0) DEFAULT NULL COMMENT '盘磁利用率',
  `insert_date` datetime DEFAULT NULL COMMENT '插入日期',
  `monitor_type` varchar(20) DEFAULT NULL COMMENT '监控类型(故障还是告警)',
  `server_type` varchar(20) DEFAULT NULL COMMENT '服务器类型(服务器OR云主机)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of monitor_server
-- ----------------------------

-- ----------------------------
-- Table structure for `monitor_server_temp`
-- ----------------------------
DROP TABLE IF EXISTS `monitor_server_temp`;
CREATE TABLE `monitor_server_temp` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `serverid` varchar(50) DEFAULT NULL COMMENT '服务器ID',
  `cpu_usage` float(20,0) DEFAULT NULL COMMENT 'cpu利用率',
  `memory_usage` float(20,0) DEFAULT NULL COMMENT '内存利用率',
  `disk_usage` float(20,0) DEFAULT NULL COMMENT '磁盘利用率',
  `monitor_type` varchar(20) DEFAULT NULL COMMENT '监控类型(故障还是告警)',
  `server_type` varchar(20) DEFAULT NULL COMMENT '服务器类型(服务器OR云主机)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of monitor_server_temp
-- ----------------------------

-- ----------------------------
-- Table structure for `monitor_shield`
-- ----------------------------
DROP TABLE IF EXISTS `monitor_shield`;
CREATE TABLE `monitor_shield` (
  `uuid` varchar(36) NOT NULL COMMENT '对象的主键uuid',
  `shield` varchar(1) DEFAULT NULL COMMENT '是否被屏蔽(0 未屏蔽，1 屏蔽)',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of monitor_shield
-- ---------------------------- 

-- ----------------------------
-- Table structure for `oper_log`
-- ----------------------------
DROP TABLE IF EXISTS `oper_log`;
CREATE TABLE `oper_log` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL COMMENT '操作的用户',
  `oper_time` varchar(17) DEFAULT NULL COMMENT '操作时间',
  `user_ip` varchar(20) DEFAULT NULL COMMENT '用户IP',
  `module` varchar(50) DEFAULT NULL COMMENT '模块名',
  `content` varchar(500) DEFAULT NULL COMMENT '操作的内容',
  `status` int(11) DEFAULT NULL COMMENT '操作状态 1:成功 2：失败 3：异步',
  `level` int(11) DEFAULT NULL COMMENT '操作等级 1：一般 2：敏感 3：高危',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oper_log
-- ----------------------------
 
-- ----------------------------
-- Table structure for `pool_max_creating`
-- ----------------------------
DROP TABLE IF EXISTS `pool_max_creating`;
CREATE TABLE `pool_max_creating` (
  `pool_id` varchar(36) NOT NULL DEFAULT '',
  `pool_name` varchar(50) DEFAULT NULL,
  `max_creating` int(2) DEFAULT NULL,
  PRIMARY KEY (`pool_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pool_max_creating
-- ----------------------------

-- ----------------------------
-- Table structure for `qos_setting`
-- ----------------------------
DROP TABLE IF EXISTS `qos_setting`;
CREATE TABLE `qos_setting` (
  `id` char(32) NOT NULL COMMENT 'ID',
  `uuid` char(36) NOT NULL COMMENT '云主机真实ID',
  `host_name` varchar(100) DEFAULT NULL COMMENT '服务器名',
  `type` int(11) NOT NULL COMMENT '1：云桌面 2：云服务器 3：专属云',
  `name` varchar(45) NOT NULL COMMENT '规则名',
  `ip` varchar(15) NOT NULL COMMENT '云主机IP',
  `server_ip` varchar(15) NOT NULL COMMENT '所属服务器（宿主机）IP',
  `inbound_bandwidth` decimal(20,0) NOT NULL COMMENT '入口带宽，单位：字节',
  `outbound_bandwidth` decimal(20,0) NOT NULL COMMENT '出口带宽，单位：字节',
  `max_iops` int(11) NOT NULL COMMENT '最大云主机最',
  `priority` int(11) NOT NULL COMMENT 'cpu优先级：0=高优先<默认> 1=中优先 2=低优先',
  `create_time` char(17) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='QoS规则';

-- ----------------------------
-- Records of qos_setting
-- ----------------------------

-- ----------------------------
-- Table structure for `set_time_operation_detail`
-- ----------------------------
DROP TABLE IF EXISTS `set_time_operation_detail`;
CREATE TABLE `set_time_operation_detail` (
  `id` varchar(32) DEFAULT '',
  `display_name` varchar(100) DEFAULT NULL,
  `status` int(1) DEFAULT '1',
  `host_id` varchar(32) DEFAULT NULL,
  `type` int(10) DEFAULT NULL,
  `create_time` varchar(17) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of set_time_operation_detail
-- ---------------------------- 
-- ----------------------------
-- Table structure for `shared_memory`
-- ----------------------------
DROP TABLE IF EXISTS `shared_memory`;
CREATE TABLE `shared_memory` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `name` varchar(50) DEFAULT NULL COMMENT '路径名称',
  `url` varchar(200) DEFAULT NULL COMMENT '路径URL',
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `secretkey` varchar(200) DEFAULT NULL COMMENT '秘钥',
  `insert_user` varchar(32) DEFAULT NULL COMMENT '创建人',
  `insert_date` datetime DEFAULT NULL COMMENT '创建时间',
  `available` varchar(10) DEFAULT NULL COMMENT '是否为可用:yes 可用，null 不可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shared_memory
-- ----------------------------

-- ----------------------------
-- Table structure for `sms_config`
-- ----------------------------
DROP TABLE IF EXISTS `sms_config`;
CREATE TABLE `sms_config` (
  `id` char(32) NOT NULL DEFAULT '',
  `sms_id` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `create_time` varchar(45) DEFAULT NULL,
  `service_url` varchar(80) DEFAULT NULL,
  `config_name` varchar(45) DEFAULT NULL,
  `modified_time` char(17) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sms_config
-- ----------------------------
INSERT INTO `sms_config` VALUES ('0b04cb0090374a7b98e9291f78dbca17', '1019', 'ld2', 'DA51D4679A905CC180C10AECA121DECD', '20150816222127037', 'http://sms.gknet.com.cn:8180/Service.asmx/SendMessage', '系统通知', '20151120111140048');
INSERT INTO `sms_config` VALUES ('cd15ef02e0f34c96924c5085371fbfd7', '9803', 'lddddd', '1224432434', '20150824103538436', 'http://127.0.0.1/message/service', '配置', '20150824103538436');

-- ----------------------------
-- Table structure for `sms_template`
-- ----------------------------
DROP TABLE IF EXISTS `sms_template`;
CREATE TABLE `sms_template` (
  `id` char(32) NOT NULL DEFAULT '',
  `config_id` char(32) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `recipient` varchar(45) DEFAULT NULL,
  `content` text,
  `create_time` char(17) DEFAULT NULL,
  `modified_time` char(17) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sms_template
-- ----------------------------
INSERT INTO `sms_template` VALUES ('48039987f7f046ea81ec4603e2236cd7', '0b04cb0090374a7b98e9291f78dbca17', 'MONITOR_NOTIFY', '15928003743', '${content}', '20150825172906381', '20151022101556168', '监控短信模板');
INSERT INTO `sms_template` VALUES ('708363dddc1c47c2ab07e129bd56b48a', '0b04cb0090374a7b98e9291f78dbca17', 'DB_WARN', '15928003743', '【致云科技】 ${region}数据库故障，请及早排查处理', '20150817163036151', '20151022142051315', '数据库故障告警通知');

-- ----------------------------
-- Table structure for `sys_disk_image`
-- ----------------------------
DROP TABLE IF EXISTS `sys_disk_image`;
CREATE TABLE `sys_disk_image` (
  `id` char(32) NOT NULL,
  `real_image_id` char(36) DEFAULT NULL COMMENT '真正的磁盘镜像的id',
  `name` varchar(100) DEFAULT NULL COMMENT '镜像名称',
  `display_name` varchar(100) DEFAULT NULL COMMENT '显示名称',
  `from_host_id` char(32) DEFAULT NULL COMMENT '从哪部云主机制作此镜像',
  `type` int(11) DEFAULT NULL COMMENT '镜像类型：0：系统默认 1:从云主机创建 2:镜像上传',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `user_id` char(32) DEFAULT NULL COMMENT '创建人ID',
  `sort` int(11) DEFAULT NULL COMMENT '排序序号',
  `status` int(11) DEFAULT '1' COMMENT '状态：1：未验证 2：已验证可创建云主机',
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  `modified_time` char(17) DEFAULT NULL,
  `image_type` int(11) DEFAULT '1' COMMENT '镜像类型：\r\n            1：通用镜像\r\n            2：桌面云专用镜像\r\n            3：云主机专用镜像\r\n            4：VPC专用镜像',
  `file_type` int(1) DEFAULT '0' COMMENT '磁盘镜像格式 0=raw，1=qcow2.',
  `size` decimal(30,0) DEFAULT NULL COMMENT '镜像大小',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='镜像表';

-- ----------------------------
-- Records of sys_disk_image
-- ---------------------------- 
-- ----------------------------
-- Table structure for `sys_group`
-- ----------------------------
DROP TABLE IF EXISTS `sys_group`;
CREATE TABLE `sys_group` (
  `id` char(32) NOT NULL COMMENT 'ID',
  `group_name` varchar(100) DEFAULT NULL COMMENT '群组名',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `parent_id` char(32) DEFAULT NULL COMMENT '上级分组',
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  `modified_time` char(17) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='群组';

-- ----------------------------
-- Records of sys_group
-- ---------------------------- 
-- ----------------------------
-- Table structure for `sys_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` varchar(32) NOT NULL,
  `oper_time` varchar(17) DEFAULT NULL COMMENT '操作时间',
  `content` varchar(500) DEFAULT NULL COMMENT '操作的内容',
  `status` int(11) DEFAULT NULL COMMENT '操作状态 1:成功 2：失败 3:异步',
  `level` int(11) DEFAULT NULL COMMENT '操作等级 1：一般 2：敏感 3：高危',
  `module` varchar(50) DEFAULT NULL COMMENT '操作的模块',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_tenant`
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant` (
  `id` varchar(32) NOT NULL DEFAULT '' COMMENT 'ID',
  `name` varchar(64) DEFAULT NULL COMMENT '名称',
  `remark` varchar(1024) DEFAULT NULL COMMENT '说明',
  `cpu` int(11) DEFAULT '0' COMMENT '个数',
  `mem` decimal(20,0) DEFAULT '0' COMMENT '内存',
  `bandwidth` decimal(20,0) DEFAULT NULL,
  `disk` decimal(20,0) DEFAULT '0' COMMENT '硬盘',
  `status` int(1) DEFAULT '0' COMMENT '状态 0 正常 1 停用 9 删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='租户管理';

-- ----------------------------
-- Records of sys_tenant
-- ---------------------------- 
-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` char(32) NOT NULL,
  `type` int(11) DEFAULT NULL COMMENT '系统用户类型：1：管理员  2：终端用户',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '用户名，用于登录系统',
  `password` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '密码, sha1加密',
  `group_id` char(32) DEFAULT NULL COMMENT '所属群组与sys_group的id关联',
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  `modified_time` char(17) DEFAULT NULL COMMENT '修改时间',
  `alias` varchar(100) DEFAULT NULL COMMENT '别名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
 
-- ----------------------------
-- Table structure for `sys_warnrule`
-- ----------------------------
DROP TABLE IF EXISTS `sys_warnrule`;
CREATE TABLE `sys_warnrule` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `name` varchar(100) DEFAULT NULL COMMENT '规则名称',
  `code` varchar(20) DEFAULT NULL COMMENT '唯一编码',
  `content` varchar(2000) DEFAULT NULL COMMENT '显示内容',
  `ruletype` int(1) DEFAULT NULL COMMENT '规则类型(0、警告 1、故障)',
  `isnotify` varchar(1) DEFAULT NULL COMMENT '是否发送通知(1、是 0、否)',
  `frequency` varchar(20) DEFAULT NULL COMMENT '采样频率',
  `sampletime` int(9) DEFAULT NULL COMMENT '采样次数',
  `realtime` varchar(1) DEFAULT NULL COMMENT '定时发送还是实时发送(1、定时 2、实时)',
  `sendtime` varchar(20) DEFAULT NULL COMMENT '定时发送时间',
  `notify_phone` varchar(32) DEFAULT NULL COMMENT '通知电话',
  `notify_email` varchar(100) DEFAULT NULL COMMENT '通知邮箱',
  `insert_user` varchar(32) DEFAULT NULL COMMENT '创建人',
  `insert_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_warnrule
-- ----------------------------
INSERT INTO `sys_warnrule` VALUES ('3d8d24d0e9bc4ad9a73c0e5882950639', 'web监控告警规则', 'monitor_rule_warn', null, '0', '0', '60', '3', '1', '12:00:00', '15928003743', 'lshaowei@zhicloud.com', 'fed6c5aeaf5a4e5da21abcc3b250e75e', '2015-07-15 15:55:37');
INSERT INTO `sys_warnrule` VALUES ('448df06dd0494bc9a779273c026ea5b2', 'web监控故障规则', 'monitor_rule_error', null, '1', '0', '10', '3', '2', null, '15928003743', 'lshaowei@zhicloud.com', 'fed6c5aeaf5a4e5da21abcc3b250e75e', '2015-07-16 14:51:45');

-- ----------------------------
-- Table structure for `sys_warnvalue`
-- ----------------------------
DROP TABLE IF EXISTS `sys_warnvalue`;
CREATE TABLE `sys_warnvalue` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `code` varchar(50) DEFAULT NULL COMMENT 'code',
  `operator` varchar(32) DEFAULT NULL COMMENT '操作符',
  `value` varchar(32) DEFAULT NULL COMMENT '值',
  `contact` varchar(10) DEFAULT NULL COMMENT '连接符(And||Or)',
  `sort` int(9) DEFAULT NULL COMMENT '顺序',
  `ruleid` varchar(32) DEFAULT NULL COMMENT '规则ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_warnvalue
-- ----------------------------
INSERT INTO `sys_warnvalue` VALUES ('e1f180a4782a4d4d896ce099c2e02cb8', '硬盘利用率', 'disk_usage', 'between', '0.5-0.8', '', '3', '3d8d24d0e9bc4ad9a73c0e5882950639');
INSERT INTO `sys_warnvalue` VALUES ('66b8a7efc06e486891b79a82c26e197f', '内存利用率', 'memory_usage', 'between', '0.5-0.8', 'or', '2', '3d8d24d0e9bc4ad9a73c0e5882950639');
INSERT INTO `sys_warnvalue` VALUES ('e676dc49df294e338bc2c13e7fbc7e6c', 'CPU利用率', 'cpu_usage', 'between', '0.5-0.8', 'or', '1', '3d8d24d0e9bc4ad9a73c0e5882950639');
INSERT INTO `sys_warnvalue` VALUES ('ddf5e65de2d9441a82cd36d9d8688bea', '磁盘利用率', 'disk_usage', 'high', '0.9', '', '3', '448df06dd0494bc9a779273c026ea5b2');
INSERT INTO `sys_warnvalue` VALUES ('a967a22c9f8143839dd491b033b54401', '内存利用率', 'memory_usage', 'high', '0.9', 'or', '2', '448df06dd0494bc9a779273c026ea5b2');
INSERT INTO `sys_warnvalue` VALUES ('266c4a6e827547be9e2eb420aeaf4c57', 'CPU利用率', 'cpu_usage', 'high', '0.9', 'or', '1', '448df06dd0494bc9a779273c026ea5b2');

-- ----------------------------
-- Table structure for `terminal_box`
-- ----------------------------
DROP TABLE IF EXISTS `terminal_box`;
CREATE TABLE `terminal_box` (
  `id` char(32) NOT NULL COMMENT 'ID',
  `serial_number` varchar(45) DEFAULT NULL COMMENT '盒子编号',
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  `allocate_user_id` char(32) DEFAULT NULL COMMENT '分配用户ID',
  `allocate_time` char(17) DEFAULT NULL COMMENT '分配时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态 0：未分配 1：已分配',
  `modified_time` char(17) DEFAULT NULL COMMENT '修改时间',
  `name` varchar(45) DEFAULT NULL COMMENT '终端盒子名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `no_UNIQUE` (`serial_number`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of terminal_box
-- ---------------------------- 
-- ----------------------------
-- Table structure for `terminal_information_push`
-- ----------------------------
DROP TABLE IF EXISTS `terminal_information_push`;
CREATE TABLE `terminal_information_push` (
  `id` varchar(32) NOT NULL DEFAULT '',
  `group_id` varchar(32) DEFAULT NULL COMMENT '发送对象（按照群组），无则表明发送全部',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `content` varchar(500) DEFAULT NULL COMMENT '内容',
  `create_time` varchar(17) DEFAULT NULL COMMENT '创建日期',
  `region` varchar(45) DEFAULT NULL COMMENT '地区',
  `industry` varchar(45) DEFAULT NULL COMMENT '行业',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of terminal_information_push
-- ----------------------------
 
-- ----------------------------
-- Table structure for `terminal_user`
-- ----------------------------
DROP TABLE IF EXISTS `terminal_user`;
CREATE TABLE `terminal_user` (
  `id` char(32) NOT NULL COMMENT '在系统用户表须有一条id一样的记录',
  `name` varchar(100) DEFAULT NULL COMMENT '显示名',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `usb_status` int(11) DEFAULT '0' COMMENT 'USB开启状态：0:未开启 1:开启',
  `status` int(11) DEFAULT '0' COMMENT '用户状态：0:正常 1:禁用',
  `create_time` char(17) DEFAULT NULL,
  `modified_time` char(17) DEFAULT NULL,
  `cloud_host_amount` int(11) DEFAULT '0' COMMENT '已分配主机数',
  `region` varchar(45) DEFAULT NULL COMMENT '地区',
  `industry` varchar(45) DEFAULT NULL COMMENT '行业',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='终端用户表';

-- ----------------------------
-- Records of terminal_user
-- ----------------------------
 
-- ----------------------------
-- Table structure for `timer_info`
-- ----------------------------
DROP TABLE IF EXISTS `timer_info`;
CREATE TABLE `timer_info` (
  `id` varchar(32) NOT NULL DEFAULT '' COMMENT '操作的对象的id',
  `status` int(1) DEFAULT NULL COMMENT '定时器状态：1、启用\r\n                  2、禁用',
  `timer_key` varchar(50) DEFAULT NULL COMMENT '表示属于哪种定时器：1、定时备份定时器 back_up_timer  2、开机定时器 startup_timer 3、关机定时器 shutdonw_timer',
  `disk` int(11) DEFAULT NULL COMMENT '0',
  `mode` int(11) DEFAULT NULL COMMENT '0',
  `type` int(11) DEFAULT NULL COMMENT '1:月定时器\r\n2:周定时器\r\n3:日定时器',
  `week` int(10) DEFAULT NULL COMMENT '每周周几',
  `day` int(11) DEFAULT NULL COMMENT '每月多少号',
  `hour` int(11) DEFAULT NULL COMMENT '时',
  `minute` int(11) DEFAULT NULL COMMENT '分',
  `second` int(11) DEFAULT NULL COMMENT '秒',
  `obj_id` varchar(32) DEFAULT NULL COMMENT '对应对象ID',
  `create_time` varchar(17) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of timer_info
-- ----------------------------
 
-- ----------------------------
-- Table structure for `user_tenant_relationship`
-- ----------------------------
DROP TABLE IF EXISTS `user_tenant_relationship`;
CREATE TABLE `user_tenant_relationship` (
  `id` varchar(32) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL COMMENT 'man_system_user的id',
  `tenant_id` varchar(32) DEFAULT NULL COMMENT 'sys_tenant的id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_tenant_relationship
-- ----------------------------
 
-- ----------------------------
-- Table structure for `version_record`
-- ----------------------------
DROP TABLE IF EXISTS `version_record`;
CREATE TABLE `version_record` (
  `id` varchar(32) NOT NULL,
  `version_number` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `update_info` varchar(200) DEFAULT NULL,
  `create_time` varchar(17) DEFAULT NULL,
  `fsize` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of version_record
-- ----------------------------
 
-- ----------------------------
-- Table structure for `vpc_base_info`
-- ----------------------------
DROP TABLE IF EXISTS `vpc_base_info`;
CREATE TABLE `vpc_base_info` (
  `id` char(32) NOT NULL COMMENT 'ID',
  `real_vpc_id` char(36) DEFAULT NULL COMMENT '真实VPC的ID',
  `user_id` char(32) DEFAULT NULL COMMENT '对应用户ID',
  `name` varchar(100) NOT NULL COMMENT 'VPC名称',
  `display_name` varchar(100) DEFAULT NULL COMMENT '显示名称',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `status` int(11) DEFAULT '1' COMMENT '状态：1 启用 2 暂停 3 关闭',
  `host_amount` int(11) DEFAULT '0' COMMENT '绑定云主机个数',
  `ip_amount` int(11) DEFAULT '0' COMMENT '绑定IP个数',
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  `modified_time` char(17) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='VPC基本信息';

-- ----------------------------
-- Records of vpc_base_info
-- ----------------------------
 
-- ----------------------------
-- Table structure for `vpc_bill_detail`
-- ----------------------------
DROP TABLE IF EXISTS `vpc_bill_detail`;
CREATE TABLE `vpc_bill_detail` (
  `id` char(32) NOT NULL DEFAULT '' COMMENT 'ID',
  `vpc_id` char(32) DEFAULT NULL COMMENT '对应VPC的ID',
  `host_amount` int(11) DEFAULT NULL COMMENT '绑定云主机个数',
  `ip_amount` int(11) DEFAULT NULL,
  `start_time` char(17) DEFAULT NULL COMMENT '开启时间',
  `end_time` char(17) DEFAULT NULL COMMENT '关闭时间',
  `fee` decimal(10,2) DEFAULT NULL COMMENT '费用',
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  `is_paid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='VPC账单明细';

-- ----------------------------
-- Records of vpc_bill_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `vpc_bind_host`
-- ----------------------------
DROP TABLE IF EXISTS `vpc_bind_host`;
CREATE TABLE `vpc_bind_host` (
  `id` char(32) NOT NULL COMMENT 'ID',
  `vpc_id` char(32) DEFAULT NULL COMMENT '所属VPC的ID',
  `host_id` char(32) DEFAULT NULL COMMENT '绑定云主机ID',
  `flag` int(11) DEFAULT NULL COMMENT '删除标志位：0：未删除 1：已删除',
  `create_time` char(17) DEFAULT NULL COMMENT '绑定时间',
  `remove_time` char(17) DEFAULT NULL COMMENT '解绑时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='VPC绑定云主机';

-- ----------------------------
-- Records of vpc_bind_host
-- ----------------------------
 
-- ----------------------------
-- Table structure for `vpc_bind_port`
-- ----------------------------
DROP TABLE IF EXISTS `vpc_bind_port`;
CREATE TABLE `vpc_bind_port` (
  `id` char(32) NOT NULL DEFAULT '' COMMENT 'ID',
  `vpc_id` char(32) DEFAULT NULL COMMENT '所属VPC的ID',
  `host_id` char(32) DEFAULT NULL COMMENT '所属host的ID',
  `outer_ip` varchar(15) DEFAULT NULL COMMENT '外网IP',
  `outer_port` int(11) DEFAULT NULL COMMENT '外网端口',
  `host_port` int(11) DEFAULT NULL COMMENT '内网端口',
  `protocol` int(11) DEFAULT NULL COMMENT '协议',
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  `flag` int(1) DEFAULT '1' COMMENT '标示 1：主动绑定，0 默认绑定',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='VPC绑定端口';

-- ----------------------------
-- Records of vpc_bind_port
-- ----------------------------

-- ----------------------------
-- Table structure for `vpc_outer_ip`
-- ----------------------------
DROP TABLE IF EXISTS `vpc_outer_ip`;
CREATE TABLE `vpc_outer_ip` (
  `id` char(32) NOT NULL COMMENT 'ID',
  `vpc_id` char(32) DEFAULT NULL COMMENT '对应VPC的ID',
  `ip` varchar(15) DEFAULT NULL,
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='VPC外网端口';

-- ----------------------------
-- Records of vpc_outer_ip
-- ----------------------------
 
-- ----------------------------
-- Table structure for `whitelist`
-- ----------------------------
DROP TABLE IF EXISTS `whitelist`;
CREATE TABLE `whitelist` (
  `rule_id` varchar(32) NOT NULL,
  `rule_name` varchar(50) DEFAULT NULL COMMENT '规则名',
  `rule_ip` varchar(50) DEFAULT NULL COMMENT 'ip或ip网段',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of whitelist
-- ----------------------------
