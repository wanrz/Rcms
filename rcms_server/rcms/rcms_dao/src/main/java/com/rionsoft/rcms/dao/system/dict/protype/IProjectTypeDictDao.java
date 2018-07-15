/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.protype;

import java.util.List;
import java.util.Set;

import com.rionsoft.rcms.condition.system.ProjectTypeDictCondition;
import com.rionsoft.rcms.entry.system.ProjectTypeDictEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.IWholeTableQuery;

/**
 * @author kongdeshuang
 * @date 2017年4月18日
 */
public interface IProjectTypeDictDao
		extends ISingleTableDao<ProjectTypeDictEntry>, IWholeTableQuery<ProjectTypeDictEntry> {

	/**
	 * 根据查询条件查询字典
	 *
	 * @author kongdeshuang
	 * @param projectTypeDictCondition
	 * @date 2017年4月17日
	 * @return List<ProjectTypeDictEntry>
	 */
	List<ProjectTypeDictEntry> ProTypeDictByConditioinList(ProjectTypeDictCondition projectTypeDictCondition);

	/**
	 * 归档
	 *
	 * @author kongdeshuang
	 * @date 2017年4月21日
	 * @param entry
	 * @param columnNameSet
	 */
	void flagUpdate(final ProjectTypeDictEntry entry, final Set<String> columnNameSet);

	/**
	 * 查询项目类型
	 *
	 * @author linzhiqiang
	 * @date 2017年4月28日
	 * @return list
	 */
	List<ProjectTypeDictEntry> queryProjectList();

	/**
	 * 项目变更查询项目类型
	 *
	 * @author 刘教练
	 * @date 2017年8月22日
	 * @return view
	 */
	List<ProjectTypeDictEntry> queryProjectChangeList();

	/**
	 * 项目类型字典批量修改状态
	 *
	 * @author 刘教练
	 * @date 2017年9月8日
	 * @param typeIdList
	 * @param flag
	 */
	void updateTypeIdListFlag(final List<Long> typeIdList, final String flag);

	/**
	 * 查询类型字典code
	 *
	 * @author kongdeshuang
	 * @date 2017年5月12日
	 * @param typeCode
	 * @return int
	 */
	int queryTypeCode(String typeCode);

	/**
	 * 查询相同code的总条数
	 *
	 * @author kongdeshuang
	 * @param projectTypeDictCondition
	 * @date 2017年5月15日
	 *
	 * @return int
	 */
	int queryCodeCount(ProjectTypeDictCondition projectTypeDictCondition);

	/**
	 * 删除项目类型字典
	 *
	 * @author 刘教练
	 * @date 2017年9月13日
	 * @param typeCode
	 * @return int
	 */
	int deleteTypeDictById(final String typeCode);
}
