/**
 *
 */
package com.rionsoft.rcms.bo.constant;

/**
 * @author loujie
 * @data 2017年4月26日
 */
public enum TaskTypeEnum {

	/** 计划外 - 1 */
	OUTSIDE_THE_PLAN("1", "计划外"),
	/** 计划内 - 2 */
	INSIDE_THE_PLAN("2", "计划内");

	private String code;
	private String type;

	private TaskTypeEnum(final String code, final String type) {
		this.code = code;
		this.type = type;
	}

	/**
	 * @author loujie
	 * @data 2017年4月26日
	 * @return string
	 */
	public String getCode() {
		return this.code;
	}

	/**
	 * @author loujie
	 * @data 2017年4月26日
	 * @return string
	 */
	public String getType() {
		return this.type;
	}

	/**
	 * 根据code查询枚举名称type
	 *
	 * @param code
	 * @return name
	 */
	public static String getType(final String code) {
		if (code == null || code.isEmpty()) {
			return null;
		}
		for (final TaskTypeEnum roleEnum : values()) {
			if (roleEnum.code.equals(code)) {
				return roleEnum.type;
			}
		}
		return null;
	}

	/**
	 * 根据type查询枚举名称code
	 *
	 * @param type
	 * @return name
	 */
	public static String getCode(final String type) {
		if (type == null || type.isEmpty()) {
			return null;
		}
		for (final TaskTypeEnum roleEnum : values()) {
			if (roleEnum.type.equals(type)) {
				return roleEnum.code;
			}
		}
		return null;
	}
}
