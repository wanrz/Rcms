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

ALTER TABLE USER_INFO ADD ALLOW_REPEAT_LOGIN BIT;
UPDATE USER_INFO SET ALLOW_REPEAT_LOGIN = '1';


if exists (select 1
            from  sysobjects
           where  id = object_id('V_USER_PROJECT')
            and   type = 'V')
   drop view V_USER_PROJECT
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

if exists (select 1
            from  sysobjects
           where  id = object_id('V_DEPT_USER_PROJECT')
            and   type = 'V')
   drop view V_DEPT_USER_PROJECT
go

/*==============================================================*/
/* View: V_DEPT_USER_PROJECT                                    */
/*==============================================================*/
create view V_DEPT_USER_PROJECT as
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
go
