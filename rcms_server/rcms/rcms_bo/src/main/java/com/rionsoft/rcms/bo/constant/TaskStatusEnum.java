/**
 *
 */
package com.rionsoft.rcms.bo.constant;

/**
 * @author loujie
 * @data 2017年4月26日
 */
public enum TaskStatusEnum {

	/** 未开始 - 0 */
	NODOING("0", "未开始"),
	/** 进行中 - 1 */
	DOING("1", "进行中"),
	/** 已完成 - 2 */
	COMPLETED("2", "已完成"),
	/** 已封存 - 3 */
	SEALED("3", "已封存"),
	/** 延误 - 4 */
	DELAYED("4", "延误"),
	/** 强制完成 - 5 */
	FORCECOMPLETED("5","已强制完成");
	
	private String code;
	private String type;

	private TaskStatusEnum(final String code, final String type) {
		this.code = code;
		this.type = type;
	}

	/**
	 * @author loujie
	 * @data 2017年4月26日
	 * @return code
	 */
	public String getCode() {
		return this.code;
	}

	/**
	 * @author loujie
	 * @data 2017年4月26日
	 * @return type
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
		for (final TaskStatusEnum roleEnum : values()) {
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
		for (final TaskStatusEnum roleEnum : values()) {
			if (roleEnum.type.equals(type)) {
				return roleEnum.code;
			}
		}
		return null;
	}

}
