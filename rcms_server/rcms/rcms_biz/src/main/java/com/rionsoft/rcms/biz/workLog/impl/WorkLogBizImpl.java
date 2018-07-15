/**
 *
 */
package com.rionsoft.rcms.biz.workLog.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rionsoft.rcms.biz.workLog.IWorkLogBiz;
import com.rionsoft.rcms.biz.workLog.IWorkLogImportBiz;
import com.rionsoft.rcms.bo.workLog.WorkLogBo;
import com.rionsoft.rcms.condition.task.TaskUserRefListEntry;
import com.rionsoft.rcms.condition.workLog.WorkLogCondition;
import com.rionsoft.rcms.dao.task.ITaskDao;
import com.rionsoft.rcms.dao.task.ITaskUserRefDao;
import com.rionsoft.rcms.dao.workLog.IWorkLogDao;
import com.rionsoft.rcms.entry.task.TaskEntry;
import com.rionsoft.rcms.entry.task.TaskUserRefEntry;
import com.rionsoft.rcms.entry.workLog.WorkLogEntry;
import com.rionsoft.support.basebo.view.ExportFileBo;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

/**
 * @author loujie
 * @data 2017年4月30日
 */
@Service
public class WorkLogBizImpl extends BaseBiz implements IWorkLogBiz {

	@Autowired
	private IWorkLogDao workLogDao;
	@Autowired
	private ITaskUserRefDao userRefDao;
	@Autowired
	private ITaskDao taskDao;
	@Autowired
	private IWorkLogImportBiz importBiz;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.workLog.IWorkLogBiz#queryWorkByCondition(com.
	 * rionsoft.rcms.condition.workLog.WorkLogCondition)
	 */
	@Override
	public List<WorkLogBo> queryWorkByCondition(final WorkLogCondition condition) {
		final Calendar calendar = Calendar.getInstance();
		final SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		format.format(calendar.getTime());
		final ArrayList<Date> list = new ArrayList<>();
		calendar.add(Calendar.DATE, condition.getDateId());
		format.format(calendar.getTime());
		final int week = calendar.get(Calendar.DAY_OF_WEEK);
		if (week == 1) {
			calendar.add(Calendar.DATE, -1);
		}
		calendar.setFirstDayOfWeek(Calendar.MONDAY);
		calendar.add(Calendar.DATE, calendar.getFirstDayOfWeek() - week);
		try {
			list.add(format.parse(format.format(calendar.getTime())));
			for (int i = 0; i < 6; i++) {
				calendar.add(Calendar.DATE, 1);
				list.add(format.parse(format.format(calendar.getTime())));
			}
		} catch (final ParseException e) {
			e.printStackTrace();
		}
		final List<WorkLogBo> daysumList = mapListEntry(
				workLogDao.queryDaySum(condition.getUserId(), condition.getDateId()), WorkLogBo.class);
		return workLogList(condition, list, daysumList, false);
	}

	@Override
	public List<WorkLogBo> queryMonthByCondition(final WorkLogCondition condition) {
		final Calendar calendar = Calendar.getInstance();
		final SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		format.format(calendar.getTime());
		final ArrayList<Date> list = new ArrayList<>();
		final int days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		try {
			list.add(format.parse(format.format(calendar.getTime())));
			for (int i = 0; i < days - 1; i++) {
				calendar.add(Calendar.DAY_OF_MONTH, 1);
				list.add(format.parse(format.format(calendar.getTime())));
			}
		} catch (final ParseException e) {
			e.printStackTrace();
		}
		final List<WorkLogBo> daysumList = mapListEntry(workLogDao.queryMonthDaySum(condition.getUserId()),
				WorkLogBo.class);
		return workLogList(condition, list, daysumList, true);
	}

	@SuppressWarnings("deprecation")
	private List<WorkLogBo> workLogList(final WorkLogCondition condition, final ArrayList<Date> list,
			final List<WorkLogBo> daysumList, final boolean boole) {
		final String[] weekOfDays = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" };
		final Date currentDate = new Date();
		List<WorkLogBo> boList = null;
		if (boole) {
			boList = mapListEntry(workLogDao.queryMonthByCondition(condition), WorkLogBo.class);
		} else {
			boList = mapListEntry(workLogDao.queryWorkByCondition(condition), WorkLogBo.class);
		}
		final List<WorkLogBo> workList = new ArrayList<>();
		for (final WorkLogBo sumBo : daysumList) {
			if (sumBo.getRelSum() <= 0) {
				int sum = 0;
				final int daySum = sumBo.getDaySum();
				final int weekSum = sumBo.getWeekSum();
				if (daySum <= weekSum) {
					sum = weekSum - daySum;
				}
				for (int i = sum, len = list.size(); i < len; i++) {
					final WorkLogBo newBo = new WorkLogBo();
					newBo.setToday(currentDate);
					newBo.setWhatday(weekOfDays[list.get(i).getDay()]);
					newBo.setTheDay(list.get(i));
					newBo.setTaskCode(sumBo.getTaskCode());
					newBo.setTaskName(sumBo.getTaskName());
					newBo.setPkTask(sumBo.getPkTask());
					newBo.setProjName(sumBo.getProjName());
					newBo.setExpStratDate(sumBo.getExpStratDate());
					for (final WorkLogBo bo : boList) {
						final long boTask = bo.getPkTask();
						final long newboTask = newBo.getPkTask();
						if (boTask == newboTask && bo.getLogDate() != null) {
							if (bo.getLogDate().getTime() == newBo.getTheDay().getTime()) {
								newBo.setPkWorkLog(bo.getPkWorkLog());
								newBo.setLogDate(bo.getLogDate());
								newBo.setWorkTime(bo.getWorkTime());
								newBo.setOverWorkTime(bo.getOverWorkTime());
								newBo.setOverWorkReason(bo.getOverWorkReason());
								newBo.setWorkDesc(bo.getWorkDesc());
								newBo.setPercentage(bo.getPercentage());
								newBo.setIsVerfied(bo.getIsVerfied());
							}
						}
					}
					if (sumBo.getRelEndDate() != null && sumBo.getStatus().equals("5")
							&& newBo.getTheDay().getTime() > sumBo.getRelEndDate().getTime()) {
						break;
					}
					workList.add(newBo);
					if (newBo.getPercentage() != null && newBo.getPercentage() == 100) {
						break;
					}
				}
			}
		}
		Collections.sort(workList, new Comparator<WorkLogBo>() {
			@Override
			public int compare(final WorkLogBo o1, final WorkLogBo o2) {
				final int flag = o1.getTheDay().compareTo(o2.getTheDay());
				return flag;
			}
		});
		return workList;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.workLog.IWorkLogBiz#workLogAdd(com.rionsoft.rcms.bo
	 * .workLog.WorkLogBo)
	 */
	@Override
	@Transactional
	public void workLogAdd(final List<WorkLogBo> boList) {
		final List<WorkLogEntry> entryList = mapToEntryList(boList, WorkLogEntry.class);
		final long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		final List<TaskUserRefEntry> taskList = userRefDao.queryByUserId(userId);
		final List<TaskUserRefListEntry> taskEntryList = userRefDao.queryByPkTask(entryList);
		for (final TaskUserRefEntry taskEntry : taskList) {
			final long aId = taskEntry.getPkTask();
			final List<Long> penList = new ArrayList<>();
			for (final WorkLogEntry entry : entryList) {
				entry.setUserId(userId);
				final long bId = entry.getPkTask();
				if (aId == bId) {
					final Calendar cal = Calendar.getInstance();
					cal.setTime(entry.getLogDate());
					final int weekday = cal.get(Calendar.DAY_OF_WEEK) - 1;
					final boolean weekdayBoole = (weekday == 0 || weekday == 6) ? true : false;
					final boolean percentageBoole = (entry.getPercentage() == null) ? true : false;
					final boolean workdirBoole = (entry.getWorkDesc().equals("") || entry.getWorkDesc() == null) ? true
							: false;
					if (weekdayBoole && percentageBoole && workdirBoole) {
						continue;
					}
					penList.add(entry.getPercentage());
				}
			}
			if (penList.size() > 0) {
				Collections.sort(penList);
				final TaskUserRefEntry userEntry = new TaskUserRefEntry();
				userEntry.setPkTask(taskEntry.getPkTask());
				userEntry.setUserId(userId);
				userEntry.setPercentage(penList.get(penList.size() - 1));
				final Long percentage = userEntry.getPercentage();
				if (percentage == 100) {
					for (final WorkLogEntry entry : entryList) {
						final long eid = entry.getPkTask();
						final long uid = userEntry.getPkTask();
						if (eid == uid) {
							if (entry.getPercentage() == 100) {
								final java.sql.Date sqlDate = entry.getLogDate();
								if (taskEntry.getRelEndDate() == null || !sqlDate.equals(taskEntry.getRelEndDate())) {
									userEntry.setRelEndDate(sqlDate);
								} else {
									userEntry.setRelEndDate(taskEntry.getRelEndDate());
								}
							}
						}
					}
				}
				userRefDao.updateUserRef(userEntry);

				long day = 0;
				long pen = penList.get(penList.size() - 1);
				for (final TaskUserRefListEntry refEntry : taskEntryList) {
					final long cId = refEntry.getPkTask();
					if (aId == cId) {
						day = day + 1;
						if (refEntry.getUserId() != userId) {
							pen = pen + refEntry.getPercentage();
						}
					}
				}
				final long aaa = pen / day;
				final TaskEntry tEntry = new TaskEntry();
				if (aaa == 100) {
					for (final WorkLogEntry entry : entryList) {
						if (entry.getPercentage() == 100) {
							final long bId = entry.getPkTask();
							if (aId == bId) {
								final java.sql.Date maxDate = workLogDao.selectMaxLogDateCamp(bId);
								if (maxDate != null && maxDate.getTime() >= entry.getLogDate().getTime()) {
									tEntry.setRelEndDate(maxDate);
								} else {
									tEntry.setRelEndDate(entry.getLogDate());
								}
							}
						}
					}
					tEntry.setStatus("2");
				} else if (aaa > 0) {
					tEntry.setStatus("1");
				}

				tEntry.setPkTask(aId);
				tEntry.setPercentage(aaa);
				taskDao.updateSelective(tEntry);
			}
		}
		workLogDao.deleteList(entryList);
		importBiz.insertWorkLogList(entryList);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.workLog.IWorkLogBiz#exportWorkLog(java.util.List,
	 * java.lang.String, java.lang.String)
	 */
	@Override
	public ExportFileBo<Map<String, Object>> exportWorkLog(final List<Long> pkWorkLogList) {
		final List<Map<String, Object>> listMap = workLogDao.queryWorkLogExprot(pkWorkLogList);
		for (final Map<String, Object> map : listMap) {
			final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			final String s = sdf.format((Date) map.get("logDate"));
			map.put("logDate", s);
		}
		final String[] fieldNames = { "projName", "taskName", "userName", "logDate", "workTime", "overWorkTime",
				"percentage", "workDesc" };
		final String[] columnName = { "项目名称", "任务名称", "用户姓名", "日志日期", "正常工时", "加班工时", "完成百分比", "工作内容描述" };

		final LinkedHashMap<String, String> fieldMap = new LinkedHashMap<>();

		for (int i = 0; i < fieldNames.length; i++) {
			fieldMap.put(fieldNames[i], columnName[i]);
		}

		final String sheetName = "工作日志表";
		final String fileName = "工作日志详情";
		final String fileType = "xlsx";
		final ExportFileBo<Map<String, Object>> fileBo = new ExportFileBo<Map<String, Object>>(fileName, fileType);
		fileBo.setDataList(listMap);
		fileBo.setFieldMap(fieldMap);
		fileBo.setSheetName(sheetName);
		return fileBo;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.workLog.IWorkLogBiz#selectWorkCount(long)
	 */
	@Override
	public Map<String, String> selectMonthWorkInfo() {
		final long uesrId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		return returnElementMap(mapListEntry(workLogDao.selectMonthWorkInfo(uesrId), WorkLogBo.class));
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.workLog.IWorkLogBiz#selectNonCurrent(long)
	 */
	@Override
	public Map<String, String> selectWeekWorkInfo(final long dateId) {
		final long uesrId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		return returnElementMap(mapListEntry(workLogDao.selectWeekWorkInfo(uesrId, dateId), WorkLogBo.class));
	}

	/**
	 * 任务状态、百分百、此周之前最大百分百及其对应的最大日期、此周之后最小百分百及其对应日期
	 *
	 * @param entry
	 * @return map
	 */
	private Map<String, String> returnElementMap(final List<WorkLogBo> entry) {
		final Map<String, String> map = new HashMap<>();
		for (final WorkLogBo workLogBo : entry) {
			map.put(workLogBo.getTaskCode() + "status", workLogBo.getStatus());
			if (workLogBo.getPercentage() != null) {
				map.put(workLogBo.getTaskCode() + "percentage", workLogBo.getPercentage() + "");
			}
			if (workLogBo.getExpStratDate() != null) {
				map.put(workLogBo.getTaskCode() + "maxPercentage", workLogBo.getDaySum() + "");
				map.put(workLogBo.getTaskCode() + "maxLogDate",
						DateFormatUtils.ISO_DATE_FORMAT.format(workLogBo.getExpStratDate()));
			}
			if (workLogBo.getExpEndDate() != null) {
				map.put(workLogBo.getTaskCode() + "minPercentage", workLogBo.getRelSum() + "");
				map.put(workLogBo.getTaskCode() + "minLogDate",
						DateFormatUtils.ISO_DATE_FORMAT.format(workLogBo.getExpEndDate()));
			}
		}
		return map;
	}
}
