/**
 *
 */
package com.rionsoft.rcms.biz.department;

import java.util.List;

import com.rionsoft.rcms.bo.department.AuthDirBo;
import com.rionsoft.rcms.condition.listentry.department.TreeNodeListEntry;
import com.rionsoft.rcms.entry.department.AuthDirEntry;

/**
 * @author likeke
 * @date 2017年4月13日
 */
public interface IAuthDirBiz {

	/**
	 * 查询根节点
	 *
	 * @return 根目录信息
	 *
	 * @author likk 2016年11月30日
	 */
	List<TreeNodeListEntry> queryTreeRoot();

	/**
	 * 部门修改
	 *
	 * @author linzhiqiang
	 * @date 2017年4月14日
	 * @param authDirBo
	 */
	void deptUpdate(AuthDirBo authDirBo);

	/**
	 * 部门查询
	 *
	 * @author linzhiqiang
	 * @date 2017年4月17日
	 * @param dirId
	 * @return 部门信息
	 */
	AuthDirEntry queryDept(long dirId);

	/**
	 * 部门新增
	 *
	 * @author linzhiqiang
	 * @date 2017年4月18日
	 * @param authDirBo
	 *
	 */
	void deptSave(AuthDirBo authDirBo);

	/**
	 * 部门删除
	 *
	 * @author linzhiqiang
	 * @date 2017年4月18日
	 * @param dirId
	 * @param dirSeq
	 */
	void deptDelete(long dirId, String dirSeq);

	/**
	 * 根据人员的id查询部门信息
	 * 
	 * @author sungantao
	 * @date 2017年9月4日
	 * @return AuthDirBo
	 */
	AuthDirBo queryAuthDirEntryByUserId();
}
