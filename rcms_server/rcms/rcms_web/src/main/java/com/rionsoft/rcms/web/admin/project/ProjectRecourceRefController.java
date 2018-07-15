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
import com.rionsoft.rcms.biz.project.IProjectRecourceRefBiz;
import com.rionsoft.rcms.biz.user.IUserInfoBiz;
import com.rionsoft.rcms.bo.project.ProjectBo;
import com.rionsoft.rcms.bo.project.ProjectRecourceRefBo;
import com.rionsoft.rcms.condition.project.ProjectCondition;
import com.rionsoft.rcms.condition.project.ProjectRecourceRefCondition;
import com.rionsoft.rcms.condition.project.ProjectUserListEntry;
import com.rionsoft.rcms.condition.user.UserCondition;
import com.rionsoft.rcms.entry.role.AuthDataTypeEntry;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

import net.sf.json.JSONArray;

/**
 * 资源分配
 *
 * @author linzhiqiang
 * @date 2017年4月25日
 */
@Controller
@RequestMapping("admin/project")
public class ProjectRecourceRefController extends BaseController {
	@Autowired
	private IProjectRecourceRefBiz projectRecourceRefBiz;
	@Autowired
	private IAuthDirBiz authDirBiz;
	@Autowired
	private IUserInfoBiz userInfoBizImpl;
	@Autowired
	private IProjectBiz projectBiz;
	/**
	 * 跳转到资源页面
	 *
	 * @author linzhiqiang
	 * @param model
	 * @param userCondition
	 * @date 2017年4月25日
	 * @return view
	 */
	@RequestMapping("/projectRecource.do")
	public String projectRecourceRef(final Map<String, Object> model, final UserCondition userCondition) {
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

		return getView("admin/project/projectRecourceRef");
	}

	/**
	 * 查询项目列表
	 *
	 * @author linzhiqiang
	 * @date 2017年4月25日
	 * @param map
	 * @param req
	 * @param condition
	 * @return view
	 */
	@RequestMapping("/projectRecourceRefQuery.ajax")
	public String projectRfeQuery(final Map<String, Object> map, final ProjectCondition condition,
			final HttpServletRequest req) {
		condition.setStatus("15");
		map.put("recourceBoList", projectBiz.queryProjectByProjOperator(condition, req));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 跳转到项目人员分配页面
	 *
	 * @author linzhiqiang
	 * @date 2017年4月25日
	 * @param pkProj
	 * @param map
	 * @param projNames
	 * @return view
	 */
	@RequestMapping("/projectRefAdd.do")
	public String projectUserAdd(final Map<String, Object> map, final long pkProj, final String projNames) {
		map.put("pkProj", pkProj);
		map.put("projNames", projNames);
		return getView("admin/project/projectRefAdd");
	}

	/**
	 * 查询已分配人员
	 *
	 * @author linzhiqiang
	 * @date 2017年4月25日
	 * @param map
	 * @param condition
	 * @return view
	 */
	@RequestMapping("/projectUserQuery.ajax")
	public String projectUserQuery(final Map<String, Object> map, final ProjectRecourceRefCondition condition) {
		final List<ProjectUserListEntry> refBoList = projectRecourceRefBiz.projectUserQuery(condition);
		ProjectBo project = projectBiz.queryProject(condition.getPkProj());
		map.put("pmid", project.getPmId());
		map.put("projectUser", refBoList);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 保存分配人员
	 *
	 * @author linzhiqiang
	 * @date 2017年4月26日
	 * @param taskList
	 * @return view
	 *
	 */

	@RequestMapping("/projectUserSave.ajax")
	public String projectUserSave(final String taskList) {
		final JSONArray a = JSONArray.fromObject(taskList);
		@SuppressWarnings({ "unchecked" })
		final List<ProjectRecourceRefBo> refBoList = (List<ProjectRecourceRefBo>) JSONArray.toCollection(a,
				ProjectRecourceRefBo.class);
		projectRecourceRefBiz.projectUserSave(refBoList);
		return getView(ViewEnumType.JSON_VIEW);

	}
	/**
	 * 	
	 *
	 * @author linzhiqiang
	 * @date   2017年11月24日	
	 * @param userId
	 * @param chargeProj
	 * @param pkProj
	 * @return view
	 */
	@RequestMapping("/updateProjectRefUser.ajax")
	public String updateProjectRefUser(final Long userId,final String chargeProj,final Long pkProj) {
		projectRecourceRefBiz.updateProjectRefUser(userId,chargeProj,pkProj);
		return getView(ViewEnumType.JSON_VIEW);
	}
	/**
	 * 查询未分配人员
	 *
	 * @author linzhiqiang
	 * @date 2017年4月27日
	 * @param map
	 * @param condition
	 * @return view
	 */
	@RequestMapping("/projectUserList.ajax")
	public String projectUserList(final Map<String, Object> map, final ProjectRecourceRefCondition condition) {
		final List<ProjectUserListEntry> userList = projectRecourceRefBiz.projectUserList(condition);
		map.put("userList", userList);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 删除已分配人员
	 *
	 * @author linzhiqiang
	 * @date 2017年4月27日
	 * @param userList
	 * @param pkProj
	 * @return view
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/projectDeleteUser.ajax")
	public String projectDeleteUser(final String userList, final long pkProj) {
		final JSONArray a = JSONArray.fromObject(userList);

		final List<Long> userIdList = (List<Long>) JSONArray.toCollection(a);

		projectRecourceRefBiz.projectDeleteUser(userIdList, pkProj);

		return getView(ViewEnumType.JSON_VIEW);
	}
	
	/**
	 * 查询是否只有一位管理者	
	 *
	 * @author linzhiqiang
	 * @date   2017年11月30日	
	 * @param userId
	 * @param pkProj
	 * @param chargeProj
	 * @return view
	 */
	@RequestMapping("/queryProjectRefCharge.ajax")
	public String queryProjectRefCharge(final Long userId,final String chargeProj,final Long pkProj) {
		projectRecourceRefBiz.queryProjectRefCharge(pkProj,userId,chargeProj);
		return getView(ViewEnumType.JSON_VIEW);
	}

}
