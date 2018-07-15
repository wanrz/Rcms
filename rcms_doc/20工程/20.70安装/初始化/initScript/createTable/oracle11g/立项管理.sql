/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2017/7/11 星期二 下午 8:35:05                     */
/*==============================================================*/


alter table PROJECT
   drop primary key cascade;

drop table PROJECT cascade constraints;

alter table PROJECT_HIS
   drop primary key cascade;

drop table PROJECT_HIS cascade constraints;

drop sequence PROJECT_ID_SEQ;

create sequence PROJECT_ID_SEQ
increment by 1
start with 2
 maxvalue 999999999999
 minvalue 1
 cache 1000;

/*==============================================================*/
/* Table: PROJECT                                               */
/*==============================================================*/
create table PROJECT 
(
   PK_PROJ              INTEGER              not null,
   PROJ_CODE            VARCHAR(20)          not null,
   PROJ_NAME            VARCHAR2(60)         not null,
   PROJ_SH_NAME         VARCHAR(20)          not null,
   PROJ_TYPE            CHAR(3)              not null,
   PROJ_LEVEL           INTEGER              not null,
   STATUS               CHAR(2),
   APPLY_DATE           DATE,
   DEPT_ID              INT,
   BUDGET_SOURCE        VARCHAR2(30),
   EXP_SALE_AMOUNT      DECIMAL(10, 2),
   EXP_START_DATE       DATE,
   EXP_END_DATE         DATE,
   REL_START_DATE       DATE,
   REL_END_DATE         DATE,
   PM_ID                INTEGER,
   REMARK               INT,
   URGENT_LEVEL         INTEGER,
   WORKLOAD             INTEGER,
   EXP_COST             DECIMAL(10, 2),
   PROJECT_EXP          VARCHAR2(100),
   DELIVERY_DESC        VARCHAR2(100),
   FEASIBILITY_REPORT   VARCHAR2(100),
   INCLUDE_TECH         VARCHAR2(100),
   RISK_DESC            VARCHAR2(100),
   CLIENT_NAMES         VARCHAR2(100),
   PROJ_DESC            VARCHAR2(100),
   PROJ_END_DATE        DATE,
   PROJ_END_DESC        VARCHAR2(100),
   CHARGE_MAN           INTEGER,
   VERSION              INT,
   CREATE_USER_ID       INTEGER,
   CREATE_TIME          TIMESTAMP,
   MODIFY_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP
);

comment on column PROJECT.PROJ_LEVEL is
'01小型项目
02中型项目
03大型项目
04特大型项目';

comment on column PROJECT.STATUS is
'01未立项
02立项审批
03开发进行
04销售进行
05方案评审
06结项';

comment on column PROJECT.EXP_SALE_AMOUNT is
'(合同金额：万)';

comment on column PROJECT.REL_START_DATE is
'004001记忆、004002理解、004003应用、004004分析、004005综合
004006评价
';

comment on column PROJECT.URGENT_LEVEL is
'01一般
02紧急
03持续';

alter table PROJECT
   add constraint PK_PROJECT primary key (PK_PROJ);

/*==============================================================*/
/* Table: PROJECT_HIS                                           */
/*==============================================================*/
create table PROJECT_HIS 
(
   PK_PROJ              INTEGER              not null,
   PROJ_CODE            VARCHAR(20)          not null,
   PROJ_NAME            VARCHAR2(60)         not null,
   PROJ_SH_NAME         VARCHAR(20)          not null,
   PROJ_TYPE            CHAR(3)              not null,
   PROJ_LEVEL           INTEGER              not null,
   STATUS               CHAR(2),
   APPLY_DATE           DATE,
   DEPT_ID              INT,
   BUDGET_SOURCE        VARCHAR2(30),
   EXP_SALE_AMOUNT      DECIMAL(10, 2),
   EXP_START_DATE       DATE,
   EXP_END_DATE         DATE,
   REL_START_DATE       DATE,
   REL_END_DATE         DATE,
   PM_ID                INTEGER,
   REMARK               INT,
   URGENT_LEVEL         INTEGER,
   WORKLOAD             INTEGER,
   EXP_COST             DECIMAL(10, 2),
   PROJECT_EXP          VARCHAR2(100),
   DELIVERY_DESC        VARCHAR2(100),
   FEASIBILITY_REPORT   VARCHAR2(100),
   INCLUDE_TECH         VARCHAR2(100),
   RISK_DESC            VARCHAR2(100),
   CLIENT_NAMES         VARCHAR2(100),
   PROJ_DESC            VARCHAR2(100),
   PROJ_END_DATE        DATE,
   PROJ_END_DESC        VARCHAR2(100),
   CHARGE_MAN           INTEGER,
   VERSION              INT                  not null,
   CREATE_USER_ID       INTEGER,
   CREATE_TIME          TIMESTAMP,
   MODIFY_USER_ID       INTEGER,
   UPDATE_TIME          TIMESTAMP
);

comment on column PROJECT_HIS.PROJ_LEVEL is
'01小型项目
02中型项目
03大型项目
04特大型项目';

comment on column PROJECT_HIS.STATUS is
'01未立项
02立项审批
03开发进行
04销售进行
05方案评审
06结项';

comment on column PROJECT_HIS.EXP_SALE_AMOUNT is
'(合同金额：万)';

comment on column PROJECT_HIS.REL_START_DATE is
'004001记忆、004002理解、004003应用、004004分析、004005综合
004006评价
';

comment on column PROJECT_HIS.URGENT_LEVEL is
'01一般
02紧急
03持续';

alter table PROJECT_HIS
   add constraint PK_PROJECT_HIS primary key (PK_PROJ, VERSION);

