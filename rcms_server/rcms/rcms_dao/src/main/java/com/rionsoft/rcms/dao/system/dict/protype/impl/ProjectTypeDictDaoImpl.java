/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.protype.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.system.ProjectTypeDictCondition;
import com.rionsoft.rcms.dao.system.dict.protype.IProjectTypeDictDao;
import com.rionsoft.rcms.dao.system.dict.protype.IProjectTypeDictMapper;
import com.rionsoft.rcms.entry.system.ProjectTypeDictEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author kongdeshuang
 * @date 2017年4月18日
 */
@Repository
class ProjectTypeDictDaoImpl extends SingleTableDao<ProjectTypeDictEntry> implements IProjectTypeDictDao {
	@Autowired
	private IProjectTypeDictMapper projectTypeDictMapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.system.dict.IProjectTypeDictDao#
	 * ProTypeDictByConditioinList(com.rionsoft.rcms.condition.system.
	 * ProjectTypeDictCondition)
	 */
	@Override
	public List<ProjectTypeDictEntry> ProTypeDictByConditioinList(
			final ProjectTypeDictCondition projectTypeDictCondition) {
		return projectTypeDictMapper.ProTypeDictByConditioinList(projectTypeDictCondition);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.system.dict.IProjectTypeDictDao#flagUpdate(com.
	 * rionsoft.rcms.entry.system.ProjectTypeDictEntry, java.util.Set)
	 */
	@Override
	public void flagUpdate(final ProjectTypeDictEntry entry, final Set<String> columnNameSet) {
		super.updateColumns(entry, columnNameSet);
	}

	@Override
	public List<ProjectTypeDictEntry> queryProjectList() {
		return projectTypeDictMapper.queryProjectList();
	}

	@Override
	public List<ProjectTypeDictEntry> queryProjectChangeList() {
		return projectTypeDictMapper.queryProjectChangeList();
	}
	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.system.dict.protype.IProjectTypeDictDao#
	 * queryTypeCode()
	 */
	@Override
	public int queryTypeCode(final String typeCode) {
		final Map<String, Object> map = new HashMap<>();
		map.put("TYPE_CODE", typeCode);
		return super.queryCountByColumns(map);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.system.dict.protype.IProjectTypeDictDao#
	 * queryCodeCount(java.lang.String, long)
	 */
	@Override
	public int queryCodeCount(final ProjectTypeDictCondition projectTypeDictCondition) {
		return projectTypeDictMapper.queryCodeCount(projectTypeDictCondition);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.system.dict.protype.IProjectTypeDictDao#updateDictListFlag(java.util.List, java.lang.String)
	 */
	@Override
	public void updateTypeIdListFlag(List<Long> typeIdList, String flag) {
		projectTypeDictMapper.updateTypeIdListFlag(typeIdList, flag);
	}

	@Override
	public int deleteTypeDictById(String typeCode) {
		return projectTypeDictMapper.deleteTypeDictById(typeCode);
	}

	
}
