/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2017/9/8 16:19:56                            */
/*==============================================================*/


alter table PROJECT
   drop constraint PK_PROJECT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROJECT')
            and   type = 'U')
   drop table PROJECT
go

alter table PROJECT_HIS
   drop constraint PK_PROJECT_HIS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROJECT_HIS')
            and   type = 'U')
   drop table PROJECT_HIS
go

/*==============================================================*/
/* Table: PROJECT                                               */
/*==============================================================*/
create table PROJECT (
   PK_PROJ              bigint               identity,
   PROJ_CODE            varchar(20)          not null,
   PROJ_NAME            varchar(60)          not null,
   PROJ_SH_NAME         varchar(20)          not null,
   PROJ_TYPE            char(3)              not null,
   PROJ_LEVEL           int                  not null,
   STATUS               char(2)              null,
   APPLY_DATE           datetime             null,
   DEPT_ID              bigint               null,
   BUDGET_SOURCE        varchar(30)          null,
   EXP_SALE_AMOUNT      decimal(10,2)        null,
   EXP_START_DATE       datetime             null,
   EXP_END_DATE         datetime             null,
   REL_START_DATE       datetime             null,
   REL_END_DATE         datetime             null,
   PM_ID                bigint               null,
   REMARK               int                  null,
   URGENT_LEVEL         int                  null,
   WORKLOAD             decimal(10,2)        null,
   EXP_COST             decimal(10,2)        null,
   PROJECT_EXP          varchar(100)         null,
   DELIVERY_DESC        varchar(100)         null,
   FEASIBILITY_REPORT   varchar(100)         null,
   INCLUDE_TECH         varchar(100)         null,
   RISK_DESC            varchar(100)         null,
   CLIENT_NAMES         varchar(100)         null,
   PROJ_DESC            varchar(100)         null,
   PROJ_END_DATE        datetime             null,
   PROJ_END_DESC        varchar(100)         null,
   CHARGE_MAN           bigint               null,
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
   '01С����Ŀ
   02������Ŀ
   03������Ŀ
   04�ش�����Ŀ',
   'user', @CurrentUser, 'table', 'PROJECT', 'column', 'PROJ_LEVEL'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '01δ����
   02��������
   03��������
   04���۽���
   05��������
   06����',
   'user', @CurrentUser, 'table', 'PROJECT', 'column', 'STATUS'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '(��ͬ����)',
   'user', @CurrentUser, 'table', 'PROJECT', 'column', 'EXP_SALE_AMOUNT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '004001���䡢004002��⡢004003Ӧ�á�004004������004005�ۺ�
   004006����
   ',
   'user', @CurrentUser, 'table', 'PROJECT', 'column', 'REL_START_DATE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '01һ��
   02����
   03����',
   'user', @CurrentUser, 'table', 'PROJECT', 'column', 'URGENT_LEVEL'
go

alter table PROJECT
   add constraint PK_PROJECT primary key nonclustered (PK_PROJ)
go

/*==============================================================*/
/* Table: PROJECT_HIS                                           */
/*==============================================================*/
create table PROJECT_HIS (
   PK_PROJ              bigint               not null,
   PROJ_CODE            varchar(20)          not null,
   PROJ_NAME            varchar(60)          not null,
   PROJ_SH_NAME         varchar(20)          not null,
   PROJ_TYPE            char(3)              not null,
   PROJ_LEVEL           int                  not null,
   STATUS               char(2)              null,
   APPLY_DATE           datetime             null,
   DEPT_ID              bigint               null,
   BUDGET_SOURCE        varchar(30)          null,
   EXP_SALE_AMOUNT      decimal(10,2)        null,
   EXP_START_DATE       datetime             null,
   EXP_END_DATE         datetime             null,
   REL_START_DATE       datetime             null,
   REL_END_DATE         datetime             null,
   PM_ID                bigint               null,
   REMARK               int                  null,
   URGENT_LEVEL         int                  null,
   WORKLOAD             decimal(10,2)        null,
   EXP_COST             decimal(10,2)        null,
   PROJECT_EXP          varchar(100)         null,
   DELIVERY_DESC        varchar(100)         null,
   FEASIBILITY_REPORT   varchar(100)         null,
   INCLUDE_TECH         varchar(100)         null,
   RISK_DESC            varchar(100)         null,
   CLIENT_NAMES         varchar(100)         null,
   PROJ_DESC            varchar(100)         null,
   PROJ_END_DATE        datetime             null,
   PROJ_END_DESC        varchar(100)         null,
   CHARGE_MAN           bigint               null,
   VERSION              int                  not null,
   CREATE_USER_ID       bigint               null,
   CREATE_TIME          datetime             null,
   MODIFY_USER_ID       bigint               null,
   UPDATE_TIME          datetime             null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '01С����Ŀ
   02������Ŀ
   03������Ŀ
   04�ش�����Ŀ',
   'user', @CurrentUser, 'table', 'PROJECT_HIS', 'column', 'PROJ_LEVEL'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '01δ����
   02��������
   03��������
   04���۽���
   05��������
   06����',
   'user', @CurrentUser, 'table', 'PROJECT_HIS', 'column', 'STATUS'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '(��ͬ����)',
   'user', @CurrentUser, 'table', 'PROJECT_HIS', 'column', 'EXP_SALE_AMOUNT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '004001���䡢004002��⡢004003Ӧ�á�004004������004005�ۺ�
   004006����
   ',
   'user', @CurrentUser, 'table', 'PROJECT_HIS', 'column', 'REL_START_DATE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '01һ��
   02����
   03����',
   'user', @CurrentUser, 'table', 'PROJECT_HIS', 'column', 'URGENT_LEVEL'
go

alter table PROJECT_HIS
   add constraint PK_PROJECT_HIS primary key nonclustered (PK_PROJ, VERSION)
go

