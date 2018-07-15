/**
 *
 */
package com.rionsoft.rcms.biz.role;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rionsoft.rcms.biz.constant.RCMSExceptionCodeEnum;
import com.rionsoft.rcms.bo.role.AuthRoleBo;
import com.rionsoft.rcms.bo.role.UserRoleBo;
import com.rionsoft.rcms.condition.listentry.role.AuthRoleListEntry;
import com.rionsoft.rcms.condition.listentry.role.UserRoleListEntry;
import com.rionsoft.rcms.condition.role.UserRoleCondition;
import com.rionsoft.rcms.dao.role.IAuthRoleAttributeDao;
import com.rionsoft.rcms.dao.role.IAuthRoleDao;
import com.rionsoft.rcms.dao.role.IAuthRoleDataDao;
import com.rionsoft.rcms.dao.role.IUserRoleDao;
import com.rionsoft.rcms.entry.role.AuthRoleAttributeEntry;
import com.rionsoft.rcms.entry.role.AuthRoleDataEntry;
import com.rionsoft.rcms.entry.role.AuthRoleEntry;
import com.rionsoft.rcms.entry.role.UserRoleEntry;
import com.rionsoft.support.basebo.session.UserLoginBo;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.biz.common.error.RionsoftException;
import com.rionsoft.support.biz.common.insertlist.ITableInsertListBiz;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;
import com.rionsoft.support.mybatisplugin.dao.util.PropertyPlaceholderUtils;

/**
 * @author likeke
 * @date 2017年4月14日
 */
@Service
public class AuthRoleBizImpl extends BaseBiz implements IAuthRoleBiz {
	@Autowired
	private IAuthRoleDao authRoleDaoImpl;
	@Autowired
	private IUserRoleDao userRoleDaoImpl;

	/* 批量插使用 */
	@Autowired
	private ITableInsertListBiz iTableInsertListBiz;
	@Autowired
	private IAuthRoleAttributeDao authRoleAttributeDaoImpl;
	@Autowired
	private IAuthRoleDataDao authRoleDataDaoImpl;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.role.IAuthRoleBiz#roleAdd()
	 */
	@Override
	public void userRoleAdd(final List<Long> roleId, final long userId) {

		final List<UserRoleEntry> entryList = new ArrayList<>();
		for (final long id : roleId) {
			final UserRoleEntry entry = new UserRoleEntry();
			entry.setRoleId(id);
			entry.setUserId(userId);
			entryList.add(entry);
		}
		userRoleDaoImpl.insertList(entryList);

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.role.IAuthRoleBiz#roleList()
	 */
	@Override
	public List<AuthRoleBo> roleList() {

		return map(authRoleDaoImpl.queryAll(), AuthRoleBo.class);

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.role.IAuthRoleBiz#userRoleList()
	 */
	@Override
	public List<UserRoleListEntry> userRoleList(final UserRoleCondition userRoleCondition) {
		return userRoleDaoImpl.userRoleList(userRoleCondition);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.role.IAuthRoleBiz#userRoleById(java.lang.Long)
	 */
	@Override
	public List<UserRoleBo> userRoleById(final long userId) {
		return map(userRoleDaoImpl.queryListById(userId), UserRoleBo.class);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.role.IAuthRoleBiz#userRoleDelet(java.lang.Long)
	 */
	@Override
	public void deleteUserRoleByIds(final List<Long> userId) {
		userRoleDaoImpl.deleteListByIds(userId);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.role.IAuthRoleBiz#userRoleUpdate(java.util.List,
	 * long)
	 */
	@Override
	public void userRoleUpdate(final List<Long> roleId, final long userId) {
		/* 删除人员角色 */
		final List<Long> userIds = new ArrayList<>();
		userIds.add(userId);
		deleteUserRoleByIds(userIds);
		/* 添加人员角色 */
		userRoleAdd(roleId, userId);

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.role.IAuthRoleBiz#addRole(com.rionsoft.rcms.bo.role
	 * .AuthRoleBo)
	 */
	@Override
	@Transactional
	public void addRole(final AuthRoleBo authRoleBo) {
		final AuthRoleEntry authRoleEntry = map(authRoleBo, AuthRoleEntry.class);

		authRoleDaoImpl.insert(authRoleEntry);
		final List<AuthRoleAttributeEntry> roleEntryList = new ArrayList<>();

		for (final Long attributeId : authRoleBo.getAttributeIds()) {
			final AuthRoleAttributeEntry e = new AuthRoleAttributeEntry();
			e.setAttributeId(attributeId);
			e.setRoleId(authRoleEntry.getRoleId());
			roleEntryList.add(e);
		}
		// iTableInsertListBiz.insertList(roleEntryList,
		// AuthRoleAttributeEntry.class, true);
		iTableInsertListBiz.insertWithUnionFieldPkList(roleEntryList, AuthRoleAttributeEntry.class, true);
		final List<AuthRoleDataEntry> dataEntryDList = new ArrayList<>();
		for (final Long dataId : authRoleBo.getDataIds()) {
			final AuthRoleDataEntry e = new AuthRoleDataEntry();
			e.setDataId(dataId);
			e.setRoleId(authRoleEntry.getRoleId());
			dataEntryDList.add(e);
		}
		// iTableInsertListBiz.insertList(dataEntryDList,
		// AuthRoleDataEntry.class, true);
		iTableInsertListBiz.insertWithUnionFieldPkList(dataEntryDList, AuthRoleDataEntry.class, true);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.role.IAuthRoleBiz#updateRole(com.rionsoft.rcms.bo.
	 * role.AuthRoleBo)
	 */
	@Override
	public void updateRole(final AuthRoleBo authRoleBo) {
		/* 删除角色级联表 */
		authRoleAttributeDaoImpl.deleteByID(authRoleBo.getRoleId());
		authRoleDataDaoImpl.deleteByID(authRoleBo.getRoleId());
		/* 修改 */
		authRoleDaoImpl.update(map(authRoleBo, AuthRoleEntry.class));
		final List<AuthRoleAttributeEntry> roleEntryList = new ArrayList<>();
		for (final Long attributeId : authRoleBo.getAttributeIds()) {
			final AuthRoleAttributeEntry e = new AuthRoleAttributeEntry();
			e.setAttributeId(attributeId);
			e.setRoleId(authRoleBo.getRoleId());
			roleEntryList.add(e);
		}
		// iTableInsertListBiz.insertList(roleEntryList,
		// AuthRoleAttributeEntry.class, true);
		iTableInsertListBiz.insertWithUnionFieldPkList(roleEntryList, AuthRoleAttributeEntry.class, true);
		final List<AuthRoleDataEntry> dataEntryDList = new ArrayList<>();
		for (final Long dataId : authRoleBo.getDataIds()) {
			final AuthRoleDataEntry e = new AuthRoleDataEntry();
			e.setDataId(dataId);
			e.setRoleId(authRoleBo.getRoleId());
			dataEntryDList.add(e);
		}
		// iTableInsertListBiz.insertList(dataEntryDList,
		// AuthRoleDataEntry.class, true);
		iTableInsertListBiz.insertWithUnionFieldPkList(dataEntryDList, AuthRoleDataEntry.class, true);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.role.IAuthRoleBiz#deleteRole(java.lang.Long)
	 */
	@Override
	public void deleteRole(final Long roleId) {
		/* 校验角色是否授权给用户 */
		final List<UserRoleEntry> entryList = userRoleDaoImpl.queryListByRoleId(roleId);
		if (!entryList.isEmpty()) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0019, false);
		}
		/* 删除角色 */
		authRoleDaoImpl.deleteByID(roleId);
		authRoleAttributeDaoImpl.deleteByID(roleId);
		authRoleDataDaoImpl.deleteByID(roleId);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.role.IAuthRoleBiz#queryRoleDetail(java.lang.Long)
	 */
	@Override
	public AuthRoleListEntry queryRoleDetail(final Long roleId) {
		return authRoleDaoImpl.queryRoleDetail(roleId);

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.role.IAuthRoleBiz#QueryAuthRoleById(long)
	 */
	@Override
	public List<AuthRoleBo> queryAuthRoleByUserId() {
		final String adminLoginCode = PropertyPlaceholderUtils.getContextProperty("adminLoginCode");
		final UserLoginBo bo = (UserLoginBo) SessionLocal.getSessionLocal(SessionLocalEnum.USER_LOGIN_INFO);
		return map(authRoleDaoImpl.queryAuthRoleByUserId(bo.getUserId(), bo.getLoginCode(), adminLoginCode),
				AuthRoleBo.class);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.role.IAuthRoleBiz#queryUserByRoleCode(java.lang.
	 * String)
	 */
	@Override
	public List<UserRoleListEntry> queryUserByRoleCode() {

		return userRoleDaoImpl.queryUserByRoleCode();
	}

}
