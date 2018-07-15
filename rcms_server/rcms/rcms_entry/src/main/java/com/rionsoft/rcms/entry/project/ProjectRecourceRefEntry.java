/**
 *
 */
package com.rionsoft.rcms.entry.project;

import com.rionsoft.support.baseentry.BaseEntry;
import com.rionsoft.support.baseentry.annotation.EntryPk;
import com.rionsoft.support.baseentry.util.VarietyEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年4月25日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createTime = true, createUserId = true, updateTime = true, modifyUserId = true)
public class ProjectRecourceRefEntry extends BaseEntry {
	/** 项目主键 */
	@EntryPk
	private Long pkProj;
	/** 人员主键 */
	@EntryPk
	private Long userId;
	/** 是否项目管理 */
	private String chargeProj;

}
