/**
 *
 */
package com.rionsoft.rcms.biz.system.bddict.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rionsoft.rcms.biz.system.bddict.IBdDictBiz;
import com.rionsoft.rcms.bo.system.BdDictBo;
import com.rionsoft.rcms.condition.system.BdDictCondition;
import com.rionsoft.rcms.dao.system.dict.bddict.IBdDictDao;
import com.rionsoft.support.biz.BaseBiz;

/**
 * @author kongdeshuang
 * @date 2017年5月10日
 */
@Service
public class BdDictBizImpl extends BaseBiz implements IBdDictBiz {
	@Autowired
	private IBdDictDao bdDictDaoImpl;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.system.bddict.IBdDictBiz#queryDictList(com.rionsoft
	 * .rcms.condition.system.BdDictCondition)
	 */
	@Override
	public List<BdDictBo> queryDictList(final BdDictCondition bdDictCondition) {
		bdDictCondition.setFlag("1");
		return map(bdDictDaoImpl.queryBdDictList(bdDictCondition), BdDictBo.class);
	}

}
