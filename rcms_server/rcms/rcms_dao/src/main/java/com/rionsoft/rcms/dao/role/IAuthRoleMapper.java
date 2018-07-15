/**
 *
 */
package com.rionsoft.rcms.dao.role;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.listentry.role.AuthRoleListEntry;
import com.rionsoft.rcms.entry.role.AuthRoleEntry;

/**
 * @author likeke
 * @date 2017年4月15日
 */
@Repository
public interface IAuthRoleMapper {

	/**
	 * 根据角色ID查询角色权限详情
	 *
	 * @author likeke
	 * @date 2017年4月24日
	 * @param roleId
	 * @return List<AuthRoleListEntry>
	 */
	AuthRoleListEntry queryRoleDetail(Long roleId);

	/**
	 * 查询登录用户拥有的角色
	 *
	 * @author likeke
	 * @date 2017年4月27日
	 * @param userId
	 * @param loginCode
	 * @param adminLoginCode
	 * @return List<AuthRoleEntry>
	 */
	List<AuthRoleEntry> queryAuthRoleByUserId(@Param("userId") Long userId, @Param("loginCode") String loginCode,
			@Param("adminLoginCode") String adminLoginCode);

}
