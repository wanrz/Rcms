/**
 *
 */
package com.rionsoft.rcms.biz.workLog;

import java.util.List;
import java.util.Map;

import com.rionsoft.rcms.bo.workLog.WorkLogBo;
import com.rionsoft.rcms.condition.workLog.WorkLogCondition;
import com.rionsoft.support.basebo.view.ExportFileBo;

/**
 * @author loujie
 * @data 2017年4月30日
 */
public interface IWorkLogBiz {

	/**
	 * 查询工作日志
	 *
	 * @author loujie
	 * @data 2017年4月30日
	 * @param condition
	 * @return list
	 */
	List<WorkLogBo> queryWorkByCondition(WorkLogCondition condition);

	/**
	 * 查询本月工作日志
	 *
	 * @author 刘教练
	 * @date 2017年8月28日
	 * @param condition
	 * @return list
	 */
	List<WorkLogBo> queryMonthByCondition(WorkLogCondition condition);

	/**
	 * 添加日志
	 *
	 * @author loujie
	 * @data 2017年5月1日
	 * @param boList
	 */
	void workLogAdd(List<WorkLogBo> boList);

	/**
	 * 导出工作日志
	 *
	 * @author loujie
	 * @data 2017年5月2日
	 * @param pkWorkLogList
	 * @return ExportFileBo
	 */
	ExportFileBo<Map<String, Object>> exportWorkLog(List<Long> pkWorkLogList);

	/**
	 * 查询本月任务状态
	 *
	 * @author 刘教练
	 * @date 2017年8月25日
	 * @return list
	 */
	Map<String, String> selectMonthWorkInfo();

	/**
	 * 查询此周任务的信息
	 *
	 * @author 刘教练
	 * @date 2017年8月31日
	 * @param dateId
	 * @return list
	 */
	Map<String, String> selectWeekWorkInfo(long dateId);
}
