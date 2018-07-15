/**
 *
 */
package com.rionsoft.rcms.dao.role;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.listentry.role.AuthAttributeListEntry;
import com.rionsoft.rcms.condition.listentry.role.AuthMenuListEntry;

/**
 * @author likeke
 * @date 2017年4月24日
 */
@Repository
public interface IAuthAttributeMapper {
	/**
	 * 查询所有菜单操作信息
	 *
	 * @return 菜单操作信息
	 */
	List<AuthMenuListEntry> queryMenuAttribute();

	/**
	 * 根据actionUrl查询菜单和操作名称
	 *
	 * @param actionUrl
	 * @return 菜单和操作名称
	 */
	List<AuthAttributeListEntry> queryMenuAndAttr(@Param("actionUrl") String actionUrl);
}
