package com.rionsoft.rcms.web.common.view;

import org.springframework.web.servlet.view.AbstractView;

import com.rionsoft.support.basebo.common.view.ViewEnumType;

/**
 * web view 视图抽象基类
 *
 * @author shuzijian 2016年11月6日
 */
public abstract class BaseView extends AbstractView implements IView {

	/**
	 * 构建view
	 */
	public BaseView() {
		setContentType(getViewType().getContentType());
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.roep.web.view.IView#getViewType()
	 */
	@Override
	public abstract ViewEnumType getViewType();

}
