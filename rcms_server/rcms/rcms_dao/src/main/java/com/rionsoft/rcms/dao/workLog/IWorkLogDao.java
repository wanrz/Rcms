/**
 *
 */
package com.rionsoft.rcms.dao.workLog;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.rionsoft.rcms.condition.workLog.WorkLogCondition;
import com.rionsoft.rcms.condition.workLog.WorkLogListEntry;
import com.rionsoft.rcms.condition.workLog.WorkLogViewCondition;
import com.rionsoft.rcms.entry.workLog.WorkLogEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.ITableInsertList;

/**
 * @author loujie
 * @data 2017年4月30日
 */
public interface IWorkLogDao extends ISingleTableDao<WorkLogEntry>, ITableInsertList<WorkLogEntry> {

	/**
	 * 查询工作日志
	 *
	 * @author loujie
	 * @data 2017年4月30日
	 * @param condition
	 * @return list
	 */
	List<WorkLogListEntry> queryWorkByCondition(WorkLogCondition condition);

	/**
	 * 查询工作日志
	 *
	 * @author 刘教练
	 * @date 2017年8月28日
	 * @param condition
	 * @return list
	 */
	List<WorkLogListEntry> queryMonthByCondition(WorkLogCondition condition);

	/**
	 * 查询要导出的数据
	 *
	 * @author loujie
	 * @data 2017年5月2日
	 * @param pkWorkLogList
	 * @return list
	 */
	List<Map<String, Object>> queryWorkLogExprot(List<Long> pkWorkLogList);

	/**
	 * 查询任务是否填写过工作日志
	 *
	 * @author loujie
	 * @data 2017年5月2日
	 * @param pkList
	 * @return list
	 */
	List<WorkLogListEntry> queryWorkLogByPkTask(List<Long> pkList);

	/**
	 * 查询任务当前日期和任务开始日期的差值以及任务状态和百分百
	 *
	 * @author loujie
	 * @data 2017年5月3日
	 * @param userId
	 * @param dateId
	 * @return list
	 */
	List<WorkLogListEntry> queryDaySum(long userId, int dateId);

	/**
	 * 查询任务当前日期和任务开始日期的差值以及任务状态和百分百
	 *
	 * @author 刘教练
	 * @date 2017年8月23日
	 * @param userId
	 * @return list
	 */
	List<WorkLogListEntry> queryMonthDaySum(long userId);

	/**
	 * 新增日志时先删除原先当天的日志
	 *
	 * @author loujie
	 * @param entryList
	 * @data 2017年5月4日
	 */
	void deleteList(List<WorkLogEntry> entryList);

	/**
	 * 查询此周任务的信息
	 *
	 * @author 刘教练
	 * @date 2017年8月25日
	 * @param uesrId
	 * @return List<WorkLogListEntry>
	 */
	List<WorkLogListEntry> selectMonthWorkInfo(long uesrId);

	/**
	 * 查询此周任务的信息
	 *
	 * @author 刘教练
	 * @date 2017年8月31日
	 * @param dateId
	 * @param uesrId
	 * @return List<WorkLogListEntry>
	 */
	List<WorkLogListEntry> selectWeekWorkInfo(long uesrId, long dateId);

	/**
	 * 删除人员
	 *
	 * @author 刘教练
	 * @date 2017年8月16日
	 * @param userId
	 * @return int
	 */
	int queryWorkLogUserCount(long userId);

	/**
	 * 查看所管理的员工的日志
	 *
	 * @author 刘教练
	 * @date 2017年10月26日
	 * @param logViewCondition
	 * @return list
	 */
	List<WorkLogListEntry> queryWorkLogViewList(WorkLogViewCondition logViewCondition);

	/**
	 * 通过任务id搜索任务百分比为一百的日志
	 *
	 * @author 刘教练
	 * @date 2017年11月2日
	 * @param pkTask
	 * @return Date
	 */
	Date selectMaxLogDateCamp(Long pkTask);

	/**
	 * 通过项目Id和人员Id查询日志
	 *
	 * @author 刘教练
	 * @date 2017年11月2日
	 * @param pkProj
	 * @param userId
	 * @param dateId
	 * @return list
	 */
	List<WorkLogListEntry> workLogViewVisual(final Long pkProj, final Long userId, final long dateId);

}
