/**
 *
 */
package com.rionsoft.rcms.dao.task.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.task.TaskUserRefListEntry;
import com.rionsoft.rcms.dao.task.ITaskMapper;
import com.rionsoft.rcms.dao.task.ITaskUserRefDao;
import com.rionsoft.rcms.entry.task.TaskUserRefEntry;
import com.rionsoft.rcms.entry.workLog.WorkLogEntry;
import com.rionsoft.support.mybatisplugin.dao.common.annotation.GenerateId;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author loujie
 * @data 2017年4月27日
 */
@Repository
@GenerateId(value = false)
public class TaskUserRefDaoImpl extends SingleTableDao<TaskUserRefEntry> implements ITaskUserRefDao {

	@Autowired
	private ITaskMapper taskMapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.task.ITaskUserRefDao#queryByPkTask(long)
	 */
	@Override
	public List<TaskUserRefListEntry> queryByPkTask(final List<WorkLogEntry> entryList) {
		return taskMapper.queryByPkTask(entryList);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.task.ITaskUserRefDao#updateUserRef(com.rionsoft.
	 * rcms.entry.task.TaskUserRefEntry)
	 */
	@Override
	public void updateUserRef(final TaskUserRefEntry userEntry) {
		taskMapper.updateUserRef(userEntry);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.task.ITaskUserRefDao#queryByUserId(long)
	 */
	@Override
	public List<TaskUserRefEntry> queryByUserId(final long userId) {
		final HashMap<String, Object> model = new HashMap<>();
		model.put("USER_ID", userId);
		return queryListByColumns(model);
	}

}
