package com.rionsoft.rcms.dao.weeklyReport;

import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.entry.weeklyReport.RptWeeklyApprovalOpinionsEntry;

/**
 * @author 刘教练
 * @date 2017年10月9日
 */
@Repository
public interface IWeeklyReportApproveMapper {
	/**
	 * 提交周报意见审批信息
	 * 
	 * @author 刘教练
	 * @date 2017年10月17日
	 * @param rptWeeklyApproveEntry
	 */
	void insertRptWeeklyApprove(RptWeeklyApprovalOpinionsEntry rptWeeklyApproveEntry);
}
