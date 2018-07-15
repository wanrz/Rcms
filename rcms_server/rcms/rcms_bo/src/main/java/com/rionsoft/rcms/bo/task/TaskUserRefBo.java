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
public class TaskUserRefBo extends BaseBo {
	/* 任务主键 */
	private Long pkTask;
	/* 参与人员 */
	private Long userId;
	/* 完成百分比 */
	private Long percentage;
	/* 参与人员姓名 */
	private String userName;
	/* 部门名称 */
	private String dirName;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	/* 计划开始日期 */
	private Date expStartDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	/* 计划结束日期 */
	private Date expEndDate;
	private BigDecimal requireWorkload;

	/**
	 * 导出时使用
	 */
	/** 项目名称 */
	private String projName;
	/** 项目经理名称 */
	private String pmName;
	/* 任务编码 */
	private String taskCode;
	/* 任务名称 */
	private String taskName;
	/* 任务实际完成时间 */
	private Date relEndDate;
	/* 任务状态 */
	private String status;
}
