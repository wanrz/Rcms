/**
 *
 */
package com.rionsoft.rcms.condition.listentry;

import com.rionsoft.support.condition.IListEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author likeke
 * @date 2017年4月17日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TreeNodeListEntry implements IListEntry {
	private boolean checked;
	private long dataId;
	private boolean isParent;
	private String name;
	private long parentId;
	private String dirSeq;
}
