/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2017/9/12 11:06:22                           */
/*==============================================================*/


if exists (select 1
            from  sysobjects
           where  id = object_id('USER_DEPT_PROJECT')
            and   type = 'V')
   drop view USER_DEPT_PROJECT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('V_USER_ROLE_DATA')
            and   type = 'V')
   drop view V_USER_ROLE_DATA
go

alter table AUTH_ATTRIBUTE
   drop constraint PK_AUTH_ATTRIBUTE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AUTH_ATTRIBUTE')
            and   type = 'U')
   drop table AUTH_ATTRIBUTE
go

alter table AUTH_ATTR_ACTION
   drop constraint PK_AUTH_ATTR_ACTION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AUTH_ATTR_ACTION')
            and   type = 'U')
   drop table AUTH_ATTR_ACTION
go

alter table AUTH_DIR
   drop constraint PK_AUTH_DIR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AUTH_DIR')
            and   type = 'U')
   drop table AUTH_DIR
go

alter table AUTH_MENU
   drop constraint PK_AUTH_MENU
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AUTH_MENU')
            and   type = 'U')
   drop table AUTH_MENU
go

alter table AUTH_ROLE
   drop constraint PK_AUTH_ROLE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AUTH_ROLE')
            and   type = 'U')
   drop table AUTH_ROLE
go

alter table AUTH_ROLE_ATTRIBUTE
   drop constraint PK_AUTH_ROLE_ATTRIBUTE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AUTH_ROLE_ATTRIBUTE')
            and   type = 'U')
   drop table AUTH_ROLE_ATTRIBUTE
go

alter table AUTH_ROLE_DATA
   drop constraint PK_AUTH_ROLE_DATA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AUTH_ROLE_DATA')
            and   type = 'U')
   drop table AUTH_ROLE_DATA
go

alter table ROLE_DATA_TYPE
   drop constraint PK_ROLE_DATA_TYPE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ROLE_DATA_TYPE')
            and   type = 'U')
   drop table ROLE_DATA_TYPE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('USER_INFO')
            and   name  = 'LOGIN_CODE_IDX'
            and   indid > 0
            and   indid < 255)
   drop index USER_INFO.LOGIN_CODE_IDX
go

alter table USER_INFO
   drop constraint PK_USER_INFO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('USER_INFO')
            and   type = 'U')
   drop table USER_INFO
go

alter table USER_ROLE
   drop constraint PK_USER_ROLE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('USER_ROLE')
            and   type = 'U')
   drop table USER_ROLE
go

/*==============================================================*/
/* Table: AUTH_ATTRIBUTE                                        */
/*==============================================================*/
create table AUTH_ATTRIBUTE (
   ATTRIBUTE_ID         int                  not null,
   ATTRIBUTE_CODE       varchar(30)          not null,
   MENU_CODE            varchar(20)          null,
   TITLE                varchar(512)         null,
   OPERATION_URL        varchar(200)         not null,
   OPERATION_TYPE       int                  not null,
   IDX                  int                  null,
   CREATE_USER_ID       int                  null,
   UPDATE_TIME          datetime             null,
   CREATE_TIME          datetime             null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '菜单、权限表',
   'user', @CurrentUser, 'table', 'AUTH_ATTRIBUTE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '菜单ID',
   'user', @CurrentUser, 'table', 'AUTH_ATTRIBUTE', 'column', 'ATTRIBUTE_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '父菜单ID',
   'user', @CurrentUser, 'table', 'AUTH_ATTRIBUTE', 'column', 'MENU_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '菜单中文名称',
   'user', @CurrentUser, 'table', 'AUTH_ATTRIBUTE', 'column', 'TITLE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   ' 1:查询 2:编辑',
   'user', @CurrentUser, 'table', 'AUTH_ATTRIBUTE', 'column', 'OPERATION_TYPE'
go

alter table AUTH_ATTRIBUTE
   add constraint PK_AUTH_ATTRIBUTE primary key nonclustered (ATTRIBUTE_ID)
go

/*==============================================================*/
/* Table: AUTH_ATTR_ACTION                                      */
/*==============================================================*/
create table AUTH_ATTR_ACTION (
   ATTRIBUTE_ID         int                  not null,
   ACTION_URL           varchar(200)         not null,
   CREATE_TIME          datetime             null,
   VERIFY_RESOURCE      char(1)              not null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '一个功能对应的action，系统通过action来控制请求
   ',
   'user', @CurrentUser, 'table', 'AUTH_ATTR_ACTION'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '父菜单ID',
   'user', @CurrentUser, 'table', 'AUTH_ATTR_ACTION', 'column', 'ACTION_URL'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0:不验证
   1:验证',
   'user', @CurrentUser, 'table', 'AUTH_ATTR_ACTION', 'column', 'VERIFY_RESOURCE'
go

alter table AUTH_ATTR_ACTION
   add constraint PK_AUTH_ATTR_ACTION primary key nonclustered (ATTRIBUTE_ID, ACTION_URL)
go

/*==============================================================*/
/* Table: AUTH_DIR                                              */
/*==============================================================*/
create table AUTH_DIR (
   DIR_ID               bigint               identity,
   PARENT_ID            bigint               not null,
   DIR_NAME             varchar(30)          not null,
   DIR_CODE             varchar(20)          not null,
   DIR_SEQ              varchar(3072)        not null,
   SEQ                  char(5)              not null,
   IDX                  int                  null,
   EMAIL                varchar(50)          null,
   PHONE                varchar(20)          null,
   IS_LEAF              char(1)              null,
   MEMO                 varchar(50)          null,
   STATE                char(2)              null,
   CREATE_TIME          datetime             not null,
   CREATE_USER_ID       int                  not null,
   UPDATE_TIME          datetime             null,
   MODIFY_USER_ID       bigint               null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '机构',
   'user', @CurrentUser, 'table', 'AUTH_DIR'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '01有效02无效。默认01',
   'user', @CurrentUser, 'table', 'AUTH_DIR', 'column', 'STATE'
go

alter table AUTH_DIR
   add constraint PK_AUTH_DIR primary key nonclustered (DIR_ID)
go

/*==============================================================*/
/* Table: AUTH_MENU                                             */
/*==============================================================*/
create table AUTH_MENU (
   MENU_ID              int                  not null,
   MENU_NAME            varchar(20)          not null,
   MENU_CODE            varchar(20)          not null,
   PARENT_MENU_CODE     varchar(20)          not null,
   IS_LEAF              char(1)              not null,
   IDX                  int                  null,
   ACTION_URL           varchar(200)         not null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '父菜单ID',
   'user', @CurrentUser, 'table', 'AUTH_MENU', 'column', 'ACTION_URL'
go

alter table AUTH_MENU
   add constraint PK_AUTH_MENU primary key nonclustered (MENU_ID)
go

/*==============================================================*/
/* Table: AUTH_ROLE                                             */
/*==============================================================*/
create table AUTH_ROLE (
   ROLE_ID              bigint               identity,
   ROLE_NAME            varchar(20)          not null,
   ROLE_DESC            varchar(600)         null,
   VERSION              int                  null,
   CREATE_USER_ID       bigint               not null,
   CREATE_TIME          datetime             not null,
   MODIFY_USER_ID       bigint               null,
   UPDATE_TIME          datetime             not null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色可操作功能的集合',
   'user', @CurrentUser, 'table', 'AUTH_ROLE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色ID',
   'user', @CurrentUser, 'table', 'AUTH_ROLE', 'column', 'ROLE_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色描述',
   'user', @CurrentUser, 'table', 'AUTH_ROLE', 'column', 'ROLE_DESC'
go

alter table AUTH_ROLE
   add constraint PK_AUTH_ROLE primary key nonclustered (ROLE_ID)
go

/*==============================================================*/
/* Table: AUTH_ROLE_ATTRIBUTE                                   */
/*==============================================================*/
create table AUTH_ROLE_ATTRIBUTE (
   ROLE_ID              bigint               not null,
   ATTRIBUTE_ID         int                  not null,
   CREATE_USER_ID       bigint               null,
   UPDATE_TIME          datetime             null,
   CREATE_TIME          datetime             null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色可操作的权限',
   'user', @CurrentUser, 'table', 'AUTH_ROLE_ATTRIBUTE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '应用系统ID',
   'user', @CurrentUser, 'table', 'AUTH_ROLE_ATTRIBUTE', 'column', 'ROLE_ID'
go

alter table AUTH_ROLE_ATTRIBUTE
   add constraint PK_AUTH_ROLE_ATTRIBUTE primary key nonclustered (ROLE_ID, ATTRIBUTE_ID)
go

/*==============================================================*/
/* Table: AUTH_ROLE_DATA                                        */
/*==============================================================*/
create table AUTH_ROLE_DATA (
   ROLE_ID              bigint               not null,
   DATA_ID              int                  not null,
   CREATE_USER_ID       bigint               null,
   UPDATE_TIME          datetime             null,
   CREATE_TIME          datetime             null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色可操作的权限',
   'user', @CurrentUser, 'table', 'AUTH_ROLE_DATA'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '应用系统ID',
   'user', @CurrentUser, 'table', 'AUTH_ROLE_DATA', 'column', 'ROLE_ID'
go

alter table AUTH_ROLE_DATA
   add constraint PK_AUTH_ROLE_DATA primary key nonclustered (ROLE_ID, DATA_ID)
go

/*==============================================================*/
/* Table: ROLE_DATA_TYPE                                        */
/*==============================================================*/
create table ROLE_DATA_TYPE (
   DATA_ID              int                  not null,
   DATA_NAME            varchar(20)          null,
   DATA_DESC            varchar(200)         null,
   DATA_CODE            char(2)              null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '全公司01
   所在部门02
   项目经理03
   所在项目04',
   'user', @CurrentUser, 'table', 'ROLE_DATA_TYPE', 'column', 'DATA_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '全公司01
   所在部门02
   项目经理03
   所在项目04',
   'user', @CurrentUser, 'table', 'ROLE_DATA_TYPE', 'column', 'DATA_DESC'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '全公司01
   所在部门02
   项目经理03
   所在项目04',
   'user', @CurrentUser, 'table', 'ROLE_DATA_TYPE', 'column', 'DATA_CODE'
go

alter table ROLE_DATA_TYPE
   add constraint PK_ROLE_DATA_TYPE primary key nonclustered (DATA_ID)
go

/*==============================================================*/
/* Table: USER_INFO                                             */
/*==============================================================*/
create table USER_INFO (
   USER_ID              bigint               identity,
   LOGIN_CODE           varchar(20)          not null,
   PASSWORD             varchar(50)          not null,
   USER_NAME            varchar(40)          not null,
   USER_CODE            varchar(20)          not null,
   PHOTO                varchar(100)         null,
   GENDER               char(2)              null,
   NATION               varchar(60)          null,
   NATIVE_PLACE         varchar(200)         null,
   HOME_ADD             varchar(100)         null,
   CURRENT_ADD          varchar(100)         null,
   PROFESSIONAL_RANKS   varchar(50)          null,
   CELL_PHONE           varchar(20)          null,
   OFFICE_PHONE         varchar(20)          null,
   EMERGENCY_MAN        varchar(20)          null,
   EMERGENCY_PHONE      varchar(20)          null,
   HOME_PHONE           varchar(20)          null,
   ENTRY_DATE           datetime             null,
   USER_STATUS          char(1)              null,
   POLITICS_STATUS      varchar(30)          null,
   EDUCATION            varchar(30)          null,
   DEGREE               varchar(10)          null,
   GRADUATE_SCHOOL      varchar(50)          null,
   SPECIALTY            varchar(50)          null,
   GRADUATE_DATE        datetime             null,
   START_WORK_DATE      datetime             null,
   BIRTHDAY             datetime             null,
   ID_NUMBER            varchar(18)          null,
   EMAIL                varchar(30)          null,
   QQ                   varchar(30)          null,
   HOUSING_FUND_ACCOUNT varchar(30)          null,
   POSITION             varchar(30)          null,
   DIR_ID               bigint               null,
   DEPT_POSITION        varchar(20)          null,
   POSITION_DEGREE      varchar(30)          null,
   POSITION_TIME        datetime             null,
   CONTRACT_TYPE        varchar(60)          null,
   CONTRACT_START_TIME  datetime             null,
   CONTRACT_END_TIME    datetime             null,
   EMPLOYEE_TYPE        varchar(60)          null,
   EMPLOYEE_WAGES_TYPE  varchar(60)          null,
   PROBATION_START      datetime             null,
   PROBATION_END        datetime             null,
   WORK_STATUS          varchar(60)          null,
   MARITAL_STATUS       varchar(30)          null,
   ALLOW_REPEAT_LOGIN   bit					 null,
   VERSION              int                  null,
   CREATE_TIME          datetime             null,
   CREATE_USER_ID       bigint               null,
   UPDATE_TIME          datetime             null,
   MODIFY_USER_ID       bigint               null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户信息表',
   'user', @CurrentUser, 'table', 'USER_INFO'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户ID',
   'user', @CurrentUser, 'table', 'USER_INFO', 'column', 'USER_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '员工号',
   'user', @CurrentUser, 'table', 'USER_INFO', 'column', 'USER_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '员工号',
   'user', @CurrentUser, 'table', 'USER_INFO', 'column', 'USER_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '性别
   00-男
   01-女
   02-未知',
   'user', @CurrentUser, 'table', 'USER_INFO', 'column', 'GENDER'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户状态
   0-失效
   1-生效',
   'user', @CurrentUser, 'table', 'USER_INFO', 'column', 'USER_STATUS'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '证件号码',
   'user', @CurrentUser, 'table', 'USER_INFO', 'column', 'ID_NUMBER'
go

alter table USER_INFO
   add constraint PK_USER_INFO primary key nonclustered (USER_ID)
go

/*==============================================================*/
/* Index: LOGIN_CODE_IDX                                        */
/*==============================================================*/
create unique index LOGIN_CODE_IDX on USER_INFO (
LOGIN_CODE ASC
)
go

/*==============================================================*/
/* Table: USER_ROLE                                             */
/*==============================================================*/
create table USER_ROLE (
   USER_ID              bigint               not null,
   ROLE_ID              bigint               not null,
   CREATE_USER_ID       bigint               null,
   UPDATE_TIME          datetime             null,
   CREATE_TIME          datetime             null
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户角色关系',
   'user', @CurrentUser, 'table', 'USER_ROLE'
go

alter table USER_ROLE
   add constraint PK_USER_ROLE primary key nonclustered (USER_ID, ROLE_ID)
go

/*==============================================================*/
/* View: USER_DEPT_PROJECT                                      */
/*==============================================================*/
create view USER_DEPT_PROJECT as
SELECT
    A.USER_ID,
    A.USER_CODE,
    B.PK_PROJ,
    B.PROJ_NAME,
    A.DIR_ID,
    C.DIR_CODE,
    C.DIR_NAME
FROM
    USER_INFO A
JOIN
    PROJECT B
ON
    A.DIR_ID = B.DEPT_ID
JOIN
    AUTH_DIR C
ON
    A.DIR_ID = C.DIR_ID
go

/*==============================================================*/
/* View: V_USER_ROLE_DATA                                       */
/*==============================================================*/
create view V_USER_ROLE_DATA as
SELECT
    C.DATA_CODE,
    B.USER_ID
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
go


/*==============================================================*/
/* View: V_USER_PROJECT                                         */
/*==============================================================*/
create view V_USER_PROJECT as
SELECT
    B.USER_ID,
    E.DIR_ID,
    E.DIR_SEQ,
    D.PK_PROJ
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    PROJECT D
ON
    1 = 1
JOIN
    AUTH_DIR E
ON
    D.DEPT_ID = E.DIR_ID
WHERE
    C.DATA_CODE = '01'
UNION
SELECT
    B.USER_ID,
    E.DIR_ID,
    E.DIR_SEQ,
    G.PK_PROJ
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    USER_INFO D
ON
    B.USER_ID = D.USER_ID
JOIN
    AUTH_DIR E
ON
    D.DIR_ID = E.DIR_ID
JOIN
    PROJECT G
ON
    E.DIR_ID = G.DEPT_ID
WHERE
    C.DATA_CODE = '02'
UNION
SELECT
    B.USER_ID,
    E.DIR_ID,
    E.DIR_SEQ,
    D.PK_PROJ
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    PROJECT D
ON
    B.USER_ID = D.PM_ID
JOIN
    AUTH_DIR E
ON
    D.DEPT_ID = E.DIR_ID
WHERE
    C.DATA_CODE = '03'
UNION
SELECT
    B.USER_ID,
    F.DIR_ID,
    F.DIR_SEQ,
    D.PK_PROJ
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    PROJECT_RECOURCE_REF D
ON
    B.USER_ID = D.USER_ID
JOIN
    PROJECT E
ON
    D.PK_PROJ = E.PK_PROJ
JOIN
    AUTH_DIR F
ON
    E.DEPT_ID = F.DIR_ID
WHERE
    D.CHARGE_PROJ = '2'
go


if exists (select 1
            from  sysobjects
           where  id = object_id('V_USER_ROLE_DATA')
            and   type = 'V')
   drop view V_USER_ROLE_DATA
go

/*==============================================================*/
/* View: V_USER_ROLE_DATA                                       */
/*==============================================================*/
create view V_USER_ROLE_DATA as
SELECT
    C.DATA_CODE,
    B.USER_ID
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
go


if exists (select 1
            from  sysobjects
           where  id = object_id('V_USER_DEPT_PROJECT')
            and   type = 'V')
   drop view V_USER_DEPT_PROJECT
go

/*==============================================================*/
/* View: V_USER_DEPT_PROJECT                                    */
/*==============================================================*/
create view V_USER_DEPT_PROJECT as
SELECT
    A.USER_ID,
    A.USER_CODE,
    B.PK_PROJ,
    B.PROJ_NAME,
    A.DIR_ID,
    C.DIR_CODE,
    C.DIR_NAME
FROM
    USER_INFO A
JOIN
    PROJECT B
ON
    A.DIR_ID = B.DEPT_ID
JOIN
    AUTH_DIR C
ON
    A.DIR_ID = C.DIR_ID
go


if exists (select 1
            from  sysobjects
           where  id = object_id('V_USER')
            and   type = 'V')
   drop view V_USER
go

/*==============================================================*/
/* View: V_USER                                                 */
/*==============================================================*/
create view V_USER as
SELECT
    B.USER_ID,
    D.DIR_ID,
    D.USER_ID AS OTHER_USER_ID
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    USER_INFO D
ON
    1=1
WHERE
    C.DATA_CODE = '01'
UNION
SELECT
    B.USER_ID,
    E.DIR_ID,
    E.USER_ID AS OTHER_USER_ID
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    USER_INFO D
ON
    B.USER_ID = D.USER_ID
JOIN
    USER_INFO E
ON
    D.DIR_ID = E.DIR_ID
WHERE
    C.DATA_CODE = '02'
UNION
SELECT
    B.USER_ID,
    F.DIR_ID,
    E.USER_ID AS OTHER_USER_ID
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    PROJECT D
ON
    B.USER_ID = D.PM_ID
JOIN
    PROJECT_RECOURCE_REF E
ON
    D.PK_PROJ = E.PK_PROJ
JOIN
    USER_INFO F
ON
    E.USER_ID = F.USER_ID
WHERE
    C.DATA_CODE = '03'
UNION
SELECT
    B.USER_ID,
    F.DIR_ID,
    E.USER_ID AS OTHER_USER_ID
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    PROJECT_RECOURCE_REF D
ON
    B.USER_ID = D.USER_ID
JOIN
    PROJECT_RECOURCE_REF E
ON
    D.PK_PROJ = E.PK_PROJ
JOIN
    USER_INFO F
ON
    E.USER_ID = F.USER_ID
WHERE
    D.CHARGE_PROJ = '2'
go


if exists (select 1
            from  sysobjects
           where  id = object_id('V_USER_PROJECT_ALL')
            and   type = 'V')
   drop view V_USER_PROJECT_ALL
go

/*==============================================================*/
/* View: V_USER_PROJECT_ALL                                     */
/*==============================================================*/
create view V_USER_PROJECT_ALL as
SELECT
    B.USER_ID,
    E.DIR_ID,
    E.DIR_SEQ,
    D.PK_PROJ
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    PROJECT D
ON
    1 = 1
JOIN
    AUTH_DIR E
ON
    D.DEPT_ID = E.DIR_ID
WHERE
    C.DATA_CODE = '01'
UNION
SELECT
    B.USER_ID,
    F.DIR_ID,
    F.DIR_SEQ,
    G.PK_PROJ
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    USER_INFO D
ON
    B.USER_ID = D.USER_ID
JOIN
    AUTH_DIR E
ON
    D.DIR_ID = E.DIR_ID
JOIN
    AUTH_DIR F
ON
    F.DIR_SEQ LIKE E.DIR_SEQ + '%'
JOIN
    PROJECT G
ON
    F.DIR_ID = G.DEPT_ID
WHERE
    C.DATA_CODE = '02'
UNION
SELECT
    B.USER_ID,
    E.DIR_ID,
    E.DIR_SEQ,
    D.PK_PROJ
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    PROJECT D
ON
    B.USER_ID = D.PM_ID
JOIN
    AUTH_DIR E
ON
    D.DEPT_ID = E.DIR_ID
WHERE
    C.DATA_CODE = '03'
UNION
SELECT
    B.USER_ID,
    F.DIR_ID,
    F.DIR_SEQ,
    D.PK_PROJ
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    PROJECT_RECOURCE_REF D
ON
    B.USER_ID = D.USER_ID
JOIN
    PROJECT E
ON
    D.PK_PROJ = E.PK_PROJ
JOIN
    AUTH_DIR F
ON
    E.DEPT_ID = F.DIR_ID
WHERE
    D.CHARGE_PROJ = '2'
go


if exists (select 1
            from  sysobjects
           where  id = object_id('V_USER_ALL')
            and   type = 'V')
   drop view V_USER_ALL
go

/*==============================================================*/
/* View: V_USER_ALL                                             */
/*==============================================================*/
create view V_USER_ALL as
SELECT
    B.USER_ID,
    D.DIR_ID,
    D.USER_ID AS OTHER_USER_ID
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    USER_INFO D
ON
    1=1
WHERE
    C.DATA_CODE = '01'
UNION
SELECT
    B.USER_ID,
    F.DIR_ID,
    G.USER_ID AS OTHER_USER_ID
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    USER_INFO D
ON
    B.USER_ID = D.USER_ID
    JOIN AUTH_DIR E ON D.DIR_ID = E.DIR_ID
    JOIN AUTH_DIR F ON F.DIR_SEQ LIKE E.DIR_SEQ +'%'
JOIN
    USER_INFO G
ON
    F.DIR_ID = G.DIR_ID
WHERE
    C.DATA_CODE = '02'
UNION
SELECT
    B.USER_ID,
    F.DIR_ID,
    E.USER_ID AS OTHER_USER_ID
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    PROJECT D
ON
    B.USER_ID = D.PM_ID
JOIN
    PROJECT_RECOURCE_REF E
ON
    D.PK_PROJ = E.PK_PROJ
JOIN
    USER_INFO F
ON
    E.USER_ID = F.USER_ID
WHERE
    C.DATA_CODE = '03'
UNION
SELECT
    B.USER_ID,
    F.DIR_ID,
    E.USER_ID AS OTHER_USER_ID
FROM
    AUTH_ROLE_DATA A
JOIN
    USER_ROLE B
ON
    A.ROLE_ID = B.ROLE_ID
JOIN
    ROLE_DATA_TYPE C
ON
    A.DATA_ID = C.DATA_ID
JOIN
    PROJECT_RECOURCE_REF D
ON
    B.USER_ID = D.USER_ID
JOIN
    PROJECT_RECOURCE_REF E
ON
    D.PK_PROJ = E.PK_PROJ
JOIN
    USER_INFO F
ON
    E.USER_ID = F.USER_ID
WHERE
    D.CHARGE_PROJ = '2'
go