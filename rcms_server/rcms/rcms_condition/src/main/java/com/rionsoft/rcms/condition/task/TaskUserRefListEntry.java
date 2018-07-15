/**
 *
 */
package com.rionsoft.rcms.condition.task;

import java.math.BigDecimal;
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
public class TaskUserRefListEntry implements IListEntry {
	/* 任务主键 */
	private long pkTask;
	/* 参与人员 */
	private long userId;
	/* 参与人员姓名 */
	private String userName;
	/* 部门名称 */
	private String dirName;
	/* 完成百分比 */
	private long percentage;
	/* 计划开始日期 */
	private Date expStartDate;
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
	@SuppressWarnings("unused")
	private String status;

	/**
	 * @author likeke
	 * @date 2017年5月1日
	 * @return 返回任务状态
	 */
	public String getStatus() {
		if (percentage == 100) {
			return "已完成";
		}
		return "未完成";

	}
}
