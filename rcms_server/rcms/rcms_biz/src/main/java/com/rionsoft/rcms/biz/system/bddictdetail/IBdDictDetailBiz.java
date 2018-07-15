/**
 *
 */
package com.rionsoft.rcms.biz.system.bddictdetail;

import java.util.List;

import com.rionsoft.rcms.bo.system.BdDictDetailBo;
import com.rionsoft.rcms.condition.system.BdDictDetailCondition;

/**
 * @author kongdeshuang
 * @date 2017年5月10日
 */
public interface IBdDictDetailBiz {
	/**
	 * 查询字典
	 *
	 * @author kongdeshuang
	 * @date 2017年5月10日
	 * @param bdDictDetailCondition
	 * @return List<BdDictDetailBo>
	 */
	List<BdDictDetailBo> queryBdDictDetail(BdDictDetailCondition bdDictDetailCondition);

	/**
	 * 字典修改
	 *
	 * @author kongdeshuang
	 * @date 2017年5月10日
	 * @param bdDictDetailBo
	 */
	void updateDbDictDetail(BdDictDetailBo bdDictDetailBo);

	/**
	 * 字典归档
	 *
	 * @author kongdeshuang
	 * @date 2017年5月10日
	 * @param pkDetail
	 */
	void updateDictFlag(final Long pkDetail);

	/**
	 * 字典添加
	 *
	 * @author kongdeshuang
	 * @date 2017年5月10日
	 * @param bdDictDetailBo
	 */
	void bdDictDetailAdd(BdDictDetailBo bdDictDetailBo);
}
