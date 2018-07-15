package com.rionsoft.rcms.web.admin.weeklyReport;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.rionsoft.rcms.biz.weeklyReport.IWeeklyReportApproveBiz;
import com.rionsoft.rcms.biz.weeklyReport.IWeeklyReportFillBiz;
import com.rionsoft.rcms.bo.weeklyReport.ProjectRptWeeklyBo;
import com.rionsoft.rcms.bo.weeklyReport.RptWeeklyApprovalOpinionBo;
import com.rionsoft.rcms.condition.project.ProjectCondition;
import com.rionsoft.rcms.condition.weeklyReport.ProjectRptWeeklyCondition;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;

/**
 * 周报填写
 *
 * @author 刘教练
 * @date 2017年9月29日
 */
@Controller
@RequestMapping("/admin/weeklyReport")
public class WeeklyReportApproveController extends BaseController {
	@Autowired
	private IWeeklyReportApproveBiz weeklyReportApprove;
	@Autowired
	private IWeeklyReportFillBiz weeklyReportFillBiz;

	/**
	 * 跳转到周报填写界面
	 *
	 * @author 刘教练
	 * @date 2017年9月29日
	 * @param model
	 * @return view
	 */
	@RequestMapping("/weeklyReportApprove.do")
	public String weeklyReportApprove(final Map<String, Object> model) {
		return getView("admin/weeklyReport/approve/weeklyReportApproveManage");
	}

	/**
	 * 审批周报查询
	 *
	 * @author 刘教练
	 * @date 2017年10月13日
	 * @param projectCondition
	 * @param model
	 * @param req
	 * @return rptWeeklyListUnapproved
	 */
	@RequestMapping("/weeklyReportUnapprovedList.ajax")
	public String weeklyReportUnapprovedList(final Map<String, Object> model, final ProjectCondition projectCondition,
			final HttpServletRequest req) {
		model.put("rptWeeklyListUnapproved", weeklyReportApprove.weeklyReportListManagerAbove(projectCondition));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 查询审批过的项目
	 *
	 * @author 刘教练
	 * @date 2017年10月14日
	 * @param projectCondition
	 * @param model
	 * @param req
	 * @return projectListByApprovalTime
	 */
	@RequestMapping("/projectListByApprovalTime.ajax")
	public String projectListByApprovalTime(final Map<String, Object> model, final ProjectCondition projectCondition,
			final HttpServletRequest req) {
		model.put("projectListByApprovalTime", weeklyReportApprove.projectListByApprovalTime(projectCondition, req));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 跳转到周报审批页面
	 *
	 * @author 刘教练
	 * @date 2017年10月16日
	 * @param model
	 * @param projectRptWeeklyBo
	 * @return rptWeeklyBo
	 */
	@RequestMapping("/weeklyReportApproveFill.do")
	public String weeklyReportApproveFill(final Map<String, Object> model, final String projectRptWeeklyBo) {
		final ProjectRptWeeklyBo rptWeeklyBo = JSON.parseObject(projectRptWeeklyBo, ProjectRptWeeklyBo.class);
		model.put("rptWeeklyBo", rptWeeklyBo);
		return getView("admin/weeklyReport/approve/weeklyReportApproveFill");
	}

	/**
	 * 提交周报意见审批信息
	 *
	 * @author 刘教练
	 * @date 2017年10月16日
	 * @param rptWeeklyApproveBo
	 * @return view
	 */
	@RequestMapping("/insertRptWeeklyApprove.ajax")
	public String insertRptWeeklyApprove(final RptWeeklyApprovalOpinionBo rptWeeklyApproveBo) {
		weeklyReportApprove.insertRptWeeklyApprove(rptWeeklyApproveBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 跳转到项目Id为pkProj的审批通过的周报列表
	 *
	 * @author 刘教练
	 * @date 2017年10月17日
	 * @param model
	 * @param pkProj
	 * @return pkProj
	 */
	@RequestMapping("/weeklyReportListApproved.do")
	public String weeklyReportListApproved(final Map<String, Object> model, final Long pkProj) {
		model.put("pkProj", pkProj);
		return getView("admin/weeklyReport/approve/weeklyReportListApproved");
	}

	/**
	 * 查询项目Id为pkProj的审批通过的周报列表
	 *
	 * @author 刘教练
	 * @date 2017年10月17日
	 * @param model
	 * @param rptWeeklyCondition
	 * @return rptWeeklyList
	 */
	@RequestMapping("/weeklyReportListApprovedByPkProj.ajax")
	public String weeklyReportListApprovedByPkProj(final Map<String, Object> model,
			final ProjectRptWeeklyCondition rptWeeklyCondition) {
		rptWeeklyCondition.setStatus("2");
		model.put("rptWeeklyList", weeklyReportFillBiz.weeklyReportListGistProject(rptWeeklyCondition));
		return getView(ViewEnumType.JSON_VIEW);
	}
}
