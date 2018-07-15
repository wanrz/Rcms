/**
 *
 */
package com.rionsoft.rcms.condition.task;

import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author loujie
 * @data 2017年4月25日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TaskUserRefCondition extends AbstractQueryCondition {
	/* 任务主键 */
	private long pkTask;
	/* 项目主键 */
	private long pkProj;
	/** 部门名称 */
	private String deptName;
	/** 人员名称 */
	private String userName;
}
