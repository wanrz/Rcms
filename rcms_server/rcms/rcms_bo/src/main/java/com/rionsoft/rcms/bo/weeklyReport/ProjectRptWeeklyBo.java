/**
 *
 */
package com.rionsoft.rcms.bo.weeklyReport;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import java.sql.Timestamp;


/**
 * @author 刘教练
 * @date 2017年9月30日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjectRptWeeklyBo extends BaseBo {
	/* 周报主键 */
	private Long proRptId;
	/* 项目主键 */
	private Long pkProj;
	/* 周报开始日期 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date weekBeginDate;
	/* 周报结束日期 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
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
	/*创建人*/
	private String createUserName;
	/* 审批意见*/
	private String approvalOpinions;
	/*审批人*/
	private Long  approvalUserId;
	/*审批人*/
	private String approvalUserName;
	/*审批时间*/
	private Timestamp approvalTime;
	/*项目名称*/
	private String projName;
	/*项目编号*/
	private String projCode;
	/*项目状态*/
	private String projStatus;
}
