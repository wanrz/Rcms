/**
 *
 */
package com.rionsoft.rcms.condition.listentry.role;

import com.rionsoft.support.condition.IListEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author likeke
 * @date 2017年4月24日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AuthAttributeListEntry implements IListEntry {
	/**  */
	private long attributeId;
	/** 标题 */
	private String title;
	private String attributeCode;
	private String operationType;
	/** 菜单名称 */
	private String menuName;
}
