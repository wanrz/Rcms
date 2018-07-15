/**
 *
 */
package com.rionsoft.rcms.web.admin;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rionsoft.rcms.biz.session.IUserLoginBiz;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;

/**
 * @author likeke
 * @date 2017年4月27日
 */
@Controller
@RequestMapping("/admin")
public class WebLoginController extends BaseController {
	@Autowired
	private IUserLoginBiz userLoginBiz;

	/**
	 * 登录
	 *
	 * @param request
	 * @return jsonView
	 */
	@RequestMapping("/login.do")
	public String login(final HttpServletRequest request) {
		return getView("admin/login");
	}

	/**
	 * web端登录
	 *
	 * @param request
	 * @param model
	 * @param userInfoBo
	 * @return jsonView
	 */
	@RequestMapping(value = "/login.ajax")
	public String login(final HttpServletRequest request, final Model model,
			final com.rionsoft.rcms.bo.user.UserInfoBo userInfoBo) {
		userLoginBiz.userLogin(request, userInfoBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 登出
	 *
	 * @author shuzijian
	 * @param request
	 *            请求
	 * @date 2016年11月10日
	 * @return view
	 */
	@RequestMapping("/logout.do")
	public String logout(final HttpServletRequest request) {
		userLoginBiz.logout(request);
		return getRedirectView("admin/login.do?s_from=logout");
	}

	/**
	 *
	 * @param request
	 * @param model
	 * @return index.jsp
	 */
	@RequestMapping(value = "/index.do", method = RequestMethod.GET)
	public String index(final HttpServletRequest request, final Map<String, Object> model) {
		return getView("index");
	}
}
