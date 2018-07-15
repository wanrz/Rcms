/**
 *
 */
package com.rionsoft.rcms.dao.role;

import java.util.List;

import com.rionsoft.rcms.condition.listentry.role.AuthAttributeListEntry;
import com.rionsoft.rcms.condition.listentry.role.AuthMenuListEntry;
import com.rionsoft.rcms.entry.role.AuthAttributeEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;

/**
 * @author likeke
 * @date 2017年4月24日
 */
public interface IAuthAttributeDao extends ISingleTableDao<AuthAttributeEntry> {
	/**
	 * 查询户所有属性
	 *
	 * @return 属性列表
	 */
	List<AuthAttributeEntry> queryAuthAttribute();

	/**
	 * 查询所有可用属性
	 *
	 * @return 属性列表
	 */
	List<AuthMenuListEntry> queryMenuAttribute();

	/**
	 * 根据actionUrl查询菜单和操作名称
	 *
	 * @param actionUrl
	 * @return 菜单和操作名称
	 */
	List<AuthAttributeListEntry> queryMenuAndAttr(String actionUrl);
}
