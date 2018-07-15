package com.rionsoft.rcms.biz.weeklyReport;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.rionsoft.rcms.bo.project.ProjectBo;
import com.rionsoft.rcms.bo.weeklyReport.ProjectRptWeeklyBo;
import com.rionsoft.rcms.bo.weeklyReport.RptWeeklyApprovalOpinionBo;
import com.rionsoft.rcms.condition.project.ProjectCondition;

/**
 * @author liujiaolian
 * @date 2017年10月14日
 */
public interface IWeeklyReportApproveBiz {
	/**
	 * （项目经理以上职位）周报审批列表
	 *
	 * @author 刘教练
	 * @date 2017年10月14日
	 * @param projectCondition
	 * @return List<ProjectRptWeeklyBo>
	 */
	List<ProjectRptWeeklyBo> weeklyReportListManagerAbove(ProjectCondition projectCondition);

	/**
	 * 查询审批过的项目
	 *
	 * @author 刘教练
	 * @date 2017年10月16日
	 * @param projectCondition
	 * @param req
	 * @return list
	 */
	List<ProjectBo> projectListByApprovalTime(ProjectCondition projectCondition, HttpServletRequest req);

	/**
	 * 提交周报意见审批信息
	 *
	 * @author 刘教练
	 * @date 2017年10月16日
	 * @param rptWeeklyApproveBo
	 */
	void insertRptWeeklyApprove(RptWeeklyApprovalOpinionBo rptWeeklyApproveBo);
}
