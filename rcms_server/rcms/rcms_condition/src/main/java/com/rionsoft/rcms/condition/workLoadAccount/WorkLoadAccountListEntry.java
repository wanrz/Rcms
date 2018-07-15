/**
 *
 */
package com.rionsoft.rcms.condition.workLoadAccount;

import java.util.List;

import com.rionsoft.support.condition.IListEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年5月4日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class WorkLoadAccountListEntry implements IListEntry {
	private List<WorkLoadListEntry> loadListEntry;
	private String yearMonth;
	private long pkProj;
}
