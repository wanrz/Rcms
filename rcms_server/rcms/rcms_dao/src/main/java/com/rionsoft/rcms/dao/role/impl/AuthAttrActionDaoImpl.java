/**
 *
 */
package com.rionsoft.rcms.dao.role.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.role.AuthAttributeActionQueryCondition;
import com.rionsoft.rcms.dao.role.IAuthAttrActionDao;
import com.rionsoft.rcms.dao.role.IAuthAttrActionMapper;
import com.rionsoft.rcms.entry.role.AuthAttrActionEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author likeke
 * @date 2017年4月24日
 */
@Repository
class AuthAttrActionDaoImpl extends SingleTableDao<AuthAttrActionEntry> implements IAuthAttrActionDao {
	@Autowired
	private IAuthAttrActionMapper authAttrActionMapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.role.IAuthAttrActionDao#queryAllAttributeAction(com
	 * .rionsoft.rcms.condition.role.AuthAttributeActionQueryCondition)
	 */
	@Override
	public List<AuthAttrActionEntry> queryAllAttributeAction(final AuthAttributeActionQueryCondition condition) {
		return authAttrActionMapper.queryAllAttributeAction(condition);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.role.IAuthAttrActionDao#queryAllAttActionByUserId(
	 * java.lang.Long)
	 */
	@Override
	public List<AuthAttrActionEntry> queryAllAttrActionByUserId(final Long userId, final String loginCode,
			final String adminLoginCode) {
		return authAttrActionMapper.queryAllAttrActionByUserId(userId, loginCode, adminLoginCode);
	}

}
