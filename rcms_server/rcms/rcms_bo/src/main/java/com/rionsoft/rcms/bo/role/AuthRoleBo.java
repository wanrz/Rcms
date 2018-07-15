/**
 *
 */
package com.rionsoft.rcms.bo.role;

import java.util.List;

import com.rionsoft.support.basebo.BaseBo;

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
public class AuthRoleBo extends BaseBo {
	/** 角色id */
	private long roleId;
	/** 角色名称 */
	private String roleName;
	/** 角色描述 */
	private String roleDesc;
	/** 角色功能权限 */
	private List<Long> attributeIds;
	/** 角色数据权限 */
	private List<Long> dataIds;

}
