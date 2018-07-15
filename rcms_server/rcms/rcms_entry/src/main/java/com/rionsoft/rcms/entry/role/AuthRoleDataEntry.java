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
 * 角色拥有的数据权限
 *
 * @author likeke
 * @date 2017年4月15日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createUserId = true, createTime = true, updateTime = true)
public class AuthRoleDataEntry extends BaseEntry {
	@EntryPk
	/** 角色id */
	private long roleId;
	/** 数据类型id */
	private long DataId;
}
