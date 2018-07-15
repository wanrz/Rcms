package com.rionsoft.rcms.bo.role;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author likeke
 * @date 2017年4月24日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AuthAttributeBo extends BaseBo {
	/**  */
	private long attributeId;
	/** 属性编码 */
	private String attributeCode;
	/** 菜单编码 */
	private String menuCode;
	/** 菜单名称 */
	private String menuName;
	/** 标题 */
	private String title;
	private Integer idx;
	/** 操作url */
	private String operationUrl;
	/** 操作类型 1:查询 2:编辑 */
	private Integer operationType;
}
