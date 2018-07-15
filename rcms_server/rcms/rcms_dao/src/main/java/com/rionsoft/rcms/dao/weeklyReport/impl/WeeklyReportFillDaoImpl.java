package com.rionsoft.rcms.dao.weeklyReport.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.project.ProjectCondition;
import com.rionsoft.rcms.condition.weeklyReport.ProjectRptWeeklyCondition;
import com.rionsoft.rcms.condition.weeklyReport.ProjectRptWeeklyListEntry;
import com.rionsoft.rcms.dao.weeklyReport.IWeeklyReportFillDao;
import com.rionsoft.rcms.dao.weeklyReport.IWeeklyReportFillMapper;
import com.rionsoft.rcms.entry.weeklyReport.ProjectRptWeeklyEntry;
import com.rionsoft.support.mybatisplugin.dao.common.annotation.GenerateId;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;
/**
 * @author 刘教练
 * @date 2017年10月9日
 */
@Repository
@GenerateId(value = true)
class WeeklyReportFillDaoImpl extends SingleTableDao<ProjectRptWeeklyEntry> implements IWeeklyReportFillDao {
    @Autowired
	private IWeeklyReportFillMapper weeklyReportFillMapper;
	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.weeklyReport.IWeelykReportFillDao#weeklyReportFillStartTime(java.lang.Long)
	 */
	@Override
	public List<ProjectRptWeeklyEntry> weeklyReportFillList(Long pkProj) {
		return weeklyReportFillMapper.weeklyReportFillList(pkProj);
	}
	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.weeklyReport.IWeeklyReportFillDao#weeklyReportListCondition(com.rionsoft.rcms.condition.weeklyReport.ProjectRptWeeklyCondition)
	 */
	@Override
	public List<ProjectRptWeeklyListEntry> weeklyReportListGistProject(ProjectRptWeeklyCondition rptWeeklyCondition) {
		return weeklyReportFillMapper.weeklyReportListGistProject(rptWeeklyCondition);
	}
	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.weeklyReport.IWeeklyReportFillDao#weeklyReportListManagerAbove(com.rionsoft.rcms.condition.weeklyReport.ProjectRptWeeklyCondition)
	 */
	@Override
	public List<ProjectRptWeeklyListEntry> weeklyReportListManagerAbove(ProjectCondition projectCondition) {
		return weeklyReportFillMapper.weeklyReportListManagerAbove(projectCondition);
	}
}
