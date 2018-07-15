package com.rionsoft.rcms.web;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import com.rionsoft.support.basebo.common.view.ViewEnumType;

/**
 * 控制器基类
 *
 * @author shuzijian
 * @date 2016年11月9日
 */
public class BaseController {

	/**
	 * 获取重定向view
	 *
	 * @author shuzijian
	 * @date 2016年11月9日
	 * @param view
	 *            重定向视图
	 * @return 重定向view
	 */
	protected String getRedirectView(final String view) {
		return new StringBuilder().append("redirect:").append(view).toString();
	}

	/**
	 * 获取普通view
	 *
	 * @author shuzijian
	 * @date 2016年11月9日
	 * @param view
	 *            视图
	 * @return view
	 */
	protected String getView(final String view) {
		return view;
	}

	/**
	 * 获取beanName对应的view
	 *
	 * @author shuzijian
	 * @date 2016年11月9日
	 * @param viewEnumType
	 *            view枚举
	 * @return 枚举指向的实际beanName
	 */
	protected String getView(final ViewEnumType viewEnumType) {
		return viewEnumType.getView();
	}

	/**
	 * 解决前台向后台传递list大于255时报错
	 *
	 * @author likeke
	 * @date 2017年3月22日
	 * @param binder
	 *
	 */
	@InitBinder
	public void initBinder(final WebDataBinder binder) {
		binder.setAutoGrowCollectionLimit(Integer.MAX_VALUE);

	}

}
