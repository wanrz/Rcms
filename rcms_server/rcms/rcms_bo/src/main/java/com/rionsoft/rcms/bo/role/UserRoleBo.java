/**
 *
 */
package com.rionsoft.rcms.bo.role;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author likeke
 * @date 2017年4月15日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class UserRoleBo extends BaseBo {
	/** 用户id */
	private long userId;
	/** 角色id */
	private long roleId;

}
