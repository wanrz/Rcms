/**
 *
 */
package com.rionsoft.rcms.dao.role.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.listentry.role.AuthRoleListEntry;
import com.rionsoft.rcms.dao.role.IAuthRoleDao;
import com.rionsoft.rcms.dao.role.IAuthRoleMapper;
import com.rionsoft.rcms.entry.role.AuthRoleEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author likeke
 * @date 2017年4月15日
 */
@Repository
class AuthRoleDaoImpl extends SingleTableDao<AuthRoleEntry> implements IAuthRoleDao {

	@Autowired
	private IAuthRoleMapper authRoleMapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.role.IAuthRoleDao#queryRoleDetail(java.lang.Long)
	 */
	@Override
	public AuthRoleListEntry queryRoleDetail(final Long roleId) {
		return authRoleMapper.queryRoleDetail(roleId);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.role.IAuthRoleDao#queryAuthRoleById(java.lang.Long)
	 */
	@Override
	public List<AuthRoleEntry> queryAuthRoleByUserId(final Long userId, final String loginCode,
			final String adminLoginCode) {
		return authRoleMapper.queryAuthRoleByUserId(userId, loginCode, adminLoginCode);
	}

}
