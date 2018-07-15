/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.protype;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.system.ProjectTypeDictCondition;
import com.rionsoft.rcms.entry.system.ProjectTypeDictEntry;

/**
 * @author kongdeshuang
 * @date 2017年4月18日
 */
@Repository
public interface IProjectTypeDictMapper {

	/**
	 * 根据类型查询字典
	 *
	 * @author kongdeshuang
	 * @param projectTypeDictCondition
	 * @date 2017年4月17日
	 * @return List<ProjectTypeDictEntry>
	 */
	List<ProjectTypeDictEntry> ProTypeDictByConditioinList(ProjectTypeDictCondition projectTypeDictCondition);

	/**
	 * 归档字典
	 *
	 * @author kongdeshuang
	 * @param typeId
	 * @date 2017年4月17日
	 */

	void updateFlagByid(long typeId);

	/**
	 * 项目类型查询
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
	 * 根据code查询总条数
	 *
	 * @author kongdeshuang
	 * @param projectTypeDictCondition
	 * @date 2017年5月15日
	 * @return int
	 */
	int queryCodeCount(ProjectTypeDictCondition projectTypeDictCondition);

	/**
	 * 项目类型字典批量修改状态
	 *
	 * @author 刘教练
	 * @date 2017年9月8日
	 * @param typeIdList
	 * @param flag
	 */
	void updateTypeIdListFlag(@Param("typeIdList") final List<Long> typeIdList, @Param("flag") final String flag);

	/**
	 * 删除项目类型字典
	 *
	 * @author 刘教练
	 * @date 2017年9月13日
	 * @param typeCode
	 * @return int
	 */
	int deleteTypeDictById(@Param("typeCode") final String typeCode);
}
