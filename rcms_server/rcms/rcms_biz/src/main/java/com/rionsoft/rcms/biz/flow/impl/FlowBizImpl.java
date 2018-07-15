/**
 *
 */
package com.rionsoft.rcms.biz.flow.impl;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.IdentityService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.activiti.image.ProcessDiagramGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rionsoft.rcms.biz.flow.IFlowBiz;
import com.rionsoft.rcms.bo.flow.ProjectFlowBo;
import com.rionsoft.rcms.bo.project.ProjectBo;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

import lombok.SneakyThrows;

/**
 * @author 金浩宇
 * @date 2017年4月24日
 */
@Service
public class FlowBizImpl extends BaseBiz implements IFlowBiz {

	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private IdentityService identityService;
	@Autowired
	private RepositoryService repositoryService;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.flow.IFlowBiz#startWorkflow(java.lang.Long,
	 * java.lang.String, java.util.Map)
	 */
	@Override
	@Transactional
	public ProcessInstance startWorkflow(final Long businessKey, final String flowKey) {

		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		/**** 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中 ****/
		identityService.setAuthenticatedUserId(userId.toString());
		/**** 启动流程 ***/
		return runtimeService.startProcessInstanceByKey(flowKey, businessKey.toString());
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.flow.IFlowBiz#queryProjectToDo(java.lang.Long)
	 */
	@Override
	public List<ProjectFlowBo> queryProjectToDo() {
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		final List<ProjectFlowBo> list = new ArrayList<>();

		/*** 根据当前人的ID查询代办任务 **/
		final TaskQuery taskQuery = taskService.createTaskQuery().taskCandidateOrAssigned(userId.toString());
		final List<Task> tasks = taskQuery.list();
		final ProjectFlowBo bo = new ProjectFlowBo();
		for (final Task task : tasks) {
			final String processInstanceId = task.getProcessInstanceId();

			final ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
					.processInstanceId(processInstanceId).active().singleResult();
			if (processInstance == null) {
				continue;
			}
			final String businessKey = processInstance.getBusinessKey();
			if (businessKey == null) {
				continue;
			}
			bo.setTaskKey(task.getTaskDefinitionKey());
			bo.setPkProj(Long.parseLong(businessKey));
			bo.setTaskId(task.getId());
			bo.setTaskName(task.getName());
			bo.setProcessInstanceId(processInstance.getId());
			bo.setProcessInstanceName(processInstance.getProcessDefinitionName());
			list.add(bo);
		}
		return list;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.flow.IFlowBiz#pass(java.lang.Long,
	 * java.lang.String, boolean, java.lang.String)
	 */
	@Override
	@Transactional
	public void pass(final Long pkProj, final String key, final boolean value, final String taskId) {
		/***** 完成流程 ****/
		final Map<String, Object> map = new HashMap<>();
		map.put(key, value);
		taskService.complete(taskId, map);
		// TODO 此处增加项目变更状态代码
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.flow.IFlowBiz#unpass(java.lang.Long,
	 * java.lang.String, boolean, java.lang.String)
	 */
	@Override
	public void unpass(final Long pkProj, final String key, final boolean value, final String taskId) {

		final Map<String, Object> map = new HashMap<>();
		map.put(key, value);
		taskService.complete(taskId, map);
		// TODO 此处增加项目变更状态代码
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.flow.IFlowBiz#adjust(com.rionsoft.rcms.bo.project.
	 * ProjectBo, java.lang.String, boolean, java.lang.String)
	 */
	@Override
	@Transactional
	public void adjust(final ProjectBo bo, final String key, final boolean value, final String taskId) {
		final Map<String, Object> map = new HashMap<>();
		map.put(key, value);
		taskService.complete(taskId, map);
		// TODO 加上项目变更代码
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.flow.IFlowBiz#unadjust(java.lang.String,
	 * boolean, java.lang.String)
	 */
	@Override
	@Transactional
	public void unadjust(final ProjectBo bo, final String key, final boolean value, final String taskId) {

		final Map<String, Object> map = new HashMap<>();
		map.put(key, value);
		taskService.complete(taskId, map);
		// TODO 加上项目删除代码
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.flow.IFlowBiz#traceFlow(java.lang.String)
	 */
	@SneakyThrows(IOException.class)
	@Override
	public void traceFlow(final String processInstanceId, final HttpServletResponse response) {
		// 1.创建核心引擎流程对象processEngine
		final ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();

		final Task task = taskService.createTaskQuery().processInstanceId(processInstanceId).singleResult();
		// 流程定义
		final BpmnModel bpmnModel = repositoryService.getBpmnModel(task.getProcessDefinitionId());

		// 正在活动节点
		final List<String> activeActivityIds = runtimeService.getActiveActivityIds(task.getExecutionId());

		final ProcessDiagramGenerator pdg = processEngine.getProcessEngineConfiguration().getProcessDiagramGenerator();
		// 生成流图片
		final InputStream inputStream = pdg.generateDiagram(bpmnModel, "PNG", activeActivityIds, activeActivityIds,
				processEngine.getProcessEngineConfiguration().getActivityFontName(),
				processEngine.getProcessEngineConfiguration().getLabelFontName(),
				processEngine.getProcessEngineConfiguration().getActivityFontName(),
				processEngine.getProcessEngineConfiguration().getProcessEngineConfiguration().getClassLoader(), 1.0);
		final byte[] b = new byte[1024];
		int len = -1;
		while ((len = inputStream.read(b, 0, 1024)) != -1) {
			response.getOutputStream().write(b, 0, len);
		}
		inputStream.close();

	}

}
