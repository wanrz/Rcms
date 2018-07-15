/**
 *
 */
package com.rionsoft.rcms.condition.workLog;

import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author loujie
 * @data 2017年4月30日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class WorkLogCondition extends AbstractQueryCondition {
	/* 参与人员 */
	private long userId;
	/* 判断第几周 */
	private int dateId;
}
