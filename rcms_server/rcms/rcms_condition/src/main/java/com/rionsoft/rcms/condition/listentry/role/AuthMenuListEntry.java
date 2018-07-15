/**
 *
 */
package com.rionsoft.rcms.condition.listentry.role;

import java.util.List;

import com.rionsoft.support.condition.IListEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author likeke
 * @date 2017年4月24日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AuthMenuListEntry implements IListEntry {
	/** 菜单名称 */
	private String menuName;
	/** 菜单编码 */
	private String menuCode;
	private List<AuthAttributeListEntry> attrList;
}
