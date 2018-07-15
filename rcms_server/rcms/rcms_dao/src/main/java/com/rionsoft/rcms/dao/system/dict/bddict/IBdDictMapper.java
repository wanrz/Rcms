/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.bddict;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.system.BdDictCondition;
import com.rionsoft.rcms.entry.system.BdDictEntry;

/**
 * @author kongdeshuang
 * @date 2017年5月10日
 */
@Repository
public interface IBdDictMapper {
	/**
	 * @author kongdeshuang
	 * @date 2017年5月10日
	 * @param bdDictCondition
	 * @return List<BdDictEntry>
	 */
	List<BdDictEntry> queryBdDictList(BdDictCondition bdDictCondition);
}
