/**
 *
 */
package com.rionsoft.rcms.biz.department.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rionsoft.rcms.biz.code.SequenceTypeEnum;
import com.rionsoft.rcms.biz.constant.RCMSExceptionCodeEnum;
import com.rionsoft.rcms.biz.department.IAuthDirBiz;
import com.rionsoft.rcms.bo.department.AuthDirBo;
import com.rionsoft.rcms.condition.listentry.department.TreeNodeListEntry;
import com.rionsoft.rcms.dao.department.IAuthDirDao;
import com.rionsoft.rcms.dao.project.IProjectDao;
import com.rionsoft.rcms.dao.user.IUserInfoDao;
import com.rionsoft.rcms.entry.department.AuthDirEntry;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.biz.common.error.RionsoftException;
import com.rionsoft.support.biz.sequence.IManageSequenceBiz;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

/**
 * @author likeke
 * @date 2017年4月13日
 */
@Service
public class AuthDirBizImpl extends BaseBiz implements IAuthDirBiz {

	@Autowired
	private IAuthDirDao dirDaoImpl;
	@Autowired
	private IProjectDao projDao;
	@Autowired
	private IUserInfoDao userInfoDao;
	@Autowired
	private IManageSequenceBiz manageSequenceBiz;

	@Override
	public List<TreeNodeListEntry> queryTreeRoot() {
		return dirDaoImpl.queryTreeRoot();
	}

	@Override
	public void deptSave(final AuthDirBo authDirBo) {
		authDirBo.setSeq(manageSequenceBiz.getSequenceNo(SequenceTypeEnum.DEPTSEQ.getEnumName()));
		authDirBo.setDirSeq(authDirBo.getDirSeq() + "|" + authDirBo.getSeq());

		dirDaoImpl.insert(map(authDirBo, AuthDirEntry.class));
	}

	@Override
	public void deptUpdate(final AuthDirBo authDirBo) {

		dirDaoImpl.updateSelective(map(authDirBo, AuthDirEntry.class));
	}

	@Override
	public AuthDirEntry queryDept(final long dirId) {
		return dirDaoImpl.queryByID(dirId);
	}

	@Override
	public void deptDelete(final long dirId, final String dirSeq) {
		if (userInfoDao.queryUserByID(dirId) > 0) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0322,false, "人员");
		}
		if (projDao.queryProjById(dirId) > 0) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0322,false, "项目");
		}
		if (dirDaoImpl.queryCountByDirSeq(dirSeq) > 1) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0322,false, "子部门");
		}
		dirDaoImpl.deleteByID(dirId);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.rionsoft.rcms.biz.department.IAuthDirBiz#queryAuthDirEntryByUserId()
	 */
	@Override
	public AuthDirBo queryAuthDirEntryByUserId() {
		long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		AuthDirEntry authDirEntry = dirDaoImpl.queryAuthDirEntryByUserId(userId);
		return map(authDirEntry, AuthDirBo.class);
	}
}
