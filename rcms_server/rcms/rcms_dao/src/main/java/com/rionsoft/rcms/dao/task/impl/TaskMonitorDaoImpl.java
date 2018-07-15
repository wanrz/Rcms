/**
 *
 */
package com.rionsoft.rcms.dao.task.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.project.ProjMonitorCondition;
import com.rionsoft.rcms.condition.project.ProjMonitorListEntry;
import com.rionsoft.rcms.condition.task.TaskCondition;
import com.rionsoft.rcms.condition.task.TaskListEntry;
import com.rionsoft.rcms.condition.task.TaskMonitorCondition;
import com.rionsoft.rcms.condition.task.TaskUserRefListEntry;
import com.rionsoft.rcms.dao.task.ITaskMonitorDao;
import com.rionsoft.rcms.dao.task.ITaskMonitorMapper;
import com.rionsoft.rcms.entry.task.TaskEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author likeke
 * @date 2017年5月1日
 */
@Repository
public class TaskMonitorDaoImpl extends SingleTableDao<TaskEntry> implements ITaskMonitorDao {

	@Autowired
	private ITaskMonitorMapper taskMonitorMapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.task.ITaskMonitorDao#queryProgressDetail(com.
	 * rionsoft.rcms.condition.task.TaskMonitorCondition)
	 */
	@Override
	public List<TaskUserRefListEntry> queryProgressDetail(final TaskMonitorCondition condition) {

		return taskMonitorMapper.queryProgressDetail(condition);
	}

	@Override
	public List<ProjMonitorListEntry> queryProjMonitor(final ProjMonitorCondition condition) {
		return taskMonitorMapper.queryProjMonitor(condition);
	}

	@Override
	public int queryTask(final long pkProj) {
		return taskMonitorMapper.queryTask(pkProj);
	}

	@Override
	public int projPercent(final long pkProj) {
		return taskMonitorMapper.projPercent(pkProj);
	}

	@Override
	public List<TaskListEntry> queryTaskMonitor(final TaskCondition condition) {
		return taskMonitorMapper.queryTaskMonitor(condition);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.rionsoft.rcms.dao.task.ITaskMonitorDao#queryMonitorByDataCode(com.
	 * rionsoft.rcms.condition.project.ProjMonitorCondition)
	 */
	@Override
	public List<ProjMonitorListEntry> queryMonitorByDataCode(ProjMonitorCondition projectCondition) {
		return taskMonitorMapper.queryMonitorByDataCode(projectCondition);
	}

}
