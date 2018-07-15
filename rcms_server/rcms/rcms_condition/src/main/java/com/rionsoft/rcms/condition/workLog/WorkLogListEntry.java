/**
 *
 */
package com.rionsoft.rcms.condition.workLog;

import java.sql.Timestamp;
import java.util.Date;

import com.rionsoft.support.condition.IListEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author loujie
 * @data 2017年4月30日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class WorkLogListEntry implements IListEntry {
	/* 日志主键 */
	private Long pkWorkLog;
	/* 任务主键 */
	private Long pkTask;
	/* 参与人员 */
	private Long userId;
	/* 正常工时 */
	private Integer workTime;
	/* 加班工时 */
	private Integer overWorkTime;
	/* 加班缘由 */
	private String overWorkReason;
	/* 工作内容描述 */
	private String workDesc;
	/* 完成百分比 */
	private Long percentage;
	/* 是否审核 */
	private String isVerfied;
	/* 审核人 */
	private String pmId;
	/* 日志日期 */
	private Date logDate;
	/** 建立时间 */
	private Timestamp createTime;
	/** 更新时间 */
	private Timestamp updateTime;
	/** 创建人 */
	private Long createUserId;
	/** 修改人 */
	private Long modifyUserId;
	/** 版本号 */
	private Integer version;
	/** 计划开始日期 */
	private Date expStratDate;
	/** 计划结束日期 */
	private Date expEndDate;
	/** 任务编码 */
	private String taskCode;
	/** 任务名称 */
	private String taskName;
	/** 项目Id */
	private Long pkProj;
	/** 项目名称 */
	private String projName;
	/* 参与人员姓名 */
	private String userName;
	private Date theDay;
	private int daySum;
	private int weekSum;
	private int relSum;
	/** 任务的真正结束时间 */
	private Date relEndDate;
	/** 任务的状态 */
	private String status;
}
