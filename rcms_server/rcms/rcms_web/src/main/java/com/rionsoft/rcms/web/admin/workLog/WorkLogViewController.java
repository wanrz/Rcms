/**
 *
 */
package com.rionsoft.rcms.web.admin.workLog;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.rionsoft.rcms.biz.common.cache.CacheUtil;
import com.rionsoft.rcms.biz.common.date.IDatabaseTimeBiz;
import com.rionsoft.rcms.biz.user.IUserInfoBiz;
import com.rionsoft.rcms.biz.workLog.IWorkLogBiz;
import com.rionsoft.rcms.biz.workLog.IWorkLogViewBiz;
import com.rionsoft.rcms.condition.user.UserCondition;
import com.rionsoft.rcms.condition.workLog.WorkLogViewCondition;
import com.rionsoft.rcms.entry.role.AuthDataTypeEntry;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.basebo.session.UserLoginBo;
import com.rionsoft.support.biz.util.DatePattern;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

/**
 * @author 刘教练
 * @date 2017年10月25日
 */
@Controller
@RequestMapping("/admin/workLog")
public class WorkLogViewController extends BaseController {
	@Autowired
	private IWorkLogViewBiz workLogViewBiz;
	@Autowired
	private IWorkLogBiz workLogBiz;
	@Autowired
	private IDatabaseTimeBiz databaseTimeBiz;
	@Autowired
	private IUserInfoBiz userInfoBizImpl;

	/**
	 * 跳转到日志查看页面
	 *
	 * @author 刘教练
	 * @date 2017年10月25日
	 * @param model
	 * @param userCondition
	 * @return view
	 */
	@RequestMapping("/workLogViewManage.do")
	public String workLogViewManage(final Map<String, Object> model, final UserCondition userCondition) {
		// 用来判断是不是只存在本部门
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		final List<AuthDataTypeEntry> authDataTypeList = userInfoBizImpl.queryAuthRoleByUserId(userCondition);
		final List<String> dataCodes = new ArrayList<String>();
		for (final AuthDataTypeEntry authDataTypeEntry : authDataTypeList) {
			dataCodes.add(authDataTypeEntry.getDataCode());
		}
		if (!dataCodes.contains("01") && !dataCodes.contains("03") && !dataCodes.contains("04") && userId != 1) {
			model.put("dataId2", dataCodes.get(0));
		}
		return getView("admin/workLog/workLogViewManage");
	}

	/**
	 * 查看所管理的员工的日志
	 *
	 * @author 刘教练
	 * @date 2017年10月26日
	 * @param model
	 * @param logViewCondition
	 * @return view
	 */
	@RequestMapping("/queryWorkLogViewList.ajax")
	public String queryWorkLogViewList(final Map<String, Object> model, final WorkLogViewCondition logViewCondition) {
		if (logViewCondition.getBeginDate() != null && logViewCondition.getBeginDate() != "") {
			logViewCondition.setBeginDate("'" + logViewCondition.getBeginDate() + "'");
		}
		if (logViewCondition.getEndDate() != null && logViewCondition.getEndDate() != "") {
			logViewCondition.setEndDate("'" + logViewCondition.getEndDate() + "'");
		}
		final UserLoginBo userLoginBo = SessionLocal.getSessionLocal(SessionLocalEnum.USER_LOGIN_INFO);
		logViewCondition.setOperatorId(userLoginBo.getUserId());
		logViewCondition.setLoginCode(String.valueOf(CacheUtil.isAdmin(userLoginBo.getLoginCode())));
		model.put("workLogViewList", workLogViewBiz.queryWorkLogViewList(logViewCondition));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 日志导出
	 *
	 * @author 刘教练
	 * @date 2017年10月27日
	 * @param pkWorkLogList
	 * @param model
	 * @return view
	 */
	@RequestMapping("/exportWorkLogView.download")
	public String exportWorkLogView(@RequestParam("pkWorkLogList") final List<Long> pkWorkLogList,
			final Map<String, Object> model) {
		model.put("exportFilebo", workLogBiz.exportWorkLog(pkWorkLogList));
		return getView(ViewEnumType.EXPORT_VIEW);
	}

	/**
	 * 视图可视化
	 *
	 * @author 刘教练
	 * @date 2017年10月27日
	 * @param model
	 * @param pkProj
	 * @param userId
	 * @return view
	 */
	@RequestMapping("/workLogViewVisual.do")
	public String workLogViewVisual(final Map<String, Object> model, final Long pkProj, final Long userId) {
		model.put("pkProj", pkProj);
		model.put("userId", userId);
		return getView("admin/workLog/workLogViewVisual");
	}

	/**
	 * 通过部门项目查询自己管理的人员
	 *
	 * @author 刘教练
	 * @date 2017年11月2日
	 * @param model
	 * @param userName
	 * @param pkProj
	 * @param dirId
	 * @return view
	 */
	@RequestMapping("/userListByProjDirOperator.ajax")
	public String userListByProjDirOperator(final Map<String, Object> model, final String userName, final Long pkProj,
			final Long dirId) {
		model.put("userList", workLogViewBiz.userListByProjDirOperator(userName, pkProj, dirId));
		return getView(ViewEnumType.JSON_VIEW);
	}

	//
	/**
	 * 通过userId和pkProj和日期查询日志
	 *
	 * @author 刘教练
	 * @date 2017年11月3日
	 * @param model
	 * @param userId
	 * @param pkProj
	 * @param dateId
	 * @return view
	 */
	@RequestMapping("/WorkLogViewVisualByWeek.ajax")
	public String WorkLogViewVisualByWeek(final Map<String, Object> model, final Long pkProj, final Long userId,
			final long dateId) {
		model.put("workLogViewList", workLogViewBiz.workLogViewVisual(pkProj, userId, dateId));
		model.put("currentTime", DatePattern.YYYY_MM_DD.format(databaseTimeBiz.databaseCurrentTime()));
		return getView(ViewEnumType.JSON_VIEW);
	}
}
