package com.rionsoft.rcms.dao.weeklyReport;

import java.util.List;

import com.rionsoft.rcms.condition.project.ProjectCondition;
import com.rionsoft.rcms.condition.weeklyReport.ProjectRptWeeklyCondition;
import com.rionsoft.rcms.condition.weeklyReport.ProjectRptWeeklyListEntry;
import com.rionsoft.rcms.entry.weeklyReport.ProjectRptWeeklyEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;

/**
 * @author 刘教练
 * @date 2017年10月9日
 */
public interface IWeeklyReportFillDao extends ISingleTableDao<ProjectRptWeeklyEntry> {
	/**
	 * 查询项目周报每周的开始日期
	 *
	 * @author 刘教练
	 * @date 2017年10月9日
	 * @param pkProj
	 * @return List<ProjectRptWeeklyEntry>
	 */
	List<ProjectRptWeeklyEntry> weeklyReportFillList(Long pkProj);

	/**
	 * 查询周报列表
	 *
	 * @author 刘教练
	 * @date 2017年10月10日
	 * @param rptWeeklyCondition
	 * @return List<ProjectRptWeeklyListEntry>
	 */
	List<ProjectRptWeeklyListEntry> weeklyReportListGistProject(ProjectRptWeeklyCondition rptWeeklyCondition);

	/**
	 * （项目经理以上职位）周报审批列表
	 *
	 * @author 刘教练
	 * @date 2017年10月14日
	 * @param projectCondition
	 * @return List<ProjectRptWeeklyListEntry>
	 */
	List<ProjectRptWeeklyListEntry> weeklyReportListManagerAbove(ProjectCondition projectCondition);
}
