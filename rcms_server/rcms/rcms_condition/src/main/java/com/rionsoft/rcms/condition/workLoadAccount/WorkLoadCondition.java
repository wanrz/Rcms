/**
 *
 */
package com.rionsoft.rcms.condition.workLoadAccount;

import java.util.Date;

import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年5月2日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class WorkLoadCondition extends AbstractQueryCondition {
	/** 项目名称 */
	private String projName;
	/** 项目编码 */
	private String projCode;
	/** 项目状态 */
	private String projStatus;
	/** 统计年月开始时间 */
	private Date logDateStat;
	/** 统计年月结束时间 */
	private Date logDateEnd;
	/** 部门id */
	private String deptId;
	/** 项目主键 */
	private long pkProj;
	/** 登录人的id */
	private long userId;

	private String adminLoginCode;
	private String loginCode;
	/** 任务的年月 */
	private String yearMonth;
	/* 所有部门 */
	private String checkDirName;
	/** 部门编码 */
	private String dirSeq;
	/** 当数据权限为2的登录人员所在部门的下属部门 */
	private String checkDirName2;
	/** 部门名称 */
	private String deptName;
	/** 版本 */
	private String version;
}
