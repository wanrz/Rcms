/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.bddictdetail;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.system.BdDictDetailCondition;
import com.rionsoft.rcms.entry.system.BdDictDetailEntry;

/**
 * @author kongdeshuang
 * @date 2017年5月10日
 */
@Repository
public interface IBdDictDetailMapper {
	/**
	 * 按条件查询字典
	 *
	 * @author kongdeshuang
	 * @date 2017年5月10日
	 * @param bdDictDetailCondition
	 * @return List<BdDictDetailEntry>
	 */
	List<BdDictDetailEntry> queryBdDetailDictList(BdDictDetailCondition bdDictDetailCondition);
}
