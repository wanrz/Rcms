/**
 *
 */
package com.rionsoft.rcms.biz.system.bddict;

import java.util.List;

import com.rionsoft.rcms.bo.system.BdDictBo;
import com.rionsoft.rcms.condition.system.BdDictCondition;

/**
 * @author kongdeshuang
 * @date 2017年5月10日
 */
public interface IBdDictBiz {
	/**
	 * 查询字典大表
	 *
	 * @author kongdeshuang
	 * @date 2017年5月10日
	 * @param bdDictCondition
	 * @return List<BdDictBo>
	 */
	List<BdDictBo> queryDictList(BdDictCondition bdDictCondition);
}
