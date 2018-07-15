/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.prourgent.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.system.ProjectUrgentDictCondition;
import com.rionsoft.rcms.dao.system.dict.prourgent.IProjectUrgentDictDao;
import com.rionsoft.rcms.dao.system.dict.prourgent.IProjectUrgentDictMapper;
import com.rionsoft.rcms.entry.system.ProjectUrgentDictEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author kongdeshuang
 * @date 2017年4月24日
 */
@Repository
class ProjectUrgentDictImpl extends SingleTableDao<ProjectUrgentDictEntry> implements IProjectUrgentDictDao {
	@Autowired
	private IProjectUrgentDictMapper ProjectUrgentDictMapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.system.dict.prourgent.IProjectUrgentDictDao#
	 * queryProUrgentDictList(com.rionsoft.rcms.condition.system.
	 * ProjectUrgentDictCondition)
	 */
	@Override
	public List<ProjectUrgentDictEntry> queryProUrgentDictList(
			final ProjectUrgentDictCondition projectUrgentDictCondition) {

		return ProjectUrgentDictMapper.queryProUrgentDictList(projectUrgentDictCondition);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.system.dict.prourgent.IProjectUrgentDictDao#
	 * urgentDictFlagUpdate(com.rionsoft.rcms.condition.system.
	 * ProjectUrgentDictCondition, java.util.Set)
	 */
	@Override
	public void urgentDictFlagUpdate(final ProjectUrgentDictEntry entry, final Set<String> columnNameSet) {
		super.updateColumns(entry, columnNameSet);

	}

	@Override
	public List<ProjectUrgentDictEntry> queryUrgent() {
		return ProjectUrgentDictMapper.queryUrgent();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.rionsoft.rcms.dao.system.dict.prourgent.IProjectUrgentDictDao#
	 * queryUrgentName(java.lang.String)
	 */
	@Override
	public int queryUrgentName(final String urgentName) {
		final Map<String, Object> map = new HashMap<>();
		map.put("URGENT_NAME", urgentName);
		return super.queryCountByColumns(map);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.system.dict.prourgent.IProjectUrgentDictDao#updateUrgentDictListFlag(java.util.List, java.lang.String)
	 */
	@Override
	public void updateUrgentDictListFlag(List<Long> urgentIdList, String flag) {
		ProjectUrgentDictMapper.updateUrgentDictListFlag(urgentIdList, flag);
	}

	@Override
	public int deleteUrgentDictById(String urgentId) {
		return ProjectUrgentDictMapper.deleteUrgentDictById(urgentId);
	}

}
