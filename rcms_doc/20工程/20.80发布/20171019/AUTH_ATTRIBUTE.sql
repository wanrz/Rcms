delete from AUTH_ATTRIBUTE WHERE ATTRIBUTE_CODE IN ('CreateProjDetail','RptReportFill','RptReportAdd','RptReportUpdate','RptWeeklyApprove','RptWeeklyApproveAdd','RptWeeklyApproved','TaskManageDevan','TaskManageForce');

INSERT INTO AUTH_ATTRIBUTE (ATTRIBUTE_ID, ATTRIBUTE_CODE, MENU_CODE, TITLE, OPERATION_URL, OPERATION_TYPE, IDX) VALUES (46, 'RptReportFill', 'RptWeeklyFillManage', '查询', '#', 1, 1);
INSERT INTO AUTH_ATTRIBUTE (ATTRIBUTE_ID, ATTRIBUTE_CODE, MENU_CODE, TITLE, OPERATION_URL, OPERATION_TYPE, IDX) VALUES (47, 'RptReportAdd', 'RptWeeklyFillManage', '周报填写', '#', 2, 2);
INSERT INTO AUTH_ATTRIBUTE (ATTRIBUTE_ID, ATTRIBUTE_CODE, MENU_CODE, TITLE, OPERATION_URL, OPERATION_TYPE, IDX) VALUES (48, 'RptReportUpdate', 'RptWeeklyFillManage', '周报修改', '#', 2, 3);
INSERT INTO AUTH_ATTRIBUTE (ATTRIBUTE_ID, ATTRIBUTE_CODE, MENU_CODE, TITLE, OPERATION_URL, OPERATION_TYPE, IDX) VALUES (49, 'RptWeeklyApprove', 'RptWeeklyApprManage', '查询', '#', 1, 1);
INSERT INTO AUTH_ATTRIBUTE (ATTRIBUTE_ID, ATTRIBUTE_CODE, MENU_CODE, TITLE, OPERATION_URL, OPERATION_TYPE, IDX) VALUES (50, 'RptWeeklyApproveAdd', 'RptWeeklyApprManage', '审批', '#', 2, 2);
INSERT INTO AUTH_ATTRIBUTE (ATTRIBUTE_ID, ATTRIBUTE_CODE, MENU_CODE, TITLE, OPERATION_URL, OPERATION_TYPE, IDX) VALUES (51, 'RptWeeklyApproved', 'RptWeeklyApprManage', '历史周报', '#', 2, 3);
INSERT INTO AUTH_ATTRIBUTE (ATTRIBUTE_ID, ATTRIBUTE_CODE, MENU_CODE, TITLE, OPERATION_URL, OPERATION_TYPE, IDX) VALUES (52, 'TaskManageDevan', 'TaskManage', '解封', '#', 2, 8);
INSERT INTO AUTH_ATTRIBUTE (ATTRIBUTE_ID, ATTRIBUTE_CODE, MENU_CODE, TITLE, OPERATION_URL, OPERATION_TYPE, IDX) VALUES (53, 'TaskManageForce', 'TaskManage', '强制完成', '#', 2, 9);


INSERT INTO AUTH_ATTRIBUTE (ATTRIBUTE_ID, ATTRIBUTE_CODE, MENU_CODE, TITLE, OPERATION_URL, OPERATION_TYPE, IDX, CREATE_USER_ID, UPDATE_TIME, CREATE_TIME) VALUES (45, 'CreateProjDetail', 'CreateProj', '详情', '#', 2, 5, null, null, null);