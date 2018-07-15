/**
 *
 */
package com.rionsoft.rcms.bo.constant;

/**
 * @author loujie
 * @data 2017年4月27日
 */
public enum ProjectStatusEnum {

	/** 未立项 - 01 */
	NOT_PROJECT("01", "未立项"),
	/** 立项审批- 02 */
	PROJECT_APPROVAL("02", "立项审批"),
	/** 开发进行- 03 */
	CONDUCT_DEVELOPMENT("03", "开发进行"),
	/** 销售进行- 04 */
	CONDUCT_SALES("04", "销售进行"),
	/** 方案评审- 05 */
	PROGRAMME_REVIEW("05", "方案评审"),
	/** 结项- 06 */
	KNOT("06", "结项");

	private String code;
	private String type;

	private ProjectStatusEnum(final String code, final String type) {
		this.code = code;
		this.type = type;
	}

	/**
	 * @author loujie
	 * @data 2017年4月27日
	 * @return code
	 */
	public String getCode() {
		return this.code;
	}

	/**
	 * @author loujie
	 * @data 2017年4月27日
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
		for (final ProjectStatusEnum roleEnum : values()) {
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
		for (final ProjectStatusEnum roleEnum : values()) {
			if (roleEnum.type.equals(type)) {
				return roleEnum.code;
			}
		}
		return null;
	}

}
