/**
 *
 */
package com.rionsoft.rcms.biz.system;

import java.util.List;

import com.rionsoft.rcms.bo.system.ProjectLevelDictBo;
import com.rionsoft.rcms.bo.system.ProjectTypeDictBo;
import com.rionsoft.rcms.bo.system.ProjectUrgentDictBo;
import com.rionsoft.rcms.condition.system.ProjectLevelDictCondition;
import com.rionsoft.rcms.condition.system.ProjectTypeDictCondition;
import com.rionsoft.rcms.condition.system.ProjectUrgentDictCondition;
import com.rionsoft.rcms.entry.system.ProjectTypeDictEntry;

/**
 * @author kongdeshuang
 * @date 2017年4月18日
 */
public interface IProjectTypeDictBiz {

	/**
	 * 按查询条件查询字典
	 *
	 * @author kongdeshuang
	 * @param projectTypeDictCondition
	 * @return List<ProjectTypeDictEntry>
	 * @date 2017年4月18日
	 */
	List<ProjectTypeDictBo> getDictByConditon(ProjectTypeDictCondition projectTypeDictCondition);

	/**
	 * 更改项目类型字典
	 *
	 * @author kongdeshuang
	 * @param projectTypeDictBo
	 * @date 2017年4月18日
	 */
	void updateProtypeDict(ProjectTypeDictBo projectTypeDictBo);

	/**
	 * 项目类型字典归档
	 *
	 * @author kongdeshuang
	 * @param typeId
	 * @param flag
	 * @date 2017年4月18日
	 */
	void updateDictFlag(final Long typeId, final String flag);

	/**
	 * 项目类型字典批量修改状态
	 *
	 * @author 刘教练
	 * @date 2017年9月8日
	 * @param typeIdList
	 * @param flag
	 */
	void updateTypeIdListFlag(final List<Long> typeIdList, final String flag);

	/**
	 * 添加项目类型字典
	 *
	 * @author kongdeshuang
	 * @param projectTypeDictBo
	 * @date 2017年4月19日
	 */
	void proTypeDictAdd(ProjectTypeDictBo projectTypeDictBo);

	/**
	 * 根据ID查询
	 *
	 * @author kongdeshuang
	 * @date 2017年4月20日
	 * @param typeId
	 * @return ProjectTypeDictEntry
	 */
	ProjectTypeDictEntry queryDictByID(long typeId);

	/**
	 * 添加项目级别字典
	 *
	 * @author kongdeshuang
	 * @param projectLevelDictBo
	 * @date 2017年4月24日
	 */
	void proLevelDictAdd(ProjectLevelDictBo projectLevelDictBo);

	/**
	 * 查询项目级别字典
	 *
	 * @author kongdeshuang
	 * @param projectLevelDictCondition
	 * @date 2017年4月24日
	 * @return List<ProjectLevelDictBo>
	 */
	List<ProjectLevelDictBo> queryProLevelDict(ProjectLevelDictCondition projectLevelDictCondition);

	/**
	 * 更改项目级别字典
	 *
	 * @author kongdeshuang
	 * @param projectLevelDictBo
	 * @date 2017年4月18日
	 */
	void updateProLevelDict(ProjectLevelDictBo projectLevelDictBo);

	/**
	 * 项目级别字典归档
	 *
	 * @author kongdeshuang
	 * @param levelId
	 * @param flag
	 * @date 2017年4月18日
	 */
	void updateLevelDictFlag(final Long levelId, final String flag);

	/**
	 * 按查询条件查询项目紧急字典
	 *
	 * @author kongdeshuang
	 * @param projectUrgentDictCondition
	 * @return List<ProjectTypeDictEntry>
	 * @date 2017年4月18日
	 */
	List<ProjectUrgentDictBo> queryUrgentDict(ProjectUrgentDictCondition projectUrgentDictCondition);

	/**
	 * 更改项目紧急程度字典
	 *
	 * @author kongdeshuang
	 * @param projectUrgentDictBo
	 * @date 2017年4月18日
	 */
	void updateProUrgentDict(ProjectUrgentDictBo projectUrgentDictBo);

	/**
	 * 项目紧急程度字典归档
	 *
	 * @author kongdeshuang
	 * @param urgentId
	 * @param flag
	 * @date 2017年4月18日
	 */
	void updateUrgentDictFlag(final Long urgentId, final String flag);

	/**
	 * 添加项目紧急程度字典
	 *
	 * @author kongdeshuang
	 * @param projectUrgentDictBo
	 * @date 2017年4月24日
	 */
	void proUrgentDictAdd(ProjectUrgentDictBo projectUrgentDictBo);

	/**
	 * 查询项目类型
	 *
	 * @author linzhiqiang
	 * @date 2017年4月24日
	 * @return view
	 */
	List<ProjectTypeDictBo> queryProjectList();

	/**
	 * 项目变更查询项目类型
	 *
	 * @author 刘教练
	 * @date 2017年8月22日
	 * @return view
	 */
	List<ProjectTypeDictBo> queryProjectChangeList();

	/**
	 * 查询有效项目级别
	 *
	 * @author linzhiqiang
	 * @date 2017年4月28日
	 * @return view
	 */
	List<ProjectLevelDictBo> queryLevel();

	/**
	 * 查询有效项目紧急程度
	 *
	 * @author linzhiqiang
	 * @date 2017年4月28日
	 * @return List
	 */
	List<ProjectUrgentDictBo> queryUrgent();

	/**
	 * 项目级别批量修改封存、解封
	 *
	 * @author 刘教练
	 * @date 2017年9月8日
	 * @param levelIdList
	 * @param flag
	 */
	void updateProLevelDictListFlag(final List<Long> levelIdList, final String flag);

	/**
	 * 项目紧急程度字典批量解封、封存
	 *
	 * @author 刘教练
	 * @date 2017年9月8日
	 * @param urgentIdList
	 * @param flag
	 */
	void updateUrgentDictListFlag(final List<Long> urgentIdList, final String flag);

	/**
	 * 删除项目类型字典
	 *
	 * @author 刘教练
	 * @date 2017年9月13日
	 * @param typeCode
	 * @return int
	 */
	int deleteTypeDictById(final String typeCode);

	/**
	 * 删除项目级别字典
	 *
	 * @author 刘教练
	 * @date 2017年9月13日
	 * @param levelId
	 * @return int
	 */
	int deleteLevelDictById(final String levelId);

	/**
	 * 删除项目紧急程度字典
	 *
	 * @author 刘教练
	 * @date 2017年9月13日
	 * @param urgentId
	 * @return int
	 */
	int deleteUrgentDictById(final String urgentId);
}
