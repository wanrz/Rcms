package com.rionsoft.rcms.web.common.date;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rionsoft.rcms.biz.common.date.IDatabaseTimeBiz;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.biz.util.DatePattern;

/**
 * @author liujiaolian
 * @date 2017年12月29日
 */
@Controller
@RequestMapping("/common")
public class DatabaseTimeController extends BaseController {
	@Autowired
	private IDatabaseTimeBiz databaseTimeBiz;

	/**
	 * 得到数据库当前时间
	 *
	 * @author 刘教练
	 * @date 2017年10月23日
	 * @param model
	 * @return view
	 */
	@RequestMapping("/databaseCurrentTime.ajax")
	public String databaseCurrentTime(final Map<String, Object> model) {
		model.put("currentTime", DatePattern.YYYY_MM_DD.format(databaseTimeBiz.databaseCurrentTime()));
		return getView(ViewEnumType.JSON_VIEW);
	}
}
