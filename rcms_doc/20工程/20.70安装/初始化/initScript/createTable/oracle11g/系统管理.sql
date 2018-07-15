/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2017/7/11 星期二 下午 8:36:26                     */
/*==============================================================*/


alter table BD_DICT
   drop primary key cascade;

drop table BD_DICT cascade constraints;

alter table BD_DICT_DETAIL
   drop primary key cascade;

drop table BD_DICT_DETAIL cascade constraints;

alter table PROJECT_LEVEL_DICT
   drop primary key cascade;

drop table PROJECT_LEVEL_DICT cascade constraints;

alter table PROJECT_TYPE_DICT
   drop primary key cascade;

drop table PROJECT_TYPE_DICT cascade constraints;

alter table PROJECT_URGENT_DICT
   drop primary key cascade;

drop table PROJECT_URGENT_DICT cascade constraints;

alter table SYS_LOGIN_LOG
   drop primary key cascade;

drop table SYS_LOGIN_LOG cascade constraints;

alter table SYS_OPERATION_LOG
   drop primary key cascade;

drop table SYS_OPERATION_LOG cascade constraints;

drop sequence BD_DICT_DETAIL_ID_SEQ;

drop sequence PROJECT_LEVEL_DICT_ID_SEQ;

drop sequence PROJECT_TYPE_DICT_ID_SEQ;

drop sequence PROJECT_URGENT_DICT_ID_SEQ;

drop sequence SYS_LOGIN_LOG_ID_SEQ;

drop sequence SYS_OPERATION_LOG_ID_SEQ;

create sequence BD_DICT_DETAIL_ID_SEQ
increment by 1
start with 1
 maxvalue 999999999999
 minvalue 1;

create sequence PROJECT_LEVEL_DICT_ID_SEQ
increment by 1
start with 1
 maxvalue 999999999999
 minvalue 1;

create sequence PROJECT_TYPE_DICT_ID_SEQ
increment by 1
start with 1
 maxvalue 999999999999
 minvalue 1;

create sequence PROJECT_URGENT_DICT_ID_SEQ
increment by 1
start with 1
 maxvalue 999999999999
 minvalue 1;

create sequence SYS_LOGIN_LOG_ID_SEQ
increment by 1
start with 1
 maxvalue 999999999999
 minvalue 1;

create sequence SYS_OPERATION_LOG_ID_SEQ
increment by 1
start with 1
 maxvalue 999999999999
 minvalue 1;

/*==============================================================*/
/* Table: BD_DICT                                               */
/*==============================================================*/
create table BD_DICT 
(
   PK_DICT              NUMBER(6)            not null,
   DICT_CODE            VARCHAR2(100)        not null,
   DICT_NAME            VARCHAR2(100),
   FLAG                 CHAR(1),
   VERSION              INTEGER,
   CREATE_USER_ID       NUMBER(10,0),
   CREATE_TIME          TIMESTAMP,
   MODIFY_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP
);

comment on table BD_DICT is
'字典类型表';

comment on column BD_DICT.PK_DICT is
'字典类型代码';

comment on column BD_DICT.DICT_CODE is
'字典类型名称';

comment on column BD_DICT.FLAG is
'0封存1可用';

alter table BD_DICT
   add constraint PK_BD_DICT primary key (PK_DICT);

/*==============================================================*/
/* Table: BD_DICT_DETAIL                                        */
/*==============================================================*/
create table BD_DICT_DETAIL 
(
   PK_DETAIL            NUMBER(6)            not null,
   PK_DICT              INTEGER              not null,
   DETAIL_CODE          VARCHAR2(100)        not null,
   DETAIL_NAME          VARCHAR2(100)        not null,
   FLAG                 CHAR(1),
   VERSION              INTEGER,
   CREATE_USER_ID       NUMBER(10,0),
   CREATE_TIME          TIMESTAMP,
   MODIFY_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP
);

comment on table BD_DICT_DETAIL is
'字典详细表';

comment on column BD_DICT_DETAIL.PK_DETAIL is
'字典类型代码';

comment on column BD_DICT_DETAIL.PK_DICT is
'字典代码';

comment on column BD_DICT_DETAIL.DETAIL_CODE is
'字典名称';

comment on column BD_DICT_DETAIL.DETAIL_NAME is
'序号';

comment on column BD_DICT_DETAIL.FLAG is
'0封存1可用';

alter table BD_DICT_DETAIL
   add constraint PK_BD_DICT_DETAIL primary key (PK_DETAIL);

/*==============================================================*/
/* Table: PROJECT_LEVEL_DICT                                    */
/*==============================================================*/
create table PROJECT_LEVEL_DICT 
(
   LEVEL_ID             INTEGER              not null,
   LEVEL_NAME           VARCHAR2(30)         not null,
   FLAG                 CHAR(1),
   VERSION              INTEGER,
   CREATE_USER_ID       INTEGER,
   CREATE_TIME          TIMESTAMP,
   MODIFY_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP
);

comment on table PROJECT_LEVEL_DICT is
'项目级别字典表';

comment on column PROJECT_LEVEL_DICT.LEVEL_ID is
'字典类型代码';

comment on column PROJECT_LEVEL_DICT.LEVEL_NAME is
'字典类型名称';

comment on column PROJECT_LEVEL_DICT.FLAG is
'0封存1可用';

alter table PROJECT_LEVEL_DICT
   add constraint PK_PROJECT_LEVEL_DICT primary key (LEVEL_ID);

/*==============================================================*/
/* Table: PROJECT_TYPE_DICT                                     */
/*==============================================================*/
create table PROJECT_TYPE_DICT 
(
   TYPE_ID              INTEGER              not null,
   TYPE_CODE            CHAR(3)              not null,
   TYPE_NAME            VARCHAR2(30)         not null,
   FLAG                 CHAR(1),
   VERSION              INTEGER,
   CREATE_USER_ID       INTEGER,
   CREATE_TIME          TIMESTAMP,
   MODIFY_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP
);

comment on table PROJECT_TYPE_DICT is
'项目类型字典表';

comment on column PROJECT_TYPE_DICT.TYPE_ID is
'字典类型代码';

comment on column PROJECT_TYPE_DICT.TYPE_CODE is
'管理服务类	MGR
驻场开发类	LOC
委托开发类	COM
产品类	PRO
研发类	DEV
销售类	SLS
拓展类	EXP
运营类	OPR
';

comment on column PROJECT_TYPE_DICT.TYPE_NAME is
'字典类型名称';

comment on column PROJECT_TYPE_DICT.FLAG is
'0封存1可用';

alter table PROJECT_TYPE_DICT
   add constraint PK_PROJECT_TYPE_DICT primary key (TYPE_ID);

/*==============================================================*/
/* Table: PROJECT_URGENT_DICT                                   */
/*==============================================================*/
create table PROJECT_URGENT_DICT 
(
   URGENT_ID            INTEGER              not null,
   URGENT_NAME          VARCHAR2(30)         not null,
   FLAG                 CHAR(1),
   VERSION              INTEGER,
   CREATE_USER_ID       INTEGER,
   CREATE_TIME          TIMESTAMP,
   MODIFY_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP
);

comment on table PROJECT_URGENT_DICT is
'项目紧急程度字典表';

comment on column PROJECT_URGENT_DICT.URGENT_ID is
'字典类型代码';

comment on column PROJECT_URGENT_DICT.URGENT_NAME is
'字典类型名称';

comment on column PROJECT_URGENT_DICT.FLAG is
'0封存1可用';

alter table PROJECT_URGENT_DICT
   add constraint PK_PROJECT_URGENT_DICT primary key (URGENT_ID);

/*==============================================================*/
/* Table: SYS_LOGIN_LOG                                         */
/*==============================================================*/
create table SYS_LOGIN_LOG 
(
   PK_LOGIN             NUMBER(6)            not null,
   USER_ID              INTEGER              not null,
   LOGIN_TYPE           CHAR(1)              not null,
   LOGIN_CODE           VARCHAR(30)          not null,
   USER_NAME            VARCHAR2(30)         not null,
   IP                   VARCHAR2(20)         not null,
   CREATE_TIME          TIMESTAMP
);

comment on column SYS_LOGIN_LOG.LOGIN_TYPE is
'1:前台登录
2:后台登陆';

alter table SYS_LOGIN_LOG
   add constraint PK_SYS_LOGIN_LOG primary key (PK_LOGIN);

/*==============================================================*/
/* Table: SYS_OPERATION_LOG                                     */
/*==============================================================*/
create table SYS_OPERATION_LOG 
(
   LOG_ID               NUMBER(6)            not null,
   LOG_CONTENT          VARCHAR2(2000),
   LOG_MODULE           VARCHAR2(1000),
   DETAIL               VARCHAR2(1000),
   CREATE_USER_ID       NUMBER(10,0),
   OPERATOR_IP          VARCHAR2(20),
   OPERATE_DATA         VARCHAR2(1000),
   CREATE_TIME          TIMESTAMP
);

comment on table SYS_OPERATION_LOG is
'系统日志';

comment on column SYS_OPERATION_LOG.LOG_ID is
'网站异常日志ID';

comment on column SYS_OPERATION_LOG.LOG_CONTENT is
'异常内容';

comment on column SYS_OPERATION_LOG.LOG_MODULE is
'异常模块';

comment on column SYS_OPERATION_LOG.CREATE_USER_ID is
'操作人';

comment on column SYS_OPERATION_LOG.OPERATE_DATA is
'操作数据';

comment on column SYS_OPERATION_LOG.CREATE_TIME is
'操作时间';

alter table SYS_OPERATION_LOG
   add constraint PK_SYS_OPERATION_LOG primary key (LOG_ID);

