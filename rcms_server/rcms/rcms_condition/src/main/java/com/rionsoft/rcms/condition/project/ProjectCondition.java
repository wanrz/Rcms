/**
 *
 */
package com.rionsoft.rcms.condition.project;

import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年4月19日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjectCondition extends AbstractQueryCondition {
	/* 项目名称（中文） */
	private String projName;
	/* 项目编码 */
	private String projCode;
	/* 项目主键 */
	private long pkProj;
	/* 申请部门 */
	private String deptId;
	/* 所有部门 */
	private String checkDirName;
	/* 项目状态 */
	private String status;
	/** 权限控制 */
	private long userId;
	private String adminLoginCode;
	private String loginCode;
	/** 部门编码 */
	private String dirSeq;
	/** 当数据权限为2的登录人员所在部门的下属部门 */
	private String checkDirName2;
	/** 部门名称 */
	private String deptName;
	/** 版本 */
	private String version;
}
