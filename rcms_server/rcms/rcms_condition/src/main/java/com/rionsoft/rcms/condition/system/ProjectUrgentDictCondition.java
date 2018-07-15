/**
 *
 */
package com.rionsoft.rcms.condition.system;

import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author kongdeshuang
 * @date 2017年4月24日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjectUrgentDictCondition extends AbstractQueryCondition {
	/** 主键 */
	private long urgentId;
	/** 项目级别 */
	private String urgentName;
	/** 封存标志 */
	private String flag;
}
