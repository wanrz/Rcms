/**
 *
 */
package com.rionsoft.rcms.web.common.filter.auth;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import com.rionsoft.rcms.biz.role.IAuthAttributeBiz;
import com.rionsoft.rcms.condition.listentry.role.AuthAttributeListEntry;
import com.rionsoft.rcms.condition.role.AuthAttributeActionQueryCondition;
import com.rionsoft.rcms.entry.role.AuthAttrActionEntry;
import com.rionsoft.support.biz.common.json.IJsonBiz;
import com.rionsoft.support.biz.util.ArrayUtilsEx;

/**
 * @author likeke
 * @date 2017年4月27日
 */
public class AdminDefaultActionUrlFilter implements Filter {
	/**  */
	private final Log logger = LogFactory.getLog(AdminDefaultActionUrlFilter.class);

	/** 不验证的资源 */
	private String[] ignoreUrls;
	/** 验证资源匹配符，以此开头 */
	private String matcherUrl;
	/** 不验证的资源通配符，以此开头 */
	private String[] unMatcherUrls;

	@Autowired
	private IAuthAttributeBiz authAttributeBiz;
	@Autowired
	private IJsonBiz jsonBiz;

	/*
	 * (non-Javadoc)
	 *
	 * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
	 */
	@Override
	public void init(final FilterConfig filterConfig) throws ServletException {
		SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, filterConfig.getServletContext());
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest,
	 * javax.servlet.ServletResponse, javax.servlet.FilterChain)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void doFilter(final ServletRequest request, final ServletResponse response, final FilterChain chain)
			throws IOException, ServletException {
		final HttpServletRequest httpRequest = (HttpServletRequest) request;
		final HttpServletResponse httpResponse = (HttpServletResponse) response;
		final String url = httpRequest.getRequestURI();

		final String matherPath = StringUtils.substringAfter(url, httpRequest.getContextPath());

		/* 1、不验证配置的资源 */
		if (ArrayUtils.isNotEmpty(ignoreUrls) && ArrayUtils.contains(ignoreUrls, matherPath)) {
			chain.doFilter(request, response);
			return;
		}
		if (StringUtils.isEmpty(matcherUrl) || !StringUtils.startsWith(matherPath, matcherUrl)) {
			chain.doFilter(request, response);
			return;
		}
		if (ArrayUtils.isNotEmpty(unMatcherUrls) && ArrayUtilsEx.startsWith(matherPath, unMatcherUrls)) {
			chain.doFilter(request, response);
			return;
		}

		/* 2、请求的url不需要验证 */
		final AuthAttributeActionQueryCondition condition = new AuthAttributeActionQueryCondition();
		condition.setActionUrl(matherPath);
		final List<AuthAttrActionEntry> list = authAttributeBiz.queryAllAttributeAction(condition);

		if (CollectionUtils.size(list) > 1) {
			logger.warn(condition.getActionUrl() + "在AUTH_ATTR_ACTION中配置多份！！！");
		}
		if (CollectionUtils.isEmpty(list)) {
			logger.warn(condition.getActionUrl() + "未在AUTH_ATTR_ACTION中配置！！！");
		}

		if (CollectionUtils.isEmpty(list) || list.get(0).getVerifyResource().equals("0")) {
			chain.doFilter(request, response);
			return;
		} else if (!((List<String>) ((HttpServletRequest) request).getSession().getAttribute("actionList"))
				.contains(matherPath)) {
			/* 4、验证操作 */
			final AuthAttributeListEntry authAttributeBo = authAttributeBiz.queryMenuAndAttr(matherPath).get(0);
			writeMsg(httpRequest, httpResponse,
					"无权限操作此资源【" + authAttributeBo.getMenuName() + "--" + authAttributeBo.getTitle() + "】");
			return;
		}
		chain.doFilter(request, response);
	}

	private void writeMsg(final HttpServletRequest httpRequest, final HttpServletResponse httpResponse,
			final String msg) throws IOException {
		final PrintWriter writer = httpResponse.getWriter();
		final StringBuilder str = new StringBuilder();

		if (jsonBiz.isJsonRequest(httpRequest)) {
			httpResponse.setContentType("application/json");
			httpResponse.setHeader("Pragma", "No-cache");
			httpResponse.setHeader("Cache-Control", "no-cache");
			httpResponse.setCharacterEncoding("UTF-8");
			str.append(msg);
		} else {
			str.append("<script language='javascript'>alert('" + msg + "');</script>");
			httpResponse.setContentType("text/html;charset=UTF-8");
		}
		writer.write(str.toString());
		writer.flush();
		writer.close();
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
	 * @param ignoreUrls
	 *            the ignoreUrls to set
	 */
	public void setIgnoreUrls(final String[] ignoreUrls) {
		this.ignoreUrls = ignoreUrls;
	}

	/**
	 * @param matcherUrl
	 *            the matcherUrl to set
	 */
	public void setMatcherUrl(final String matcherUrl) {
		this.matcherUrl = matcherUrl;
	}

	/**
	 * @param unMatcherUrls
	 *            the unMatcherUrls to set
	 */
	public void setUnMatcherUrls(final String[] unMatcherUrls) {
		this.unMatcherUrls = unMatcherUrls;
	}
}
