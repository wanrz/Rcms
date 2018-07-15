/**
 *
 */
package com.rionsoft.rcms.entry.task;

import java.math.BigDecimal;
import java.sql.Date;

import com.rionsoft.support.baseentry.BaseEntry;
import com.rionsoft.support.baseentry.annotation.EntryPk;
import com.rionsoft.support.baseentry.util.VarietyEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author loujie
 * @data 2017年4月25日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createTime = true, createUserId = true, updateTime = true, modifyUserId = true)
public class TaskEntry extends BaseEntry {

	@EntryPk
	/* 任务主键 */
	private Long pkTask;
	/* 项目主键 */
	private Long pkProj;
	/* 任务编码 */
	private String taskCode;
	/* 任务名称 */
	private String taskName;
	/* 计划开始日期 */
	private Date expStartDate;
	/* 计划结束日期 */
	private Date expEndDate;
	/* 实际结束日期 */
	private Date relEndDate;
	/* 完成百分比 */
	private Long percentage;
	/* 工作量 */
	private BigDecimal workload;
	/* 任务状态 */
	private String status;
	/* 任务类型 */
	private String taskType;
}
