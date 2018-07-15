/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2017/7/11 星期二 下午 8:35:30                     */
/*==============================================================*/


alter table PROJECT_RECOURCE_REF
   drop primary key cascade;

drop table PROJECT_RECOURCE_REF cascade constraints;

alter table TASK
   drop primary key cascade;

drop table TASK cascade constraints;

alter table TASK_USER_REF
   drop primary key cascade;

drop table TASK_USER_REF cascade constraints;

alter table WORK_LOG
   drop primary key cascade;

drop table WORK_LOG cascade constraints;

drop sequence TASK_CODE_SEQ;

drop sequence TASK_ID_SEQ;

drop sequence WORK_LOG_ID_SEQ;

create sequence TASK_CODE_SEQ
increment by 1
start with 2
 maxvalue 9999999
 minvalue 1
 cache 1000;

create sequence TASK_ID_SEQ
increment by 1
start with 2
 maxvalue 999999999999
 minvalue 1
 cache 1000;

create sequence WORK_LOG_ID_SEQ
increment by 1
start with 2
 maxvalue 999999999999
 minvalue 1
 cache 1000;

/*==============================================================*/
/* Table: PROJECT_RECOURCE_REF                                  */
/*==============================================================*/
create table PROJECT_RECOURCE_REF 
(
   PK_PROJ              INTEGER              not null,
   USER_ID              INTEGER              not null,
   CHARGE_PROJ          CHAR(1),
   CREATE_USER_ID       INTEGER,
   CREATE_TIME          TIMESTAMP,
   MODIFY_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP
);

comment on column PROJECT_RECOURCE_REF.CHARGE_PROJ is
'1是
0否';

alter table PROJECT_RECOURCE_REF
   add constraint PK_PROJECT_RECOURCE_REF primary key (PK_PROJ, USER_ID);

/*==============================================================*/
/* Table: TASK                                                  */
/*==============================================================*/
create table TASK 
(
   PK_TASK              INTEGER              not null,
   PK_PROJ              INTEGER              not null,
   TASK_NAME            VARCHAR2(50)         not null,
   TASK_CODE            VARCHAR(20)          not null,
   EXP_START_DATE       DATE,
   EXP_END_DATE         DATE,
   REL_END_DATE         DATE,
   PERCENTAGE           INTEGER,
   WORKLOAD             NUMBER(5,1)          not null,
   TASK_TYPE            CHAR(1)              not null,
   STATUS               CHAR(1)              not null,
   CREATE_USER_ID       INTEGER,
   CREATE_TIME          TIMESTAMP,
   MODIFY_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP
);

comment on column TASK.PERCENTAGE is
'0-100整数';

comment on column TASK.TASK_TYPE is
'1计划外
2计划内
';

comment on column TASK.STATUS is
'0未开始
1进行中
2已完成
3已封存
4延误';

alter table TASK
   add constraint PK_TASK primary key (PK_TASK);

/*==============================================================*/
/* Table: TASK_USER_REF                                         */
/*==============================================================*/
create table TASK_USER_REF 
(
   PK_TASK              INTEGER              not null,
   USER_ID              INTEGER              not null,
   REQUIRE_WORKLOAD     NUMBER(5,1)          not null,
   PERCENTAGE           INTEGER,
   REL_END_DATE         DATE,
   CREATE_USER_ID       INTEGER,
   CREATE_TIME          TIMESTAMP,
   MODIFY_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP
);

comment on column TASK_USER_REF.PERCENTAGE is
'0-100整数';

alter table TASK_USER_REF
   add constraint PK_TASK_USER_REF primary key (PK_TASK, USER_ID);

/*==============================================================*/
/* Table: WORK_LOG                                              */
/*==============================================================*/
create table WORK_LOG 
(
   PK_WORK_LOG          INTEGER              not null,
   PK_TASK              INTEGER              not null,
   USER_ID              INTEGER              not null,
   WORK_TIME            NUMBER(3,1)          not null,
   OVER_WORK_TIME       NUMBER(3,1)          not null,
   WORK_DESC            VARCHAR(2000)        not null,
   PERCENTAGE           INTEGER,
   LOG_DATE             DATE,
   VERSION              INT,
   CREATE_USER_ID       INTEGER,
   CREATE_TIME          TIMESTAMP,
   MODIFY_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP
);

comment on column WORK_LOG.PERCENTAGE is
'0-100整数';

comment on column WORK_LOG.LOG_DATE is
'年月日';

alter table WORK_LOG
   add constraint PK_WORK_LOG primary key (PK_WORK_LOG);

