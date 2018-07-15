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
 * @date 2017年4月24日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjectLevelDictBo extends BaseBo {
	/** 主键 */
	private Long levelId;
	/** 项目级别 */
	private String levelName;
	/** 封存标志 */
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
