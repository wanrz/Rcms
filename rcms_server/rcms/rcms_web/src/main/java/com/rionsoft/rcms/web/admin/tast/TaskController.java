/**
 *
 */
package com.rionsoft.rcms.web.admin.tast;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rionsoft.rcms.biz.code.SequenceTypeEnum;
import com.rionsoft.rcms.biz.project.IProjectBiz;
import com.rionsoft.rcms.biz.task.ITaskBiz;
import com.rionsoft.rcms.biz.task.ITaskImportBiz;
import com.rionsoft.rcms.bo.constant.TaskStatusEnum;
import com.rionsoft.rcms.bo.task.TaskBo;
import com.rionsoft.rcms.bo.task.TaskUserRefBo;
import com.rionsoft.rcms.condition.project.ProjectCondition;
import com.rionsoft.rcms.condition.task.TaskCondition;
import com.rionsoft.rcms.condition.task.TaskUserRefCondition;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.file.FileUploadBo;
import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.biz.sequence.IManageSequenceBiz;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

import net.sf.json.JSONArray;

/**
 * @author loujie
 * @data 2017年4月25日
 */
@Controller
@RequestMapping("/admin/task")
public class TaskController extends BaseController {

	@Autowired
	private ITaskBiz taskBiz;
	@Autowired
	private IProjectBiz projectBiz;
	@Autowired
	private ITaskImportBiz importBiz;
	@Autowired
	private IManageSequenceBiz manageSequenceBiz;

	/**
	 * 跳转到任务界面
	 *
	 * @author loujie
	 * @param model
	 * @data 2017年4月25日
	 * @return view
	 */
	@RequestMapping("/taskManage.do")
	public String task(final Map<String, Object> model) {
		model.put("taskStatus", TaskStatusEnum.values());
		return getView("admin/task/taskManage");
	}

	/**
	 * 查询任务列表
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param model
	 * @param condition
	 * @param req
	 * @return json
	 */
	@RequestMapping("/queryTask.ajax")
	public String queryTask(final Map<String, Object> model, final TaskCondition condition,
			final HttpServletRequest req) {
		final long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		condition.setUserId(userId);
		model.put("taskList", taskBiz.queryByCondition(condition, req));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 跳转到任务新增界面
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param model
	 * @param req
	 * @return view
	 */
	@RequestMapping("/addTask.do")
	public String addTask(final Map<String, Object> model, final HttpServletRequest req) {
		final ProjectCondition projectCondition = new ProjectCondition();
		projectCondition.setStatus("15");
		model.put("projectList", projectBiz.queryProjectByProjOperator(projectCondition, req));
		model.put("taskCodeSeq", manageSequenceBiz.getSequenceNo(SequenceTypeEnum.TASKCODE.getEnumName()));
		return getView("admin/task/taskAdd");
	}

	/**
	 * 新增任务
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param taskBo
	 * @return json
	 */
	@RequestMapping("/taskAdd.ajax")
	public String saveTask(final TaskBo taskBo) {
		taskBiz.addTask(taskBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 根据pkTask查询任务详情并跳转到修改界面
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param model
	 * @param pkTask
	 * @param req
	 * @return view
	 */
	@RequestMapping("/updateTask.do")
	public String update(final Map<String, Object> model, final long pkTask, final HttpServletRequest req) {
		model.put("task", taskBiz.queryTaskById(pkTask));
		final ProjectCondition condition = new ProjectCondition();
		model.put("projectList", projectBiz.projectChangeQuery(condition, req));
		return getView("admin/task/taskUpdate");
	}

	/**
	 * 修改任务
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param taskBo
	 * @return json
	 */
	@RequestMapping("/taskUpdate.ajax")
	public String updateTask(final TaskBo taskBo) {
		taskBiz.updateTask(taskBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 任务解封
	 *
	 * @author 刘教练
	 * @date 2017年10月18日
	 * @param pkTask
	 * @param status
	 * @return json
	 */
	@RequestMapping("/devanningTask.ajax")
	public String devanningTask(final long pkTask, final String status) {
		taskBiz.updateStatus(pkTask, status);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 任务封存
	 *
	 * @author 刘教练
	 * @date 2017年10月18日
	 * @param pkTask
	 * @param status
	 * @return json
	 */
	@RequestMapping("/binningTask.ajax")
	public String binningTask(final long pkTask, final String status) {
		taskBiz.updateStatus(pkTask, status);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 任务强制完成
	 *
	 * @author 刘教练
	 * @date 2017年10月18日
	 * @param pkTask
	 * @param status
	 * @return json
	 */
	@RequestMapping("/forcibleExecutionTask.ajax")
	public String forcibleExecutionTask(final long pkTask, final String status) {
		taskBiz.updateStatus(pkTask, status);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 删除任务
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param pkTaskList
	 * @return json
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/deleteTask.ajax")
	public String deleteTask(final String pkTaskList) {
		final JSONArray a = JSONArray.fromObject(pkTaskList);
		final List<Long> pkList = (List<Long>) JSONArray.toCollection(a);
		taskBiz.deleteTask(pkList);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 跳转到分配任务页面
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param model
	 * @param pkTask
	 * @param projName
	 * @param workload
	 * @param pkProj
	 * @param queryStatus
	 * @return view
	 */
	@RequestMapping("/addUser.do")
	public String taskUser(final Map<String, Object> model, final long pkTask, final String projName,
			final BigDecimal workload, final long pkProj, final String queryStatus) {
		model.put("pkTask", pkTask);
		model.put("projName", projName);
		model.put("workload", workload);
		model.put("pkProj", pkProj);
		model.put("queryStatus", queryStatus);
		return getView("admin/task/taskUser");
	}

	/**
	 * 查询已分配任务的人员
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param model
	 * @param condition
	 * @return json
	 */
	@RequestMapping("/queryUserRef.ajax")
	public String queryRefByCondition(final Map<String, Object> model, final TaskUserRefCondition condition) {
		model.put("userRefList", taskBiz.queryRefByCondition(condition));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 删除分配人员
	 *
	 * @author loujie
	 * @data 2017年4月25日
	 * @param userIdList
	 * @param pkTask
	 * @return json
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/deleteUser.ajax")
	public String deleteUser(final String userIdList, final long pkTask) {
		final JSONArray a = JSONArray.fromObject(userIdList);
		final List<Long> userList = (List<Long>) JSONArray.toCollection(a);
		taskBiz.deleteUser(userList, pkTask);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 查询用户信息
	 *
	 * @author kongdeshuang
	 * @date 2017年4月26日
	 * @param model
	 * @param condition
	 * @return String
	 */
	@RequestMapping("/queryUserInfo.ajax")
	public String queryUserInfoByCondition(final Map<String, Object> model, final TaskUserRefCondition condition) {
		model.put("userInfoList", taskBiz.queryUserInfoByCondition(condition));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 跳转到任务导入界面
	 *
	 * @author loujie
	 * @data 2017年4月26日
	 * @return view
	 */
	@RequestMapping("/improtTask.do")
	public String taskImport() {
		return getView("admin/task/taskImport");
	}

	/**
	 * 任务导入
	 *
	 * @author loujie
	 * @data 2017年4月26日
	 * @param model
	 * @return json
	 */
	@RequestMapping("improtTask.ajax")
	public String importTask(final Model model) {
		final Map<String, FileUploadBo> uploadFileMap = SessionLocal.getSessionLocal(SessionLocalEnum.UPLOAD_FILE);
		final FileUploadBo fileUploadBo = uploadFileMap.get("importTask");
		Assert.notNull(fileUploadBo, "上传文件为空!");
		Assert.isTrue(fileUploadBo.getFileSize() > 0, "上传文件为空!");
		model.addAttribute("successMessag", taskBiz.userExcel(fileUploadBo));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 分配人员
	 *
	 * @author loujie
	 * @data 2017年4月27日
	 * @param userIdList
	 * @return json
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("addUser.ajax")
	public String addUser(final String userIdList) {
		final JSONArray a = JSONArray.fromObject(userIdList);
		final List<TaskUserRefBo> boList = (List<TaskUserRefBo>) JSONArray.toCollection(a, TaskUserRefBo.class);
		importBiz.addUser(boList);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 分配人员
	 *
	 * @author loujie
	 * @data 2017年4月27日
	 * @return json
	 */
	@RequestMapping("/taskDetails.do")
	public String queryDetailsByTaskCode() {
		return getView("admin/task/taskDetails");
	}

}
