/**
 *
 */
package com.rionsoft.rcms.dao.role;

import java.util.List;

import com.rionsoft.rcms.condition.listentry.role.AuthRoleListEntry;
import com.rionsoft.rcms.entry.role.AuthRoleEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.IWholeTableQuery;

/**
 * @author likeke
 * @date 2017年4月15日
 */
public interface IAuthRoleDao extends ISingleTableDao<AuthRoleEntry>, IWholeTableQuery<AuthRoleEntry> {

	/**
	 * @author likeke
	 * @date 2017年4月24日
	 * @param roleId
	 * @return AuthRoleListEntry
	 */
	AuthRoleListEntry queryRoleDetail(Long roleId);

	/**
	 * 查询登录用户拥有的角色
	 *
	 * @author likeke
	 * @date 2017年4月27日
	 * @param userId
	 * @param loginCode
	 *
	 * @param adminLoginCode
	 *            管理员登录名
	 * @return List<AuthRoleEntry>
	 */
	List<AuthRoleEntry> queryAuthRoleByUserId(Long userId, String loginCode, String adminLoginCode);

}
