/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.prolevel;

import java.util.List;
import java.util.Set;

import com.rionsoft.rcms.condition.system.ProjectLevelDictCondition;
import com.rionsoft.rcms.entry.system.ProjectLevelDictEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.IWholeTableQuery;

/**
 * @author kongdeshuang
 * @date 2017年4月24日
 */
public interface IProjectLevelDictDao
		extends ISingleTableDao<ProjectLevelDictEntry>, IWholeTableQuery<ProjectLevelDictEntry> {

	/**
	 * 项目级别字典归档
	 *
	 * @author kongdeshuang
	 * @date 2017年4月21日
	 * @param entry
	 * @param columnNameSet
	 */
	void LevelFlagUpdate(final ProjectLevelDictEntry entry, final Set<String> columnNameSet);

	/**
	 * 根据查询条件查询字典
	 *
	 * @author kongdeshuang
	 * @param projectLevelDictCondition
	 * @date 2017年4月17日
	 * @return List<ProjectTypeDictEntry>
	 */
	List<ProjectLevelDictEntry> ProLevelDictByConditioinList(ProjectLevelDictCondition projectLevelDictCondition);

	/**
	 * 查询项目级别
	 *
	 * @author linzhiqiang
	 * @date 2017年4月28日
	 * @return list
	 */
	List<ProjectLevelDictEntry> queryLevel();

	/**
	 * 查询项目级别字典名称
	 *
	 * @author kongdeshuang
	 * @date 2017年5月12日
	 * @param levelName
	 * @return int
	 */
	int queryLevelName(String levelName);

	/**
	 * 项目级别批量修改封存、解封
	 *
	 * @author 刘教练
	 * @date 2017年9月8日
	 * @param levelIdList
	 * @param flag
	 */
	void updateProLevelDictListFlag(final List<Long> levelIdList, final String flag);

	/**
	 * 删除项目级别字典
	 *
	 * @author 刘教练
	 * @date 2017年9月13日
	 * @param levelId
	 * @return int
	 */
	int deleteLevelDictById(final String levelId);
}
