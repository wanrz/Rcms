/**
 *
 */
package com.rionsoft.rcms.biz.session;

import javax.servlet.http.HttpServletRequest;

import com.rionsoft.rcms.bo.user.UserInfoBo;
import com.rionsoft.rcms.entry.user.UserInfoEntry;
import com.rionsoft.support.basebo.session.UserLoginBo;

/**
 * @author likeke
 * @date 2017年4月24日
 */
public interface IUserLoginBiz {

	/**
	 * 用户登录
	 *
	 * @author likeke
	 * @param request
	 *            req请求
	 * @date 2016年11月11日
	 * @param userInfoBo
	 *            用户信息实体
	 * @return UserLoginBo
	 */
	UserLoginBo userLogin(HttpServletRequest request, UserInfoBo userInfoBo);

	/**
	 * 用户登出
	 *
	 * @author likeke
	 * @date 2017年4月27日
	 * @param request
	 */
	void logout(HttpServletRequest request);

	/**
	 * 验证登录信息
	 *
	 * @param loginCode
	 * @param password
	 * @return 数据库用户信息
	 */
	UserInfoEntry validateLoginInfo(String loginCode, String password);

}
