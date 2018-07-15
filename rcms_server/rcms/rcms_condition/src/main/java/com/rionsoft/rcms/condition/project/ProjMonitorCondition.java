/**
 *
 */
package com.rionsoft.rcms.condition.project;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年5月3日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjMonitorCondition extends AbstractQueryCondition {
	/** 项目编码 */
	private String projCode;
	/** 项目名称 */
	private String projName;
	/** 部门名称 */
	private String deptName;
	/** 项目状态 */
	private String status;
	/** 部门id */
	private Long deptId;
	/** 参与人员id */
	private Long personId;
	/** 项目经理id */
	private Long pmId;
	/** 计划完成日期 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date planEndDate;
	/** 所有部门 */
	private String checkDirName;
	/** 部门编码 */
	private String dirSeq;
	/** 当数据权限为2的登录人员所在部门的下属部门 */
	private String checkDirName2;
	/** 登录用户id */
	private Long userId;
	private String adminLoginCode;
	private String loginCode;

}
