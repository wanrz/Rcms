/**
 *
 */
package com.rionsoft.rcms.bo.workLog;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author loujie
 * @data 2017年4月30日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class WorkLogBo extends BaseBo {
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
	/*加班缘由*/
	private String  overWorkReason;
	/* 工作内容描述 */
	private String workDesc;
	/* 完成百分比 */
	private Long percentage;
	/*是否审核*/
	private String isVerfied;
	/*审核人*/
	private String pmId;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	/* 日志日期 */
	private Date logDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	/* 计划结束日期 */
	private Date expEndDate;
	/* 任务编码 */
	private String taskCode;
	/* 任务名称 */
	private String taskName;
	/* 项目Id */
	private Long pkProj;
	/* 项目名称 */
	private String projName;
	/* 参与人员姓名 */
	private String userName;
	/** 星期几 **/
	private String whatday;
	/** 任务日期 **/
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date theDay;
	/** 任务时间差 **/
	private int daySum;
	private int weekSum;
	private int relSum;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date today;
	private Date expStratDate;
	/* 任务的真正结束时间*/
	private Date relEndDate;
	/* 任务的状态*/
	private String status;
}
