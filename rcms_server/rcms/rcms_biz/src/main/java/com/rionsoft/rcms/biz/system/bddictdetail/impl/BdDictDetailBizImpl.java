/**
 *
 */
package com.rionsoft.rcms.biz.system.bddictdetail.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rionsoft.rcms.biz.system.bddictdetail.IBdDictDetailBiz;
import com.rionsoft.rcms.bo.system.BdDictDetailBo;
import com.rionsoft.rcms.condition.system.BdDictDetailCondition;
import com.rionsoft.rcms.dao.system.dict.bddictdetail.IBdDictDetailDao;
import com.rionsoft.rcms.entry.system.BdDictDetailEntry;
import com.rionsoft.support.biz.BaseBiz;

/**
 * @author kongdeshuang
 * @date 2017年5月10日
 */
@Service
public class BdDictDetailBizImpl extends BaseBiz implements IBdDictDetailBiz {
	@Autowired
	private IBdDictDetailDao bdDictDetailDaoImpl;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.system.bddictdetail.IBdDictDetailBiz#
	 * queryBdDictDetail(com.rionsoft.rcms.condition.system.
	 * BdDictDetailCondition)
	 */
	@Override
	public List<BdDictDetailBo> queryBdDictDetail(final BdDictDetailCondition bdDictDetailCondition) {

		return map(bdDictDetailDaoImpl.queryBdDictList(bdDictDetailCondition), BdDictDetailBo.class);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.system.bddictdetail.IBdDictDetailBiz#
	 * updateDbDictDetail(com.rionsoft.rcms.bo.system.BdDictDetailBo)
	 */
	@Override
	public void updateDbDictDetail(final BdDictDetailBo bdDictDetailBo) {
		bdDictDetailDaoImpl.update(map(bdDictDetailBo, BdDictDetailEntry.class));

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.system.bddictdetail.IBdDictDetailBiz#updateDictFlag
	 * (java.lang.Long)
	 */
	@Override
	public void updateDictFlag(final Long pkDetail) {
		final BdDictDetailEntry detailEntry = new BdDictDetailEntry();
		final Set<String> dictEntrySet = new HashSet<String>();
		detailEntry.setFlag("0");
		detailEntry.setPkDetail(pkDetail);
		dictEntrySet.add("FLAG");
		bdDictDetailDaoImpl.FlagUpdate(detailEntry, dictEntrySet);

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.system.bddictdetail.IBdDictDetailBiz#
	 * bdDictDetailAdd(com.rionsoft.rcms.bo.system.BdDictDetailBo)
	 */
	@Override
	public void bdDictDetailAdd(final BdDictDetailBo bdDictDetailBo) {
		bdDictDetailBo.setFlag("1");
		bdDictDetailDaoImpl.insert(map(bdDictDetailBo, BdDictDetailEntry.class));

	}

}
