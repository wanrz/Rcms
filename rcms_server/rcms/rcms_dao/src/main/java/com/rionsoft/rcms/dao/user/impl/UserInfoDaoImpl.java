/**
 *
 */
package com.rionsoft.rcms.dao.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.listentry.user.UserInfoListEntry;
import com.rionsoft.rcms.condition.user.UserCondition;
import com.rionsoft.rcms.dao.user.IUserInfoDao;
import com.rionsoft.rcms.dao.user.IUserInfoMapper;
import com.rionsoft.rcms.entry.department.AuthDirEntry;
import com.rionsoft.rcms.entry.role.AuthDataTypeEntry;
import com.rionsoft.rcms.entry.system.BdDictDetailEntry;
import com.rionsoft.rcms.entry.user.UserInfoEntry;
import com.rionsoft.support.mybatisplugin.dao.common.annotation.GenerateId;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author likeke
 * @date 2017年4月14日
 */
@Repository
@GenerateId(value = true)
class UserInfoDaoImpl extends SingleTableDao<UserInfoEntry> implements IUserInfoDao {
	@Autowired
	private IUserInfoMapper userInfoMapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.user.IUserInfoDao#queryByCondition(com.rionsoft.
	 * rcms.condition.user.UserCondition)
	 */
	@Override
	public List<UserInfoListEntry> queryByCondition(final UserCondition userCondition) {

		return userInfoMapper.queryByCondition(userCondition);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.user.IUserInfoDao#deleteIdList(java.util.List)
	 */
	@Override
	public boolean deleteByIds(final List<Long> idList) {

		return super.deleteListByIdList(idList);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.user.IUserInfoDao#userArchive(java.util.List)
	 */
	@Override
	public void userArchive(final List<Long> userId, final String userStatus) {
		userInfoMapper.userArchive(userId, userStatus);

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.user.IUserInfoDao#queryUserByLoginCode(java.lang.
	 * String)
	 */
	@Override
	public UserInfoEntry queryUserByLoginCode(final String loginCode) {
		final Map<String, Object> map = new HashMap<>();
		map.put("LOGIN_CODE", loginCode);
		return super.queryByColumns(map);
	}

	@Override
	public int queryLoginCodeCount(final String loginCode) {
		return userInfoMapper.queryLoginCodeCount(loginCode);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.user.IUserInfoDao#queryUserByID(long)
	 */
	@Override
	public int queryUserByID(final long dirId) {
		final Map<String, Object> map = new HashMap<>();
		map.put("DIR_ID", dirId);
		return queryCountByColumns(map);
	}

	@Override
	public UserInfoListEntry queryPassword(final long userId) {
		return userInfoMapper.queryPassword(userId);
	}

	@Override
	public void updatePassword(final long userId, final String password) {
		userInfoMapper.updatePassword(userId, password);
	}

	@Override
	public List<AuthDirEntry> queryAuthDir() {
		return userInfoMapper.queryAuthDir();
	}

	@Override
	public List<BdDictDetailEntry> queryContract() {
		return userInfoMapper.queryContract();
	}

	@Override
	public List<BdDictDetailEntry> queryEmployee() {
		return userInfoMapper.queryEmployee();
	}

	@Override
	public List<BdDictDetailEntry> queryWages() {
		return userInfoMapper.queryWages();
	}

	@Override
	public List<String> selectExist(List<UserInfoEntry> entryList) {
		return userInfoMapper.selectExist(entryList);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.rionsoft.rcms.dao.user.IUserInfoDao#queryByDataCode(com.rionsoft.rcms
	 * .condition.user.UserCondition)
	 */
	@Override
	public List<UserInfoListEntry> queryByDataCode(UserCondition userCondition) {
		return userInfoMapper.queryByDataCode(userCondition);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.rionsoft.rcms.dao.user.IUserInfoDao#queryAuthRoleByUserId(com.
	 * rionsoft.rcms.condition.user.UserCondition)
	 */
	@Override
	public List<AuthDataTypeEntry> queryAuthRoleByUserId(UserCondition userCondition) {
		return userInfoMapper.queryAuthRoleByUserId(userCondition);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.user.IUserInfoDao#userListByProjDirOperator(java.lang.String, java.lang.Long, java.lang.Long)
	 */
	@Override
	public List<UserInfoEntry> userListByProjDirOperator(String userName, Long pkProj, Long dirId) {
		return userInfoMapper.userListByProjDirOperator(userName, pkProj, dirId);
	}
}