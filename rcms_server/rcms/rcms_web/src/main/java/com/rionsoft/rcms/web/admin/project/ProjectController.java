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
import com.rionsoft.rcms.biz.user.IUserInfoBiz;
import com.rionsoft.rcms.bo.project.ProjectBo;
import com.rionsoft.rcms.bo.system.ProjectLevelDictBo;
import com.rionsoft.rcms.bo.system.ProjectTypeDictBo;
import com.rionsoft.rcms.bo.system.ProjectUrgentDictBo;
import com.rionsoft.rcms.condition.listentry.role.UserRoleListEntry;
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
 * @author linzhiqiang
 * @date 2017年4月18日
 */
@Controller
@RequestMapping("admin/project")
public class ProjectController extends BaseController {
	@Autowired
	private IProjectBiz projectBiz;
	@Autowired
	private IProjectTypeDictBiz typeBiz;
	@Autowired
	private IAuthRoleBiz authRoleBiz;
	@Autowired
	private IAuthDirBiz authDirBiz;
	@Autowired
	private IUserInfoBiz userInfoBizImpl;

	/**
	 * 跳转到立项管理主页
	 *
	 * @author linzhiqiang
	 * @date 2017年4月18日
	 * @param model
	 * @param userCondition
	 * @return view
	 */
	@RequestMapping("/project.do")
	public String project(final Map<String, Object> model, final UserCondition userCondition) {
		final List<ProjectTypeDictBo> projectList = typeBiz.queryProjectList();
		model.put("projectTypeList", projectList);
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

		return getView("admin/project/project");
	}

	/**
	 * 跳转到新增页面
	 *
	 * @author linzhiqiang
	 * @date 2017年4月18日
	 * @param typeCode
	 * @param projectName
	 * @param request
	 * @param map
	 * @return view
	 */
	@RequestMapping("/projectAdd.do")
	public String addProject(final String typeCode, final String projectName, final HttpServletRequest request,
			final Map<String, Object> map) {
		final String projCode = projectBiz.getProjectCode(typeCode);
		final List<ProjectTypeDictBo> projectList = typeBiz.queryProjectList();
		final List<ProjectLevelDictBo> levelBoList = typeBiz.queryLevel();
		final List<ProjectUrgentDictBo> urgentBoList = typeBiz.queryUrgent();
		final List<UserRoleListEntry> pmList = authRoleBiz.queryUserByRoleCode();
		final UserCondition condition = new UserCondition();
		final List<UserInfoListEntry> busList = userInfoBizImpl.queryByCondition(condition, request);
		map.put("levelBoList", levelBoList);
		map.put("urgentBoList", urgentBoList);
		map.put("projectTypeList", projectList);
		map.put("pmList", JSONArray.fromObject(pmList));
		map.put("busList", JSONArray.fromObject(busList));
		map.put("projCode", projCode);
		map.put("projType", projectName);
		map.put("typeCode", typeCode);
		return getView("admin/project/projectAdd");
	}

	/**
	 * 立项管理保存
	 *
	 * @author linzhiqiang
	 * @date 2017年4月19日
	 * @param request
	 * @param projectBo
	 * @return view
	 */
	@RequestMapping(value = "/projectSave.ajax")
	public String projectSave(final HttpServletRequest request, final ProjectBo projectBo) {
		projectBiz.projectSave(projectBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 立项管理查询
	 *
	 * @author linzhiqiang
	 * @date 2017年4月19日
	 * @param model
	 * @param projectCondition
	 * @param req
	 * @return view
	 */
	@RequestMapping("/projectQuery.ajax")
	public String projectQuery(final Map<String, Object> model, final ProjectCondition projectCondition,
			final HttpServletRequest req) {
		model.put("projectList", projectBiz.projectQuery(projectCondition, req));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 跳转到修改页面
	 *
	 * @author linzhiqiang
	 * @date 2017年4月20日
	 * @param model
	 * @param pkProj
	 * @param request
	 * @return view
	 */
	@RequestMapping("/projectUpdate.do")
	public String UpdateProject(final Map<String, Object> model, final long pkProj, final HttpServletRequest request) {
		final List<ProjectTypeDictBo> projectList = typeBiz.queryProjectList();
		final List<ProjectLevelDictBo> levelBoList = typeBiz.queryLevel();
		final List<ProjectUrgentDictBo> urgentBoList = typeBiz.queryUrgent();
		final List<UserRoleListEntry> pmList = authRoleBiz.queryUserByRoleCode();
		final UserCondition condition = new UserCondition();
		final List<UserInfoListEntry> busList = userInfoBizImpl.queryByCondition(condition, request);
		model.put("levelBoList", levelBoList);
		model.put("urgentBoList", urgentBoList);
		model.put("projectTypeList", projectList);
		model.put("pmList", JSONArray.fromObject(pmList));
		model.put("busList", JSONArray.fromObject(busList));
		model.put("project", projectBiz.queryProject(pkProj));
		return getView("admin/project/projectUpdate");
	}

	/**
	 * 修改保存
	 *
	 * @author linzhiqiang
	 * @date 2017年4月20日
	 * @param request
	 * @param projectBo
	 * @return view
	 */
	@RequestMapping(value = "/projectUpdate.ajax")
	public String projectUpdate(final HttpServletRequest request, final ProjectBo projectBo) {
		projectBiz.projectUpdate(projectBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 批量删除
	 *
	 * @author linzhiqiang
	 * @date 2017年4月28日
	 * @param pkProjList
	 * @return view
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/deleteProj.ajax")
	public String deleteProj(final String pkProjList) {
		final JSONArray a = JSONArray.fromObject(pkProjList);
		final List<Long> pkList = (List<Long>) JSONArray.toCollection(a);
		projectBiz.deleteProj(pkList);
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
	@RequestMapping("/dirTree.ajax")
	public String dirTree(final String dirType, final Map<String, Object> model, final HttpServletRequest request) {
		model.put("treeRootList", authDirBiz.queryTreeRoot());
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 查看项目详情
	 *
	 * @author sungantao
	 * @param model
	 * @param pkProj
	 * @date 2017年9月22日
	 * @return view
	 */
	@RequestMapping("/projectDetails.do")
	public String projectDetails(final Map<String, Object> model, final long pkProj) {
		model.put("project", projectBiz.queryProject(pkProj));
		return getView("admin/project/projectDetails");
	}

	/**
	 * @author sungantao
	 * @date 2017年9月25日
	 * @param model
	 * @param condition
	 * @return view
	 */
	@RequestMapping("/projectDetails.ajax")
	public String showProjectDetails(final Map<String, Object> model, final ProjectCondition condition) {
		final List<ProjectBo> boList = projectBiz.queryProjectDetails(condition);
		model.put("projectList", boList);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * @author sungantao
	 * @date 2017年9月25日
	 * @param model
	 * @param condition
	 * @return view
	 */
	@RequestMapping("/contrast.do")
	public String contrast(final Map<String, Object> model, final ProjectCondition condition) {
		final List<ProjectBo> boList = projectBiz.projectContrast(condition);
		model.put("count", boList.size());
		model.put("project", boList.get(0));
		if (boList.size() == 2) {
			model.put("oldProject", boList.get(1));
		}
		return getView("admin/project/change/contrast");
	}
}
