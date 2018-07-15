/**
 *
 */
package com.rionsoft.rcms.bo.project;

import java.util.List;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年4月25日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjectRecourceRefBo extends BaseBo {
	/** 项目主键 */

	private Long pkProj;
	/** 人员主键 */

	private Long userId;
	/** 项目名称 */
	private String projName;
	/** 项目编码 */
	private String projCode;
	/** 项目经理 */
	private String deptId;
	/** 已分配资源 */
	private List<ProjectRecourceRefBo> recourceList;
	/** 是否项目管理 */
	private String chargeProj;
}
