/**
 *
 */
package com.rionsoft.rcms.entry.role;

import com.rionsoft.support.baseentry.BaseEntry;
import com.rionsoft.support.baseentry.annotation.EntryPk;
import com.rionsoft.support.baseentry.util.VarietyEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 属性菜单权限表
 * 
 * @author likeke
 * @date 2017年4月15日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createUserId = true, createTime = true, updateTime = true)
public class AuthAttributeEntry extends BaseEntry {
	/**  */
	@EntryPk
	private long attributeId;
	/** 属性编码 */
	private String attributeCode;
	/** 菜单编码 */
	private String menuCode;
	/** 标题 */
	private String title;
	private Integer idx;
	/** 操作url */
	private String operationUrl;
	/** 操作类型 1:查询 2:编辑 */
	private Integer operationType;

}
