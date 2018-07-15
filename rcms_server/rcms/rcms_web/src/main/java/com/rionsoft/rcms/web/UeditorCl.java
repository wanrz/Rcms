/**
 *
 * 2016年3月23日
 */
package com.rionsoft.rcms.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.baidu.ueditor.ActionEnter;

/**
 * @author Leayn <handohand@vip.qq.com> 2016年3月23日
 */
public class UeditorCl extends HttpServlet {

	/**  */
	private static final long serialVersionUID = 1033094182192531216L;

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.
	 * HttpServletRequest , javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected void doGet(final HttpServletRequest req, final HttpServletResponse resp)
			throws ServletException, IOException {
		// super.doGet(req, resp);
		resp.getWriter().write(new ActionEnter(req, req.getSession().getServletContext().getRealPath("/")).exec());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.
	 * HttpServletRequest , javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected void doPost(final HttpServletRequest req, final HttpServletResponse resp)
			throws ServletException, IOException {
		// super.doPost(req, resp);
		resp.getWriter().write(new ActionEnter(req, req.getSession().getServletContext().getRealPath("/")).exec());
	}

	// /**
	// * 2016年2月24日 ue editor 入口
	// *
	// * @param model
	// * @param file
	// * @param type
	// * @param request
	// */
	// @ResponseBody
	// @RequestMapping(value = "/editor")
	// public String editorEnter(final ModelMap model, final HttpServletRequest
	// request, final HttpServletResponse response) {
	// return new ActionEnter(request, new
	// Arequest(request).getSession().getServletContext().getRealPath("/")).exec();
	// }
	//
	// /**
	// * 2016年2月24日 培训课程：获取新增界面
	// *
	// * @param model
	// * @param file
	// * @param type
	// * @param request
	// */
	// @RequestMapping(value = "/ue/demo")
	// public String demo(final ModelMap model, final HttpServletRequest
	// request) {
	// return "demo/ue_demo";
	// }
}
