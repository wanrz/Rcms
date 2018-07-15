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
 * 角色拥有菜单权限
 *
 * @author likeke
 * @date 2017年4月15日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createUserId = true, createTime = true, updateTime = true)
public class AuthRoleAttributeEntry extends BaseEntry {
	@EntryPk
	/** 角色ID */
	private long roleId;
	/** 属性ID */
	private long attributeId;

}
