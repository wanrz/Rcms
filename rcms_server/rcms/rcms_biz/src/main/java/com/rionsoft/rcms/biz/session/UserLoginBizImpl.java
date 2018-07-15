/**
 *
 */
package com.rionsoft.rcms.biz.session;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import com.rionsoft.rcms.biz.constant.RCMSExceptionCodeEnum;
import com.rionsoft.rcms.biz.role.IAuthAttributeBiz;
import com.rionsoft.rcms.biz.role.IAuthMenuBiz;
import com.rionsoft.rcms.bo.constant.UserEnum;
import com.rionsoft.rcms.bo.user.UserInfoBo;
import com.rionsoft.rcms.dao.user.IUserInfoDao;
import com.rionsoft.rcms.entry.user.UserInfoEntry;
import com.rionsoft.support.basebo.session.UserLoginBo;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.biz.common.constants.RionsoftExceptionCodeEnum;
import com.rionsoft.support.biz.common.constants.SessionConstant;
import com.rionsoft.support.biz.common.error.RionsoftException;
import com.rionsoft.support.mybatisplugin.dao.common.core.ICommonDao;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

/**
 * @author shuzijian
 * @date 2016年11月11日
 */
@Service
public class UserLoginBizImpl extends BaseBiz implements IUserLoginBiz {

	@Autowired
	private IUserInfoDao userInfoDao;

	@Autowired
	private ICommonDao commonDao;
	@Autowired
	private IAuthMenuBiz authMenuBiz;
	@Autowired
	private IAuthAttributeBiz authAttributeBiz;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.session.IUserLoginBiz#userLogin(javax.servlet.http.
	 * HttpServletRequest, com.rionsoft.rcms.bo.user.UserInfoBo)
	 */
	@Override
	public UserLoginBo userLogin(final HttpServletRequest request, final UserInfoBo userInfoBo) {
		final HttpSession session = request.getSession(true);
		final UserInfoEntry userInfoEntry = validateLoginInfo(userInfoBo.getLoginCode(), userInfoBo.getPassword());
		final UserLoginBo userLoginBo = assembleUserLoginBo(request, userInfoEntry);
		session.setAttribute(SessionConstant.ADMIN_LOGIN.name(), userLoginBo);

		final List<String> actionList = authAttributeBiz.queryAllAttrActionByUserId(userLoginBo.getUserId(),
				userLoginBo.getLoginCode());
		if (CollectionUtils.isEmpty(actionList)) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0020, false);
		}
		session.setAttribute("actionList", actionList);
		session.setAttribute("loginUserPhoto", userInfoEntry.getPhoto());
		session.setAttribute("menuList",
				authMenuBiz.getUserTreeMenu(userLoginBo.getUserId(), userLoginBo.getLoginCode(), request));

		SessionLocal.setSessionLocal(SessionLocalEnum.LOGIN_USER_ID, userLoginBo.getUserId());
		/* 登录日志后期增加 */
		return userLoginBo;
	}

	/**
	 * @author likeke
	 * @date 2017年4月25日
	 * @param request
	 * @param userInfoEntry
	 * @return
	 */
	private UserLoginBo assembleUserLoginBo(final HttpServletRequest request, final UserInfoEntry userInfoEntry) {
		final UserLoginBo userLoginBo = map(userInfoEntry, UserLoginBo.class);
		userLoginBo.setLoginIp(request.getRemoteAddr());
		userLoginBo.setOrgId(userInfoEntry.getDirId());
		userLoginBo.setLoginTime(commonDao.queryCurrentTime());
		return userLoginBo;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.session.IUserLoginBiz#logout(javax.servlet.http.
	 * HttpServletRequest)
	 */
	@Override
	public void logout(final HttpServletRequest request) {
		WebUtils.setSessionAttribute(request, SessionConstant.ADMIN_LOGIN.name(), null);
		WebUtils.setSessionAttribute(request, SessionLocalEnum.LOGIN_USER_ID.name(), null);
		WebUtils.setSessionAttribute(request, "menuList", null);
		WebUtils.setSessionAttribute(request, "actionList", null);
		WebUtils.setSessionAttribute(request, "loginUserPhoto", null);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.session.IUserLoginBiz#validateLoginInfo(java.lang.
	 * String, java.lang.String)
	 */
	@Override
	public UserInfoEntry validateLoginInfo(final String loginCode, final String password) {
		final UserInfoEntry userInfoEntry = userInfoDao.queryUserByLoginCode(loginCode);
		if (userInfoEntry == null) {
			throw new RionsoftException(RionsoftExceptionCodeEnum.A_B_C_BZ0001, false);
		}
		if (StringUtils.equals(UserEnum.UserStatusEnum.INVALID.getCode(), userInfoEntry.getUserStatus())) {
			throw new RionsoftException(RionsoftExceptionCodeEnum.A_B_C_BZ0013, false);
		}
		if (!StringUtils.equals(password, userInfoEntry.getPassword())) {
			throw new RionsoftException(RionsoftExceptionCodeEnum.A_B_C_BZ0014, false);
		}
		return userInfoEntry;
	}

}
