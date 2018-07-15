/**
 *
 */
package com.rionsoft.rcms.biz.task.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import com.rionsoft.rcms.biz.constant.RCMSExceptionCodeEnum;
import com.rionsoft.rcms.biz.task.ITaskBiz;
import com.rionsoft.rcms.biz.task.ITaskImportBiz;
import com.rionsoft.rcms.bo.constant.TaskStatusEnum;
import com.rionsoft.rcms.bo.constant.TaskTypeEnum;
import com.rionsoft.rcms.bo.project.ProjectBo;
import com.rionsoft.rcms.bo.task.ExcelTaskBo;
import com.rionsoft.rcms.bo.task.TaskBo;
import com.rionsoft.rcms.bo.task.TaskUserRefBo;
import com.rionsoft.rcms.bo.user.UserInfoBo;
import com.rionsoft.rcms.condition.task.TaskCondition;
import com.rionsoft.rcms.condition.task.TaskListEntry;
import com.rionsoft.rcms.condition.task.TaskUserRefCondition;
import com.rionsoft.rcms.condition.workLog.WorkLogListEntry;
import com.rionsoft.rcms.dao.project.IProjectRecourceRefDao;
import com.rionsoft.rcms.dao.task.ITaskDao;
import com.rionsoft.rcms.dao.workLog.IWorkLogDao;
import com.rionsoft.rcms.entry.project.ProjectEntry;
import com.rionsoft.rcms.entry.task.TaskEntry;
import com.rionsoft.support.basebo.common.file.FileUploadBo;
import com.rionsoft.support.basebo.session.UserLoginBo;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.biz.common.constants.SessionConstant;
import com.rionsoft.support.biz.common.error.RionsoftException;
import com.rionsoft.support.biz.util.excel.ReadExcelUtils;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;
import com.rionsoft.support.mybatisplugin.dao.util.PropertyPlaceholderUtils;

/**
 * @author loujie
 * @data 2017年4月25日
 */
@Service
public class TaskBizImpl extends BaseBiz implements ITaskBiz {

	@Autowired
	private ITaskDao teskDao;
	@Autowired
	private ITaskImportBiz importBiz;
	@Autowired
	private IWorkLogDao workLogDao;
	@Autowired
	private IProjectRecourceRefDao projectRecourceRefDao;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.task.ITaskBiz#queryByCondition(com.rionsoft.rcms.
	 * condition.task.TaskCondition, javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public List<TaskBo> queryByCondition(final TaskCondition condition, final HttpServletRequest req) {
		if (condition.getUserName() != null && condition.getUserName() != "") {
			final List<Long> taskIdList = teskDao.queryTaskByUserName(condition.getUserName());
			condition.setPkTaskList(taskIdList);
		}
		condition.setUserName(null);
		// 用户权限判断
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		final String adminLoginCode = PropertyPlaceholderUtils.getContextProperty("adminLoginCode");
		final UserLoginBo bo = (UserLoginBo) WebUtils.getSessionAttribute(req, SessionConstant.ADMIN_LOGIN.name());
		condition.setUserId(userId);
		condition.setAdminLoginCode(adminLoginCode);
		condition.setLoginCode(bo.getLoginCode());

		final List<TaskListEntry> oldEntryList = teskDao.queryTaskByDataCode(condition);
		for (final TaskListEntry entry : oldEntryList) {
			entry.setStatus(TaskStatusEnum.getType(entry.getStatus()));
		}

		return mapListEntry(oldEntryList, TaskBo.class);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.task.ITaskBiz#addTask(com.rionsoft.rcms.bo.task.
	 * TaskBo)
	 */
	@Override
	public void addTask(final TaskBo taskBo) {
		final Date date = new Date();
		if (date.after(taskBo.getExpStartDate())) {
			taskBo.setStatus("1");
		} else {
			taskBo.setStatus("0");
		}
		taskBo.setPercentage((long) 0);
		teskDao.insert(map(taskBo, TaskEntry.class));
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.task.ITaskBiz#queryTaskById(com.rionsoft.rcms.
	 * condition.project.ProjectCondition)
	 */
	@Override
	public TaskBo queryTaskById(final long pkTask) {
		return map(teskDao.queryByID(pkTask), TaskBo.class);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.task.ITaskBiz#updateTask(com.rionsoft.rcms.bo.task.
	 * TaskBo)
	 */
	@Override
	public void updateTask(final TaskBo taskBo) {
		final TaskEntry entry = map(taskBo, TaskEntry.class);
		teskDao.updateSelective(entry);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.task.ITaskBiz#updateStatus(long,
	 * java.lang.String)
	 */
	@Override
	public void updateStatus(final long pkTask, final String status) {
		final TaskEntry entry = new TaskEntry();
		entry.setPkTask(pkTask);
		entry.setStatus(status);
		if (status.equals("5")) {
			entry.setRelEndDate(new java.sql.Date(new Date().getTime()));
		}
		teskDao.updateSelective(entry);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.task.ITaskBiz#deleteTask(java.util.List)
	 */
	@Override
	public void deleteTask(final List<Long> pkList) {
		final List<WorkLogListEntry> entryList = workLogDao.queryWorkLogByPkTask(pkList);
		if (entryList.size() > 0) {
			String code = "";
			for (final WorkLogListEntry entry : entryList) {
				code = code + entry.getTaskCode() + ",";
			}
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0320, false,
					code.substring(0, code.length() - 1));
		}
		teskDao.deleteTask(pkList);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.task.ITaskBiz#queryRefByCondition(com.rionsoft.rcms
	 * .condition.task.taskUserRefCondition)
	 */
	@Override
	public List<TaskUserRefBo> queryRefByCondition(final TaskUserRefCondition condition) {
		return mapListEntry(teskDao.queryRefByCondition(condition), TaskUserRefBo.class);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.task.ITaskBiz#deleteUser(java.util.List)
	 */
	@Override
	public void deleteUser(final List<Long> userList, final long pkTask) {
		List<UserInfoBo> userInfoBo=map(projectRecourceRefDao.queryTaskCountInfo(userList,pkTask),UserInfoBo.class);
        String name = "";
        if(userInfoBo.size()>0){
           for(UserInfoBo bo:userInfoBo){
        	   name = name + bo.getUserName() + ",";
           }
           throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0329, false, name.substring(0, name.length() - 1));
        }
		teskDao.deleteUser(userList, pkTask);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.task.ITaskBiz#queryUserInfoByCondition(com.rionsoft
	 * .rcms.condition.task.taskUserRefCondition)
	 */
	@Override
	public List<TaskUserRefBo> queryUserInfoByCondition(final TaskUserRefCondition condition) {

		return mapListEntry(teskDao.queryUserInfoByCondition(condition), TaskUserRefBo.class);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.task.ITaskBiz#userExcel(com.rionsoft.support.basebo
	 * .common.file.FileUploadBo)
	 */
	@Override
	public int userExcel(final FileUploadBo fileUploadBo) {
		final List<ExcelTaskBo> boList = ReadExcelUtils.readNormalTempleteExcel(fileUploadBo.getTempFile(),
				ExcelTaskBo.class);
		if (CollectionUtils.isEmpty(boList)) {

			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0301, false);
		}
		final List<String> proNameList = new ArrayList<>();
		final List<String> taskCodeList = new ArrayList<>();
		for (final ExcelTaskBo bo : boList) {
			/** 验证项目名称是否为空 **/
			if (bo.getProjName().isEmpty()) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0317, false);
			}
			/** 验证项目名称长度 **/
			if (bo.getProjName().length() > 20) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0303, false, bo.getProjName());
			}
			/** 验证任务名称不为空 **/
			if (bo.getTaskName().isEmpty()) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0304, false);
			}
			/** 验证任务名称长度不超过16 **/
			if (bo.getTaskName().length() > 16) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0305, false, bo.getTaskName());
			}
			/** 验证任务编码不为空 **/
			if (bo.getTaskCode().isEmpty()) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0306, false, bo.getTaskName());
			}
			/** 验证任务编码长度不能超过20位 **/
			if (bo.getTaskCode().length() > 20) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0307, false, bo.getTaskCode());
			}
			/** 验证任务编码是否只是由字母数字和下划线组成 **/
			final String codeEL = "^[a-zA-Z0-9_]{0,}$";
			final Pattern codePattern = Pattern.compile(codeEL);
			final Matcher code = codePattern.matcher(bo.getTaskCode());

			final boolean codeFlag = code.matches();

			if (!codeFlag) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0315, false, bo.getTaskName());
			}

			/** 验证任务工作量是否为空 **/
			if (bo.getWorkload().isEmpty()) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0308, false, bo.getTaskName());
			}
			/** 验证任务工作量长度是否小于5位 **/
			if (bo.getWorkload().length() > 5) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0310, false, bo.getTaskName());
			}
			/** 验证任务工作量是否为整数 **/
			final String EL = "^[0-9]*[1-9][0-9]*$";
			final Pattern workPattern = Pattern.compile(EL);
			final Matcher workLoad = workPattern.matcher(bo.getWorkload());

			final boolean workLoadFlag = workLoad.matches();

			if (!workLoadFlag) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0314, false, bo.getTaskName());
			}
			/** 验证任务工作类型 **/
			if (StringUtils.isEmpty(bo.getTaskType())) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0309, false, bo.getTaskName());
			}

			/** 验证任务工作状态 **/

			if (StringUtils.isEmpty(bo.getStatus())) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0311, false, bo.getTaskName());
			}

			/** 验证任务开始日期和任务结束日期的格式 **/
			final String dateEL = "[0-9]{4}-[0-9]{2}-[0-9]{2}";
			final Pattern p = Pattern.compile(dateEL);
			final Matcher startDate = p.matcher(bo.getExpStartDate());
			final Matcher endDate = p.matcher(bo.getExpEndDate());
			final boolean dateStartFlag = startDate.matches();
			final boolean endDateFlag = endDate.matches();
			if (!dateStartFlag) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0312, false, bo.getTaskName());
			}
			if (!endDateFlag) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0313, false, bo.getTaskName());
			}

			/** 验证任务的起始日期小于结束日期 **/
			final int excStartDate = Integer.parseInt(bo.getExpStartDate().replace("-", "").toString());
			final int excEndDate = Integer.parseInt(bo.getExpEndDate().replace("-", "").toString());
			if (excStartDate > excEndDate) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0316, false, bo.getTaskName());
			}
			proNameList.add(bo.getProjName());
			taskCodeList.add(bo.getTaskCode());
			bo.setStatus(TaskStatusEnum.getCode(bo.getStatus()));
			bo.setTaskType(TaskTypeEnum.getCode(bo.getTaskType()));
		}

		final String codeList = teskDao.checkTaskCode(taskCodeList);
		if (codeList != null) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0318, false, codeList);
		}

		final List<ProjectEntry> proEntryList = teskDao.queryProjectByName(proNameList);
		for (final ProjectEntry entry : proEntryList) {
			for (final ExcelTaskBo bo : boList) {
				if (bo.getProjName().equals(entry.getProjName())) {
					bo.setPkProj(entry.getPkProj());
				}
			}
		}

		for (final ExcelTaskBo bo : boList) {
			if (bo.getPkProj() == null) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0302, false, bo.getProjName());
			}
		}
		return importBiz.importTaskList(boList);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.task.ITaskBiz#projectQuery(com.rionsoft.rcms.
	 * condition.project.ProjectCondition)
	 */
	@Override
	public List<ProjectBo> projectQuery(final long userId) {
		return map(teskDao.projectQuery(userId), ProjectBo.class);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.task.ITaskBiz#queryTaskByUserId(long)
	 */
	@Override
	public List<TaskBo> queryTaskByUserId(final long userId) {
		return mapListEntry(teskDao.queryTaskByUserId(userId), TaskBo.class);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.task.ITaskBiz#queryTaskByPkProj(long)
	 */
	@Override
	public List<TaskBo> queryTaskByPkProj(long pkProj) {
		return map(teskDao.queryTaskByPkProj(pkProj), TaskBo.class);
	}

}
