/**
 *
 */
package com.rionsoft.rcms.bo.constant;

/**
 * 角色枚举
 *
 * @author likeke
 * @date 2017年4月28日
 */
public enum AuthRoleEnum {

	/** 总经理 - GM */
	GM("GM", "总经理"),
	/** 副总经理 - DGM */
	DGM("DGM", "副总经理"),
	/** 事业部经理 - CGM */
	CGM("CGM", "事业部经理"),
	/** 项目经理 - PM */
	PM("PM", "项目经理"),
	/** 技术经理 - TM */
	TM("TM", "技术经理"),
	/** 组长- TL */
	TL("TL", "组长"),
	/** 质量经理 - QAM */
	QAM("QAM", "质量经理"),
	/** 程序员 - PG */
	PG("PG ", "程序员"),
	/** 测试人员 - STG */
	STG("STG", "测试人员"),
	/** 财务经理 - FM */
	FM("FM", "财务经理");

	private String code;
	private String type;

	private AuthRoleEnum(final String code, final String type) {
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
		for (final AuthRoleEnum roleEnum : values()) {
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
		for (final AuthRoleEnum roleEnum : values()) {
			if (roleEnum.type.equals(type)) {
				return roleEnum.code;
			}
		}
		return null;
	}

}
