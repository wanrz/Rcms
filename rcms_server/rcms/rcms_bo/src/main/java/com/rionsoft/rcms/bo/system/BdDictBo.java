/**
 *
 */
package com.rionsoft.rcms.bo.system;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author kongdeshuang
 * @date 2017年5月10日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class BdDictBo extends BaseBo {

	/* 大 类主键 */
	private Long pkDict;
	/* 大类编码 */
	private String dictCode;
	/* 大类名称 */
	private String dictName;
	/* 封存标志 */
	private String flag;
}
