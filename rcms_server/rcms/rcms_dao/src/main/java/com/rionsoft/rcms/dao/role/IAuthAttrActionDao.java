/**
 *
 */
package com.rionsoft.rcms.dao.role;

import java.util.List;

import com.rionsoft.rcms.condition.role.AuthAttributeActionQueryCondition;
import com.rionsoft.rcms.entry.role.AuthAttrActionEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;

/**
 * @author likeke
 * @date 2017年4月24日
 */
public interface IAuthAttrActionDao extends ISingleTableDao<AuthAttrActionEntry> {

	/**
	 * 根据条件获取
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
	 * @return List<AuthAttrActionEntry>
	 */
	List<AuthAttrActionEntry> queryAllAttrActionByUserId(Long userId, String loginCode, String adminLoginCode);

}
