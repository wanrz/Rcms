/**
 *
 */
package com.rionsoft.rcms.dao.department;

import java.util.List;

import com.rionsoft.rcms.condition.listentry.department.TreeNodeListEntry;
import com.rionsoft.rcms.entry.department.AuthDirEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.ITableInsertList;
import com.rionsoft.support.mybatisplugin.dao.common.core.IWholeTableQuery;

/**
 * @author likeke
 * @date 2017年4月13日
 */
public interface IAuthDirDao
		extends ISingleTableDao<AuthDirEntry>, ITableInsertList<AuthDirEntry>, IWholeTableQuery<AuthDirEntry> {

	/**
	 * 查询根节点
	 *
	 * @return 根目录信息
	 *
	 * @author likk 2016年11月30日
	 */
	List<TreeNodeListEntry> queryTreeRoot();

	/**
	 * 根据接邻路径查询是否包含子部门
	 *
	 * @author loujie
	 * @data 2017年5月6日
	 * @param dirSeq
	 * @return int
	 */
	long queryCountByDirSeq(String dirSeq);

	/**
	 * 根据人员的id查询部门信息
	 * 
	 * @author sungantao
	 * @date 2017年9月4日
	 * @param userId
	 * @return AuthDirEntry
	 */
	AuthDirEntry queryAuthDirEntryByUserId(long userId);

}
