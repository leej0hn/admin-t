
/* Drop Indexes */

/*
DROP INDEX sys_area_parent_id;
DROP INDEX sys_area_parent_ids;
DROP INDEX sys_area_del_flag;
DROP INDEX sys_dict_value;
DROP INDEX sys_dict_label;
DROP INDEX sys_dict_del_flag;
DROP INDEX sys_log_create_by;
DROP INDEX sys_log_request_uri;
DROP INDEX sys_log_type;
DROP INDEX sys_log_create_date;
DROP INDEX sys_mdict_parent_id;
DROP INDEX sys_mdict_parent_ids;
DROP INDEX sys_mdict_del_flag;
DROP INDEX sys_menu_parent_id;
DROP INDEX sys_menu_parent_ids;
DROP INDEX sys_menu_del_flag;
DROP INDEX sys_office_parent_id;
DROP INDEX sys_office_parent_ids;
DROP INDEX sys_office_del_flag;
DROP INDEX sys_office_type;
DROP INDEX sys_role_del_flag;
DROP INDEX sys_role_enname;
DROP INDEX sys_user_office_id;
DROP INDEX sys_user_login_name;
DROP INDEX sys_user_company_id;
DROP INDEX sys_user_update_date;
DROP INDEX sys_user_del_flag;
*/


/* Drop Tables */

/*
DROP TABLE sys_user_role CASCADE CONSTRAINTS;
DROP TABLE sys_user CASCADE CONSTRAINTS;
DROP TABLE sys_role_office CASCADE CONSTRAINTS;
DROP TABLE sys_office CASCADE CONSTRAINTS;
DROP TABLE sys_area CASCADE CONSTRAINTS;
DROP TABLE sys_dict CASCADE CONSTRAINTS;
DROP TABLE sys_log CASCADE CONSTRAINTS;
DROP TABLE sys_mdict CASCADE CONSTRAINTS;
DROP TABLE sys_role_menu CASCADE CONSTRAINTS;
DROP TABLE sys_menu CASCADE CONSTRAINTS;
DROP TABLE sys_role CASCADE CONSTRAINTS;
*/



/* Create Tables */

-- 区域表
CREATE TABLE sys_area
(
	id varchar2(64) NOT NULL,
	parent_id varchar2(64) NOT NULL,
	parent_ids varchar2(2000) NOT NULL,
	name nvarchar2(100) NOT NULL,
	sort number(10,0) NOT NULL,
	code varchar2(100),
	type char(1),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);


-- 字典表
CREATE TABLE sys_dict
(
	id varchar2(64) NOT NULL,
	value varchar2(100) NOT NULL,
	label varchar2(100) NOT NULL,
	type varchar2(100) NOT NULL,
	description nvarchar2(100) NOT NULL,
	sort number(10,0) NOT NULL,
	parent_id varchar2(64) DEFAULT '0',
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);


-- 日志表
CREATE TABLE sys_log
(
	id varchar2(64) NOT NULL,
	type char(1) DEFAULT '1',
	title nvarchar2(500),
	create_by varchar2(64),
	create_date timestamp,
	remote_addr varchar2(255),
	user_agent varchar2(255),
	request_uri varchar2(255),
	method varchar2(5),
	params clob,
	exception clob,
	PRIMARY KEY (id)
);


-- 多级字典表
CREATE TABLE sys_mdict
(
	id varchar2(64) NOT NULL,
	parent_id varchar2(64) NOT NULL,
	parent_ids varchar2(2000) NOT NULL,
	name nvarchar2(100) NOT NULL,
	sort number(10,0) NOT NULL,
	description nvarchar2(100),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);


-- 菜单表
CREATE TABLE sys_menu
(
	id varchar2(64) NOT NULL,
	parent_id varchar2(64) NOT NULL,
	parent_ids varchar2(2000) NOT NULL,
	name nvarchar2(100) NOT NULL,
	sort number(10,0) NOT NULL,
	href varchar2(2000),
	target varchar2(20),
	icon varchar2(100),
	is_show char(1) NOT NULL,
	permission varchar2(200),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);


-- 机构表
CREATE TABLE sys_office
(
	id varchar2(64) NOT NULL,
	parent_id varchar2(64) NOT NULL,
	parent_ids varchar2(2000) NOT NULL,
	name nvarchar2(100) NOT NULL,
	sort number(10,0) NOT NULL,
	area_id varchar2(64) NOT NULL,
	code varchar2(100),
	type char(1) NOT NULL,
	grade char(1) NOT NULL,
	address nvarchar2(255),
	zip_code varchar2(100),
	master nvarchar2(100),
	phone nvarchar2(200),
	fax nvarchar2(200),
	email nvarchar2(200),
	USEABLE varchar2(64),
	PRIMARY_PERSON varchar2(64),
	DEPUTY_PERSON varchar2(64),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);


-- 角色表
CREATE TABLE sys_role
(
	id varchar2(64) NOT NULL,
	office_id varchar2(64),
	name nvarchar2(100) NOT NULL,
	enname varchar2(255),
	role_type varchar2(255),
	data_scope char(1),
	is_sys varchar2(64),
	useable varchar2(64),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);


-- 角色-菜单
CREATE TABLE sys_role_menu
(
	role_id varchar2(64) NOT NULL,
	menu_id varchar2(64) NOT NULL,
	PRIMARY KEY (role_id, menu_id)
);


-- 角色-机构
CREATE TABLE sys_role_office
(
	role_id varchar2(64) NOT NULL,
	office_id varchar2(64) NOT NULL,
	PRIMARY KEY (role_id, office_id)
);


-- 用户表
CREATE TABLE sys_user
(
	id varchar2(64) NOT NULL,
	company_id varchar2(64) NOT NULL,
	office_id varchar2(64) NOT NULL,
	login_name varchar2(100) NOT NULL,
	password varchar2(100) NOT NULL,
	no varchar2(100),
	name nvarchar2(100) NOT NULL,
	email nvarchar2(200),
	phone varchar2(200),
	mobile varchar2(200),
	user_type char(1),
	photo varchar2(1000),
	login_ip varchar2(100),
	login_date timestamp,
	login_flag varchar2(64),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);


-- 用户-角色
CREATE TABLE sys_user_role
(
	user_id varchar2(64) NOT NULL,
	role_id varchar2(64) NOT NULL,
	PRIMARY KEY (user_id, role_id)
);



/* Create Indexes */

CREATE INDEX sys_area_parent_id ON sys_area (parent_id);
CREATE INDEX sys_area_parent_ids ON sys_area (parent_ids);
CREATE INDEX sys_area_del_flag ON sys_area (del_flag);
CREATE INDEX sys_dict_value ON sys_dict (value);
CREATE INDEX sys_dict_label ON sys_dict (label);
CREATE INDEX sys_dict_del_flag ON sys_dict (del_flag);
CREATE INDEX sys_log_create_by ON sys_log (create_by);
CREATE INDEX sys_log_request_uri ON sys_log (request_uri);
CREATE INDEX sys_log_type ON sys_log (type);
CREATE INDEX sys_log_create_date ON sys_log (create_date);
CREATE INDEX sys_mdict_parent_id ON sys_mdict (parent_id);
CREATE INDEX sys_mdict_parent_ids ON sys_mdict (parent_ids);
CREATE INDEX sys_mdict_del_flag ON sys_mdict (del_flag);
CREATE INDEX sys_menu_parent_id ON sys_menu (parent_id);
CREATE INDEX sys_menu_parent_ids ON sys_menu (parent_ids);
CREATE INDEX sys_menu_del_flag ON sys_menu (del_flag);
CREATE INDEX sys_office_parent_id ON sys_office (parent_id);
CREATE INDEX sys_office_parent_ids ON sys_office (parent_ids);
CREATE INDEX sys_office_del_flag ON sys_office (del_flag);
CREATE INDEX sys_office_type ON sys_office (type);
CREATE INDEX sys_role_del_flag ON sys_role (del_flag);
CREATE INDEX sys_role_enname ON sys_role (enname);
CREATE INDEX sys_user_office_id ON sys_user (office_id);
CREATE INDEX sys_user_login_name ON sys_user (login_name);
CREATE INDEX sys_user_company_id ON sys_user (company_id);
CREATE INDEX sys_user_update_date ON sys_user (update_date);
CREATE INDEX sys_user_del_flag ON sys_user (del_flag);




-- ----------------------------
-- Records of sys_area
-- ----------------------------
INSERT INTO sys_area VALUES ('1', '0', '0,', '中国', '10', '100000', '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_area VALUES ('2', '1', '0,1,', '山东省', '20', '110000', '2', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_area VALUES ('3', '2', '0,1,2,', '济南市', '30', '110101', '3', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_area VALUES ('4', '3', '0,1,2,3,', '历城区', '40', '110102', '4', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_area VALUES ('5', '3', '0,1,2,3,', '历下区', '50', '110104', '4', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_area VALUES ('6', '3', '0,1,2,3,', '高新区', '60', '110105', '4', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');


-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO sys_dict VALUES ('1', '0', '正常', 'del_flag', '删除标记', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('10', 'yellow', '黄色', 'color', '颜色值', '40', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('100', 'java.util.Date', 'Date', 'gen_java_type', 'Java类型', '50', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('101', 'com.redscarf.admin.modules.sys.entity.User', 'User', 'gen_java_type', 'Java类型', '60', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('102', 'com.redscarf.admin.modules.sys.entity.Office', 'Office', 'gen_java_type', 'Java类型', '70', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('103', 'com.redscarf.admin.modules.sys.entity.Area', 'Area', 'gen_java_type', 'Java类型', '80', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('104', 'Custom', 'Custom', 'gen_java_type', 'Java类型', '90', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('105', '1', '会议通告', 'oa_notify_type', '通知通告类型', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('106', '2', '奖惩通告', 'oa_notify_type', '通知通告类型', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('107', '3', '活动通告', 'oa_notify_type', '通知通告类型', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('108', '0', '草稿', 'oa_notify_status', '通知通告状态', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('109', '1', '发布', 'oa_notify_status', '通知通告状态', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('11', 'orange', '橙色', 'color', '颜色值', '50', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('110', '0', '未读', 'oa_notify_read', '通知通告状态', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('111', '1', '已读', 'oa_notify_read', '通知通告状态', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('12', 'default', '默认主题', 'theme', '主题方案', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('13', 'cerulean', '天蓝主题', 'theme', '主题方案', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('14', 'readable', '橙色主题', 'theme', '主题方案', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('15', 'united', '红色主题', 'theme', '主题方案', '40', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('16', 'flat', 'Flat主题', 'theme', '主题方案', '60', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('17', '1', '国家', 'sys_area_type', '区域类型', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('18', '2', '省份、直辖市', 'sys_area_type', '区域类型', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('19', '3', '地市', 'sys_area_type', '区域类型', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('2', '1', '删除', 'del_flag', '删除标记', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('20', '4', '区县', 'sys_area_type', '区域类型', '40', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('21', '1', '公司', 'sys_office_type', '机构类型', '60', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('22', '2', '部门', 'sys_office_type', '机构类型', '70', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('23', '3', '小组', 'sys_office_type', '机构类型', '80', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('24', '4', '其它', 'sys_office_type', '机构类型', '90', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('25', '1', '综合部', 'sys_office_common', '快捷通用部门', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('26', '2', '开发部', 'sys_office_common', '快捷通用部门', '40', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('27', '3', '人力部', 'sys_office_common', '快捷通用部门', '50', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('28', '1', '一级', 'sys_office_grade', '机构等级', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('29', '2', '二级', 'sys_office_grade', '机构等级', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('3', '1', '显示', 'show_hide', '显示/隐藏', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('30', '3', '三级', 'sys_office_grade', '机构等级', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('31', '4', '四级', 'sys_office_grade', '机构等级', '40', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('32', '1', '所有数据', 'sys_data_scope', '数据范围', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('33', '2', '所在公司及以下数据', 'sys_data_scope', '数据范围', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('34', '3', '所在公司数据', 'sys_data_scope', '数据范围', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('35', '4', '所在部门及以下数据', 'sys_data_scope', '数据范围', '40', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('36', '5', '所在部门数据', 'sys_data_scope', '数据范围', '50', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('37', '8', '仅本人数据', 'sys_data_scope', '数据范围', '90', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('38', '9', '按明细设置', 'sys_data_scope', '数据范围', '100', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('39', '1', '系统管理', 'sys_user_type', '用户类型', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('4', '0', '隐藏', 'show_hide', '显示/隐藏', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('40', '2', '部门经理', 'sys_user_type', '用户类型', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('41', '3', '普通用户', 'sys_user_type', '用户类型', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('42', 'basic', '基础主题', 'cms_theme', '站点主题', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('43', 'blue', '蓝色主题', 'cms_theme', '站点主题', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('44', 'red', '红色主题', 'cms_theme', '站点主题', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('45', 'article', '文章模型', 'cms_module', '栏目模型', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('46', 'picture', '图片模型', 'cms_module', '栏目模型', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('47', 'download', '下载模型', 'cms_module', '栏目模型', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('48', 'link', '链接模型', 'cms_module', '栏目模型', '40', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('49', 'special', '专题模型', 'cms_module', '栏目模型', '50', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('5', '1', '是', 'yes_no', '是/否', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('50', '0', '默认展现方式', 'cms_show_modes', '展现方式', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('51', '1', '首栏目内容列表', 'cms_show_modes', '展现方式', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('52', '2', '栏目第一条内容', 'cms_show_modes', '展现方式', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('53', '0', '发布', 'cms_del_flag', '内容状态', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('54', '1', '删除', 'cms_del_flag', '内容状态', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('55', '2', '审核', 'cms_del_flag', '内容状态', '15', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('56', '1', '首页焦点图', 'cms_posid', '推荐位', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('57', '2', '栏目页文章推荐', 'cms_posid', '推荐位', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('58', '1', '咨询', 'cms_guestbook', '留言板分类', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('59', '2', '建议', 'cms_guestbook', '留言板分类', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('6', '0', '否', 'yes_no', '是/否', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('60', '3', '投诉', 'cms_guestbook', '留言板分类', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('61', '4', '其它', 'cms_guestbook', '留言板分类', '40', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('62', '1', '公休', 'oa_leave_type', '请假类型', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('63', '2', '病假', 'oa_leave_type', '请假类型', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('64', '3', '事假', 'oa_leave_type', '请假类型', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('65', '4', '调休', 'oa_leave_type', '请假类型', '40', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('66', '5', '婚假', 'oa_leave_type', '请假类型', '60', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('67', '1', '接入日志', 'sys_log_type', '日志类型', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('68', '2', '异常日志', 'sys_log_type', '日志类型', '40', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('69', 'leave', '请假流程', 'act_type', '流程类型', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('7', 'red', '红色', 'color', '颜色值', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('70', 'test_audit', '审批测试流程', 'act_type', '流程类型', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('71', '1', '分类1', 'act_category', '流程分类', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('72', '2', '分类2', 'act_category', '流程分类', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('73', 'crud', '增删改查', 'gen_category', '代码生成分类', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('74', 'crud_many', '增删改查（包含从表）', 'gen_category', '代码生成分类', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('75', 'tree', '树结构', 'gen_category', '代码生成分类', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('76', '=', '=', 'gen_query_type', '查询方式', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('77', '!=', '!=', 'gen_query_type', '查询方式', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('78', '&gt;', '&gt;', 'gen_query_type', '查询方式', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('79', '&lt;', '&lt;', 'gen_query_type', '查询方式', '40', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('7fa4e8e2647d4e95a6d40e9ea4393a5e', '3', '3', 'act_category', '流程分类', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '44', '0');
INSERT INTO sys_dict VALUES ('8', 'green', '绿色', 'color', '颜色值', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('80', 'between', 'Between', 'gen_query_type', '查询方式', '50', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('81', 'like', 'Like', 'gen_query_type', '查询方式', '60', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('82', 'left_like', 'Left Like', 'gen_query_type', '查询方式', '70', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('83', 'right_like', 'Right Like', 'gen_query_type', '查询方式', '80', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('84', 'input', '文本框', 'gen_show_type', '字段生成方案', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('85', 'textarea', '文本域', 'gen_show_type', '字段生成方案', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('86', 'select', '下拉框', 'gen_show_type', '字段生成方案', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('87', 'checkbox', '复选框', 'gen_show_type', '字段生成方案', '40', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('88', 'radiobox', '单选框', 'gen_show_type', '字段生成方案', '50', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('89', 'dateselect', '日期选择', 'gen_show_type', '字段生成方案', '60', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('9', 'blue', '蓝色', 'color', '颜色值', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('90', 'userselect', '人员选择', 'gen_show_type', '字段生成方案', '70', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('91', 'officeselect', '部门选择', 'gen_show_type', '字段生成方案', '80', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('92', 'areaselect', '区域选择', 'gen_show_type', '字段生成方案', '90', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('93', 'String', 'String', 'gen_java_type', 'Java类型', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('94', 'Long', 'Long', 'gen_java_type', 'Java类型', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('95', 'dao', '仅持久层', 'gen_category', '代码生成分类\0\0', '40', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('96', '1', '男', 'sex', '性别', '10', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('97', '2', '女', 'sex', '性别', '20', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_dict VALUES ('98', 'Integer', 'Integer', 'gen_java_type', 'Java类型', '30', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_dict VALUES ('99', 'Double', 'Double', 'gen_java_type', 'Java类型', '40', '0', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');


-- ----------------------------
-- Records of sys_log
-- ----------------------------


-- ----------------------------
-- Records of sys_mdict
-- ----------------------------


-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO sys_menu VALUES ('0b2ebd4d639e4c2b83c2dd0764522f24', 'ba8092291b40482db8fe7fc006ea3d76', '0,1,79,3c92c17886944d0687e73e286cada573,ba8092291b40482db8fe7fc006ea3d76,', '编辑', '60', '', '', '', '0', 'test:testData:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '', '1');
INSERT INTO sys_menu VALUES ('0ca004d6b1bf4bcab9670a5060d82a55', '3c92c17886944d0687e73e286cada573', '0,1,79,3c92c17886944d0687e73e286cada573,', '树结构', '90', '/test/testTree', '', '', '1', '', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '', '1');
INSERT INTO sys_menu VALUES ('1', '0', '0,', '功能菜单', '0', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('10', '3', '0,1,2,3,', '字典管理', '60', '/sys/dict/', null, 'th-list', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('11', '10', '0,1,2,3,10,', '查看', '30', null, null, null, '0', 'sys:dict:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('12', '10', '0,1,2,3,10,', '修改', '40', null, null, null, '0', 'sys:dict:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('13', '2', '0,1,2,', '机构用户', '970', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('14', '13', '0,1,2,13,', '区域管理', '50', '/sys/area/', null, 'th', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('15', '14', '0,1,2,13,14,', '查看', '30', null, null, null, '0', 'sys:area:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('16', '14', '0,1,2,13,14,', '修改', '40', null, null, null, '0', 'sys:area:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('17', '13', '0,1,2,13,', '机构管理', '40', '/sys/office/', null, 'th-large', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('18', '17', '0,1,2,13,17,', '查看', '30', null, null, null, '0', 'sys:office:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('19', '17', '0,1,2,13,17,', '修改', '40', null, null, null, '0', 'sys:office:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('2', '1', '0,1,', '系统设置', '900', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('20', '13', '0,1,2,13,', '用户管理', '30', '/sys/user/index', null, 'user', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('21', '20', '0,1,2,13,20,', '查看', '30', null, null, null, '0', 'sys:user:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('22', '20', '0,1,2,13,20,', '修改', '40', null, null, null, '0', 'sys:user:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('23', '2', '0,1,2,', '关于帮助', '990', null, null, null, '0', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('24', '23', '0,1,2,23', '官方首页', '30', '#', '_blank', null, '0', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('25', '23', '0,1,2,23', '项目支持', '50', '#', '_blank', null, '0', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('26', '23', '0,1,2,23', '论坛交流', '80', '#', '_blank', null, '0', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('27', '1', '0,1,', '我的面板', '100', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('28', '27', '0,1,27,', '个人信息', '30', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('29', '28', '0,1,27,28,', '个人信息', '30', '/sys/user/info', null, 'user', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('3', '2', '0,1,2,', '系统设置', '980', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('30', '28', '0,1,27,28,', '修改密码', '40', '/sys/user/modifyPwd', null, 'lock', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('31', '1', '0,1,', '内容管理', '500', '', '', '', '0', '', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '', '1');
INSERT INTO sys_menu VALUES ('32', '31', '0,1,31,', '栏目设置', '990', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('33', '32', '0,1,31,32', '栏目管理', '30', '/cms/category/', null, 'align-justify', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('34', '33', '0,1,31,32,33,', '查看', '30', null, null, null, '0', 'cms:category:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('35', '33', '0,1,31,32,33,', '修改', '40', null, null, null, '0', 'cms:category:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('36', '32', '0,1,31,32', '站点设置', '40', '/cms/site/', null, 'certificate', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('37', '36', '0,1,31,32,36,', '查看', '30', null, null, null, '0', 'cms:site:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('38', '36', '0,1,31,32,36,', '修改', '40', null, null, null, '0', 'cms:site:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('39', '32', '0,1,31,32', '切换站点', '50', '/cms/site/select', null, 'retweet', '1', 'cms:site:select', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('3c92c17886944d0687e73e286cada573', '79', '0,1,79,', '生成示例', '120', '', '', '', '1', '', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '', '1');
INSERT INTO sys_menu VALUES ('4', '3', '0,1,2,3,', '菜单管理', '30', '/sys/menu/', null, 'list-alt', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('40', '31', '0,1,31,', '内容管理', '500', null, null, null, '1', 'cms:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('41', '40', '0,1,31,40,', '内容发布', '30', '/cms/', null, 'briefcase', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('42', '41', '0,1,31,40,41,', '文章模型', '40', '/cms/article/', null, 'file', '0', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('43', '42', '0,1,31,40,41,42,', '查看', '30', null, null, null, '0', 'cms:article:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('44', '42', '0,1,31,40,41,42,', '修改', '40', null, null, null, '0', 'cms:article:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('45', '42', '0,1,31,40,41,42,', '审核', '50', null, null, null, '0', 'cms:article:audit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('46', '41', '0,1,31,40,41,', '链接模型', '60', '/cms/link/', null, 'random', '0', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('47', '46', '0,1,31,40,41,46,', '查看', '30', null, null, null, '0', 'cms:link:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('48', '46', '0,1,31,40,41,46,', '修改', '40', null, null, null, '0', 'cms:link:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('4855cf3b25c244fb8500a380db189d97', 'b1f6d1b86ba24365bae7fd86c5082317', '0,1,79,3c92c17886944d0687e73e286cada573,b1f6d1b86ba24365bae7fd86c5082317,', '查看', '30', '', '', '', '0', 'test:testDataMain:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '', '1');
INSERT INTO sys_menu VALUES ('49', '46', '0,1,31,40,41,46,', '审核', '50', null, null, null, '0', 'cms:link:audit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('5', '4', '0,1,2,3,4,', '查看', '30', null, null, null, '0', 'sys:menu:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('50', '40', '0,1,31,40,', '评论管理', '40', '/cms/comment/?status=2', null, 'comment', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('51', '50', '0,1,31,40,50,', '查看', '30', null, null, null, '0', 'cms:comment:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('52', '50', '0,1,31,40,50,', '审核', '40', null, null, null, '0', 'cms:comment:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('53', '40', '0,1,31,40,', '公共留言', '80', '/cms/guestbook/?status=2', null, 'glass', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('54', '53', '0,1,31,40,53,', '查看', '30', null, null, null, '0', 'cms:guestbook:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('55', '53', '0,1,31,40,53,', '审核', '40', null, null, null, '0', 'cms:guestbook:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('56', '71', '0,1,27,71,', '文件管理', '90', '/../static/ckfinder/ckfinder.html', null, 'folder-open', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('57', '56', '0,1,27,40,56,', '查看', '30', null, null, null, '0', 'cms:ckfinder:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('58', '56', '0,1,27,40,56,', '上传', '40', null, null, null, '0', 'cms:ckfinder:upload', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('59', '56', '0,1,27,40,56,', '修改', '50', null, null, null, '0', 'cms:ckfinder:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('6', '4', '0,1,2,3,4,', '修改', '40', null, null, null, '0', 'sys:menu:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('60', '31', '0,1,31,', '统计分析', '600', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('61', '60', '0,1,31,60,', '信息量统计', '30', '/cms/stats/article', null, 'tasks', '1', 'cms:stats:article', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('62', '1', '0,1,', '在线办公', '200', '', '', '', '0', '', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '', '1');
INSERT INTO sys_menu VALUES ('63', '62', '0,1,62,', '个人办公', '30', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('64', '63', '0,1,62,63,', '请假办理', '300', '/oa/leave', null, 'leaf', '0', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('65', '64', '0,1,62,63,64,', '查看', '30', null, null, null, '0', 'oa:leave:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('66', '64', '0,1,62,63,64,', '修改', '40', null, null, null, '0', 'oa:leave:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('67', '2', '0,1,2,', '日志查询', '985', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('68', '67', '0,1,2,67,', '日志查询', '30', '/sys/log', null, 'pencil', '1', 'sys:log:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('69', '62', '0,1,62,', '流程管理', '300', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('7', '3', '0,1,2,3,', '角色管理', '50', '/sys/role/', null, 'lock', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('70', '69', '0,1,62,69,', '流程管理', '50', '/act/process', null, 'road', '1', 'act:process:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('71', '27', '0,1,27,', '文件管理', '90', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('72', '69', '0,1,62,69,', '模型管理', '100', '/act/model', null, 'road', '1', 'act:model:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('73', '63', '0,1,62,63,', '我的任务', '50', '/act/task/todo/', null, 'tasks', '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('74', '63', '0,1,62,63,', '审批测试', '100', '/oa/testAudit', null, null, '1', 'oa:testAudit:view,oa:testAudit:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('75', '1', '0,1,', '在线演示', '3000', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('79', '1', '0,1,', '代码生成', '5000', '', '', '', '0', '', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '', '1');
INSERT INTO sys_menu VALUES ('8', '7', '0,1,2,3,7,', '查看', '30', null, null, null, '0', 'sys:role:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('80', '79', '0,1,79,', '代码生成', '50', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('81', '80', '0,1,79,80,', '生成方案配置', '30', '/gen/genScheme', null, null, '1', 'gen:genScheme:view,gen:genScheme:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('82', '80', '0,1,79,80,', '业务表配置', '20', '/gen/genTable', null, null, '1', 'gen:genTable:view,gen:genTable:edit,gen:genTableColumn:view,gen:genTableColumn:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('83', '80', '0,1,79,80,', '代码模板管理', '90', '/gen/genTemplate', null, null, '1', 'gen:genTemplate:view,gen:genTemplate:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('84', '67', '0,1,2,67,', '连接池监视', '40', '/../druid', '', '', '1', '', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '', '1');
INSERT INTO sys_menu VALUES ('85', '76', '0,1,75,76,', '行政区域', '80', '/../static/map/map-city.html', null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('86', '75', '0,1,75,', '组件演示', '50', null, null, null, '1', null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('87', '86', '0,1,75,86,', '组件演示', '30', '/test/test/form', null, null, '1', 'test:test:view,test:test:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('88', '62', '0,1,62,', '通知通告', '20', '', '', '', '1', '', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('89', '88', '0,1,62,88,', '我的通告', '30', '/oa/oaNotify/self', '', '', '1', '', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('9', '7', '0,1,2,3,7,', '修改', '40', null, null, null, '0', 'sys:role:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_menu VALUES ('90', '88', '0,1,62,88,', '通告管理', '50', '/oa/oaNotify', '', '', '1', 'oa:oaNotify:view,oa:oaNotify:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '1');
INSERT INTO sys_menu VALUES ('afab2db430e2457f9cf3a11feaa8b869', '0ca004d6b1bf4bcab9670a5060d82a55', '0,1,79,3c92c17886944d0687e73e286cada573,0ca004d6b1bf4bcab9670a5060d82a55,', '编辑', '60', '', '', '', '0', 'test:testTree:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '', '1');
INSERT INTO sys_menu VALUES ('b1f6d1b86ba24365bae7fd86c5082317', '3c92c17886944d0687e73e286cada573', '0,1,79,3c92c17886944d0687e73e286cada573,', '主子表', '60', '/test/testDataMain', '', '', '1', '', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '', '1');
INSERT INTO sys_menu VALUES ('ba8092291b40482db8fe7fc006ea3d76', '3c92c17886944d0687e73e286cada573', '0,1,79,3c92c17886944d0687e73e286cada573,', '单表', '30', '/test/testData', '', '', '1', '', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '', '1');
INSERT INTO sys_menu VALUES ('c2e4d9082a0b4386884a0b203afe2c5c', '0ca004d6b1bf4bcab9670a5060d82a55', '0,1,79,3c92c17886944d0687e73e286cada573,0ca004d6b1bf4bcab9670a5060d82a55,', '查看', '30', '', '', '', '0', 'test:testTree:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '', '1');
INSERT INTO sys_menu VALUES ('d15ec45a4c5449c3bbd7a61d5f9dd1d2', 'b1f6d1b86ba24365bae7fd86c5082317', '0,1,79,3c92c17886944d0687e73e286cada573,b1f6d1b86ba24365bae7fd86c5082317,', '编辑', '60', '', '', '', '0', 'test:testDataMain:edit', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '', '1');
INSERT INTO sys_menu VALUES ('df7ce823c5b24ff9bada43d992f373e2', 'ba8092291b40482db8fe7fc006ea3d76', '0,1,79,3c92c17886944d0687e73e286cada573,ba8092291b40482db8fe7fc006ea3d76,', '查看', '30', '', '', '', '0', 'test:testData:view', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '', '1');


-- ----------------------------
-- Records of sys_office
-- ----------------------------
INSERT INTO sys_office VALUES ('1', '0', '0,', '山东省总公司', '10', '2', '100000', '1', '1', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('10', '7', '0,1,7,', '市场部', '30', '3', '200003', '2', '2', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('11', '7', '0,1,7,', '技术部', '40', '3', '200004', '2', '2', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('12', '7', '0,1,7,', '历城区分公司', '0', '4', '201000', '1', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('13', '12', '0,1,7,12,', '公司领导', '10', '4', '201001', '2', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('14', '12', '0,1,7,12,', '综合部', '20', '4', '201002', '2', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('15', '12', '0,1,7,12,', '市场部', '30', '4', '201003', '2', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('16', '12', '0,1,7,12,', '技术部', '40', '4', '201004', '2', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('17', '7', '0,1,7,', '历下区分公司', '40', '5', '201010', '1', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('18', '17', '0,1,7,17,', '公司领导', '10', '5', '201011', '2', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('19', '17', '0,1,7,17,', '综合部', '20', '5', '201012', '2', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('2', '1', '0,1,', '公司领导', '10', '2', '100001', '2', '1', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('20', '17', '0,1,7,17,', '市场部', '30', '5', '201013', '2', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('21', '17', '0,1,7,17,', '技术部', '40', '5', '201014', '2', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('22', '7', '0,1,7,', '高新区分公司', '50', '6', '201010', '1', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('23', '22', '0,1,7,22,', '公司领导', '10', '6', '201011', '2', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('24', '22', '0,1,7,22,', '综合部', '20', '6', '201012', '2', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('25', '22', '0,1,7,22,', '市场部', '30', '6', '201013', '2', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('26', '22', '0,1,7,22,', '技术部', '40', '6', '201014', '2', '3', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('3', '1', '0,1,', '综合部', '20', '2', '100002', '2', '1', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('4', '1', '0,1,', '市场部', '30', '2', '100003', '2', '1', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('5', '1', '0,1,', '技术部', '40', '2', '100004', '2', '1', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('6', '1', '0,1,', '研发部', '50', '2', '100005', '2', '1', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('7', '1', '0,1,', '济南市分公司', '20', '3', '200000', '1', '2', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('8', '7', '0,1,7,', '公司领导', '10', '3', '200001', '2', '2', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_office VALUES ('9', '7', '0,1,7,', '综合部', '20', '3', '200002', '2', '2', null, null, null, null, null, null, '1', null, null, '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');


-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO sys_role VALUES ('1', '1', '系统管理员', 'dept', 'assignment', '1', null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_role VALUES ('2', '1', '公司管理员', 'hr', 'assignment', '2', null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_role VALUES ('3', '1', '本公司管理员', 'a', 'assignment', '3', null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_role VALUES ('4', '1', '部门管理员', 'b', 'assignment', '4', null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_role VALUES ('5', '1', '本部门管理员', 'c', 'assignment', '5', null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_role VALUES ('6', '1', '普通用户', 'd', 'assignment', '8', null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_role VALUES ('7', '7', '济南市管理员', 'e', 'assignment', '9', null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');


-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO sys_role_menu VALUES ('1', '1');
INSERT INTO sys_role_menu VALUES ('1', '10');
INSERT INTO sys_role_menu VALUES ('1', '11');
INSERT INTO sys_role_menu VALUES ('1', '12');
INSERT INTO sys_role_menu VALUES ('1', '13');
INSERT INTO sys_role_menu VALUES ('1', '14');
INSERT INTO sys_role_menu VALUES ('1', '15');
INSERT INTO sys_role_menu VALUES ('1', '16');
INSERT INTO sys_role_menu VALUES ('1', '17');
INSERT INTO sys_role_menu VALUES ('1', '18');
INSERT INTO sys_role_menu VALUES ('1', '19');
INSERT INTO sys_role_menu VALUES ('1', '2');
INSERT INTO sys_role_menu VALUES ('1', '20');
INSERT INTO sys_role_menu VALUES ('1', '21');
INSERT INTO sys_role_menu VALUES ('1', '22');
INSERT INTO sys_role_menu VALUES ('1', '23');
INSERT INTO sys_role_menu VALUES ('1', '24');
INSERT INTO sys_role_menu VALUES ('1', '25');
INSERT INTO sys_role_menu VALUES ('1', '26');
INSERT INTO sys_role_menu VALUES ('1', '27');
INSERT INTO sys_role_menu VALUES ('1', '28');
INSERT INTO sys_role_menu VALUES ('1', '29');
INSERT INTO sys_role_menu VALUES ('1', '3');
INSERT INTO sys_role_menu VALUES ('1', '30');
INSERT INTO sys_role_menu VALUES ('1', '31');
INSERT INTO sys_role_menu VALUES ('1', '32');
INSERT INTO sys_role_menu VALUES ('1', '33');
INSERT INTO sys_role_menu VALUES ('1', '34');
INSERT INTO sys_role_menu VALUES ('1', '35');
INSERT INTO sys_role_menu VALUES ('1', '36');
INSERT INTO sys_role_menu VALUES ('1', '37');
INSERT INTO sys_role_menu VALUES ('1', '38');
INSERT INTO sys_role_menu VALUES ('1', '39');
INSERT INTO sys_role_menu VALUES ('1', '4');
INSERT INTO sys_role_menu VALUES ('1', '40');
INSERT INTO sys_role_menu VALUES ('1', '41');
INSERT INTO sys_role_menu VALUES ('1', '42');
INSERT INTO sys_role_menu VALUES ('1', '43');
INSERT INTO sys_role_menu VALUES ('1', '44');
INSERT INTO sys_role_menu VALUES ('1', '45');
INSERT INTO sys_role_menu VALUES ('1', '46');
INSERT INTO sys_role_menu VALUES ('1', '47');
INSERT INTO sys_role_menu VALUES ('1', '48');
INSERT INTO sys_role_menu VALUES ('1', '49');
INSERT INTO sys_role_menu VALUES ('1', '5');
INSERT INTO sys_role_menu VALUES ('1', '50');
INSERT INTO sys_role_menu VALUES ('1', '51');
INSERT INTO sys_role_menu VALUES ('1', '52');
INSERT INTO sys_role_menu VALUES ('1', '53');
INSERT INTO sys_role_menu VALUES ('1', '54');
INSERT INTO sys_role_menu VALUES ('1', '55');
INSERT INTO sys_role_menu VALUES ('1', '56');
INSERT INTO sys_role_menu VALUES ('1', '57');
INSERT INTO sys_role_menu VALUES ('1', '58');
INSERT INTO sys_role_menu VALUES ('1', '59');
INSERT INTO sys_role_menu VALUES ('1', '6');
INSERT INTO sys_role_menu VALUES ('1', '60');
INSERT INTO sys_role_menu VALUES ('1', '61');
INSERT INTO sys_role_menu VALUES ('1', '62');
INSERT INTO sys_role_menu VALUES ('1', '63');
INSERT INTO sys_role_menu VALUES ('1', '64');
INSERT INTO sys_role_menu VALUES ('1', '65');
INSERT INTO sys_role_menu VALUES ('1', '66');
INSERT INTO sys_role_menu VALUES ('1', '67');
INSERT INTO sys_role_menu VALUES ('1', '68');
INSERT INTO sys_role_menu VALUES ('1', '69');
INSERT INTO sys_role_menu VALUES ('1', '7');
INSERT INTO sys_role_menu VALUES ('1', '70');
INSERT INTO sys_role_menu VALUES ('1', '71');
INSERT INTO sys_role_menu VALUES ('1', '72');
INSERT INTO sys_role_menu VALUES ('1', '73');
INSERT INTO sys_role_menu VALUES ('1', '74');
INSERT INTO sys_role_menu VALUES ('1', '75');
INSERT INTO sys_role_menu VALUES ('1', '76');
INSERT INTO sys_role_menu VALUES ('1', '77');
INSERT INTO sys_role_menu VALUES ('1', '78');
INSERT INTO sys_role_menu VALUES ('1', '79');
INSERT INTO sys_role_menu VALUES ('1', '8');
INSERT INTO sys_role_menu VALUES ('1', '80');
INSERT INTO sys_role_menu VALUES ('1', '81');
INSERT INTO sys_role_menu VALUES ('1', '82');
INSERT INTO sys_role_menu VALUES ('1', '83');
INSERT INTO sys_role_menu VALUES ('1', '84');
INSERT INTO sys_role_menu VALUES ('1', '85');
INSERT INTO sys_role_menu VALUES ('1', '86');
INSERT INTO sys_role_menu VALUES ('1', '87');
INSERT INTO sys_role_menu VALUES ('1', '88');
INSERT INTO sys_role_menu VALUES ('1', '89');
INSERT INTO sys_role_menu VALUES ('1', '9');
INSERT INTO sys_role_menu VALUES ('1', '90');
INSERT INTO sys_role_menu VALUES ('2', '1');
INSERT INTO sys_role_menu VALUES ('2', '10');
INSERT INTO sys_role_menu VALUES ('2', '11');
INSERT INTO sys_role_menu VALUES ('2', '12');
INSERT INTO sys_role_menu VALUES ('2', '13');
INSERT INTO sys_role_menu VALUES ('2', '14');
INSERT INTO sys_role_menu VALUES ('2', '15');
INSERT INTO sys_role_menu VALUES ('2', '16');
INSERT INTO sys_role_menu VALUES ('2', '17');
INSERT INTO sys_role_menu VALUES ('2', '18');
INSERT INTO sys_role_menu VALUES ('2', '19');
INSERT INTO sys_role_menu VALUES ('2', '2');
INSERT INTO sys_role_menu VALUES ('2', '20');
INSERT INTO sys_role_menu VALUES ('2', '21');
INSERT INTO sys_role_menu VALUES ('2', '22');
INSERT INTO sys_role_menu VALUES ('2', '23');
INSERT INTO sys_role_menu VALUES ('2', '24');
INSERT INTO sys_role_menu VALUES ('2', '25');
INSERT INTO sys_role_menu VALUES ('2', '26');
INSERT INTO sys_role_menu VALUES ('2', '27');
INSERT INTO sys_role_menu VALUES ('2', '28');
INSERT INTO sys_role_menu VALUES ('2', '29');
INSERT INTO sys_role_menu VALUES ('2', '3');
INSERT INTO sys_role_menu VALUES ('2', '30');
INSERT INTO sys_role_menu VALUES ('2', '31');
INSERT INTO sys_role_menu VALUES ('2', '32');
INSERT INTO sys_role_menu VALUES ('2', '33');
INSERT INTO sys_role_menu VALUES ('2', '34');
INSERT INTO sys_role_menu VALUES ('2', '35');
INSERT INTO sys_role_menu VALUES ('2', '36');
INSERT INTO sys_role_menu VALUES ('2', '37');
INSERT INTO sys_role_menu VALUES ('2', '38');
INSERT INTO sys_role_menu VALUES ('2', '39');
INSERT INTO sys_role_menu VALUES ('2', '4');
INSERT INTO sys_role_menu VALUES ('2', '40');
INSERT INTO sys_role_menu VALUES ('2', '41');
INSERT INTO sys_role_menu VALUES ('2', '42');
INSERT INTO sys_role_menu VALUES ('2', '43');
INSERT INTO sys_role_menu VALUES ('2', '44');
INSERT INTO sys_role_menu VALUES ('2', '45');
INSERT INTO sys_role_menu VALUES ('2', '46');
INSERT INTO sys_role_menu VALUES ('2', '47');
INSERT INTO sys_role_menu VALUES ('2', '48');
INSERT INTO sys_role_menu VALUES ('2', '49');
INSERT INTO sys_role_menu VALUES ('2', '5');
INSERT INTO sys_role_menu VALUES ('2', '50');
INSERT INTO sys_role_menu VALUES ('2', '51');
INSERT INTO sys_role_menu VALUES ('2', '52');
INSERT INTO sys_role_menu VALUES ('2', '53');
INSERT INTO sys_role_menu VALUES ('2', '54');
INSERT INTO sys_role_menu VALUES ('2', '55');
INSERT INTO sys_role_menu VALUES ('2', '56');
INSERT INTO sys_role_menu VALUES ('2', '57');
INSERT INTO sys_role_menu VALUES ('2', '58');
INSERT INTO sys_role_menu VALUES ('2', '59');
INSERT INTO sys_role_menu VALUES ('2', '6');
INSERT INTO sys_role_menu VALUES ('2', '60');
INSERT INTO sys_role_menu VALUES ('2', '61');
INSERT INTO sys_role_menu VALUES ('2', '62');
INSERT INTO sys_role_menu VALUES ('2', '63');
INSERT INTO sys_role_menu VALUES ('2', '64');
INSERT INTO sys_role_menu VALUES ('2', '65');
INSERT INTO sys_role_menu VALUES ('2', '66');
INSERT INTO sys_role_menu VALUES ('2', '67');
INSERT INTO sys_role_menu VALUES ('2', '68');
INSERT INTO sys_role_menu VALUES ('2', '69');
INSERT INTO sys_role_menu VALUES ('2', '7');
INSERT INTO sys_role_menu VALUES ('2', '70');
INSERT INTO sys_role_menu VALUES ('2', '71');
INSERT INTO sys_role_menu VALUES ('2', '72');
INSERT INTO sys_role_menu VALUES ('2', '73');
INSERT INTO sys_role_menu VALUES ('2', '74');
INSERT INTO sys_role_menu VALUES ('2', '75');
INSERT INTO sys_role_menu VALUES ('2', '76');
INSERT INTO sys_role_menu VALUES ('2', '77');
INSERT INTO sys_role_menu VALUES ('2', '78');
INSERT INTO sys_role_menu VALUES ('2', '79');
INSERT INTO sys_role_menu VALUES ('2', '8');
INSERT INTO sys_role_menu VALUES ('2', '80');
INSERT INTO sys_role_menu VALUES ('2', '81');
INSERT INTO sys_role_menu VALUES ('2', '82');
INSERT INTO sys_role_menu VALUES ('2', '83');
INSERT INTO sys_role_menu VALUES ('2', '84');
INSERT INTO sys_role_menu VALUES ('2', '85');
INSERT INTO sys_role_menu VALUES ('2', '86');
INSERT INTO sys_role_menu VALUES ('2', '87');
INSERT INTO sys_role_menu VALUES ('2', '88');
INSERT INTO sys_role_menu VALUES ('2', '89');
INSERT INTO sys_role_menu VALUES ('2', '9');
INSERT INTO sys_role_menu VALUES ('2', '90');
INSERT INTO sys_role_menu VALUES ('3', '1');
INSERT INTO sys_role_menu VALUES ('3', '10');
INSERT INTO sys_role_menu VALUES ('3', '11');
INSERT INTO sys_role_menu VALUES ('3', '12');
INSERT INTO sys_role_menu VALUES ('3', '13');
INSERT INTO sys_role_menu VALUES ('3', '14');
INSERT INTO sys_role_menu VALUES ('3', '15');
INSERT INTO sys_role_menu VALUES ('3', '16');
INSERT INTO sys_role_menu VALUES ('3', '17');
INSERT INTO sys_role_menu VALUES ('3', '18');
INSERT INTO sys_role_menu VALUES ('3', '19');
INSERT INTO sys_role_menu VALUES ('3', '2');
INSERT INTO sys_role_menu VALUES ('3', '20');
INSERT INTO sys_role_menu VALUES ('3', '21');
INSERT INTO sys_role_menu VALUES ('3', '22');
INSERT INTO sys_role_menu VALUES ('3', '23');
INSERT INTO sys_role_menu VALUES ('3', '24');
INSERT INTO sys_role_menu VALUES ('3', '25');
INSERT INTO sys_role_menu VALUES ('3', '26');
INSERT INTO sys_role_menu VALUES ('3', '27');
INSERT INTO sys_role_menu VALUES ('3', '28');
INSERT INTO sys_role_menu VALUES ('3', '29');
INSERT INTO sys_role_menu VALUES ('3', '3');
INSERT INTO sys_role_menu VALUES ('3', '30');
INSERT INTO sys_role_menu VALUES ('3', '31');
INSERT INTO sys_role_menu VALUES ('3', '32');
INSERT INTO sys_role_menu VALUES ('3', '33');
INSERT INTO sys_role_menu VALUES ('3', '34');
INSERT INTO sys_role_menu VALUES ('3', '35');
INSERT INTO sys_role_menu VALUES ('3', '36');
INSERT INTO sys_role_menu VALUES ('3', '37');
INSERT INTO sys_role_menu VALUES ('3', '38');
INSERT INTO sys_role_menu VALUES ('3', '39');
INSERT INTO sys_role_menu VALUES ('3', '4');
INSERT INTO sys_role_menu VALUES ('3', '40');
INSERT INTO sys_role_menu VALUES ('3', '41');
INSERT INTO sys_role_menu VALUES ('3', '42');
INSERT INTO sys_role_menu VALUES ('3', '43');
INSERT INTO sys_role_menu VALUES ('3', '44');
INSERT INTO sys_role_menu VALUES ('3', '45');
INSERT INTO sys_role_menu VALUES ('3', '46');
INSERT INTO sys_role_menu VALUES ('3', '47');
INSERT INTO sys_role_menu VALUES ('3', '48');
INSERT INTO sys_role_menu VALUES ('3', '49');
INSERT INTO sys_role_menu VALUES ('3', '5');
INSERT INTO sys_role_menu VALUES ('3', '50');
INSERT INTO sys_role_menu VALUES ('3', '51');
INSERT INTO sys_role_menu VALUES ('3', '52');
INSERT INTO sys_role_menu VALUES ('3', '53');
INSERT INTO sys_role_menu VALUES ('3', '54');
INSERT INTO sys_role_menu VALUES ('3', '55');
INSERT INTO sys_role_menu VALUES ('3', '56');
INSERT INTO sys_role_menu VALUES ('3', '57');
INSERT INTO sys_role_menu VALUES ('3', '58');
INSERT INTO sys_role_menu VALUES ('3', '59');
INSERT INTO sys_role_menu VALUES ('3', '6');
INSERT INTO sys_role_menu VALUES ('3', '60');
INSERT INTO sys_role_menu VALUES ('3', '61');
INSERT INTO sys_role_menu VALUES ('3', '62');
INSERT INTO sys_role_menu VALUES ('3', '63');
INSERT INTO sys_role_menu VALUES ('3', '64');
INSERT INTO sys_role_menu VALUES ('3', '65');
INSERT INTO sys_role_menu VALUES ('3', '66');
INSERT INTO sys_role_menu VALUES ('3', '67');
INSERT INTO sys_role_menu VALUES ('3', '68');
INSERT INTO sys_role_menu VALUES ('3', '69');
INSERT INTO sys_role_menu VALUES ('3', '7');
INSERT INTO sys_role_menu VALUES ('3', '70');
INSERT INTO sys_role_menu VALUES ('3', '71');
INSERT INTO sys_role_menu VALUES ('3', '72');
INSERT INTO sys_role_menu VALUES ('3', '73');
INSERT INTO sys_role_menu VALUES ('3', '74');
INSERT INTO sys_role_menu VALUES ('3', '75');
INSERT INTO sys_role_menu VALUES ('3', '76');
INSERT INTO sys_role_menu VALUES ('3', '77');
INSERT INTO sys_role_menu VALUES ('3', '78');
INSERT INTO sys_role_menu VALUES ('3', '79');
INSERT INTO sys_role_menu VALUES ('3', '8');
INSERT INTO sys_role_menu VALUES ('3', '80');
INSERT INTO sys_role_menu VALUES ('3', '81');
INSERT INTO sys_role_menu VALUES ('3', '82');
INSERT INTO sys_role_menu VALUES ('3', '83');
INSERT INTO sys_role_menu VALUES ('3', '84');
INSERT INTO sys_role_menu VALUES ('3', '85');
INSERT INTO sys_role_menu VALUES ('3', '86');
INSERT INTO sys_role_menu VALUES ('3', '87');
INSERT INTO sys_role_menu VALUES ('3', '88');
INSERT INTO sys_role_menu VALUES ('3', '89');
INSERT INTO sys_role_menu VALUES ('3', '9');
INSERT INTO sys_role_menu VALUES ('3', '90');


-- ----------------------------
-- Records of sys_role_office
-- ----------------------------
INSERT INTO sys_role_office VALUES ('7', '10');
INSERT INTO sys_role_office VALUES ('7', '11');
INSERT INTO sys_role_office VALUES ('7', '12');
INSERT INTO sys_role_office VALUES ('7', '13');
INSERT INTO sys_role_office VALUES ('7', '14');
INSERT INTO sys_role_office VALUES ('7', '15');
INSERT INTO sys_role_office VALUES ('7', '16');
INSERT INTO sys_role_office VALUES ('7', '17');
INSERT INTO sys_role_office VALUES ('7', '18');
INSERT INTO sys_role_office VALUES ('7', '19');
INSERT INTO sys_role_office VALUES ('7', '20');
INSERT INTO sys_role_office VALUES ('7', '21');
INSERT INTO sys_role_office VALUES ('7', '22');
INSERT INTO sys_role_office VALUES ('7', '23');
INSERT INTO sys_role_office VALUES ('7', '24');
INSERT INTO sys_role_office VALUES ('7', '25');
INSERT INTO sys_role_office VALUES ('7', '26');
INSERT INTO sys_role_office VALUES ('7', '7');
INSERT INTO sys_role_office VALUES ('7', '8');
INSERT INTO sys_role_office VALUES ('7', '9');


-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO sys_user VALUES ('1', '1', '2', 'admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0001', '系统管理员', 'zww199009@163.com', '0354-5774554', '15209840499', '', '/userfiles/1/images/photo/2017/01/QQ%E5%9B%BE%E7%89%8720160701203534.jpg', '127.0.0.1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '最高管理员', '0');
INSERT INTO sys_user VALUES ('10', '7', '11', 'jn_jsb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0010', '济南技术部', null, null, null, null, null, null, null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_user VALUES ('11', '12', '13', 'lc_admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0011', '济南历城领导', null, null, null, null, null, null, null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_user VALUES ('12', '12', '18', 'lx_admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0012', '济南历下领导', null, null, null, null, null, null, null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_user VALUES ('13', '22', '23', 'gx_admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0013', '济南高新领导', null, null, null, null, null, null, null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_user VALUES ('2', '1', '2', 'sd_admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0002', '管理员', null, null, null, null, null, null, null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_user VALUES ('3', '1', '3', 'sd_zhb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0003', '综合部', null, null, null, null, null, null, null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_user VALUES ('4', '1', '4', 'sd_scb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0004', '市场部', null, null, null, null, null, null, null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_user VALUES ('5', '1', '5', 'sd_jsb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0005', '技术部', null, null, null, null, null, null, null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_user VALUES ('6', '1', '6', 'sd_yfb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0006', '研发部', null, null, null, null, null, null, null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_user VALUES ('7', '7', '8', 'jn_admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0007', '济南领导', null, null, null, null, null, null, null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_user VALUES ('8', '7', '9', 'jn_zhb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0008', '济南综合部', null, null, null, null, null, null, null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');
INSERT INTO sys_user VALUES ('9', '7', '10', 'jn_scb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0009', '济南市场部', null, null, null, null, null, null, null, '1', '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), '1', to_date('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss'), null, '0');


-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO sys_user_role VALUES ('1', '1');
INSERT INTO sys_user_role VALUES ('1', '2');
INSERT INTO sys_user_role VALUES ('10', '2');
INSERT INTO sys_user_role VALUES ('11', '3');
INSERT INTO sys_user_role VALUES ('12', '4');
INSERT INTO sys_user_role VALUES ('13', '5');
INSERT INTO sys_user_role VALUES ('14', '6');
INSERT INTO sys_user_role VALUES ('2', '1');
INSERT INTO sys_user_role VALUES ('3', '2');
INSERT INTO sys_user_role VALUES ('4', '3');
INSERT INTO sys_user_role VALUES ('5', '4');
INSERT INTO sys_user_role VALUES ('6', '5');
INSERT INTO sys_user_role VALUES ('7', '2');
INSERT INTO sys_user_role VALUES ('7', '7');
INSERT INTO sys_user_role VALUES ('8', '2');
INSERT INTO sys_user_role VALUES ('9', '1');

commit;