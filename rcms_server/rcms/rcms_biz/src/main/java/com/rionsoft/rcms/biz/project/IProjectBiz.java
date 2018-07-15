/**
 *
 */
package com.rionsoft.rcms.biz.project;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.rionsoft.rcms.bo.project.ProjectBo;
import com.rionsoft.rcms.condition.project.ProjectCondition;

/**
 * @author linzhiqiang
 * @date 2017年4月19日
 */
public interface IProjectBiz {

	/**
	 * 立项管理保存
	 *
	 * @author linzhiqiang
	 * @date 2017年4月19日
	 * @param projectBo
	 */
	void projectSave(ProjectBo projectBo);

	/**
	 * 立项管理查询
	 *
	 * @author linzhiqiang
	 * @date 2017年4月19日
	 * @param projectCondition
	 * @param req
	 * @return view
	 */
	List<ProjectBo> projectChangeQuery(ProjectCondition projectCondition, HttpServletRequest req);

	/**
	 * @author sungantao
	 * @date 2017年9月1日
	 * @param projectCondition
	 * @param req
	 * @return List<ProjectBo>
	 */
	List<ProjectBo> projectQuery(ProjectCondition projectCondition, HttpServletRequest req);

	/**
	 * 查询修改详情
	 *
	 * @author linzhiqiang
	 * @date 2017年4月20日
	 * @param pkProj
	 * @return view
	 */
	ProjectBo queryProject(long pkProj);

	/**
	 * 修改保存
	 *
	 * @author linzhiqiang
	 * @date 2017年4月20日
	 * @param projectBo
	 */
	void projectUpdate(ProjectBo projectBo);

	/**
	 * 项目变更
	 *
	 * @author loujie
	 * @data 2017年4月21日
	 * @param projectBo
	 */
	void changeProject(ProjectBo projectBo);

	/**
	 * 查询项目变更记录和详情
	 *
	 * @author loujie
	 * @data 2017年4月21日
	 * @param condition
	 * @return list
	 */
	List<ProjectBo> queryProjectDetails(ProjectCondition condition);

	/**
	 * @author linzhiqiang
	 * @param typeCode
	 * @date 2017年4月24日
	 * @return view
	 */
	String getProjectCode(String typeCode);

	/**
	 * 根据pkProj和version查询项目当前详情和上次修改的详情
	 *
	 * @author loujie
	 * @data 2017年4月24日
	 * @param pkProj
	 * @param version
	 * @return list
	 */
	List<ProjectBo> queryProjectContrast(long pkProj, int version);

	/**
	 * 查询项目变更记录次数
	 *
	 * @author loujie
	 * @data 2017年4月24日
	 * @param pkProj
	 * @return int
	 */
	int queryCount(long pkProj);

	/**
	 * 批量删除
	 *
	 * @author linzhiqiang
	 * @date 2017年4月28日
	 * @param pkList
	 */
	void deleteProj(List<Long> pkList);

	/**
	 * @author sungantao
	 * @date 2017年9月25日
	 * @param condition
	 * @return List<ProjectBo>
	 */
	List<ProjectBo> projectContrast(ProjectCondition condition);

	/**
	 * 查询操作的项目
	 *
	 * @author 刘教练
	 * @date 2017年10月12日
	 * @param projectCondition
	 * @param req
	 * @return list
	 */
	List<ProjectBo> queryProjectByProjOperator(ProjectCondition projectCondition, HttpServletRequest req);

	/**
	 * 管理项目所包含的员工
	 *
	 * @author liujiaolian
	 * @date 2017年10月25日
	 * @date 2018年1月4日
	 * @param userId
	 * @param loginCode
	 * @return List<ProjectBo>
	 */
	List<ProjectBo> userInProjectByProjOperator(long userId, String loginCode);

}
