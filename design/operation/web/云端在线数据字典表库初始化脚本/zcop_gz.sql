/*
Navicat MySQL Data Transfer

Source Server         : 172.18.10.18
Source Server Version : 50626
Source Host           : 172.18.10.18:3306
Source Database       : zcop_gz

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2016-01-04 14:33:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `account_balance_detail`
-- ----------------------------
DROP TABLE IF EXISTS `account_balance_detail`;
CREATE TABLE `account_balance_detail` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '类型：\n            1：充值\n            2：消费',
  `amount` decimal(20,2) DEFAULT NULL COMMENT '变动的金额',
  `balance_before_change` decimal(20,2) DEFAULT NULL COMMENT '变动之前的余额',
  `balance_after_change` decimal(20,2) DEFAULT NULL COMMENT '变动之后的余额',
  `pay_type` int(11) NOT NULL COMMENT '支付类型：\n            1：支付宝\n            2：银联\n            3：系统赠送\n            4：系统扣费\n            5：现金券兑换',
  `description` varchar(100) DEFAULT NULL COMMENT '用于描述余额变动的原因',
  `change_time` varchar(17) DEFAULT NULL COMMENT '余额变动的时间',
  `invoice_id` varchar(32) DEFAULT NULL COMMENT '如果已开发票，刚不为空',
  `bill_id` varchar(32) DEFAULT NULL COMMENT '账单id，如果是消费记录，此字段不为空',
  `recharge_status` int(11) DEFAULT NULL COMMENT '1：未支付，\n            2：已支付',
  `gift_amount` decimal(20,2) DEFAULT NULL,
  `resource_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`,`pay_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_balance_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `agent`
-- ----------------------------
DROP TABLE IF EXISTS `agent`;
CREATE TABLE `agent` (
  `id` varchar(32) NOT NULL COMMENT '在系统用户表须有一条id一样的记录',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL COMMENT '电话号码',
  `status` int(11) DEFAULT NULL COMMENT '状态\n            1:正常\n            2：禁用\n            3：结束\n            ',
  `belonging_id` varchar(32) DEFAULT NULL,
  `create_time` varchar(17) DEFAULT NULL,
  `account_balance` decimal(20,2) DEFAULT '0.00' COMMENT '账户余额',
  `percent_off` decimal(5,2) DEFAULT '0.00',
  `balance_update_time` varchar(17) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of agent
-- ----------------------------

-- ----------------------------
-- Table structure for `backup_record`
-- ----------------------------
DROP TABLE IF EXISTS `backup_record`;
CREATE TABLE `backup_record` (
  `id` varchar(36) NOT NULL COMMENT '存放该云主机real_host_id',
  `mode` int(11) DEFAULT NULL COMMENT '备份类型',
  `disk` int(11) DEFAULT NULL COMMENT '备份盘',
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='备份纪录';

-- ----------------------------
-- Records of backup_record
-- ----------------------------

-- ----------------------------
-- Table structure for `bandwidth_package_option`
-- ----------------------------
DROP TABLE IF EXISTS `bandwidth_package_option`;
CREATE TABLE `bandwidth_package_option` (
  `id` varchar(32) NOT NULL,
  `min` decimal(20,0) DEFAULT NULL COMMENT '单位为bps',
  `max` decimal(20,0) DEFAULT NULL COMMENT '单位为bps',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bandwidth_package_option
-- ----------------------------
INSERT INTO `bandwidth_package_option` VALUES ('4832a71689644776b6bc7840be9798ba', '1000000', '100000000');

-- ----------------------------
-- Table structure for `bill`
-- ----------------------------
DROP TABLE IF EXISTS `bill`;
CREATE TABLE `bill` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL COMMENT '表示账单是谁的',
  `fee` decimal(20,2) DEFAULT NULL COMMENT '账单的费用',
  `is_paid` int(11) DEFAULT NULL COMMENT '是否已费：\n            1：未付费\n            2：已付费',
  `payable_time` varchar(17) DEFAULT NULL COMMENT '应付费时间',
  `payment_time` varchar(17) DEFAULT NULL COMMENT '实际付费时间',
  `create_time` varchar(17) DEFAULT NULL COMMENT '创建这条记录的时间',
  `region` int(2) DEFAULT NULL,
  `resource_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bill
-- ----------------------------

-- ----------------------------
-- Table structure for `bill_detail`
-- ----------------------------
DROP TABLE IF EXISTS `bill_detail`;
CREATE TABLE `bill_detail` (
  `id` varchar(32) NOT NULL,
  `bill_id` varchar(32) DEFAULT NULL,
  `item_type` int(11) DEFAULT NULL COMMENT '物品类别：\n            1：云主机\n            2：存储服务',
  `item_id` varchar(32) DEFAULT NULL COMMENT '物品的id，\n            如果是云主机，对应“云主机选购配置”的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bill_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `cash_coupon`
-- ----------------------------
DROP TABLE IF EXISTS `cash_coupon`;
CREATE TABLE `cash_coupon` (
  `id` varbinary(32) NOT NULL,
  `creater_id` varbinary(32) DEFAULT NULL,
  `user_id` varbinary(32) DEFAULT NULL,
  `cash_code` varbinary(32) DEFAULT NULL COMMENT '现金券兑换码',
  `money` decimal(20,2) DEFAULT NULL COMMENT '现金券对应的价值',
  `create_time` varbinary(17) DEFAULT NULL,
  `deadline` varbinary(17) DEFAULT NULL,
  `send_time` varbinary(17) DEFAULT NULL,
  `phone` varbinary(20) DEFAULT NULL,
  `email` varbinary(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '状态\n            1、未发送\n            2、已发送\n            3、已过期\n            4、已使用',
  `send_address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cash_coupon
-- ----------------------------

-- ----------------------------
-- Table structure for `cloud_disk`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_disk`;
CREATE TABLE `cloud_disk` (
  `id` varchar(32) NOT NULL,
  `real_disk_id` varchar(36) DEFAULT NULL COMMENT '对应后台真实云存储的uuid',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `name` varchar(100) DEFAULT NULL COMMENT '机器名',
  `account` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL COMMENT '可以为明文',
  `disk` decimal(30,0) DEFAULT NULL COMMENT '系统磁盘容量，以字节为单位',
  `running_status` int(11) DEFAULT NULL COMMENT '运行状态：1: 关机，2: 启动3: 告警，4: 故障',
  `status` int(11) DEFAULT NULL COMMENT '状态：1: 正常  2: 停机3：欠费 4：永久停机，已删除',
  `inner_ip` varchar(15) DEFAULT NULL COMMENT '内网监控地址ip',
  `inner_port` int(11) DEFAULT NULL COMMENT '内网监控地址端口',
  `outer_ip` varchar(15) DEFAULT NULL COMMENT '公网监控地址ip',
  `outer_port` int(11) DEFAULT NULL COMMENT '公网监控地址端口',
  `create_time` varchar(17) DEFAULT NULL COMMENT '云硬盘创建成功的时间',
  `inactivate_time` varchar(17) DEFAULT NULL COMMENT '停机时间',
  `reactivate_time` varchar(17) DEFAULT NULL COMMENT '停机恢复的时间',
  `monthly_price` decimal(10,2) DEFAULT NULL,
  `region` int(11) DEFAULT NULL COMMENT '地域：1：广州 2：成都  3：北京 4：香港',
  `iqn` varchar(128) DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `type` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_disk
-- ----------------------------

-- ----------------------------
-- Table structure for `cloud_disk_bill_detail`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_disk_bill_detail`;
CREATE TABLE `cloud_disk_bill_detail` (
  `id` varchar(32) NOT NULL,
  `disk_id` varchar(32) DEFAULT NULL,
  `disk` decimal(30,0) DEFAULT NULL COMMENT '硬盘容量 字节',
  `start_time` varchar(17) DEFAULT NULL,
  `end_time` varchar(17) DEFAULT NULL,
  `fee` decimal(10,2) DEFAULT NULL,
  `create_time` varchar(17) DEFAULT NULL,
  `is_paid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_disk_bill_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `cloud_disk_shopping_config`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_disk_shopping_config`;
CREATE TABLE `cloud_disk_shopping_config` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL COMMENT '表示是哪个用户的云硬盘',
  `disk_id` varchar(32) DEFAULT NULL COMMENT '关联cloud_disk',
  `disk` decimal(30,0) DEFAULT NULL COMMENT '硬盘容量，单位为byte',
  `start_time` varchar(17) DEFAULT NULL,
  `end_time` varchar(17) DEFAULT NULL,
  `price` decimal(20,2) DEFAULT NULL COMMENT '定价',
  `create_time` varchar(17) DEFAULT NULL,
  `process_status` int(11) DEFAULT NULL COMMENT '处理状态：0：未处理 1：成功 2：失败 3：正在创建',
  `process_message` varchar(100) DEFAULT NULL COMMENT '处理信息',
  `region` char(10) DEFAULT NULL COMMENT '地域：1：广州 2：成都  3：北京4：香港',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_disk_shopping_config
-- ----------------------------

-- ----------------------------
-- Table structure for `cloud_host`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_host`;
CREATE TABLE `cloud_host` (
  `id` varchar(32) NOT NULL,
  `real_host_id` varchar(36) DEFAULT NULL COMMENT '对应后台真实云主机的uuid',
  `type` int(11) DEFAULT NULL COMMENT '类型：\n            1：运营商自用\n            2：代理商自用\n            3：终端用户云主机\n            4：仓库云主机\n            ',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `host_name` varchar(100) DEFAULT NULL COMMENT '机器名',
  `account` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL COMMENT '可以为明文',
  `cpu_core` int(11) DEFAULT NULL COMMENT 'cpu核心数量',
  `memory` decimal(30,0) DEFAULT NULL COMMENT '内存，以字节为单位',
  `sys_image_id` varchar(32) DEFAULT NULL COMMENT '操作镜像id',
  `sys_disk` decimal(30,0) DEFAULT NULL COMMENT '系统磁盘容量，以字节为单位',
  `data_disk` decimal(30,0) DEFAULT NULL COMMENT '数据磁盘容量，以字节为单位',
  `bandwidth` decimal(20,0) DEFAULT NULL COMMENT '网络带宽，单位bps',
  `is_auto_startup` int(11) DEFAULT NULL COMMENT '是否自动启动：\n            1、是\n            2、否',
  `running_status` int(11) DEFAULT NULL COMMENT '运行状态：\n            1: 关机\n            2: 启动\n            3: 告警\n            4: 故障',
  `status` int(11) DEFAULT NULL COMMENT '状态：\n            1: 正常\n            2: 停机\n            3：欠费\n            4：永久停机，云主机已删除',
  `inner_ip` varchar(15) DEFAULT NULL COMMENT '内网监控地址ip',
  `inner_port` int(11) DEFAULT NULL COMMENT '内网监控地址端口',
  `outer_ip` varchar(15) DEFAULT NULL COMMENT '公网监控地址ip',
  `outer_port` int(11) DEFAULT NULL COMMENT '公网监控地址端口',
  `create_time` varchar(17) DEFAULT NULL COMMENT '云主机创建成功的时间',
  `inactivate_time` varchar(17) DEFAULT NULL COMMENT '停机时间',
  `reactivate_time` varchar(17) DEFAULT NULL COMMENT '停机恢复的时间',
  `monthly_price` decimal(10,2) DEFAULT NULL,
  `region` int(11) DEFAULT NULL COMMENT '地域：\n            1：广州\n            2：成都\n            3：北京\n            4：香港',
  `sys_image_name` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `package_id` varchar(32) DEFAULT NULL,
  `vpc_ip` varchar(15) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_host
-- ----------------------------

-- ----------------------------
-- Table structure for `cloud_host_bill_detail`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_host_bill_detail`;
CREATE TABLE `cloud_host_bill_detail` (
  `id` varchar(32) NOT NULL,
  `host_id` varchar(32) DEFAULT NULL COMMENT '云主机的id',
  `type` int(11) DEFAULT NULL COMMENT '账单类型\n            1：包月付费\n            2：按量付费\n            3：试用\n            4：按时付费（按天扣费，精确到分钟）',
  `cpu_core` int(11) DEFAULT NULL COMMENT 'cpu核数',
  `cpu_used` decimal(7,2) DEFAULT NULL COMMENT 'cpu运算时长，小时为单位，包括了所有的核',
  `memory` decimal(10,2) DEFAULT NULL COMMENT '内存，以MB为单位',
  `memory_used` decimal(10,2) DEFAULT NULL COMMENT '内存使用的均值，以MB为单位',
  `sys_image_id` varchar(32) DEFAULT NULL COMMENT '操作系统',
  `sys_disk` decimal(10,2) DEFAULT NULL COMMENT '磁盘容量，以GB为单位',
  `sys_disk_used` decimal(10,2) DEFAULT NULL,
  `data_disk` decimal(10,2) DEFAULT NULL,
  `data_disk_used` decimal(10,2) DEFAULT NULL COMMENT '磁盘的使用均值，以GB为单位',
  `disk_read` decimal(20,2) DEFAULT NULL COMMENT '从磁盘读取的数据总量，以GB为单位',
  `disk_write` decimal(20,2) DEFAULT NULL COMMENT '向磁盘写入的数据总量，以GB为单位',
  `bandwidth` decimal(10,2) DEFAULT NULL COMMENT '网络带宽，以Mbps为单位',
  `network_traffic` decimal(20,2) DEFAULT NULL COMMENT '网络流量，以Gb为单位',
  `start_time` varchar(17) DEFAULT NULL COMMENT '账单的开始时间',
  `end_time` varchar(17) DEFAULT NULL COMMENT '账单的结束时间',
  `fee` decimal(20,2) DEFAULT NULL COMMENT '账单的费用',
  `is_paid` int(11) DEFAULT NULL COMMENT '是否已费：\n            1：未付费\n            2：已付费',
  `create_time` varchar(17) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_host_bill_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `cloud_host_open_port`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_host_open_port`;
CREATE TABLE `cloud_host_open_port` (
  `id` varchar(32) NOT NULL,
  `host_id` varchar(32) DEFAULT NULL COMMENT '云主机的id',
  `protocol` int(11) DEFAULT NULL COMMENT '协议：\n            0：所有协议\n            1：tcp\n            2：udp',
  `port` int(11) DEFAULT NULL COMMENT '云主机需要公开的端口',
  `server_port` int(11) DEFAULT NULL COMMENT '宿主机端口',
  `outer_port` int(11) DEFAULT NULL COMMENT '映射到公网的端口',
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_host_open_port
-- ----------------------------

-- ----------------------------
-- Table structure for `cloud_host_shopping_config`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_host_shopping_config`;
CREATE TABLE `cloud_host_shopping_config` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL COMMENT '表示是哪个用户的套餐',
  `host_id` varchar(32) DEFAULT NULL COMMENT '云主机id：根据此配置创建的云主机的id\n            如果云主机还没有创建，则为null，如果云主机已经创建，则为该云主机的id',
  `type` int(11) DEFAULT NULL COMMENT '套餐类型：\n            1：包月\n            2：按量付费\n            3：试用\n            4：按时付费（按天扣费，精确到分钟）',
  `cpu_core` int(11) DEFAULT NULL COMMENT '表示选择了多少个核',
  `memory` decimal(30,0) DEFAULT NULL COMMENT '内存，单位为Byte',
  `sys_image_id` varchar(32) DEFAULT NULL COMMENT '操作镜像id',
  `sys_disk` decimal(30,0) DEFAULT NULL COMMENT '系统磁盘，单位为byte',
  `data_disk` decimal(30,0) DEFAULT NULL COMMENT '数据磁盘，单位为Byte',
  `bandwidth` decimal(20,0) DEFAULT NULL COMMENT '网络带宽，单位bps',
  `duration` int(11) DEFAULT NULL COMMENT '包月时长，单位为月',
  `start_time` varchar(17) DEFAULT NULL,
  `end_time` varchar(17) DEFAULT NULL,
  `price` decimal(20,2) DEFAULT NULL COMMENT '定价',
  `create_time` varchar(17) DEFAULT NULL,
  `process_status` int(11) DEFAULT NULL COMMENT '处理状态：\n                        0：未处理\n                        1：成功\n                        2：失败\n                        3：正在创建',
  `process_message` varchar(100) DEFAULT NULL COMMENT '处理信息',
  `host_name` varchar(100) DEFAULT NULL,
  `region` int(11) DEFAULT NULL COMMENT '地域：\n            1：广州\n            2：成都\n            3：北京\n            4：香港',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_host_shopping_config
-- ----------------------------

-- ----------------------------
-- Table structure for `cloud_host_shopping_port_config`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_host_shopping_port_config`;
CREATE TABLE `cloud_host_shopping_port_config` (
  `id` varchar(32) NOT NULL,
  `config_id` varchar(32) DEFAULT NULL,
  `protocol` int(11) DEFAULT NULL COMMENT '协议：\n            0：所有协议\n            1：tcp\n            2：udp',
  `port` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_host_shopping_port_config
-- ----------------------------

-- ----------------------------
-- Table structure for `cloud_host_sys_default_ports`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_host_sys_default_ports`;
CREATE TABLE `cloud_host_sys_default_ports` (
  `id` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(50) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `protocol` int(11) DEFAULT '1',
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_host_sys_default_ports
-- ----------------------------
INSERT INTO `cloud_host_sys_default_ports` VALUES ('1', 'FTP', '20', '1', '2');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('10', 'HTTPS', '8443', '1', '7');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('11', 'NNTP', '119', '1', '18');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('12', 'IMAP', '143', '1', '19');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('13', 'IPSec', '500', '2', '20');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('14', 'L2TP', '1701', '2', '21');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('15', 'PPTP', '1723', '1', '22');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('16', 'MySQL', '1433', '1', '8');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('17', 'MySQL', '3306', '1', '9');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('18', 'ORACLE', '1521', '1', '10');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('19', 'ORACLE', '1158', '1', '11');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('2', 'FTP', '21', '1', '3');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('20', 'ORACLE', '2100', '1', '12');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('21', 'RDP', '3389', '1', '22');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('22', 'FTP', '30000', '1', '23');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('23', 'FTP', '30001', '1', '24');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('24', 'FTP', '30002', '1', '25');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('25', 'FTP', '30003', '1', '26');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('26', 'SNMP', '161', '2', '13');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('29', '主机面板', '10000', '1', '1');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('3', 'Telnet', '23', '1', '14');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('4', 'TFTP', '69', '2', '15');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('5', 'SMTP/POP3', '25', '1', '16');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('6', 'SMTP/POP3', '110', '1', '17');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('7', 'HTTP', '80', '1', '4');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('8', 'HTTP', '8080', '1', '5');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('9', 'HTTPS', '443', '1', '6');
INSERT INTO `cloud_host_sys_default_ports` VALUES ('bddc77a662344376bdecda1c95ff40d0', 'SSH', '22', '1', '1');

-- ----------------------------
-- Table structure for `cloud_host_warehouse_definition`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_host_warehouse_definition`;
CREATE TABLE `cloud_host_warehouse_definition` (
  `id` varchar(32) NOT NULL,
  `sys_image_id` varchar(32) DEFAULT NULL COMMENT '系统磁盘镜像id',
  `_DEL_data_disk` decimal(30,0) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `total_amount` int(11) DEFAULT NULL COMMENT '总共预先创建云主机的数量',
  `remain_amount` int(11) DEFAULT NULL COMMENT '当前云主机剩余数量',
  `region` int(11) DEFAULT NULL COMMENT '地域：\n                        1：广州\n                        2：成都\n                        3：北京\n                        4：香港',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_host_warehouse_definition
-- ----------------------------

-- ----------------------------
-- Table structure for `cloud_host_warehouse_detail`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_host_warehouse_detail`;
CREATE TABLE `cloud_host_warehouse_detail` (
  `id` varchar(32) NOT NULL,
  `warehouse_id` varchar(32) DEFAULT NULL,
  `host_id` varchar(32) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '处理状态：\n            1：未处理\n            2：创建失败\n            3：创建成功未分配\n            4：创建成功已分配\n            5：云主机创建中',
  `process_message` varchar(100) DEFAULT NULL COMMENT '处理信息',
  `fail_time` varchar(17) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_host_warehouse_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `cloud_terminal_binding`
-- ----------------------------
DROP TABLE IF EXISTS `cloud_terminal_binding`;
CREATE TABLE `cloud_terminal_binding` (
  `id` varchar(32) NOT NULL,
  `cloud_terminal_id` varchar(40) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `host_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx1_cloud_terminal_binding` (`cloud_terminal_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_terminal_binding
-- ----------------------------

-- ----------------------------
-- Table structure for `complaint`
-- ----------------------------
DROP TABLE IF EXISTS `complaint`;
CREATE TABLE `complaint` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL COMMENT '投诉的内容',
  `submit_time` varchar(17) DEFAULT NULL,
  `result` varchar(1000) DEFAULT NULL COMMENT '处理结果',
  `resolved_time` varchar(17) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '状态\n            1：未处理\n            2：正在处理\n            3：已处理',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of complaint
-- ----------------------------

-- ----------------------------
-- Table structure for `cpu_package_option`
-- ----------------------------
DROP TABLE IF EXISTS `cpu_package_option`;
CREATE TABLE `cpu_package_option` (
  `id` varchar(32) NOT NULL,
  `core` int(11) DEFAULT NULL COMMENT 'cpu核数',
  `sort` int(11) DEFAULT NULL COMMENT '排序序号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cpu_package_option
-- ----------------------------
INSERT INTO `cpu_package_option` VALUES ('29a74f4500124214a135cb1e90a8b358', '16', '16');
INSERT INTO `cpu_package_option` VALUES ('613a2771c54d4606b6a2a4a7d963906b', '4', '4');
INSERT INTO `cpu_package_option` VALUES ('710c6ed9ec8b42f4bfc3934039026df3', '1', '1');
INSERT INTO `cpu_package_option` VALUES ('bcf59f4a8ba64e8ea4a9be2c4f2d9cc7', '2', '2');
INSERT INTO `cpu_package_option` VALUES ('e2c11b08c6aa48da92016795fcb98d49', '8', '8');

-- ----------------------------
-- Table structure for `disk_package_option`
-- ----------------------------
DROP TABLE IF EXISTS `disk_package_option`;
CREATE TABLE `disk_package_option` (
  `id` varchar(32) NOT NULL,
  `min` decimal(30,0) DEFAULT NULL COMMENT '单位为GB',
  `max` decimal(30,0) DEFAULT NULL COMMENT '单位为GB',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of disk_package_option
-- ----------------------------
INSERT INTO `disk_package_option` VALUES ('8f4d5bd554e74a6796a3f6f5128d1f35', '1073741824', '107374182400');

-- ----------------------------
-- Table structure for `domain_cloud_host_binding`
-- ----------------------------
DROP TABLE IF EXISTS `domain_cloud_host_binding`;
CREATE TABLE `domain_cloud_host_binding` (
  `id` char(32) NOT NULL COMMENT 'ID',
  `host_id` char(32) NOT NULL COMMENT '绑定云主机',
  `domain` varchar(100) NOT NULL COMMENT '域名',
  `name` varchar(100) NOT NULL COMMENT '站点名称',
  `admin_name` varchar(100) NOT NULL COMMENT '管理员姓名',
  `phone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(100) NOT NULL COMMENT '邮箱',
  `create_time` char(17) NOT NULL COMMENT '创建时间',
  `modified_time` char(17) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='域名绑定到虚拟机';

-- ----------------------------
-- Records of domain_cloud_host_binding
-- ----------------------------

-- ----------------------------
-- Table structure for `egg_plan`
-- ----------------------------
DROP TABLE IF EXISTS `egg_plan`;
CREATE TABLE `egg_plan` (
  `id` varchar(32) NOT NULL,
  `incubator_name` varchar(50) DEFAULT NULL,
  `contacts` varchar(20) DEFAULT NULL,
  `contacts_position` varchar(20) DEFAULT NULL,
  `contacts_phone` varchar(15) DEFAULT NULL,
  `qq_or_weixin` varchar(100) DEFAULT NULL,
  `summary` text,
  `status` int(1) DEFAULT '1' COMMENT '状态：1 待处理\r\n         2 已处理',
  `handle_user_id` varchar(32) DEFAULT NULL COMMENT '处理用户id',
  `create_time` varchar(17) DEFAULT NULL,
  `handle_time` varchar(17) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of egg_plan
-- ----------------------------

-- ----------------------------
-- Table structure for `email_config`
-- ----------------------------
DROP TABLE IF EXISTS `email_config`;
CREATE TABLE `email_config` (
  `id` char(32) DEFAULT NULL COMMENT 'ID',
  `name` varchar(45) DEFAULT NULL COMMENT '配置名',
  `sender` varchar(45) DEFAULT NULL COMMENT '发送人',
  `sender_address` varchar(45) DEFAULT NULL COMMENT '发送邮箱',
  `password` varchar(45) DEFAULT NULL COMMENT '密码',
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  `modified_time` char(17) DEFAULT NULL COMMENT '修改时间',
  `protocol` varchar(20) DEFAULT NULL COMMENT '邮件服务协议',
  `host` varchar(20) DEFAULT NULL COMMENT '邮件服务器',
  `is_auth` int(10) DEFAULT NULL COMMENT '是否要求身份验证 0：否 1：是',
  `port` int(10) DEFAULT NULL COMMENT '服务端器口'
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
  `id` char(32) NOT NULL DEFAULT '' COMMENT 'ID',
  `config_id` char(32) DEFAULT NULL COMMENT '使用服务配置ID',
  `name` varchar(45) DEFAULT NULL COMMENT '模版名称',
  `recipient` varchar(400) DEFAULT NULL,
  `subject` varchar(45) DEFAULT NULL COMMENT '邮件标题',
  `content` text COMMENT '邮件正文',
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  `modified_time` char(17) DEFAULT NULL COMMENT '修改时间',
  `code` varchar(45) DEFAULT NULL COMMENT '代码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of email_template
-- ----------------------------
INSERT INTO `email_template` VALUES ('190c5af9b6774e63aaa56eea8cc48262', 'b323eaca749d46d1a66c9627e917d14a', '云端在线代理商初始化密码模板', null, '云端在线代理商初始化密码', '尊敬的用户：<br />您好！<br />恭喜您的账户已注册成功，点击下面的链接即可体验！<br /><a href=https://www.zhicloud.com/agent.do target=_blank>https://www.zhicloud.com/agent.do</a><br />登录账户是:${username} 初始密码为:${password}<br />(为了您账号的安全，请登录后及时修改)<br /><a href=http://${address_of_this_system}loadWord.do target=_blank>致云代理商管理平台操作指南</a><br />请勿把这封邮件泄露给其他非相关人士！<br />如果您有什么疑问、意见、建议，欢迎来电：<br />技术支持：4000-212-999 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;业务咨询：185 0207 7846<br /><br />致云科技感谢您的支持！<br />', '20150730100234356', '20150730100234356', 'INFO_AGENT_INIT_PASSWORD');
INSERT INTO `email_template` VALUES ('227702c997d54964a2ca69962b74ccdd', 'b323eaca749d46d1a66c9627e917d14a', '云端在线登录信息验证模板', null, '云端在线登录信息验证', '<p>	尊敬的用户：</p><p>	您好！</p><p>	由于您忘记了您的登陆信息，所以您收到了这封邮件！以下是系统为您提供的验证码。</p><p>	<span style=color:#E53333;>${code}</span></p><p>	请勿把这封邮件泄露给他人！</p><p>	<br /></p>致云科技感谢您的支持！<br />', '20150730081047094', '20150730081047094', 'INFO_LOGIN_CHECK');
INSERT INTO `email_template` VALUES ('387a24d8996e4659b57f2ef598a0fd69', 'b323eaca749d46d1a66c9627e917d14a', '客户索取发票通知', 'chendongmei@zhicloud.com;mali@zhicloud.com', '有一个来自客户索取发票的请求', '<p>	您好：</p><p>	有一个来自客户${customer}索取发票的请求，请登录：<a href=https://www.zhicloud.com/operator.do target=_blank>https://www.zhicloud.com/operator.do</a>&nbsp;进行处理，谢谢！</p>', '20150831172033738', '20150911092523378', 'BILL_NOTICE');
INSERT INTO `email_template` VALUES ('4042fcb9925f4f6d8a3d1e6ed945d4d6', 'b323eaca749d46d1a66c9627e917d14a', '短信告警模板', 'lshaowei@zhicloud.com', '【云端在线告警通知】', '<p>	管理员，您好：</p><p>	${content}</p><p>	请悉知！</p>', '20150806153751618', '20150930145433613', 'SMS_CODE');
INSERT INTO `email_template` VALUES ('4120d4f5f6a14a6c8c2d34f2ba8e0bc3', 'b323eaca749d46d1a66c9627e917d14a', '云端在线邮箱验证模板', null, '云端在线邮箱验证', '<p>	尊敬的用户：</p><p>	您好！<br />由于您将更改了您的邮箱信息，所以您收到了这封邮件！以下是系统为您提供的验证码。<br /><span style=color:#E53333;>${code}</span><br />致云科技感谢您的支持！<br /></p>', '20150730080702046', '20150730080702046', 'INFO_EMAIL_CHECK');
INSERT INTO `email_template` VALUES ('46518f08e6df4028b33a445392db79db', 'b323eaca749d46d1a66c9627e917d14a', '云端在线余额为零通知模板', null, '云端在线余额为零', '<p>	尊敬的用户：</p><p>	您好！<br />您的账户余额已为零，目前已暂停您的所有产品服务，为了不影响您的业务情况，请您尽快充值开通服务，谢谢。<br /></p><p>	<br /></p><p>	致云科技感谢您的支持！<br /></p>', '20150730083047539', '20150730083047539', 'INFO_BALANCE_ZERO');
INSERT INTO `email_template` VALUES ('489e7e42d2d54c25b816a393152a8a8d', 'b323eaca749d46d1a66c9627e917d14a', '云端在线告警通知模板', 'lshaowei@zhicloud.com', '云端在线告警通知', '<p>	管理员：</p><p>	您好！<br />云端在线发现故障<br /><span style=color:#E53333;><span style=color:#000000;>${type} </span>${region} <span style=color:#000000;>${content}</span></span></p>', '20150730084005200', '20151008110747329', 'INFO_WARN');
INSERT INTO `email_template` VALUES ('67220c088fb64410baf13b236d04ddb8', 'b323eaca749d46d1a66c9627e917d14a', 'web监控恢复邮件模板', 'lshaowei@zhicloud.com', '云端在线恢复', '<p>	管理员，您好：</p><p>	以下设备已恢复正常：</p><p>	${content}</p>', '20150730114041903', '20151008170623643', 'MONITOR_RULE_RECOVER');
INSERT INTO `email_template` VALUES ('6d9c8eba75384114888f6d292f7b8b36', 'b323eaca749d46d1a66c9627e917d14a', '云端在线公有云邀请码模板', null, '云端在线公有云邀请码', '您好！<br /><p>	让您久等了，这是【云端在线】公有云邀请码：</p><p>	<span style=color:#E53333;>${invite_code}</span></p><p>	<span style=line-height:1.5;color:#E53333;><span style=color:#000000;>请在这里注册使用：<a href=http://${address_of_this_system}register.do?code=${code} target=_blank>http://${address_of_this_system}register.do?code=${code}</a></span></span></p>本邀请码7天有效，请尽快注册使用，谢谢。<br />致云科技感谢您的支持！<br />', '20150730081534129', '20150730081534129', 'INFO_INVITAION_CODE');
INSERT INTO `email_template` VALUES ('6e8cd30675454f998cf6985634664370', 'b323eaca749d46d1a66c9627e917d14a', '云端在线手机验证模板', null, '云端在线手机验证', '<p>	尊敬的用户：</p><p>	您好！</p><p>	由于您将更改了您的手机信息，所以您收到了这封邮件！以下是系统为您提供的验证码。</p><p>	<span style=color:#E53333;>${code}</span></p>请勿把这封邮件泄露给他人！<br /><div>	<span style=line-height:1.5;></span></div>致云科技感谢您的支持！<br />', '20150730080906111', '20150730080906112', 'INFO_PHONE_CHECK');
INSERT INTO `email_template` VALUES ('6e98d08306c9413db8f58d5ab7977706', 'b323eaca749d46d1a66c9627e917d14a', '云端在线通知余额模板', null, '云端在线通知', '您好！<br />您的余额还可以支付：<span style=color:#E53333;>${day} </span>天的费用，<span style=color:#E53333;>${day} </span>天后所有产品将会被暂停服务，<span style=line-height:1.5;>为不影响您的云主机正常使用，请及时充值。谢谢</span><br /><br />致云科技感谢您的支持！<br />', '20150730081815308', '20150730082424321', 'INFO_BALANCE_NOTIFICATION');
INSERT INTO `email_template` VALUES ('760c21b9c8e24d809b0a3fa1f994c97a', 'b323eaca749d46d1a66c9627e917d14a', '云端在线警告汇总数据模板', 'lshaowei@zhicloud.com', '云端在线警告汇总数据', '<p>	管理员：</p><p>	以下服务器当天处于告警状态：</p><p>	${content}</p>', '20150730090121533', '20151009093453647', 'INFO_WARN_SUMMARY');
INSERT INTO `email_template` VALUES ('9171f749cf23498ea5444edc0cbab1d9', 'b323eaca749d46d1a66c9627e917d14a', '云端在线用户忘记用户名模板', null, '云端在线忘记用户名', '<p>	尊敬的用户：</p><p>	您好！</p>由于您忘记了您的用户名，申请找回，所以您收到了这封邮件！以下是系统为您找回的用户名，为了您账号的安全，请登录后及时修改。<br /><span style=color:#E53333;>${account}</span> <br /><p>	请别把这封邮件泄露给别人！</p><p>	<br /></p>致云科技感谢您的支持！<br /><br />', '20150730080359564', '20150730080516769', 'INFO_FORGET_USERNAME');
INSERT INTO `email_template` VALUES ('91824d1e344e4b51a708f57aa057ec51', 'b323eaca749d46d1a66c9627e917d14a', 'web监控故障邮件模板', 'lshaowei@zhicloud.com', '云端在线故障通知', '<p>	管理员，您好：</p><p>	以下${type}存在故障：</p><p>	${content}</p><p>	请及时排查解决。</p>', '20150723095616741', '20151008170758510', 'MONITOR_RULE_ERROR');
INSERT INTO `email_template` VALUES ('a16cb5c8f878431ea5c09586c619a681', 'b323eaca749d46d1a66c9627e917d14a', '致云科技初始密码模板', null, '致云科技初始密码', '<p>	尊敬的用户：</p><p>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 您好！</p><p>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您的账户已经注册成功，以下是系统为您提供的初始密码。</p><p>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=color:#E53333;>${password}</span></p><div>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;为了您账号的安全，请登录后及时修改。<br />	<div>		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请勿把这封邮件泄露给其他非相关人士！<br />		<div>			<br />		</div>致云科技感谢您的支持！	</div></div>', '20150729193253361', '20150729193253361', 'INFO_INIT_PASSWORD');
INSERT INTO `email_template` VALUES ('a42486aedd8642c48f062b204a30e81d', 'b323eaca749d46d1a66c9627e917d14a', '云端在线意见反馈模板', 'support@zhicloud.com', '云端在线意见反馈', '云端在线意见反馈<br /><p>	收到来自【${user_type}】${user_name}的意见反馈:</p><p>	${content}</p>请及时处理.<br />客户联系方式:${contact}<br />', '20150730085624872', '20151008170011212', 'INFO_SUGGESTION');
INSERT INTO `email_template` VALUES ('a5691bae58b041539877859a5b821879', 'b323eaca749d46d1a66c9627e917d14a', '致云科技重置密码模板', null, '致云科技重置密码', '<p>	尊敬的用户：</p><p>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您好！</p><p>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;由于您忘记了您的密码，申请重置密码，所以您收到了这封邮件！</p><p>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;以下是系统为您提供的初始化密码，为了您账号的安全，请登录后及时修改。</p><p>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; <span style=color:#E53333;font-size:14px;>${password}</span></p><p>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请勿把这封邮件泄露给其他非相关人士！</p><p>	<br /></p><p>	致云科技感谢您的支持！</p>', '20150729183550703', '20150729183550703', 'INFO_RESET_PASSWORD');
INSERT INTO `email_template` VALUES ('b0c44f2934ad498798e5fbd7b25bad78', 'b323eaca749d46d1a66c9627e917d14a', '云端在线忘记密码模板', null, '云端在线忘记密码', '<p>	尊敬的用户：</p><p>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 您好！</p><p>	<span style=line-height:1.5;>&nbsp; &nbsp; &nbsp; &nbsp; 由于您忘记了您的密码，正在申请修改，所以您收到了这封邮件！现在您只需点击下面的链接就可进行密码的修改。</span><span style=line-height:1.5;>&nbsp;&nbsp;</span></p><p>	<span style=line-height:1.5;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=http://${address_of_this_system}user/changePasswordbysendmail.do?str=${str} target=_blank>http://${address_of_this_system}user/changePasswordbysendmail.do?str=${str}</a></span></p><p>	<span style=line-height:1.5;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您也可以将地址复制到浏览器进行访问。</span></p><p>	<span style=line-height:1.5;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;若您没申请过密码修改，请您忽略此邮件，给您的带来的不便敬请谅解！</span></p><p>	<span style=line-height:1.5;><br /></span></p><p>	<span style=line-height:1.5;>致云科技感谢您的支持！&nbsp;&nbsp;</span></p><p>	<br /></p>', '20150729170938374', '20150729170938374', 'INFO_CHANGE_PASSWORD');
INSERT INTO `email_template` VALUES ('ba6407fe44204f019a30f14acca640da', 'b323eaca749d46d1a66c9627e917d14a', '云端在线恢复通知模板', 'lshaowei@zhicloud.com', '云端在线恢复通知', '<p>	管理员：</p><p>	您好！<br />云端在线故障恢复<br />${type}<span style=color:#E53333;>${region}</span>${content}</p>', '20150730084506974', '20151009093432368', 'INFO_RCOVER');
INSERT INTO `email_template` VALUES ('c3e5aa68c3bb42b5af12f9d05f7443f3', 'b323eaca749d46d1a66c9627e917d14a', 'web监控告警通知模板', 'lshaowei@zhicloud.com', '云端在线告警数据', '<p>	管理员，您好：</p><p>	以下是今天告警${type}的汇总数据：</p><p>	${content}</p><p>	请及时排查解决。</p>', '20150723095801760', '20151008170743094', 'MONITOR_RULE_WARN');
INSERT INTO `email_template` VALUES ('d67d147a689746d893fd2a864cf1d059', 'b323eaca749d46d1a66c9627e917d14a', '用户注册模板', 'zhangxiang@zhicloud.com', '致云科技注册', '<p>	尊敬的用户：</p><p>	您好！</p><p>	感谢您注册致云科技云端在线，您只需点击下面链接激活您的账号，便可以体验我们的服务！</p><p>	<a href=http://${address_of_this_system}user/sendmail.do?str=${str} target=_blank>http://${address_of_this_system}user/sendmail.do?str=${str}</a></p><p>	您也可以将地址复制到浏览器进行访问。</p><p>	<strong>若您没申请过邮箱激活账号，请忽略此邮件，给您带来的不便敬请谅解！</strong></p><p>	致云科技感谢您的支持！</p>', '20150729160741953', '20150729165342590', 'INFO_REGISTER');
INSERT INTO `email_template` VALUES ('dc53d038b88049bbbf412c46581572ed', 'b323eaca749d46d1a66c9627e917d14a', 'web监控定时通知模板', 'lshaowei@zhicloud.com', '云端在线定时通知', '<p>	管理员，您好：</p><p>	以下是今天${type}的定时汇总数据：</p><p>	${content}</p><p>	请注意查收。</p>', '20150723100009738', '20151008170751965', 'MONITOR_RULE_FIXTIME');
INSERT INTO `email_template` VALUES ('eaf7ca7bc85f4068a379a9f9285607f0', 'b323eaca749d46d1a66c9627e917d14a', '数据库告警模版', 'zhangxiang@zhicloud.com;zhang.xiang1991@gmail.com', '数据库告警', '${region}地域出现问题，请及时排查', '20150721161352172', '20150729162607689', 'DB_WARN');
INSERT INTO `email_template` VALUES ('fe5a707ec402449cb77bc09402d07f74', 'b323eaca749d46d1a66c9627e917d14a', '云端在线终端用户初始化密码模板', null, '云端在线终端用户初始化密码', '尊敬的用户：<br />您好！<br /><p>	恭喜您的账户已注册成功，点击下面的链接即可体验！</p><p>	<a href=https://www.zhicloud.com target=_blank>https://www.zhicloud.com</a></p>登录账户是:${username} 初始密码为:${password}<br />(为了您账号的安全，请登录后及时修改)<br />请勿把这封邮件泄露给其他非相关人士！<br />如果您有什么疑问、意见、建议，欢迎来电：<br />技术支持：4000-212-999 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;业务咨询：185 0207 7846<br /><br />致云科技感谢您的支持！<br />', '20150730102936864', '20150730103108561', 'INFO_USER_INIT_PASSWORD');

-- ----------------------------
-- Table structure for `image_host_application`
-- ----------------------------
DROP TABLE IF EXISTS `image_host_application`;
CREATE TABLE `image_host_application` (
  `id` varchar(32) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `contacts` varchar(20) DEFAULT NULL,
  `contacts_position` varchar(20) DEFAULT NULL,
  `contacts_phone` varchar(15) DEFAULT NULL,
  `qq_or_weixin` varchar(100) DEFAULT NULL,
  `summary` text,
  `status` int(1) DEFAULT '1' COMMENT '状态：1 待处理\r\n         2 已处理',
  `handle_user_id` varchar(32) DEFAULT NULL COMMENT '处理用户id',
  `create_time` varchar(17) DEFAULT NULL,
  `handle_time` varchar(17) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of image_host_application
-- ----------------------------

-- ----------------------------
-- Table structure for `invite_code`
-- ----------------------------
DROP TABLE IF EXISTS `invite_code`;
CREATE TABLE `invite_code` (
  `id` varchar(32) NOT NULL,
  `creater_id` varchar(32) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `code` varchar(32) DEFAULT NULL,
  `create_time` varchar(17) DEFAULT NULL,
  `send_time` varchar(17) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL COMMENT '电话号码',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `status` int(11) DEFAULT NULL COMMENT '状态\n            1：未发送\n            2：已发送\n            3：已过期\n            4：已使用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of invite_code
-- ----------------------------

-- ----------------------------
-- Table structure for `invoice`
-- ----------------------------
DROP TABLE IF EXISTS `invoice`;
CREATE TABLE `invoice` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `total_amount` decimal(20,2) DEFAULT NULL COMMENT '发票总金额',
  `invoice_title` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `recipients` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '状态：\n            1、发票尚未开\n            2、发票已开，尚未寄送\n            3、发票已寄送',
  `submit_time` varchar(17) DEFAULT NULL COMMENT '提交时间',
  `taxNumber` varchar(64) DEFAULT NULL,
  `bankNumber` varchar(64) DEFAULT NULL,
  `addressTel` varchar(256) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of invoice
-- ----------------------------

-- ----------------------------
-- Table structure for `invoice_address`
-- ----------------------------
DROP TABLE IF EXISTS `invoice_address`;
CREATE TABLE `invoice_address` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `invoice_title` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `recipients` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `taxNumber` varchar(64) DEFAULT NULL,
  `bankNumber` varchar(64) DEFAULT NULL,
  `addressTel` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of invoice_address
-- ----------------------------

-- ----------------------------
-- Table structure for `malfunction_alarm`
-- ----------------------------
DROP TABLE IF EXISTS `malfunction_alarm`;
CREATE TABLE `malfunction_alarm` (
  `id` varchar(32) NOT NULL,
  `level` int(11) DEFAULT NULL,
  `source` varchar(200) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `alarm_time` varchar(17) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of malfunction_alarm
-- ----------------------------

-- ----------------------------
-- Table structure for `mark`
-- ----------------------------
DROP TABLE IF EXISTS `mark`;
CREATE TABLE `mark` (
  `id` varchar(32) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mark
-- ----------------------------

-- ----------------------------
-- Table structure for `mark_bind_user`
-- ----------------------------
DROP TABLE IF EXISTS `mark_bind_user`;
CREATE TABLE `mark_bind_user` (
  `id` varchar(32) NOT NULL,
  `mark_id` varchar(32) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `create_time` varchar(17) DEFAULT NULL,
  `flag` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mark_bind_user
-- ----------------------------

-- ----------------------------
-- Table structure for `memory_package_option`
-- ----------------------------
DROP TABLE IF EXISTS `memory_package_option`;
CREATE TABLE `memory_package_option` (
  `id` varchar(32) NOT NULL,
  `memory` decimal(20,0) DEFAULT NULL COMMENT '内存，以字节为单位',
  `label` varchar(10) DEFAULT NULL COMMENT '内存对应的label，如：\n            512MB\n            1GB\n            2GB',
  `sort` decimal(20,0) DEFAULT NULL COMMENT '排序序号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of memory_package_option
-- ----------------------------
INSERT INTO `memory_package_option` VALUES ('0961091e2d1b4e70a84f7c7fb5a431c3', '2147483648', '2GB', '2147483648');
INSERT INTO `memory_package_option` VALUES ('504a212a7de34483af4954ca811b7406', '34359738368', '32GB', '34359738368');
INSERT INTO `memory_package_option` VALUES ('9c59eee847cb40508bf1ad0f771fc3f4', '536870912', '512MB', '536870912');
INSERT INTO `memory_package_option` VALUES ('a543edffaeba4f328f304de17eb2d17d', '17179869184', '16GB', '17179869184');
INSERT INTO `memory_package_option` VALUES ('dea6b2d809bf4e62b885670eb405788d', '8589934592', '8GB', '8589934592');
INSERT INTO `memory_package_option` VALUES ('dff15deaa8a44a999e6777a84249f415', '4294967296', '4GB', '4294967296');
INSERT INTO `memory_package_option` VALUES ('f763bf35831942eeba2f3e7371f67ee4', '1073741824', '1GB', '1073741824');

-- ----------------------------
-- Table structure for `message_record`
-- ----------------------------
DROP TABLE IF EXISTS `message_record`;
CREATE TABLE `message_record` (
  `id` char(32) DEFAULT NULL COMMENT 'ID',
  `sender_address` varchar(45) DEFAULT NULL COMMENT '发送地址',
  `recipient_address` varchar(255) DEFAULT NULL COMMENT '接收地址',
  `content` text COMMENT '发送内容',
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  `type` int(10) DEFAULT '0' COMMENT '消息类型：0：邮箱 1:短信',
  `sms_state` varchar(10) DEFAULT NULL COMMENT '短信发送状态(1、成功 其他值为失败)'
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
INSERT INTO `monitor_shield` VALUES ('2aeb56805815493fab394d45e4278b07', '1');
INSERT INTO `monitor_shield` VALUES ('2c106b164e194002afccf8612314fb06', '1');
INSERT INTO `monitor_shield` VALUES ('bf0656468e2e4ed1bf58740ff7605608', '1');
INSERT INTO `monitor_shield` VALUES ('c45444458b11', '1');
INSERT INTO `monitor_shield` VALUES ('da72668ece824bacb553afdc4596c9e7', '1');
INSERT INTO `monitor_shield` VALUES ('e6c7618ecad140b9af12d37dbfba010f', '1');
INSERT INTO `monitor_shield` VALUES ('fa4758041b1848a69c5deebd3bef425b', '1');
INSERT INTO `monitor_shield` VALUES ('fa4ae9d9b36c4068b4d449dd0cea06a2', '1');
INSERT INTO `monitor_shield` VALUES ('storage_server_33e80c6e7281', '0');

-- ----------------------------
-- Table structure for `my_file`
-- ----------------------------
DROP TABLE IF EXISTS `my_file`;
CREATE TABLE `my_file` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `file_name` varchar(200) DEFAULT NULL COMMENT '文件名',
  `file_path` varchar(400) DEFAULT NULL COMMENT '文件路径',
  `size` decimal(10,0) DEFAULT NULL COMMENT '文件大小',
  `upload_time` varchar(17) DEFAULT NULL COMMENT '文件上传时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of my_file
-- ----------------------------

-- ----------------------------
-- Table structure for `oper_log`
-- ----------------------------
DROP TABLE IF EXISTS `oper_log`;
CREATE TABLE `oper_log` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `oper_time` varchar(17) DEFAULT NULL,
  `oper_duration` varchar(8) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `resource_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for `operator`
-- ----------------------------
DROP TABLE IF EXISTS `operator`;
CREATE TABLE `operator` (
  `id` varchar(32) NOT NULL COMMENT '在系统用户表须有一条id一样的记录',
  `name` varchar(100) DEFAULT NULL COMMENT '名称，由用户输入',
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL COMMENT '电话号码',
  `status` int(11) DEFAULT NULL COMMENT '状态\n            1:正常\n            2：禁用\n            3：结束\n            ',
  `create_time` varchar(17) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of operator
-- ----------------------------

-- ----------------------------
-- Table structure for `order_detail`
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `id` varchar(32) NOT NULL,
  `order_id` varchar(32) DEFAULT NULL COMMENT '用户id，表明这个购物车是属于哪一个用户的',
  `item_type` int(11) DEFAULT NULL COMMENT '物品类别：\n            1：云主机\n            2：存储服务',
  `item_id` varchar(32) DEFAULT NULL COMMENT '物品的id，\n            如果是云主机，对应“云主机选购配置”的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `order_info`
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户id，表明这个成交单是属于哪一个用户的',
  `create_time` varchar(17) DEFAULT NULL,
  `total_price` decimal(20,2) DEFAULT NULL,
  `process_status` int(11) DEFAULT NULL COMMENT '处理状态：\n            0：未处理\n            1：成功\n            2：失败',
  `process_message` varchar(100) DEFAULT NULL COMMENT '处理信息',
  `is_paid` int(11) DEFAULT NULL COMMENT '是否已经付费：\n            1：未付费\n            2：已付费',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_info
-- ----------------------------

-- ----------------------------
-- Table structure for `package_info`
-- ----------------------------
DROP TABLE IF EXISTS `package_info`;
CREATE TABLE `package_info` (
  `id` varchar(32) NOT NULL,
  `region` int(11) DEFAULT NULL COMMENT '地域：\r\n            1：广州，\r\n            2：成都，\r\n            3：北京，\r\n            4：香港',
  `type` int(11) DEFAULT NULL COMMENT '类型：\r\n            1：cpu，\r\n			2：内存，\r\n			3：硬盘，\r\n			4：带宽，\r\n			5：套餐',
  `cpu_core` int(11) DEFAULT NULL,
  `memory` decimal(30,0) DEFAULT NULL,
  `data_disk` decimal(30,0) DEFAULT NULL,
  `bandwidth` decimal(20,0) DEFAULT NULL,
  `monthly_price` decimal(10,2) DEFAULT NULL,
  `percent_off` decimal(5,2) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of package_info
-- ----------------------------
INSERT INTO `package_info` VALUES ('02c83f1c6fee429ca4f6d90fa76e6d1d', '2', '1', '2', null, null, null, '65.00', null, '', '1');
INSERT INTO `package_info` VALUES ('02e8078554d6415990df6a819b64e451', '1', '1', '16', null, null, null, '675.00', null, '', '1');
INSERT INTO `package_info` VALUES ('032da100c6524df986585eb1f24ec3c5', '1', '1', '1', null, null, null, '15.00', null, '', '1');
INSERT INTO `package_info` VALUES ('072a7abbd80e44dcba30737254f9657a', '1', '1', '12', null, null, null, '498.00', null, '', '1');
INSERT INTO `package_info` VALUES ('0a477b498c2e47daa140c2b92333c3a3', '2', '1', '1', null, null, null, '15.00', null, '', '1');
INSERT INTO `package_info` VALUES ('0e07add93cb24287b6dc10285aa1a72e', '2', '5', '12', '12884901888', '536870912000', '10000000', '1673.00', null, '12核/12G/500G数据盘/10M', '1');
INSERT INTO `package_info` VALUES ('1505acc835374c49ad6214eb0f7544d4', '2', '5', '2', '4294967296', '53687091200', '4000000', '252.50', null, '2核/4G/50G数据盘/4M', '1');
INSERT INTO `package_info` VALUES ('18af242d186847c9b14484c2bd0c9a03', '4', '2', null, '68719476736', null, null, '2402.00', null, '', '1');
INSERT INTO `package_info` VALUES ('1a447b7410174eeab89eec5ced34e2b1', '1', '3', null, null, '107374182400', null, '9.00', null, '', '1');
INSERT INTO `package_info` VALUES ('20791e00caf7485d9d9501b04d9596fa', '4', '5', '8', '8589934592', '214748364800', '8000000', '1343.00', null, '8核 / 8G / 200G数据盘 / 8M', '1');
INSERT INTO `package_info` VALUES ('226fc422b5fb4769a9baab66a6695084', '1', '2', null, '17179869184', null, null, '390.00', null, '', '1');
INSERT INTO `package_info` VALUES ('24073176e9c143b580644c9a6bbfa081', '4', '3', null, null, '214748364800', null, '45.00', null, '', '1');
INSERT INTO `package_info` VALUES ('2451aa4268e24e618f402a3f977b8b33', '4', '4', null, null, null, '2000000', '90.00', null, '', '1');
INSERT INTO `package_info` VALUES ('253f3c574c024443b46e94ff89bb8e8d', '4', '3', null, null, '53687091200', null, '11.25', null, '', '1');
INSERT INTO `package_info` VALUES ('268c451a304a46cb81cbbdcdba262875', '4', '2', null, '2147483648', null, null, '82.00', null, '', '1');
INSERT INTO `package_info` VALUES ('28f6e6a4ba744bfdacfd0ff81b192517', '4', '5', '1', '1073741824', '21474836480', '2000000', null, null, '1核 / 1G / 20G数据盘 / 2M', '3');
INSERT INTO `package_info` VALUES ('2a3caad90bfb42e58968a1833e3b3ab0', '2', '2', null, '6442450944', null, null, '165.00', null, '', '1');
INSERT INTO `package_info` VALUES ('2cf604abb42e4a0293295c4b78cddbdd', '1', '2', null, '6442450944', null, null, '165.00', null, '', '1');
INSERT INTO `package_info` VALUES ('2da2e8f57ccd42c79655d1b74e8136cd', '1', '5', '4', '4294967296', '107374182400', '6000000', '400.00', null, '4核 / 4G / 100G数据盘 / 6M', '1');
INSERT INTO `package_info` VALUES ('3095e1c962774a73b8eb61f0c388055d', '1', '2', null, '2147483648', null, null, '65.00', null, '', '1');
INSERT INTO `package_info` VALUES ('310d0ec52a8f453d8a859dc96abdc1d1', '4', '4', null, null, null, '6000000', '325.00', null, '', '1');
INSERT INTO `package_info` VALUES ('325e783541354bdf88cd822a8c675bf0', '4', '1', '16', null, null, null, '1135.00', null, '', '1');
INSERT INTO `package_info` VALUES ('34ee142536254d49a528008cb68e7e0c', '1', '2', null, '1073741824', null, null, '27.00', null, '', '1');
INSERT INTO `package_info` VALUES ('388ba6d817e84c4f87e0753a726be218', '1', '2', null, '12884901888', null, null, '300.00', null, '', '1');
INSERT INTO `package_info` VALUES ('3b6f8d04e68b47018b5c11709e701be6', '1', '4', null, null, null, '8000000', '352.50', null, '', '1');
INSERT INTO `package_info` VALUES ('43b94113ad6f4b459506a842b965eb51', '4', '2', null, '8589934592', null, null, '305.00', null, '', '1');
INSERT INTO `package_info` VALUES ('48b103543d124b968fc688e212d9c5c6', '1', '3', null, null, '536870912000', null, '45.00', null, '', '1');
INSERT INTO `package_info` VALUES ('4c00aafeb30547158869c335e091da6c', '2', '4', null, null, null, '4000000', '90.00', null, '', '1');
INSERT INTO `package_info` VALUES ('4ebc1c221a0b4a209d92432a7c3145d4', '1', '2', null, '34359738368', null, null, '750.00', null, '', '1');
INSERT INTO `package_info` VALUES ('50878c9d669a4bf09e084ac9675fb61e', '2', '4', null, null, null, '10000000', '512.50', null, '', '1');
INSERT INTO `package_info` VALUES ('5611926aad5a40f88e2b05553466f194', '4', '2', null, '17179869184', null, null, '602.00', null, '', '1');
INSERT INTO `package_info` VALUES ('656632b8ba6c46c0ab922d98a03235c8', '2', '4', null, null, null, '2000000', '45.00', null, '', '1');
INSERT INTO `package_info` VALUES ('6a585efe25e849b98c7a905ca59e313f', '4', '2', null, '6442450944', null, null, '231.00', null, '', '1');
INSERT INTO `package_info` VALUES ('6b42814315a44f2ba4787933c1564354', '1', '2', null, '8589934592', null, null, '210.00', null, '', '1');
INSERT INTO `package_info` VALUES ('6cf9829c4dd949a38bb05a27da301a63', '1', '2', null, '4294967296', null, null, '120.00', null, '', '1');
INSERT INTO `package_info` VALUES ('6f21fa94e11949bea7ac1a57349fd85b', '1', '1', '4', null, null, null, '145.00', null, '', '1');
INSERT INTO `package_info` VALUES ('73fc0fae1da74b23a02b983f0d27634e', '2', '2', null, '12884901888', null, null, '300.00', null, '', '1');
INSERT INTO `package_info` VALUES ('7488a97a4f9e488dbb0eb71b68c99c2d', '4', '1', '2', null, null, null, '137.00', null, '', '1');
INSERT INTO `package_info` VALUES ('79e79b2aaa674d82851f98cbd4fe6602', '1', '5', '8', '8589934592', '214748364800', '8000000', '814.50', null, '8核 / 8G / 200G数据盘 / 8M', '1');
INSERT INTO `package_info` VALUES ('7a6d5ec3924d4738bc1f5a582ac59314', '4', '2', null, '1073741824', null, null, '45.00', null, '', '1');
INSERT INTO `package_info` VALUES ('7a73df77c4c04e1d84d4fee5ab2c5630', '1', '4', null, null, null, '10000000', '512.50', null, '', '1');
INSERT INTO `package_info` VALUES ('7b663cd6f408459cb0d6285c3d7d1135', '2', '1', '4', null, null, null, '145.00', null, '', '1');
INSERT INTO `package_info` VALUES ('7bf6c1de0a6241bea88f3816da05e016', '2', '2', null, '4294967296', null, null, '120.00', null, '', '1');
INSERT INTO `package_info` VALUES ('7d4cca3f661b4376be706771f867a000', '2', '2', null, '1073741824', null, null, '27.00', null, '', '1');
INSERT INTO `package_info` VALUES ('85c7d04d24ec409aa0798c44e9f934a0', '4', '5', '12', '12884901888', '536870912000', '10000000', '2189.00', null, '12核 / 12G / 500G数据盘 / 10M', '1');
INSERT INTO `package_info` VALUES ('8be2ca20d0404224bc94651f2e203479', '1', '5', '2', '2147483648', '21474836480', '4000000', '184.00', null, '2核 / 2G / 20G数据盘 / 4M', '1');
INSERT INTO `package_info` VALUES ('8bf26c3d628b49348bd447443eea5d5f', '2', '3', null, null, '21474836480', null, '4.05', null, '', '1');
INSERT INTO `package_info` VALUES ('9005e7b448c240f7ba8ac99985c6a0ac', '2', '2', null, '34359738368', null, null, '750.00', null, '', '1');
INSERT INTO `package_info` VALUES ('92eb6a82bc894496a775bef5cf9a2231', '4', '4', null, null, null, '4000000', '180.00', null, '', '1');
INSERT INTO `package_info` VALUES ('9377349ca52d474ea3f28ccc20641613', '4', '1', '4', null, null, null, '281.00', null, '', '1');
INSERT INTO `package_info` VALUES ('9b76e94548d9447494d8e05bf72de2f6', '4', '5', '2', '2147483648', '21474836480', '4000000', '323.40', null, '2核 / 2G / 20G数据盘 / 4M', '1');
INSERT INTO `package_info` VALUES ('9c458203b9f44187ac8c6672d6a77ccb', '1', '4', null, null, null, '2000000', '45.00', null, '', '1');
INSERT INTO `package_info` VALUES ('a0dfe35edc0c4aeab15360b28cc45591', '2', '5', '4', '4294967296', '107374182400', '6000000', '400.00', null, ': 4核/4G/100G数据盘/6M', '1');
INSERT INTO `package_info` VALUES ('a0e5a8f460c845079d800840abf20bd1', '1', '4', null, null, null, '4000000', '90.00', null, '', '1');
INSERT INTO `package_info` VALUES ('a1173c759f9d4d59b65b224fdc1acf6a', '4', '2', null, '34359738368', null, null, '1198.00', null, '', '1');
INSERT INTO `package_info` VALUES ('aad5283ff05a493887d1fc3cc61cc653', '1', '5', '1', '1073741824', '21474836480', '2000000', '0.00', null, '1核 / 1G / 20G数据盘 / 2M', '3');
INSERT INTO `package_info` VALUES ('ae342b8ca8c843fabb431cc786b7aa7f', '4', '5', '4', '4294967296', '107374182400', '6000000', '689.00', null, '4核 / 4G / 100G数据盘 / 6M', '1');
INSERT INTO `package_info` VALUES ('afb50b6a8cf74ba39f6fecb36f937101', '4', '4', null, null, null, '8000000', '525.00', null, '', '1');
INSERT INTO `package_info` VALUES ('b12bdfa28a5549c1ab5f3fbda5e4c3d2', '4', '1', '1', null, null, null, '65.00', null, '', '1');
INSERT INTO `package_info` VALUES ('b1527fafe66b40fab61c19c0fba3e028', '2', '3', null, null, '214748364800', null, '40.50', null, '', '1');
INSERT INTO `package_info` VALUES ('b422cc803b684ec0a28d5ca29c0c481b', '2', '3', null, null, '107374182400', null, '20.25', null, '', '1');
INSERT INTO `package_info` VALUES ('b4741ddd120642e29bd5f9d501918eca', '2', '1', '12', null, null, null, '498.00', null, '', '1');
INSERT INTO `package_info` VALUES ('b4769afc2b2048ed9b0c58bc200b39ab', '2', '4', null, null, null, '6000000', '192.50', null, '', '1');
INSERT INTO `package_info` VALUES ('b5da7c34591b427487773cc650b20ae5', '2', '5', '8', '8589934592', '214748364800', '8000000', '814.50', null, '8核/8G/200G数据盘/8M', '1');
INSERT INTO `package_info` VALUES ('b639bf6c2ea441239246b56afbda757d', '2', '2', null, '8589934592', null, null, '210.00', null, '', '1');
INSERT INTO `package_info` VALUES ('baf194aa9bde497290b226f38cb689a1', '2', '3', null, null, '536870912000', null, '101.25', null, '', '1');
INSERT INTO `package_info` VALUES ('bba756159bbf491aa0230c1f4efc0943', '2', '1', '16', null, null, null, '675.00', null, '', '1');
INSERT INTO `package_info` VALUES ('bd18e2f8ff084f4c92a8df814671d7fc', '4', '3', null, null, '107374182400', null, '22.50', null, '', '1');
INSERT INTO `package_info` VALUES ('bddb6f035e7f4753a856d791f20afb79', '4', '1', '8', null, null, null, '569.00', null, '', '1');
INSERT INTO `package_info` VALUES ('bfabeb5fd9134b4f97277c962213c41a', '1', '3', null, null, '53687091200', null, '4.50', null, '', '1');
INSERT INTO `package_info` VALUES ('c0593da8de6242ad93012d60787fad51', '4', '2', null, '12884901888', null, null, '454.00', null, '', '1');
INSERT INTO `package_info` VALUES ('c9bcf74e7b894b3b8730ce0c01ca40a4', '1', '4', null, null, null, '6000000', '192.50', null, '', '1');
INSERT INTO `package_info` VALUES ('cbcbb11712894b08a2b938bf180430d6', '2', '2', null, '17179869184', null, null, '390.00', null, '', '1');
INSERT INTO `package_info` VALUES ('ccfa3ea3c70d4fb8a630f075897caa08', '1', '1', '2', null, null, null, '65.00', null, '', '1');
INSERT INTO `package_info` VALUES ('cf43eaefda7a4c51bc1f93a36a3ca49a', '1', '1', '8', null, null, null, '322.00', null, '', '1');
INSERT INTO `package_info` VALUES ('cf58734d1d2445bcb13db923b9350a8d', '4', '5', '2', '4294967296', '53687091200', '4000000', '419.00', null, '2核 / 4G / 50G数据盘 / 4M', '1');
INSERT INTO `package_info` VALUES ('d2b1de9da80348fa90f29dba47e63738', '2', '2', null, '68719476736', null, null, '1470.00', null, '', '1');
INSERT INTO `package_info` VALUES ('d4b62edca6cd41a8b5866ed3a99c5608', '4', '2', null, '4294967296', null, null, '156.00', null, '', '1');
INSERT INTO `package_info` VALUES ('d64133e1deb44ce693a2d40c29a39ce8', '4', '3', null, null, '536870912000', null, '112.50', null, '', '1');
INSERT INTO `package_info` VALUES ('d6acd877fe48406597f9c53a82fc888a', '1', '5', '12', '12884901888', '536870912000', '10000000', '1673.00', null, '12核 / 12G / 500G数据盘 / 10M', '1');
INSERT INTO `package_info` VALUES ('d82e969720aa429d8e0d1a1e7e309027', '2', '3', null, null, '53687091200', null, '10.13', null, '', '1');
INSERT INTO `package_info` VALUES ('df89660c730e42e4b0388fd3025890f6', '2', '5', '1', '1073741824', '21474836480', '2000000', '0.00', null, '1核/1G/20G数据盘/2M', '3');
INSERT INTO `package_info` VALUES ('e08800972d254f29968355f3848fc3b6', '2', '1', '8', null, null, null, '322.00', null, '', '1');
INSERT INTO `package_info` VALUES ('e4d1e89c4e0d428ab6aad9e9573232b9', '2', '2', null, '2147483648', null, null, '65.00', null, '', '1');
INSERT INTO `package_info` VALUES ('e6848cb205934b23b0356b07af43f230', '1', '5', '2', '4294967296', '53687091200', '4000000', '252.50', null, '2核 / 4G / 50G数据盘 / 4M', '1');
INSERT INTO `package_info` VALUES ('e830abedeef74f9fa83e621db27aae90', '2', '5', '2', '2147483648', '21474836480', '4000000', '184.00', null, '2核/2G/20G数据盘/4M', '1');
INSERT INTO `package_info` VALUES ('eadebfbd07724808a4ad8f69b20926b0', '1', '3', null, null, '214748364800', null, '18.00', null, '', '1');
INSERT INTO `package_info` VALUES ('ecde65f6a36d42a6837315fbbd38c1d4', '4', '3', null, null, '21474836480', null, '4.50', null, '', '1');
INSERT INTO `package_info` VALUES ('f0b3ca307ee44c83a988e6c4ff56d3c1', '4', '4', null, null, null, '10000000', '725.00', null, '', '1');
INSERT INTO `package_info` VALUES ('f18c91af6d4241fab58819e2fed1944b', '1', '3', null, null, '21474836480', null, '1.80', null, '', '1');
INSERT INTO `package_info` VALUES ('f2324d2edcf14862a6588993dfb048df', '4', '1', '12', null, null, null, '850.00', null, '', '1');
INSERT INTO `package_info` VALUES ('f2cd478de95c4d928119e970a541480b', '2', '4', null, null, null, '8000000', '352.50', null, '', '1');
INSERT INTO `package_info` VALUES ('f877b73076144c5bb285ed04ae6e76d5', '1', '2', null, '68719476736', null, null, '1470.00', null, '', '1');

-- ----------------------------
-- Table structure for `package_price`
-- ----------------------------
DROP TABLE IF EXISTS `package_price`;
CREATE TABLE `package_price` (
  `id` char(32) NOT NULL DEFAULT '' COMMENT 'ID',
  `package_id` char(32) DEFAULT NULL COMMENT 'æ‰€å±žpackage_infoçš„ID',
  `status` int(11) DEFAULT NULL COMMENT '1=通用;2=仅VPC使用\r\n3=仅普通用户使用 \r\n',
  `monthly_price` decimal(10,2) DEFAULT NULL COMMENT 'æ¯æœˆèµ„è´¹',
  `create_time` char(17) DEFAULT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `modified_time` char(17) DEFAULT NULL COMMENT 'ä¿®æ”¹æ—¶é—´',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='å¥—é¤ä»·æ ¼';

-- ----------------------------
-- Records of package_price
-- ----------------------------
INSERT INTO `package_price` VALUES ('001964f1ef724f9d8720b8c1ea893e50', 'ae342b8ca8c843fabb431cc786b7aa7f', '2', '360.00', '20151103161509252', null);
INSERT INTO `package_price` VALUES ('009a05050b7447d5a4a04d3f9c80f86d', '3095e1c962774a73b8eb61f0c388055d', '3', '50.00', '20151103155147086', null);
INSERT INTO `package_price` VALUES ('01bf4e60422b40178f03c36bfc4ceeff', 'bd18e2f8ff084f4c92a8df814671d7fc', '2', '40.00', '20151103180637398', null);
INSERT INTO `package_price` VALUES ('03f448eae8d348baaac729e5c2b0d5e2', 'c0593da8de6242ad93012d60787fad51', '3', '300.00', '20151103163228273', null);
INSERT INTO `package_price` VALUES ('04ff410506c64205858773166f2aebc1', '43b94113ad6f4b459506a842b965eb51', '3', '200.00', '20151103163207222', null);
INSERT INTO `package_price` VALUES ('06315690be9a4dd09d79a29f5fb3d776', '2da2e8f57ccd42c79655d1b74e8136cd', '2', '360.00', '20151103160750587', null);
INSERT INTO `package_price` VALUES ('0659aa80e4f7484a9951aee31f08cde7', '388ba6d817e84c4f87e0753a726be218', '2', '290.00', '20150430165409110', null);
INSERT INTO `package_price` VALUES ('06c03d504e284060bed55374d3fcc3c6', '5611926aad5a40f88e2b05553466f194', '3', '380.00', '20151103163250739', null);
INSERT INTO `package_price` VALUES ('078868c4c1924372b29de7d6ae0719f0', '4c00aafeb30547158869c335e091da6c', '2', '50.00', '20151103182203614', null);
INSERT INTO `package_price` VALUES ('0819b17f9f6a458687ec59204185e9fa', '7bf6c1de0a6241bea88f3816da05e016', '3', '100.00', '20151103181157412', null);
INSERT INTO `package_price` VALUES ('08356271282d4b46b6af5faa12441628', '92eb6a82bc894496a775bef5cf9a2231', '2', '50.00', '20151103182450143', null);
INSERT INTO `package_price` VALUES ('08daadf896434cbdb07f78ea1a694efc', 'df89660c730e42e4b0388fd3025890f6', '3', '83.00', '20151104153718797', null);
INSERT INTO `package_price` VALUES ('098194911abb4d64b724cc48e53ab291', 'e6848cb205934b23b0356b07af43f230', '3', '230.00', '20151103160738801', null);
INSERT INTO `package_price` VALUES ('0a8726ae4e3e4b3abf3c3d4af6f56c04', 'cf43eaefda7a4c51bc1f93a36a3ca49a', '2', '190.00', '20151103155425641', null);
INSERT INTO `package_price` VALUES ('0c6d10873a3444649a48bf85f0acf4bc', '2a3caad90bfb42e58968a1833e3b3ab0', '2', '140.00', '20151103181216713', null);
INSERT INTO `package_price` VALUES ('0c9cb194aa9442069943a10a0a73383f', 'f0b3ca307ee44c83a988e6c4ff56d3c1', '3', '330.00', '20151103180733154', null);
INSERT INTO `package_price` VALUES ('0cf0efb43b3b45e49e0ccd80280be618', 'd64133e1deb44ce693a2d40c29a39ce8', '2', '200.00', '20151103180702454', null);
INSERT INTO `package_price` VALUES ('0fc24736ac934084a56b7e661680cc53', 'b422cc803b684ec0a28d5ca29c0c481b', '3', '40.00', '20151103181435497', null);
INSERT INTO `package_price` VALUES ('109ef59dda12495b8b6c298ad8ea2229', 'ae342b8ca8c843fabb431cc786b7aa7f', '3', '370.00', '20151103161509252', null);
INSERT INTO `package_price` VALUES ('116e005b610046d6bd7e2454aeb2aa37', '3b6f8d04e68b47018b5c11709e701be6', '3', '230.00', '20151103180610982', null);
INSERT INTO `package_price` VALUES ('17493ff467ba4c5b9023deb992cc82b3', 'bddb6f035e7f4753a856d791f20afb79', '2', '190.00', '20151103161845524', null);
INSERT INTO `package_price` VALUES ('17790ff9a98d49898fdcfd844f9fc06d', 'e830abedeef74f9fa83e621db27aae90', '3', '168.00', '20151103183039824', null);
INSERT INTO `package_price` VALUES ('1798545c3272498e8f1eca00525a1f62', 'd2b1de9da80348fa90f29dba47e63738', '2', '1400.00', '20151103181335757', null);
INSERT INTO `package_price` VALUES ('184fa3f914f54a699849cf07fdc0e473', 'd6acd877fe48406597f9c53a82fc888a', '3', '1130.00', '20151103160818958', null);
INSERT INTO `package_price` VALUES ('1a44524cb4bd44a9b391696f01d21955', '8bf26c3d628b49348bd447443eea5d5f', '3', '8.00', '20151103181426128', null);
INSERT INTO `package_price` VALUES ('1b69d29e2e0b4061ad6c7328cfa51126', '7488a97a4f9e488dbb0eb71b68c99c2d', '3', '50.00', '20151103161828690', null);
INSERT INTO `package_price` VALUES ('1bad73ea02264ec882f2ad54f90eed30', 'a0dfe35edc0c4aeab15360b28cc45591', '2', '360.00', '20151103183352282', null);
INSERT INTO `package_price` VALUES ('1c314495f6ba4b1b8c3b41114429911c', 'f877b73076144c5bb285ed04ae6e76d5', '3', '1450.00', '20151103155312583', null);
INSERT INTO `package_price` VALUES ('22c2bb4af33141d79b6ca29348afd5e6', '85c7d04d24ec409aa0798c44e9f934a0', '2', '1100.00', '20151103161619962', null);
INSERT INTO `package_price` VALUES ('250aecfdaf3348d4ab42b7d6801d5083', '48b103543d124b968fc688e212d9c5c6', '2', '200.00', '20151103180530182', null);
INSERT INTO `package_price` VALUES ('26eb0730090f41b5838ec38351998957', '7b663cd6f408459cb0d6285c3d7d1135', '3', '100.00', '20151103181001942', null);
INSERT INTO `package_price` VALUES ('28f647593b6f4b7f94000e80a0d89dd6', '7a73df77c4c04e1d84d4fee5ab2c5630', '3', '330.00', '20151103180616054', null);
INSERT INTO `package_price` VALUES ('29757ea4c12f49589a01363821537e5d', 'cf58734d1d2445bcb13db923b9350a8d', '2', '220.00', '20151103161438655', null);
INSERT INTO `package_price` VALUES ('2b0cb9d23ff0485594a1771f896a9fd5', '92eb6a82bc894496a775bef5cf9a2231', '3', '60.00', '20151103182450143', null);
INSERT INTO `package_price` VALUES ('2cde7555e9a24139920b81164bd78ad3', 'cf43eaefda7a4c51bc1f93a36a3ca49a', '3', '200.00', '20151103155425641', null);
INSERT INTO `package_price` VALUES ('2d9f7d8018d44c4fa6df35ab7151b3ce', 'f0b3ca307ee44c83a988e6c4ff56d3c1', '2', '320.00', '20151103180733154', null);
INSERT INTO `package_price` VALUES ('2dc3c0e5bd064eabb8c535f477072854', 'b4741ddd120642e29bd5f9d501918eca', '3', '300.00', '20151103181040817', null);
INSERT INTO `package_price` VALUES ('309710e60f51415686b42cd2038a71b1', 'd4b62edca6cd41a8b5866ed3a99c5608', '3', '100.00', '20151103163123208', null);
INSERT INTO `package_price` VALUES ('334dd78b89f54d1491e94889303fc4a0', '226fc422b5fb4769a9baab66a6695084', '3', '380.00', '20151103155247530', null);
INSERT INTO `package_price` VALUES ('33898db7267541fe8a23edec2e949379', '9b76e94548d9447494d8e05bf72de2f6', '3', '168.00', '20151103161354284', null);
INSERT INTO `package_price` VALUES ('339c4c9100014db4a7debd0d67a8189d', 'b1527fafe66b40fab61c19c0fba3e028', '3', '80.00', '20151103181441199', null);
INSERT INTO `package_price` VALUES ('34381de95a0f4985ac475fa78b52c8ef', 'c0593da8de6242ad93012d60787fad51', '2', '290.00', '20151103163228273', null);
INSERT INTO `package_price` VALUES ('344a2918e8eb414e99d39c821c9bc6ef', 'd64133e1deb44ce693a2d40c29a39ce8', '3', '200.00', '20151103180702454', null);
INSERT INTO `package_price` VALUES ('35bcadbdcf714123b8d4780f2a6ef66e', '79e79b2aaa674d82851f98cbd4fe6602', '3', '710.00', '20151103160803235', null);
INSERT INTO `package_price` VALUES ('36bcccbb5e394d05b3ea7558ead3be67', 'a0e5a8f460c845079d800840abf20bd1', '2', '50.00', '20151103180557537', null);
INSERT INTO `package_price` VALUES ('370c152998824820a327c5915668da15', 'a1173c759f9d4d59b65b224fdc1acf6a', '2', '700.00', '20151103163317078', null);
INSERT INTO `package_price` VALUES ('37ac067d8d4e47a7a3afd3fc85677c02', '325e783541354bdf88cd822a8c675bf0', '2', '390.00', '20151103161903758', null);
INSERT INTO `package_price` VALUES ('391d66ab5dbc4d8cbd185978401bfa83', '34ee142536254d49a528008cb68e7e0c', '3', '25.00', '20151103155137993', null);
INSERT INTO `package_price` VALUES ('3a2dd6a324aa40c1881bf7bf11c936e1', 'eadebfbd07724808a4ad8f69b20926b0', '3', '80.00', '20151103180524598', null);
INSERT INTO `package_price` VALUES ('3a77d64c452a4c39b29a4193fbbd6bee', '6f21fa94e11949bea7ac1a57349fd85b', '2', '90.00', '20151103155418105', null);
INSERT INTO `package_price` VALUES ('3d08904d1ca14db787d406f4a64cb54c', '656632b8ba6c46c0ab922d98a03235c8', '2', '20.00', '20151103182158380', null);
INSERT INTO `package_price` VALUES ('3f1d3f0e6deb4daca50bc2eb011ea396', '268c451a304a46cb81cbbdcdba262875', '2', '40.00', '20151103163056145', null);
INSERT INTO `package_price` VALUES ('3f658ab87945489ea36cdb8d7177b378', '73fc0fae1da74b23a02b983f0d27634e', '3', '300.00', '20150430170415742', null);
INSERT INTO `package_price` VALUES ('41b8a7a6ede142fbb1bad0c476fe5af7', 'bfabeb5fd9134b4f97277c962213c41a', '3', '20.00', '20151103180511523', null);
INSERT INTO `package_price` VALUES ('434970869aaf409e84d32769fa8c9a04', '18af242d186847c9b14484c2bd0c9a03', '3', '1450.00', '20151103163340702', null);
INSERT INTO `package_price` VALUES ('43da76a23d0440dfaa7c17aefebf5ca2', 'baf194aa9bde497290b226f38cb689a1', '2', '200.00', '20151103181456038', null);
INSERT INTO `package_price` VALUES ('458dac8751d143df87102b049886a203', 'e08800972d254f29968355f3848fc3b6', '2', '190.00', '20151103181018966', null);
INSERT INTO `package_price` VALUES ('46c7ab5bc4064c048c07ba1fb16e8eda', '24073176e9c143b580644c9a6bbfa081', '2', '80.00', '20151103180658304', null);
INSERT INTO `package_price` VALUES ('4910142726f44680935c62115d67a082', '325e783541354bdf88cd822a8c675bf0', '3', '400.00', '20151103161903758', null);
INSERT INTO `package_price` VALUES ('49313b5485ef4964b3d8ecb07686f01e', '656632b8ba6c46c0ab922d98a03235c8', '3', '30.00', '20151103182158380', null);
INSERT INTO `package_price` VALUES ('49aa65add8a94319bfb0a212a629e639', 'ecde65f6a36d42a6837315fbbd38c1d4', '3', '8.00', '20151103180629059', null);
INSERT INTO `package_price` VALUES ('4c2133dd553b4c57a0f8e727601d1857', '7a73df77c4c04e1d84d4fee5ab2c5630', '2', '320.00', '20151103180616054', null);
INSERT INTO `package_price` VALUES ('4eeba45231794bd6b94e701856e764c4', 'f2324d2edcf14862a6588993dfb048df', '2', '290.00', '20151103161854420', null);
INSERT INTO `package_price` VALUES ('4f8ba427e8604e1e89c2fe02de1ad2da', '072a7abbd80e44dcba30737254f9657a', '2', '290.00', '20151103155432977', null);
INSERT INTO `package_price` VALUES ('4fe0e6f9e0d440b89a9afa2496ece7ac', 'f877b73076144c5bb285ed04ae6e76d5', '2', '1400.00', '20151103155312583', null);
INSERT INTO `package_price` VALUES ('50f2e2d63f7c403c8411f20c7ed41744', '1505acc835374c49ad6214eb0f7544d4', '2', '220.00', '20151103183216316', null);
INSERT INTO `package_price` VALUES ('546081621ced43abb15e4364c4eb31a4', '02c83f1c6fee429ca4f6d90fa76e6d1d', '3', '50.00', '20151103180946278', null);
INSERT INTO `package_price` VALUES ('5576b7f003da43ec85fa85af6fb7ccb9', '7d4cca3f661b4376be706771f867a000', '3', '25.00', '20151103181127845', null);
INSERT INTO `package_price` VALUES ('55dcd32f67494717aeb700321e492e08', '253f3c574c024443b46e94ff89bb8e8d', '3', '20.00', '20151103180633468', null);
INSERT INTO `package_price` VALUES ('594d5149cb514b9eacf23647ef8a7fa3', '253f3c574c024443b46e94ff89bb8e8d', '2', '20.00', '20151103180633468', null);
INSERT INTO `package_price` VALUES ('5b2c62ebe7f4440f913f19500b7fcf72', '6cf9829c4dd949a38bb05a27da301a63', '3', '100.00', '20151103155157228', null);
INSERT INTO `package_price` VALUES ('5d2b7f559ef04cf8a6d556de2e372fb0', 'afb50b6a8cf74ba39f6fecb36f937101', '2', '220.00', '20151103180729031', null);
INSERT INTO `package_price` VALUES ('5dd4e4bd3038492084ecc70d81b7648d', '1505acc835374c49ad6214eb0f7544d4', '3', '230.00', '20151103183216316', null);
INSERT INTO `package_price` VALUES ('5f04279d09b84e0bad894fd7a4a1426b', 'd6acd877fe48406597f9c53a82fc888a', '2', '1100.00', '20151103160818958', null);
INSERT INTO `package_price` VALUES ('623e9bc9f09c43629efce788cc0c0806', 'e4d1e89c4e0d428ab6aad9e9573232b9', '3', '50.00', '20151103181143951', null);
INSERT INTO `package_price` VALUES ('65247a3aafd54d5f8d0c48eaed06eea2', 'afb50b6a8cf74ba39f6fecb36f937101', '3', '230.00', '20151103180729031', null);
INSERT INTO `package_price` VALUES ('6558401c25b34895acf69cd2ec111ae7', 'c9bcf74e7b894b3b8730ce0c01ca40a4', '3', '130.00', '20151103180604414', null);
INSERT INTO `package_price` VALUES ('6613c00a95384b85b9cfe77ba3771f52', '6cf9829c4dd949a38bb05a27da301a63', '2', '90.00', '20151103155157228', null);
INSERT INTO `package_price` VALUES ('6870b7725dbd499198d441904631bfb2', '3095e1c962774a73b8eb61f0c388055d', '2', '40.00', '20151103155147086', null);
INSERT INTO `package_price` VALUES ('68f723a6a510401499926e5147dea215', '48b103543d124b968fc688e212d9c5c6', '3', '200.00', '20151103180530182', null);
INSERT INTO `package_price` VALUES ('6b8c29f774f64c84bdc744d2c137fbda', '310d0ec52a8f453d8a859dc96abdc1d1', '2', '120.00', '20151103180725528', null);
INSERT INTO `package_price` VALUES ('6ed9dc2f40d743b2ba980ece90a04483', 'f18c91af6d4241fab58819e2fed1944b', '2', '8.00', '20151103171949150', null);
INSERT INTO `package_price` VALUES ('6edbd91ebbb44e38927fce562af0c745', '4c00aafeb30547158869c335e091da6c', '3', '60.00', '20151103182203614', null);
INSERT INTO `package_price` VALUES ('708c91047e054fefa97f61a5281eddb1', '0a477b498c2e47daa140c2b92333c3a3', '2', '15.00', '20151103180932066', null);
INSERT INTO `package_price` VALUES ('71f8ead124384a6cb5735f2f1c7ac9c9', '9c458203b9f44187ac8c6672d6a77ccb', '3', '30.00', '20151103180553684', null);
INSERT INTO `package_price` VALUES ('73a1812d7cba49d2b7f6114d68e02da6', '0a477b498c2e47daa140c2b92333c3a3', '3', '20.00', '20151103180932066', null);
INSERT INTO `package_price` VALUES ('73fd49d41d32441587497415d4cb86f8', '2451aa4268e24e618f402a3f977b8b33', '2', '20.00', '20151103180717461', null);
INSERT INTO `package_price` VALUES ('74f2933001704d9ba300150ba3b7df79', '7a6d5ec3924d4738bc1f5a582ac59314', '2', '15.00', '20151103163037986', null);
INSERT INTO `package_price` VALUES ('77742e9dbaa84071b70348dbffeb857c', '20791e00caf7485d9d9501b04d9596fa', '2', '700.00', '20151103161534422', null);
INSERT INTO `package_price` VALUES ('7a3cc5145db143fb9b37d669fe3300be', 'c9bcf74e7b894b3b8730ce0c01ca40a4', '2', '120.00', '20151103180604414', null);
INSERT INTO `package_price` VALUES ('7e85a9402a8946ecaddb903467014ea8', '43b94113ad6f4b459506a842b965eb51', '2', '190.00', '20151103163207222', null);
INSERT INTO `package_price` VALUES ('8067ab3ca7bd428ea24495f549716fa3', '28f6e6a4ba744bfdacfd0ff81b192517', '3', '83.00', '20151104153644871', null);
INSERT INTO `package_price` VALUES ('80920c9d579f460a90347ddf5e633dc0', '6a585efe25e849b98c7a905ca59e313f', '3', '150.00', '20151103163147103', null);
INSERT INTO `package_price` VALUES ('816aadc87bbe4347a0363b569f9027be', 'b4741ddd120642e29bd5f9d501918eca', '2', '290.00', '20151103181040817', null);
INSERT INTO `package_price` VALUES ('817e3597077e4d9cabb1a621948f0345', '8be2ca20d0404224bc94651f2e203479', '2', '158.00', '20151103160727485', null);
INSERT INTO `package_price` VALUES ('8205309bf67e4246922b2754a629721f', '072a7abbd80e44dcba30737254f9657a', '3', '300.00', '20151103155432977', null);
INSERT INTO `package_price` VALUES ('8685580cc82342078e478ca9cf1a5243', '1a447b7410174eeab89eec5ced34e2b1', '3', '40.00', '20151103180515251', null);
INSERT INTO `package_price` VALUES ('87010012e1844a7181ad330ae32a3b31', 'e830abedeef74f9fa83e621db27aae90', '2', '158.00', '20151103183039824', null);
INSERT INTO `package_price` VALUES ('878255a0909f428781618a2afc3ffe11', '24073176e9c143b580644c9a6bbfa081', '3', '80.00', '20151103180658304', null);
INSERT INTO `package_price` VALUES ('88143d632a1846079f34b3266b4c9ba2', '18af242d186847c9b14484c2bd0c9a03', '2', '1400.00', '20151103163340702', null);
INSERT INTO `package_price` VALUES ('8887b4fbc21144eda52f8414ba0e953d', 'b422cc803b684ec0a28d5ca29c0c481b', '2', '40.00', '20151103181435497', null);
INSERT INTO `package_price` VALUES ('88c0b1529bcd4491b84e379197edcdb1', '0e07add93cb24287b6dc10285aa1a72e', '3', '1130.00', '20151103183600446', null);
INSERT INTO `package_price` VALUES ('8949e52c382244c8bfbcb470071f1efc', '6b42814315a44f2ba4787933c1564354', '2', '190.00', '20151103155218480', null);
INSERT INTO `package_price` VALUES ('8c12a3441ec54a6caa4fa615f98909e0', '9377349ca52d474ea3f28ccc20641613', '2', '90.00', '20151103161837646', null);
INSERT INTO `package_price` VALUES ('8c4e884546154d31b070a7af5c31c63d', 'e4d1e89c4e0d428ab6aad9e9573232b9', '2', '40.00', '20151103181143951', null);
INSERT INTO `package_price` VALUES ('90a6f2f74f9344f885510f989c3d9731', 'b12bdfa28a5549c1ab5f3fbda5e4c3d2', '2', '15.00', '20151103161814749', null);
INSERT INTO `package_price` VALUES ('9453670eabdd4966828e1f8d5b23a91a', 'aad5283ff05a493887d1fc3cc61cc653', '3', '83.00', '20151104153634953', null);
INSERT INTO `package_price` VALUES ('94d426ebeafc48c281a0154ff36cdd48', '02e8078554d6415990df6a819b64e451', '2', '390.00', '20151103155446701', null);
INSERT INTO `package_price` VALUES ('9643c2ffc375403eabc0a1f087eb277f', 'bfabeb5fd9134b4f97277c962213c41a', '2', '20.00', '20151103180511523', null);
INSERT INTO `package_price` VALUES ('991659cfc6134ae2b1edec6cdcc13af9', '9377349ca52d474ea3f28ccc20641613', '3', '100.00', '20151103161837646', null);
INSERT INTO `package_price` VALUES ('9abaf4db1fb94acfb843e165106d6578', '2451aa4268e24e618f402a3f977b8b33', '3', '30.00', '20151103180717461', null);
INSERT INTO `package_price` VALUES ('9d8689a8b5c1482b882803e68f5f7233', 'b1527fafe66b40fab61c19c0fba3e028', '2', '80.00', '20151103181441199', null);
INSERT INTO `package_price` VALUES ('9e985f9e0fbc4b0dafcd51d8e1070f8e', '85c7d04d24ec409aa0798c44e9f934a0', '3', '1130.00', '20151103161619962', null);
INSERT INTO `package_price` VALUES ('9f158c069e3e4850bf496d7d82f1256d', 'd82e969720aa429d8e0d1a1e7e309027', '2', '20.00', '20151103181431887', null);
INSERT INTO `package_price` VALUES ('9fab2ff72dda448c9b5f294c8cd48358', '032da100c6524df986585eb1f24ec3c5', '3', '20.00', '20151103155357709', null);
INSERT INTO `package_price` VALUES ('9fc684c11d6e4b95ae2d275eb8e1cb17', '6b42814315a44f2ba4787933c1564354', '3', '200.00', '20151103155218480', null);
INSERT INTO `package_price` VALUES ('9fe21856f28e4da1b034eb7bd16dd0a3', '226fc422b5fb4769a9baab66a6695084', '2', '370.00', '20151103155247530', null);
INSERT INTO `package_price` VALUES ('a34358991ff94a149949cf9cd8b30387', 'a0dfe35edc0c4aeab15360b28cc45591', '3', '370.00', '20151103183352282', null);
INSERT INTO `package_price` VALUES ('a477313311f346ceb78c5ab9a11a363c', 'e08800972d254f29968355f3848fc3b6', '3', '200.00', '20151103181018966', null);
INSERT INTO `package_price` VALUES ('a69415c31f89494dbc633b5f4abe169c', '9c458203b9f44187ac8c6672d6a77ccb', '2', '20.00', '20151103180553684', null);
INSERT INTO `package_price` VALUES ('a736acb4f6b44c60bab2a01d0f69fd96', 'd82e969720aa429d8e0d1a1e7e309027', '3', '20.00', '20151103181431887', null);
INSERT INTO `package_price` VALUES ('a741b5f60dc34e5db4c64425690dd0da', 'a0e5a8f460c845079d800840abf20bd1', '3', '60.00', '20151103180557537', null);
INSERT INTO `package_price` VALUES ('a756963212404d528dd09fff7464a796', '9b76e94548d9447494d8e05bf72de2f6', '2', '158.00', '20151103161354284', null);
INSERT INTO `package_price` VALUES ('a800b9abb1ff42d8b0691054c4b7a242', 'bd18e2f8ff084f4c92a8df814671d7fc', '3', '40.00', '20151103180637398', null);
INSERT INTO `package_price` VALUES ('adcc20c3f1d040f0a41957607320bb9c', 'f2324d2edcf14862a6588993dfb048df', '3', '300.00', '20151103161854420', null);
INSERT INTO `package_price` VALUES ('ae11cee05df8498f84dd2c6687d4243c', '2a3caad90bfb42e58968a1833e3b3ab0', '3', '150.00', '20151103181216713', null);
INSERT INTO `package_price` VALUES ('af078c6af3af4e45a210deead33f3a3f', 'ccfa3ea3c70d4fb8a630f075897caa08', '3', '50.00', '20151103155409834', null);
INSERT INTO `package_price` VALUES ('b00380052c7545dba421dec96d19485f', 'bba756159bbf491aa0230c1f4efc0943', '2', '390.00', '20151103181056020', null);
INSERT INTO `package_price` VALUES ('b0a98daaadf2424f89aa121366fe4b90', 'b639bf6c2ea441239246b56afbda757d', '2', '190.00', '20151103181231501', null);
INSERT INTO `package_price` VALUES ('b39ef85d58204a12a360ba8ae76a1879', '6a585efe25e849b98c7a905ca59e313f', '2', '140.00', '20151103163147103', null);
INSERT INTO `package_price` VALUES ('b446edcc64e640cc9b2a7fb262d7feb8', '7b663cd6f408459cb0d6285c3d7d1135', '2', '90.00', '20151103181001942', null);
INSERT INTO `package_price` VALUES ('b980acc288ac4a80a6940e9f3b95a16f', '6f21fa94e11949bea7ac1a57349fd85b', '3', '100.00', '20151103155418105', null);
INSERT INTO `package_price` VALUES ('bfffd3e8318a4de38dcd9701001f0aa0', 'd2b1de9da80348fa90f29dba47e63738', '3', '1450.00', '20151103181335757', null);
INSERT INTO `package_price` VALUES ('c0beed2da89548bf8796eeecc8a2aefd', 'b4769afc2b2048ed9b0c58bc200b39ab', '3', '130.00', '20151103182208385', null);
INSERT INTO `package_price` VALUES ('c2a8ce1dc1ba425ba5154ef73718fef7', '79e79b2aaa674d82851f98cbd4fe6602', '2', '700.00', '20151103160803235', null);
INSERT INTO `package_price` VALUES ('c350ab20061d44f485da313d2167ae89', '268c451a304a46cb81cbbdcdba262875', '3', '50.00', '20151103163056145', null);
INSERT INTO `package_price` VALUES ('c3d4b89b74314111bf8cd93b84270550', 'a1173c759f9d4d59b65b224fdc1acf6a', '3', '750.00', '20151103163317078', null);
INSERT INTO `package_price` VALUES ('c5f8075665da44a2b30631760ccdba69', 'b4769afc2b2048ed9b0c58bc200b39ab', '2', '120.00', '20151103182208385', null);
INSERT INTO `package_price` VALUES ('ca1d4d27a4e744c698d90ab104af4397', 'b639bf6c2ea441239246b56afbda757d', '3', '200.00', '20151103181231501', null);
INSERT INTO `package_price` VALUES ('ca88e198d1b64647b69582533a606a69', '7488a97a4f9e488dbb0eb71b68c99c2d', '2', '45.00', '20151103161828690', null);
INSERT INTO `package_price` VALUES ('caef6206694f4d019537ee42a80a6629', '3b6f8d04e68b47018b5c11709e701be6', '2', '220.00', '20151103180610982', null);
INSERT INTO `package_price` VALUES ('cc9c162f395a4a43ad5cdd4ccdb94668', '5611926aad5a40f88e2b05553466f194', '2', '370.00', '20151103163250739', null);
INSERT INTO `package_price` VALUES ('cd7bff8bc84943d086d536fbd441ea10', '4ebc1c221a0b4a209d92432a7c3145d4', '3', '750.00', '20151103155325400', null);
INSERT INTO `package_price` VALUES ('cdf4908f69504c0d9c605c5f094db032', 'f2cd478de95c4d928119e970a541480b', '2', '220.00', '20151103182212362', null);
INSERT INTO `package_price` VALUES ('ceb320613ef04d30bce9943cfbfa4f12', '310d0ec52a8f453d8a859dc96abdc1d1', '3', '130.00', '20151103180725528', null);
INSERT INTO `package_price` VALUES ('cf9d52775284426787923609046c4135', '73fc0fae1da74b23a02b983f0d27634e', '2', '290.00', '20150430170415742', null);
INSERT INTO `package_price` VALUES ('d0c37571571e4917bbfbbe08ac15003b', '9005e7b448c240f7ba8ac99985c6a0ac', '2', '700.00', '20151103181321769', null);
INSERT INTO `package_price` VALUES ('d60de2fa0962463ab59761255ee16d4a', 'bddb6f035e7f4753a856d791f20afb79', '3', '200.00', '20151103161845524', null);
INSERT INTO `package_price` VALUES ('d6e605b078d2424eaa870fab36cb691e', 'cbcbb11712894b08a2b938bf180430d6', '3', '380.00', '20151103181306000', null);
INSERT INTO `package_price` VALUES ('d752697a7d3548818fd97661c904faa0', 'e6848cb205934b23b0356b07af43f230', '2', '220.00', '20151103160738801', null);
INSERT INTO `package_price` VALUES ('d830bc06c4454c08afdf749e2a798751', '34ee142536254d49a528008cb68e7e0c', '2', '15.00', '20151103155137993', null);
INSERT INTO `package_price` VALUES ('d8d421abd1034958aec134ec06bb2921', '2cf604abb42e4a0293295c4b78cddbdd', '3', '150.00', '20151103155209234', null);
INSERT INTO `package_price` VALUES ('d9323cb76af24b06b853e8f72d7f5521', 'f18c91af6d4241fab58819e2fed1944b', '3', '8.00', '20151103171949150', null);
INSERT INTO `package_price` VALUES ('d9ab495d0adf4319aaf0bfa0e73997c1', 'b5da7c34591b427487773cc650b20ae5', '3', '710.00', '20151103183515176', null);
INSERT INTO `package_price` VALUES ('da133977181e4d8e9c507e727d5725b6', '02e8078554d6415990df6a819b64e451', '3', '400.00', '20151103155446701', null);
INSERT INTO `package_price` VALUES ('da782ce5e17e4a8fafd9de8e189e9418', '20791e00caf7485d9d9501b04d9596fa', '3', '710.00', '20151103161534422', null);
INSERT INTO `package_price` VALUES ('dc33e3de53604b41a5d32e1ff2f830ce', '9005e7b448c240f7ba8ac99985c6a0ac', '3', '750.00', '20151103181321769', null);
INSERT INTO `package_price` VALUES ('df99875751fc4f05a3e5637cf74708ea', 'b5da7c34591b427487773cc650b20ae5', '2', '700.00', '20151103183515176', null);
INSERT INTO `package_price` VALUES ('dfc54f6258874e91900175566be46a67', '7a6d5ec3924d4738bc1f5a582ac59314', '3', '25.00', '20151103163037986', null);
INSERT INTO `package_price` VALUES ('dfef7855e7d647d19dbcb2bfc6a600f9', 'bba756159bbf491aa0230c1f4efc0943', '3', '400.00', '20151103181056020', null);
INSERT INTO `package_price` VALUES ('e17efbdf42614a0d9c0308236d2ea53b', 'ccfa3ea3c70d4fb8a630f075897caa08', '2', '45.00', '20151103155409834', null);
INSERT INTO `package_price` VALUES ('e2b362a608474cf2972e05c8f3011623', '1a447b7410174eeab89eec5ced34e2b1', '2', '40.00', '20151103180515251', null);
INSERT INTO `package_price` VALUES ('e3c94541352a4a1786211edb8bbcc998', 'cbcbb11712894b08a2b938bf180430d6', '2', '370.00', '20151103181306000', null);
INSERT INTO `package_price` VALUES ('e624db033ab54d9cb213afb24fbc9cb4', 'd4b62edca6cd41a8b5866ed3a99c5608', '2', '90.00', '20151103163123208', null);
INSERT INTO `package_price` VALUES ('e6d51e6245e047ce9fb4e70d9997dad3', '388ba6d817e84c4f87e0753a726be218', '3', '300.00', '20150430165409110', null);
INSERT INTO `package_price` VALUES ('eb0117d089954e0eb6e257f9cab936ae', '50878c9d669a4bf09e084ac9675fb61e', '2', '320.00', '20151103182215612', null);
INSERT INTO `package_price` VALUES ('eba8df1beeea470887acfa0df3c6dd25', 'b12bdfa28a5549c1ab5f3fbda5e4c3d2', '3', '20.00', '20151103161814749', null);
INSERT INTO `package_price` VALUES ('ebac9cb2b15042f5bb0d466ff3206058', '8be2ca20d0404224bc94651f2e203479', '3', '168.00', '20151103160727485', null);
INSERT INTO `package_price` VALUES ('ec54f1f8687441ecb2eaac67f874d926', '7d4cca3f661b4376be706771f867a000', '2', '15.00', '20151103181127845', null);
INSERT INTO `package_price` VALUES ('ee346432fb624c45b46f1192880ce66e', '4ebc1c221a0b4a209d92432a7c3145d4', '2', '700.00', '20151103155325400', null);
INSERT INTO `package_price` VALUES ('f0ae00e7d9ae42f9be55294277a968c9', '0e07add93cb24287b6dc10285aa1a72e', '2', '1100.00', '20151103183600446', null);
INSERT INTO `package_price` VALUES ('f0b6437c98c0454c99befaacf0140c23', '8bf26c3d628b49348bd447443eea5d5f', '2', '8.00', '20151103181426128', null);
INSERT INTO `package_price` VALUES ('f161fd5e06c5412d87ff5bfa6d27b5c2', 'eadebfbd07724808a4ad8f69b20926b0', '2', '80.00', '20151103180524598', null);
INSERT INTO `package_price` VALUES ('f172306c9eaf4ae1865a94e1168bd035', 'baf194aa9bde497290b226f38cb689a1', '3', '200.00', '20151103181456038', null);
INSERT INTO `package_price` VALUES ('f1815889e52b4ce9b9025a26a19c6f30', 'ecde65f6a36d42a6837315fbbd38c1d4', '2', '8.00', '20151103180629059', null);
INSERT INTO `package_price` VALUES ('f1e8f108819c4f3fa0843cf6ec562e21', '2da2e8f57ccd42c79655d1b74e8136cd', '3', '370.00', '20151103160750587', null);
INSERT INTO `package_price` VALUES ('f1f1ec76150a4307b834eb5ac6e22dbc', 'cf58734d1d2445bcb13db923b9350a8d', '3', '230.00', '20151103161438655', null);
INSERT INTO `package_price` VALUES ('f3a065805735431bb70a37e0728abf89', '2cf604abb42e4a0293295c4b78cddbdd', '2', '140.00', '20151103155209234', null);
INSERT INTO `package_price` VALUES ('f7182fc704304d3eaa3e68c6c4a83018', '50878c9d669a4bf09e084ac9675fb61e', '3', '330.00', '20151103182215612', null);
INSERT INTO `package_price` VALUES ('f9dc508067924cfdbd5115e94f17976c', '02c83f1c6fee429ca4f6d90fa76e6d1d', '2', '45.00', '20151103180946278', null);
INSERT INTO `package_price` VALUES ('fac55d157a8c45b4a7b3003c4f5d2b3b', '032da100c6524df986585eb1f24ec3c5', '2', '15.00', '20151103155357709', null);
INSERT INTO `package_price` VALUES ('fda95ac97aef41bfabe0b99eb956bf15', '7bf6c1de0a6241bea88f3816da05e016', '2', '90.00', '20151103181157412', null);
INSERT INTO `package_price` VALUES ('fddc5bff035e426fa47f0e53c09293b4', 'f2cd478de95c4d928119e970a541480b', '3', '230.00', '20151103182212362', null);

-- ----------------------------
-- Table structure for `price_update`
-- ----------------------------
DROP TABLE IF EXISTS `price_update`;
CREATE TABLE `price_update` (
  `id` varchar(32) NOT NULL,
  `item_id` varchar(32) DEFAULT NULL COMMENT '关联cloud_host或硬盘',
  `item` int(11) DEFAULT NULL COMMENT '类型：\n\n            1：云主机\n\n            2：云硬盘\n\n             ',
  `price` decimal(20,2) DEFAULT NULL COMMENT '更改之后的价格',
  `before_price` decimal(20,2) DEFAULT NULL COMMENT '更改之前的价格',
  `update_time` varchar(17) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of price_update
-- ----------------------------

-- ----------------------------
-- Table structure for `privilege_group`
-- ----------------------------
DROP TABLE IF EXISTS `privilege_group`;
CREATE TABLE `privilege_group` (
  `id` varchar(32) NOT NULL,
  `group_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of privilege_group
-- ----------------------------
INSERT INTO `privilege_group` VALUES ('0929a4e3a7cb4cb69688b8968cc1ed92', '财务');
INSERT INTO `privilege_group` VALUES ('1946f9eb93a2421f9a0359a4a630c530', '运营商');
INSERT INTO `privilege_group` VALUES ('4f2b4daa3ce54048b41922a868963965', '代理商');
INSERT INTO `privilege_group` VALUES ('9caac96d9fd34e1bb269d48696c2a93a', '技术支持');
INSERT INTO `privilege_group` VALUES ('fce54f249d984d3ebdf28b71d2586551', '客服支持');

-- ----------------------------
-- Table structure for `shopping_cart`
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户id，表明这个购物车是属于哪一个用户的',
  `create_time` varchar(17) DEFAULT NULL,
  `total_price` decimal(20,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------

-- ----------------------------
-- Table structure for `shopping_cart_detail`
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart_detail`;
CREATE TABLE `shopping_cart_detail` (
  `id` varchar(32) NOT NULL,
  `cart_id` varchar(32) DEFAULT NULL COMMENT '用户id，表明这个购物车是属于哪一个用户的',
  `item_type` int(11) DEFAULT NULL COMMENT '物品类别：\n            1：云主机\n            2：存储服务',
  `item_id` varchar(32) DEFAULT NULL COMMENT '物品的id，\n            如果是云主机，对应“云主机选购配置”的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopping_cart_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `sms_config`
-- ----------------------------
DROP TABLE IF EXISTS `sms_config`;
CREATE TABLE `sms_config` (
  `id` char(32) DEFAULT NULL COMMENT 'ID',
  `sms_id` varchar(45) DEFAULT NULL COMMENT '短信配置ID',
  `name` varchar(45) DEFAULT NULL COMMENT '账户名',
  `password` varchar(45) DEFAULT NULL COMMENT '密码',
  `create_time` varchar(45) DEFAULT NULL COMMENT '创建时间',
  `service_url` varchar(80) DEFAULT NULL COMMENT '服务端地址',
  `config_name` varchar(45) DEFAULT NULL COMMENT '配置名',
  `modified_time` char(17) DEFAULT NULL COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sms_config
-- ----------------------------
INSERT INTO `sms_config` VALUES ('2d89a209dc8543e38b9ad9c8c10881ed', '1019', 'ld2', 'DA51D4679A905CC180C10AECA121DECD', '20150720170643078', 'http://sms.gknet.com.cn:8180/Service.asmx/SendMessage', '系统通知', '20150824103133400');
INSERT INTO `sms_config` VALUES ('cd15ef02e0f34c96924c5085371fbfd7', '9803', 'lddddd', '1224432434', '20150824103538436', 'http://127.0.0.1/message/service', '配置', '20150824103538436');

-- ----------------------------
-- Table structure for `sms_template`
-- ----------------------------
DROP TABLE IF EXISTS `sms_template`;
CREATE TABLE `sms_template` (
  `id` char(32) DEFAULT NULL COMMENT 'ID',
  `config_id` char(32) DEFAULT NULL COMMENT '使用服务配置ID',
  `code` varchar(45) DEFAULT NULL COMMENT '代码',
  `recipient` varchar(200) DEFAULT NULL,
  `content` text COMMENT '短信正文',
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  `modified_time` char(17) DEFAULT NULL COMMENT '修改时间',
  `name` varchar(45) DEFAULT NULL COMMENT '模板名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sms_template
-- ----------------------------
INSERT INTO `sms_template` VALUES ('0c75541001fa43e4bb6ee4716746a5a6', '2d89a209dc8543e38b9ad9c8c10881ed', 'INFO_NOTIFICATION', null, '${content}', '20150730111311966', '20150730111311966', '云端在线短信通知模板');
INSERT INTO `sms_template` VALUES ('4594360dee9645d9912091a7fae7bee6', '2d89a209dc8543e38b9ad9c8c10881ed', 'DB_WARN', '13568814609', '【致云科技】 ${region}数据库故障', '20150721145814975', '20150721145814975', '数据库告警模版');
INSERT INTO `sms_template` VALUES ('48039987f7f046ea81ec4603e2236cd7', '2d89a209dc8543e38b9ad9c8c10881ed', 'MONITOR_NOTIFY', '18708177268', '${content}', '20150825172906381', '20150825172906381', '监控短信模板');

-- ----------------------------
-- Table structure for `suggestion`
-- ----------------------------
DROP TABLE IF EXISTS `suggestion`;
CREATE TABLE `suggestion` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '\n            1：页面风格\n            2：产品功能\n            3：其他',
  `status` int(11) DEFAULT NULL COMMENT '\n            1：未答复\n            2：已答复',
  `submit_time` varchar(17) DEFAULT NULL,
  `reply_time` varchar(17) DEFAULT NULL,
  `result` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of suggestion
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_disk_image`
-- ----------------------------
DROP TABLE IF EXISTS `sys_disk_image`;
CREATE TABLE `sys_disk_image` (
  `id` varchar(32) NOT NULL,
  `real_image_id` varchar(32) DEFAULT NULL COMMENT '真正的磁盘镜像的id',
  `name` varchar(100) DEFAULT NULL COMMENT '镜像的名称',
  `display_name` varchar(100) DEFAULT NULL,
  `from_host_id` varchar(32) DEFAULT NULL COMMENT '从哪部云主机制作此镜像',
  `tag` varchar(200) DEFAULT NULL COMMENT '标签',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `group_id` varchar(32) DEFAULT NULL COMMENT '用户所有的组',
  `user_id` varchar(32) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL COMMENT '排序序号',
  `region` int(11) DEFAULT NULL COMMENT '地域：\n                        1：广州\n                        2：成都\n                        3：北京\n                        4：香港',
  `status` int(10) DEFAULT '1',
  `type` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_disk_image
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_privilege`
-- ----------------------------
DROP TABLE IF EXISTS `sys_privilege`;
CREATE TABLE `sys_privilege` (
  `id` varchar(32) NOT NULL,
  `privilege_code` varchar(50) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '系统权限的类型：\n            1：menu\n            2：function',
  `level` int(11) DEFAULT NULL COMMENT '从1开始',
  `name` varchar(50) DEFAULT NULL,
  `parent_id` varchar(32) DEFAULT NULL COMMENT '父权限的id',
  `sort_num` int(11) DEFAULT NULL COMMENT '排序序号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_privilege
-- ----------------------------
INSERT INTO `sys_privilege` VALUES ('01f268bdc343488b995ee5b852edc1a3', 'operator_manage_page', '2', '3', '运营商员工管理页面', '56a316de15014107853b9fa8e5f6109e', '1');
INSERT INTO `sys_privilege` VALUES ('024cc8ec3fdb429aa52f96091564ec83', 'message_mail_record_manage_add', '2', '5', '新增纪录', '5fad147a8d4f4a6492670193b497b848', '2');
INSERT INTO `sys_privilege` VALUES ('03194d1ed510421a8b89c075fc6d3695', 'vpc_manage_page', '2', '3', 'VPC管理页面', '760f385e794f46959348434cee792294', '5');
INSERT INTO `sys_privilege` VALUES ('031b2643beb949b69e967f609b79e618', 'admin_change_password_page', '2', '2', '修改密码', '22f8657b636240d0a7c7edb12bd11178', '2');
INSERT INTO `sys_privilege` VALUES ('05cd19aeb4954c3cb3e278c96908921c', 'monitor_cloudhost', '2', '4', '云主机信息监控', 'e6bbed3b41c94113ac0330f6c0eb604f', '5');
INSERT INTO `sys_privilege` VALUES ('0616999f6a514c4a9c0a6557d570f35e', 'admin_basic_information_page', '2', '2', '基本资料', '22f8657b636240d0a7c7edb12bd11178', '1');
INSERT INTO `sys_privilege` VALUES ('067018eae70b48c38db0799bc1bd66c4', 'invoice_manage_agent', '2', '2', '发票管理', '6bd730a92be3430bbbc95519b90f161c', '7');
INSERT INTO `sys_privilege` VALUES ('0851b89a1b6249c39843eecee2fd6371', 'operator_agent_recharge', '2', '3', '充值', 'e7873a28bd644878abdb6e0c7cce1d38', '6');
INSERT INTO `sys_privilege` VALUES ('0a5dce2e58cc48888e19642309fb085e', 'operator_cash_coupon_send_phone', '2', '3', '发送到手机', '245ef10c85d142f4b6be94225c299a2e', '4');
INSERT INTO `sys_privilege` VALUES ('0b267f4d18cf44799746a5cddcf82840', 'view_all_user_oper_log', '2', '2', '用户日志', '2b89bc1cf1704ed6940bb35721e01a4d', '15');
INSERT INTO `sys_privilege` VALUES ('0bf3e360110442619b5ff08dd2a9782d', 'operator_cash_coupon_add', '2', '3', '添加', '245ef10c85d142f4b6be94225c299a2e', '2');
INSERT INTO `sys_privilege` VALUES ('0c65de74a6cd4aefa4b9e0a1acf7da70', 'sys_role_manage_modify', '2', '3', '修改', '8d366c19c4284aa8ac0a178c0b80af1e', '3');
INSERT INTO `sys_privilege` VALUES ('0e75c8aefe5240229c6cc1c778baa801', 'sys_disk_image_manage', '2', '2', '系统镜像管理', '2b89bc1cf1704ed6940bb35721e01a4d', '8');
INSERT INTO `sys_privilege` VALUES ('102235ed37e541c6b9364844d7cb2bd2', 'agent_manage_add', '2', '3', '添加', 'e7873a28bd644878abdb6e0c7cce1d38', '2');
INSERT INTO `sys_privilege` VALUES ('10827ef8efeb4390bafbecdf6ae46c94', 'sys_group_manage_modify', '2', '3', '修改', '195e5ddd29e44563b09a5df35b33211f', '3');
INSERT INTO `sys_privilege` VALUES ('128c61e8435747be96fdce3a36c6695b', 'monitor_area', '2', '4', '总体概况监控', 'e6bbed3b41c94113ac0330f6c0eb604f', '1');
INSERT INTO `sys_privilege` VALUES ('144de5d775964e37b5f0eb9128574c90', 'bill_part_page_agent', '2', '3', '账单部份', 'e4c0cd0f353649fabf639a9d0a327e66', '4');
INSERT INTO `sys_privilege` VALUES ('14ccd4bf2fc54c5b9b23dfbca5fbe78d', 'cloud_host_manage_page', '2', '3', '云主机管理页面', '760f385e794f46959348434cee792294', '4');
INSERT INTO `sys_privilege` VALUES ('160f7d545e9e49119baff46349f60438', 'message_mail_template_manage_add', '2', '5', '新增模版', '4acd08940b65421aadb13f70d8963d26', '2');
INSERT INTO `sys_privilege` VALUES ('195e5ddd29e44563b09a5df35b33211f', 'sys_group_manage', '2', '2', '系统权限组管理', '22f8657b636240d0a7c7edb12bd11178', '4');
INSERT INTO `sys_privilege` VALUES ('19ba3f6246564a80b4125370c267b559', 'cpu_package_option_delete', '2', '3', 'CPU套餐项删除', '879bef28004742efa9771643bd04e179', '4');
INSERT INTO `sys_privilege` VALUES ('1d0a125e75764a1fa1a404f8b74d9b3f', 'warehouse_manage_modify', '2', '3', '修改库存类型页面', 'fd45cd4813a9497b936e3efda9fc7ae9', '4');
INSERT INTO `sys_privilege` VALUES ('1f5b5477e5a845d8b58d321977649ba4', 'sys_role_manage_page', '2', '3', '系统角色管理页面', '8d366c19c4284aa8ac0a178c0b80af1e', '1');
INSERT INTO `sys_privilege` VALUES ('22879786cf5e419d96b461d183924ec5', 'bill_manage_delete_agent', '2', '3', '删除', 'e4c0cd0f353649fabf639a9d0a327e66', '3');
INSERT INTO `sys_privilege` VALUES ('22f8657b636240d0a7c7edb12bd11178', 'privilege_of_admin', '2', '1', '超级管理员的权限', null, '1');
INSERT INTO `sys_privilege` VALUES ('245ef10c85d142f4b6be94225c299a2e', 'operator_cash_coupon_manage', '2', '2', '代金券管理', '2b89bc1cf1704ed6940bb35721e01a4d', '10');
INSERT INTO `sys_privilege` VALUES ('247c064e4b22418e8d704318bb5df544', 'terminal_user_manage_delete', '2', '3', '删除', '46d3556da48e47118c40ede7d9ff6266', '4');
INSERT INTO `sys_privilege` VALUES ('24db2a14f1034de18a43b254c53d8f75', 'message_mail_config_manage_page', '2', '5', '配置管理', 'dc2f20c40f72483da7f3932b28acae62', '1');
INSERT INTO `sys_privilege` VALUES ('25d47cda546841bf85666c51ee825500', 'terminal_user_manage_delete_agent', '2', '3', '删除', 'e8c6c39065fe4628a91aff941d38ee48', '4');
INSERT INTO `sys_privilege` VALUES ('2884927fcc9041c3a41a516eadaf0784', 'operator_cash_coupon_manage_page', '2', '3', '代金券管理页面', '245ef10c85d142f4b6be94225c299a2e', '1');
INSERT INTO `sys_privilege` VALUES ('2b89bc1cf1704ed6940bb35721e01a4d', 'privilege_of_operator', '2', '1', '运营商的权限', null, '2');
INSERT INTO `sys_privilege` VALUES ('2e546273894f4e76adf3633e62afc0ef', 'message_mail_record_manage_delete', '2', '5', '删除纪录', '5fad147a8d4f4a6492670193b497b848', '3');
INSERT INTO `sys_privilege` VALUES ('2f4375eda44b4fa1a28432c25c85181c', 'terminal_user_manage_add_agent', '2', '3', '添加', 'e8c6c39065fe4628a91aff941d38ee48', '2');
INSERT INTO `sys_privilege` VALUES ('38eb29f1075748b19676bf5ff7ed52f6', 'operator_cash_coupon_delete', '2', '3', '删除', '245ef10c85d142f4b6be94225c299a2e', '3');
INSERT INTO `sys_privilege` VALUES ('3b4c03a4fe784a05899639555f937c77', 'operator_manage_delete', '2', '3', '删除', '56a316de15014107853b9fa8e5f6109e', '4');
INSERT INTO `sys_privilege` VALUES ('3c9dae2c105840d7ad637a0f36b0395f', 'monitor_rule_delete', '2', '5', '删除', 'eccf127b99c948049b65d01dbdd65671', '4');
INSERT INTO `sys_privilege` VALUES ('3d694ff143fb4ee0ac5c0808a5f6b225', 'terminal_user_manage_add', '2', '3', '添加', '46d3556da48e47118c40ede7d9ff6266', '2');
INSERT INTO `sys_privilege` VALUES ('3dfcb76e812245759161e9d9c1b9d338', 'vpc_manage_page_agent', '2', '3', 'VPC管理页面', 'fa337b5198d5422eb9532df68607865a', '5');
INSERT INTO `sys_privilege` VALUES ('3efc9dd75173425c925ce97035199aeb', 'monitor_server', '2', '4', '服务器信息监控', 'e6bbed3b41c94113ac0330f6c0eb604f', '4');
INSERT INTO `sys_privilege` VALUES ('415042921573401784e6eb2cff82be60', 'memory_package_option_add', '2', '3', '内存套餐项添加', '879bef28004742efa9771643bd04e179', '5');
INSERT INTO `sys_privilege` VALUES ('4189695f1f8a4986a12ef41c3f6f5944', 'agent_reset_password', '2', '3', '重置密码', 'e7873a28bd644878abdb6e0c7cce1d38', '5');
INSERT INTO `sys_privilege` VALUES ('44570277179841578f4519f88924df5b', 'disk_package_option_modify', '2', '3', '磁盘套餐项修改', '879bef28004742efa9771643bd04e179', '7');
INSERT INTO `sys_privilege` VALUES ('4530b44bf3e44371836ec41e0faf025d', 'agent_manage_page', '2', '3', '代理商管理页面', 'e7873a28bd644878abdb6e0c7cce1d38', '1');
INSERT INTO `sys_privilege` VALUES ('46d3556da48e47118c40ede7d9ff6266', 'terminal_user_manage', '2', '2', '终端用户管理', '2b89bc1cf1704ed6940bb35721e01a4d', '6');
INSERT INTO `sys_privilege` VALUES ('488d3d12812044e9ac5497c0f7396c1b', 'bandwidth_package_option_modify', '2', '3', '宽带套餐项修改', '879bef28004742efa9771643bd04e179', '8');
INSERT INTO `sys_privilege` VALUES ('4acd08940b65421aadb13f70d8963d26', 'message_mail_template_manage', '2', '4', '邮件模版管理', 'bb8edf0f99344615afb642371f398f68', '2');
INSERT INTO `sys_privilege` VALUES ('51f0f76882f94e9ead77d798c6071f9e', 'memory_package_option_delete', '2', '3', '内存套餐项删除', '879bef28004742efa9771643bd04e179', '6');
INSERT INTO `sys_privilege` VALUES ('531ca93856c74f17a4d50fb7729ae3cc', 'bill_manage_modify_agent', '2', '3', '修改', 'e4c0cd0f353649fabf639a9d0a327e66', '2');
INSERT INTO `sys_privilege` VALUES ('556df5c1e52648be880fcadb1ba4bf9f', 'bill_detail_page_agent', '2', '3', '账单详情', 'e4c0cd0f353649fabf639a9d0a327e66', '5');
INSERT INTO `sys_privilege` VALUES ('55c23831cedc441d927fb19e347ed91d', 'message_mail_template_manage_page', '2', '5', '模版管理', '4acd08940b65421aadb13f70d8963d26', '1');
INSERT INTO `sys_privilege` VALUES ('56a316de15014107853b9fa8e5f6109e', 'operator_manage', '2', '2', '运营商员工管理', '22f8657b636240d0a7c7edb12bd11178', '5');
INSERT INTO `sys_privilege` VALUES ('57429e337baa4a9091ca3853deb3e386', 'sys_disk_image_manage_page', '2', '3', '系统镜像管理页面', '0e75c8aefe5240229c6cc1c778baa801', '1');
INSERT INTO `sys_privilege` VALUES ('57832b0450144213b04cdeef32271ea8', 'cloud_host_bill_detail_page', '2', '3', '云主机账单详情', '57b196f52aa7429bbc3add3fbe854f59', '6');
INSERT INTO `sys_privilege` VALUES ('57b196f52aa7429bbc3add3fbe854f59', 'bill_manage', '2', '2', '账单管理', '2b89bc1cf1704ed6940bb35721e01a4d', '9');
INSERT INTO `sys_privilege` VALUES ('583a315bd31b4fcbb34904b5cbf553c8', 'monitor_resource', '2', '4', '资源监控', 'e6bbed3b41c94113ac0330f6c0eb604f', '7');
INSERT INTO `sys_privilege` VALUES ('597d3680983643afa4f3ec44564143d8', 'agent_change_password_page', '2', '2', '修改密码', '6bd730a92be3430bbbc95519b90f161c', '2');
INSERT INTO `sys_privilege` VALUES ('5b99250ad2264864a19454d9122ad800', 'agent_basic_information_page', '2', '2', '基本资料', '6bd730a92be3430bbbc95519b90f161c', '1');
INSERT INTO `sys_privilege` VALUES ('5cf007f657f34ce29e3ef1712a1ec68a', 'warehouse_manage_detail', '2', '3', '库存类型详情页面', 'fd45cd4813a9497b936e3efda9fc7ae9', '3');
INSERT INTO `sys_privilege` VALUES ('5da21782359c4be49ae2f2345e1b0dc1', 'operator_manage_modify', '2', '3', '修改', '56a316de15014107853b9fa8e5f6109e', '3');
INSERT INTO `sys_privilege` VALUES ('5fad147a8d4f4a6492670193b497b848', 'message_mail_record_manage', '2', '4', '邮件发送纪录查看', 'bb8edf0f99344615afb642371f398f68', '3');
INSERT INTO `sys_privilege` VALUES ('64cfbb3dfff94397aab4960942d340e6', 'monitor_room', '2', '4', '机房信息监控', 'e6bbed3b41c94113ac0330f6c0eb604f', '2');
INSERT INTO `sys_privilege` VALUES ('674e3cd7c37b4429a325a1cf4c462ed7', 'message_mail_template_manage_delete', '2', '5', '删除模版', '4acd08940b65421aadb13f70d8963d26', '4');
INSERT INTO `sys_privilege` VALUES ('6bd730a92be3430bbbc95519b90f161c', 'privilege_of_agent', '2', '1', '代理商的权限', null, '3');
INSERT INTO `sys_privilege` VALUES ('6ca35a991b464039a2f2d516d3d622dd', 'bill_manage_modify', '2', '3', '修改', '57b196f52aa7429bbc3add3fbe854f59', '2');
INSERT INTO `sys_privilege` VALUES ('6e1cf3ee694b49b6bf4500847f59a37b', 'terminal_user_manage_modify_agent', '2', '3', '修改', 'e8c6c39065fe4628a91aff941d38ee48', '3');
INSERT INTO `sys_privilege` VALUES ('7174cfd19c544e7abbba242549b3d79d', 'terminal_user_manage_page_for_agent', '2', '3', '终端用户管理页面', 'e8c6c39065fe4628a91aff941d38ee48', '1');
INSERT INTO `sys_privilege` VALUES ('733ec2405e054ea3b056d0c6ee0c9fd2', 'sys_group_manage_add', '2', '3', '添加', '195e5ddd29e44563b09a5df35b33211f', '2');
INSERT INTO `sys_privilege` VALUES ('754e6cf0a4184ec5942d31dae52cbddf', 'cloud_host_create_agent', '2', '3', '创建云主机', 'fa337b5198d5422eb9532df68607865a', '2');
INSERT INTO `sys_privilege` VALUES ('760f385e794f46959348434cee792294', 'cloud_host_manage', '2', '2', '云主机管理', '2b89bc1cf1704ed6940bb35721e01a4d', '4');
INSERT INTO `sys_privilege` VALUES ('7b46e9d64ecd43b999e2a712cb37c10a', 'sys_disk_image_manage_delete', '2', '3', '删除', '0e75c8aefe5240229c6cc1c778baa801', '4');
INSERT INTO `sys_privilege` VALUES ('7fe4053cae044d1598b45163d9a2944e', 'warehouse_manage_add', '2', '3', '添加库存类型页面', 'fd45cd4813a9497b936e3efda9fc7ae9', '2');
INSERT INTO `sys_privilege` VALUES ('801f9deeb2654fe79124c11602565ccd', 'sys_group_manage_set_role', '2', '3', '设置角色', '195e5ddd29e44563b09a5df35b33211f', '6');
INSERT INTO `sys_privilege` VALUES ('8350055ebf0e4da78a1aa58bfd95e224', 'sys_group_manage_set_member', '2', '3', '设置组员', '195e5ddd29e44563b09a5df35b33211f', '5');
INSERT INTO `sys_privilege` VALUES ('86b9ffdb1a5844c882a0df7f005fcea8', 'package_price_manage_page', '2', '3', '套餐价格管理页面', '879bef28004742efa9771643bd04e179', '2');
INSERT INTO `sys_privilege` VALUES ('879bef28004742efa9771643bd04e179', 'package_item_manage', '2', '2', '套餐项管理', '2b89bc1cf1704ed6940bb35721e01a4d', '7');
INSERT INTO `sys_privilege` VALUES ('89354d29cb374a21b99503067af33b1a', 'bill_manage_delete', '2', '3', '删除', '57b196f52aa7429bbc3add3fbe854f59', '3');
INSERT INTO `sys_privilege` VALUES ('8a73442783a54b43b7581e3d5c6904f6', 'message_mail_record_manage_page', '2', '5', '发送纪录查看', '5fad147a8d4f4a6492670193b497b848', '1');
INSERT INTO `sys_privilege` VALUES ('8b1a3df236524a08a749613431981fba', 'sys_role_manage_add', '2', '3', '添加', '8d366c19c4284aa8ac0a178c0b80af1e', '2');
INSERT INTO `sys_privilege` VALUES ('8bc56f091f044ea09c23056225f7a59f', 'app_porpertise_manage', '2', '2', '全局属性管理', '22f8657b636240d0a7c7edb12bd11178', '6');
INSERT INTO `sys_privilege` VALUES ('8d366c19c4284aa8ac0a178c0b80af1e', 'sys_role_manage', '2', '2', '系统角色管理', '22f8657b636240d0a7c7edb12bd11178', '3');
INSERT INTO `sys_privilege` VALUES ('904da3b52f75413095427794768f12dc', 'operator_self_use_cloud_host_add_port_page', '2', '3', '开放端口', '760f385e794f46959348434cee792294', '8');
INSERT INTO `sys_privilege` VALUES ('92c0f81d18de47b29e9d7afbc3d542c8', 'cloud_host_bill_detail_page_agent', '2', '3', '云主机账单详情', 'e4c0cd0f353649fabf639a9d0a327e66', '6');
INSERT INTO `sys_privilege` VALUES ('93cbfce957b34ec28d529284c7d466ab', 'operator_self_use_cloud_host_start_page', '2', '3', '启动云主机', '760f385e794f46959348434cee792294', '6');
INSERT INTO `sys_privilege` VALUES ('9602980f958e43d1af2ae37296f3796c', 'app_porpertise_manage_page', '2', '3', '全局属性管理\'页面', '8bc56f091f044ea09c23056225f7a59f', '1');
INSERT INTO `sys_privilege` VALUES ('973caa655b004ef3a431986917ba61c5', 'business_statistics_agent', '2', '2', '业务统计', '6bd730a92be3430bbbc95519b90f161c', '9');
INSERT INTO `sys_privilege` VALUES ('977b81cb8bd745cb915f5750b0ccb802', 'agent_business_graphics_page', '2', '2', '业务图表', '6bd730a92be3430bbbc95519b90f161c', '8');
INSERT INTO `sys_privilege` VALUES ('983d657e541742eb8c89acb98f1726a8', 'trial_period_manage', '2', '3', '试用期修改', '879bef28004742efa9771643bd04e179', '9');
INSERT INTO `sys_privilege` VALUES ('9938f86ceee94b6c8ee4c259d2280d70', 'operator_change_password_page', '2', '2', '修改密码', '2b89bc1cf1704ed6940bb35721e01a4d', '2');
INSERT INTO `sys_privilege` VALUES ('9c49c0a8a2cf4ff2babf415d1b2cf2d8', 'agent_manage_modify', '2', '3', '修改', 'e7873a28bd644878abdb6e0c7cce1d38', '3');
INSERT INTO `sys_privilege` VALUES ('a0659fe882784625a24938a026da9398', 'operator_reset_password', '2', '3', '重置密码', '56a316de15014107853b9fa8e5f6109e', '5');
INSERT INTO `sys_privilege` VALUES ('a3ac49b05c4447149253d8fc4007da8c', 'operator_terminal_user_reset_password', '2', '3', '重置密码', '46d3556da48e47118c40ede7d9ff6266', '5');
INSERT INTO `sys_privilege` VALUES ('a6bc77ce38144363bc32a4ac5633ef1b', 'bill_detail_page', '2', '3', '账单详情', '57b196f52aa7429bbc3add3fbe854f59', '5');
INSERT INTO `sys_privilege` VALUES ('a6f8008b30b7481da3d286d11677f25e', 'bill_part_page', '2', '3', '账单部份', '57b196f52aa7429bbc3add3fbe854f59', '4');
INSERT INTO `sys_privilege` VALUES ('a7bb4751561e4583ad040209f7fd8cfe', 'sys_disk_image_manage_add', '2', '3', '添加', '0e75c8aefe5240229c6cc1c778baa801', '2');
INSERT INTO `sys_privilege` VALUES ('a88ca4ce5f86402db4a7dd68fc9e5ab1', 'sys_role_manage_set_privilege', '2', '3', '设置权限', '8d366c19c4284aa8ac0a178c0b80af1e', '5');
INSERT INTO `sys_privilege` VALUES ('aa78c12d60d743b19511ba5312752921', 'service_detail_agent', '2', '2', '业务明细', '6bd730a92be3430bbbc95519b90f161c', '10');
INSERT INTO `sys_privilege` VALUES ('ab229cadc3c6428d8c274048a4849e6f', 'statement_manage_page_agent', '2', '2', '报表统计页面', '6bd730a92be3430bbbc95519b90f161c', '14');
INSERT INTO `sys_privilege` VALUES ('ac7e1a5e1a71463096a3b5653395b262', 'monitor_rule_add', '2', '5', '新增', 'eccf127b99c948049b65d01dbdd65671', '2');
INSERT INTO `sys_privilege` VALUES ('b07ef2b9fcc74faeb1c7eaaab63e47a2', 'message_mail_config_manage_delete', '2', '5', '删除配置', 'dc2f20c40f72483da7f3932b28acae62', '4');
INSERT INTO `sys_privilege` VALUES ('b126d7ced0f54f6f93778a3ef73c7b21', 'message_mail_config_manage_add', '2', '5', '新增配置', 'dc2f20c40f72483da7f3932b28acae62', '2');
INSERT INTO `sys_privilege` VALUES ('b152b5e973314d5eb25ccb78eb9997c7', 'cloud_host_manage_page_agent', '2', '3', '云主机管理页面', 'fa337b5198d5422eb9532df68607865a', '4');
INSERT INTO `sys_privilege` VALUES ('b6b7825ed8d843d4b1fa1f61a7bbfda5', 'consumption_detail_agent', '2', '2', '消费明细', '6bd730a92be3430bbbc95519b90f161c', '12');
INSERT INTO `sys_privilege` VALUES ('bb0cd0133c6d46afa919d8d939a575f4', 'bill_manage_page', '2', '3', '账单管理页面', '57b196f52aa7429bbc3add3fbe854f59', '1');
INSERT INTO `sys_privilege` VALUES ('bb8edf0f99344615afb642371f398f68', 'message_mail_manage', '2', '3', '邮件管理', '760f385e794f46959348434cee792294', '11');
INSERT INTO `sys_privilege` VALUES ('bd6b0f5d324742c9932024c7eb2bcc23', 'monitor_rule_modify', '2', '5', '修改', 'eccf127b99c948049b65d01dbdd65671', '3');
INSERT INTO `sys_privilege` VALUES ('bd89c0246e8c4f8195d1c5047006e533', 'operator_self_use_cloud_host_insert_iso_image_page', '2', '3', '加载光盘', '760f385e794f46959348434cee792294', '7');
INSERT INTO `sys_privilege` VALUES ('bdc5834a11914f7aac177303e453bb50', 'self_use_cloud_host_page', '2', '3', '自用云主机页面', '760f385e794f46959348434cee792294', '1');
INSERT INTO `sys_privilege` VALUES ('c05a095ac42b479f81f6c1a6554ef50e', 'terminal_user_manage_page_for_operator', '2', '3', '终端用户管理页面', '46d3556da48e47118c40ede7d9ff6266', '1');
INSERT INTO `sys_privilege` VALUES ('c16ee70e03854d879745408768dbafbd', 'monitor_rule_query', '2', '5', '查询', 'eccf127b99c948049b65d01dbdd65671', '1');
INSERT INTO `sys_privilege` VALUES ('c30950db2eb8405fa72fb394da085ddf', 'sys_role_manage_delete', '2', '3', '删除', '8d366c19c4284aa8ac0a178c0b80af1e', '4');
INSERT INTO `sys_privilege` VALUES ('c4e20be4399244c99f3b56d6d7f3122b', 'message_mail_config_manage_modify', '2', '5', '修改配置', 'dc2f20c40f72483da7f3932b28acae62', '3');
INSERT INTO `sys_privilege` VALUES ('c6062eef7e4a439d9b24fbc54890951b', 'statement_manage_page_operator', '2', '2', '报表统计页面', '2b89bc1cf1704ed6940bb35721e01a4d', '13');
INSERT INTO `sys_privilege` VALUES ('c681ba3ffe3141bcbf3a6880c604b08d', 'message_mail_template_manage_modify', '2', '5', '修改模版', '4acd08940b65421aadb13f70d8963d26', '3');
INSERT INTO `sys_privilege` VALUES ('c7e5fa72e23145f3b5a72780e2040bf2', 'cloud_host_view_detail', '2', '3', '云主机查看详情', '760f385e794f46959348434cee792294', '3');
INSERT INTO `sys_privilege` VALUES ('c92d505d53fa47dfb8d5b3d8c8577cba', 'statement_manage_agent', '2', '2', '报表管理', '6bd730a92be3430bbbc95519b90f161c', '13');
INSERT INTO `sys_privilege` VALUES ('cb65bc64b168452f8dd17102d8b4b765', 'operator_self_use_cloud_host_update_password', '2', '3', '修改监控密码', '760f385e794f46959348434cee792294', '10');
INSERT INTO `sys_privilege` VALUES ('cbb0ee47ad6d4a11835af5d9f4718839', 'agent_manage_delete', '2', '3', '删除', 'e7873a28bd644878abdb6e0c7cce1d38', '4');
INSERT INTO `sys_privilege` VALUES ('ccc5e6633ca946dbb8d1c5417bba38fe', 'warehouse_manage_page', '2', '3', '库存类型管理页面', 'fd45cd4813a9497b936e3efda9fc7ae9', '1');
INSERT INTO `sys_privilege` VALUES ('d201231880d44802a2eb2fcd64941709', 'mark_manage_page', '2', '2', '标签管理页面', '2b89bc1cf1704ed6940bb35721e01a4d', '3');
INSERT INTO `sys_privilege` VALUES ('d253a8ccb53341bf8038e29a2291adad', 'operator_manage_add', '2', '3', '添加', '56a316de15014107853b9fa8e5f6109e', '2');
INSERT INTO `sys_privilege` VALUES ('d3731d2acdc24577b80b4bbf59a51fa5', 'sys_disk_image_manage_modify', '2', '3', '修改', '0e75c8aefe5240229c6cc1c778baa801', '3');
INSERT INTO `sys_privilege` VALUES ('d9fd99f0bbfe48cd87588ff78889d1a4', 'sys_group_manage_page', '2', '3', '系统权限组管理页面', '195e5ddd29e44563b09a5df35b33211f', '1');
INSERT INTO `sys_privilege` VALUES ('da99d579ef8d483e96f278892aaef773', 'suggestion_manage_page_operator', '2', '2', '意见反馈', '2b89bc1cf1704ed6940bb35721e01a4d', '14');
INSERT INTO `sys_privilege` VALUES ('db3ba29743b44a4a8035e4aa8eb76499', 'bill_manage_page_agent', '2', '3', '账单管理页面', 'e4c0cd0f353649fabf639a9d0a327e66', '1');
INSERT INTO `sys_privilege` VALUES ('dc2f20c40f72483da7f3932b28acae62', 'message_mail_config_manage', '2', '4', '邮件配置管理', 'bb8edf0f99344615afb642371f398f68', '1');
INSERT INTO `sys_privilege` VALUES ('dd1eede4bea846339e16632963735fb8', 'cloud_host_create', '2', '3', '创建云主机', '760f385e794f46959348434cee792294', '2');
INSERT INTO `sys_privilege` VALUES ('de2cb3a91d324d0388f46fe80554331b', 'operator_self_use_cloud_host_terminal_binding_page', '2', '3', '绑定终端', '760f385e794f46959348434cee792294', '9');
INSERT INTO `sys_privilege` VALUES ('de49fdb25dcb4d329ce1f026624c0dc8', 'recharge_detail_agent', '2', '2', '充值明细', '6bd730a92be3430bbbc95519b90f161c', '11');
INSERT INTO `sys_privilege` VALUES ('e35858c69b504c3c80fbbc544dbbece1', 'operator_cash_coupon_send_email', '2', '3', '发送到邮箱', '245ef10c85d142f4b6be94225c299a2e', '5');
INSERT INTO `sys_privilege` VALUES ('e4c0cd0f353649fabf639a9d0a327e66', 'bill_manage_agent', '2', '2', '账单管理', '6bd730a92be3430bbbc95519b90f161c', '6');
INSERT INTO `sys_privilege` VALUES ('e5ab5f8664e942b2b52647a976f9824c', 'cpu_package_option_add', '2', '3', 'CPU套餐项添加', '879bef28004742efa9771643bd04e179', '3');
INSERT INTO `sys_privilege` VALUES ('e5cb5cfac2104789a81b1cbd317dd409', 'sys_group_manage_delete', '2', '3', '删除', '195e5ddd29e44563b09a5df35b33211f', '4');
INSERT INTO `sys_privilege` VALUES ('e6bbed3b41c94113ac0330f6c0eb604f', 'monitor_manage', '2', '3', '监控信息管理', '760f385e794f46959348434cee792294', '12');
INSERT INTO `sys_privilege` VALUES ('e7873a28bd644878abdb6e0c7cce1d38', 'agent_manage', '2', '2', '代理商管理', '2b89bc1cf1704ed6940bb35721e01a4d', '5');
INSERT INTO `sys_privilege` VALUES ('e8ba31d9cb9a4e01b5b92ba4aecaa747', 'package_item_manage_page', '2', '3', '套餐项管理页面', '879bef28004742efa9771643bd04e179', '1');
INSERT INTO `sys_privilege` VALUES ('e8ba7ebd1cb64d0ead5189f41841c766', 'monitor_rack', '2', '4', '机架信息监控', 'e6bbed3b41c94113ac0330f6c0eb604f', '3');
INSERT INTO `sys_privilege` VALUES ('e8c6c39065fe4628a91aff941d38ee48', 'terminal_user_manage_agent', '2', '2', '终端用户管理', '6bd730a92be3430bbbc95519b90f161c', '5');
INSERT INTO `sys_privilege` VALUES ('eccf127b99c948049b65d01dbdd65671', 'monitor_rule_manage', '2', '4', '预警规则管理', 'e6bbed3b41c94113ac0330f6c0eb604f', '6');
INSERT INTO `sys_privilege` VALUES ('f01eda1c34ae4381b3b2d618e9b11e17', 'self_use_cloud_host_page_agent', '2', '3', '自用云主机页面', 'fa337b5198d5422eb9532df68607865a', '1');
INSERT INTO `sys_privilege` VALUES ('f10dabe50eef4a7a88e48e4502a8875a', 'operator_basic_information_page', '2', '2', '基本资料', '2b89bc1cf1704ed6940bb35721e01a4d', '1');
INSERT INTO `sys_privilege` VALUES ('f3f0d3e4a5af4ab2b6766f9b22a6055d', 'agent_recharge', '2', '2', '账户充值', '6bd730a92be3430bbbc95519b90f161c', '3');
INSERT INTO `sys_privilege` VALUES ('fa337b5198d5422eb9532df68607865a', 'cloud_host_manage_agent', '2', '2', '云主机管理', '6bd730a92be3430bbbc95519b90f161c', '4');
INSERT INTO `sys_privilege` VALUES ('fc6256b87bdf4c40ac79c73ab14dca10', 'invoice_manage_page_operator', '2', '2', '发票管理', '2b89bc1cf1704ed6940bb35721e01a4d', '12');
INSERT INTO `sys_privilege` VALUES ('fca63f27dcbd4a2db2a819f47a54e755', 'terminal_user_manage_modify', '2', '3', '修改', '46d3556da48e47118c40ede7d9ff6266', '3');
INSERT INTO `sys_privilege` VALUES ('fd45cd4813a9497b936e3efda9fc7ae9', 'warehouse_manage', '2', '2', '库存类型管理', '2b89bc1cf1704ed6940bb35721e01a4d', '11');
INSERT INTO `sys_privilege` VALUES ('fec109c7a05443d68072b39a3affdd99', 'cloud_host_view_detail_agent', '2', '3', '云主机查看详情', 'fa337b5198d5422eb9532df68607865a', '3');

-- ----------------------------
-- Table structure for `sys_privilege_role_relation`
-- ----------------------------
DROP TABLE IF EXISTS `sys_privilege_role_relation`;
CREATE TABLE `sys_privilege_role_relation` (
  `id` varchar(32) NOT NULL,
  `role_id` varchar(32) DEFAULT NULL,
  `privilege_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_privilege_role_relation
-- ----------------------------
INSERT INTO `sys_privilege_role_relation` VALUES ('0310af173eb24e69a6685e4414d1b9e2', '624fa127491842ebb22065fb6c3f9959', 'cb65bc64b168452f8dd17102d8b4b765');
INSERT INTO `sys_privilege_role_relation` VALUES ('04dde8b7635945dba4b0d251378cd7c4', 'bee006a8193a4e2bb0d4d70236037d29', '55c23831cedc441d927fb19e347ed91d');
INSERT INTO `sys_privilege_role_relation` VALUES ('0545ef1dd82d479b9f5b6afc88852acb', 'bee006a8193a4e2bb0d4d70236037d29', '44570277179841578f4519f88924df5b');
INSERT INTO `sys_privilege_role_relation` VALUES ('067b0c04a69c45198eedafb9ded736e0', '624fa127491842ebb22065fb6c3f9959', 'c681ba3ffe3141bcbf3a6880c604b08d');
INSERT INTO `sys_privilege_role_relation` VALUES ('07a0df32f4ec45cb96824da8f41ac931', '6cd93866cb2c49f69c62af4f90d3ab6f', '89354d29cb374a21b99503067af33b1a');
INSERT INTO `sys_privilege_role_relation` VALUES ('07f3ca0a1be8434eab65e8c6fc5b36e7', 'bee006a8193a4e2bb0d4d70236037d29', 'cb65bc64b168452f8dd17102d8b4b765');
INSERT INTO `sys_privilege_role_relation` VALUES ('0878dae013f14f5bbb49c0b86a8ab448', '624fa127491842ebb22065fb6c3f9959', 'fc6256b87bdf4c40ac79c73ab14dca10');
INSERT INTO `sys_privilege_role_relation` VALUES ('096f94ee74f74ec6b87ef53b61a5b838', '624fa127491842ebb22065fb6c3f9959', '3d694ff143fb4ee0ac5c0808a5f6b225');
INSERT INTO `sys_privilege_role_relation` VALUES ('0a1554b90f48453ca3058e951239a8df', 'bee006a8193a4e2bb0d4d70236037d29', '38eb29f1075748b19676bf5ff7ed52f6');
INSERT INTO `sys_privilege_role_relation` VALUES ('0a31676eac064ffe82df640a526fca78', 'bee006a8193a4e2bb0d4d70236037d29', 'ccc5e6633ca946dbb8d1c5417bba38fe');
INSERT INTO `sys_privilege_role_relation` VALUES ('0bdc6c532e4f4559af051f14a4669bf4', '624fa127491842ebb22065fb6c3f9959', '03194d1ed510421a8b89c075fc6d3695');
INSERT INTO `sys_privilege_role_relation` VALUES ('0c3ccc6b9f2e45afb46970c8e667b9a4', '984c39480d9f42e8a03869305611ff40', 'e4c0cd0f353649fabf639a9d0a327e66');
INSERT INTO `sys_privilege_role_relation` VALUES ('0c54f2c2d4284890af122309bde2c949', '6cd93866cb2c49f69c62af4f90d3ab6f', '973caa655b004ef3a431986917ba61c5');
INSERT INTO `sys_privilege_role_relation` VALUES ('0cb305cc3f744b1abdc0a415558127ed', 'bee006a8193a4e2bb0d4d70236037d29', 'b6b7825ed8d843d4b1fa1f61a7bbfda5');
INSERT INTO `sys_privilege_role_relation` VALUES ('0e203ef5abc84358bb5008e1038cd608', '624fa127491842ebb22065fb6c3f9959', '9938f86ceee94b6c8ee4c259d2280d70');
INSERT INTO `sys_privilege_role_relation` VALUES ('0e99070753f44b32aa362548481d1b5d', 'bee006a8193a4e2bb0d4d70236037d29', '9c49c0a8a2cf4ff2babf415d1b2cf2d8');
INSERT INTO `sys_privilege_role_relation` VALUES ('13ac6367936f42d8aac474629596178f', '624fa127491842ebb22065fb6c3f9959', 'b126d7ced0f54f6f93778a3ef73c7b21');
INSERT INTO `sys_privilege_role_relation` VALUES ('13fb78b7e43346778346d00eb9e4ba3f', '6cd93866cb2c49f69c62af4f90d3ab6f', '531ca93856c74f17a4d50fb7729ae3cc');
INSERT INTO `sys_privilege_role_relation` VALUES ('146996c4c5954676879ee4e7a7d07f0c', '624fa127491842ebb22065fb6c3f9959', '247c064e4b22418e8d704318bb5df544');
INSERT INTO `sys_privilege_role_relation` VALUES ('16396424bfdf49f2bc4aa453b790d885', 'bee006a8193a4e2bb0d4d70236037d29', '89354d29cb374a21b99503067af33b1a');
INSERT INTO `sys_privilege_role_relation` VALUES ('18af27f3111e4a52bf28af7364581363', 'bee006a8193a4e2bb0d4d70236037d29', '760f385e794f46959348434cee792294');
INSERT INTO `sys_privilege_role_relation` VALUES ('18bb26b9ff6d46139818b5f6516805a5', 'bee006a8193a4e2bb0d4d70236037d29', 'e8ba7ebd1cb64d0ead5189f41841c766');
INSERT INTO `sys_privilege_role_relation` VALUES ('195292cd0f46411aaecbcc682b12c4e9', 'bee006a8193a4e2bb0d4d70236037d29', '7fe4053cae044d1598b45163d9a2944e');
INSERT INTO `sys_privilege_role_relation` VALUES ('196dfb359b084a05880f097c025d3613', '624fa127491842ebb22065fb6c3f9959', '14ccd4bf2fc54c5b9b23dfbca5fbe78d');
INSERT INTO `sys_privilege_role_relation` VALUES ('1ad3a54eb5454e8ab920f26aaff5387b', 'bee006a8193a4e2bb0d4d70236037d29', '4189695f1f8a4986a12ef41c3f6f5944');
INSERT INTO `sys_privilege_role_relation` VALUES ('1b38ba220a1741899ce7cce60a0d024c', '624fa127491842ebb22065fb6c3f9959', '5fad147a8d4f4a6492670193b497b848');
INSERT INTO `sys_privilege_role_relation` VALUES ('1c89013de3d24cf7b02b9bcd3f1ba0ab', 'bee006a8193a4e2bb0d4d70236037d29', 'e8c6c39065fe4628a91aff941d38ee48');
INSERT INTO `sys_privilege_role_relation` VALUES ('1cefd384f8804b38a94ffb5c342033b0', '624fa127491842ebb22065fb6c3f9959', '6ca35a991b464039a2f2d516d3d622dd');
INSERT INTO `sys_privilege_role_relation` VALUES ('1d1044824dcd455383eebb39e068223f', '624fa127491842ebb22065fb6c3f9959', '93cbfce957b34ec28d529284c7d466ab');
INSERT INTO `sys_privilege_role_relation` VALUES ('1d3bf7ccd4ac46a1b78df5c996752de2', 'ffc94b71ed8a4e9ab6937ad73d3b9380', '0bf3e360110442619b5ff08dd2a9782d');
INSERT INTO `sys_privilege_role_relation` VALUES ('1ebc161dd43f4a4d816258a19fef6372', '6cd93866cb2c49f69c62af4f90d3ab6f', '067018eae70b48c38db0799bc1bd66c4');
INSERT INTO `sys_privilege_role_relation` VALUES ('1f586556ec4e4e2b924c7f67ea94fa14', 'bee006a8193a4e2bb0d4d70236037d29', '556df5c1e52648be880fcadb1ba4bf9f');
INSERT INTO `sys_privilege_role_relation` VALUES ('201e5a1bab1e49d4969c14ac4cad6867', '624fa127491842ebb22065fb6c3f9959', 'a6f8008b30b7481da3d286d11677f25e');
INSERT INTO `sys_privilege_role_relation` VALUES ('2104ee265d034987810122a4ca9ae017', 'bee006a8193a4e2bb0d4d70236037d29', 'fa337b5198d5422eb9532df68607865a');
INSERT INTO `sys_privilege_role_relation` VALUES ('21425ce11fe74d0b8f1dad1915dde49e', '624fa127491842ebb22065fb6c3f9959', 'bd6b0f5d324742c9932024c7eb2bcc23');
INSERT INTO `sys_privilege_role_relation` VALUES ('21a437cff1f94769a97ca8b862c84de7', '624fa127491842ebb22065fb6c3f9959', 'bb8edf0f99344615afb642371f398f68');
INSERT INTO `sys_privilege_role_relation` VALUES ('21dafd5c59bd4596ae2d34e4e5b5063e', '984c39480d9f42e8a03869305611ff40', '977b81cb8bd745cb915f5750b0ccb802');
INSERT INTO `sys_privilege_role_relation` VALUES ('268f93a3e5cf4646be4097530046e7b5', 'bee006a8193a4e2bb0d4d70236037d29', '128c61e8435747be96fdce3a36c6695b');
INSERT INTO `sys_privilege_role_relation` VALUES ('26afa7af11ec4d6fb6309f25d06dea1f', 'bee006a8193a4e2bb0d4d70236037d29', '22879786cf5e419d96b461d183924ec5');
INSERT INTO `sys_privilege_role_relation` VALUES ('289d6bf7f2ce48f7a55f1dc52201bffd', 'ffc94b71ed8a4e9ab6937ad73d3b9380', 'c7e5fa72e23145f3b5a72780e2040bf2');
INSERT INTO `sys_privilege_role_relation` VALUES ('2a95a5f59aa44a74bd50dc14a9596393', 'bee006a8193a4e2bb0d4d70236037d29', '6ca35a991b464039a2f2d516d3d622dd');
INSERT INTO `sys_privilege_role_relation` VALUES ('2b8b2c985f3b4072802139ae71d4dc64', '984c39480d9f42e8a03869305611ff40', 'ab229cadc3c6428d8c274048a4849e6f');
INSERT INTO `sys_privilege_role_relation` VALUES ('2e6d9109d778429b85c8024979c1b23f', 'bee006a8193a4e2bb0d4d70236037d29', '0b267f4d18cf44799746a5cddcf82840');
INSERT INTO `sys_privilege_role_relation` VALUES ('2ef72862bdbc48f3ba2f10cc5e3efd86', 'bee006a8193a4e2bb0d4d70236037d29', '05cd19aeb4954c3cb3e278c96908921c');
INSERT INTO `sys_privilege_role_relation` VALUES ('2fcd4829284e4c72b9ad155e3e3b12bb', '6cd93866cb2c49f69c62af4f90d3ab6f', '57832b0450144213b04cdeef32271ea8');
INSERT INTO `sys_privilege_role_relation` VALUES ('30298ab198dd4c9a89fdcaa7a71178bb', '6cd93866cb2c49f69c62af4f90d3ab6f', '92c0f81d18de47b29e9d7afbc3d542c8');
INSERT INTO `sys_privilege_role_relation` VALUES ('303eca434d96450dbc36b94a8bb91901', 'ffc94b71ed8a4e9ab6937ad73d3b9380', 'f10dabe50eef4a7a88e48e4502a8875a');
INSERT INTO `sys_privilege_role_relation` VALUES ('31038a71940c406eae72777e037ace32', 'bee006a8193a4e2bb0d4d70236037d29', 'b126d7ced0f54f6f93778a3ef73c7b21');
INSERT INTO `sys_privilege_role_relation` VALUES ('31bd18bf7a604bcdb2aefc0f10de31f9', 'bee006a8193a4e2bb0d4d70236037d29', 'a3ac49b05c4447149253d8fc4007da8c');
INSERT INTO `sys_privilege_role_relation` VALUES ('31cbdbb6dcaf4e7abb754ad5b7bb815e', '624fa127491842ebb22065fb6c3f9959', '0b267f4d18cf44799746a5cddcf82840');
INSERT INTO `sys_privilege_role_relation` VALUES ('3305ccca700840c9af601ee0b07d92b6', 'ffc94b71ed8a4e9ab6937ad73d3b9380', '38eb29f1075748b19676bf5ff7ed52f6');
INSERT INTO `sys_privilege_role_relation` VALUES ('3385c03f4d83451f8a8ad641f08ef6e5', 'bee006a8193a4e2bb0d4d70236037d29', '5fad147a8d4f4a6492670193b497b848');
INSERT INTO `sys_privilege_role_relation` VALUES ('339ff6d084d84d8087eb2a3544dc17fa', '6cd93866cb2c49f69c62af4f90d3ab6f', 'a6f8008b30b7481da3d286d11677f25e');
INSERT INTO `sys_privilege_role_relation` VALUES ('34601848e561497384e0003b7a39637a', '624fa127491842ebb22065fb6c3f9959', '3c9dae2c105840d7ad637a0f36b0395f');
INSERT INTO `sys_privilege_role_relation` VALUES ('36d051d518074e33a2951f9664d00bb0', 'bee006a8193a4e2bb0d4d70236037d29', '86b9ffdb1a5844c882a0df7f005fcea8');
INSERT INTO `sys_privilege_role_relation` VALUES ('38caff6bb05e4d959b19583a2c4345f9', 'bee006a8193a4e2bb0d4d70236037d29', 'a7bb4751561e4583ad040209f7fd8cfe');
INSERT INTO `sys_privilege_role_relation` VALUES ('39932afc2b3f4db58bdafcebdbac6a2f', '624fa127491842ebb22065fb6c3f9959', 'c05a095ac42b479f81f6c1a6554ef50e');
INSERT INTO `sys_privilege_role_relation` VALUES ('39d233eecfd7412daea18164fe36d2e6', 'bee006a8193a4e2bb0d4d70236037d29', '160f7d545e9e49119baff46349f60438');
INSERT INTO `sys_privilege_role_relation` VALUES ('3c202cf347f8477d96a4570f73c150e3', 'bee006a8193a4e2bb0d4d70236037d29', '03194d1ed510421a8b89c075fc6d3695');
INSERT INTO `sys_privilege_role_relation` VALUES ('3c3dcba5a50e4ad294bde2e84173fc1c', 'bee006a8193a4e2bb0d4d70236037d29', 'cbb0ee47ad6d4a11835af5d9f4718839');
INSERT INTO `sys_privilege_role_relation` VALUES ('3db7a4b7fed643b49504413fc79feef2', 'ffc94b71ed8a4e9ab6937ad73d3b9380', '583a315bd31b4fcbb34904b5cbf553c8');
INSERT INTO `sys_privilege_role_relation` VALUES ('4014766545fb473fb02fd771c3b8bfba', 'bee006a8193a4e2bb0d4d70236037d29', '1d0a125e75764a1fa1a404f8b74d9b3f');
INSERT INTO `sys_privilege_role_relation` VALUES ('42026d14917b4aada9d1422df56a6513', '6cd93866cb2c49f69c62af4f90d3ab6f', '556df5c1e52648be880fcadb1ba4bf9f');
INSERT INTO `sys_privilege_role_relation` VALUES ('4238fb7b692248eb8d04805ade15a5ad', '624fa127491842ebb22065fb6c3f9959', 'e6bbed3b41c94113ac0330f6c0eb604f');
INSERT INTO `sys_privilege_role_relation` VALUES ('42548e025e3f4c9c8ef5232c65d481a9', '984c39480d9f42e8a03869305611ff40', '7174cfd19c544e7abbba242549b3d79d');
INSERT INTO `sys_privilege_role_relation` VALUES ('450ecb625b174c3db347e1ac1fd85bf7', 'bee006a8193a4e2bb0d4d70236037d29', '0bf3e360110442619b5ff08dd2a9782d');
INSERT INTO `sys_privilege_role_relation` VALUES ('4518ec1eaf25471b96a71da9303ad255', 'bee006a8193a4e2bb0d4d70236037d29', '597d3680983643afa4f3ec44564143d8');
INSERT INTO `sys_privilege_role_relation` VALUES ('4664f8696c5c441884c05b1e9b7043f6', '984c39480d9f42e8a03869305611ff40', 'e8c6c39065fe4628a91aff941d38ee48');
INSERT INTO `sys_privilege_role_relation` VALUES ('4872fd32da7345ceb98260bb9bc21699', '6cd93866cb2c49f69c62af4f90d3ab6f', '57b196f52aa7429bbc3add3fbe854f59');
INSERT INTO `sys_privilege_role_relation` VALUES ('49ff74b628a241cda295c880eb8c3c7c', '624fa127491842ebb22065fb6c3f9959', '57832b0450144213b04cdeef32271ea8');
INSERT INTO `sys_privilege_role_relation` VALUES ('4a171e9349224029ab466e7bc50419cb', '984c39480d9f42e8a03869305611ff40', '067018eae70b48c38db0799bc1bd66c4');
INSERT INTO `sys_privilege_role_relation` VALUES ('4ac6f6048275407f9f700801fb6bc32a', '984c39480d9f42e8a03869305611ff40', '973caa655b004ef3a431986917ba61c5');
INSERT INTO `sys_privilege_role_relation` VALUES ('4aeaf08c86e24471aeaf3441f0878495', '624fa127491842ebb22065fb6c3f9959', '583a315bd31b4fcbb34904b5cbf553c8');
INSERT INTO `sys_privilege_role_relation` VALUES ('4b1ccc0897c54fc19aa4fd79f32ad77e', '6cd93866cb2c49f69c62af4f90d3ab6f', 'f10dabe50eef4a7a88e48e4502a8875a');
INSERT INTO `sys_privilege_role_relation` VALUES ('4b741f49d75e4ba9abd287d68391ed0b', 'bee006a8193a4e2bb0d4d70236037d29', 'da99d579ef8d483e96f278892aaef773');
INSERT INTO `sys_privilege_role_relation` VALUES ('4de65edde4484268ba5acd5db057b000', 'bee006a8193a4e2bb0d4d70236037d29', 'd201231880d44802a2eb2fcd64941709');
INSERT INTO `sys_privilege_role_relation` VALUES ('4eb2cc6dc36a47f585e55c8c729bdbdc', 'bee006a8193a4e2bb0d4d70236037d29', 'b152b5e973314d5eb25ccb78eb9997c7');
INSERT INTO `sys_privilege_role_relation` VALUES ('56145697a4054b52848dc1f44157b606', 'ffc94b71ed8a4e9ab6937ad73d3b9380', 'c05a095ac42b479f81f6c1a6554ef50e');
INSERT INTO `sys_privilege_role_relation` VALUES ('562e27e69a694bcd81e1b18816fe923c', '624fa127491842ebb22065fb6c3f9959', 'bb0cd0133c6d46afa919d8d939a575f4');
INSERT INTO `sys_privilege_role_relation` VALUES ('58a93d3e360f4fbe8eadb93f59f9342f', '624fa127491842ebb22065fb6c3f9959', '5cf007f657f34ce29e3ef1712a1ec68a');
INSERT INTO `sys_privilege_role_relation` VALUES ('599a254223f74ddcb5ce5f4c842c2d54', '624fa127491842ebb22065fb6c3f9959', '674e3cd7c37b4429a325a1cf4c462ed7');
INSERT INTO `sys_privilege_role_relation` VALUES ('5b854f8f356c4591846840347590b064', 'ffc94b71ed8a4e9ab6937ad73d3b9380', '14ccd4bf2fc54c5b9b23dfbca5fbe78d');
INSERT INTO `sys_privilege_role_relation` VALUES ('5b944174a6274ecea0c1caa215c8add6', 'ffc94b71ed8a4e9ab6937ad73d3b9380', '05cd19aeb4954c3cb3e278c96908921c');
INSERT INTO `sys_privilege_role_relation` VALUES ('5cc56c00cc004019a00272e733e7e2f4', '624fa127491842ebb22065fb6c3f9959', 'ac7e1a5e1a71463096a3b5653395b262');
INSERT INTO `sys_privilege_role_relation` VALUES ('5cd0fd1b7b8746a7b35bcec0f276a599', 'bee006a8193a4e2bb0d4d70236037d29', 'a6bc77ce38144363bc32a4ac5633ef1b');
INSERT INTO `sys_privilege_role_relation` VALUES ('5cfd61bf938647f3b122f09ec1bb67fd', '6cd93866cb2c49f69c62af4f90d3ab6f', '22879786cf5e419d96b461d183924ec5');
INSERT INTO `sys_privilege_role_relation` VALUES ('5dad25e5640f4ff59999be3d4c1c6b7e', '984c39480d9f42e8a03869305611ff40', 'b6b7825ed8d843d4b1fa1f61a7bbfda5');
INSERT INTO `sys_privilege_role_relation` VALUES ('5e2fd9af73804334bdfa66ff234a9a21', '624fa127491842ebb22065fb6c3f9959', 'c4e20be4399244c99f3b56d6d7f3122b');
INSERT INTO `sys_privilege_role_relation` VALUES ('5f9195f4df2d401ead5bc42118d3ba24', '624fa127491842ebb22065fb6c3f9959', '024cc8ec3fdb429aa52f96091564ec83');
INSERT INTO `sys_privilege_role_relation` VALUES ('5fdd0983cb4e4ff78554e42e597843bf', 'bee006a8193a4e2bb0d4d70236037d29', 'bb8edf0f99344615afb642371f398f68');
INSERT INTO `sys_privilege_role_relation` VALUES ('605f52cc2b1c4634a55de4408622b8d1', 'bee006a8193a4e2bb0d4d70236037d29', 'bb0cd0133c6d46afa919d8d939a575f4');
INSERT INTO `sys_privilege_role_relation` VALUES ('60bf6a37991d48379be2a70c7dd48124', 'bee006a8193a4e2bb0d4d70236037d29', '583a315bd31b4fcbb34904b5cbf553c8');
INSERT INTO `sys_privilege_role_relation` VALUES ('61a4117cf6e24ec8add5c8343f4aa413', 'bee006a8193a4e2bb0d4d70236037d29', 'dc2f20c40f72483da7f3932b28acae62');
INSERT INTO `sys_privilege_role_relation` VALUES ('62767e4a5be94be2b0939300943efd40', '624fa127491842ebb22065fb6c3f9959', 'a6bc77ce38144363bc32a4ac5633ef1b');
INSERT INTO `sys_privilege_role_relation` VALUES ('639905e7dd8247b288f7e0dc146b21de', 'bee006a8193a4e2bb0d4d70236037d29', 'e4c0cd0f353649fabf639a9d0a327e66');
INSERT INTO `sys_privilege_role_relation` VALUES ('63a0074efb81471eb5d2f2a78110ad43', 'bee006a8193a4e2bb0d4d70236037d29', 'c6062eef7e4a439d9b24fbc54890951b');
INSERT INTO `sys_privilege_role_relation` VALUES ('6415f1890bc04e49a9c0f97747829052', '984c39480d9f42e8a03869305611ff40', '556df5c1e52648be880fcadb1ba4bf9f');
INSERT INTO `sys_privilege_role_relation` VALUES ('667d30faba654d7c8a240dc33859f632', '624fa127491842ebb22065fb6c3f9959', 'e8ba7ebd1cb64d0ead5189f41841c766');
INSERT INTO `sys_privilege_role_relation` VALUES ('66c1fb535fd248a992993011056c82f6', 'bee006a8193a4e2bb0d4d70236037d29', 'aa78c12d60d743b19511ba5312752921');
INSERT INTO `sys_privilege_role_relation` VALUES ('677e508112f54080abf7bd5c2c7f9af5', '624fa127491842ebb22065fb6c3f9959', 'ccc5e6633ca946dbb8d1c5417bba38fe');
INSERT INTO `sys_privilege_role_relation` VALUES ('687fc3d8ce3646b09bc33b133e8ccda4', '984c39480d9f42e8a03869305611ff40', '6bd730a92be3430bbbc95519b90f161c');
INSERT INTO `sys_privilege_role_relation` VALUES ('694b8604761e479ea0930f6b5767fddd', 'bee006a8193a4e2bb0d4d70236037d29', '2e546273894f4e76adf3633e62afc0ef');
INSERT INTO `sys_privilege_role_relation` VALUES ('69c0add33fb24718a5c6bdf7c3950a86', '624fa127491842ebb22065fb6c3f9959', '57b196f52aa7429bbc3add3fbe854f59');
INSERT INTO `sys_privilege_role_relation` VALUES ('6a91cd8228cc4fb6b6f24a8b796ab939', 'bee006a8193a4e2bb0d4d70236037d29', '57b196f52aa7429bbc3add3fbe854f59');
INSERT INTO `sys_privilege_role_relation` VALUES ('6af462d5bf354d9cbf46436ac6ded27e', '624fa127491842ebb22065fb6c3f9959', 'f10dabe50eef4a7a88e48e4502a8875a');
INSERT INTO `sys_privilege_role_relation` VALUES ('6b55bcf467044ba1b68801dccc906d71', '984c39480d9f42e8a03869305611ff40', '754e6cf0a4184ec5942d31dae52cbddf');
INSERT INTO `sys_privilege_role_relation` VALUES ('6b897823cfb3445690dfd366baf84b24', 'bee006a8193a4e2bb0d4d70236037d29', '973caa655b004ef3a431986917ba61c5');
INSERT INTO `sys_privilege_role_relation` VALUES ('6bfd31fddde84d5283582475d8bbd81c', 'bee006a8193a4e2bb0d4d70236037d29', 'c92d505d53fa47dfb8d5b3d8c8577cba');
INSERT INTO `sys_privilege_role_relation` VALUES ('6cb78195b3934a61ac55618b9465bb5a', '624fa127491842ebb22065fb6c3f9959', 'c7e5fa72e23145f3b5a72780e2040bf2');
INSERT INTO `sys_privilege_role_relation` VALUES ('6da25e0755184db396693912e7245be5', '6cd93866cb2c49f69c62af4f90d3ab6f', '6ca35a991b464039a2f2d516d3d622dd');
INSERT INTO `sys_privilege_role_relation` VALUES ('6e77c054c5c54e6b85d6c2701090b347', '624fa127491842ebb22065fb6c3f9959', '4acd08940b65421aadb13f70d8963d26');
INSERT INTO `sys_privilege_role_relation` VALUES ('6e836e43feed43ff8fecd627304cc9bc', 'bee006a8193a4e2bb0d4d70236037d29', '754e6cf0a4184ec5942d31dae52cbddf');
INSERT INTO `sys_privilege_role_relation` VALUES ('7005a77b06ec42089f8d3b08a6fd4793', 'bee006a8193a4e2bb0d4d70236037d29', 'fd45cd4813a9497b936e3efda9fc7ae9');
INSERT INTO `sys_privilege_role_relation` VALUES ('72432c53eaed4abca9c63210522ff229', 'bee006a8193a4e2bb0d4d70236037d29', 'fca63f27dcbd4a2db2a819f47a54e755');
INSERT INTO `sys_privilege_role_relation` VALUES ('72474f2cc6804c8c89940cbba5def445', '624fa127491842ebb22065fb6c3f9959', 'a3ac49b05c4447149253d8fc4007da8c');
INSERT INTO `sys_privilege_role_relation` VALUES ('72d3769612df4dabbbcd692f56c2ca61', '6cd93866cb2c49f69c62af4f90d3ab6f', 'aa78c12d60d743b19511ba5312752921');
INSERT INTO `sys_privilege_role_relation` VALUES ('73c56082ad534327a5958a423e8fc3eb', 'bee006a8193a4e2bb0d4d70236037d29', 'e8ba31d9cb9a4e01b5b92ba4aecaa747');
INSERT INTO `sys_privilege_role_relation` VALUES ('762ef1dd881c4f0185ee7579510ec6a3', 'ffc94b71ed8a4e9ab6937ad73d3b9380', '9938f86ceee94b6c8ee4c259d2280d70');
INSERT INTO `sys_privilege_role_relation` VALUES ('766a853656b44d1db81fc6f533630e30', '624fa127491842ebb22065fb6c3f9959', '64cfbb3dfff94397aab4960942d340e6');
INSERT INTO `sys_privilege_role_relation` VALUES ('77a0e99d31b9468384a5adeabd76b2cb', 'bee006a8193a4e2bb0d4d70236037d29', '2f4375eda44b4fa1a28432c25c85181c');
INSERT INTO `sys_privilege_role_relation` VALUES ('78a49d2ab7c7448f852a830a2d4e6b3e', '984c39480d9f42e8a03869305611ff40', '92c0f81d18de47b29e9d7afbc3d542c8');
INSERT INTO `sys_privilege_role_relation` VALUES ('7a0342c950374d0891d7b4bb082d5218', 'bee006a8193a4e2bb0d4d70236037d29', 'fec109c7a05443d68072b39a3affdd99');
INSERT INTO `sys_privilege_role_relation` VALUES ('7bc33627f19347d08a2521c82cd53e08', '984c39480d9f42e8a03869305611ff40', '5b99250ad2264864a19454d9122ad800');
INSERT INTO `sys_privilege_role_relation` VALUES ('7c1fcdfc97894116b5799e34d6513646', '624fa127491842ebb22065fb6c3f9959', '128c61e8435747be96fdce3a36c6695b');
INSERT INTO `sys_privilege_role_relation` VALUES ('7c472fa1abd842d990ecff2976847915', '624fa127491842ebb22065fb6c3f9959', '05cd19aeb4954c3cb3e278c96908921c');
INSERT INTO `sys_privilege_role_relation` VALUES ('7c5258fa85764e228423180ac4dbad6c', '6cd93866cb2c49f69c62af4f90d3ab6f', '9938f86ceee94b6c8ee4c259d2280d70');
INSERT INTO `sys_privilege_role_relation` VALUES ('7d342a1b95c04a36940a01110bbeaa32', 'bee006a8193a4e2bb0d4d70236037d29', '14ccd4bf2fc54c5b9b23dfbca5fbe78d');
INSERT INTO `sys_privilege_role_relation` VALUES ('7f27997571a8402488730c3024639ab8', '984c39480d9f42e8a03869305611ff40', 'f3f0d3e4a5af4ab2b6766f9b22a6055d');
INSERT INTO `sys_privilege_role_relation` VALUES ('7f3ec71438644656adc561aa53f645dc', '624fa127491842ebb22065fb6c3f9959', '89354d29cb374a21b99503067af33b1a');
INSERT INTO `sys_privilege_role_relation` VALUES ('8246b7eb7af448678380e5dc4764162e', 'ffc94b71ed8a4e9ab6937ad73d3b9380', '64cfbb3dfff94397aab4960942d340e6');
INSERT INTO `sys_privilege_role_relation` VALUES ('84123e66d30b44f09a6868c21a256e7b', '624fa127491842ebb22065fb6c3f9959', '8a73442783a54b43b7581e3d5c6904f6');
INSERT INTO `sys_privilege_role_relation` VALUES ('84ba684c11fd415ab692b42c1c9358f3', 'bee006a8193a4e2bb0d4d70236037d29', '415042921573401784e6eb2cff82be60');
INSERT INTO `sys_privilege_role_relation` VALUES ('859d0cb19d67423392dde15e963ac8c7', '624fa127491842ebb22065fb6c3f9959', '3efc9dd75173425c925ce97035199aeb');
INSERT INTO `sys_privilege_role_relation` VALUES ('867649e3558a4b218fa41452dde23ec9', '624fa127491842ebb22065fb6c3f9959', 'fca63f27dcbd4a2db2a819f47a54e755');
INSERT INTO `sys_privilege_role_relation` VALUES ('86cac2a1882840d6a953b37b7bc9f84c', 'bee006a8193a4e2bb0d4d70236037d29', '983d657e541742eb8c89acb98f1726a8');
INSERT INTO `sys_privilege_role_relation` VALUES ('87601c8ef78443f4bedc375fff8dd582', 'bee006a8193a4e2bb0d4d70236037d29', '3d694ff143fb4ee0ac5c0808a5f6b225');
INSERT INTO `sys_privilege_role_relation` VALUES ('87d1729f15644b72bcd727f97dac1297', 'bee006a8193a4e2bb0d4d70236037d29', '2b89bc1cf1704ed6940bb35721e01a4d');
INSERT INTO `sys_privilege_role_relation` VALUES ('88f192f254f543a6aed115914c953afa', 'ffc94b71ed8a4e9ab6937ad73d3b9380', '3efc9dd75173425c925ce97035199aeb');
INSERT INTO `sys_privilege_role_relation` VALUES ('8a84da3a403e4e24a8ee1da9daf3b622', 'bee006a8193a4e2bb0d4d70236037d29', 'ac7e1a5e1a71463096a3b5653395b262');
INSERT INTO `sys_privilege_role_relation` VALUES ('8c7b7f4603dd417ab302431b231f7167', '984c39480d9f42e8a03869305611ff40', '6e1cf3ee694b49b6bf4500847f59a37b');
INSERT INTO `sys_privilege_role_relation` VALUES ('8f07d126d9184458802567b294f202f3', 'bee006a8193a4e2bb0d4d70236037d29', '6bd730a92be3430bbbc95519b90f161c');
INSERT INTO `sys_privilege_role_relation` VALUES ('904464b42ff9448793c444eee11916cd', 'bee006a8193a4e2bb0d4d70236037d29', 'd3731d2acdc24577b80b4bbf59a51fa5');
INSERT INTO `sys_privilege_role_relation` VALUES ('9125f4b77f0d436da708e143b1efdb0e', 'bee006a8193a4e2bb0d4d70236037d29', '7b46e9d64ecd43b999e2a712cb37c10a');
INSERT INTO `sys_privilege_role_relation` VALUES ('92ab4444832440fbb7dde53a0f6e6db5', '624fa127491842ebb22065fb6c3f9959', 'fd45cd4813a9497b936e3efda9fc7ae9');
INSERT INTO `sys_privilege_role_relation` VALUES ('9324f49388ef41a4bc30978df546203b', 'ffc94b71ed8a4e9ab6937ad73d3b9380', 'da99d579ef8d483e96f278892aaef773');
INSERT INTO `sys_privilege_role_relation` VALUES ('93504242017341a28e9cb4782215fef8', 'bee006a8193a4e2bb0d4d70236037d29', '3efc9dd75173425c925ce97035199aeb');
INSERT INTO `sys_privilege_role_relation` VALUES ('94201cf710804ab98902dbf9fa434225', 'bee006a8193a4e2bb0d4d70236037d29', '2884927fcc9041c3a41a516eadaf0784');
INSERT INTO `sys_privilege_role_relation` VALUES ('945eb793e87e410d8c08a26f5efe4f1f', '624fa127491842ebb22065fb6c3f9959', 'bd89c0246e8c4f8195d1c5047006e533');
INSERT INTO `sys_privilege_role_relation` VALUES ('9555ba38cd674f99a3044842ba3efa45', 'bee006a8193a4e2bb0d4d70236037d29', 'f01eda1c34ae4381b3b2d618e9b11e17');
INSERT INTO `sys_privilege_role_relation` VALUES ('95e3b8ec5d604c7abf0559261ba76945', 'bee006a8193a4e2bb0d4d70236037d29', '0851b89a1b6249c39843eecee2fd6371');
INSERT INTO `sys_privilege_role_relation` VALUES ('97b094b1b1874a7c95b7cefea3c2cf27', 'bee006a8193a4e2bb0d4d70236037d29', 'b07ef2b9fcc74faeb1c7eaaab63e47a2');
INSERT INTO `sys_privilege_role_relation` VALUES ('99819a78e2364ef2af4f02a8f2ce42bf', 'bee006a8193a4e2bb0d4d70236037d29', '024cc8ec3fdb429aa52f96091564ec83');
INSERT INTO `sys_privilege_role_relation` VALUES ('9a1ff18aec194823a3f8bc1870be0c9f', 'bee006a8193a4e2bb0d4d70236037d29', '57429e337baa4a9091ca3853deb3e386');
INSERT INTO `sys_privilege_role_relation` VALUES ('9b3c2d30490c4bb59dd6f0c60312695e', 'bee006a8193a4e2bb0d4d70236037d29', '24db2a14f1034de18a43b254c53d8f75');
INSERT INTO `sys_privilege_role_relation` VALUES ('9c9274ce609e40afb683e3dde33bb9ae', 'bee006a8193a4e2bb0d4d70236037d29', '245ef10c85d142f4b6be94225c299a2e');
INSERT INTO `sys_privilege_role_relation` VALUES ('9cc006e904a748878623d07712e1318a', 'bee006a8193a4e2bb0d4d70236037d29', 'c05a095ac42b479f81f6c1a6554ef50e');
INSERT INTO `sys_privilege_role_relation` VALUES ('9cc3ef9b109c4261a3f998378f3fc183', 'bee006a8193a4e2bb0d4d70236037d29', '57832b0450144213b04cdeef32271ea8');
INSERT INTO `sys_privilege_role_relation` VALUES ('9eac8009d7704bfdb7eb39bca2ade058', 'bee006a8193a4e2bb0d4d70236037d29', 'bd6b0f5d324742c9932024c7eb2bcc23');
INSERT INTO `sys_privilege_role_relation` VALUES ('9f4fd78d6e9a4f4aa0d46929df24c3cd', '984c39480d9f42e8a03869305611ff40', 'fec109c7a05443d68072b39a3affdd99');
INSERT INTO `sys_privilege_role_relation` VALUES ('9fb122fb73e44e04b04da0f30fb5136b', '6cd93866cb2c49f69c62af4f90d3ab6f', 'b6b7825ed8d843d4b1fa1f61a7bbfda5');
INSERT INTO `sys_privilege_role_relation` VALUES ('9ff33913d45f41de98264ccf10ce9fbd', '6cd93866cb2c49f69c62af4f90d3ab6f', 'ab229cadc3c6428d8c274048a4849e6f');
INSERT INTO `sys_privilege_role_relation` VALUES ('a0bd51863d2a422c9cf74a1ac9afccbd', 'bee006a8193a4e2bb0d4d70236037d29', '92c0f81d18de47b29e9d7afbc3d542c8');
INSERT INTO `sys_privilege_role_relation` VALUES ('a101cd8242f04fbf96e47cf0723e93b8', 'ffc94b71ed8a4e9ab6937ad73d3b9380', 'e8ba7ebd1cb64d0ead5189f41841c766');
INSERT INTO `sys_privilege_role_relation` VALUES ('a12ca40555a4406092046115cb2d942c', 'bee006a8193a4e2bb0d4d70236037d29', 'e6bbed3b41c94113ac0330f6c0eb604f');
INSERT INTO `sys_privilege_role_relation` VALUES ('a18df2b4dc714941943583bc55919c16', '984c39480d9f42e8a03869305611ff40', 'db3ba29743b44a4a8035e4aa8eb76499');
INSERT INTO `sys_privilege_role_relation` VALUES ('a1e828219fe6494ebc7e11d80b6e72e5', '984c39480d9f42e8a03869305611ff40', 'f01eda1c34ae4381b3b2d618e9b11e17');
INSERT INTO `sys_privilege_role_relation` VALUES ('a23b07ca85e4422c80a95c6a4237b31d', 'bee006a8193a4e2bb0d4d70236037d29', 'de49fdb25dcb4d329ce1f026624c0dc8');
INSERT INTO `sys_privilege_role_relation` VALUES ('a2ef13b94c46439eb34df92aafa12e2c', 'bee006a8193a4e2bb0d4d70236037d29', '879bef28004742efa9771643bd04e179');
INSERT INTO `sys_privilege_role_relation` VALUES ('a343e5c6647847e9b2e58f563d44e4eb', '6cd93866cb2c49f69c62af4f90d3ab6f', 'db3ba29743b44a4a8035e4aa8eb76499');
INSERT INTO `sys_privilege_role_relation` VALUES ('a53ecd5dc59e4011afe97dc46f8f3c45', '984c39480d9f42e8a03869305611ff40', '2f4375eda44b4fa1a28432c25c85181c');
INSERT INTO `sys_privilege_role_relation` VALUES ('a58c536923d14985825f07f2888f5499', '624fa127491842ebb22065fb6c3f9959', 'd201231880d44802a2eb2fcd64941709');
INSERT INTO `sys_privilege_role_relation` VALUES ('a9992944a3cb458cb6653d83c7489265', 'ffc94b71ed8a4e9ab6937ad73d3b9380', 'e35858c69b504c3c80fbbc544dbbece1');
INSERT INTO `sys_privilege_role_relation` VALUES ('aa39728a472440ffb0871997317b5bde', 'bee006a8193a4e2bb0d4d70236037d29', '9938f86ceee94b6c8ee4c259d2280d70');
INSERT INTO `sys_privilege_role_relation` VALUES ('aa8204a9b6224c6f9227b38a6a68d925', 'bee006a8193a4e2bb0d4d70236037d29', 'f10dabe50eef4a7a88e48e4502a8875a');
INSERT INTO `sys_privilege_role_relation` VALUES ('ad441d0c319245d591c4b343a920854e', '624fa127491842ebb22065fb6c3f9959', 'da99d579ef8d483e96f278892aaef773');
INSERT INTO `sys_privilege_role_relation` VALUES ('ae6552d761db47dca01edab1aadfdff0', 'bee006a8193a4e2bb0d4d70236037d29', '6e1cf3ee694b49b6bf4500847f59a37b');
INSERT INTO `sys_privilege_role_relation` VALUES ('aec2103e93814ea39cb924aeaaa234b8', 'bee006a8193a4e2bb0d4d70236037d29', '5b99250ad2264864a19454d9122ad800');
INSERT INTO `sys_privilege_role_relation` VALUES ('b0116b2bfb7a4092a33b79f235eced70', '624fa127491842ebb22065fb6c3f9959', '46d3556da48e47118c40ede7d9ff6266');
INSERT INTO `sys_privilege_role_relation` VALUES ('b10ab741f9a14439a86162681921c46d', 'bee006a8193a4e2bb0d4d70236037d29', '247c064e4b22418e8d704318bb5df544');
INSERT INTO `sys_privilege_role_relation` VALUES ('b3418b352c4242ffa483a3da7fe7dd47', 'bee006a8193a4e2bb0d4d70236037d29', '5cf007f657f34ce29e3ef1712a1ec68a');
INSERT INTO `sys_privilege_role_relation` VALUES ('b463da104ec84be0a90c2d33939d475b', '6cd93866cb2c49f69c62af4f90d3ab6f', 'a6bc77ce38144363bc32a4ac5633ef1b');
INSERT INTO `sys_privilege_role_relation` VALUES ('b4966e656ad14e418641aa2f57091f91', 'bee006a8193a4e2bb0d4d70236037d29', '51f0f76882f94e9ead77d798c6071f9e');
INSERT INTO `sys_privilege_role_relation` VALUES ('b52984214feb427bba5df3e49168ce8b', '624fa127491842ebb22065fb6c3f9959', '7fe4053cae044d1598b45163d9a2944e');
INSERT INTO `sys_privilege_role_relation` VALUES ('b5e96edec04b420cb85077dadbe078b6', 'bee006a8193a4e2bb0d4d70236037d29', '067018eae70b48c38db0799bc1bd66c4');
INSERT INTO `sys_privilege_role_relation` VALUES ('b5f306c38abb49c28766e74c9a742c99', '6cd93866cb2c49f69c62af4f90d3ab6f', 'e4c0cd0f353649fabf639a9d0a327e66');
INSERT INTO `sys_privilege_role_relation` VALUES ('b705034371b64a2ebcbd373cc530118e', '624fa127491842ebb22065fb6c3f9959', '904da3b52f75413095427794768f12dc');
INSERT INTO `sys_privilege_role_relation` VALUES ('b754869be1e649e493315910515cfbc7', '624fa127491842ebb22065fb6c3f9959', 'b07ef2b9fcc74faeb1c7eaaab63e47a2');
INSERT INTO `sys_privilege_role_relation` VALUES ('b8a52886485d4b11a60c386a0bf28d89', '984c39480d9f42e8a03869305611ff40', 'aa78c12d60d743b19511ba5312752921');
INSERT INTO `sys_privilege_role_relation` VALUES ('ba8b6a8a3dd34be191541835e78532d2', 'bee006a8193a4e2bb0d4d70236037d29', 'e7873a28bd644878abdb6e0c7cce1d38');
INSERT INTO `sys_privilege_role_relation` VALUES ('bc64af7effde4fce97591b4d66733516', 'bee006a8193a4e2bb0d4d70236037d29', '488d3d12812044e9ac5497c0f7396c1b');
INSERT INTO `sys_privilege_role_relation` VALUES ('bddb6b7e300643a28803d0eac6cb49ea', 'ffc94b71ed8a4e9ab6937ad73d3b9380', '0a5dce2e58cc48888e19642309fb085e');
INSERT INTO `sys_privilege_role_relation` VALUES ('bdea58e578b2407f8bbefec916c003a4', 'bee006a8193a4e2bb0d4d70236037d29', '674e3cd7c37b4429a325a1cf4c462ed7');
INSERT INTO `sys_privilege_role_relation` VALUES ('be3a8b7ea8274d8494c327933e5a136e', 'bee006a8193a4e2bb0d4d70236037d29', '3c9dae2c105840d7ad637a0f36b0395f');
INSERT INTO `sys_privilege_role_relation` VALUES ('bfd066141c1043c5bc0db8626ce988d2', '984c39480d9f42e8a03869305611ff40', '531ca93856c74f17a4d50fb7729ae3cc');
INSERT INTO `sys_privilege_role_relation` VALUES ('c32cc7cea8694ea1833fce9d3fea604f', 'bee006a8193a4e2bb0d4d70236037d29', 'fc6256b87bdf4c40ac79c73ab14dca10');
INSERT INTO `sys_privilege_role_relation` VALUES ('c3cd871a59ad43d2987c3e846368c72f', '984c39480d9f42e8a03869305611ff40', 'de49fdb25dcb4d329ce1f026624c0dc8');
INSERT INTO `sys_privilege_role_relation` VALUES ('c40f32e613ae48839b956d4ce7f541f9', 'bee006a8193a4e2bb0d4d70236037d29', 'eccf127b99c948049b65d01dbdd65671');
INSERT INTO `sys_privilege_role_relation` VALUES ('c6997cb61df84e22818e427acb3970f7', 'bee006a8193a4e2bb0d4d70236037d29', 'a6f8008b30b7481da3d286d11677f25e');
INSERT INTO `sys_privilege_role_relation` VALUES ('c69d8d049434451c943829206cbc615d', 'bee006a8193a4e2bb0d4d70236037d29', '0e75c8aefe5240229c6cc1c778baa801');
INSERT INTO `sys_privilege_role_relation` VALUES ('c7891bc25fa04f64a434d923866369de', '984c39480d9f42e8a03869305611ff40', 'fa337b5198d5422eb9532df68607865a');
INSERT INTO `sys_privilege_role_relation` VALUES ('c98cd7cbf99242d5a6a7d01becc9f19b', 'ffc94b71ed8a4e9ab6937ad73d3b9380', '128c61e8435747be96fdce3a36c6695b');
INSERT INTO `sys_privilege_role_relation` VALUES ('ca7a079eabd343c4814ea963e67af28c', 'bee006a8193a4e2bb0d4d70236037d29', 'e35858c69b504c3c80fbbc544dbbece1');
INSERT INTO `sys_privilege_role_relation` VALUES ('cbcae7a199d44b2792d4d207cfb212da', 'bee006a8193a4e2bb0d4d70236037d29', 'bdc5834a11914f7aac177303e453bb50');
INSERT INTO `sys_privilege_role_relation` VALUES ('cbdf6560fb6f4141a61e36fa4b747866', '6cd93866cb2c49f69c62af4f90d3ab6f', 'c92d505d53fa47dfb8d5b3d8c8577cba');
INSERT INTO `sys_privilege_role_relation` VALUES ('cc900c3c534848d298b3d4bfdb8b2f6a', '624fa127491842ebb22065fb6c3f9959', 'c16ee70e03854d879745408768dbafbd');
INSERT INTO `sys_privilege_role_relation` VALUES ('cd48a262ccdd4e0b8b2cb166035cb4cd', 'bee006a8193a4e2bb0d4d70236037d29', 'de2cb3a91d324d0388f46fe80554331b');
INSERT INTO `sys_privilege_role_relation` VALUES ('ce8bf6d485d548adb616cc92102b415e', 'bee006a8193a4e2bb0d4d70236037d29', '4530b44bf3e44371836ec41e0faf025d');
INSERT INTO `sys_privilege_role_relation` VALUES ('ced11abf07b24e60b84ca29aae9fa8e2', 'bee006a8193a4e2bb0d4d70236037d29', '93cbfce957b34ec28d529284c7d466ab');
INSERT INTO `sys_privilege_role_relation` VALUES ('d0dd0546e75248a3959ea2ca16bc6d3b', '6cd93866cb2c49f69c62af4f90d3ab6f', 'fc6256b87bdf4c40ac79c73ab14dca10');
INSERT INTO `sys_privilege_role_relation` VALUES ('d0ecc3706ca94ada95b4b7cf193c7d08', 'ffc94b71ed8a4e9ab6937ad73d3b9380', 'fca63f27dcbd4a2db2a819f47a54e755');
INSERT INTO `sys_privilege_role_relation` VALUES ('d1cf805a2dbd47419a264e89e4d55345', 'bee006a8193a4e2bb0d4d70236037d29', 'db3ba29743b44a4a8035e4aa8eb76499');
INSERT INTO `sys_privilege_role_relation` VALUES ('d202be70d87148d399882d8fbcafc341', '624fa127491842ebb22065fb6c3f9959', '2e546273894f4e76adf3633e62afc0ef');
INSERT INTO `sys_privilege_role_relation` VALUES ('d33fcac95bb44b2b9f3c4efe2a0fedc9', 'bee006a8193a4e2bb0d4d70236037d29', 'c681ba3ffe3141bcbf3a6880c604b08d');
INSERT INTO `sys_privilege_role_relation` VALUES ('d368b1325b814422b641b286b04b1b70', 'bee006a8193a4e2bb0d4d70236037d29', 'e5ab5f8664e942b2b52647a976f9824c');
INSERT INTO `sys_privilege_role_relation` VALUES ('d48bebae8986464f8433e1bc411d82a6', '624fa127491842ebb22065fb6c3f9959', 'c6062eef7e4a439d9b24fbc54890951b');
INSERT INTO `sys_privilege_role_relation` VALUES ('d51383dfda2945a194e026a390e6694c', '624fa127491842ebb22065fb6c3f9959', 'dd1eede4bea846339e16632963735fb8');
INSERT INTO `sys_privilege_role_relation` VALUES ('d6a1bf0477804fbdb85029c6a06b1bad', 'bee006a8193a4e2bb0d4d70236037d29', '144de5d775964e37b5f0eb9128574c90');
INSERT INTO `sys_privilege_role_relation` VALUES ('d8bcddb0c62d42ebb4a879c650d39162', 'bee006a8193a4e2bb0d4d70236037d29', 'f3f0d3e4a5af4ab2b6766f9b22a6055d');
INSERT INTO `sys_privilege_role_relation` VALUES ('d8d1da98abdd4524827dbe14359967c7', 'bee006a8193a4e2bb0d4d70236037d29', 'dd1eede4bea846339e16632963735fb8');
INSERT INTO `sys_privilege_role_relation` VALUES ('d9011cc78579491d98188c0292f210e0', 'ffc94b71ed8a4e9ab6937ad73d3b9380', '2884927fcc9041c3a41a516eadaf0784');
INSERT INTO `sys_privilege_role_relation` VALUES ('d936d4b320d0411690523d60d9bb69f7', '624fa127491842ebb22065fb6c3f9959', 'de2cb3a91d324d0388f46fe80554331b');
INSERT INTO `sys_privilege_role_relation` VALUES ('d9fa8170b891427e92d15049c253c389', '624fa127491842ebb22065fb6c3f9959', '24db2a14f1034de18a43b254c53d8f75');
INSERT INTO `sys_privilege_role_relation` VALUES ('dba05e8cf2414aa09d8917d84e648fe1', '6cd93866cb2c49f69c62af4f90d3ab6f', 'c6062eef7e4a439d9b24fbc54890951b');
INSERT INTO `sys_privilege_role_relation` VALUES ('dbf02539f3c045f2be3d8ed45414082a', 'bee006a8193a4e2bb0d4d70236037d29', '7174cfd19c544e7abbba242549b3d79d');
INSERT INTO `sys_privilege_role_relation` VALUES ('dd0e41752bcd40948c531e7c8e7935c0', '984c39480d9f42e8a03869305611ff40', '144de5d775964e37b5f0eb9128574c90');
INSERT INTO `sys_privilege_role_relation` VALUES ('dd9fb768aadf441aadada0df64fd9fb7', '6cd93866cb2c49f69c62af4f90d3ab6f', '144de5d775964e37b5f0eb9128574c90');
INSERT INTO `sys_privilege_role_relation` VALUES ('ddb77a0a880c489b94ebd7ab59a832f7', 'bee006a8193a4e2bb0d4d70236037d29', '19ba3f6246564a80b4125370c267b559');
INSERT INTO `sys_privilege_role_relation` VALUES ('ddcafbce000345fca93e3dd3f4345f0a', '624fa127491842ebb22065fb6c3f9959', '1d0a125e75764a1fa1a404f8b74d9b3f');
INSERT INTO `sys_privilege_role_relation` VALUES ('ddec0e0213e44d16b75649677ca12eb4', 'bee006a8193a4e2bb0d4d70236037d29', '8a73442783a54b43b7581e3d5c6904f6');
INSERT INTO `sys_privilege_role_relation` VALUES ('dfb7b9735cf1487f92ae227d04b0ee08', 'bee006a8193a4e2bb0d4d70236037d29', 'ab229cadc3c6428d8c274048a4849e6f');
INSERT INTO `sys_privilege_role_relation` VALUES ('e0220d1e4944432c8221b6e2502ef970', 'ffc94b71ed8a4e9ab6937ad73d3b9380', 'a3ac49b05c4447149253d8fc4007da8c');
INSERT INTO `sys_privilege_role_relation` VALUES ('e14735a928384ee9ac0a3131b3344c09', '624fa127491842ebb22065fb6c3f9959', '160f7d545e9e49119baff46349f60438');
INSERT INTO `sys_privilege_role_relation` VALUES ('e4483cdfd31d485296cc91c98118659f', '6cd93866cb2c49f69c62af4f90d3ab6f', 'de49fdb25dcb4d329ce1f026624c0dc8');
INSERT INTO `sys_privilege_role_relation` VALUES ('e4a3d85a95114ad59f1af80668b9b4a0', 'bee006a8193a4e2bb0d4d70236037d29', '531ca93856c74f17a4d50fb7729ae3cc');
INSERT INTO `sys_privilege_role_relation` VALUES ('e4c70b69ec3a45df8761058f47ed2895', 'bee006a8193a4e2bb0d4d70236037d29', '102235ed37e541c6b9364844d7cb2bd2');
INSERT INTO `sys_privilege_role_relation` VALUES ('e65adac7751e4eb589eea86559040f77', 'bee006a8193a4e2bb0d4d70236037d29', '0a5dce2e58cc48888e19642309fb085e');
INSERT INTO `sys_privilege_role_relation` VALUES ('e6647b1ceda44974b47c282f6d550b77', 'bee006a8193a4e2bb0d4d70236037d29', 'c7e5fa72e23145f3b5a72780e2040bf2');
INSERT INTO `sys_privilege_role_relation` VALUES ('e74e6564ab3d4aa881e8b85136853a74', '624fa127491842ebb22065fb6c3f9959', '760f385e794f46959348434cee792294');
INSERT INTO `sys_privilege_role_relation` VALUES ('e90df89ec4414b47a0f6d21d77b06397', 'bee006a8193a4e2bb0d4d70236037d29', '904da3b52f75413095427794768f12dc');
INSERT INTO `sys_privilege_role_relation` VALUES ('ea4750d78a474272b1683b9610bf3aa0', 'bee006a8193a4e2bb0d4d70236037d29', '4acd08940b65421aadb13f70d8963d26');
INSERT INTO `sys_privilege_role_relation` VALUES ('eb3a3cbb62ef4384b6ceb20d33d981c6', 'bee006a8193a4e2bb0d4d70236037d29', 'c4e20be4399244c99f3b56d6d7f3122b');
INSERT INTO `sys_privilege_role_relation` VALUES ('eb3d4a7ad84647cc9800bde497bfba76', 'bee006a8193a4e2bb0d4d70236037d29', '3dfcb76e812245759161e9d9c1b9d338');
INSERT INTO `sys_privilege_role_relation` VALUES ('ec5a8fa48edb4be6ae367e49842c45c8', '984c39480d9f42e8a03869305611ff40', 'c92d505d53fa47dfb8d5b3d8c8577cba');
INSERT INTO `sys_privilege_role_relation` VALUES ('ec7ecdb8398f48bfa789397c85e2f47f', '984c39480d9f42e8a03869305611ff40', '22879786cf5e419d96b461d183924ec5');
INSERT INTO `sys_privilege_role_relation` VALUES ('ed007f23b677458bb3074a7da430e315', 'bee006a8193a4e2bb0d4d70236037d29', '46d3556da48e47118c40ede7d9ff6266');
INSERT INTO `sys_privilege_role_relation` VALUES ('ed115aeeeb544ad8a0ade9bff1bbd2b5', '6cd93866cb2c49f69c62af4f90d3ab6f', 'bb0cd0133c6d46afa919d8d939a575f4');
INSERT INTO `sys_privilege_role_relation` VALUES ('ed58e5a5b7ee4bbca7182db78999f30f', 'bee006a8193a4e2bb0d4d70236037d29', 'c16ee70e03854d879745408768dbafbd');
INSERT INTO `sys_privilege_role_relation` VALUES ('ed5b88c7540f4875a62337b3a2c77d13', '984c39480d9f42e8a03869305611ff40', '597d3680983643afa4f3ec44564143d8');
INSERT INTO `sys_privilege_role_relation` VALUES ('ee038726ec2d499794f696985b230c74', 'ffc94b71ed8a4e9ab6937ad73d3b9380', '245ef10c85d142f4b6be94225c299a2e');
INSERT INTO `sys_privilege_role_relation` VALUES ('ee40c83cb0ce47c09c74345fc71a7d85', '984c39480d9f42e8a03869305611ff40', '25d47cda546841bf85666c51ee825500');
INSERT INTO `sys_privilege_role_relation` VALUES ('ee63b3b75c954b5ea4c4a72e351e0dc0', 'bee006a8193a4e2bb0d4d70236037d29', '64cfbb3dfff94397aab4960942d340e6');
INSERT INTO `sys_privilege_role_relation` VALUES ('f0de53d480ad42b6baf9b9fdd63c5662', '624fa127491842ebb22065fb6c3f9959', 'eccf127b99c948049b65d01dbdd65671');
INSERT INTO `sys_privilege_role_relation` VALUES ('f2e62e3bdac14ce68a61820c9d2ae92e', 'bee006a8193a4e2bb0d4d70236037d29', '25d47cda546841bf85666c51ee825500');
INSERT INTO `sys_privilege_role_relation` VALUES ('f4f944a6d0c04e0db799ec843d39a9fc', '984c39480d9f42e8a03869305611ff40', '3dfcb76e812245759161e9d9c1b9d338');
INSERT INTO `sys_privilege_role_relation` VALUES ('f5556740177b466da567333840571146', 'bee006a8193a4e2bb0d4d70236037d29', 'bd89c0246e8c4f8195d1c5047006e533');
INSERT INTO `sys_privilege_role_relation` VALUES ('f91b566647cf4b22b69f81026cd9e017', '6cd93866cb2c49f69c62af4f90d3ab6f', '977b81cb8bd745cb915f5750b0ccb802');
INSERT INTO `sys_privilege_role_relation` VALUES ('fa567eb26d474dc985961a47b22f1a84', '624fa127491842ebb22065fb6c3f9959', '55c23831cedc441d927fb19e347ed91d');
INSERT INTO `sys_privilege_role_relation` VALUES ('fccb43171bd645b696655e03794a434f', '624fa127491842ebb22065fb6c3f9959', 'dc2f20c40f72483da7f3932b28acae62');
INSERT INTO `sys_privilege_role_relation` VALUES ('fd32b1f13c234fb680849b735af59823', '984c39480d9f42e8a03869305611ff40', 'b152b5e973314d5eb25ccb78eb9997c7');
INSERT INTO `sys_privilege_role_relation` VALUES ('fed87234ead742d1a9e927a3701e3ec3', '624fa127491842ebb22065fb6c3f9959', 'bdc5834a11914f7aac177303e453bb50');
INSERT INTO `sys_privilege_role_relation` VALUES ('ffc0dd2b014f40f6a96cf2b41c036b1c', 'bee006a8193a4e2bb0d4d70236037d29', '977b81cb8bd745cb915f5750b0ccb802');

-- ----------------------------
-- Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` varchar(32) NOT NULL,
  `role_name` varchar(50) DEFAULT NULL COMMENT '权限角色的名字',
  `create_time` varchar(17) DEFAULT NULL COMMENT '创建日期\n            格式：yyyyMMddHHmmssSSS',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('624fa127491842ebb22065fb6c3f9959', '技术支持', '20150518171448844');
INSERT INTO `sys_role` VALUES ('6cd93866cb2c49f69c62af4f90d3ab6f', '财务', '20150819095521654');
INSERT INTO `sys_role` VALUES ('984c39480d9f42e8a03869305611ff40', '代理商', '20150928152528842');
INSERT INTO `sys_role` VALUES ('bee006a8193a4e2bb0d4d70236037d29', '运营商', '20141006154309679');
INSERT INTO `sys_role` VALUES ('ffc94b71ed8a4e9ab6937ad73d3b9380', '客服', '20150728163558465');

-- ----------------------------
-- Table structure for `sys_role_group_relation`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_group_relation`;
CREATE TABLE `sys_role_group_relation` (
  `id` varchar(32) NOT NULL,
  `role_id` varchar(32) DEFAULT NULL,
  `group_id` varchar(32) DEFAULT NULL COMMENT '权限组id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_group_relation
-- ----------------------------
INSERT INTO `sys_role_group_relation` VALUES ('40e1418ce1ab4895beb1c4f4caf14315', 'e8734b02b748473086ffb046f7e79266', 'c41c5e95d67a462b8609b57a5a73c6ef');
INSERT INTO `sys_role_group_relation` VALUES ('71aca9a7fc8d404cafac9fcd27ba7f91', '2729e0d8a5cf4936bcaff26dd5169b19', '9ff89bffe6314e2cb3d262484a30fd32');
INSERT INTO `sys_role_group_relation` VALUES ('74775adc4efb40da891ee2ff1ca54f74', 'ad091278c69040fd89e91aa4f3b26aa8', '665c83b29a904694a99e572f8861cf4a');
INSERT INTO `sys_role_group_relation` VALUES ('7b39eb38dee24030b2b90a29e7253319', 'bee006a8193a4e2bb0d4d70236037d29', '1946f9eb93a2421f9a0359a4a630c530');
INSERT INTO `sys_role_group_relation` VALUES ('828679808e0e4d2aa18b17e9b00746af', 'ad091278c69040fd89e91aa4f3b26aa8', '048b6a8cc5b24a6e9e62adf7df0c3e65');
INSERT INTO `sys_role_group_relation` VALUES ('8398abc50a874cef90a002400d2f3f26', '624fa127491842ebb22065fb6c3f9959', '9caac96d9fd34e1bb269d48696c2a93a');
INSERT INTO `sys_role_group_relation` VALUES ('8ddc4ebfff2e4ca5917b66ad1d989a12', 'af015823a6074faa97023f1cf5e7c7cc', '6b089ff3e3494f0d84b89b36c7116834');
INSERT INTO `sys_role_group_relation` VALUES ('9342d8c3b4914afaa0c39550fd54c2eb', 'b63aa4637ebc4d1799dcffcdfd36c608', 'a6e0a93315854be2a386be3278850a52');
INSERT INTO `sys_role_group_relation` VALUES ('a2d05dd3a8fa419ba928b075db8fa7ad', '6cd93866cb2c49f69c62af4f90d3ab6f', '0929a4e3a7cb4cb69688b8968cc1ed92');
INSERT INTO `sys_role_group_relation` VALUES ('d4ae54ce3ba84112b27fb2f38d379633', 'ffc94b71ed8a4e9ab6937ad73d3b9380', 'fce54f249d984d3ebdf28b71d2586551');
INSERT INTO `sys_role_group_relation` VALUES ('e2828a2498cf4522bb0ffc4db3e72bdd', '15e9d1f0672c42bcbb85d0d756afcf08', '9578554bdc0246f9909996fdb64b2368');
INSERT INTO `sys_role_group_relation` VALUES ('f0e62473329b409f96b75553f8619c26', '984c39480d9f42e8a03869305611ff40', '4f2b4daa3ce54048b41922a868963965');
INSERT INTO `sys_role_group_relation` VALUES ('fdfd1b0127144cc595cfaeafd79fd65d', '6a8a8dcf70f648e3836bc7c222eb2a86', '0efd27e09962486093bab07354b978c5');

-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` varchar(32) NOT NULL,
  `type` int(11) DEFAULT NULL COMMENT '系统用户类型：\n            1：超级管理员\n            2：运营商\n            3：代理商\n            4：终端用户',
  `account` varchar(100) DEFAULT NULL COMMENT '账号，用于登录系统',
  `password` varchar(40) DEFAULT NULL COMMENT 'sha1加密',
  `group_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sys_user_1` (`type`,`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('admin', '1', 'admin', '55E90D81B259ABC21C393BA9CB226A26971BF24C', 'admin');

-- ----------------------------
-- Table structure for `sys_user_image_relation`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_image_relation`;
CREATE TABLE `sys_user_image_relation` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `sys_image_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_image_relation
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
INSERT INTO `sys_warnrule` VALUES ('3d8d24d0e9bc4ad9a73c0e5882950639', 'web监控告警规则', 'monitor_rule_warn', null, '0', '0', '60', '3', '2', null, '15928003743', 'support@zhicloud.com', 'fed6c5aeaf5a4e5da21abcc3b250e75e', '2015-07-15 15:55:37');
INSERT INTO `sys_warnrule` VALUES ('448df06dd0494bc9a779273c026ea5b2', 'web监控故障规则', 'monitor_rule_error', null, '1', '0', '10', '3', '2', null, '15928003743', 'support@zhicloud.com', 'fed6c5aeaf5a4e5da21abcc3b250e75e', '2015-07-16 14:51:45');

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
INSERT INTO `sys_warnvalue` VALUES ('85309f8d12ee4f83b95d3d3872789548', 'CPU利用率', 'cpu_usage', 'between', '0.65-0.8', 'or', '1', '3d8d24d0e9bc4ad9a73c0e5882950639');
INSERT INTO `sys_warnvalue` VALUES ('3f0b4e0d4d014007a12b8179d74e3594', '内存利用率', 'memory_usage', 'between', '0.7-0.8', 'or', '2', '3d8d24d0e9bc4ad9a73c0e5882950639');
INSERT INTO `sys_warnvalue` VALUES ('1ac07771bd344a84aa95b879becbfebe', '内存利用率', 'memory_usage', 'high', '0.8', 'or', '2', '448df06dd0494bc9a779273c026ea5b2');
INSERT INTO `sys_warnvalue` VALUES ('6f8d1d325a99488899df505c9a21b68f', 'CPU利用率', 'cpu_usage', 'high', '0.8', 'or', '1', '448df06dd0494bc9a779273c026ea5b2');

-- ----------------------------
-- Table structure for `terminal_user`
-- ----------------------------
DROP TABLE IF EXISTS `terminal_user`;
CREATE TABLE `terminal_user` (
  `id` varchar(32) NOT NULL COMMENT '在系统用户表须有一条id一样的记录',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `id_card` varchar(20) DEFAULT NULL COMMENT '身份证',
  `email` varchar(100) DEFAULT NULL,
  `email_verified` int(11) DEFAULT NULL COMMENT '邮件是否验证：\n            1：否\n            2：是',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话号码',
  `phone_verified` int(11) DEFAULT NULL COMMENT '手机是否验证：\n            1：否\n            2：是',
  `status` int(11) DEFAULT NULL COMMENT '状态:\n            1:未验证\n            2：正常\n            3：禁用\n            4:欠费\n            5：结束',
  `belonging_type` int(11) DEFAULT NULL COMMENT '帐号归属\n            1：运营商\n            2：代理商',
  `belonging_id` varchar(32) DEFAULT NULL COMMENT '如果归属于运营商，填代开户的运营商管理员的id。\n            如果归属于代理商，填代开户的代理商管理员的id。\n            如果是用户自己注册开户，填空\n            ',
  `account_balance` decimal(20,2) DEFAULT NULL COMMENT '账户余额',
  `balance_update_time` varchar(17) DEFAULT NULL COMMENT '余额变动的时间',
  `create_time` varchar(17) DEFAULT NULL,
  `percent_off` decimal(5,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of terminal_user
-- ----------------------------

-- ----------------------------
-- Table structure for `trial_period_param`
-- ----------------------------
DROP TABLE IF EXISTS `trial_period_param`;
CREATE TABLE `trial_period_param` (
  `id` varchar(32) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '类型：\n            1：云主机试用天数\n            2：云存储调用期',
  `day` int(11) DEFAULT NULL COMMENT '试用的天数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of trial_period_param
-- ----------------------------
INSERT INTO `trial_period_param` VALUES ('ce715689c049410b98e41aebf23e3491', '1', '1');
INSERT INTO `trial_period_param` VALUES ('d3f9ec552af54d3da551473a54e1ee8f', '2', '1');

-- ----------------------------
-- Table structure for `user_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `user_dictionary`;
CREATE TABLE `user_dictionary` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `dictionary_key` varchar(50) DEFAULT NULL COMMENT '字典：\n\n                   is_first_access_host_list：创建主机之后是否首次进入主机列表，value=true表示是，value=false表示否',
  `dictionary_value` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_dictionary
-- ----------------------------

-- ----------------------------
-- Table structure for `user_message`
-- ----------------------------
DROP TABLE IF EXISTS `user_message`;
CREATE TABLE `user_message` (
  `id` varchar(32) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `content` varchar(100) DEFAULT NULL,
  `create_time` varchar(17) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_message
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
  `region` int(11) DEFAULT NULL COMMENT '地域 1. 广州 2：成都 3：北京 4：香港',
  `monthly_price` decimal(10,2) DEFAULT NULL COMMENT '每月资费',
  `host_amount` int(11) DEFAULT '0' COMMENT '绑定云主机个数',
  `ip_amount` int(11) DEFAULT '0' COMMENT '绑定IP个数',
  `create_time` char(17) DEFAULT NULL COMMENT '创建时间',
  `modified_time` char(17) DEFAULT NULL COMMENT '修改时间',
  `type` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='VPC基本信息';

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
  `flag` int(1) DEFAULT '1',
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
-- Table structure for `vpc_price`
-- ----------------------------
DROP TABLE IF EXISTS `vpc_price`;
CREATE TABLE `vpc_price` (
  `id` varchar(32) NOT NULL,
  `vpc_amount` int(11) DEFAULT NULL,
  `price` decimal(20,2) DEFAULT NULL,
  `region` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vpc_price
-- ----------------------------
INSERT INTO `vpc_price` VALUES ('e2f4764e4549418b8e0bcb9cb0c9810a', '1', '220.00', '4');
INSERT INTO `vpc_price` VALUES ('baf74f17d4404fc491ab855458b7a6c1', '2', '240.00', '1');
INSERT INTO `vpc_price` VALUES ('e24a6d580c784866b07ee6d322eb29ea', '2', '240.00', '4');
INSERT INTO `vpc_price` VALUES ('124887b75db64937be47463407c5432f', '3', '260.00', '4');
INSERT INTO `vpc_price` VALUES ('e9c88ed565f642bd86c947817091a6a4', '5', '300.00', '4');
INSERT INTO `vpc_price` VALUES ('130247cf7740470e9e059bb8e189b399', '6', '320.00', '4');
INSERT INTO `vpc_price` VALUES ('7fd0e968b38d4e6186d8a0acb74a555c', '7', '340.00', '4');
INSERT INTO `vpc_price` VALUES ('a10471ae4ce8497e9a9742694a3aac49', '1', '220.00', '2');
INSERT INTO `vpc_price` VALUES ('1c38269a251d4d039574ff3715be16bd', '3', '260.00', '1');
INSERT INTO `vpc_price` VALUES ('574164c67e6f499da2d3a7049896d055', '4', '280.00', '1');
INSERT INTO `vpc_price` VALUES ('ad1a37735cb74ff3bc4fb7e473e73836', '5', '300.00', '1');
INSERT INTO `vpc_price` VALUES ('f5ef5e48e01a4ae6bb475e04cafff364', '6', '320.00', '1');
INSERT INTO `vpc_price` VALUES ('b6f6c45b44154a4183ff92d5df33b5bf', '7', '340.00', '1');
INSERT INTO `vpc_price` VALUES ('eb5872cb12f741c0b668a2d295aacc5b', '8', '360.00', '1');
INSERT INTO `vpc_price` VALUES ('ab6d83b8acf64b4b96c033e6adfc2165', '9', '380.00', '1');
INSERT INTO `vpc_price` VALUES ('55c8e8ac3f9f4b1aa7b9a5d074d4135a', '10', '400.00', '1');
INSERT INTO `vpc_price` VALUES ('a75768c176cb499281d6de2340afc5b9', '1', '220.00', '1');
INSERT INTO `vpc_price` VALUES ('45e3f3531bb14d55aaf0d411dec66649', '4', '280.00', '4');
INSERT INTO `vpc_price` VALUES ('0eb36ce46c6c401cb4093f61be2df0c8', '11', '420.00', '1');
INSERT INTO `vpc_price` VALUES ('6102698558bb48ef9fd0c5bf2f225cc2', '12', '440.00', '1');
INSERT INTO `vpc_price` VALUES ('b625e1ca19a94ebfb2a7c640fc890521', '13', '460.00', '1');
INSERT INTO `vpc_price` VALUES ('d5265f6b57ec4597948728d31400846d', '14', '480.00', '1');
INSERT INTO `vpc_price` VALUES ('d509c138a252472fb92ebf490a5eef56', '15', '500.00', '1');
INSERT INTO `vpc_price` VALUES ('ac34a1707bed4fc39b7698395dd7ce2c', '8', '360.00', '4');
INSERT INTO `vpc_price` VALUES ('0f7788bd9ef64e0bb877779f85b731cb', '9', '380.00', '4');
INSERT INTO `vpc_price` VALUES ('ce283b7a166f45bd8e32577c8db0e2d9', '10', '400.00', '4');
INSERT INTO `vpc_price` VALUES ('e2d11ea3a45e4ba7b6a89ffb62ecb936', '11', '420.00', '4');
INSERT INTO `vpc_price` VALUES ('af5d90b9428a4a94867da5ad72044a4a', '12', '440.00', '4');
INSERT INTO `vpc_price` VALUES ('5a0a4541314d4fb7b0c816cd8c85657a', '13', '460.00', '4');
INSERT INTO `vpc_price` VALUES ('0e2eea65d7464e23a01786ecadaa2180', '14', '480.00', '4');
INSERT INTO `vpc_price` VALUES ('599e11d2d8544a4ebd608a72ea1aa78a', '15', '500.00', '4');
INSERT INTO `vpc_price` VALUES ('835efa1218004524a513e31774043eb2', '2', '240.00', '2');
INSERT INTO `vpc_price` VALUES ('39e1d3f600a14f1b82fbb2449bbe3804', '3', '260.00', '2');
INSERT INTO `vpc_price` VALUES ('ab728be47d564a5dbee6b47c449a8c54', '4', '280.00', '2');
INSERT INTO `vpc_price` VALUES ('4c7acdfa104142c28bc75aef91c3d91b', '5', '300.00', '2');
INSERT INTO `vpc_price` VALUES ('4a6859a63c934f3d9aee25d3f59ecc6a', '6', '320.00', '2');
INSERT INTO `vpc_price` VALUES ('7488dd1f861346e4b40305b5f2144e96', '7', '340.00', '2');
INSERT INTO `vpc_price` VALUES ('da7b4c126fd84e33922b414d19d8d0a5', '8', '360.00', '2');
INSERT INTO `vpc_price` VALUES ('c4a338758bcd4c6babb9d1595dd1a4a5', '9', '380.00', '2');
INSERT INTO `vpc_price` VALUES ('97bc97b445df438297fd38fcf06ea5ca', '10', '400.00', '2');
INSERT INTO `vpc_price` VALUES ('62e0b54fe3d348b9abecae7226e239ec', '11', '420.00', '2');
INSERT INTO `vpc_price` VALUES ('4c9b2eb0deb549af88e5f8f288df1b04', '12', '440.00', '2');
INSERT INTO `vpc_price` VALUES ('7ed19691e2b04effbac336b1c6e2ec7e', '13', '460.00', '2');
INSERT INTO `vpc_price` VALUES ('451907e1cb964d2593364bdf42cfda55', '14', '180.00', '2');
INSERT INTO `vpc_price` VALUES ('c840680317bc41e0b9c5c09fc5a6e586', '15', '500.00', '2');
