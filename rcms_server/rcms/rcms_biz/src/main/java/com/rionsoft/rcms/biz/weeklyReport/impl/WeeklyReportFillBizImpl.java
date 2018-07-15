package com.rionsoft.rcms.biz.weeklyReport.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rionsoft.rcms.biz.weeklyReport.IWeeklyReportFillBiz;
import com.rionsoft.rcms.bo.weeklyReport.ProjectRptWeeklyBo;
import com.rionsoft.rcms.condition.weeklyReport.ProjectRptWeeklyCondition;
import com.rionsoft.rcms.dao.weeklyReport.IWeeklyReportFillDao;
import com.rionsoft.rcms.entry.weeklyReport.ProjectRptWeeklyEntry;
import com.rionsoft.support.biz.BaseBiz;
/**
 * @author 刘教练
 * @date 2017年9月29日
 */
@Service
public class WeeklyReportFillBizImpl extends BaseBiz implements IWeeklyReportFillBiz {
	@Autowired
	private IWeeklyReportFillDao weeklyReportFillDao;
	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.weeklyReport.IWeeklyReportFillBiz#weeklyReportFillStartTime(java.lang.Long)
	 */
	@Override
	public List<ProjectRptWeeklyBo> weeklyReportFillList(Long pkProj) {
		return map(weeklyReportFillDao.weeklyReportFillList(pkProj),ProjectRptWeeklyBo.class);
	}
	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.weeklyReport.IWeeklyReportFillBiz#insertWeeklyReport(com.rionsoft.rcms.bo.weeklyReport.ProjectRptWeeklyBo)
	 */
	@Override
	public long insertWeeklyReport(ProjectRptWeeklyBo rptWeeklyBo) {
		return weeklyReportFillDao.insert(map(rptWeeklyBo,ProjectRptWeeklyEntry.class));
	}
	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.weeklyReport.IWeeklyReportFillBiz#weeklyReportListCondition(com.rionsoft.rcms.condition.weeklyReport.ProjectRptWeeklyCondition)
	 */
	@Override
	public List<ProjectRptWeeklyBo> weeklyReportListGistProject(ProjectRptWeeklyCondition rptWeeklyCondition) {
		return mapListEntry(weeklyReportFillDao.weeklyReportListGistProject(rptWeeklyCondition),ProjectRptWeeklyBo.class);
	}
	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.weeklyReport.IWeeklyReportFillBiz#updateWeeklyReportByProRptId(com.rionsoft.rcms.bo.weeklyReport.ProjectRptWeeklyBo)
	 */
	@Override
	public boolean updateWeeklyReportByProRptId(ProjectRptWeeklyBo rptWeeklyBo) {
		return weeklyReportFillDao.updateSelective(map(rptWeeklyBo,ProjectRptWeeklyEntry.class));
	}

}
