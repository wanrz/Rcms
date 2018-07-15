/**
 *
 */
package com.rionsoft.rcms.condition.project;

import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年4月25日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjectRecourceRefCondition extends AbstractQueryCondition {
	/** 项目名称 */
	private String projName;
	/** 项目编码 */
	private String projCode;
	/** 项目主键 */
	private long pkProj;
	/** 部门id */
	private Long deptId;
	/** 部门名称 */
	private String deptName;
	/** 部门编码 */
	private String dirSeq;
	/** 用户名称 */
	private String userName;
	/** 登录用户id */
	private Long userId;
	private String adminLoginCode;
	private String loginCode;
	/** 全部部门 */
	private String CheckDirName2;
	/** 部门 */
	private String CheckDirName;
}
