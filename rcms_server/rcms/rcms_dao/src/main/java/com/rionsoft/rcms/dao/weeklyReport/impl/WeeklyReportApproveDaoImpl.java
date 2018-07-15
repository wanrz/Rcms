package com.rionsoft.rcms.dao.weeklyReport.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.dao.weeklyReport.IWeeklyReportApproveDao;
import com.rionsoft.rcms.dao.weeklyReport.IWeeklyReportApproveMapper;
import com.rionsoft.rcms.entry.weeklyReport.RptWeeklyApprovalOpinionsEntry;
import com.rionsoft.support.mybatisplugin.dao.common.annotation.GenerateId;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;
/**
 * @author 刘教练
 * @date 2017年10月9日
 */
@Repository
@GenerateId(value = true)
class WeeklyReportApproveDaoImpl extends SingleTableDao<RptWeeklyApprovalOpinionsEntry> implements IWeeklyReportApproveDao {
	@Autowired
	private IWeeklyReportApproveMapper rptWeeklyApproveMapper;
	@Override
	public void insertRptWeeklyApprove(RptWeeklyApprovalOpinionsEntry rptWeeklyApproveEntry) {
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		rptWeeklyApproveEntry.setCreateUserId(userId);
		rptWeeklyApproveMapper.insertRptWeeklyApprove(rptWeeklyApproveEntry);
	}
}