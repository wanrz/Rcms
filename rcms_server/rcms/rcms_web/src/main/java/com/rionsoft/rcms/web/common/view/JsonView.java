/**
 *
 */
package com.rionsoft.rcms.web.common.view;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rionsoft.support.basebo.common.rsp.RspDataBo;
import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.biz.common.rsp.IRspHandlerBiz;

/**
 * @author shuzijian
 * @date 2016年11月6日
 */
@Service
public class JsonView extends BaseView {

	@Autowired
	private IRspHandlerBiz rspHandlerBiz;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.roep.web.view.IView#getViewType()
	 */
	@Override
	public ViewEnumType getViewType() {
		return ViewEnumType.JSON_VIEW;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * org.springframework.web.servlet.view.AbstractView#renderMergedOutputModel
	 * (java.util.Map, javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected void renderMergedOutputModel(final Map<String, Object> model, final HttpServletRequest request,
			final HttpServletResponse response) throws Exception {
		final Map<String, ?> value = rspHandlerBiz.filterModel(model);
		final RspDataBo rspDataBo = rspHandlerBiz.assembleRspData(getViewType(), value);
		rspHandlerBiz.rspWriterByJson(response, rspDataBo);
	}

}
