/**
 *
 */
package com.rionsoft.rcms.condition.project;

import java.util.List;

import com.rionsoft.support.condition.IListEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年4月25日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjectRecourceRefListEntry implements IListEntry {
	/** 项目经理ID */
	private long pmId;
	/** 项目主键 */
	private long pkProj;
	/** 项目编码 */
	private String projCode;
	/** 项目名称 */
	private String projName;
	/** 人员参与 */
	private List<ProjectUserListEntry> userList;
	/** 项目经理名称 */
	private String pmName;
	/** 已分配人数 */
	private int number;

}
