/**
 *
 */
package com.rionsoft.rcms.web.front;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.WebUtils;

import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.basebo.session.UserLoginBo;
import com.rionsoft.support.biz.common.constants.SessionConstant;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

/**
 *
 * @author <a href="mailto:dailycode@163.com"> liyw <a><br>
 *         2017年1月9日
 *
 */
@Controller
@RequestMapping("/front")
public class FrontLoginController extends BaseController {

	/**
	 * 登录
	 *
	 * @param request
	 * @return jsonView
	 */
	@RequestMapping("/login.do")
	public String login(final HttpServletRequest request) {
		return getView("front/login");
	}

	/**
	 * web端登录
	 *
	 * @param userInfoBo
	 * @param request
	 * @param model
	 * @return jsonView
	 */
	@RequestMapping(value = "/login.ajax")
	public String login(final HttpServletRequest request, final Model model) {
		// :TODO移至业务层
		WebUtils.setSessionAttribute(request, SessionConstant.ADMIN_LOGIN.name(), new UserLoginBo());
		SessionLocal.setSessionLocal(SessionLocalEnum.LOGIN_USER_ID, 123L);

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
		// :TODO移至业务层
		WebUtils.setSessionAttribute(request, SessionConstant.ADMIN_LOGIN.name(), null);

		return getRedirectView("addmin/login.do?s_from=logout");
	}

	/**
	 *
	 * @param request
	 * @param model
	 * @return index.jsp
	 */
	@RequestMapping(value = "/index.do", method = RequestMethod.GET)
	public String index(final HttpServletRequest request, final Map<String, Object> model) {
		return getView("front/index");
	}
}
