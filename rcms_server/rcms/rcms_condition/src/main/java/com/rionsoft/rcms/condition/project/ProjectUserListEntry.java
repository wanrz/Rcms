/**
 *
 */
package com.rionsoft.rcms.condition.project;

import com.rionsoft.support.condition.IListEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年4月25日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjectUserListEntry implements IListEntry {
	/** 人员id */
	private long userId;
	/** 人员名称 */
	private String userName;
	/** 部门名称 */
	private String dirName;
	/** 是否项目管理 */
	private String chargeProj;
}
