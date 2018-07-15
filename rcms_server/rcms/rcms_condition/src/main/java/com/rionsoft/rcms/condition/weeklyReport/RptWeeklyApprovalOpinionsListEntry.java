/**
 *
 */
package com.rionsoft.rcms.condition.weeklyReport;

import java.sql.Timestamp;

import com.rionsoft.support.condition.IListEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;
/**
 * @author 刘教练
 * @date 2017年10月11日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class RptWeeklyApprovalOpinionsListEntry implements IListEntry {
	/* 周报主键 */
	private Long proRptId;
	/* 审批意见*/
	private String approvalOpinions;
	/* 建立时间 */
	private Timestamp createTime;
	/* 创建人 */
	private String createUserName;
	/* 版本号 */
	private int version;
}
