package com.rionsoft.rcms.biz.weeklyReport;

import java.util.List;

import com.rionsoft.rcms.bo.weeklyReport.ProjectRptWeeklyBo;
import com.rionsoft.rcms.condition.weeklyReport.ProjectRptWeeklyCondition;

/**
 * @author liujiaolian
 * @date 2017年10月9日
 */
public interface IWeeklyReportFillBiz {
	/**
	 * 查询项目周报每周的开始日期
	 *
	 * @author 刘教练
	 * @date 2017年10月9日
	 * @param pkProj
	 * @return view
	 */
	List<ProjectRptWeeklyBo> weeklyReportFillList(Long pkProj);

	/**
	 * 填写周报
	 *
	 * @author 刘教练
	 * @date 2017年10月10日
	 * @param rptWeeklyBo
	 * @return long
	 */
	long insertWeeklyReport(final ProjectRptWeeklyBo rptWeeklyBo);

	/**
	 * 查询周报列表
	 *
	 * @author 刘教练
	 * @date 2017年10月10日
	 * @param rptWeeklyCondition
	 * @return List<ProjectRptWeeklyBo>
	 */
	List<ProjectRptWeeklyBo> weeklyReportListGistProject(ProjectRptWeeklyCondition rptWeeklyCondition);

	/**
	 * 提交修改的周报信息
	 *
	 * @author 刘教练
	 * @date 2017年10月11日
	 * @param rptWeeklyBo
	 * @return view
	 */
	boolean updateWeeklyReportByProRptId(final ProjectRptWeeklyBo rptWeeklyBo);
}
