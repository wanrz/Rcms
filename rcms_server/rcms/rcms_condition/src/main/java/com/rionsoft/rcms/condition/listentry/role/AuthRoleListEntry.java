/**
 *
 */
package com.rionsoft.rcms.condition.listentry.role;

import java.util.List;

import com.rionsoft.support.condition.IListEntry;

import lombok.Data;

/**
 * 角色
 *
 * @author likeke
 * @date 2017年4月15日
 */
@Data
public class AuthRoleListEntry implements IListEntry {
	/** 角色id */
	private long roleId;
	/** 角色名称 */
	private String roleName;
	/** 角色描述 */
	private String roleDesc;
	/** 角色CODE */
	private String roleCode;
	/** 角色功能权限 */
	private List<Long> attributeIds;
	/** 角色数据权限 */
	private List<Long> dataIds;

}
