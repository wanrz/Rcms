/**
 *
 */
package com.rionsoft.rcms.condition.role;

import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author likeke
 * @date 2017年4月17日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class UserRoleCondition extends AbstractQueryCondition {
	/* 角色ID */
	private Long roleId;
	/* 用户ID */
	private Long userId;
	/* 员工姓名 */
	private Long userName;

	/* 是否授权角色标志位 true为已授权，false为未授权 */
	private Boolean roleStatus;
}
