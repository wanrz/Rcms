/**
 *
 */
package com.rionsoft.rcms.web.admin.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.rionsoft.rcms.biz.code.SequenceTypeEnum;
import com.rionsoft.rcms.biz.department.IAuthDirBiz;
import com.rionsoft.rcms.biz.role.IAuthRoleBiz;
import com.rionsoft.rcms.biz.user.IUserInfoBiz;
import com.rionsoft.rcms.bo.role.UserRoleBo;
import com.rionsoft.rcms.bo.user.UserInfoBo;
import com.rionsoft.rcms.condition.listentry.user.UserInfoListEntry;
import com.rionsoft.rcms.condition.user.UserCondition;
import com.rionsoft.rcms.entry.role.AuthDataTypeEntry;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.file.FileUploadBo;
import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.biz.sequence.IManageSequenceBiz;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

/**
 * @author likeke
 * @date 2017年4月17日
 */

@Controller
@RequestMapping("/admin/user")
public class UserInfoController extends BaseController {
	@Autowired
	private IUserInfoBiz userInfoBizImpl;
	@Autowired
	private IAuthRoleBiz roleBizImpl;
	@Autowired
	private IManageSequenceBiz manageSequenceBiz;
	@Autowired
	private IAuthDirBiz authDirBiz;

	/**
	 * 跳转到人员管理首页
	 *
	 * @author likeke
	 * @param model
	 * @param userCondition
	 * @date 2017年4月17日
	 * @return view
	 */
	@RequestMapping("/userManage.do")
	public String toUser(final Map<String, Object> model, final UserCondition userCondition) {
		model.put("authDirBo", authDirBiz.queryAuthDirEntryByUserId());
		// 用来判断是不是只存在本部门
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		final List<AuthDataTypeEntry> authDataTypeList = userInfoBizImpl.queryAuthRoleByUserId(userCondition);
		final List<String> dataCodes = new ArrayList<String>();
		for (final AuthDataTypeEntry authDataTypeEntry : authDataTypeList) {
			dataCodes.add(authDataTypeEntry.getDataCode());
		}
		if (!dataCodes.contains("01") && !dataCodes.contains("03") && !dataCodes.contains("04") && userId != 1) {
			model.put("dataId2", dataCodes.get(0));
		}
		return getView("admin/user/userManage");
	}

	/**
	 * 查询员工列表
	 *
	 * @author likeke
	 * @data 2017年4月17日
	 * @param model
	 * @param userCondition
	 * @param req
	 * @return view
	 */

	@RequestMapping("/userList.ajax")
	public String userList(final Map<String, Object> model, final UserCondition userCondition,
			final HttpServletRequest req) {
		model.put("userList", userInfoBizImpl.queryByCondition(userCondition, req));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 添加人员信息页面跳转
	 *
	 * @author likeke
	 * @param map
	 * @date 2017年4月18日
	 * @return String
	 */
	@RequestMapping("/userAdd.do")
	public String toUserInfoAdd(final Map<String, Object> map) {
		map.put("roleList", roleBizImpl.queryAuthRoleByUserId());
		map.put("userCodeSeq", manageSequenceBiz.getSequenceNo(SequenceTypeEnum.USERCODE.getEnumName()));
		return getView("/admin/user/userAdd");
	}

	/**
	 * 添加人员信息
	 *
	 * @author likeke
	 * @param userInfoBo
	 * @param request
	 * @param roleId
	 * @date 2017年4月18日
	 * @return String
	 */
	@RequestMapping("/userAdd.ajax")
	public String userInfoAdd(final UserInfoBo userInfoBo, final HttpServletRequest request,
			@RequestParam("roleId") final List<Long> roleId) {
		userInfoBizImpl.addUserInfo(userInfoBo, request, roleId);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 人员归档
	 *
	 * @author likeke
	 * @param userId
	 * @param userStatus
	 * @date 2017年4月18日
	 * @return String
	 */
	@RequestMapping("/userArchive.ajax")
	public String userDelet(@RequestParam("userId") final List<Long> userId, final String userStatus) {
		userInfoBizImpl.userArchive(userId, userStatus);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 人员恢复
	 *
	 * @author loujie
	 * @data 2017年5月6日
	 * @param userId
	 * @param userStatus
	 * @return json
	 */
	@RequestMapping("/userRecovery.ajax")
	public String userArchive(@RequestParam("userId") final List<Long> userId, final String userStatus) {
		userInfoBizImpl.userArchive(userId, userStatus);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 修改人员页面跳转
	 *
	 * @author likeke
	 * @param map
	 * @param userId
	 * @date 2017年4月18日
	 * @return String
	 */

	@RequestMapping("/userUpdate.do")
	public String userUpdate(final Map<String, Object> map, final Long userId) {

		/* 查询用户基础信息 */
		map.put("userInfoBo", userInfoBizImpl.querById(userId));
		/* 查询所有角色 */
		map.put("roleList", roleBizImpl.queryAuthRoleByUserId());
		/* 查询用户拥有角色 */
		final List<UserRoleBo> containRole = roleBizImpl.userRoleById(userId);
		final String roleListContain = StringUtils.join(containRole, ',');
		map.put("roleListContain", roleListContain);
		return getView("/admin/user/userUpdate");

	}

	/**
	 * @author sungantao
	 * @date 2017年8月24日
	 * @param map
	 * @param userId
	 * @return view
	 */
	@RequestMapping("/userDescribe.do")
	public String userDescribe(final Map<String, Object> map, final Long userId) {

		/* 查询用户基础信息 */
		map.put("userInfoBo", userInfoBizImpl.querById(userId));
		/* 查询所有角色 */
		map.put("roleList", roleBizImpl.queryAuthRoleByUserId());
		/* 查询用户拥有角色 */
		final List<UserRoleBo> containRole = roleBizImpl.userRoleById(userId);
		final String roleListContain = StringUtils.join(containRole, ',');
		map.put("roleListContain", roleListContain);
		return getView("/admin/user/userDescribe");

	}

	/**
	 * 修改人员信息
	 *
	 * @author likeke
	 * @param userInfoBo
	 * @param request
	 * @param roleId
	 * @param oldPhoto
	 * @date 2017年4月18日
	 * @return String
	 */
	@RequestMapping("/userUpdate.ajax")
	public String userUpdate(final UserInfoBo userInfoBo, final HttpServletRequest request,
			@RequestParam("roleId") final List<Long> roleId, final String oldPhoto) {
		userInfoBizImpl.userUpdate(userInfoBo, request, roleId, oldPhoto);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 删除人员
	 *
	 * @author 刘教练
	 * @date 2017年8月16日
	 * @param userId
	 * @return String
	 */
	@RequestMapping("/userDelete.ajax")
	public String userDelete(final long userId) {
		userInfoBizImpl.userDelete(userId);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 跳转到人员导入界面
	 *
	 * @author linzhiqiang
	 * @date 2017年5月9日
	 * @return view
	 */
	@RequestMapping("/userImport.do")
	public String userImport() {
		return getView("/admin/user/userImport");
	}

	/**
	 * 人员导入
	 *
	 * @author linzhiqiang
	 * @date 2017年5月9日
	 * @param model
	 * @return view
	 */
	@RequestMapping("improtUser.ajax")
	public String importTask(final Model model) {
		final Map<String, FileUploadBo> uploadFileMap = SessionLocal.getSessionLocal(SessionLocalEnum.UPLOAD_FILE);
		final FileUploadBo fileUploadBo = uploadFileMap.get("importUser");
		Assert.notNull(fileUploadBo, "上传文件为空!");
		Assert.isTrue(fileUploadBo.getFileSize() > 0, "上传文件为空!");
		model.addAttribute("successMessag", userInfoBizImpl.userExcel(fileUploadBo));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 查询密码及用户名
	 *
	 * @author linzhiqiang
	 * @date 2017年5月10日
	 * @param map
	 * @return view
	 */
	@RequestMapping("queryPassword.ajax")
	public String queryPassword(final Map<String, Object> map) {
		final UserInfoListEntry entry = userInfoBizImpl.queryPassword();
		map.put("entry", entry);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 修改密码
	 *
	 * @author linzhiqiang
	 * @date 2017年5月10日
	 * @param userId
	 * @param password
	 * @param oldPassword
	 * @return view
	 */
	@RequestMapping("updatePassword.ajax")
	public String updatePassword(final long userId, final String password, final String oldPassword) {
		userInfoBizImpl.updatePassword(userId, password, oldPassword);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 查询目录根节点
	 *
	 * @author loujie
	 * @data 2017年9月7日
	 * @param dirType
	 * @param model
	 * @param request
	 * @return json
	 */
	@RequestMapping("/dirTree.ajax")
	public String dirTree(final String dirType, final Map<String, Object> model, final HttpServletRequest request) {
		model.put("treeRootList", authDirBiz.queryTreeRoot());
		return getView(ViewEnumType.JSON_VIEW);
	}

	// /**
	// * 查询商务负责人信息
	// *
	// * @param condition
	// * @param pageNumber
	// * 当前页号
	// * @param pageSize
	// * 每页显示记录数
	// * @param request
	// * @param map
	// * @return 商务负责人
	// * @author liyw
	// */
	// @RequestMapping("/queryUser.ajax")
	// public String queryBusUser(final UserCondition condition, final int
	// pageNumber, final int pageSize,
	// final HttpServletRequest request, final Map<String, Object> map) {
	// final PageCond pageCond = new PageCond();
	// pageCond.setLimit(pageSize);
	// pageCond.setStart(pageCond.getLimit() * (pageNumber - 1) + 1);
	// condition.setPageCond(pageCond);
	// final List<UserInfoListEntry> list =
	// userInfoBizImpl.queryByCondition(condition, request);
	// map.put("list", list);
	// map.put("totalRow", condition.getPageCond().getCount());
	// return getView(ViewEnumType.JSON_VIEW);
	// }
}
