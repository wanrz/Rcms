/**
 *
 */
package com.rionsoft.rcms.biz.role;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import com.rionsoft.rcms.bo.constant.AuthMenuEnum;
import com.rionsoft.rcms.bo.constant.SessionConstant;
import com.rionsoft.rcms.bo.role.AuthMenuBo;
import com.rionsoft.rcms.dao.role.IAuthMenuDao;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.mybatisplugin.dao.util.PropertyPlaceholderUtils;

/**
 * @author likeke
 * @date 2017年4月24日
 */
@Service
public class AuthMenuBizImpl extends BaseBiz implements IAuthMenuBiz {
	@Autowired
	private IAuthMenuDao authMenuDao;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.role.IAuthMenuBiz#getUserTreeMenu(long,
	 * javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public List<AuthMenuBo> getUserTreeMenu(final long userId, final String loginCode, final HttpServletRequest req) {
		@SuppressWarnings("unchecked")
		List<AuthMenuBo> menuList = (List<AuthMenuBo>) WebUtils.getSessionAttribute(req, SessionConstant.MENU.name());
		if (CollectionUtils.isNotEmpty(menuList)) {
			return menuList;
		}
		menuList = getUserTreeMenu(userId, loginCode);
		return menuList;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.role.IAuthMenuBiz#queryAuthMenuByUserId(long)
	 */
	@Override
	public List<AuthMenuBo> queryAuthMenuByUserId(final long userId, final String loginCode) {
		final String adminLoginCode = PropertyPlaceholderUtils.getContextProperty("adminLoginCode");
		return map(authMenuDao.queryAuthMenuByUserId(userId, loginCode, adminLoginCode), AuthMenuBo.class);
	}

	/**
	 * 获取用户菜单树
	 *
	 * @param userId
	 *            用户id
	 * @return 菜单树
	 */
	private List<AuthMenuBo> getUserTreeMenu(final long userId, final String loginCode) {

		final List<AuthMenuBo> authMenuList = filterSysMenu(userId, loginCode);

		final List<AuthMenuBo> menuList = getTreeMenu(authMenuList);

		/* 集合元素排序,去除非叶子节点中，子节点为空的数据 */
		sortList(menuList);

		return menuList;
	}

	/**
	 * 过滤系统菜单中用户未授权的叶子节点<br>
	 * 暂不考虑实现Predicate，使用内部类
	 *
	 * @param userId
	 * @return
	 */
	private List<AuthMenuBo> filterSysMenu(final long userId, final String loginCode) {
		return queryAuthMenuByUserId(userId, loginCode);
	}

	private List<AuthMenuBo> getTreeMenu(final List<AuthMenuBo> authMenuList) {
		final List<AuthMenuBo> menuList = new ArrayList<>();

		for (final AuthMenuBo authMenuBo : authMenuList) {
			if (!StringUtils.equals(authMenuBo.getParentMenuCode(), AuthMenuEnum.P_CODE.getCode())) {
				continue;
			}
			menuList.add(authMenuBo);
		}

		for (final AuthMenuBo menuBo : menuList) {
			assembleMenuBo(menuBo, authMenuList);
		}
		return menuList;
	}

	/**
	 * 深度复制
	 *
	 * @param srcList
	 * @return
	 * @throws IOException
	 * @throws ClassNotFoundException
	 */
	@SuppressWarnings({ "unchecked", "unused" })
	private List<AuthMenuBo> deepCopy(final List<AuthMenuBo> srcList) {
		List<AuthMenuBo> destList = null;

		try {
			final ByteArrayOutputStream byteOut = new ByteArrayOutputStream();
			final ObjectOutputStream out = new ObjectOutputStream(byteOut);
			out.writeObject(srcList);

			final ByteArrayInputStream byteIn = new ByteArrayInputStream(byteOut.toByteArray());
			final ObjectInputStream in = new ObjectInputStream(byteIn);
			destList = (List<AuthMenuBo>) in.readObject();
		} catch (final IOException e) {
			// logger.error("复制系统菜单信息异常", e);
			e.printStackTrace();
		} catch (final ClassNotFoundException e) {
			// logger.error("复制系统菜单信息异常", e);
			e.printStackTrace();
		}
		return destList;
	}

	/** 集合元素排序,去除非叶子节点中，子节点为空的数据 */
	private void sortList(final List<AuthMenuBo> authMenuList) {
		if (CollectionUtils.isEmpty(authMenuList)) {
			return;
		}
		Collections.sort(authMenuList);
		final Iterator<AuthMenuBo> it = authMenuList.iterator();
		while (it.hasNext()) {
			final AuthMenuBo bo = it.next();
			if (StringUtils.equals(bo.getIsLeaf(), AuthMenuEnum.NOT.getCode())
					&& CollectionUtils.isEmpty(bo.getChildMenuList())) {
				it.remove();
				continue;
			}
			sortList(bo.getChildMenuList());
		}
	}

	/**
	 * 获取参数menuBo在authMenuList中的后代节点。
	 *
	 * @param menuBo
	 * @param authMenuList
	 * @return
	 */
	private AuthMenuBo assembleMenuBo(final AuthMenuBo menuBo, final List<AuthMenuBo> authMenuList) {
		for (final AuthMenuBo authMenuBo : authMenuList) {
			if (StringUtils.equals(menuBo.getMenuCode(), authMenuBo.getParentMenuCode())) {
				if (menuBo.getChildMenuList() == null) {
					menuBo.setChildMenuList(new ArrayList<AuthMenuBo>());
				}
				menuBo.getChildMenuList().add(assembleMenuBo(authMenuBo, authMenuList));
			}
		}
		return menuBo;
	}

}
