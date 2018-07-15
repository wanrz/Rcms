/**
 *
 */
package com.rionsoft.rcms.dao.department;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.listentry.department.TreeNodeListEntry;
import com.rionsoft.rcms.entry.department.AuthDirEntry;

/**
 * @author likeke
 * @date 2017年4月14日
 */
@Repository
public interface IAuthDirMapper {

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
	 * @return long
	 */
	long queryCountByDirSeq(@Param("dirSeq") String dirSeq);

	/**
	 * 根据人员的id查询部门信息
	 * 
	 * @author sungantao
	 * @date 2017年9月4日
	 * @param userId
	 * @return 部门信息
	 */
	AuthDirEntry queryAuthDirEntryByUserId(long userId);

}
