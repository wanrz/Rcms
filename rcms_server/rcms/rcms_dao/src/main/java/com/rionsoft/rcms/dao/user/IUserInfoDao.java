/**
 *
 */
package com.rionsoft.rcms.dao.user;

import java.util.List;

import com.rionsoft.rcms.condition.listentry.user.UserInfoListEntry;
import com.rionsoft.rcms.condition.user.UserCondition;
import com.rionsoft.rcms.entry.department.AuthDirEntry;
import com.rionsoft.rcms.entry.role.AuthDataTypeEntry;
import com.rionsoft.rcms.entry.system.BdDictDetailEntry;
import com.rionsoft.rcms.entry.user.UserInfoEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.ITableInsertList;
import com.rionsoft.support.mybatisplugin.dao.common.core.IWholeTableQuery;

/**
 * @author kongdeshuang
 * @date 2017年4月14日
 *
 */
public interface IUserInfoDao
		extends ISingleTableDao<UserInfoEntry>, ITableInsertList<UserInfoEntry>, IWholeTableQuery<UserInfoEntry> {

	/**
	 * 查询用户列表
	 *
	 * @author likeke
	 * @date 2017年4月18日
	 * @param userCondition
	 * @return List<UserInfoEntry>
	 */
	List<UserInfoListEntry> queryByCondition(UserCondition userCondition);

	/**
	 * 删除用户
	 *
	 * @author likeke
	 * @date 2017年4月2
	 * @param idList
	 * @return boolean
	 */
	boolean deleteByIds(final List<Long> idList);

	/**
	 * 人员归档
	 *
	 * @author likeke
	 * @date 2017年4月25日
	 * @param userId
	 * @param userStatus
	 */
	void userArchive(List<Long> userId, String userStatus);

	/**
	 * 通过登录码 查找用户
	 *
	 * @author 金浩宇
	 * @date 2017年4月25日
	 * @param loginCode
	 * @return UserInfoEntry
	 */
	UserInfoEntry queryUserByLoginCode(String loginCode);

	/**
	 * 查询登录名是否重复
	 *
	 * @author linzhiqiang
	 * @date 2017年5月5日
	 * @param loginCode
	 * @return count
	 */
	int queryLoginCodeCount(String loginCode);

	/**
	 * 查询该部门下是否包含人员
	 *
	 * @author loujie
	 * @data 2017年5月6日
	 * @param dirId
	 * @return int
	 */
	int queryUserByID(long dirId);

	/**
	 * 查询登录人员密码
	 *
	 * @author linzhiqiang
	 * @date 2017年5月10日
	 * @param userId
	 * @return entry
	 */
	UserInfoListEntry queryPassword(long userId);

	/**
	 * 修改密码
	 *
	 * @author linzhiqiang
	 * @date 2017年5月10日
	 * @param userId
	 * @param password
	 */
	void updatePassword(long userId, String password);

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
	List<String> selectExist(List<UserInfoEntry> entryList);

	/**
	 * 根据数据权限查询人员相应数据
	 *
	 * @author sungantao
	 * @date 2017年9月14日
	 * @param userCondition
	 * @return 人员信息集合
	 */
	List<UserInfoListEntry> queryByDataCode(UserCondition userCondition);

	/**
	 * 根据用户id查询用户数据权限
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
	 * @return view
	 */
	List<UserInfoEntry> userListByProjDirOperator(final String userName, final Long pkProj, final Long dirId);
}
