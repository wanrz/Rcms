/**
 *
 */
package com.rionsoft.rcms.condition.task;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

import com.rionsoft.support.condition.IListEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author loujie
 * @data 2017年4月25日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TaskListEntry implements IListEntry {
	/* 任务主键 */
	private long pkTask;
	/* 项目主键 */
	private long pkProj;
	/* 任务编码 */
	private String taskCode;
	/* 任务名称 */
	private String taskName;
	/* 计划开始日期 */
	private Date expStartDate;
	/* 计划结束日期 */
	private Date expEndDate;
	/* 实际完成日期 */
	private Date relEndDate;
	/* 完成百分比 */
	private Long percentage;
	/* 工作量 */
	private BigDecimal workload;
	/* 任务状态 */
	private String status;
	/* 员工数量 */
	private String userCount;
	/* 任务参与人 */
	private String taskJoiner;
	/* 任务类型 */
	private String taskType;
	/** 建立时间 */
	private Timestamp createTime;
	/** 更新时间 */
	private Timestamp updateTime;
	/** 创建人 */
	private long createUserId;
	/** 最后更新人 */
	private long modifyUserId;
	/** 项目名称 */
	private String projName;
	/** 项目经理名称 */
	private String pmName;

}
