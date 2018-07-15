package com.rionsoft.rcms.biz.weeklyReport.impl;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rionsoft.rcms.biz.common.cache.CacheUtil;
import com.rionsoft.rcms.biz.weeklyReport.IWeeklyReportApproveBiz;
import com.rionsoft.rcms.bo.project.ProjectBo;
import com.rionsoft.rcms.bo.weeklyReport.ProjectRptWeeklyBo;
import com.rionsoft.rcms.bo.weeklyReport.RptWeeklyApprovalOpinionBo;
import com.rionsoft.rcms.condition.project.ProjectCondition;
import com.rionsoft.rcms.dao.project.IProjectDao;
import com.rionsoft.rcms.dao.weeklyReport.IWeeklyReportApproveDao;
import com.rionsoft.rcms.dao.weeklyReport.IWeeklyReportFillDao;
import com.rionsoft.rcms.entry.weeklyReport.ProjectRptWeeklyEntry;
import com.rionsoft.rcms.entry.weeklyReport.RptWeeklyApprovalOpinionsEntry;
import com.rionsoft.support.basebo.session.UserLoginBo;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;
/**
 * @author 刘教练
 * @date 2017年9月29日
 */
@Service
public class WeeklyReportApproveBizImpl extends BaseBiz implements IWeeklyReportApproveBiz {
	@Autowired
	private IWeeklyReportFillDao weeklyReportFillDao;
	@Autowired
	private IProjectDao projectDao;
	@Autowired
	private IWeeklyReportApproveDao weeklyReportApproveDao;
	
	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.weeklyReport.IWeeklyReportApproveBiz#weeklyReportListManagerAbove(com.rionsoft.rcms.condition.weeklyReport.ProjectRptWeeklyCondition)
	 */
	@Override
	public List<ProjectRptWeeklyBo> weeklyReportListManagerAbove(ProjectCondition projectCondition) {
		ProjectCondition projectCond = userLImitsOfAuthority(projectCondition);
		return mapListEntry(weeklyReportFillDao.weeklyReportListManagerAbove(projectCond),ProjectRptWeeklyBo.class);
	}
	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.weeklyReport.IWeeklyReportApproveBiz#projectListByApprovalTime(com.rionsoft.rcms.condition.project.ProjectCondition, javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public List<ProjectBo> projectListByApprovalTime(ProjectCondition projectCondition, HttpServletRequest req) {
		ProjectCondition projectCond = userLImitsOfAuthority(projectCondition);
		return mapListEntry(projectDao.projectListByApprovalTime(projectCond),ProjectBo.class);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.weeklyReport.IWeeklyReportApproveBiz#insertRptWeeklyApprove(com.rionsoft.rcms.bo.weeklyReport.RptWeeklyApprovalOpinionBo)
	 */
	@Override
	public void insertRptWeeklyApprove(RptWeeklyApprovalOpinionBo rptWeeklyApproveBo) {
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		ProjectRptWeeklyBo projectRptWeeklyBo = new ProjectRptWeeklyBo();
		projectRptWeeklyBo.setStatus(rptWeeklyApproveBo.getStatus());
		projectRptWeeklyBo.setProRptId(rptWeeklyApproveBo.getProRptId());
		projectRptWeeklyBo.setApprovalUserId(userId);
		projectRptWeeklyBo.setApprovalOpinions(rptWeeklyApproveBo.getApprovalOpinions());
		projectRptWeeklyBo.setApprovalTime(Timestamp.valueOf(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())));
		weeklyReportFillDao.updateSelective(map(projectRptWeeklyBo, ProjectRptWeeklyEntry.class));
		weeklyReportApproveDao.insertRptWeeklyApprove(map(rptWeeklyApproveBo, RptWeeklyApprovalOpinionsEntry.class));
	}
	private ProjectCondition userLImitsOfAuthority(ProjectCondition projectCondition) {
		if (projectCondition.getCheckDirName() != "" && projectCondition.getCheckDirName() != null) {
			projectCondition.setDeptId(null);
			final String dirSeq = projectCondition.getCheckDirName();
			if (dirSeq.contains("|")) {
				projectCondition.setDirSeq(dirSeq.substring(dirSeq.lastIndexOf("|") + 1));
			} else {
				projectCondition.setDirSeq(dirSeq);
			}
			projectCondition.setDeptName(null);
		}
		if (projectCondition.getCheckDirName2() != "" && projectCondition.getCheckDirName2() != null) {
			projectCondition.setDeptId(null);
			projectCondition.setDirSeq(projectCondition.getCheckDirName2());
			projectCondition.setDeptName(null);
		}

		// 用户权限判断
		UserLoginBo userLoginBo = SessionLocal.getSessionLocal(SessionLocalEnum.USER_LOGIN_INFO);
		projectCondition.setUserId(userLoginBo.getUserId());
		projectCondition.setLoginCode(String.valueOf(CacheUtil.isAdmin(userLoginBo.getLoginCode())));
		return projectCondition;
	}
}
