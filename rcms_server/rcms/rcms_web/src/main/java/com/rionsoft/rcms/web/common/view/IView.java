/**
 *
 */
package com.rionsoft.rcms.web.common.view;

import com.rionsoft.support.basebo.common.view.ViewEnumType;

/**
 * web view基础接口
 *
 * @author shuzijian
 * @date 2016年11月8日
 */
public interface IView {

	/**
	 * 获取视图类型
	 *
	 * @author shuzijian
	 * @date 2016年11月9日
	 * @return 视图枚举
	 */
	ViewEnumType getViewType();

}
