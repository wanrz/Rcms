/**
 *
 */
package com.rionsoft.rcms.biz.task;

import java.util.List;

import com.rionsoft.rcms.bo.task.ExcelTaskBo;
import com.rionsoft.rcms.bo.task.TaskUserRefBo;
import com.rionsoft.rcms.bo.user.ExcelUserBo;

/**
 * @author loujie
 * @data 2017年4月26日
 */
public interface ITaskImportBiz {

	/**
	 * 批量插入task
	 *
	 * @author loujie
	 * @data 2017年4月26日
	 * @param boList
	 * @return int
	 */
	int importTaskList(List<ExcelTaskBo> boList);

	/**
	 * 分配人员
	 *
	 * @author loujie
	 * @data 2017年4月27日
	 * @param boList
	 */
	void addUser(List<TaskUserRefBo> boList);

	/**
	 * @author linzhiqiang
	 * @date 2017年5月9日
	 * @param boList
	 * @return 11
	 */
	int importUserList(List<ExcelUserBo> boList);

}
