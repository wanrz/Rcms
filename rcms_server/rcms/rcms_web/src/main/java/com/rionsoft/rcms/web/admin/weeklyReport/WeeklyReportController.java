package com.rionsoft.rcms.web.admin.weeklyReport;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.rionsoft.rcms.biz.project.IProjectBiz;
import com.rionsoft.rcms.biz.weeklyReport.IWeeklyReportFillBiz;
import com.rionsoft.rcms.bo.weeklyReport.ProjectRptWeeklyBo;
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
public class WeeklyReportController extends BaseController {
	@Autowired
	private IWeeklyReportFillBiz weeklyReportFill;
	@Autowired
	private IProjectBiz projectBiz;

	/**
	 * 跳转到周报填写界面
	 *
	 * @author 刘教练
	 * @date 2017年9月29日
	 * @param model
	 * @return view
	 */
	@RequestMapping("/weeklyReportFill.do")
	public String weekReportFill(final Map<String, Object> model) {
		return getView("admin/weeklyReport/weeklyReportFill");
	}

	/**
	 * 项目列表加载
	 *
	 * @author 刘教练
	 * @date 2017年9月29日
	 * @param model
	 * @param req
	 * @param projectCondition
	 * @return json
	 */
	@RequestMapping("/weeklyReportFillProjectQuery.ajax")
	public String weekReportFillProjectQuery(final Map<String, Object> model, final ProjectCondition projectCondition,
			final HttpServletRequest req) {
		model.put("projectList", projectBiz.queryProjectByProjOperator(projectCondition, req));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 跳转到周报列表页面
	 *
	 * @author 刘教练
	 * @date 2017年9月30日
	 * @param model
	 * @param pkProj
	 * @param expStartDate
	 * @param flag
	 * @return pkProj
	 */
	@RequestMapping("/weeklyReportList.do")
	public String weeklyReportList(final Map<String, Object> model, final Long pkProj, final String expStartDate,
			final String flag) {
		model.put("pkProj", pkProj);
		model.put("expStartDate", expStartDate);
		model.put("flag", flag);
		return getView("admin/weeklyReport/weeklyReportList");
	}

	/**
	 * 周报列表加载
	 *
	 * @author 刘教练
	 * @date 2017年9月30日
	 * @param model
	 * @param rptWeeklyCondition
	 * @param req
	 * @return rptWeeklyList
	 */
	@RequestMapping("weeklyReportListGistProject.ajax")
	public String weeklyReportListGistProject(final Map<String, Object> model,
			final ProjectRptWeeklyCondition rptWeeklyCondition, final HttpServletRequest req) {
		model.put("rptWeeklyList", weeklyReportFill.weeklyReportListGistProject(rptWeeklyCondition));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 跳转到周报填写页面
	 *
	 * @author 刘教练
	 * @date 2017年9月30日
	 * @param model
	 * @param pkProj
	 * @param expStartDate
	 * @return startTimeList
	 */
	@RequestMapping("/weeklyReportAdd.do")
	public String weeklyReportAdd(final Map<String, Object> model, final Long pkProj, final String expStartDate) {
		model.put("expStartDate", expStartDate);
		model.put("pkProj", pkProj);
		model.put("startTimeList", weeklyReportFill.weeklyReportFillList(pkProj));
		return getView("admin/weeklyReport/weeklyReportAdd");
	}

	/**
	 * 保存项目周报
	 *
	 * @author 刘教练
	 * @date 2017年10月9日
	 * @param model
	 * @param rptWeeklyBo
	 * @return flag
	 */
	@RequestMapping("/insertWeeklyReportSave.ajax")
	public String insertWeeklyReportSave(final Map<String, Object> model, final ProjectRptWeeklyBo rptWeeklyBo) {
		model.put("flag", weeklyReportFill.insertWeeklyReport(rptWeeklyBo));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 提交项目周报
	 *
	 * @author 刘教练
	 * @date 2017年10月18日
	 * @param model
	 * @param rptWeeklyBo
	 * @return flag
	 */
	@RequestMapping("/insertWeeklyReportSubmit.ajax")
	public String insertWeeklyReportSubmit(final Map<String, Object> model, final ProjectRptWeeklyBo rptWeeklyBo) {
		model.put("flag", weeklyReportFill.insertWeeklyReport(rptWeeklyBo));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 跳转到周报修改
	 *
	 * @author 刘教练
	 * @date 2017年10月11日
	 * @param model
	 * @param rptWeeklyBo
	 * @param expStartDate
	 * @return flag
	 */
	@RequestMapping("/weeklyReportUpdate.do")
	public String weeklyReportUpdate(final Map<String, Object> model, final String rptWeeklyBo,
			final String expStartDate) {
		final ProjectRptWeeklyBo rptWeeklyUpdateBo = JSON.parseObject(rptWeeklyBo, ProjectRptWeeklyBo.class);
		model.put("rptWeeklyBo", rptWeeklyUpdateBo);
		model.put("expStartDate", expStartDate);
		final List<ProjectRptWeeklyBo> startTimeList = weeklyReportFill
				.weeklyReportFillList(rptWeeklyUpdateBo.getPkProj());
		for (int i = 0; i < startTimeList.size(); i++) {
			final long bgTime = startTimeList.get(i).getWeekBeginDate().getTime();
			final long upTime = rptWeeklyUpdateBo.getWeekBeginDate().getTime();
			if (bgTime == upTime) {
				startTimeList.remove(i);
				i--;
			}
		}
		model.put("startTimeList", startTimeList);
		return getView("admin/weeklyReport/weeklyReportUpdate");
	}

	/**
	 * 提交修改的周报信息
	 *
	 * @author 刘教练
	 * @date 2017年10月11日
	 * @param model
	 * @param rptWeeklyBo
	 * @return view
	 */
	@RequestMapping("/updateWeeklyReportSubmit.ajax")
	public String updateWeeklyReportSubmit(final Map<String, Object> model, final ProjectRptWeeklyBo rptWeeklyBo) {
		model.put("flag", weeklyReportFill.updateWeeklyReportByProRptId(rptWeeklyBo));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 保存修改的周报信息
	 *
	 * @author 刘教练
	 * @date 2017年10月11日
	 * @param model
	 * @param rptWeeklyBo
	 * @return view
	 */
	@RequestMapping("/updateWeeklyReportSave.ajax")
	public String updateWeeklyReportSave(final Map<String, Object> model, final ProjectRptWeeklyBo rptWeeklyBo) {
		model.put("flag", weeklyReportFill.updateWeeklyReportByProRptId(rptWeeklyBo));
		return getView(ViewEnumType.JSON_VIEW);
	}
}
