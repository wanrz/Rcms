/**
 *
 */
package com.rionsoft.rcms.biz.task.impl;

import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import com.rionsoft.rcms.biz.task.ITaskBiz;
import com.rionsoft.rcms.biz.task.ITaskMonitorBiz;
import com.rionsoft.rcms.bo.constant.ProjectStatusEnum;
import com.rionsoft.rcms.bo.constant.TaskStatusEnum;
import com.rionsoft.rcms.bo.task.TaskBo;
import com.rionsoft.rcms.bo.task.TaskUserRefBo;
import com.rionsoft.rcms.condition.project.ProjMonitorCondition;
import com.rionsoft.rcms.condition.project.ProjMonitorListEntry;
import com.rionsoft.rcms.condition.task.TaskCondition;
import com.rionsoft.rcms.condition.task.TaskListEntry;
import com.rionsoft.rcms.condition.task.TaskMonitorCondition;
import com.rionsoft.rcms.condition.task.TaskUserRefListEntry;
import com.rionsoft.rcms.dao.task.ITaskMonitorDao;
import com.rionsoft.support.basebo.session.UserLoginBo;
import com.rionsoft.support.basebo.view.ExportFileBo;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.biz.common.constants.SessionConstant;
import com.rionsoft.support.biz.util.DatePattern;
import com.rionsoft.support.biz.util.excel.FileType;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;
import com.rionsoft.support.mybatisplugin.dao.util.PropertyPlaceholderUtils;

/**
 * @author likeke
 * @date 2017年4月30日
 */
@Service
public class TaskMonitorBizImpl extends BaseBiz implements ITaskMonitorBiz {

	@Autowired
	private ITaskMonitorDao taskMonitorDao;
	@Autowired
	private ITaskBiz taskBiz;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.task.ITaskMonitorBiz#exportTask(java.util.List,
	 * long, java.lang.String)
	 */
	@Override
	public ExportFileBo<TaskUserRefBo> exportTaskDetail(final List<Long> idList) {
		final TaskMonitorCondition condition = new TaskMonitorCondition();
		condition.setPkTaskList(idList);
		final List<TaskUserRefBo> listBo = mapListEntry(taskMonitorDao.queryProgressDetail(condition),
				TaskUserRefBo.class);
		final String[] fieldNames = { "projName", "pmName", "taskCode", "taskName", "relEndDate", "relEndDate",
				"requireWorkload", "status", "userName", "percentage" };
		final String[] columnName = { "项目名称", "项目经理", "任务编号", "任务名称", "任务时间", "任务实际结束时间", "工作量", "任务状态", "参与人员",
				"完成百分比" };

		final LinkedHashMap<String, String> fieldMap = new LinkedHashMap<>();

		for (int i = 0; i < fieldNames.length; i++) {
			fieldMap.put(fieldNames[i], columnName[i]);
		}
		final String sheetName = "任务详情表";
		final String fileName = "任务详情表" + DatePattern.YYYYMMDDHHMMSS.format(new Date());
		final ExportFileBo<TaskUserRefBo> fileBo = new ExportFileBo<TaskUserRefBo>(fileName, FileType.XLS.name());
		fileBo.setDataList(listBo);
		fileBo.setFieldMap(fieldMap);
		fileBo.setSheetName(sheetName);
		return fileBo;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.task.ITaskMonitorBiz#queryProgressDetail(com.
	 * rionsoft.rcms.condition.task.TaskCondition)
	 */
	@Override
	public List<TaskUserRefListEntry> queryProgressDetail(final TaskMonitorCondition condition) {

		return taskMonitorDao.queryProgressDetail(condition);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.task.ITaskMonitorBiz#exportTask(java.util.List)
	 */
	@Override
	public ExportFileBo<TaskBo> exportTask(final List<Long> idList, final HttpServletRequest req) {

		final TaskCondition condition = new TaskCondition();
		condition.setPkTaskList(idList);

		final List<TaskBo> listEntry = taskBiz.queryByCondition(condition, req);
		final String[] fieldNames = { "projName", "pmName", "taskCode", "taskName", "relEndDate", "relEndDate",
				"workload", "status", "userCount", "percentage" };
		final String[] columnName = { "项目名称", "项目经理", "任务编号", "任务名称", "任务时间", "任务实际结束时间", "工作量", "任务状态", "参与人数",
				"完成百分比" };
		final LinkedHashMap<String, String> fieldMap = new LinkedHashMap<>();

		for (int i = 0; i < fieldNames.length; i++) {
			fieldMap.put(fieldNames[i], columnName[i]);
		}
		final String sheetName = "任务表";
		final String fileName = "任务表" + DatePattern.YYYYMMDDHHMMSS.format(new Date());
		final ExportFileBo<TaskBo> fileBo = new ExportFileBo<TaskBo>(fileName, FileType.XLS.name());
		fileBo.setDataList(listEntry);
		fileBo.setFieldMap(fieldMap);
		fileBo.setSheetName(sheetName);
		return fileBo;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.task.ITaskMonitorBiz#queryProjMonitor(com.rionsoft.
	 * rcms.condition.project.ProjMonitorCondition,
	 * javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public List<ProjMonitorListEntry> queryProjMonitor(final ProjMonitorCondition projectCondition,
			final HttpServletRequest req) {
		if (projectCondition.getCheckDirName() != "" && projectCondition.getCheckDirName() != null) {
			projectCondition.setDeptId(null);
			final String dirSeq = projectCondition.getCheckDirName();
			if (dirSeq.contains("|")) {
				projectCondition.setDirSeq(dirSeq.substring(dirSeq.lastIndexOf("|") + 1));
			} else {
				projectCondition.setDirSeq(dirSeq);
			}
			projectCondition.setDeptName(null);
		}
		if (projectCondition.getCheckDirName2() != "" && projectCondition.getCheckDirName2() != null) {
			projectCondition.setDeptId(null);
			projectCondition.setDirSeq(projectCondition.getCheckDirName2());
			projectCondition.setDeptName(null);
		}
		// 用户权限判断
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		final String adminLoginCode = PropertyPlaceholderUtils.getContextProperty("adminLoginCode");
		final UserLoginBo bo = (UserLoginBo) WebUtils.getSessionAttribute(req, SessionConstant.ADMIN_LOGIN.name());
		projectCondition.setUserId(userId);
		projectCondition.setAdminLoginCode(adminLoginCode);
		projectCondition.setLoginCode(bo.getLoginCode());

		final List<ProjMonitorListEntry> projectMonitorBo = taskMonitorDao.queryMonitorByDataCode(projectCondition);
		for (final ProjMonitorListEntry newProjectMonitor : projectMonitorBo) {
			newProjectMonitor.setStatus(ProjectStatusEnum.getType(newProjectMonitor.getStatus()));
		}

		return projectMonitorBo;
	}

	@Override
	public List<TaskListEntry> queryTaskMonitor(final TaskCondition condition) {
		final List<TaskListEntry> entryList = taskMonitorDao.queryTaskMonitor(condition);
		for (final TaskListEntry entry : entryList) {
			entry.setStatus(TaskStatusEnum.getType(entry.getStatus()));
			if(entry.getPercentage()==null){
				entry.setPercentage((long) 0);
			}
		}
		return entryList;

	}
}
