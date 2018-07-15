/**
 *
 */
package com.rionsoft.rcms.bo.flow;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author 金浩宇
 * @date 2017年4月25日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjectFlowBo extends BaseBo {
	/** 项目主键 */
	private long pkProj;
	/** 项目编码 */
	private String projCode;
	/** 项目中文名称 */
	private String projName;
	/** 申请日期 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date applyDate;
	/*** 节点id ***/
	private String taskId;
	/**** 节点名称 ****/
	private String taskName;
	/*** 流程名称 **/
	private String processInstanceName;
	/****** 流程id ******/
	private String processInstanceId;
	/**** 节点key ***/
	private String taskKey;
}
