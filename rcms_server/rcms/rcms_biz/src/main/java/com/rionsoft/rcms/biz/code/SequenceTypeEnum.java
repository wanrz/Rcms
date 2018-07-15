/**
 *
 */
package com.rionsoft.rcms.biz.code;

import com.rionsoft.support.biz.sequence.ISequenceType;

/**
 * 自动生成编码配置
 *
 * @author likeke
 * @date 2017年4月20日
 */
public enum SequenceTypeEnum implements ISequenceType {

	/** 人员编号 **/
	USERCODE,
	/*** 部门序列 ***/
	DEPTSEQ,
	/*** 部门编号 ***/
	DEPTCODE,
	/*** 任务编号 ***/
	TASKCODE;
	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.support.biz.IEnumType#getEnumName()
	 */
	@Override
	public String getEnumName() {
		return this.name();
	}

}
