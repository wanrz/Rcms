/**
 *
 */
package com.rionsoft.rcms.bo.department;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年4月17日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AuthDirBo extends BaseBo {

	/** 目录ID */
	private Long dirId;
	/** 父级目录ID */
	private Long parentId;
	/** 目录名称 */
	private String dirName;
	/** 目录编码 */
	private String dirCode;
	/** 邻接路径 */
	private String dirSeq;
	/** 序列码 */
	private String seq;
	/** 显示顺序 */
	private Integer idx;
	/** 邮箱 */
	private String email;
	/** 电话 */
	private String phone;
	/** 是否叶子节点 */
	private String isLeaf;
	/** 简介 */
	private String memo;
	/** 有效性 */
	private String state;

}
