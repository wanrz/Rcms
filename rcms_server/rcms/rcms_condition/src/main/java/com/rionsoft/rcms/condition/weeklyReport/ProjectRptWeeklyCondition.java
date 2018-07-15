/**
 *
 */
package com.rionsoft.rcms.condition.weeklyReport;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;
/**
 * @author 刘教练
 * @date 2017年10月17日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjectRptWeeklyCondition extends AbstractQueryCondition {
	/* 周报主键 */
	private Long proRptId;
	/* 项目主键 */
	private Long pkProj;
	/*操作人*/
	private Long userId;
	/* 周报开始日期 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date weekBeginDate;
	/* 周报结束日期 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date weekEndDate;
	/* 里程碑 */
	private String milePost;
	/* 本周事项汇报 */
	private String curRpt;
	/* 当前重要风险*/
	private String curRisk;
	/* 下周重要事项 */
	private String nextRpt;
	/* 周报状态 */
	private String status;
	/* 审批意见*/
	private String approvalOpinions;
	/*项目状态*/
	private String projectStatus;
	/*项目名称*/
	private String projName;
	/*项目编号*/
	private String projCode;
	/*部门名称*/
	private String deptName;
}
