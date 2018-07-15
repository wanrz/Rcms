/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2017/9/13 10:44:38                           */
/*==============================================================*/


alter table BD_DICT
   drop constraint PK_BD_DICT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BD_DICT')
            and   type = 'U')
   drop table BD_DICT
go

alter table BD_DICT_DETAIL
   drop constraint PK_BD_DICT_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BD_DICT_DETAIL')
            and   type = 'U')
   drop table BD_DICT_DETAIL
go

alter table PROJECT_LEVEL_DICT
   drop constraint PK_PROJECT_LEVEL_DICT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROJECT_LEVEL_DICT')
            and   type = 'U')
   drop table PROJECT_LEVEL_DICT
go

alter table PROJECT_TYPE_DICT
   drop constraint PK_PROJECT_TYPE_DICT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROJECT_TYPE_DICT')
            and   type = 'U')
   drop table PROJECT_TYPE_DICT
go

alter table PROJECT_URGENT_DICT
   drop constraint PK_PROJECT_URGENT_DICT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROJECT_URGENT_DICT')
            and   type = 'U')
   drop table PROJECT_URGENT_DICT
go

alter table SYS_LOGIN_LOG
   drop constraint PK_SYS_LOGIN_LOG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_LOGIN_LOG')
            and   type = 'U')
   drop table SYS_LOGIN_LOG
go

alter table SYS_OPERATION_LOG
   drop constraint PK_SYS_OPERATION_LOG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_OPERATION_LOG')
            and   type = 'U')
   drop table SYS_OPERATION_LOG
go

/*==============================================================*/
/* Table: BD_DICT                                               */
/*==============================================================*/
create table BD_DICT (
   PK_DICT              bigint               not null,
   DICT_CODE            varchar(100)         not null,
   DICT_NAME            varchar(100)         null,
   FLAG                 char(1)              null,
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
   '字典类型表',
   'user', @CurrentUser, 'table', 'BD_DICT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典类型代码',
   'user', @CurrentUser, 'table', 'BD_DICT', 'column', 'PK_DICT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典类型名称',
   'user', @CurrentUser, 'table', 'BD_DICT', 'column', 'DICT_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0封存1可用',
   'user', @CurrentUser, 'table', 'BD_DICT', 'column', 'FLAG'
go

alter table BD_DICT
   add constraint PK_BD_DICT primary key nonclustered (PK_DICT)
go

/*==============================================================*/
/* Table: BD_DICT_DETAIL                                        */
/*==============================================================*/
create table BD_DICT_DETAIL (
   PK_DETAIL            bigint               identity,
   PK_DICT              bigint               not null,
   DETAIL_CODE          varchar(100)         not null,
   DETAIL_NAME          varchar(100)         not null,
   FLAG                 char(1)              null,
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
   '字典详细表',
   'user', @CurrentUser, 'table', 'BD_DICT_DETAIL'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典类型代码',
   'user', @CurrentUser, 'table', 'BD_DICT_DETAIL', 'column', 'PK_DETAIL'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典代码',
   'user', @CurrentUser, 'table', 'BD_DICT_DETAIL', 'column', 'PK_DICT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典名称',
   'user', @CurrentUser, 'table', 'BD_DICT_DETAIL', 'column', 'DETAIL_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '序号',
   'user', @CurrentUser, 'table', 'BD_DICT_DETAIL', 'column', 'DETAIL_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0封存1可用',
   'user', @CurrentUser, 'table', 'BD_DICT_DETAIL', 'column', 'FLAG'
go

alter table BD_DICT_DETAIL
   add constraint PK_BD_DICT_DETAIL primary key nonclustered (PK_DETAIL)
go

/*==============================================================*/
/* Table: PROJECT_LEVEL_DICT                                    */
/*==============================================================*/
create table PROJECT_LEVEL_DICT (
   LEVEL_ID             bigint               identity,
   LEVEL_NAME           varchar(30)          not null,
   FLAG                 char(1)              null,
   VERSION              int                  null,
   CREATE_USER_ID       int                  null,
   CREATE_TIME          datetime             null,
   MODIFY_USER_ID       int                  null,
   UPDATE_TIME          datetime             null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '项目级别字典表',
   'user', @CurrentUser, 'table', 'PROJECT_LEVEL_DICT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典类型代码',
   'user', @CurrentUser, 'table', 'PROJECT_LEVEL_DICT', 'column', 'LEVEL_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典类型名称',
   'user', @CurrentUser, 'table', 'PROJECT_LEVEL_DICT', 'column', 'LEVEL_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0封存1可用',
   'user', @CurrentUser, 'table', 'PROJECT_LEVEL_DICT', 'column', 'FLAG'
go

alter table PROJECT_LEVEL_DICT
   add constraint PK_PROJECT_LEVEL_DICT primary key nonclustered (LEVEL_ID)
go

/*==============================================================*/
/* Table: PROJECT_TYPE_DICT                                     */
/*==============================================================*/
create table PROJECT_TYPE_DICT (
   TYPE_ID              bigint               identity,
   TYPE_CODE            char(3)              not null,
   TYPE_NAME            varchar(30)          not null,
   FLAG                 char(1)              null,
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
   '项目类型字典表',
   'user', @CurrentUser, 'table', 'PROJECT_TYPE_DICT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典类型代码',
   'user', @CurrentUser, 'table', 'PROJECT_TYPE_DICT', 'column', 'TYPE_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '管理服务类	MGR
   驻场开发类	LOC
   委托开发类	COM
   产品类	PRO
   研发类	DEV
   销售类	SLS
   拓展类	EXP
   运营类	OPR
   ',
   'user', @CurrentUser, 'table', 'PROJECT_TYPE_DICT', 'column', 'TYPE_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典类型名称',
   'user', @CurrentUser, 'table', 'PROJECT_TYPE_DICT', 'column', 'TYPE_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0封存1可用',
   'user', @CurrentUser, 'table', 'PROJECT_TYPE_DICT', 'column', 'FLAG'
go

alter table PROJECT_TYPE_DICT
   add constraint PK_PROJECT_TYPE_DICT primary key nonclustered (TYPE_ID)
go

/*==============================================================*/
/* Table: PROJECT_URGENT_DICT                                   */
/*==============================================================*/
create table PROJECT_URGENT_DICT (
   URGENT_ID            int                  identity,
   URGENT_NAME          varchar(30)          not null,
   FLAG                 char(1)              null,
   VERSION              int                  null,
   CREATE_USER_ID       int                  null,
   CREATE_TIME          datetime             null,
   MODIFY_USER_ID       int                  null,
   UPDATE_TIME          datetime             null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '项目紧急程度字典表',
   'user', @CurrentUser, 'table', 'PROJECT_URGENT_DICT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典类型代码',
   'user', @CurrentUser, 'table', 'PROJECT_URGENT_DICT', 'column', 'URGENT_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典类型名称',
   'user', @CurrentUser, 'table', 'PROJECT_URGENT_DICT', 'column', 'URGENT_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0封存1可用',
   'user', @CurrentUser, 'table', 'PROJECT_URGENT_DICT', 'column', 'FLAG'
go

alter table PROJECT_URGENT_DICT
   add constraint PK_PROJECT_URGENT_DICT primary key nonclustered (URGENT_ID)
go

/*==============================================================*/
/* Table: SYS_LOGIN_LOG                                         */
/*==============================================================*/
create table SYS_LOGIN_LOG (
   PK_LOGIN             bigint               identity,
   USER_ID              bigint               not null,
   LOGIN_TYPE           char(1)              not null,
   LOGIN_CODE           varchar(30)          not null,
   USER_NAME            varchar(30)          not null,
   IP                   varchar(20)          not null,
   CREATE_TIME          datetime             null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1:前台登录
   2:后台登陆',
   'user', @CurrentUser, 'table', 'SYS_LOGIN_LOG', 'column', 'LOGIN_TYPE'
go

alter table SYS_LOGIN_LOG
   add constraint PK_SYS_LOGIN_LOG primary key nonclustered (PK_LOGIN)
go

/*==============================================================*/
/* Table: SYS_OPERATION_LOG                                     */
/*==============================================================*/
create table SYS_OPERATION_LOG (
   LOG_ID               bigint               identity,
   LOG_CONTENT          varchar(2000)        null,
   LOG_MODULE           varchar(1000)        null,
   DETAIL               varchar(1000)        null,
   CREATE_USER_ID       bigint               null,
   OPERATOR_IP          varchar(20)          null,
   OPERATE_DATA         varchar(1000)        null,
   CREATE_TIME          datetime             null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '系统日志',
   'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '网站异常日志ID',
   'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'LOG_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '异常内容',
   'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'LOG_CONTENT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '异常模块',
   'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'LOG_MODULE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作人',
   'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'CREATE_USER_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作数据',
   'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'OPERATE_DATA'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作时间',
   'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'CREATE_TIME'
go

alter table SYS_OPERATION_LOG
   add constraint PK_SYS_OPERATION_LOG primary key nonclustered (LOG_ID)
go

