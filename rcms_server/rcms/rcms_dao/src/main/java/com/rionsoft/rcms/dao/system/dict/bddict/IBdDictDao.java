/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.bddict;

import java.util.List;

import com.rionsoft.rcms.condition.system.BdDictCondition;
import com.rionsoft.rcms.entry.system.BdDictEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.IWholeTableQuery;

/**
 * @author kongdeshuang
 * @date 2017年5月10日
 */
public interface IBdDictDao extends ISingleTableDao<BdDictEntry>, IWholeTableQuery<BdDictEntry> {
	/**
	 * 查询字典大表
	 *
	 * @author kongdeshuang
	 * @date 2017年5月10日
	 * @param bdDictCondition
	 * @return List<BdDictEntry>
	 */
	List<BdDictEntry> queryBdDictList(BdDictCondition bdDictCondition);
}
