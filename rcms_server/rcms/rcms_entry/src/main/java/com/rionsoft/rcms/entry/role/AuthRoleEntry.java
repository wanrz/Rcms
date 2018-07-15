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
 * 角色
 *
 * @author likeke
 * @date 2017年4月15日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createUserId = true, createTime = true, updateTime = true)
public class AuthRoleEntry extends BaseEntry {
	/** 角色id */
	@EntryPk
	private long roleId;
	/** 角色名称 */
	private String roleName;
	/** 角色描述 */
	private String roleDesc;

}
