/**
 *
 */
package com.rionsoft.rcms.entry.role;

import com.rionsoft.support.baseentry.BaseEntry;
import com.rionsoft.support.baseentry.annotation.EntryPk;
import com.rionsoft.support.baseentry.util.VarietyEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 数据权限类型
 * 
 * @author likeke
 * @date 2017年4月15日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createUserId = true, createTime = true, updateTime = true)
public class AuthDataTypeEntry extends BaseEntry {
	/** 数据类型id */
	@EntryPk
	private long DataId;
	/** 数据类型名称 */
	private String DataName;
	/** 数据类型描述 */
	private String DataDesc;
	/** 数据类型编码 */
	private String DataCode;

}
