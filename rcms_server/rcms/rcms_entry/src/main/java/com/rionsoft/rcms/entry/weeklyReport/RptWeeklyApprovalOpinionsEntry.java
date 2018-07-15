/**
 *
 */
package com.rionsoft.rcms.entry.weeklyReport;

import com.rionsoft.support.baseentry.BaseEntry;
import com.rionsoft.support.baseentry.annotation.EntryPk;
import com.rionsoft.support.baseentry.annotation.VersionEntry;
import com.rionsoft.support.baseentry.util.VarietyEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;
/**
 * @author 刘教练
 * @date 2017年10月11日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VersionEntry
@VarietyEntry(createTime = true, createUserId = true)
public class RptWeeklyApprovalOpinionsEntry extends BaseEntry {
	/* 周报主键 */
	@EntryPk
	private Long proRptId;
	/* 周报状态 */
	private String status;
	/* 审批意见*/
	private String approvalOpinions;
}