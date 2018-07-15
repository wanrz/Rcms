/**
 *
 */
package com.rionsoft.rcms.biz.code.strategy.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.support.incrementer.SqlServerMaxValueIncrementer;
import org.springframework.stereotype.Service;

import com.rionsoft.rcms.biz.code.SequenceTypeEnum;
import com.rionsoft.support.biz.sequence.ISequenceType;
import com.rionsoft.support.biz.sequence.strategy.ISequenceNoStrategy;
import com.rionsoft.support.biz.util.DatePattern;

/**
 * 生成人员编码
 *
 * @author likeke
 * @date 2017年4月20日
 */
@Service
public class UserSequenceBizImpl implements ISequenceNoStrategy {
	private static final int FORMAT_LEGNTH = 3;
	@Autowired
	@Qualifier("userInfoCodeSeq")
	private SqlServerMaxValueIncrementer userInfoCodeSeq;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.support.biz.common.strategy.IStrategy#getCondition()
	 */
	@Override
	public ISequenceType getCondition() {
		return SequenceTypeEnum.USERCODE;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.support.biz.sequence.strategy.ISequenceNoStrategy#
	 * getSequenceNo()
	 */
	@Override
	public String getSequenceNo() {
		final String currentDate = DatePattern.YYYYMMDD.format(new Date().getTime()).substring(2);
		final String sequenceNo = userInfoCodeSeq.nextStringValue();
		/** 序列并补充3位数字（0代表补充0，3代表总长度，d标识参数为正整型） */
		final String expendstrs = String.format("%0" + FORMAT_LEGNTH + "d", Integer.parseInt(sequenceNo));
		return "USER" + currentDate + expendstrs;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.support.biz.sequence.strategy.ISequenceNoStrategy#
	 * getSequenceNoBatch(int)
	 */
	@Override
	public List<String> getSequenceNoBatch(final int sequenceSize) {
		// TODO Auto-generated method stub
		return null;
	}

}
