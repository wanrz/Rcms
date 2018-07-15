/**
 *
 */
package com.rionsoft.rcms.biz.task;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.rionsoft.rcms.bo.task.TaskBo;
import com.rionsoft.rcms.bo.task.TaskUserRefBo;
import com.rionsoft.rcms.condition.project.ProjMonitorCondition;
import com.rionsoft.rcms.condition.project.ProjMonitorListEntry;
import com.rionsoft.rcms.condition.task.TaskCondition;
import com.rionsoft.rcms.condition.task.TaskListEntry;
import com.rionsoft.rcms.condition.task.TaskMonitorCondition;
import com.rionsoft.rcms.condition.task.TaskUserRefListEntry;
import com.rionsoft.support.basebo.view.ExportFileBo;

/**
 * @author likeke
 * @date 2017年4月30日
 */
public interface ITaskMonitorBiz {
	/**
	 * 导出任务简单信息
	 *
	 * @author likeke
	 * @date 2017年4月30日
	 * @param idList
	 * @param req
	 * @return ExportFileBo<TaskBo>
	 */
	ExportFileBo<TaskBo> exportTask(List<Long> idList, HttpServletRequest req);

	/**
	 * 导出任务详情
	 *
	 * @author likeke
	 * @date 2017年4月30日
	 * @param idList
	 * @return ExportFileBo<TaskUserRefBo>
	 */
	ExportFileBo<TaskUserRefBo> exportTaskDetail(List<Long> idList);

	/**
	 * 查询任务列表详情
	 *
	 * @author likeke
	 * @date 2017年5月1日
	 * @param condition
	 * @return TaskListEntry
	 */
	List<TaskUserRefListEntry> queryProgressDetail(final TaskMonitorCondition condition);

	/**
	 * 查询项目列表
	 *
	 * @author linzhiqiang
	 * @date 2017年5月3日
	 * @param condition
	 * @param req
	 * @return list
	 */
	List<ProjMonitorListEntry> queryProjMonitor(ProjMonitorCondition condition, HttpServletRequest req);

	/**
	 * 查询任务进度
	 *
	 * @author linzhiqiang
	 * @date 2017年5月8日
	 * @param condition
	 * @return list
	 */
	List<TaskListEntry> queryTaskMonitor(TaskCondition condition);

}
