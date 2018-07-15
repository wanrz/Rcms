package com.rionsoft.rcms.web.admin.role;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rionsoft.rcms.biz.role.IAuthAttributeBiz;
import com.rionsoft.rcms.biz.role.IAuthRoleBiz;
import com.rionsoft.rcms.biz.role.IAuthRoleDataBiz;
import com.rionsoft.rcms.bo.role.AuthRoleBo;
import com.rionsoft.rcms.condition.listentry.role.AuthMenuListEntry;
import com.rionsoft.rcms.condition.listentry.role.AuthRoleListEntry;
import com.rionsoft.rcms.condition.role.UserRoleCondition;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;

import net.sf.json.JSONArray;

/**
 * @author likeke
 * @date 2017年4月14日
 */
@Controller
@RequestMapping("/admin/role")
public class AuthRoleController extends BaseController {

	@Autowired
	private IAuthRoleBiz roleBizImpl;
	@Autowired
	private IAuthAttributeBiz attributeBizImpl;
	@Autowired
	private IAuthRoleDataBiz authRoleDataBiz;

	/**
	 * 角色管理页面条跳转
	 *
	 * @author likeke
	 * @date 2017年4月14日
	 * @return String
	 */
	@RequestMapping("/roleManage.do")
	public String roleManage() {
		return getView("admin/role/roleManage");
	}

	/**
	 * 角色列表查询
	 *
	 * @author likeke
	 * @param map
	 * @date 2017年4月14日
	 * @return String
	 */
	@RequestMapping("/roleList.ajax")
	public String roleList(final Map<String, Object> map) {

		map.put("roleBolist", roleBizImpl.roleList());
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 人员角色列表查跳转
	 *
	 * @author likeke
	 * @date 2017年4月14日
	 * @return String
	 */
	@RequestMapping("/toUserRole.do")
	public String toUserRole() {
		return getView("admin/role/userRoleManage");
	}

	/**
	 * 人员角色列表查询
	 *
	 * @author likeke
	 * @param map
	 * @param userRoleCondition
	 * @date 2017年4月14日
	 * @return String
	 */
	@RequestMapping("/userRoleList.ajax")
	public String userRoleList(final Map<String, Object> map, final UserRoleCondition userRoleCondition) {
		map.put("userRoleList", roleBizImpl.userRoleList(userRoleCondition));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 创建角色页面跳转
	 *
	 * @author likeke
	 * @param model
	 * @date 2017年4月14日
	 * @return String
	 */
	@RequestMapping("/roleAdd.do")
	public String toRoleAdd(final Map<String, Object> model) {
		/* 查询所有功能权限 */
		model.put("attrList", attributeBizImpl.queryMenuAttribute());
		/* 查询所有数据权限 */
		model.put("dataList", authRoleDataBiz.queryAllData());
		return getView("admin/role/roleAdd");
	}

	/**
	 * 创建角色
	 *
	 * @author likeke
	 * @param authRoleBo
	 * @date 2017年4月14日
	 * @return String
	 */
	@RequestMapping("/roleAdd.ajax")
	public String roleAdd(final AuthRoleBo authRoleBo) {
		roleBizImpl.addRole(authRoleBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 修改角色页面跳转
	 *
	 * @author likeke
	 * @param model
	 * @param roleId
	 * @date 2017年4月14日
	 * @return String
	 */
	@RequestMapping("/roleUpdate.do")
	public String toRoleUpdate(final Map<String, Object> model, final Long roleId) {
		/* 查询所有功能权限 */
		model.put("attrList", attributeBizImpl.queryMenuAttribute());
		List<AuthMenuListEntry> menuList = attributeBizImpl.queryMenuAttribute();
		List<String> menuCodeList = new ArrayList<String>();
		for (int i = 0; i < menuList.size(); i++) {
			AuthMenuListEntry authMenuListEntry = menuList.get(i);
			String menuCode = authMenuListEntry.getMenuCode();
			menuCodeList.add(menuCode);
		}
		// JSONArray JmenuCodeList = JSONArray.fromObject(menuCodeList);
		model.put("menuCodeList", JSONArray.fromObject(menuCodeList));
		/* 查询所有数据权限 */
		model.put("dataList", authRoleDataBiz.queryAllData());
		/* 查询角色拥有功能和数据权限 */
		final AuthRoleListEntry listEntry = roleBizImpl.queryRoleDetail(roleId);
		model.put("authRoleBo", listEntry);
		model.put("containAttr", "," + StringUtils.join(listEntry.getAttributeIds(), ",") + ",");
		model.put("containData", "," + StringUtils.join(listEntry.getDataIds(), ",") + ",");
		return getView("admin/role/roleUpdate");
	}

	/**
	 * 修改角色
	 *
	 * @author likeke
	 * @param authRoleBo
	 * @date 2017年4月14日
	 * @return String
	 */
	@RequestMapping("/roleUpdate.ajax")
	public String roleUpdate(final AuthRoleBo authRoleBo) {
		roleBizImpl.updateRole(authRoleBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 删除角色
	 *
	 * @author likeke
	 * @param roleId
	 * @date 2017年4月14日
	 * @return String
	 */
	@RequestMapping("/roleDelete.ajax")
	public String roleDelete(final Long roleId) {
		roleBizImpl.deleteRole(roleId);
		return getView(ViewEnumType.JSON_VIEW);
	}
}
