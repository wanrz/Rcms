/**
 *
 */
package com.rionsoft.rcms.dao.system.dict.prolevel;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.system.ProjectLevelDictCondition;
import com.rionsoft.rcms.entry.system.ProjectLevelDictEntry;

/**
 * @author kongdeshuang
 * @date 2017年4月25日
 */
@Repository
public interface IProjectLevelDictMapper {
	/**
	 * 根据类型查询字典
	 *
	 * @author kongdeshuang
	 * @param projectLevelDictCondition
	 * @date 2017年4月25日
	 * @return List<ProjectTypeDictEntry>
	 */
	List<ProjectLevelDictEntry> ProLevelDictByConditioinList(ProjectLevelDictCondition projectLevelDictCondition);

	/**
	 * 查询项目级别
	 *
	 * @author linzhiqiang
	 * @date 2017年4月28日
	 * @return list
	 */
	List<ProjectLevelDictEntry> queryLevel();

	/**
	 * 项目级别批量修改封存、解封
	 *
	 * @author 刘教练
	 * @date 2017年9月8日
	 * @param levelIdList
	 * @param flag
	 */
	void updateProLevelDictListFlag(@Param("levelIdList") final List<Long> levelIdList,
			@Param("flag") final String flag);

	/**
	 * 删除项目类型字典
	 *
	 * @author 刘教练
	 * @date 2017年9月13日
	 * @param levelId
	 * @return int
	 */
	int deleteLevelDictById(@Param("levelId") final String levelId);
}
