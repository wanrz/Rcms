--ɾ����־
delete from dbo.WORK_LOG where PK_TASK in (select a.PK_TASK from dbo.TASK a where a.PK_PROJ = 1016 and a.TASK_NAME in ('ȼ�Ϳ���ֵ','�µ׷�Ʊ��ƾ֤����鵵','Ա�������±��������⴦��','�ηɰ칫������','�������Ȩ�걨','�η�ͣ����'));

--ɾ��������Ա��ϵ
delete from dbo.TASK_USER_REF where PK_TASK in (select a.PK_TASK from dbo.TASK a where a.PK_PROJ = 1016 and a.TASK_NAME in ('ȼ�Ϳ���ֵ','�µ׷�Ʊ��ƾ֤����鵵','Ա�������±��������⴦��','�ηɰ칫������','�������Ȩ�걨','�η�ͣ����'));

--ɾ������
delete from dbo.TASK where PK_PROJ = 1016 and TASK_NAME in ('ȼ�Ϳ���ֵ','�µ׷�Ʊ��ƾ֤����鵵','Ա�������±��������⴦��','�ηɰ칫������','�������Ȩ�걨','�η�ͣ����');


