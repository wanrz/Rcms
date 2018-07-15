/**
 *
 */
package com.rionsoft.rcms.dao.department.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.listentry.department.TreeNodeListEntry;
import com.rionsoft.rcms.dao.department.IAuthDirDao;
import com.rionsoft.rcms.dao.department.IAuthDirMapper;
import com.rionsoft.rcms.entry.department.AuthDirEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author likeke
 * @date 2017年4月13日
 */
@Repository
class AuthDirDaoImpl extends SingleTableDao<AuthDirEntry> implements IAuthDirDao {

	/**
	 *
	 */
	@Autowired
	private IAuthDirMapper iAuthDirMapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.roep.dao.system.authdir.department.IAuthDirDao#queryTreeRoot
	 * ( long, java.lang.String)
	 */
	@Override
	public List<TreeNodeListEntry> queryTreeRoot() {
		return iAuthDirMapper.queryTreeRoot();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.rionsoft.rcms.dao.department.IAuthDirDao#queryCountByDirSeq(java.lang
	 * .String)
	 */
	@Override
	public long queryCountByDirSeq(final String dirSeq) {
		return iAuthDirMapper.queryCountByDirSeq(dirSeq);
	}

	@Override
	public AuthDirEntry queryAuthDirEntryByUserId(long userId) {
		return iAuthDirMapper.queryAuthDirEntryByUserId(userId);
	}

}
