/**
 *
 */
package com.rionsoft.rcms.bo.role;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author likeke
 * @date 2017年4月24日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AuthRoleAttributeBo extends BaseBo {
	/** 角色ID */
	private long roleId;
	/** 属性ID */
	private long attributeId;

}
