/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.bddict.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.system.BdDictCondition;
import com.rionsoft.rcms.dao.system.dict.bddict.IBdDictDao;
import com.rionsoft.rcms.dao.system.dict.bddict.IBdDictMapper;
import com.rionsoft.rcms.entry.system.BdDictEntry;
import com.rionsoft.support.mybatisplugin.dao.common.annotation.GenerateId;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author kongdeshuang
 * @date 2017年5月10日
 */
@Repository
@GenerateId(value = true)
class BdDictDaoImpl extends SingleTableDao<BdDictEntry> implements IBdDictDao {
	@Autowired
	private IBdDictMapper mapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.system.dict.bddict.IBdDictDao#queryBdDictList(com.
	 * rionsoft.rcms.condition.system.BdDictCondition)
	 */
	@Override
	public List<BdDictEntry> queryBdDictList(final BdDictCondition bdDictCondition) {

		return mapper.queryBdDictList(bdDictCondition);
	}

}
