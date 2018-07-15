/**
 *
 */
package com.rionsoft.rcms.bo.weeklyReport;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;


/**
 * @author 刘教练
 * @date 2017年9月30日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class RptWeeklyApprovalOpinionBo extends BaseBo {
	/* 周报主键 */
	private Long proRptId;
	/* 周报状态 */
	private String status;
	/* 审批意见*/
	private String approvalOpinions;
}
