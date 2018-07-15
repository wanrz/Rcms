/**
 *
 */
package com.rionsoft.rcms.dao.role.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.listentry.role.AuthAttributeListEntry;
import com.rionsoft.rcms.condition.listentry.role.AuthMenuListEntry;
import com.rionsoft.rcms.dao.role.IAuthAttributeDao;
import com.rionsoft.rcms.dao.role.IAuthAttributeMapper;
import com.rionsoft.rcms.entry.role.AuthAttributeEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author likeke
 * @date 2017年4月24日
 */
@Repository
class AuthAttributeDaoImpl extends SingleTableDao<AuthAttributeEntry> implements IAuthAttributeDao {
	@Autowired
	private IAuthAttributeMapper authAttrMapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.roep.dao.auth.IAuthMenuDao#queryAuthMenuByUserId(long)
	 */
	@Override
	public List<AuthAttributeEntry> queryAuthAttribute() {
		return super.queryAll();
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.roep.dao.auth.IAuthAttributeDao#queryMenuAttribute()
	 */
	@Override
	public List<AuthMenuListEntry> queryMenuAttribute() {
		return authAttrMapper.queryMenuAttribute();
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.roep.dao.auth.IAuthAttributeDao#queryMenuAndAttr(java.lang.
	 * String)
	 */
	@Override
	public List<AuthAttributeListEntry> queryMenuAndAttr(final String actionUrl) {
		return authAttrMapper.queryMenuAndAttr(actionUrl);
	}
}
