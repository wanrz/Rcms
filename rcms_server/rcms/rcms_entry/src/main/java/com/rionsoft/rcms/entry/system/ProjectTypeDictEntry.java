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
 * @date 2017年4月18日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createTime = true, createUserId = true, modifyUserId = true, updateTime = true)
@VersionEntry
public class ProjectTypeDictEntry extends BaseEntry {
	/** 主键 */
	@EntryPk
	private long typeId;

	/** 项目类型 */
	private String typeName;

	/** 封存标志 */
	private String flag;

	/** 项目类型编码 */
	private String typeCode;

}
