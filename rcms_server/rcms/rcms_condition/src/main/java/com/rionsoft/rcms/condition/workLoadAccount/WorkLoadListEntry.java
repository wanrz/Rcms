/**
 *
 */
package com.rionsoft.rcms.condition.workLoadAccount;

import com.rionsoft.support.condition.IListEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年5月2日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class WorkLoadListEntry implements IListEntry, Comparable<WorkLoadListEntry> {
	/** 项目主键 */
	private long pkProj;
	/** 年月 */
	private String yearMonth;
	/** 项目编码 */
	private String projCode;
	/** 项目名称 */
	private String projName;
	/** 人员名称 */
	private String userName;
	/** 正常工时 */
	private Double workTime;
	/** 加班工时 */
	private Double overWorkTime;
	/** 合计 */
	private Double count;

	// /** 项目小计 */
	// private int projCount;
	// /** 项目小计（人月） */
	// private BigDecimal projCountPerson;
	@Override
	public int compareTo(WorkLoadListEntry workLoadListEntry) {
		return (this.getPkProj() < workLoadListEntry.getPkProj() ? -1
				: (this.getPkProj() == workLoadListEntry.getPkProj() ? 0 : 1));
	}

}
