/**
 *
 */
package com.rionsoft.rcms.entry.department;

import com.rionsoft.support.baseentry.BaseEntry;
import com.rionsoft.support.baseentry.annotation.EntryPk;
import com.rionsoft.support.baseentry.util.VarietyEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author likeke
 * @date 2017年4月13日
 */
@Data
@EqualsAndHashCode(callSuper = false)
@VarietyEntry(createTime = true, createUserId = true, updateTime = true)
public class AuthDirEntry extends BaseEntry {
	/** 目录ID */
	@EntryPk
	private Long dirId;
	/** 父级目录ID */
	private Long parentId;
	/** 目录名称 */
	private String dirName;
	/** 目录编码 */
	private String dirCode;
	/** 邻接路径 */
	private String dirSeq;
	/** 序列码 */
	private String seq;
	/** 显示顺序 */
	private Integer idx;
	/** 邮箱 */
	private String email;
	/** 电话 */
	private String phone;
	/** 是否叶子节点 */
	private String isLeaf;
	/** 简介 */
	private String memo;
	/** 有效性 */
	private String state;
}
