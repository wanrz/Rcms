/**
 *
 */
package com.rionsoft.rcms.entry.task;

import java.math.BigDecimal;
import java.sql.Date;

import com.rionsoft.support.baseentry.BaseEntry;
import com.rionsoft.support.baseentry.annotation.EntryPk;
import com.rionsoft.support.baseentry.util.VarietyEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author loujie
 * @data 2017年4月25日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createTime = true, createUserId = true, updateTime = true, modifyUserId = true)
public class TaskUserRefEntry extends BaseEntry {

	@EntryPk
	/* 任务主键 */
	private Long pkTask;
	/* 参与员工 */
	private Long userId;
	/* 完成百分比 */
	private Long percentage;
	private BigDecimal requireWorkload;
	/* 实际完成日期 */
	private Date relEndDate;

}
