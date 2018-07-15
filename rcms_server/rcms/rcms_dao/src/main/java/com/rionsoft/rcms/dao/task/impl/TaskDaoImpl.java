/**
 *
 */
package com.rionsoft.rcms.dao.task.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.task.TaskCondition;
import com.rionsoft.rcms.condition.task.TaskListEntry;
import com.rionsoft.rcms.condition.task.TaskUserRefCondition;
import com.rionsoft.rcms.condition.task.TaskUserRefListEntry;
import com.rionsoft.rcms.dao.task.ITaskDao;
import com.rionsoft.rcms.dao.task.ITaskMapper;
import com.rionsoft.rcms.entry.project.ProjectEntry;
import com.rionsoft.rcms.entry.task.TaskEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author loujie
 * @data 2017年4月25日
 */
@Repository
public class TaskDaoImpl extends SingleTableDao<TaskEntry> implements ITaskDao {

	@Autowired
	private ITaskMapper teskMapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.tesk.ITeskDao#queryByCondition(com.rionsoft.rcms.
	 * condition.tesk.teskCondition)
	 */
	@Override
	public List<TaskListEntry> queryByCondition(final TaskCondition condition) {
		return teskMapper.queryByCondition(condition);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.task.ITaskDao#deleteTask(java.util.List)
	 */
	@Override
	public void deleteTask(final List<Long> pkList) {
		super.deleteListByIdList(pkList);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.task.ITaskDao#queryRefByCondition(com.rionsoft.rcms
	 * .condition.task.taskUserRefCondition)
	 */
	@Override
	public List<TaskUserRefListEntry> queryRefByCondition(final TaskUserRefCondition condition) {
		return teskMapper.queryRefByCondition(condition);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.task.ITaskDao#deleteUser(java.util.List)
	 */
	@Override
	public void deleteUser(final List<Long> userList, final long pkTask) {
		teskMapper.deleteUser(userList, pkTask);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.task.ITaskDao#queryUserInfoByCondition(com.rionsoft
	 * .rcms.condition.task.taskUserRefCondition)
	 */
	@Override
	public List<TaskUserRefListEntry> queryUserInfoByCondition(final TaskUserRefCondition condition) {
		return teskMapper.queryUserInfoByCondition(condition);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.project.IProjectDao#queryProjectByName(java.util.
	 * List)
	 */
	@Override
	public List<ProjectEntry> queryProjectByName(final List<String> proNameList) {
		return teskMapper.queryProjectByName(proNameList);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.task.ITaskDao#checkTaskCode(java.util.List)
	 */
	@Override
	public String checkTaskCode(final List<String> taskCodeList) {
		return teskMapper.checkTaskCode(taskCodeList);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.task.ITaskDao#projectQuery(long)
	 */
	@Override
	public List<ProjectEntry> projectQuery(final long userId) {
		return teskMapper.projectQuery(userId);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.task.ITaskDao#queryTaskByUserId(long)
	 */
	@Override
	public List<TaskListEntry> queryTaskByUserId(final long userId) {
		return teskMapper.queryTaskByUserId(userId);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.rionsoft.rcms.dao.task.ITaskDao#queryTaskByDataCode(com.rionsoft.rcms
	 * .condition.task.TaskCondition)
	 */
	@Override
	public List<TaskListEntry> queryTaskByDataCode(TaskCondition condition) {
		return teskMapper.queryTaskByDataCode(condition);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.task.ITaskDao#queryTaskByUserName(java.lang.String)
	 */
	@Override
	public List<Long> queryTaskByUserName(String userName) {
		return teskMapper.queryTaskByUserName(userName);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.task.ITaskDao#queryTaskByPkProj(long)
	 */
	@Override
	public List<TaskEntry> queryTaskByPkProj(long pkProj) {
		return teskMapper.queryTaskByPkProj(pkProj);
	}

}
