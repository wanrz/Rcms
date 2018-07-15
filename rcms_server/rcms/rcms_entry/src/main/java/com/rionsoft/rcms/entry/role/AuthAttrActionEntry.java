/**
 *
 */
package com.rionsoft.rcms.entry.role;

import com.rionsoft.support.baseentry.BaseEntry;
import com.rionsoft.support.baseentry.util.VarietyEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 属性功能表
 *
 * @author likeke
 * @date 2017年4月15日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createTime = true)
public class AuthAttrActionEntry extends BaseEntry {

	/** 属性id */
	private long attributeId;
	/** 功能url */
	private String actionUrl;
	/** 是否验证资源权限 0:不验证 1:验证 */
	private String verifyResource;
}
