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

import com.rionsoft.rcms.biz.department.IAuthDirBiz;
import com.rionsoft.rcms.biz.project.IProjectBiz;
import com.rionsoft.rcms.biz.role.IAuthRoleBiz;
import com.rionsoft.rcms.biz.system.IProjectTypeDictBiz;
import com.rionsoft.rcms.biz.task.ITaskBiz;
import com.rionsoft.rcms.biz.user.IUserInfoBiz;
import com.rionsoft.rcms.bo.project.ProjectBo;
import com.rionsoft.rcms.condition.listentry.user.UserInfoListEntry;
import com.rionsoft.rcms.condition.project.ProjectCondition;
import com.rionsoft.rcms.condition.user.UserCondition;
import com.rionsoft.rcms.entry.role.AuthDataTypeEntry;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

import net.sf.json.JSONArray;

/**
 * @author loujie
 * @data 2017年4月21日
 */
@Controller
@RequestMapping("/admin/change")
public class ProjectChangeController extends BaseController {

	@Autowired
	private IProjectBiz projectBiz;
	@Autowired
	private IProjectTypeDictBiz projectTypeBiz;
	@Autowired
	private ITaskBiz taskBiz;
	@Autowired
	private IAuthRoleBiz authRoleBiz;
	@Autowired
	private IAuthDirBiz authDirBiz;
	@Autowired
	private IUserInfoBiz userInfoBizImpl;

	/**
	 * 跳转到立项变更页面
	 *
	 * @author loujie
	 * @param model
	 * @param userCondition
	 * @data 2017年4月21日
	 * @return view
	 */
	@RequestMapping("/project.do")
	public String project(final Map<String, Object> model, final UserCondition userCondition) {
		model.put("authDirBo", authDirBiz.queryAuthDirEntryByUserId());
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
		return getView("admin/project/change/project");
	}

	/**
	 * 项目列表加载
	 *
	 * @author loujie
	 * @data 2017年4月21日
	 * @param model
	 * @param projectCondition
	 * @param req
	 * @return json
	 */
	@RequestMapping("/projectQuery.ajax")
	public String projectQuery(final Map<String, Object> model, final ProjectCondition projectCondition,
			final HttpServletRequest req) {
		model.put("projectList", projectBiz.projectChangeQuery(projectCondition, req));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 跳转到立项变更修改界面
	 *
	 * @author loujie
	 * @data 2017年4月21日
	 * @param model
	 * @param pkProj
	 * @param request
	 * @return view
	 */
	@RequestMapping("/projectUpdate.do")
	public String changeProject(final Map<String, Object> model, final long pkProj, final HttpServletRequest request) {
		final UserCondition condition = new UserCondition();
		final List<UserInfoListEntry> busList = userInfoBizImpl.queryByCondition(condition, request);
		model.put("unfinishTaskSize", taskBiz.queryTaskByPkProj(pkProj).size());
		model.put("project", projectBiz.queryProject(pkProj));
		model.put("projectTypeList", projectTypeBiz.queryProjectChangeList());
		model.put("pmList", JSONArray.fromObject(authRoleBiz.queryUserByRoleCode()));
		model.put("busList", JSONArray.fromObject(busList));
		return getView("admin/project/change/projectUpdate");
	}

	/**
	 * 项目变更
	 *
	 * @author loujie
	 * @data 2017年4月21日
	 * @param projectBo
	 * @return json
	 */
	@RequestMapping(value = "/projectUpdate.ajax")
	public String projectUpdate(final ProjectBo projectBo) {
		projectBiz.changeProject(projectBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 查询项目变更记录次数
	 *
	 * @author loujie
	 * @data 2017年4月24日
	 * @param model
	 * @param pkProj
	 * @return json
	 */
	@RequestMapping(value = "/queryCount.ajax")
	public String queryCount(final Map<String, Object> model, final long pkProj) {
		model.put("count", projectBiz.queryCount(pkProj));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 跳转到项目详情页面
	 *
	 * @author loujie
	 * @data 2017年4月21日
	 * @param model
	 * @param condition
	 * @return view
	 */
	@RequestMapping("/projectDetails.do")
	public String projectDetails(final Map<String, Object> model, final ProjectCondition condition) {
		final List<ProjectBo> boList = projectBiz.queryProjectDetails(condition);
		model.put("project", boList.get(0));
		return getView("admin/project/change/projectDetails");
	}

	/**
	 * 查询项目变更详情
	 *
	 * @author loujie
	 * @data 2017年4月21日
	 * @param model
	 * @param condition
	 * @return json
	 */
	@RequestMapping("/projectDetails.ajax")
	public String Details(final Map<String, Object> model, final ProjectCondition condition) {
		final List<ProjectBo> boList = projectBiz.queryProjectDetails(condition);
		model.put("projectList", boList);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 根据pkProj和version查询项目当前详情和上次修改的详情
	 *
	 * @author loujie
	 * @data 2017年4月24日
	 * @param model
	 * @param pkProj
	 * @param version
	 * @return view
	 */
	@RequestMapping("/contrast.do")
	public String contrast(final Map<String, Object> model, final long pkProj, final int version) {
		final List<ProjectBo> boList = projectBiz.queryProjectContrast(pkProj, version);
		model.put("count", boList.size());
		model.put("project", boList.get(0));
		if (boList.size() == 2) {
			model.put("oldProject", boList.get(1));
		}
		return getView("admin/project/change/contrast");
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
	@RequestMapping("/dirTree.ajax")
	public String dirTree(final String dirType, final Map<String, Object> model, final HttpServletRequest request) {
		model.put("treeRootList", authDirBiz.queryTreeRoot());
		return getView(ViewEnumType.JSON_VIEW);
	}

}
