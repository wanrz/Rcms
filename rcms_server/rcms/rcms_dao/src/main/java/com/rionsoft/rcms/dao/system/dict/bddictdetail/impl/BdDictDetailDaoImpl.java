/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.bddictdetail.impl;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.system.BdDictDetailCondition;
import com.rionsoft.rcms.dao.system.dict.bddictdetail.IBdDictDetailDao;
import com.rionsoft.rcms.dao.system.dict.bddictdetail.IBdDictDetailMapper;
import com.rionsoft.rcms.entry.system.BdDictDetailEntry;
import com.rionsoft.support.mybatisplugin.dao.common.annotation.GenerateId;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author kongdeshuang
 * @date 2017年5月10日
 */
@Repository
@GenerateId(value = true)
class BdDictDetailDaoImpl extends SingleTableDao<BdDictDetailEntry> implements IBdDictDetailDao {
	@Autowired
	private IBdDictDetailMapper mapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.system.dict.bddictdetail.IBdDictDetailDao#
	 * FlagUpdate(com.rionsoft.rcms.entry.system.BdDictDetailEntry,
	 * java.util.Set)
	 */
	@Override
	public void FlagUpdate(final BdDictDetailEntry entry, final Set<String> columnNameSet) {
		super.updateColumns(entry, columnNameSet);

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.system.dict.bddictdetail.IBdDictDetailDao#
	 * queryBdDictList(com.rionsoft.rcms.condition.system.BdDictCondition)
	 */
	@Override
	public List<BdDictDetailEntry> queryBdDictList(final BdDictDetailCondition bdDictDetailCondition) {

		return mapper.queryBdDetailDictList(bdDictDetailCondition);
	}

}
