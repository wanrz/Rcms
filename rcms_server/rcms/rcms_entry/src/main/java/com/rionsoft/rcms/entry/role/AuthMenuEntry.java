/**
 *
 */
package com.rionsoft.rcms.entry.role;

import com.rionsoft.support.baseentry.BaseEntry;
import com.rionsoft.support.baseentry.annotation.EntryPk;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 菜单表
 *
 * @author likeke
 * @date 2017年4月15日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AuthMenuEntry extends BaseEntry {
	/** 菜单id */
	@EntryPk
	private long menuId;
	/** 菜单名称 */
	private String menuName;
	/** 菜单编码 */
	private String menuCode;
	/** 父菜单编码 */
	private String parentMenuCode;
	/** 是否叶子节点 */
	private String isLeaf;
	/** 显示顺序 */
	private Integer idx;
	/** 功能url */
	private String actionUrl;
}
