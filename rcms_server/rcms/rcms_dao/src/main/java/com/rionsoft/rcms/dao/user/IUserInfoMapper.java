/**
 *
 */
package com.rionsoft.rcms.dao.user;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.listentry.user.UserInfoListEntry;
import com.rionsoft.rcms.condition.user.UserCondition;
import com.rionsoft.rcms.entry.department.AuthDirEntry;
import com.rionsoft.rcms.entry.role.AuthDataTypeEntry;
import com.rionsoft.rcms.entry.system.BdDictDetailEntry;
import com.rionsoft.rcms.entry.user.UserInfoEntry;

/**
 * @author likeke
 * @date 2017年4月15日
 */
@Repository
public interface IUserInfoMapper {

	/**
	 * 人员列表查询
	 *
	 * @author likeke
	 * @date 2017年4月18日
	 * @param userCondition
	 * @return List<UserInfoListEntry>
	 */
	List<UserInfoListEntry> queryByCondition(UserCondition userCondition);

	/**
	 * 人员归档
	 *
	 * @author likeke
	 * @date 2017年4月25日
	 * @param userId
	 * @param userStatus
	 */
	void userArchive(@Param("userId") List<Long> userId, @Param("userStatus") String userStatus);

	/**
	 * 查询登录名是否重复
	 *
	 * @author linzhiqiang
	 * @date 2017年5月5日
	 * @param loginCode
	 * @return count
	 */
	int queryLoginCodeCount(@Param("loginCode") String loginCode);

	/**
	 * 查询登录用户密码
	 *
	 * @author linzhiqiang
	 * @date 2017年5月10日
	 * @param userId
	 * @return entry
	 */
	UserInfoListEntry queryPassword(@Param("userId") long userId);

	/**
	 * 修改密码
	 *
	 * @author linzhiqiang
	 * @date 2017年5月10日
	 * @param userId
	 * @param password
	 */
	void updatePassword(@Param("userId") long userId, @Param("password") String password);

	/**
	 * 查询部门信息
	 *
	 * @author linzhiqiang
	 * @date 2017年5月11日
	 * @return list
	 */
	List<AuthDirEntry> queryAuthDir();

	/**
	 * 查询合同类别
	 *
	 * @author linzhiqiang
	 * @date 2017年5月11日
	 * @return list
	 */
	List<BdDictDetailEntry> queryContract();

	/**
	 * 查询职工类别
	 *
	 * @author linzhiqiang
	 * @date 2017年5月11日
	 * @return list
	 */
	List<BdDictDetailEntry> queryEmployee();

	/**
	 * 查询职工工资类别
	 *
	 * @author linzhiqiang
	 * @date 2017年5月11日
	 * @return list
	 */
	List<BdDictDetailEntry> queryWages();

	/**
	 * 导入员工xlsx查询员工登录名称是否存在
	 *
	 * @author 刘教练
	 * @date 2017年8月16日
	 * @param entryList
	 * @return list
	 */
	List<String> selectExist(@Param("entryList") List<UserInfoEntry> entryList);

	/**
	 * 根据权限查找人员相关信息
	 *
	 * @author sungantao
	 * @date 2017年9月14日
	 * @param userCondition
	 * @return 人员信息集合
	 */
	List<UserInfoListEntry> queryByDataCode(UserCondition userCondition);

	/**
	 * 根据用户id查询数据权限
	 *
	 * @author sungantao
	 * @date 2017年9月15日
	 * @param userCondition
	 * @return 数据权限信息
	 */
	List<AuthDataTypeEntry> queryAuthRoleByUserId(UserCondition userCondition);

	/**
	 * 通过部门项目查询自己管理的人员
	 *
	 * @author 刘教练
	 * @date 2017年11月2日
	 * @param userName
	 * @param pkProj
	 * @param dirId
	 * @return List<UserInfoEntry>
	 */
	List<UserInfoEntry> userListByProjDirOperator(@Param("userName") String userName, @Param("pkProj") Long pkProj,
			@Param("dirId") Long dirId);
}
