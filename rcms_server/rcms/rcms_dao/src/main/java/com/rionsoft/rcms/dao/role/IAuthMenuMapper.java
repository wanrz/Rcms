/**
 *
 */
package com.rionsoft.rcms.dao.role;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.entry.role.AuthMenuEntry;

/**
 * @author likeke
 * @date 2017年4月24日
 */
@Repository
public interface IAuthMenuMapper {

	/**
	 * 根据用户id查询用户所有菜单信息
	 *
	 * @param userId
	 * @param loginCode
	 * @param adminLoginCode
	 * @return 用户所有菜单信息
	 */
	List<AuthMenuEntry> queryAuthMenuByUserId(@Param("userId") long userId, @Param("loginCode") String loginCode,
			@Param("adminLoginCode") String adminLoginCode);

}
