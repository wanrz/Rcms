/**
 *
 */
package com.rionsoft.rcms.biz.role;

import java.util.List;

import com.rionsoft.rcms.condition.listentry.role.AuthAttributeListEntry;
import com.rionsoft.rcms.condition.listentry.role.AuthMenuListEntry;
import com.rionsoft.rcms.condition.role.AuthAttributeActionQueryCondition;
import com.rionsoft.rcms.entry.role.AuthAttrActionEntry;

/**
 * @author likeke
 * @date 2017年4月24日
 */
public interface IAuthAttributeBiz {

	/**
	 * 查询所有属性
	 *
	 * @return 资源
	 */
	List<AuthMenuListEntry> queryMenuAttribute();

	/**
	 * 根据actionUrl查询菜单和操作名称
	 *
	 * @param actionUrl
	 * @return 菜单和操作名称
	 */
	List<AuthAttributeListEntry> queryMenuAndAttr(String actionUrl);

	/**
	 * 查询所有操作资源
	 *
	 * @author likeke
	 * @date 2017年4月27日
	 * @param condition
	 * @return List<AuthAttributeActionEntry>
	 */
	List<AuthAttrActionEntry> queryAllAttributeAction(AuthAttributeActionQueryCondition condition);

	/**
	 * 根据用户Id查询所有菜单操作权限
	 *
	 * @author likeke
	 * @param userId
	 * @param loginCode
	 * @date 2017年4月27日
	 * @return List<AuthAttributeActionEntry>
	 */
	List<String> queryAllAttrActionByUserId(Long userId, String loginCode);

}
