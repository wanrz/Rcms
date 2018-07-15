/**
 *
 */
package com.rionsoft.rcms.condition.task;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author loujie
 * @data 2017年4月25日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TaskCondition extends AbstractQueryCondition {
	/* 项目主键 */
	private long pkProj;
	/* 任务编码 */
	private String taskCode;
	/* 任务名称 */
	private String taskName;
	/* 任务状态 */
	private String status;
	/* 参与员工姓名 */
	private String userName;
	/* 参与人员 */
	private long userId;
	/* 任务参与人 */
	private String taskJoiner;
	/* 计划结束日期 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date expEndDate;
	/* 实际结束日期 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date relEndDate;
	/* 所在部门 */
	private Long dirId;
	/* 项目经理 */
	private Long pmId;
	private List<Long> pkTaskList;
	private String adminLoginCode;
	private String loginCode;
	/*项目名称*/
	private String projName;
}
