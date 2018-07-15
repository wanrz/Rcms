/**
 *
 */
package com.rionsoft.rcms.dao.role;

import java.util.List;

import com.rionsoft.rcms.condition.listentry.role.UserRoleListEntry;
import com.rionsoft.rcms.condition.role.UserRoleCondition;
import com.rionsoft.rcms.entry.role.UserRoleEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.IWholeTableQuery;

/**
 * @author likeke
 * @date 2017年4月15日
 */
public interface IUserRoleDao extends ISingleTableDao<UserRoleEntry>, IWholeTableQuery<UserRoleEntry> {
	/**
	 * @author likeke
	 * @date 2017年4月20日
	 * @param entryList
	 */
	void insertList(List<UserRoleEntry> entryList);

	/**
	 * 查询用户拥有的角色人员关系
	 *
	 * @author likeke
	 * @param userId
	 * @date 2017年4月20日
	 * @return List<UserRoleEntry>
	 */
	List<UserRoleEntry> queryListById(long userId);

	/**
	 * 删除用户拥有的角色
	 *
	 * @author likeke
	 * @param userId
	 * @date 2017年4月20日
	 */
	void deleteListByIds(List<Long> userId);

	/**
	 * 根据角色ID查询用户角色
	 *
	 * @author likeke
	 * @param roleId
	 * @return List<UserRoleEntry>
	 * @date 2017年4月20日
	 */
	List<UserRoleEntry> queryListByRoleId(Long roleId);

	/**
	 * 人员角色列表查询
	 *
	 * @author likeke
	 * @param userRoleCondition
	 * @date 2017年4月17日
	 * @return List<UserRoleListEntry>
	 */
	List<UserRoleListEntry> userRoleList(UserRoleCondition userRoleCondition);

	/**
	 * 根据角色Code查询人员
	 *
	 * @author likeke
	 * @date 2017年4月28日
	 * @return List<UserRoleListEntry>
	 */
	List<UserRoleListEntry> queryUserByRoleCode();

}
