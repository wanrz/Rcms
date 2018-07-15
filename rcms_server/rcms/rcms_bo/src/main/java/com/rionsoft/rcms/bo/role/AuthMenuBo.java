/**
 *
 */
package com.rionsoft.rcms.bo.role;

import java.io.Serializable;
import java.util.List;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author likeke
 * @date 2017年4月24日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AuthMenuBo extends BaseBo implements Comparable<AuthMenuBo>, Serializable {
	/**  */
	private static final long serialVersionUID = 1L;
	/** 菜单id */
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
	/** 菜单样式 */
	private String menuClass;
	/** 子菜单 */
	private List<AuthMenuBo> childMenuList;
	private List<AuthAttributeBo> attrList;

	/*
	 * (non-Javadoc)
	 *
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo(final AuthMenuBo arg0) {
		return this.getIdx().compareTo(arg0.getIdx());
	}
}
