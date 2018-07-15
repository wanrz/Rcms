/**
 *
 */
package com.rionsoft.rcms.dao.project;

import java.util.List;

import com.rionsoft.rcms.condition.project.ProjectRecourceRefCondition;
import com.rionsoft.rcms.condition.project.ProjectRecourceRefListEntry;
import com.rionsoft.rcms.condition.project.ProjectUserListEntry;
import com.rionsoft.rcms.entry.project.ProjectRecourceRefEntry;
import com.rionsoft.rcms.entry.user.UserInfoEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.ITableInsertList;
import com.rionsoft.support.mybatisplugin.dao.common.core.IWholeTableQuery;

/**
 * @author linzhiqiang
 * @date 2017年4月25日
 */
public interface IProjectRecourceRefDao extends ISingleTableDao<ProjectRecourceRefEntry>,
		ITableInsertList<ProjectRecourceRefEntry>, IWholeTableQuery<ProjectRecourceRefEntry> {

	/**
	 * 查询项目列表
	 *
	 * @author linzhiqiang
	 * @date 2017年4月25日
	 * @param condition
	 * @return view
	 */
	List<ProjectRecourceRefListEntry> projectRfeQuery(ProjectRecourceRefCondition condition);

	/**
	 * 查询已分配人员
	 *
	 * @author linzhiqiang
	 * @date 2017年4月26日
	 * @param condition
	 * @return view
	 */
	List<ProjectUserListEntry> projectUserQuery(ProjectRecourceRefCondition condition);

	/**
	 * 查询未分配人员
	 *
	 * @author linzhiqiang
	 * @date 2017年4月27日
	 * @param condition
	 * @return view
	 */
	List<ProjectUserListEntry> projectUserList(ProjectRecourceRefCondition condition);

	/**
	 * 删除已分配人员
	 *
	 * @author linzhiqiang
	 * @date 2017年4月27日
	 * @param userIdList
	 * @param pkProj
	 */
	void projectDeleteUser(List<Long> userIdList, long pkProj);

	/**
	 * 根据idList查询项目是否分配过人员，分配过返回项目code
	 *
	 * @author loujie
	 * @data 2017年5月12日
	 * @param pkList
	 * @return list
	 */
	List<String> queryCodeByList(List<Long> pkList);

	/**
	 * 根据userId查询人员所参加的项目条数，返回项目条数
	 *
	 * @author 刘教练
	 * @date 2017年8月16日
	 * @param userId
	 * @return int
	 */
	int queryProjectUserCount(final long userId);

	/**
	 * 根据权限查询项目资源
	 *
	 * @author sungantao
	 * @date 2017年9月14日
	 * @param condition
	 * @return 项目资源信息集合
	 */
	List<ProjectRecourceRefListEntry> queryProjResByDataCode(ProjectRecourceRefCondition condition);

	/**
	 * 更改项目管理者
	 *
	 * @author 刘教练
	 * @date 2017年9月28日
	 * @param userId
	 * @param chargeProj
	 * @param pkProj
	 */
	void updateProjectRefUser(final Long userId, final String chargeProj, final Long pkProj);

	/**
	 * 查询该项目分配人员是否填写了关于该项目的日志
	 *
	 * @author linzhiqiang
	 * @date 2017年11月20日
	 * @param userIdList
	 * @param pkProj
	 * @return list
	 */
	List<UserInfoEntry> queryCountInfo(List<Long> userIdList, long pkProj);

	/**
	 * 查询该任务分配人员是否填写了关于该任务的日志
	 *
	 * @author linzhiqiang
	 * @date 2017年11月22日
	 * @param userList
	 * @param pkTask
	 * @return list
	 */
	List<UserInfoEntry> queryTaskCountInfo(List<Long> userList, long pkTask);

	/**
	 * 查询该项目是否只有一位管理者
	 *
	 * @author linzhiqiang
	 * @date 2017年11月30日
	 * @param pkProj
	 * @return int
	 */
	int queryProjectRefCharge(Long pkProj);

}
