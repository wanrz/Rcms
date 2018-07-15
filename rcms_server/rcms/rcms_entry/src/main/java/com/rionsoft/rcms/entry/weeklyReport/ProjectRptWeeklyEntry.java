/**
 *
 */
package com.rionsoft.rcms.entry.weeklyReport;

import java.sql.Date;
import java.sql.Timestamp;

import com.rionsoft.support.baseentry.BaseEntry;
import com.rionsoft.support.baseentry.annotation.EntryPk;
import com.rionsoft.support.baseentry.util.VarietyEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;
/**
 * @author 刘教练
 * @date 2017年10月17日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createTime = true, createUserId = true, updateTime = true, modifyUserId = true)
public class ProjectRptWeeklyEntry extends BaseEntry {
	/* 周报主键 */
	@EntryPk
	private Long proRptId;
	/* 项目主键 */
	private Long pkProj;
	/* 周报开始日期 */
	private Date weekBeginDate;
	/* 周报结束日期 */
	private Date weekEndDate;
	/* 里程碑 */
	private String milePost;
	/* 本周事项汇报 */
	private String curRpt;
	/* 当前重要风险*/
	private String curRisk;
	/* 下周重要事项 */
	private String nextRpt;
	/* 周报状态 */
	private String status;
	/*审批人*/
	private Long  approvalUserId;
	/*审批时间*/
	private Timestamp approvalTime;
	/* 审批意见*/
	private String approvalOpinions;
}
