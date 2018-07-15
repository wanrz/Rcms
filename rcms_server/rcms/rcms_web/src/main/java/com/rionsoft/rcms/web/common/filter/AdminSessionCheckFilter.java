/**
 *
 */
package com.rionsoft.rcms.web.common.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.rionsoft.support.basebo.session.UserLoginBo;
import com.rionsoft.support.biz.common.constants.SessionConstant;
import com.rionsoft.support.biz.common.json.IJsonBiz;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;
import com.rionsoft.support.mybatisplugin.dao.util.SpringBeanUtils;

/**
 * session过滤器
 *
 * @author shuzijian
 * @date 2016年11月16日
 */
public class AdminSessionCheckFilter implements Filter {

	/**
	 *
	 */
	Log logger = LogFactory.getLog(AdminSessionCheckFilter.class);

	/** 拦截以此开头的url */
	private String matcherUrlPrefix;
	/** 忽略的url列表 */
	private String[] ignoreUrls;

	/*
	 * (non-Javadoc)
	 *
	 * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
	 */
	@Override
	public void init(final FilterConfig filterConfig) throws ServletException {
		//
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest,
	 * javax.servlet.ServletResponse, javax.servlet.FilterChain)
	 */
	@Override
	public void doFilter(final ServletRequest request, final ServletResponse response, final FilterChain chain)
			throws IOException, ServletException {
		final HttpServletRequest httpRequest = (HttpServletRequest) request;
		final HttpServletResponse httpResponse = (HttpServletResponse) response;
		final HttpSession session = httpRequest.getSession();

		final String s_from = request.getParameter("s_from");

		final String url = httpRequest.getRequestURI();
		final String matherPath = StringUtils.substringAfter(url, httpRequest.getContextPath());
		final boolean isAjax = SpringBeanUtils.getBean(IJsonBiz.class).isJsonRequest(httpRequest);

		if (ArrayUtils.isNotEmpty(ignoreUrls) && ArrayUtils.contains(ignoreUrls, matherPath)) {
			chain.doFilter(request, response);
			return;
		}
		if (StringUtils.isEmpty(matcherUrlPrefix) || !StringUtils.startsWith(matherPath, matcherUrlPrefix)) {
			chain.doFilter(request, response);
			return;
		}

		final Object cacheLoginInfo = session.getAttribute(SessionConstant.ADMIN_LOGIN.name());
		if (cacheLoginInfo != null) {
			final UserLoginBo userLoginBo = (UserLoginBo) cacheLoginInfo;
			SessionLocal.setSessionLocal(SessionLocalEnum.LOGIN_USER_ID, userLoginBo.getUserId());
			SessionLocal.setSessionLocal(SessionLocalEnum.USER_LOGIN_INFO, userLoginBo);
			chain.doFilter(request, response);
			return;
		}
		logger.debug("session status:" + session.isNew());
		if (!StringUtils.equalsIgnoreCase("logout", s_from)) {
			final String loginUrl = httpRequest.getContextPath() + "/index.jsp";
			if (isAjax) {
				httpResponse.addHeader("sessionstatus", "timeOut");
				httpResponse.addHeader("loginPath", loginUrl);
				chain.doFilter(request, response);
			} else {
				final StringBuilder str = new StringBuilder()
						.append("<script language='javascript'>alert('尚未登录或会话过期,请重新登录');")
						.append("window.top.location.href='").append(loginUrl).append("';</script>");
				response.setContentType("text/html;charset=UTF-8");
				final PrintWriter writer = response.getWriter();
				writer.write(str.toString());
				writer.flush();
				writer.close();
			}
		} else {
			// 点击退出登录
			httpResponse.sendRedirect(httpRequest.getContextPath() + "/admin/login.do");
		}
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see javax.servlet.Filter#destroy()
	 */
	@Override
	public void destroy() {
		//
	}

	/**
	 * @param matcherUrlPrefix
	 *            the matcherUrlPrefix to set
	 */
	public void setMatcherUrlPrefix(final String matcherUrlPrefix) {
		this.matcherUrlPrefix = matcherUrlPrefix;
	}

	/**
	 * @param ignoreUrls
	 *            the ignoreUrls to set
	 */
	public void setIgnoreUrls(final String[] ignoreUrls) {
		this.ignoreUrls = ignoreUrls;
	}
}
