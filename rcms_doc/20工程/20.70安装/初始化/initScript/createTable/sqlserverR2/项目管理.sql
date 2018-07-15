/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2017/9/8 16:19:29                            */
/*==============================================================*/


alter table PROJECT_RECOURCE_REF
   drop constraint PK_PROJECT_RECOURCE_REF
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROJECT_RECOURCE_REF')
            and   type = 'U')
   drop table PROJECT_RECOURCE_REF
go

alter table TASK
   drop constraint PK_TASK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TASK')
            and   type = 'U')
   drop table TASK
go

alter table TASK_USER_REF
   drop constraint PK_TASK_USER_REF
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TASK_USER_REF')
            and   type = 'U')
   drop table TASK_USER_REF
go

alter table WORK_LOG
   drop constraint PK_WORK_LOG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('WORK_LOG')
            and   type = 'U')
   drop table WORK_LOG
go

/*==============================================================*/
/* Table: PROJECT_RECOURCE_REF                                  */
/*==============================================================*/
create table PROJECT_RECOURCE_REF (
   PK_PROJ              bigint               not null,
   USER_ID              bigint               not null,
   CHARGE_PROJ          char(1)              null,
   CREATE_USER_ID       bigint               null,
   CREATE_TIME          datetime             null,
   MODIFY_USER_ID       bigint               null,
   UPDATE_TIME          datetime             null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1是
   0否',
   'user', @CurrentUser, 'table', 'PROJECT_RECOURCE_REF', 'column', 'CHARGE_PROJ'
go

alter table PROJECT_RECOURCE_REF
   add constraint PK_PROJECT_RECOURCE_REF primary key nonclustered (PK_PROJ, USER_ID)
go

/*==============================================================*/
/* Table: TASK                                                  */
/*==============================================================*/
create table TASK (
   PK_TASK              bigint               identity,
   PK_PROJ              bigint               not null,
   TASK_NAME            varchar(50)          not null,
   TASK_CODE            varchar(20)          not null,
   EXP_START_DATE       datetime             null,
   EXP_END_DATE         datetime             null,
   REL_END_DATE         datetime             null,
   PERCENTAGE           int                  null,
   WORKLOAD             numeric(5,1)         not null,
   TASK_TYPE            char(1)              not null,
   STATUS               char(1)              not null,
   CREATE_USER_ID       bigint               null,
   CREATE_TIME          datetime             null,
   MODIFY_USER_ID       bigint               null,
   UPDATE_TIME          datetime             null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0-100整数',
   'user', @CurrentUser, 'table', 'TASK', 'column', 'PERCENTAGE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1计划外
   2计划内
   ',
   'user', @CurrentUser, 'table', 'TASK', 'column', 'TASK_TYPE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0未开始
   1进行中
   2已完成
   3已封存
   4延误',
   'user', @CurrentUser, 'table', 'TASK', 'column', 'STATUS'
go

alter table TASK
   add constraint PK_TASK primary key nonclustered (PK_TASK)
go

/*==============================================================*/
/* Table: TASK_USER_REF                                         */
/*==============================================================*/
create table TASK_USER_REF (
   PK_TASK              bigint               not null,
   USER_ID              bigint               not null,
   REQUIRE_WORKLOAD     numeric(5,1)         not null,
   PERCENTAGE           int                  null,
   REL_END_DATE         datetime             null,
   CREATE_USER_ID       bigint               null,
   CREATE_TIME          datetime             null,
   MODIFY_USER_ID       bigint               null,
   UPDATE_TIME          datetime             null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0-100整数',
   'user', @CurrentUser, 'table', 'TASK_USER_REF', 'column', 'PERCENTAGE'
go

alter table TASK_USER_REF
   add constraint PK_TASK_USER_REF primary key nonclustered (PK_TASK, USER_ID)
go

/*==============================================================*/
/* Table: WORK_LOG                                              */
/*==============================================================*/
create table WORK_LOG (
   PK_WORK_LOG          bigint               identity,
   PK_TASK              bigint               not null,
   USER_ID              bigint               not null,
   WORK_TIME            numeric(3,1)         not null,
   OVER_WORK_TIME       numeric(3,1)         not null,
   OVER_WORK_REASON     varchar(200)         null,
   WORK_DESC            varchar(2000)        not null,
   PERCENTAGE           int                  null,
   LOG_DATE             datetime             null,
   IS_VERFIED           char(1)              null,
   PM_ID                bigint               null,
   VERSION              int                  null,
   CREATE_USER_ID       bigint               null,
   CREATE_TIME          datetime             null,
   MODIFY_USER_ID       bigint               null,
   UPDATE_TIME          datetime             null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0-100整数',
   'user', @CurrentUser, 'table', 'WORK_LOG', 'column', 'PERCENTAGE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '年月日',
   'user', @CurrentUser, 'table', 'WORK_LOG', 'column', 'LOG_DATE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0未审核1审核。默认0',
   'user', @CurrentUser, 'table', 'WORK_LOG', 'column', 'IS_VERFIED'
go

alter table WORK_LOG
   add constraint PK_WORK_LOG primary key nonclustered (PK_WORK_LOG)
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PROJECT_RPT_WEEKLY')
            and   name  = 'PROJ_WEEK_IDX'
            and   indid > 0
            and   indid < 255)
   drop index PROJECT_RPT_WEEKLY.PROJ_WEEK_IDX
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROJECT_RPT_WEEKLY')
            and   type = 'U')
   drop table PROJECT_RPT_WEEKLY
go

/*==============================================================*/
/* Table: PROJECT_RPT_WEEKLY                                    */
/*==============================================================*/
create table PROJECT_RPT_WEEKLY (
   PRO_RPT_ID           bigint               identity,
   PK_PROJ              bigint               not null,
   WEEK_BEGIN_DATE      datetime             not null,
   WEEK_END_DATE        datetime             not null,
   MILE_POST            nvarchar(Max)        null,
   CUR_RPT              nvarchar(Max)        null,
   CUR_RISK             nvarchar(Max)        null,
   NEXT_RPT             nvarchar(Max)        null,
   STATUS               char(1)              not null,
   APPROVAL_OPINIONS    varchar(1000)        null,
   APPROVAL_USER_ID     bigint               null,
   APPROVAL_TIME        datetime             null,
   CREATE_USER_ID       bigint               not null,
   CREATE_TIME          datetime             not null,
   MODIFY_USER_ID       bigint               null,
   UPDATE_TIME          datetime             null
)
go

alter table PROJECT_RPT_WEEKLY
   add constraint PK_PROJECT_RPT_WEEKLY primary key (PRO_RPT_ID)
go

/*==============================================================*/
/* Index: PROJ_WEEK_IDX                                         */
/*==============================================================*/
create unique index PROJ_WEEK_IDX on PROJECT_RPT_WEEKLY (
PK_PROJ ASC,
WEEK_BEGIN_DATE ASC
)
go


if exists (select 1
            from  sysobjects
           where  id = object_id('RPT_WEEKLY_APPROVAL_OPINIONS')
            and   type = 'U')
   drop table RPT_WEEKLY_APPROVAL_OPINIONS
go

/*==============================================================*/
/* Table: RPT_WEEKLY_APPROVAL_OPINIONS                          */
/*==============================================================*/
create table RPT_WEEKLY_APPROVAL_OPINIONS (
   PRO_RPT_ID           bigint               not null,
   STATUS               char(1)              null,
   APPROVAL_OPINIONS    varchar(1000)        null,
   CREATE_TIME          datetime             null,
   CREATE_USER_ID       bigint               not null,
   VERSION              int                  not null
)
go

alter table RPT_WEEKLY_APPROVAL_OPINIONS
   add constraint PK_RPT_WEEKLY_APPROVAL_OPINION primary key (PRO_RPT_ID, VERSION)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('V_USER_PROJECT')
            and   type = 'V')
   drop view V_USER_PROJECT
go
