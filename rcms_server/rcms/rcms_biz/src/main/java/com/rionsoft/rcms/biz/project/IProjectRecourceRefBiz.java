/**
 *
 */
package com.rionsoft.rcms.biz.project;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.rionsoft.rcms.bo.project.ProjectRecourceRefBo;
import com.rionsoft.rcms.condition.project.ProjectRecourceRefCondition;
import com.rionsoft.rcms.condition.project.ProjectRecourceRefListEntry;
import com.rionsoft.rcms.condition.project.ProjectUserListEntry;

/**
 * @author linzhiqiang
 * @date 2017年4月25日
 */
public interface IProjectRecourceRefBiz {

	/**
	 * 查询项目列表
	 *
	 * @author linzhiqiang
	 * @date 2017年4月25日
	 * @param condition
	 * @param req
	 * @return view
	 */
	List<ProjectRecourceRefListEntry> projectRfeQuery(ProjectRecourceRefCondition condition, HttpServletRequest req);

	/**
	 * 查询已分配人员
	 *
	 * @author linzhiqiang
	 * @date 2017年4月26日
	 * @param condition
	 * @return view
	 */
	List<ProjectUserListEntry> projectUserQuery(ProjectRecourceRefCondition condition);

	/**
	 * 保存分配人员
	 *
	 * @author linzhiqiang
	 * @date 2017年4月27日
	 * @param refBoList
	 */
	void projectUserSave(List<ProjectRecourceRefBo> refBoList);

	/**
	 * 查询未分配人员
	 *
	 * @author linzhiqiang
	 * @date 2017年4月27日
	 * @param condition
	 * @return view
	 */
	List<ProjectUserListEntry> projectUserList(ProjectRecourceRefCondition condition);

	/**
	 * 删除已分配人员
	 *
	 * @author linzhiqiang
	 * @date 2017年4月27日
	 * @param userIdList
	 * @param pkProj
	 */
	void projectDeleteUser(List<Long> userIdList, long pkProj);

	/**
	 * 更改项目管理者
	 *
	 * @author 刘教练
	 * @date 2017年9月28日
	 * @param userId
	 * @param chargeProj
	 * @param pkProj
	 */
	void updateProjectRefUser(final Long userId, final String chargeProj, final Long pkProj);

	/**
	 * 查询该项目是否只有一位管理者
	 *
	 * @author linzhiqiang
	 * @date 2017年11月30日
	 * @param pkProj
	 * @param chargeProj
	 * @param userId
	 *
	 */
	void queryProjectRefCharge(final Long pkProj, final Long userId, final String chargeProj);
}
