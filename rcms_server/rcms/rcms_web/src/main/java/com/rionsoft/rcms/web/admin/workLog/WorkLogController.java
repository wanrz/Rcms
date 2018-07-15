/**
 *
 */
package com.rionsoft.rcms.web.admin.workLog;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.rionsoft.rcms.biz.common.date.IDatabaseTimeBiz;
import com.rionsoft.rcms.biz.util.JsonUtil;
import com.rionsoft.rcms.biz.workLog.IWorkLogBiz;
import com.rionsoft.rcms.bo.workLog.WorkLogBo;
import com.rionsoft.rcms.condition.workLog.WorkLogCondition;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

/**
 * @author loujie
 * @data 2017年4月30日
 */
@Controller
@RequestMapping("/admin/workLog")
public class WorkLogController extends BaseController {

	@Autowired
	private IWorkLogBiz workLogBiz;
	@Autowired
	private IDatabaseTimeBiz databaseTimeBiz;

	/**
	 * 跳转到日志界面
	 *
	 * @author loujie
	 * @data 2017年4月30日
	 * @param model
	 * @return view
	 */
	@RequestMapping("workManage.do")
	public String workLog(final Map<String, Object> model) {
		final Date currentTime = databaseTimeBiz.databaseCurrentTime();
		final Calendar cal = Calendar.getInstance();
		cal.setTime(currentTime);
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		model.put("monday", cal.getTime().getTime());
		model.put("currentDay", currentTime.getTime());
		return getView("admin/workLog/workManage");
	}

	/**
	 * 查询工作日志
	 *
	 * @author loujie
	 * @data 2017年4月30日
	 * @param condition
	 * @param model
	 * @return json
	 */
	@RequestMapping("queryWorkLog.ajax")
	public String queryWorkLog(final WorkLogCondition condition, final Map<String, Object> model) {
		final long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		condition.setUserId(userId);
		if (condition.getDateId() % 7 == 0) {
			model.put("workLogList", workLogBiz.queryWorkByCondition(condition));
		} else {
			model.put("workLogList", workLogBiz.queryMonthByCondition(condition));
		}
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 添加日志
	 *
	 * @author loujie
	 * @data 2017年5月1日
	 * @param workLogList
	 * @return json
	 */
	@RequestMapping("workLogAdd.ajax")
	public String workLogAdd(final String workLogList) {
		final List<WorkLogBo> boList = JsonUtil.toCollection(workLogList, WorkLogBo.class);
		workLogBiz.workLogAdd(boList);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 导出工作日志
	 *
	 * @author loujie
	 * @data 2017年5月2日
	 * @param pkWorkLogList
	 * @param model
	 * @return json
	 */
	@RequestMapping("exportWorkLog.download")
	public String exportWorkLog(@RequestParam("pkWorkLogList") final List<Long> pkWorkLogList,
			final Map<String, Object> model) {
		model.put("exportFilebo", workLogBiz.exportWorkLog(pkWorkLogList));
		return getView(ViewEnumType.EXPORT_VIEW);
	}

	/**
	 * 查询本月任务状态
	 *
	 * @author 刘教练
	 * @date 2017年8月25日
	 * @param dateId
	 * @param model
	 * @return json
	 */
	@RequestMapping("selectMonthWorkInfo.ajax")
	public String selectMonthWorkInfo(final long dateId, final Map<String, Object> model) {
		model.put("workInfo", workLogBiz.selectMonthWorkInfo());
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 查询本周任务状态
	 *
	 * @author 刘教练
	 * @date 2017年8月31日
	 * @param dateId
	 * @param model
	 * @return json
	 */
	@RequestMapping("selectWeekWorkInfo.ajax")
	public String selectWeekWorkInfo(final long dateId, final Map<String, Object> model) {
		final Map<String, String> workInfo = workLogBiz.selectWeekWorkInfo(dateId);
		model.put("workInfo", workInfo);
		return getView(ViewEnumType.JSON_VIEW);
	}

}
