/**
 *
 */
package com.rionsoft.rcms.entry.workLog;

import java.sql.Date;

import com.rionsoft.support.baseentry.BaseEntry;
import com.rionsoft.support.baseentry.annotation.EntryPk;
import com.rionsoft.support.baseentry.util.VarietyEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author loujie
 * @data 2017年4月30日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createTime = true, createUserId = true, updateTime = true, modifyUserId = true)
public class WorkLogEntry extends BaseEntry {

	@EntryPk
	/* 日志主键 */
	private Long pkWorkLog;
	/* 任务主键 */
	private Long pkTask;
	/* 参与员工 */
	private Long userId;
	/* 正常工时 */
	private Integer workTime;
	/* 加班工时 */
	private Integer overWorkTime;
	/*是否审核*/
	private String isVerfied;
	/* 加班缘由*/
	private String  overWorkReason;
	/* 工作内容描述 */
	private String workDesc;
	/* 完成百分比 */
	private Long percentage;
	/* 日志日期 */
	private Date logDate;
}
