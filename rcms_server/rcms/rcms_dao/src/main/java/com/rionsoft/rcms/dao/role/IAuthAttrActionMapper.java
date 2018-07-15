/**
 *
 */
package com.rionsoft.rcms.dao.role;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.role.AuthAttributeActionQueryCondition;
import com.rionsoft.rcms.entry.role.AuthAttrActionEntry;

/**
 * @author likeke
 * @date 2017年4月24日
 */
@Repository
public interface IAuthAttrActionMapper {

	/**
	 * 查询资源
	 *
	 * @author likeke
	 * @date 2017年4月27日
	 * @param condition
	 * @return 资源
	 */
	List<AuthAttrActionEntry> queryAllAttributeAction(AuthAttributeActionQueryCondition condition);

	/**
	 * 根据用户Id查询所有菜单操作权限
	 *
	 * @author likeke
	 * @date 2017年4月27日
	 * @param userId
	 * @param adminLoginCode
	 * @param loginCode
	 * @return 资源
	 */
	List<AuthAttrActionEntry> queryAllAttrActionByUserId(@Param("userId") Long userId,
			@Param("loginCode") String loginCode, @Param("adminLoginCode") String adminLoginCode);

}
