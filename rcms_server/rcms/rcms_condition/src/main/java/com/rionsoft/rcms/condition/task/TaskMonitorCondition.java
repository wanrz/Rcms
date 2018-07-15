/**
 *
 */
package com.rionsoft.rcms.condition.task;

import java.sql.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 进度查询
 *
 * @author likeke
 * @date 2017年5月1日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TaskMonitorCondition extends AbstractQueryCondition {
	/* 任务主键 */
	private Long pkTask;
	/* 任务编码 */
	private String taskCode;
	/* 任务名称 */
	private String taskName;
	/* 任务状态 */
	private String status;
	/* 员工姓名 */
	private String userName;
	/* 参与人员 */
	private long userId;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	/* 计划结束日期 */
	private Date expEndDate;
	/* 所在部门 */
	private Long dirId;

	private List<Long> pkTaskList;
}
