/**
 *
 */
package com.rionsoft.rcms.condition.system;

import java.sql.Timestamp;

import com.rionsoft.support.condition.AbstractQueryCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author kongdeshuang
 * @date 2017年4月18日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjectTypeDictCondition extends AbstractQueryCondition {

	/** 主键 */
	private long typeId;
	/** 项目类型 */
	private String typeName;
	/** 版本号 */
	private long version;
	/** 创建人 */
	private long createUserId;
	/** 封存标志 */
	private String flag;
	/** 创建时间 */
	private Timestamp createTime;
	/** 更改时间 */
	private Timestamp updateTime;

	/** 项目类型编码 */
	private String typeCode;
}
