/**
 *
 */
package com.rionsoft.rcms.condition.workLog;





import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;


/**
 * @author 刘教练
 * @date 2017年10月26日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class WorkLogViewCondition extends AbstractQueryCondition {
	/* 参与人员 */
	private Long userId;
	/* 人员姓名*/
	private String userName;
	/*登录名*/
	private String loginCode;
	/* 项目名称（中文） */
	private String projName;
	/* 项目编码 */
	private String projCode;
	/* 项目主键 */
	private Long pkProj;
	/* 任务主键*/
	private Long pkTask;
	/* 申请部门 */
	private String deptId;
	/* 所有部门 */
	private String checkDirName;
	/* 项目状态 */
	private String status;
	/* 部门编码 */
	private String dirSeq;
	/* 当数据权限为2的登录人员所在部门的下属部门 */
	private String checkDirName2;
	/* 部门名称 */
	private String deptName;
	/* 计划结束日期 */
	private String beginDate;
	/* 实际结束日期 */
	private String endDate;
	/*操作人员*/
	private Long operatorId;
}
