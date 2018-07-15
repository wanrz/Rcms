/**
 *
 */
package com.rionsoft.rcms.dao.workLog.impl;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.workLog.WorkLogCondition;
import com.rionsoft.rcms.condition.workLog.WorkLogListEntry;
import com.rionsoft.rcms.condition.workLog.WorkLogViewCondition;
import com.rionsoft.rcms.dao.workLog.IWorkLogDao;
import com.rionsoft.rcms.dao.workLog.IWorkLogMapper;
import com.rionsoft.rcms.entry.workLog.WorkLogEntry;
import com.rionsoft.support.mybatisplugin.dao.common.annotation.GenerateId;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author loujie
 * @data 2017年4月30日
 */
@Repository
@GenerateId(value = true)
public class WorkLogDaoImpl extends SingleTableDao<WorkLogEntry> implements IWorkLogDao {

	@Autowired
	private IWorkLogMapper workLogMapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.workLog.IWorkLogDao#queryWorkByCondition(com.
	 * rionsoft.rcms.condition.workLog.WorkLogCondition)
	 */
	@Override
	public List<WorkLogListEntry> queryWorkByCondition(final WorkLogCondition condition) {
		return workLogMapper.queryWorkByCondition(condition);
	}

	@Override
	public List<WorkLogListEntry> queryMonthByCondition(final WorkLogCondition condition) {
		return workLogMapper.queryMonthByCondition(condition);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.workLog.IWorkLogDao#queryWorkLogExprot(java.util.
	 * List, long)
	 */
	@Override
	public List<Map<String, Object>> queryWorkLogExprot(final List<Long> pkWorkLogList) {
		return workLogMapper.queryWorkLogExprot(pkWorkLogList);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.workLog.IWorkLogDao#queryWorkLogByPkTask(java.util.
	 * List)
	 */
	@Override
	public List<WorkLogListEntry> queryWorkLogByPkTask(final List<Long> pkList) {
		return workLogMapper.queryWorkLogByPkTask(pkList);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.workLog.IWorkLogDao#queryDaySum(long)
	 */
	@Override
	public List<WorkLogListEntry> queryDaySum(final long userId, final int dateId) {
		return workLogMapper.queryDaySum(userId, dateId);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.workLog.IWorkLogDao#queryMonthDaySum(long)
	 */
	@Override
	public List<WorkLogListEntry> queryMonthDaySum(final long userId) {
		return workLogMapper.queryMonthDaySum(userId);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.workLog.IWorkLogDao#deleteList(java.util.List)
	 */
	@Override
	public void deleteList(final List<WorkLogEntry> entryList) {
		workLogMapper.deleteList(entryList);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.workLog.IWorkLogDao#queryWorkLogUserCount(long)
	 */
	@Override
	public int queryWorkLogUserCount(final long userId) {
		final Map<String, Object> map = new HashMap<>();
		map.put("USER_ID", userId);
		return super.queryCountByColumns(map);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.workLog.IWorkLogDao#selectWorkCount(long,
	 * long)
	 */
	@Override
	public List<WorkLogListEntry> selectMonthWorkInfo(final long uesrId) {
		return workLogMapper.selectMonthWorkInfo(uesrId);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.workLog.IWorkLogDao#selectNonCurrent(long,
	 * long)
	 */
	@Override
	public List<WorkLogListEntry> selectWeekWorkInfo(final long userId, final long dateId) {
		return workLogMapper.selectWeekWorkInfo(userId, dateId);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.workLog.IWorkLogDao#queryWorkLogViewList(com.
	 * rionsoft.rcms.condition.workLog.WorkLogViewCondition)
	 */
	@Override
	public List<WorkLogListEntry> queryWorkLogViewList(final WorkLogViewCondition logViewCondition) {
		return workLogMapper.queryWorkLogViewList(logViewCondition);
	}

	@Override
	public Date selectMaxLogDateCamp(final Long pkTask) {
		return workLogMapper.selectMaxLogDateCamp(pkTask);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.workLog.IWorkLogDao#workLogViewVisual(java.lang.
	 * Long, java.lang.Long)
	 */
	@Override
	public List<WorkLogListEntry> workLogViewVisual(final Long pkProj, final Long userId, final long dateId) {
		return workLogMapper.workLogViewVisual(pkProj, userId, dateId);
	}
}
