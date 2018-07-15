/**
 *
 */
package com.rionsoft.rcms.condition.role;

import lombok.Data;

/**
 * @author likeke
 * @date 2017年4月27日
 */
@Data
public class AuthAttributeActionQueryCondition {

	private String actionUrl;
	/* 用户ID */
	private Long userId;
}
