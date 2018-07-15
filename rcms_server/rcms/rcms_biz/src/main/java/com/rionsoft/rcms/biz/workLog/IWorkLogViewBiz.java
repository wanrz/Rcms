/**
 *
 */
package com.rionsoft.rcms.biz.workLog;

import java.util.List;

import com.rionsoft.rcms.bo.user.UserInfoBo;
import com.rionsoft.rcms.bo.workLog.WorkLogBo;
import com.rionsoft.rcms.condition.workLog.WorkLogViewCondition;

/**
 * @author 刘教练
 * @date 2017年10月26日
 */
public interface IWorkLogViewBiz {
	/**
	 * 查看所管理的员工的日志
	 *
	 * @author 刘教练
	 * @date 2017年10月26日
	 * @param logViewCondition
	 * @return list
	 */
	List<WorkLogBo> queryWorkLogViewList(final WorkLogViewCondition logViewCondition);

	/**
	 * 通过部门项目查询自己管理的人员
	 *
	 * @author 刘教练
	 * @date 2017年11月2日
	 * @param userName
	 * @param pkProj
	 * @param dirId
	 * @return view
	 */
	List<UserInfoBo> userListByProjDirOperator(final String userName, final Long pkProj, final Long dirId);

	/**
	 * 通过项目Id和人员Id查询日志
	 *
	 * @author 刘教练
	 * @date 2017年11月2日
	 * @param userId
	 * @param pkProj
	 * @param dateId
	 * @return list
	 */
	List<WorkLogBo> workLogViewVisual(final Long pkProj, final Long userId, final long dateId);

}
