
/**
 *
 */
package com.rionsoft.rcms.web.admin.project;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.rionsoft.rcms.biz.department.IAuthDirBiz;
import com.rionsoft.rcms.biz.role.IAuthRoleBiz;
import com.rionsoft.rcms.biz.task.ITaskMonitorBiz;
import com.rionsoft.rcms.biz.user.IUserInfoBiz;
import com.rionsoft.rcms.bo.constant.TaskStatusEnum;
import com.rionsoft.rcms.condition.listentry.role.UserRoleListEntry;
import com.rionsoft.rcms.condition.project.ProjMonitorCondition;
import com.rionsoft.rcms.condition.project.ProjMonitorListEntry;
import com.rionsoft.rcms.condition.task.TaskCondition;
import com.rionsoft.rcms.condition.task.TaskListEntry;
import com.rionsoft.rcms.condition.task.TaskMonitorCondition;
import com.rionsoft.rcms.condition.task.TaskUserRefListEntry;
import com.rionsoft.rcms.condition.user.UserCondition;
import com.rionsoft.rcms.entry.role.AuthDataTypeEntry;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

/**
 * 进度监控
 *
 * @author likeke
 * @date 2017年4月27日
 */
@Controller
@RequestMapping("/admin/project/")
public class ProjectMonitorController extends BaseController {

	@Autowired
	private ITaskMonitorBiz taskMonitorBiz;
	@Autowired
	private IAuthRoleBiz authRoleBiz;
	@Autowired
	private IAuthDirBiz authDirBiz;
	@Autowired
	private IUserInfoBiz userInfoBizImpl;

	/**
	 * 跳转到进度监控界面
	 *
	 * @author likeke
	 * @param model
	 * @param pkProj
	 * @param projNames
	 * @date 2017年4月27日
	 * @return String
	 */
	@RequestMapping("/progressMonitor.do")
	public String progressMonitor(final Map<String, Object> model, final long pkProj, final String projNames) {
		model.put("pkProj", pkProj);
		model.put("projNames", projNames);
		model.put("projectStatus", TaskStatusEnum.values());
		return getView("admin/project/monitor/monitorTask");
	}

	/**
	 * 查询任务进度
	 *
	 * @author likeke
	 * @param model
	 * @param condition
	 * @date 2017年4月27日
	 * @return String
	 */
	@RequestMapping("/queryProgress.ajax")
	public String queryProgress(final Map<String, Object> model, final TaskCondition condition) {
		final List<TaskListEntry> boList = taskMonitorBiz.queryTaskMonitor(condition);
		model.put("taskList", boList);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 查询任务进度详情
	 *
	 * @author likeke
	 * @param model
	 * @param condition
	 * @date 2017年4月27日
	 * @return String
	 */
	@RequestMapping("/queryProgressDetail.ajax")
	public String queryProgressDetail(final Map<String, Object> model, final TaskMonitorCondition condition) {
		final List<TaskUserRefListEntry> entryList = taskMonitorBiz.queryProgressDetail(condition);
		model.put("taskDetailList", entryList);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * @author likeke
	 * @date 2017年4月30日
	 * @param idList
	 * @param flag
	 *            flag为true时导出简单信息，flag为false时导出详细信息
	 *
	 *
	 * @param model
	 * @param req
	 * @return String
	 */
	@RequestMapping("/exportTask.download")
	public String exportTask(@RequestParam("taskId") final List<Long> idList, final boolean flag,
			final Map<String, Object> model, final HttpServletRequest req) {
		if (flag) {
			model.put("exportFilebo", taskMonitorBiz.exportTask(idList, req));
		} else {
			model.put("exportFilebo", taskMonitorBiz.exportTaskDetail(idList));
		}

		return getView(ViewEnumType.EXPORT_VIEW);
	}

	/**
	 * 跳转到项目进度监控主页
	 *
	 * @author linzhiqiang
	 * @date 2017年5月2日
	 * @param model
	 * @param userCondition
	 * @return view
	 */
	@RequestMapping("/projMonitor.do")
	public String projMonitor(final Map<String, Object> model, final UserCondition userCondition) {
		final List<UserRoleListEntry> pmList = authRoleBiz.queryUserByRoleCode();
		model.put("projectStatus", TaskStatusEnum.values());
		model.put("pmList", pmList);
		model.put("authDirBo", authDirBiz.queryAuthDirEntryByUserId());

		// 用来判断是不是只存在本部门
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		List<AuthDataTypeEntry> authDataTypeList = userInfoBizImpl.queryAuthRoleByUserId(userCondition);
		List<String> dataCodes = new ArrayList<String>();
		for (AuthDataTypeEntry authDataTypeEntry : authDataTypeList) {
			dataCodes.add(authDataTypeEntry.getDataCode());
		}
		if (!dataCodes.contains("01") && !dataCodes.contains("03") && !dataCodes.contains("04") && userId != 1) {
			model.put("dataId2", dataCodes.get(0));
		}

		return getView("admin/project/monitor/projMonitor");
	}

	/**
	 * 查询项目进度列表
	 *
	 * @author linzhiqiang
	 * @date 2017年5月3日
	 * @param model
	 * @param condition
	 * @param req
	 * @return view
	 */
	@RequestMapping("/queryProjMonitor.ajax")
	public String queryProjMonitor(final Map<String, Object> model, final ProjMonitorCondition condition,
			final HttpServletRequest req) {
		final List<ProjMonitorListEntry> listEntry = taskMonitorBiz.queryProjMonitor(condition, req);
		model.put("projList", listEntry);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 查询目录根节点
	 *
	 * @author loujie
	 * @data 2017年9月7日
	 * @param dirType
	 * @param model
	 * @param request
	 * @return json
	 */
	@RequestMapping("/monitor/dirTree.ajax")
	public String dirTree(final String dirType, final Map<String, Object> model, final HttpServletRequest request) {
		model.put("treeRootList", authDirBiz.queryTreeRoot());
		return getView(ViewEnumType.JSON_VIEW);
	}

}