/**
 *
 */
package com.rionsoft.rcms.web.common.error;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.rionsoft.support.basebo.common.rsp.RspDataBo;
import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.biz.common.json.IJsonBiz;
import com.rionsoft.support.biz.common.rsp.IRspHandlerBiz;

/**
 * @author shuzijian
 * @date 2016年11月15日
 */
public class RionsoftMappingExceptionResolver implements HandlerExceptionResolver {

	@Autowired
	private IJsonBiz jsonBiz;

	@Autowired
	private IRspHandlerBiz rspHandlerBiz;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * org.springframework.web.servlet.HandlerExceptionResolver#resolveException
	 * (javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse, java.lang.Object,
	 * java.lang.Exception)
	 */
	@Override
	public ModelAndView resolveException(final HttpServletRequest request, final HttpServletResponse response,
			final Object handler, final Exception exception) {
		final boolean isAjax = jsonBiz.isJsonRequest(request);
		if (isAjax) {
			final RspDataBo rspDataBo = rspHandlerBiz.assembleRspError(ViewEnumType.JSON_VIEW, exception);
			rspHandlerBiz.rspWriterByJson(response, rspDataBo);
		} else {
			return new ModelAndView("/error/generic_error", rspHandlerBiz.assembleErrorBody(exception));
		}
		return null;
	}

}
