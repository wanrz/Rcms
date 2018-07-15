/**
 *
 */
package com.rionsoft.rcms.condition.user;

import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author likeke
 * @date 2017年4月17日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class UserCondition extends AbstractQueryCondition {
	private Long dirId;
	/* 用户名 */
	private String userName;
	/* 登录名 */
	private String loginCode;

	/* 人员状态 */
	private String userStatus;

	private String checkDirName;
	private String checkDirName2;
	/* 用户Id */
	private Long userId;
	/** 部门名称 */
	private String dirName;
	/** 权限判断字段 */
	private Long userIds;
	private String loginCodes;
	private String adminLoginCode;
	/** 部门编码 */
	private String dirSeq;
}
