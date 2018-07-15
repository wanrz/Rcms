/**
 *
 */
package com.rionsoft.rcms.biz.task;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.rionsoft.rcms.bo.project.ProjectBo;
import com.rionsoft.rcms.bo.task.TaskBo;
import com.rionsoft.rcms.bo.task.TaskUserRefBo;
import com.rionsoft.rcms.condition.task.TaskCondition;
import com.rionsoft.rcms.condition.task.TaskUserRefCondition;
import com.rionsoft.support.basebo.common.file.FileUploadBo;

/**
 * @author loujie
 * @data 2017年4月25日
 */
public interface ITaskBiz {

	/**
	 * 分配任务时查询任务列表
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param condition
	 * @param req
	 * @return list
	 */
	List<TaskBo> queryByCondition(TaskCondition condition, HttpServletRequest req);

	/**
	 * 新增任务
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param taskBo
	 */
	void addTask(TaskBo taskBo);

	/**
	 * 根据pkTask查询任务详情并跳转到修改界面
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param pkTask
	 * @return TaskBo
	 */
	TaskBo queryTaskById(long pkTask);

	/**
	 * 修改任务
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param taskBo
	 */
	void updateTask(TaskBo taskBo);

	/**
	 * 任务封存
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param pkTask
	 * @param status
	 */
	void updateStatus(long pkTask, String status);

	/**
	 * 删除任务
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param pkList
	 */
	void deleteTask(List<Long> pkList);

	/**
	 * 查询已分配任务的人员
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param condition
	 * @return list
	 */
	List<TaskUserRefBo> queryRefByCondition(TaskUserRefCondition condition);

	/**
	 * 删除已分配人员
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param userList
	 * @param pkTask
	 */
	void deleteUser(List<Long> userList, long pkTask);

	/**
	 * 查询用户信息
	 *
	 * @author kongdeshuang
	 * @date 2017年4月26日
	 * @param condition
	 * @return List<UserInfoBo>
	 */
	List<TaskUserRefBo> queryUserInfoByCondition(TaskUserRefCondition condition);

	/**
	 * 任务导入
	 *
	 * @author loujie
	 * @data 2017年4月26日
	 * @param fileUploadBo
	 * @return int
	 */
	int userExcel(FileUploadBo fileUploadBo);

	/**
	 * 查询可以分配任务的项目
	 *
	 * @author loujie
	 * @data 2017年4月30日
	 * @param userId
	 * @return list
	 */
	List<ProjectBo> projectQuery(long userId);

	/**
	 * 根据userId查询用户已分配的任务
	 *
	 * @author loujie
	 * @data 2017年5月1日
	 * @param userId
	 * @return list
	 */
	List<TaskBo> queryTaskByUserId(long userId);

	/**
	 * 通过项目ID查询其未完结的任务
	 * 
	 * @author 刘教练
	 * @date 2017年10月18日
	 * @param pkProj
	 * @return List<TaskBo>
	 */
	List<TaskBo> queryTaskByPkProj(long pkProj);
}
