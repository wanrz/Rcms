/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.prourgent;

import java.util.List;
import java.util.Set;

import com.rionsoft.rcms.condition.system.ProjectUrgentDictCondition;
import com.rionsoft.rcms.entry.system.ProjectUrgentDictEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.IWholeTableQuery;

/**
 * @author kongdeshuang
 * @date 2017年4月24日
 */
public interface IProjectUrgentDictDao
		extends ISingleTableDao<ProjectUrgentDictEntry>, IWholeTableQuery<ProjectUrgentDictEntry> {
	/**
	 * 根据查询条件查询紧急程度字典
	 *
	 * @author kongdeshuang
	 * @param projectUrgentDictCondition
	 * @date 2017年4月17日
	 * @return List<ProjectTypeDictEntry>
	 */
	List<ProjectUrgentDictEntry> queryProUrgentDictList(ProjectUrgentDictCondition projectUrgentDictCondition);

	/**
	 * 紧急程度字典 归档
	 *
	 * @author kongdeshuang
	 * @date 2017年4月21日
	 * @param entry
	 * @param columnNameSet
	 */
	void urgentDictFlagUpdate(final ProjectUrgentDictEntry entry, final Set<String> columnNameSet);

	/**
	 * 查询项目紧急程度
	 *
	 * @author linzhiqiang
	 * @date 2017年4月28日
	 * @return list
	 */
	List<ProjectUrgentDictEntry> queryUrgent();

	/**
	 * 查询项目紧急程度字典名称
	 *
	 * @author kongdeshuang
	 * @date 2017年5月12日
	 * @param urgentName
	 * @return int
	 */
	int queryUrgentName(String urgentName);

	/**
	 * 项目紧急程度字典批量解封、封存
	 *
	 * @author 刘教练
	 * @date 2017年9月8日
	 * @param urgentIdList
	 * @param flag
	 */
	void updateUrgentDictListFlag(final List<Long> urgentIdList, final String flag);

	/**
	 * 删除项目紧急程度字典
	 *
	 * @author 刘教练
	 * @date 2017年9月13日
	 * @param levelId
	 * @return int
	 */
	int deleteUrgentDictById(final String levelId);
}
