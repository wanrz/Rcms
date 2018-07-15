/**
 *
 */
package com.rionsoft.rcms.bo.constant;

import org.apache.commons.lang.StringUtils;

/**
 *
 * 字典相关枚举类
 *
 * @author likeke
 * @date 2016年12月27日
 */
public class DictEnum {

	/** 字典状态枚举 */
	public enum DictStatusEnum {
		/** 封存 - 1 */
		EFFECTIVE("1", "可用"),
		/** 可用 - 0 */
		INVALID("0", "封存");

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
		private DictStatusEnum(final String code, final String name) {
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
			for (final DictStatusEnum status : values()) {
				if (status.code.equals(code)) {
					return status.name;
				}
			}
			return null;
		}
	}

}
