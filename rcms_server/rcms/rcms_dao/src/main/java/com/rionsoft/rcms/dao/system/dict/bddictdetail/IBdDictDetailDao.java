/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.bddictdetail;

import java.util.List;
import java.util.Set;

import com.rionsoft.rcms.condition.system.BdDictDetailCondition;
import com.rionsoft.rcms.entry.system.BdDictDetailEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.IWholeTableQuery;

/**
 * @author kongdeshuang
 * @date 2017年5月10日
 */
public interface IBdDictDetailDao extends ISingleTableDao<BdDictDetailEntry>, IWholeTableQuery<BdDictDetailEntry> {
	/**
	 * 字典归档
	 *
	 * @author kongdeshuang
	 * @date 2017年5月10日
	 * @param entry
	 * @param columnNameSet
	 */
	void FlagUpdate(final BdDictDetailEntry entry, final Set<String> columnNameSet);

	/**
	 * 字典按条件查询
	 *
	 * @author kongdeshuang
	 * @date 2017年5月10日
	 * @param bdDictDetailCondition
	 * @return List<BdDictDetailEntry>
	 */
	List<BdDictDetailEntry> queryBdDictList(BdDictDetailCondition bdDictDetailCondition);
}
