/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2017/9/11 12:27:48                           */
/*==============================================================*/


alter table AUTH_DIR_CODE_SEQ
   drop constraint PK_AUTH_DIR_CODE_SEQ
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AUTH_DIR_CODE_SEQ')
            and   type = 'U')
   drop table AUTH_DIR_CODE_SEQ
go

alter table AUTH_DIR_SEQ
   drop constraint PK_AUTH_DIR_SEQ
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AUTH_DIR_SEQ')
            and   type = 'U')
   drop table AUTH_DIR_SEQ
go

alter table TASK_CODE_SEQ
   drop constraint PK_TASK_CODE_SEQ
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TASK_CODE_SEQ')
            and   type = 'U')
   drop table TASK_CODE_SEQ
go

alter table USER_INFO_CODE_SEQ
   drop constraint PK_USER_INFO_CODE_SEQ
go

if exists (select 1
            from  sysobjects
           where  id = object_id('USER_INFO_CODE_SEQ')
            and   type = 'U')
   drop table USER_INFO_CODE_SEQ
go

/*==============================================================*/
/* Table: AUTH_DIR_CODE_SEQ                                     */
/*==============================================================*/
create table AUTH_DIR_CODE_SEQ (
   ID                   bigint               identity
)
go

alter table AUTH_DIR_CODE_SEQ
   add constraint PK_AUTH_DIR_CODE_SEQ primary key (ID)
go

/*==============================================================*/
/* Table: AUTH_DIR_SEQ                                          */
/*==============================================================*/
create table AUTH_DIR_SEQ (
   ID                   bigint               identity
)
go

alter table AUTH_DIR_SEQ
   add constraint PK_AUTH_DIR_SEQ primary key (ID)
go

/*==============================================================*/
/* Table: TASK_CODE_SEQ                                         */
/*==============================================================*/
create table TASK_CODE_SEQ (
   ID                   bigint               identity
)
go

alter table TASK_CODE_SEQ
   add constraint PK_TASK_CODE_SEQ primary key (ID)
go

/*==============================================================*/
/* Table: USER_INFO_CODE_SEQ                                    */
/*==============================================================*/
create table USER_INFO_CODE_SEQ (
   ID                   bigint               identity
)
go

alter table USER_INFO_CODE_SEQ
   add constraint PK_USER_INFO_CODE_SEQ primary key (ID)
go

