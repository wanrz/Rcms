/**
 *
 */
package com.rionsoft.rcms.web.admin.taskDemo;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rionsoft.rcms.biz.flow.IFlowBiz;
import com.rionsoft.rcms.bo.project.ProjectBo;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;

/**
 * @author 金浩宇
 * @date 2017年4月24日
 */
@Controller
@RequestMapping("admin/taskDemo")
public class TaskDemo extends BaseController {
	@Autowired
	private IFlowBiz flowBiz;

	/**
	 * 跳转代办任务
	 *
	 * @author 金浩宇
	 * @date 2017年4月24日
	 * @return view
	 */
	@RequestMapping(value = "taskToDo.do")
	public String toTask() {
		return getView("admin/flowDemo/taskToDo");
	}

	/**
	 * 查询代办任务
	 *
	 * @author 金浩宇
	 * @date 2017年4月24日
	 * @param model
	 * @return view
	 */
	@RequestMapping(value = "taskToDo.ajax")
	public String taskToDo(final Map<String, Object> model) {
		model.put("projList", flowBiz.queryProjectToDo());
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 审批通过完成流程
	 *
	 * @author 金浩宇
	 * @date 2017年4月25日
	 * @param pkProj
	 * @param key
	 * @param value
	 * @param taskId
	 * @return view
	 */
	@RequestMapping(value = "pass.ajax")
	public String pass(final Long pkProj, final String key, final boolean value, final String taskId) {
		flowBiz.pass(pkProj, key, value, taskId);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 审批拒绝
	 *
	 * @author 金浩宇
	 * @date 2017年4月25日
	 * @param pkProj
	 * @param key
	 * @param value
	 * @param taskId
	 * @return view
	 */
	@RequestMapping(value = "unpass.ajax")
	public String unpass(final Long pkProj, final String key, final boolean value, final String taskId) {
		flowBiz.unpass(pkProj, key, value, taskId);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 确认调整
	 *
	 * @author 金浩宇
	 * @param bo
	 * @date 2017年4月25日
	 * @param key
	 * @param value
	 * @param taskId
	 * @return view
	 */
	@RequestMapping(value = "adjust.ajax")
	public String adjust(final ProjectBo bo, final String key, final boolean value, final String taskId) {
		flowBiz.adjust(bo, key, value, taskId);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 拒绝调整
	 *
	 * @author 金浩宇
	 * @param bo
	 * @date 2017年4月25日
	 * @param key
	 * @param value
	 * @param taskId
	 * @return view
	 */
	@RequestMapping(value = "unadjust.ajax")
	public String unadjust(final ProjectBo bo, final String key, final boolean value, final String taskId) {
		flowBiz.unadjust(bo, key, value, taskId);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 任务追踪
	 *
	 * @author 金浩宇
	 * @param processInstanceId
	 * @param response
	 * @date 2017年4月25日
	 */
	@RequestMapping(value = "trace.ajax")
	public void trace(final String processInstanceId, final HttpServletResponse response) {
		flowBiz.traceFlow(processInstanceId, response);
	}
}
