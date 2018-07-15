/**
 *
 */
package com.rionsoft.rcms.biz.project.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import com.rionsoft.rcms.biz.constant.RCMSExceptionCodeEnum;
import com.rionsoft.rcms.biz.project.IProjectRecourceRefBiz;
import com.rionsoft.rcms.bo.project.ProjectRecourceRefBo;
import com.rionsoft.rcms.bo.user.UserInfoBo;
import com.rionsoft.rcms.condition.project.ProjectRecourceRefCondition;
import com.rionsoft.rcms.condition.project.ProjectRecourceRefListEntry;
import com.rionsoft.rcms.condition.project.ProjectUserListEntry;
import com.rionsoft.rcms.dao.project.IProjectRecourceRefDao;
import com.rionsoft.rcms.entry.project.ProjectRecourceRefEntry;
import com.rionsoft.support.basebo.session.UserLoginBo;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.biz.common.constants.SessionConstant;
import com.rionsoft.support.biz.common.error.RionsoftException;
import com.rionsoft.support.biz.common.insertlist.ITableInsertListBiz;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;
import com.rionsoft.support.mybatisplugin.dao.util.PropertyPlaceholderUtils;

/**
 * @author linzhiqiang
 * @date 2017年4月25日
 */
@Service
public class ProjectRecourceRefBizImpl extends BaseBiz implements IProjectRecourceRefBiz {
	@Autowired
	private IProjectRecourceRefDao projectRecourceRefDao;
	@Autowired
	private ITableInsertListBiz iTableInsertListBiz;

	@Override
	public List<ProjectRecourceRefListEntry> projectRfeQuery(final ProjectRecourceRefCondition condition,
			final HttpServletRequest req) {
		if (condition.getCheckDirName() != "" && condition.getCheckDirName() != null) {
			final String dirSeq = condition.getCheckDirName();
			if (dirSeq.contains("|")) {
				condition.setDirSeq(dirSeq.substring(dirSeq.lastIndexOf("|") + 1));
			} else {
				condition.setDirSeq(dirSeq);
			}
			condition.setDeptName(null);
			condition.setDeptId(null);
		}
		if (condition.getCheckDirName2() != "" && condition.getCheckDirName2() != null) {
			condition.setDeptId(null);
			condition.setDirSeq(condition.getCheckDirName2());
			condition.setDeptName(null);
		}
		// 用户权限判断
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		final String adminLoginCode = PropertyPlaceholderUtils.getContextProperty("adminLoginCode");
		final UserLoginBo bo = (UserLoginBo) WebUtils.getSessionAttribute(req, SessionConstant.ADMIN_LOGIN.name());
		condition.setUserId(userId);
		condition.setAdminLoginCode(adminLoginCode);
		condition.setLoginCode(bo.getLoginCode());

		return projectRecourceRefDao.queryProjResByDataCode(condition);
	}

	@Override
	public List<ProjectUserListEntry> projectUserQuery(final ProjectRecourceRefCondition condition) {

		return projectRecourceRefDao.projectUserQuery(condition);
	}

	@Override
	public void projectUserSave(final List<ProjectRecourceRefBo> refBoList) {
		final List<ProjectRecourceRefEntry> entryList = mapToEntryList(refBoList, ProjectRecourceRefEntry.class);
		// iTableInsertListBiz.insertList(entryList,
		// ProjectRecourceRefEntry.class, true);
		iTableInsertListBiz.insertWithUnionFieldPkList(entryList, ProjectRecourceRefEntry.class, true);
	}

	@Override
	public List<ProjectUserListEntry> projectUserList(final ProjectRecourceRefCondition condition) {

		return projectRecourceRefDao.projectUserList(condition);
	}

	@Override
	public void projectDeleteUser(final List<Long> userIdList, final long pkProj) {
		 List<UserInfoBo> userInfoBo=map(projectRecourceRefDao.queryCountInfo(userIdList,pkProj),UserInfoBo.class);
         String name = "";
         if(userInfoBo.size()>0){
            for(UserInfoBo bo:userInfoBo){
         	   name = name + bo.getUserName() + ",";
            }
            throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0328, false, name.substring(0, name.length() - 1));
         }
         projectRecourceRefDao.projectDeleteUser(userIdList, pkProj);
		
	}

	@Override
	public void updateProjectRefUser(final Long userId, final String chargeProj, final Long pkProj) {
		projectRecourceRefDao.updateProjectRefUser(userId, chargeProj, pkProj);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.project.IProjectRecourceRefBiz#queryProjectRefCharge(java.lang.Long)
	 */
	@Override
	public void queryProjectRefCharge(final Long pkProj,final Long userId,final String chargeProj) {
		int count=0;
		if(chargeProj.equals("2")){
			 count=projectRecourceRefDao.queryProjectRefCharge(pkProj);
		}
		
		if(count>0){
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0330, false);
		}
		projectRecourceRefDao.updateProjectRefUser(userId, chargeProj, pkProj);
	}

}
