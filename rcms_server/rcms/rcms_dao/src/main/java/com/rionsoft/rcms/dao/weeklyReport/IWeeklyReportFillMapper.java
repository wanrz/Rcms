package com.rionsoft.rcms.dao.weeklyReport;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.project.ProjectCondition;
import com.rionsoft.rcms.condition.weeklyReport.ProjectRptWeeklyCondition;
import com.rionsoft.rcms.condition.weeklyReport.ProjectRptWeeklyListEntry;
import com.rionsoft.rcms.entry.weeklyReport.ProjectRptWeeklyEntry;

/**
 * @author 刘教练
 * @date 2017年10月9日
 */
@Repository
public interface IWeeklyReportFillMapper {
	/**
	 * 查询项目周报每周的开始日期
	 *
	 * @author 刘教练
	 * @date 2017年10月9日
	 * @param pkProj
	 * @return view
	 */
	List<ProjectRptWeeklyEntry> weeklyReportFillList(@Param("pkProj") final Long pkProj);

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
