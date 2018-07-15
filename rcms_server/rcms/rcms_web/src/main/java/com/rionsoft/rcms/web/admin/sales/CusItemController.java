/**
 *
 */
package com.rionsoft.rcms.web.admin.sales;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rionsoft.rcms.biz.department.IAuthDirBiz;
import com.rionsoft.rcms.biz.user.IUserInfoBiz;
import com.rionsoft.rcms.condition.user.UserCondition;
import com.rionsoft.rcms.web.BaseController;


/**
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/cus")
public class CusItemController extends BaseController {
	@Autowired
	private IUserInfoBiz userInfoBizImpl;
	@Autowired
	private IAuthDirBiz authDirBiz;

	/**
	 * 跳转到人员管理首页
	 *
	 * @author wanrz
	 * @param model
	 * @param userCondition
	 * @date 2017年4月17日
	 * @return view
	 */
	@RequestMapping("/cusItem.do")
	public String toUser(final Map<String, Object> model, final UserCondition userCondition) {
		// model.put("authDirBo", authDirBiz.queryAuthDirEntryByUserId());
		// // 用来判断是不是只存在本部门
		// final Long userId =
		// SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		// final List<AuthDataTypeEntry> authDataTypeList =
		// userInfoBizImpl.queryAuthRoleByUserId(userCondition);
		// final List<String> dataCodes = new ArrayList<String>();
		// for (final AuthDataTypeEntry authDataTypeEntry : authDataTypeList) {
		// dataCodes.add(authDataTypeEntry.getDataCode());
		// }
		// if (!dataCodes.contains("01") && !dataCodes.contains("03") &&
		// !dataCodes.contains("04") && userId != 1) {
		// model.put("dataId2", dataCodes.get(0));
		// }
		return getView("admin/sales/cusItem");
	}

}
