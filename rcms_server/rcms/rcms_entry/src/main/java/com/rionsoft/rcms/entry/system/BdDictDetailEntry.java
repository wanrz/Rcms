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
 * @date 2017年5月10日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createTime = true, createUserId = true, modifyUserId = true, updateTime = true)
@VersionEntry
public class BdDictDetailEntry extends BaseEntry {
	/* 小类主键 */
	@EntryPk
	private Long pkDetail;
	/* 大 类主键 */
	private Long pkDict;
	/* 小类编码 */
	private String detailCode;
	/* 小类名称 */
	private String detailName;
	/* 封存标志 */
	private String flag;
}
