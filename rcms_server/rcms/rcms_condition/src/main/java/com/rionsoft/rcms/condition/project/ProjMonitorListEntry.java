/**
 *
 */
package com.rionsoft.rcms.condition.project;

import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年5月3日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjMonitorListEntry {
	/** 项目主键 */
	private long pkProj;
	/** 项目编号 */
	private String projCode;
	/** 项目名称 */
	private String projName;
	/** 计划完成时间 */
	private Date planEndDate;
	/** 参与人数 */
	private int personCount;
	/** 项目状态 */
	private String status;
	/** 项目经理id */
	private long pmId;
	/** 项目经理名称 */
	private String pmName;
	/** 完成百分比 */
	private int persent;
	/** 计划开始时间 */
	private Date expStartDate;
	/** 计划结束时间 */
	private Date expEndDate;
	/** 部门 */
	private String deptName;

}
