/**
 *
 */
package com.rionsoft.rcms.biz.role;

import java.util.List;

import com.rionsoft.rcms.bo.role.AuthRoleBo;
import com.rionsoft.rcms.bo.role.UserRoleBo;
import com.rionsoft.rcms.condition.listentry.role.AuthRoleListEntry;
import com.rionsoft.rcms.condition.listentry.role.UserRoleListEntry;
import com.rionsoft.rcms.condition.role.UserRoleCondition;

/**
 * @author likeke
 * @date 2017年4月14日
 */
public interface IAuthRoleBiz {

	/**
	 * 创建人员角色
	 *
	 * @author likeke
	 * @param roleId
	 * @param userId
	 * @date 2017年4月15日
	 */
	void userRoleAdd(List<Long> roleId, long userId);

	/**
	 * 角色列表查询
	 *
	 * @author likeke
	 * @return List<AuthRoleBo>
	 * @date 2017年4月15日
	 */
	List<AuthRoleBo> roleList();

	/**
	 * 查询登录用户拥有的角色
	 *
	 * @author likeke
	 * @date 2017年4月17日
	 * @return List
	 */
	List<AuthRoleBo> queryAuthRoleByUserId();

	/**
	 * 人员角色列表查询
	 *
	 * @author likeke
	 * @param userRoleCondition
	 * @date 2017年4月17日
	 * @return List
	 */
	List<UserRoleListEntry> userRoleList(UserRoleCondition userRoleCondition);

	/**
	 * 根据角色Code查询人员
	 *
	 * @author likeke
	 * @date 2017年4月17日
	 * @return List<UserRoleListEntry>
	 */
	List<UserRoleListEntry> queryUserByRoleCode();

	/**
	 * 根据人员ID删除人员角色
	 *
	 * @author likeke
	 * @param userId
	 * @date 2017年4月17日
	 */
	void deleteUserRoleByIds(List<Long> userId);

	/**
	 * 查询用户拥有的角色人员关系
	 *
	 * @author likeke
	 * @param userId
	 * @date 2017年4月17日
	 * @return List
	 */
	List<UserRoleBo> userRoleById(long userId);

	/**
	 * 修改用户角色
	 *
	 * @author likeke
	 * @date 2017年4月20日
	 * @param roleId
	 * @param userId
	 */
	void userRoleUpdate(List<Long> roleId, long userId);

	/**
	 * 创建角色
	 *
	 * @author likeke
	 * @date 2017年4月24日
	 * @param authRoleBo
	 */
	void addRole(AuthRoleBo authRoleBo);

	/**
	 * 查询角色权限详情
	 *
	 * @author likeke
	 * @param roleId
	 * @return AuthRoleListEntry
	 * @date 2017年4月24日
	 */
	AuthRoleListEntry queryRoleDetail(Long roleId);

	/**
	 * 修改角色
	 *
	 * @author likeke
	 * @date 2017年4月24日
	 * @param authRoleBo
	 */
	void updateRole(AuthRoleBo authRoleBo);

	/**
	 * 删除角色
	 *
	 * @author likeke
	 * @param roleId
	 * @date 2017年4月24日
	 */
	void deleteRole(Long roleId);

}
