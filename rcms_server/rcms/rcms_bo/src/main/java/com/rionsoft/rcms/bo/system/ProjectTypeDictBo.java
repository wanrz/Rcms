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
 * @date 2017年4月19日
 */
@Data
@EqualsAndHashCode(callSuper = false)

public class ProjectTypeDictBo extends BaseBo {
	/** 字典主键 */
	private Long typeId;
	/** 类型 */
	private String typeName;
	/** 封存标志 */
	private String flag;
	/** 项目类型编码 */
	private String typeCode;

	@SuppressWarnings("unused")
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
