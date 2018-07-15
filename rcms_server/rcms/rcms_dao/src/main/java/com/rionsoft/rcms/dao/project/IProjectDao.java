/**
 *
 */
package com.rionsoft.rcms.dao.project;

import java.util.List;

import com.rionsoft.rcms.condition.project.ProjectCondition;
import com.rionsoft.rcms.condition.project.ProjectListEntry;
import com.rionsoft.rcms.entry.project.ProjectEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.ITableInsertList;
import com.rionsoft.support.mybatisplugin.dao.common.core.IWholeTableQuery;

/**
 * @author linzhiqiang
 * @date 2017年4月19日
 */
public interface IProjectDao
		extends ISingleTableDao<ProjectEntry>, ITableInsertList<ProjectEntry>, IWholeTableQuery<ProjectEntry> {

	/**
	 * 立项管理查询
	 *
	 * @author linzhiqiang
	 * @date 2017年4月19日
	 * @param projectCondition
	 * @return view
	 */
	List<ProjectListEntry> projectQuery(ProjectCondition projectCondition);

	/**
	 * 查询修改详情
	 *
	 * @author linzhiqiang
	 * @date 2017年4月20日
	 * @param pkProj
	 * @return ProjectEntry
	 */
	ProjectListEntry queryProject(long pkProj);

	/**
	 * 查询项目变更记录和详情
	 *
	 * @author loujie
	 * @data 2017年4月21日
	 * @param condition
	 * @return list
	 */
	List<ProjectListEntry> queryProjectDetails(ProjectCondition condition);

	/**
	 * 查询数据记录
	 *
	 * @author linzhiqiang
	 * @date 2017年4月24日
	 * @param code2
	 * @return view
	 */
	int queryNumber(String code2);

	/**
	 * 根据pkProj和version查询项目当前详情和上次修改的详情
	 *
	 * @author loujie
	 * @data 2017年4月24日
	 * @param pkProj
	 * @param version
	 * @return list
	 */
	List<ProjectListEntry> queryProjectContrast(long pkProj, int version);

	/**
	 * 通过idList 查询项目集合
	 *
	 * @author 金浩宇
	 * @date 2017年4月24日
	 * @param idList
	 * @return List<ProjectEntry>
	 */
	List<ProjectEntry> queryProjectTodo(List<Long> idList);

	/**
	 * 批量删除
	 *
	 * @author linzhiqiang
	 * @date 2017年4月28日
	 * @param pkList
	 */
	void deleteProj(List<Long> pkList);

	/**
	 * 查询该部门下是否包含项目
	 *
	 * @author loujie
	 * @data 2017年5月6日
	 * @param dirId
	 * @return int
	 */
	int queryProjById(long dirId);

	/**
	 * 查询已建立了任务的项目
	 *
	 * @author loujie
	 * @data 2017年5月11日
	 * @param pkList
	 * @return list
	 */
	List<String> queryByList(List<Long> pkList);

	/**
	 * 根据数据权限查询项目
	 *
	 * @author sungantao
	 * @date 2017年9月14日
	 * @param projectCondition
	 * @return 立项项目集合
	 */
	List<ProjectListEntry> queryProjectByDataCode(ProjectCondition projectCondition);

	/**
	 * @author sungantao
	 * @date 2017年9月25日
	 * @param condition
	 * @return List<ProjectListEntry>
	 */
	List<ProjectListEntry> projectContrast(ProjectCondition condition);

	/**
	 * 查询操作的项目
	 *
	 * @author 刘教练
	 * @date 2017年10月12日
	 * @param condition
	 * @return list
	 */
	List<ProjectListEntry> queryProjectByProjOperator(ProjectCondition condition);

	/**
	 * 查询审批过的项目(按照审批时间倒序排序)
	 *
	 * @author 刘教练
	 * @date 2017年10月16日
	 * @param condition
	 * @return List<ProjectListEntry>
	 */
	List<ProjectListEntry> projectListByApprovalTime(ProjectCondition condition);

	/**
	 * 管理项目所包含的员工
	 *
	 * @author 刘教练
	 * @date 2017年10月25日
	 * @param userId
	 * @param loginCode
	 * @return List<ProjectListEntry>
	 */
	List<ProjectListEntry> userInProjectByProjOperator(long userId, String loginCode);
}
