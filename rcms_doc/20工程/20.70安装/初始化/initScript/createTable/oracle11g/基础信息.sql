/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2017/7/11 星期二 下午 8:34:38                     */
/*==============================================================*/


alter table AUTH_ATTRIBUTE
   drop primary key cascade;

drop table AUTH_ATTRIBUTE cascade constraints;

alter table AUTH_ATTR_ACTION
   drop primary key cascade;

drop table AUTH_ATTR_ACTION cascade constraints;

alter table AUTH_DIR
   drop primary key cascade;

drop table AUTH_DIR cascade constraints;

alter table AUTH_MENU
   drop primary key cascade;

drop table AUTH_MENU cascade constraints;

alter table AUTH_ROLE
   drop primary key cascade;

drop table AUTH_ROLE cascade constraints;

alter table AUTH_ROLE_ATTRIBUTE
   drop primary key cascade;

drop table AUTH_ROLE_ATTRIBUTE cascade constraints;

alter table AUTH_ROLE_DATA
   drop primary key cascade;

drop table AUTH_ROLE_DATA cascade constraints;

alter table ROLE_DATA_TYPE
   drop primary key cascade;

drop table ROLE_DATA_TYPE cascade constraints;

alter table USER_ROLE
   drop primary key cascade;

drop table USER_ROLE cascade constraints;

drop sequence AUTH_DIR_CODE_SEQ;

drop sequence AUTH_DIR_ID_SEQ;

drop sequence AUTH_DIR_SEQ;

drop sequence AUTH_ROLE_ID_SEQ;

drop sequence USER_INFO_CODE_SEQ;

drop sequence USER_INFO_ID_SEQ;

create sequence AUTH_DIR_CODE_SEQ
increment by 1
start with 1
 maxvalue 9999999
 minvalue 1
cycle
 cache 10;

create sequence AUTH_DIR_ID_SEQ
increment by 1
start with 2
 maxvalue 999999999999
 minvalue 1
 cache 1000;

create sequence AUTH_DIR_SEQ
increment by 1
start with 1
 maxvalue 99999
 minvalue 1
cycle
 cache 10;

create sequence AUTH_ROLE_ID_SEQ
increment by 1
start with 1
 maxvalue 9999999
 minvalue 1
cycle
 cache 10;

create sequence USER_INFO_CODE_SEQ
increment by 1
start with 1
 maxvalue 9999999
 minvalue 1
cycle
 cache 10;

create sequence USER_INFO_ID_SEQ
increment by 1
start with 2
 maxvalue 999999999999
 minvalue 1
 cache 1000;

/*==============================================================*/
/* Table: AUTH_ATTRIBUTE                                        */
/*==============================================================*/
create table AUTH_ATTRIBUTE 
(
   ATTRIBUTE_ID         INTEGER              not null,
   ATTRIBUTE_CODE       VARCHAR(30)          not null,
   MENU_CODE            VARCHAR(20),
   TITLE                VARCHAR2(512),
   OPERATION_URL        VARCHAR2(200)        not null,
   OPERATION_TYPE       INTEGER              not null,
   IDX                  INTEGER,
   CREATE_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP,
   CREATE_TIME          TIMESTAMP
);

comment on table AUTH_ATTRIBUTE is
'菜单、权限表';

comment on column AUTH_ATTRIBUTE.ATTRIBUTE_CODE is
'菜单ID';

comment on column AUTH_ATTRIBUTE.MENU_CODE is
'父菜单ID';

comment on column AUTH_ATTRIBUTE.TITLE is
'菜单中文名称';

comment on column AUTH_ATTRIBUTE.OPERATION_TYPE is
' 1:查询 2:编辑';

alter table AUTH_ATTRIBUTE
   add constraint PK_AUTH_ATTRIBUTE primary key (ATTRIBUTE_ID);

/*==============================================================*/
/* Table: AUTH_ATTR_ACTION                                      */
/*==============================================================*/
create table AUTH_ATTR_ACTION 
(
   ATTRIBUTE_ID         INTEGER              not null,
   ACTION_URL           VARCHAR2(200)        not null,
   CREATE_TIME          TIMESTAMP,
   VERIFY_RESOURCE      CHAR(1)              not null
);

comment on table AUTH_ATTR_ACTION is
'一个功能对应的action，系统通过action来控制请求
';

comment on column AUTH_ATTR_ACTION.ACTION_URL is
'父菜单ID';

comment on column AUTH_ATTR_ACTION.VERIFY_RESOURCE is
'0:不验证
1:验证';

alter table AUTH_ATTR_ACTION
   add constraint PK_AUTH_ATTR_ACTION primary key (ATTRIBUTE_ID, ACTION_URL);

/*==============================================================*/
/* Table: AUTH_DIR                                              */
/*==============================================================*/
create table AUTH_DIR 
(
   DIR_ID               INTEGER              not null,
   PARENT_ID            INTEGER              not null,
   DIR_NAME             VARCHAR2(30)         not null,
   DIR_CODE             VARCHAR(20)          not null,
   DIR_SEQ              VARCHAR2(3072)       not null,
   SEQ                  CHAR(5)              not null,
   IDX                  INTEGER,
   EMAIL                VARCHAR(50),
   PHONE                VARCHAR(20),
   IS_LEAF              CHAR(1),
   MEMO                 VARCHAR(50),
   STATE                CHAR(2),
   CREATE_TIME          TIMESTAMP            not null,
   CREATE_USER_ID       INTEGER              not null,
   UPDATE_TIME          TIMESTAMP,
   MODIFY_USER_ID       INTEGER
);

comment on table AUTH_DIR is
'机构';

comment on column AUTH_DIR.STATE is
'01有效02无效。默认01';

alter table AUTH_DIR
   add constraint PK_AUTH_DIR primary key (DIR_ID);

/*==============================================================*/
/* Table: AUTH_MENU                                             */
/*==============================================================*/
create table AUTH_MENU 
(
   MENU_ID              INTEGER              not null,
   MENU_NAME            VARCHAR2(20)         not null,
   MENU_CODE            VARCHAR(20)          not null,
   PARENT_MENU_CODE     VARCHAR(20)          not null,
   IS_LEAF              CHAR(1)              not null,
   IDX                  INTEGER,
   ACTION_URL           VARCHAR2(200)        not null
);

comment on column AUTH_MENU.ACTION_URL is
'父菜单ID';

alter table AUTH_MENU
   add constraint PK_AUTH_MENU primary key (MENU_ID);

/*==============================================================*/
/* Table: AUTH_ROLE                                             */
/*==============================================================*/
create table AUTH_ROLE 
(
   ROLE_ID              INTEGER              not null,
   ROLE_NAME            VARCHAR2(20)         not null,
   ROLE_DESC            VARCHAR2(600),
   VERSION              INT,
   CREATE_USER_ID       INTEGER              not null,
   CREATE_TIME          TIMESTAMP            not null,
   MODIFY_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP            not null
);

comment on table AUTH_ROLE is
'角色可操作功能的集合';

comment on column AUTH_ROLE.ROLE_NAME is
'角色ID';

comment on column AUTH_ROLE.ROLE_DESC is
'角色描述';

alter table AUTH_ROLE
   add constraint PK_AUTH_ROLE primary key (ROLE_ID);

/*==============================================================*/
/* Table: AUTH_ROLE_ATTRIBUTE                                   */
/*==============================================================*/
create table AUTH_ROLE_ATTRIBUTE 
(
   ROLE_ID              INTEGER              not null,
   ATTRIBUTE_ID         INTEGER              not null,
   CREATE_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP,
   CREATE_TIME          TIMESTAMP
);

comment on table AUTH_ROLE_ATTRIBUTE is
'角色可操作的权限';

comment on column AUTH_ROLE_ATTRIBUTE.ROLE_ID is
'应用系统ID';

alter table AUTH_ROLE_ATTRIBUTE
   add constraint PK_AUTH_ROLE_ATTRIBUTE primary key (ROLE_ID, ATTRIBUTE_ID);

/*==============================================================*/
/* Table: AUTH_ROLE_DATA                                        */
/*==============================================================*/
create table AUTH_ROLE_DATA 
(
   ROLE_ID              INTEGER              not null,
   DATA_ID              INTEGER              not null,
   CREATE_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP,
   CREATE_TIME          TIMESTAMP
);

comment on table AUTH_ROLE_DATA is
'角色可操作的权限';

comment on column AUTH_ROLE_DATA.ROLE_ID is
'应用系统ID';

alter table AUTH_ROLE_DATA
   add constraint PK_AUTH_ROLE_DATA primary key (ROLE_ID, DATA_ID);

/*==============================================================*/
/* Table: ROLE_DATA_TYPE                                        */
/*==============================================================*/
create table ROLE_DATA_TYPE 
(
   DATA_ID              INTEGER              not null,
   DATA_NAME            VARCHAR2(20),
   DATA_DESC            VARCHAR2(200),
   DATA_CODE            CHAR(2)
);

comment on column ROLE_DATA_TYPE.DATA_NAME is
'全公司01
所在部门02
项目经理03
所在项目04';

comment on column ROLE_DATA_TYPE.DATA_DESC is
'全公司01
所在部门02
项目经理03
所在项目04';

comment on column ROLE_DATA_TYPE.DATA_CODE is
'全公司01
所在部门02
项目经理03
所在项目04';

alter table ROLE_DATA_TYPE
   add constraint PK_ROLE_DATA_TYPE primary key (DATA_ID);


drop index LOGIN_CODE_IDX;

alter table USER_INFO
   drop primary key cascade;

drop table USER_INFO cascade constraints;

/*==============================================================*/
/* Table: USER_INFO                                             */
/*==============================================================*/
create table USER_INFO 
(
   USER_ID              INTEGER              not null,
   LOGIN_CODE           VARCHAR2(20)         not null,
   PASSWORD             VARCHAR2(50)         not null,
   USER_NAME            VARCHAR2(40)         not null,
   USER_CODE            VARCHAR2(20)         not null,
   PHOTO                VARCHAR(100),
   GENDER               CHAR(2),
   NATION               VARCHAR2(60),
   NATIVE_PLACE         VARCHAR2(200),
   HOME_ADD             VARCHAR2(100),
   CURRENT_ADD          VARCHAR2(100),
   PROFESSIONAL_RANKS   VARCHAR2(50),
   CELL_PHONE           VARCHAR(20),
   OFFICE_PHONE         VARCHAR(20),
   EMERGENCY_MAN        VARCHAR(20),
   EMERGENCY_PHONE      VARCHAR(20),
   HOME_PHONE           VARCHAR(20),
   ENTRY_DATE           DATE,
   USER_STATUS          CHAR(1),
   POLITICS_STATUS      VARCHAR2(30),
   EDUCATION            VARCHAR2(30),
   DEGREE               VARCHAR2(10),
   GRADUATE_SCHOOL      VARCHAR2(50),
   SPECIALTY            VARCHAR2(50),
   GRADUATE_DATE        DATE,
   START_WORK_DATE      DATE,
   BIRTHDAY             DATE,
   ID_NUMBER            VARCHAR(18),
   EMAIL                VARCHAR(30),
   QQ                   VARCHAR(30),
   HOUSING_FUND_ACCOUNT VARCHAR(30),
   POSITION             VARCHAR(30),
   DIR_ID               VARCHAR(20),
   DEPT_POSITION        VARCHAR(20),
   POSITION_DEGREE      VARCHAR(30),
   POSITION_TIME        DATE,
   CONTRACT_TYPE        VARCHAR(60),
   CONTRACT_START_TIME  DATE,
   CONTRACT_END_TIME    DATE,
   EMPLOYEE_TYPE        VARCHAR(60),
   EMPLOYEE_WAGES_TYPE  VARCHAR(60),
   PROBATION_START      DATE,
   PROBATION_END        DATE,
   WORK_STATUS          VARCHAR(60),
   MARITAL_STATUS       VARCHAR(30),
   VERSION              INT,
   CREATE_TIME          TIMESTAMP,
   CREATE_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP,
   MODIFY_USER_ID       INTEGER
);

comment on table USER_INFO is
'用户信息表';

comment on column USER_INFO.USER_ID is
'用户ID';

comment on column USER_INFO.USER_NAME is
'员工号';

comment on column USER_INFO.USER_CODE is
'员工号';

comment on column USER_INFO.GENDER is
'性别
00-男
01-女
02-未知';

comment on column USER_INFO.USER_STATUS is
'用户状态
0-失效
1-生效';

comment on column USER_INFO.ID_NUMBER is
'证件号码';

alter table USER_INFO
   add constraint PK_USER_INFO primary key (USER_ID);

/*==============================================================*/
/* Index: LOGIN_CODE_IDX                                        */
/*==============================================================*/
create unique index LOGIN_CODE_IDX on USER_INFO (
   LOGIN_CODE ASC
);


/*==============================================================*/
/* Table: USER_ROLE                                             */
/*==============================================================*/
create table USER_ROLE 
(
   USER_ID              INTEGER              not null,
   ROLE_ID              INTEGER              not null,
   CREATE_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP,
   CREATE_TIME          TIMESTAMP
);

comment on table USER_ROLE is
'用户角色关系';

alter table USER_ROLE
   add constraint PK_USER_ROLE primary key (USER_ID, ROLE_ID);

