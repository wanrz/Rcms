/**
 *
 */
package com.rionsoft.rcms.bo.project;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年4月19日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjectBo extends BaseBo {

	/** 项目主键 */
	private Long pkProj;
	/** 项目编码 */
	private String projCode;
	/** 项目中文名称 */
	private String projName;
	/** 项目英文名称 */
	private String projShName;
	/** 项目类型 */
	private String projType;
	private String typeName;
	/** 项目级别 */
	private Integer projLevel;
	private String levelName;
	/** 项目状态 */
	private String status;
	/** 申请日期 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date applyDate;
	/** 申请部门 */
	private Integer deptId;
	/** 预算出处 */
	private String budgetSource;
	/** 预计销售金额 */
	private BigDecimal expSaleAmount;
	/** 项目计划开始时间 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date expStartDate;
	/** 项目计划结束时间 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date expEndDate;
	/** 项目实际开始时间 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date relStartDate;
	/** 项目实际结束时间 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date relEndDate;
	/** 项目经理 */
	private Integer pmId;
	/** 项目规模 */
	private Integer remark;
	/** 项目紧急程度 */
	private Integer urgentLevel;
	private String urgentName;
	/** 工作量估算 */
	private BigDecimal workload;
	/** 成本估算 */
	private BigDecimal expCost;
	/** 项目目标 */
	private String projectExp;
	/** 交付物 */
	private String deliveryDesc;
	/** 可行性验证情况 */
	private String feasibilityReport;
	/** 采用技术 */
	private String includeTech;
	/** 主要风险描述 */
	private String riskDesc;
	/** 客户名称 */
	private String clientNames;
	/** 项目描述 */
	private String projDesc;
	/** 结项日期 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date projEndDate;
	/** 项目结项说明 */
	private String projEndDesc;
	/** 结项负责人 */
	private String chargeMan;
	/** 部门名称 */
	private String dirName;
	/** 修改人 */
	private String modifyUserName;
	/** 项目经理 */
	private String pmName;
	/** 商务负责人 */
	private Long busId;
	private String busName;
}
