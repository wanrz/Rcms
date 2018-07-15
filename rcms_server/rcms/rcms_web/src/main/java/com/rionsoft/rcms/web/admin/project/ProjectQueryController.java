package com.rionsoft.rcms.web.admin.project;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rionsoft.rcms.biz.department.IAuthDirBiz;
import com.rionsoft.rcms.biz.project.IProjectBiz;
import com.rionsoft.rcms.biz.user.IUserInfoBiz;
import com.rionsoft.rcms.bo.project.ProjectBo;
import com.rionsoft.rcms.condition.project.ProjectCondition;
import com.rionsoft.rcms.condition.user.UserCondition;
import com.rionsoft.rcms.entry.role.AuthDataTypeEntry;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

/**
 * @author loujie
 *
 */
@Controller
@RequestMapping("/admin/projectQuery")
public class ProjectQueryController extends BaseController {

	@Autowired
	private IProjectBiz projectBiz;
	@Autowired
	private IAuthDirBiz authDirBiz;
	@Autowired
	private IUserInfoBiz userInfoBizImpl;

	/**
	 * 2018年1月3日
	 *
	 * @author loujie
	 * @param model
	 * @param userCondition
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
		return getView("admin/project/query/projectQueryManage");
	}

	/**
	 * 2018年1月3日
	 *
	 * @author loujie
	 * @param model
	 * @param projectCondition
	 * @param req
	 * @return json
	 */
	@RequestMapping(value = "/projectQuery.ajax", method = RequestMethod.POST)
	public String projectQuery(final Map<String, Object> model, final ProjectCondition projectCondition,
			final HttpServletRequest req) {
		model.put("projectList", projectBiz.projectChangeQuery(projectCondition, req));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 2018年1月3日
	 *
	 * @author loujie
	 * @param dirType
	 * @param model
	 * @param request
	 * @return json
	 */
	@RequestMapping(value = "/dirTree.ajax", method = RequestMethod.POST)
	public String dirTree(final String dirType, final Map<String, Object> model, final HttpServletRequest request) {
		model.put("treeRootList", authDirBiz.queryTreeRoot());
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 2018年1月3日
	 *
	 * @author loujie
	 * @param model
	 * @param pkProj
	 * @return view
	 */
	@RequestMapping("/projectDetails.do")
	public String projectDetails(final Map<String, Object> model, final long pkProj) {
		model.put("project", projectBiz.queryProject(pkProj));
		return getView("admin/project/query/projectQueryDetails");
	}

	/**
	 * 2018年1月3日
	 *
	 * @author loujie
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
		return getView("admin/project/query/projectContrast");
	}

	/**
	 * 2018年1月3日
	 *
	 * @author loujie
	 * @param model
	 * @param condition
	 * @return json
	 */
	@RequestMapping(value = "/projectDetails.ajax", method = RequestMethod.POST)
	public String Details(final Map<String, Object> model, final ProjectCondition condition) {
		final List<ProjectBo> boList = projectBiz.queryProjectDetails(condition);
		model.put("projectList", boList);
		return getView(ViewEnumType.JSON_VIEW);
	}
}
