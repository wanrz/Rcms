package com.rionsoft.rcms.dao.weeklyReport;

import com.rionsoft.rcms.entry.weeklyReport.RptWeeklyApprovalOpinionsEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;

/**
 * @author 刘教练
 * @date 2017年10月11日
 */
public interface IWeeklyReportApproveDao extends ISingleTableDao<RptWeeklyApprovalOpinionsEntry> {
	/**
	 * 提交周报意见审批信息
	 * 
	 * @author 刘教练
	 * @date 2017年10月17日
	 * @param rptWeeklyApproveEntry
	 */
	void insertRptWeeklyApprove(RptWeeklyApprovalOpinionsEntry rptWeeklyApproveEntry);

}
