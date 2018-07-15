/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.prourgent;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.system.ProjectUrgentDictCondition;
import com.rionsoft.rcms.entry.system.ProjectUrgentDictEntry;

/**
 * @author kongdeshuang
 * @date 2017年4月24日
 */
@Repository
public interface IProjectUrgentDictMapper {
	/**
	 * 根据项目级别查询
	 *
	 * @author kongdeshuang
	 * @param projectUrgentDictCondition
	 * @date 2017年4月24日
	 * @return List<ProjectTypeDictEntry>
	 */
	List<ProjectUrgentDictEntry> queryProUrgentDictList(ProjectUrgentDictCondition projectUrgentDictCondition);

	/**
	 * 查询有效的项目紧急程度
	 *
	 * @author linzhiqiang
	 * @date 2017年4月28日
	 * @return list
	 */
	List<ProjectUrgentDictEntry> queryUrgent();

	/**
	 * 项目紧急程度字典批量解封、封存
	 *
	 * @author 刘教练
	 * @date 2017年9月8日
	 * @param urgentIdList
	 * @param flag
	 */
	void updateUrgentDictListFlag(@Param("urgentIdList") final List<Long> urgentIdList,
			@Param("flag") final String flag);

	/**
	 * 删除项目紧急程度字典
	 *
	 * @author 刘教练
	 * @date 2017年9月13日
	 * @param urgentId
	 * @return int
	 */
	int deleteUrgentDictById(@Param("urgentId") final String urgentId);
}
