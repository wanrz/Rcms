/**
 *
 */
package com.rionsoft.rcms.dao.role;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.listentry.role.UserRoleListEntry;
import com.rionsoft.rcms.condition.role.UserRoleCondition;

/**
 * @author likeke
 * @date 2017年4月15日
 */
@Repository
public interface IUserRoleMapper {
	/**
	 * 人员角色列表查询
	 *
	 * @author likekes
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
