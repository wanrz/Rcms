set identity_insert AUTH_DIR on;
set identity_insert USER_INFO on;
set identity_insert AUTH_ROLE on;
set identity_insert PROJECT on;
set identity_insert TASK on;
set identity_insert WORK_LOG on;
set identity_insert BD_DICT_DETAIL on;
set identity_insert SYS_OPERATION_LOG on;
set identity_insert SYS_LOGIN_LOG on;
set identity_insert PROJECT_TYPE_DICT on;
set identity_insert PROJECT_LEVEL_DICT on;
set identity_insert PROJECT_URGENT_DICT on;


set identity_insert AUTH_DIR off;
set identity_insert USER_INFO off;
set identity_insert AUTH_ROLE off;
set identity_insert PROJECT off;
set identity_insert TASK off;
set identity_insert WORK_LOG off;
set identity_insert BD_DICT_DETAIL off;
set identity_insert SYS_OPERATION_LOG off;
set identity_insert SYS_LOGIN_LOG off;
set identity_insert PROJECT_TYPE_DICT off;
set identity_insert PROJECT_LEVEL_DICT off;
set identity_insert PROJECT_URGENT_DICT off;


select AUTH_DIR_CODE_SEQ.nextval from dual;
select AUTH_DIR_SEQ.nextval from dual;
select TASK_CODE_SEQ.nextval from dual;
select USER_INFO_CODE_SEQ.nextval from dual;

dbcc checkident('AUTH_DIR_CODE_SEQ',reseed,262);
dbcc checkident('AUTH_DIR_SEQ',reseed,112)
dbcc checkident('TASK_CODE_SEQ',reseed,174)
dbcc checkident('USER_INFO_CODE_SEQ',reseed,569);