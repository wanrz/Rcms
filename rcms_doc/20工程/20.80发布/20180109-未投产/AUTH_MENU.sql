delete from AUTH_MENU WHERE MENU_CODE IN ('QueryProj');
insert into AUTH_MENU(MENU_ID, MENU_NAME, MENU_CODE, PARENT_MENU_CODE, IS_LEAF, IDX, ACTION_URL) values(118,'��Ŀ��ѯ','QueryProj','ToolBarCProjManage',1,3,'/admin/projectQuery/project.do');