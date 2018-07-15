/**
 *
 */
package com.rionsoft.rcms.dao.project.impl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.project.ProjectCondition;
import com.rionsoft.rcms.condition.project.ProjectListEntry;

/**
 * @author linzhiqiang
 * @date 2017年4月19日
 */
@Repository
public interface IProjectMapper {

	/**
	 * 立项管理查询
	 *
	 * @author linzhiqiang
	 * @date 2017年4月19日
	 * @param projectCondition
	 * @return List
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
	ProjectListEntry queryProject(@Param("pkProj") long pkProj);

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
	 * 查询记录总数
	 *
	 * @author linzhiqiang
	 * @date 2017年4月24日
	 * @param code2
	 * @return string
	 */
	int queryNumber(@Param("code2") String code2);

	/**
	 * 根据pkProj和version查询项目当前详情和上次修改的详情
	 *
	 * @author loujie
	 * @data 2017年4月24日
	 * @param pkProj
	 * @param version
	 * @return list
	 */
	List<ProjectListEntry> queryProjectContrast(@Param("pkProj") long pkProj, @Param("version") int version);

	/**
	 * 查询已建立了任务的项目
	 *
	 * @author loujie
	 * @data 2017年5月11日
	 * @param pkList
	 * @return list
	 */
	List<String> queryByList(@Param("pkList") List<Long> pkList);

	/**
	 * 根据权限查询立项信息
	 *
	 * @author sungantao
	 * @date 2017年9月14日
	 * @param projectCondition
	 * @return 立项信息集合
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
	List<ProjectListEntry> userInProjectByProjOperator(@Param("userId") long userId,
			@Param("loginCode") String loginCode);

}
