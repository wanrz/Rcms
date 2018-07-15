/**
 *
 */
package com.rionsoft.rcms.biz.flow;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.runtime.ProcessInstance;

import com.rionsoft.rcms.bo.flow.ProjectFlowBo;
import com.rionsoft.rcms.bo.project.ProjectBo;

/**
 * @author 金浩宇
 * @date 2017年4月24日
 */
public interface IFlowBiz {
	/**
	 * 启动流程
	 *
	 * @author 金浩宇
	 * @date 2017年4月24日
	 * @param businessKey
	 *            业务ID
	 * @param flowKey
	 *            流程的key
	 * @return 流程实体（可供后续操作）
	 */
	ProcessInstance startWorkflow(Long businessKey, String flowKey);

	/**
	 * 查询待审批的项目计划
	 *
	 * @author 金浩宇
	 * @date 2017年4月24日
	 * @return List<ProjectBo>
	 */
	List<ProjectFlowBo> queryProjectToDo();

	/**
	 * 审批通过 完成流程
	 *
	 * @author 金浩宇
	 * @date 2017年4月25日
	 * @param pkProj
	 * @param key
	 * @param value
	 * @param taskId
	 */
	void pass(Long pkProj, String key, boolean value, String taskId);

	/**
	 * 审批拒绝 继续流程
	 *
	 * @author 金浩宇
	 * @date 2017年4月25日
	 * @param pkProj
	 * @param key
	 * @param value
	 * @param taskId
	 */
	void unpass(Long pkProj, String key, boolean value, String taskId);

	/**
	 * 确认调整
	 *
	 * @author 金浩宇
	 * @param bo
	 * @date 2017年4月25日
	 * @param key
	 * @param value
	 * @param taskId
	 */
	void adjust(ProjectBo bo, String key, boolean value, String taskId);

	/**
	 * 拒绝调整
	 *
	 * @author 金浩宇
	 * @date 2017年4月25日
	 * @param bo
	 * @param key
	 * @param value
	 * @param taskId
	 */
	void unadjust(ProjectBo bo, String key, boolean value, String taskId);

	/**
	 * 流程跟踪
	 *
	 * @author 金浩宇
	 * @date 2017年4月26日
	 * @param processInstanceId
	 * @param response
	 */
	void traceFlow(String processInstanceId, HttpServletResponse response);
}
