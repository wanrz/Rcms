/**
 *
 */
package com.rionsoft.rcms.entry.system;

import com.rionsoft.support.baseentry.BaseEntry;
import com.rionsoft.support.baseentry.annotation.EntryPk;
import com.rionsoft.support.baseentry.annotation.VersionEntry;
import com.rionsoft.support.baseentry.util.VarietyEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author kongdeshuang
 * @date 2017年4月24日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createTime = true, createUserId = true, modifyUserId = true, updateTime = true)
@VersionEntry
public class ProjectUrgentDictEntry extends BaseEntry {

	/** 主键 */
	@EntryPk
	private long urgentId;
	/** 项目紧急程度 */
	private String urgentName;
	/** 封存标志 */
	private String flag;

}
