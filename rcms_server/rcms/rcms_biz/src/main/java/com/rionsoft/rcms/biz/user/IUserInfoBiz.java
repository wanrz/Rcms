/**
 *
 */
package com.rionsoft.rcms.biz.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;

import com.rionsoft.rcms.bo.user.UserInfoBo;
import com.rionsoft.rcms.condition.listentry.user.UserInfoListEntry;
import com.rionsoft.rcms.condition.user.UserCondition;
import com.rionsoft.rcms.entry.role.AuthDataTypeEntry;
import com.rionsoft.support.basebo.common.file.FileUploadBo;

/**
 * @author kongdeshuang
 * @date 2017年4月14日
 */
public interface IUserInfoBiz {

	/**
	 * 新增用户
	 *
	 * @author likeke
	 * @date 2017年4月17日
	 * @param bo
	 *            用户信息
	 * @param request
	 * @param roleId
	 */
	void addUserInfo(UserInfoBo bo, HttpServletRequest request, List<Long> roleId);

	/**
	 * 查看用户列表
	 *
	 * @author sungantao
	 * @date 2017年9月16日
	 * @param userCondition
	 * @param req
	 * @return 用户信息集合
	 */
	List<UserInfoListEntry> queryByCondition(UserCondition userCondition, HttpServletRequest req);

	/**
	 * 删除用户
	 *
	 * @author likeke
	 * @date 2017年4月20日
	 * @param userId
	 */
	void deletUser(List<Long> userId);

	/**
	 * 根据id查找用户
	 *
	 * @author likeke
	 * @date 2017年4月20日
	 * @param userId
	 * @return UserInfoBo
	 */
	UserInfoBo querById(Long userId);

	/**
	 * @author likeke
	 * @date 2017年4月20日
	 * @param userInfoBo
	 * @param request
	 * @param roleId
	 * @param oldPhoto
	 */
	void userUpdate(UserInfoBo userInfoBo, HttpServletRequest request, List<Long> roleId, String oldPhoto);

	/**
	 * 人员归档
	 *
	 * @author likeke
	 * @date 2017年4月25日
	 * @param userId
	 * @param userStatus
	 */
	void userArchive(@Param("userId") List<Long> userId, String userStatus);

	/**
	 * 人员导入
	 *
	 * @author linzhiqiang
	 * @date 2017年5月9日
	 * @param fileUploadBo
	 * @return int
	 */
	int userExcel(FileUploadBo fileUploadBo);

	/**
	 * 查询登录人员密码
	 *
	 * @author linzhiqiang
	 * @date 2017年5月10日
	 * @return entry
	 */
	UserInfoListEntry queryPassword();

	/**
	 * 修改密码
	 *
	 * @author linzhiqiang
	 * @date 2017年5月10日
	 * @param userId
	 * @param password
	 * @param oldPassword
	 */
	void updatePassword(long userId, String password, String oldPassword);

	/**
	 * 根据userId查询人员所参加的项目条数，返回项目条数
	 *
	 * @author 刘教练
	 * @date 2017年8月16日
	 * @param userId
	 */
	void userDelete(long userId);

	/**
	 * 根据用户ID来查询数据权限
	 *
	 * @author sungantao
	 * @date 2017年9月15日
	 * @param userCondition
	 * @return 数据权限信息集合
	 */
	List<AuthDataTypeEntry> queryAuthRoleByUserId(UserCondition userCondition);
}
