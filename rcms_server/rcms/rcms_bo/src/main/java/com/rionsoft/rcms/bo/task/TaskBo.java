/**
 *
 */
package com.rionsoft.rcms.bo.task;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author loujie
 * @data 2017年4月25日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TaskBo extends BaseBo {
	/* 任务主键 */
	private Long pkTask;
	/* 项目主键 */
	private Long pkProj;
	/* 任务编码 */
	private String taskCode;
	/* 任务名称 */
	private String taskName;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	/* 计划开始日期 */
	private Date expStartDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	/* 计划结束日期 */
	private Date expEndDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	/* 实际完成日期 */
	private Date relEndDate;
	/* 完成百分比 */
	private Long percentage;
	/* 工作量 */
	private BigDecimal workload;
	/* 任务状态 */
	private String status;
	/* 任务参与人数 */
	private String userCount;
	/* 任务参与人 */
	private String taskJoiner;
	/* 任务类型 */
	private String taskType;
	/* 项目名称（中文） */
	private String projName;
	/* 项目经理名称 */
	private String pmName;
}
