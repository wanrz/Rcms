/**
 *
 */
package com.rionsoft.rcms.bo.constant;

/**
 * @author <a href="mailto:dailycode@163.com"> liyw <a><br>
 *         2016年11月23日
 *
 */
public enum AuthMenuEnum {
	/** 是叶子节点 */
	IS("1"),
	/** 不是叶子节点 */
	NOT("0"),

	/** 一级菜单的父菜单编码常量 0 */
	P_CODE("0");

	/** 类型代码 */
	private String code;

	/**
	 * @param code
	 */
	private AuthMenuEnum(String code) {
		this.code = code;
	}

	/**
	 * @return { @link code}
	 */
	public String getCode() {
		return code;
	}
}
