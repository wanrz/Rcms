/**
 *
 */
package com.rionsoft.rcms.condition.system;

import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author kongdeshuang
 * @date 2017年5月10日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class BdDictCondition extends AbstractQueryCondition {

	/* 大 类主键 */
	private Long pkDict;
	/* 大类编码 */
	private String dictCode;
	/* 大类名称 */
	private String dictName;
	/* 封存标志 */
	private String flag;
}
