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
public class BdDictDetailCondition extends AbstractQueryCondition {
	/* 小类主键 */
	private Long pkDetail;
	/* 大 类主键 */
	private Long pkDict;
	/* 小类编码 */
	private String detailCode;
	/* 小类名称 */
	private String detailName;
	/* 封存标志 */
	private String flag;
}
