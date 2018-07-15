/**
 *
 */
package com.rionsoft.rcms.condition.weeklyReport;

import java.sql.Date;
import java.sql.Timestamp;

import org.springframework.format.annotation.DateTimeFormat;

import com.rionsoft.support.condition.IListEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;
/**
 * @author 刘教练
 * @date 2017年10月10日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjectRptWeeklyListEntry implements IListEntry {
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
	/* 审批意见*/
	private String approvalOpinions;
	/* 建立时间 */
	private Timestamp createTime;
	/* 更新时间 */
	private Timestamp updateTime;
	/* 创建人 */
	private long createUserId;
	/* 创建人 */
	private String createUserName;
	/* 修改人 */
	private String modifyUserName;
	/* 审批人 */
	private String approvalUserName;
	/*审批时间*/
	private Timestamp approvalTime;
	/* 版本号 */
	private int version;
	/*项目名称*/
	private String projName;
	/*项目编号*/
	private String projCode;
}
