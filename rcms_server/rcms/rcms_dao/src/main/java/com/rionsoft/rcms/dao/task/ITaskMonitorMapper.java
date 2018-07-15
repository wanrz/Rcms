/**
 *
 */
package com.rionsoft.rcms.dao.task;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.project.ProjMonitorCondition;
import com.rionsoft.rcms.condition.project.ProjMonitorListEntry;
import com.rionsoft.rcms.condition.task.TaskCondition;
import com.rionsoft.rcms.condition.task.TaskListEntry;
import com.rionsoft.rcms.condition.task.TaskMonitorCondition;
import com.rionsoft.rcms.condition.task.TaskUserRefListEntry;

/**
 * @author loujie
 * @data 2017年4月25日
 */
@Repository
public interface ITaskMonitorMapper {

	/**
	 * 查询任务进度详情
	 *
	 * @author likeke
	 * @date 2017年5月1日
	 * @param condition
	 * @return TaskUserRefListEntry
	 */
	List<TaskUserRefListEntry> queryProgressDetail(TaskMonitorCondition condition);

	/**
	 * @author linzhiqiang
	 * @date 2017年5月3日
	 * @param condition
	 * @return list
	 */
	List<ProjMonitorListEntry> queryProjMonitor(ProjMonitorCondition condition);

	/**
	 * 查询一个项目所分配的任务个数
	 *
	 * @author linzhiqiang
	 * @date 2017年5月3日
	 * @param pkProj
	 * @return count
	 */
	int queryTask(@Param("pkProj") long pkProj);

	/**
	 * 查询项目进度百分比
	 *
	 * @author linzhiqiang
	 * @date 2017年5月4日
	 * @param pkProj
	 * @return percent
	 */
	int projPercent(@Param("pkProj") long pkProj);

	/**
	 * 查询任务进度列表
	 * 
	 * @author linzhiqiang
	 * @date 2017年5月8日
	 * @param condition
	 * @return list
	 */
	List<TaskListEntry> queryTaskMonitor(TaskCondition condition);

	/**
	 * 查看项目监控信息
	 * 
	 * @author sungantao
	 * @date 2017年9月15日
	 * @param projectCondition
	 * @return 项目监控信息集合
	 */
	List<ProjMonitorListEntry> queryMonitorByDataCode(ProjMonitorCondition projectCondition);

}
