/**
 *
 */
package com.rionsoft.rcms.biz.role;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rionsoft.rcms.condition.listentry.role.AuthAttributeListEntry;
import com.rionsoft.rcms.condition.listentry.role.AuthMenuListEntry;
import com.rionsoft.rcms.condition.role.AuthAttributeActionQueryCondition;
import com.rionsoft.rcms.dao.role.IAuthAttrActionDao;
import com.rionsoft.rcms.dao.role.IAuthAttributeDao;
import com.rionsoft.rcms.entry.role.AuthAttrActionEntry;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.mybatisplugin.dao.util.PropertyPlaceholderUtils;

/**
 * @author likeke
 * @date 2017年4月24日
 */
@Service
public class AuthAttributeBizImpl extends BaseBiz implements IAuthAttributeBiz {

	@Autowired
	private IAuthAttributeDao authAttributeDao;
	@Autowired
	private IAuthAttrActionDao authAttrActionDao;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.roep.biz.auth.IAuthAttributeBiz#queryMenuAttribute()
	 */
	@Override
	public List<AuthMenuListEntry> queryMenuAttribute() {
		return authAttributeDao.queryMenuAttribute();
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.roep.biz.auth.IAuthAttributeBiz#queryMenuAndAttr(java.lang.
	 * String)
	 */
	@Override
	public List<AuthAttributeListEntry> queryMenuAndAttr(final String actionUrl) {
		return authAttributeDao.queryMenuAndAttr(actionUrl);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.role.IAuthAttributeBiz#queryAllAttributeAction(com.
	 * rionsoft.rcms.condition.role.AuthAttributeActionQueryCondition)
	 */
	@Override
	public List<AuthAttrActionEntry> queryAllAttributeAction(final AuthAttributeActionQueryCondition condition) {
		return authAttrActionDao.queryAllAttributeAction(condition);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.role.IAuthAttributeBiz#queryAllAttActionByUserId(
	 * java.lang.Long)
	 */
	@Override
	public List<String> queryAllAttrActionByUserId(final Long userId, final String loginCode) {
		final String adminLoginCode = PropertyPlaceholderUtils.getContextProperty("adminLoginCode");
		final List<AuthAttrActionEntry> list = authAttrActionDao.queryAllAttrActionByUserId(userId, loginCode,
				adminLoginCode);

		final List<String> actionList = new ArrayList<>();
		for (final AuthAttrActionEntry entry : list) {
			actionList.add(entry.getActionUrl());
		}

		return actionList;
	}
}
