/**
 *
 */
package com.rionsoft.rcms.biz.role;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.rionsoft.rcms.bo.role.AuthMenuBo;

/**
 * @author likeke
 * @date 2017年4月24日
 */
public interface IAuthMenuBiz {

	/**
	 * 获取用户树形菜单结构
	 *
	 * @param userId
	 *            用户id
	 * @param loginCode
	 * @param req
	 * @return 树形菜单
	 */
	List<AuthMenuBo> getUserTreeMenu(long userId, String loginCode, HttpServletRequest req);

	/**
	 * 根据用户id查询用户授权所有菜单信息
	 *
	 * @param userId
	 * @param loginCode
	 * @return 资源信息
	 */
	List<AuthMenuBo> queryAuthMenuByUserId(long userId, String loginCode);
}
