/**
 *
 */
package com.rionsoft.rcms.dao.task;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.task.TaskCondition;
import com.rionsoft.rcms.condition.task.TaskListEntry;
import com.rionsoft.rcms.condition.task.TaskUserRefCondition;
import com.rionsoft.rcms.condition.task.TaskUserRefListEntry;
import com.rionsoft.rcms.entry.project.ProjectEntry;
import com.rionsoft.rcms.entry.task.TaskEntry;
import com.rionsoft.rcms.entry.task.TaskUserRefEntry;
import com.rionsoft.rcms.entry.workLog.WorkLogEntry;

/**
 * @author loujie
 * @data 2017年4月25日
 */
@Repository
public interface ITaskMapper {

	/**
	 * 查询任务列表
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param condition
	 * @return list
	 */
	List<TaskListEntry> queryByCondition(TaskCondition condition);

	/**
	 * 查询已分配任务的人员
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param condition
	 * @return list
	 */
	List<TaskUserRefListEntry> queryRefByCondition(TaskUserRefCondition condition);

	/**
	 * 删除已分配人员
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param userList
	 * @param pkTask
	 */
	void deleteUser(@Param("userList") List<Long> userList, @Param("pkTask") long pkTask);

	/**
	 * 查询用户表
	 *
	 * @author kongdeshuang
	 * @date 2017年4月26日
	 * @param condition
	 * @return List<UserInfoEntry>
	 */
	List<TaskUserRefListEntry> queryUserInfoByCondition(TaskUserRefCondition condition);

	/**
	 * 根据name查询project
	 *
	 * @author loujie
	 * @data 2017年4月26日
	 * @param proNameList
	 * @return list
	 */
	List<ProjectEntry> queryProjectByName(@Param("proNameList") List<String> proNameList);

	/**
	 * 查询编任务码是否存在
	 *
	 * @author loujie
	 * @data 2017年4月27日
	 * @param taskCodeList
	 * @return String
	 */
	String checkTaskCode(@Param("taskCodeList") List<String> taskCodeList);

	/**
	 * 查询可以分配任务的项目
	 *
	 * @author loujie
	 * @data 2017年4月30日
	 * @param userId
	 * @return list
	 */
	List<ProjectEntry> projectQuery(@Param("userId") long userId);

	/**
	 * 根据userId查询用户已分配的任务
	 *
	 * @author loujie
	 * @data 2017年5月1日
	 * @param userId
	 * @return list
	 */
	List<TaskListEntry> queryTaskByUserId(@Param("userId") long userId);

	/**
	 * 修改任务完成百分比
	 *
	 * @author loujie
	 * @data 2017年5月1日
	 * @param userEntry
	 */
	void updateUserRef(TaskUserRefEntry userEntry);

	/**
	 * 根据pkTask查询所有数据
	 *
	 * @author loujie
	 * @data 2017年5月4日
	 * @param entryList
	 * @return list
	 */
	List<TaskUserRefListEntry> queryByPkTask(@Param("entryList") List<WorkLogEntry> entryList);

	/**
	 * 根据数据权限查询任务信息
	 *
	 * @author sungantao
	 * @date 2017年9月15日
	 * @param condition
	 * @return 任务信息集合
	 */
	List<TaskListEntry> queryTaskByDataCode(TaskCondition condition);

	/**
	 * 通过人员名称查询任务Id
	 *
	 * @author 刘教练
	 * @date 2017年9月15日
	 * @param userName
	 * @return taskIdList
	 */
	List<Long> queryTaskByUserName(@Param("userName") String userName);

	/**
	 * 通过项目ID查询其未完结的任务
	 * 
	 * @author 刘教练
	 * @date 2017年10月18日
	 * @param pkProj
	 * @return List<TaskEntry>
	 */
	List<TaskEntry> queryTaskByPkProj(@Param("pkProj") long pkProj);
}
