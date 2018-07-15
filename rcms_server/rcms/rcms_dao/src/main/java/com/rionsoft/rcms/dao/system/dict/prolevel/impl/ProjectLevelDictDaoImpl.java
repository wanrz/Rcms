/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.prolevel.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.system.ProjectLevelDictCondition;
import com.rionsoft.rcms.dao.system.dict.prolevel.IProjectLevelDictDao;
import com.rionsoft.rcms.dao.system.dict.prolevel.IProjectLevelDictMapper;
import com.rionsoft.rcms.entry.system.ProjectLevelDictEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author kongdeshuang
 * @date 2017年4月24日
 */
@Repository
class ProjectLevelDictDaoImpl extends SingleTableDao<ProjectLevelDictEntry> implements IProjectLevelDictDao {

	@Autowired
	private IProjectLevelDictMapper projectLevelDictMapper;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.system.dict.prolevel.IProjectLevelDictDao#
	 * LevelFlagUpdate(com.rionsoft.rcms.entry.system.ProjectLevelDictEntry,
	 * java.util.Set)
	 */
	@Override
	public void LevelFlagUpdate(final ProjectLevelDictEntry entry, final Set<String> columnNameSet) {
		super.updateColumns(entry, columnNameSet);

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.system.dict.prolevel.IProjectLevelDictDao#
	 * ProLevelDictByConditioinList(com.rionsoft.rcms.condition.system.
	 * ProjectLevelDictCondition)
	 */
	@Override
	public List<ProjectLevelDictEntry> ProLevelDictByConditioinList(
			final ProjectLevelDictCondition projectLevelDictCondition) {

		return projectLevelDictMapper.ProLevelDictByConditioinList(projectLevelDictCondition);
	}

	@Override
	public List<ProjectLevelDictEntry> queryLevel() {
		return projectLevelDictMapper.queryLevel();
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.system.dict.prolevel.IProjectLevelDictDao#
	 * queryTypeCode(java.lang.String)
	 */
	@Override
	public int queryLevelName(final String levelName) {
		final Map<String, Object> map = new HashMap<>();
		map.put("LEVEL_NAME", levelName);
		return super.queryCountByColumns(map);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.system.dict.prolevel.IProjectLevelDictDao#updateProLevelDictListFlag(java.util.List, java.lang.String)
	 */
	@Override
	public void updateProLevelDictListFlag(List<Long> levelIdList, String flag) {
		projectLevelDictMapper.updateProLevelDictListFlag(levelIdList, flag);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.system.dict.prolevel.IProjectLevelDictDao#deleteLevelDictById(java.lang.String)
	 */
	@Override
	public int deleteLevelDictById(String levelId) {
		return projectLevelDictMapper.deleteLevelDictById(levelId);
	}

}
