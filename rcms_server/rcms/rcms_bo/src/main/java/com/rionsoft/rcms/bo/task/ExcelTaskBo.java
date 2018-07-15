/**
 *
 */
package com.rionsoft.rcms.bo.task;

import com.rionsoft.support.basebo.common.file.ExcelBaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author loujie
 * @data 2017年4月26日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ExcelTaskBo extends ExcelBaseBo {
	/** 项目主键 */
	private Long pkProj;
	/** 项目名称（中文） */
	private String projName;
	/** 任务编码 */
	private String taskCode;
	/** 任务名称 */
	private String taskName;
	/** 计划开始日期 */
	private String expStartDate;
	/** 计划结束日期 */
	private String expEndDate;
	/** 工作量 */
	private String workload;
	/** 任务状态 */
	private String status;
	/** 任务类型 */
	private String taskType;

	@Override
	public void setValue(final int i, final String s) {
		switch (i) {
		case 0:
			this.setProjName(s);
			break;

		case 1:
			this.setTaskCode(s);
			break;

		case 2:
			this.setTaskName(s);
			break;

		case 3:
			this.setExpStartDate(s);
			break;

		case 4:
			this.setExpEndDate(s);
			break;

		case 5:
			this.setWorkload(s);
			break;

		case 6:
			this.setStatus(s);
			break;

		case 7:
			this.setTaskType(s);
			break;
		default:
			break;
		}
	}
}
