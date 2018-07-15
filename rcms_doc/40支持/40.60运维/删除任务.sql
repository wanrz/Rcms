--删除日志
delete from dbo.WORK_LOG where PK_TASK in (select a.PK_TASK from dbo.TASK a where a.PK_PROJ = 1016 and a.TASK_NAME in ('燃油卡充值','月底发票、凭证整理归档','员工中秋月饼变质问题处理','涛飞办公室续租','软件著作权申报','涛飞停车费'));

--删除任务人员关系
delete from dbo.TASK_USER_REF where PK_TASK in (select a.PK_TASK from dbo.TASK a where a.PK_PROJ = 1016 and a.TASK_NAME in ('燃油卡充值','月底发票、凭证整理归档','员工中秋月饼变质问题处理','涛飞办公室续租','软件著作权申报','涛飞停车费'));

--删除任务
delete from dbo.TASK where PK_PROJ = 1016 and TASK_NAME in ('燃油卡充值','月底发票、凭证整理归档','员工中秋月饼变质问题处理','涛飞办公室续租','软件著作权申报','涛飞停车费');


