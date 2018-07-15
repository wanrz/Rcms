/**
 *
 */
package com.rionsoft.rcms.dao.task;

import java.util.List;

import com.rionsoft.rcms.condition.task.TaskUserRefListEntry;
import com.rionsoft.rcms.entry.task.TaskUserRefEntry;
import com.rionsoft.rcms.entry.workLog.WorkLogEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.ITableInsertList;

/**
 * @author loujie
 * @data 2017年4月27日
 */
public interface ITaskUserRefDao extends ISingleTableDao<TaskUserRefEntry>, ITableInsertList<TaskUserRefEntry> {

	/**
	 * 根据pkTask查询所有数据
	 *
	 * @author loujie
	 * @data 2017年5月1日
	 * @param entryList
	 * @return list
	 */
	List<TaskUserRefListEntry> queryByPkTask(List<WorkLogEntry> entryList);

	/**
	 * 修改任务完成百分比
	 *
	 * @author loujie
	 * @data 2017年5月1日
	 * @param userEntry
	 */
	void updateUserRef(TaskUserRefEntry userEntry);

	/**
	 * 查询该人员的所有任务
	 *
	 * @author loujie
	 * @data 2017年5月4日
	 * @param userId
	 * @return list
	 */
	List<TaskUserRefEntry> queryByUserId(long userId);

}
