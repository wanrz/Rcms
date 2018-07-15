/**
 *
 */
package com.rionsoft.rcms.web.admin.workLoadAccount;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rionsoft.rcms.biz.department.IAuthDirBiz;
import com.rionsoft.rcms.biz.user.IUserInfoBiz;
import com.rionsoft.rcms.biz.workLoadAccount.IWorkLoadAccountBiz;
import com.rionsoft.rcms.condition.user.UserCondition;
import com.rionsoft.rcms.condition.workLoadAccount.WorkLoadCondition;
import com.rionsoft.rcms.condition.workLoadAccount.WorkLoadListEntry;
import com.rionsoft.rcms.entry.role.AuthDataTypeEntry;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

/**
 * @author linzhiqiang
 * @date 2017年5月2日
 */
@Controller
@RequestMapping("/admin/workLoad")
public class WorkLoadAccountController extends BaseController {
	@Autowired
	private IWorkLoadAccountBiz workLoadAccountBiz;
	@Autowired
	private IAuthDirBiz authDirBiz;
	@Autowired
	private IUserInfoBiz userInfoBizImpl;

	/**
	 * 跳转到工作量统计主页
	 *
	 * @author linzhiqiang
	 * @date 2017年5月2日
	 * @param model
	 * @param userCondition
	 * @return view
	 */
	@RequestMapping("workLoadAccount.do")
	public String workLoadAccount(final Map<String, Object> model,final UserCondition userCondition) {
		model.put("authDirBo", authDirBiz.queryAuthDirEntryByUserId());
		// 用来判断是不是只存在本部门
				final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
				List<AuthDataTypeEntry> authDataTypeList = userInfoBizImpl.queryAuthRoleByUserId(userCondition);
				List<String> dataCodes = new ArrayList<String>();
				for (AuthDataTypeEntry authDataTypeEntry : authDataTypeList) {
					dataCodes.add(authDataTypeEntry.getDataCode());
				}
				if (!dataCodes.contains("01") && !dataCodes.contains("03") && !dataCodes.contains("04") && userId != 1) {
					model.put("dataId2", dataCodes.get(0));
				}
		return getView("admin/workLoadAccount/workLoadAccount");
	}

	/**
	 * 查询日志中的考核量
	 *
	 * @author linzhiqiang
	 * @date 2017年5月2日
	 * @param condition
	 * @param model
	 * @param req
	 *
	 *
	 * @return view
	 */
	@RequestMapping("workLoadQuery.ajax")
	public String workLoadAccountQuery(final WorkLoadCondition condition, final Map<String, Object> model,
			final HttpServletRequest req) {
		final List<WorkLoadListEntry> listEntry = workLoadAccountBiz.workLoadQuery(condition, req);
		model.put("workLoadList", listEntry);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 跳转到 查询每个项目具体工作统计
	 * 
	 * @author sungantao
	 * @date 2017年9月3日
	 * @return view
	 */
	@RequestMapping("projWorkLoad.do")
	public String projWorkLoad() {
		return getView("admin/workLoadAccount/projectWorkLoadAccount");
	}

	/**
	 * 导出工作量统计信息
	 * 
	 * @author sungantao
	 * @date 2017年9月19日
	 * @param model
	 * @param req
	 * @return 表格
	 */
	@RequestMapping("exportWorkAccount.download")
	public String exportWorkAccount(final Map<String, Object> model, final HttpServletRequest req) {
		model.put("exportFilebo", workLoadAccountBiz.exportWorkAccount(req));
		return getView(ViewEnumType.EXPORT_VIEW);
	}

}
