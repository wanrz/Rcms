/**
 *
 */
package com.rionsoft.rcms.bo.constant;

import org.apache.commons.lang.StringUtils;

/**
 *
 * 人员相关枚举类
 *
 * @author likeke
 * @date 2016年12月27日
 */
public class UserEnum {

	/** 人员状态枚举 */
	public enum UserStatusEnum {
		/** 生效 - 1 */
		EFFECTIVE("1", "生效"),
		/** 失效 - 0 */
		INVALID("0", "失效");

		private final String code;
		private final String name;

		/**
		 * @return { @link code}
		 */
		public String getCode() {
			return code;
		}

		/**
		 * @param code
		 * @param name
		 */
		private UserStatusEnum(final String code, final String name) {
			this.code = code;
			this.name = name;
		}

		/**
		 * 根据枚举code转换name
		 *
		 * @param code
		 * @return name
		 */
		public static String getTypeName(final String code) {
			if (StringUtils.isEmpty(code)) {
				return null;
			}
			for (final UserStatusEnum status : values()) {
				if (status.code.equals(code)) {
					return status.name;
				}
			}
			return null;
		}
	}

}
