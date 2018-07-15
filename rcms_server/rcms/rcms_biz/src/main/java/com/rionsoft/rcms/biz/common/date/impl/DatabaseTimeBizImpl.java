package com.rionsoft.rcms.biz.common.date.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rionsoft.rcms.biz.common.date.IDatabaseTimeBiz;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.mybatisplugin.dao.common.core.ICommonDao;

/**
 * @author 刘教练
 * @date 2017年10月23日
 */
@Service
public class DatabaseTimeBizImpl extends BaseBiz implements IDatabaseTimeBiz {
	@Autowired
	private ICommonDao commondao;

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.common.date.IDatabaseTimeBiz#DatabaseCurrentTime()
	 */
	@Override
	public Date databaseCurrentTime() {
		return commondao.queryCurrentTime();
	}
}
