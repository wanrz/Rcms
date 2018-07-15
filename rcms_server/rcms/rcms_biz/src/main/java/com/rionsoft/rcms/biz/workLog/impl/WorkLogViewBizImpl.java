/**
 *
 */
package com.rionsoft.rcms.biz.workLog.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rionsoft.rcms.biz.workLog.IWorkLogViewBiz;
import com.rionsoft.rcms.bo.user.UserInfoBo;
import com.rionsoft.rcms.bo.workLog.WorkLogBo;
import com.rionsoft.rcms.condition.workLog.WorkLogViewCondition;
import com.rionsoft.rcms.dao.user.IUserInfoDao;
import com.rionsoft.rcms.dao.workLog.IWorkLogDao;
import com.rionsoft.support.biz.BaseBiz;


/**
 * @author 刘教练
 * @date 2017年10月26日
 */
@Service
public class WorkLogViewBizImpl extends BaseBiz implements IWorkLogViewBiz {
	@Autowired
	private IWorkLogDao workLogDao;
	@Autowired
	private IUserInfoDao userInfoDao;
	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.workLog.IWorkLogViewBiz#queryWorkLogViewList(com.rionsoft.rcms.condition.workLog.WorkLogViewCondition)
	 */
	@Override
	public List<WorkLogBo> queryWorkLogViewList(WorkLogViewCondition logViewCondition) {
		if (logViewCondition.getCheckDirName() != "" && logViewCondition.getCheckDirName() != null) {
			logViewCondition.setDeptId(null);
			final String dirSeq = logViewCondition.getCheckDirName();
			if (dirSeq.contains("|")) {
				logViewCondition.setDirSeq(dirSeq.substring(dirSeq.lastIndexOf("|") + 1));
			} else {
				logViewCondition.setDirSeq(dirSeq);
			}
			logViewCondition.setDeptName(null);
		}
		if (logViewCondition.getCheckDirName2() != "" && logViewCondition.getCheckDirName2() != null) {
			logViewCondition.setDeptId(null);
			logViewCondition.setDirSeq(logViewCondition.getCheckDirName2());
			logViewCondition.setDeptName(null);
		}
		return mapListEntry(workLogDao.queryWorkLogViewList(logViewCondition), WorkLogBo.class);
	}
	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.workLog.IWorkLogViewBiz#userListByProjDirOperator(java.lang.String, java.lang.Long, java.lang.Long)
	 */
	@Override
	public List<UserInfoBo> userListByProjDirOperator(String userName, Long pkProj, Long dirId) {
		return map(userInfoDao.userListByProjDirOperator(userName, pkProj, dirId), UserInfoBo.class);
	}
	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.workLog.IWorkLogViewBiz#workLogViewVisual(java.lang.Long, java.lang.Long)
	 */
	@Override
	public List<WorkLogBo> workLogViewVisual(Long pkProj, Long userId,long dateId) {
		return mapListEntry(workLogDao.workLogViewVisual(pkProj, userId,dateId),WorkLogBo.class);
	}
}
