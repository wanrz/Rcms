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
public class ProjectLevelDictCondition extends AbstractQueryCondition {
	/* 主键 */
	private Long levelId;
	/* 项目级别 */
	private String levelName;
	/* 封存标志 */
	private String flag;
}
