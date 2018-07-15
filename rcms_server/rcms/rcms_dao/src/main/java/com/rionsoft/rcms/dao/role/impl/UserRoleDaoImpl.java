/**
 *
 */
package com.rionsoft.rcms.dao.role.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.listentry.role.UserRoleListEntry;
import com.rionsoft.rcms.condition.role.UserRoleCondition;
import com.rionsoft.rcms.dao.role.IUserRoleDao;
import com.rionsoft.rcms.dao.role.IUserRoleMapper;
import com.rionsoft.rcms.entry.role.UserRoleEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author likeke
 * @date 2017年4月15日
 */
@Repository
class UserRoleDaoImpl extends SingleTableDao<UserRoleEntry> implements IUserRoleDao {

	@Autowired
	private IUserRoleMapper userRoleMapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.role.IUserRoleDao#insertList(java.util.List)
	 */
	@Override
	public void insertList(final List<UserRoleEntry> entryList) {
		super.insertList(entryList, true, false);

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.role.IUserRoleDao#queryListById()
	 */
	@Override
	public List<UserRoleEntry> queryListById(final long userId) {
		final Map<String, Object> columnValues = new HashMap<>();
		columnValues.put("USER_ID", userId);
		return super.queryListByColumns(columnValues);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.role.IUserRoleDao#deleteListByIds(long)
	 */
	@Override
	public void deleteListByIds(final List<Long> userId) {
		super.deleteListByIdList(userId);

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.role.IUserRoleDao#queryListByRoleId(java.lang.Long)
	 */
	@Override
	public List<UserRoleEntry> queryListByRoleId(final Long roleId) {
		final Map<String, Object> columnValues = new HashMap<>();
		columnValues.put("ROLE_ID", roleId);
		return super.queryListByColumns(columnValues);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.role.IAuthRoleDao#userRoleList()
	 */
	@Override
	public List<UserRoleListEntry> userRoleList(final UserRoleCondition userRoleCondition) {
		return userRoleMapper.userRoleList(userRoleCondition);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.role.IUserRoleDao#queryUserByRoleCode(java.lang.
	 * String)
	 */
	@Override
	public List<UserRoleListEntry> queryUserByRoleCode() {
		return userRoleMapper.queryUserByRoleCode();
	}

}
