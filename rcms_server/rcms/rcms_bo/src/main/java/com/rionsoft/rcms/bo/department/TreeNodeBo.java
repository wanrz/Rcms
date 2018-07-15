/**
 *
 */
package com.rionsoft.rcms.bo.department;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author likeke
 * @date 2017年4月13日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TreeNodeBo extends BaseBo {

	private boolean checked;
	private long dataId;
	private boolean isParent;
	private String name;
	private long parentId;
	private String dirSeq;

	/**
	 * @return { @link isParent}
	 */
	public boolean getIsParent() {
		return isParent;
	}
}
