package com.rionsoft.rcms.entry.role;

import com.rionsoft.support.baseentry.BaseEntry;
import com.rionsoft.support.baseentry.annotation.EntryPk;
import com.rionsoft.support.baseentry.util.VarietyEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author <a href="1254046525@qq.com">likeke <a>
 * @date 2017-04-24
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createTime = true, createUserId = true, updateTime = true)
public class RoleDataTypeEntry extends BaseEntry {
	@EntryPk
	private Long dataId;

	private String dataName;

	private String dataDesc;

	private String dataCode;
}
