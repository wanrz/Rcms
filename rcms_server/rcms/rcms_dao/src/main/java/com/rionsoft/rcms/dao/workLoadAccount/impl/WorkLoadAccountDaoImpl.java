/**
 *
 */
package com.rionsoft.rcms.dao.workLoadAccount.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.workLoadAccount.WorkLoadCondition;
import com.rionsoft.rcms.condition.workLoadAccount.WorkLoadListEntry;
import com.rionsoft.rcms.dao.workLoadAccount.IWorkLoadAccountDao;
import com.rionsoft.rcms.dao.workLoadAccount.IWorkLoadAccountMapper;

/**
 * @author likeke
 * @date 2017年5月2日
 */
@Repository
class WorkLoadAccountDaoImpl implements IWorkLoadAccountDao {
	@Autowired
	private IWorkLoadAccountMapper workLoadAccount;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.workLoadAccount.WorkLoadAccountDao#
	 * workLoadQueryByMonth(com.rionsoft.rcms.condition.workLoadAccount.
	 * WorkLoadCondition)
	 */
	@Override
	public List<WorkLoadListEntry> workLoadQueryByMonth(final WorkLoadCondition condition) {

		return workLoadAccount.workLoadQueryByMonth(condition);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.rionsoft.rcms.dao.workLoadAccount.IWorkLoadAccountDao#
	 * queryWorkLoadByDataCode(com.rionsoft.rcms.condition.workLoadAccount.
	 * WorkLoadCondition)
	 */
	@Override
	public List<WorkLoadListEntry> queryWorkLoadByDataCode(WorkLoadCondition condition) {
		return workLoadAccount.queryWorkLoadByDataCode(condition);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.rionsoft.rcms.dao.workLoadAccount.IWorkLoadAccountDao#
	 * queryWorkAccountExprot()
	 */
	@Override
	public List<Map<String, Object>> queryWorkAccountExprot(WorkLoadCondition condition) {
		return workLoadAccount.queryWorkAccountExprot(condition);
	}

}
