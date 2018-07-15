/**
 *
 */
package com.rionsoft.rcms.dao.role.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.dao.role.IAuthMenuDao;
import com.rionsoft.rcms.dao.role.IAuthMenuMapper;
import com.rionsoft.rcms.entry.role.AuthMenuEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author likeke
 * @date 2017年4月24日
 */
@Repository
class AuthMenuDaoImpl extends SingleTableDao<AuthMenuEntry> implements IAuthMenuDao {

	@Autowired
	private IAuthMenuMapper authMenuMapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.roep.dao.auth.IAuthMenuDao#queryAuthMenuByUserId(long)
	 */
	@Override
	public List<AuthMenuEntry> queryAuthMenuByUserId(final long userId, final String loginCode,
			final String adminLoginCode) {
		return authMenuMapper.queryAuthMenuByUserId(userId, loginCode, adminLoginCode);
	}
}
