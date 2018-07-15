/**
 *
 */
package com.rionsoft.rcms.bo.system;

import com.rionsoft.rcms.bo.constant.DictEnum;
import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author kongdeshuang
 * @date 2017年5月10日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class BdDictDetailBo extends BaseBo {
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
	@SuppressWarnings("unused")
	/** 封存标志枚举 */
	private String flagView;

	/**
	 * @author kongdeshuang
	 * @date 2017年4月25日
	 * @return String
	 */
	public String getFlagView() {

		return DictEnum.DictStatusEnum.getTypeName(this.flag);
	}

}
