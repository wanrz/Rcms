/**
 *
 */
package com.rionsoft.rcms.biz.system;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rionsoft.rcms.biz.constant.RCMSExceptionCodeEnum;
import com.rionsoft.rcms.bo.system.ProjectLevelDictBo;
import com.rionsoft.rcms.bo.system.ProjectTypeDictBo;
import com.rionsoft.rcms.bo.system.ProjectUrgentDictBo;
import com.rionsoft.rcms.condition.system.ProjectLevelDictCondition;
import com.rionsoft.rcms.condition.system.ProjectTypeDictCondition;
import com.rionsoft.rcms.condition.system.ProjectUrgentDictCondition;
import com.rionsoft.rcms.dao.system.dict.prolevel.IProjectLevelDictDao;
import com.rionsoft.rcms.dao.system.dict.protype.IProjectTypeDictDao;
import com.rionsoft.rcms.dao.system.dict.prourgent.IProjectUrgentDictDao;
import com.rionsoft.rcms.entry.system.ProjectLevelDictEntry;
import com.rionsoft.rcms.entry.system.ProjectTypeDictEntry;
import com.rionsoft.rcms.entry.system.ProjectUrgentDictEntry;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.biz.common.error.RionsoftException;

/**
 * @author kongdeshuang
 * @date 2017年4月18日
 */
@Service
public class ProjectTypeDictBizImpl extends BaseBiz implements IProjectTypeDictBiz {
	@Autowired
	private IProjectTypeDictDao projectTypeDictDao;
	@Autowired
	private IProjectLevelDictDao projectLevelDictDaoImpl;
	@Autowired
	private IProjectUrgentDictDao projectUrgentDictDaoImpl;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#getDictByConditon(com.
	 * rionsoft.rcms.condition.system.ProjectTypeDictCondition)
	 */
	@Override
	public List<ProjectTypeDictBo> getDictByConditon(final ProjectTypeDictCondition projectTypeDictCondition) {

		return map(projectTypeDictDao.ProTypeDictByConditioinList(projectTypeDictCondition), ProjectTypeDictBo.class);
		// return projectTypeDictDao.queryAll();
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#proTypeDictAdd(com.
	 * rionsoft.rcms.entry.system.ProjectTypeDictEntry)
	 */
	@Override
	public void proTypeDictAdd(final ProjectTypeDictBo projectTypeDictBo) {

		final int count = projectTypeDictDao.queryTypeCode(projectTypeDictBo.getTypeCode());
		if (count > 0) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0324,false, projectTypeDictBo.getTypeCode());
		}
		projectTypeDictDao.insert(map(projectTypeDictBo, ProjectTypeDictEntry.class));
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#updateProtypeDict(com.
	 * rionsoft.rcms.bo.system.ProjectTypeDictBo)
	 */
	@Override
	public void updateProtypeDict(final ProjectTypeDictBo projectTypeDictBo) {
		final ProjectTypeDictCondition projectTypeDictCondition = new ProjectTypeDictCondition();
		projectTypeDictCondition.setTypeCode(projectTypeDictBo.getTypeCode());
		projectTypeDictCondition.setTypeId(projectTypeDictBo.getTypeId());
		final int count = projectTypeDictDao.queryCodeCount(projectTypeDictCondition);
		if (count > 0) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0324,false, projectTypeDictBo.getTypeCode());
		}
		projectTypeDictDao.update(map(projectTypeDictBo, ProjectTypeDictEntry.class));

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#queryDictByID(long)
	 */
	@Override
	public ProjectTypeDictEntry queryDictByID(final long typeId) {
		return projectTypeDictDao.queryByID(typeId);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#updateDictFlag(java.lang
	 * .Long)
	 */
	@Override
	public void updateDictFlag(final Long typeId,final String flag) {
		final ProjectTypeDictEntry dictEntry = new ProjectTypeDictEntry();
		final Set<String> dictEntrySet = new HashSet<String>();
		dictEntry.setFlag(flag);
		dictEntry.setTypeId(typeId);
		dictEntrySet.add("FLAG");
		projectTypeDictDao.flagUpdate(dictEntry, dictEntrySet);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#proLevelDictAdd(com.
	 * rionsoft.rcms.bo.system.ProjectLevelDictBo)
	 */
	@Override
	public void proLevelDictAdd(final ProjectLevelDictBo projectLevelDictBo) {
		projectLevelDictBo.setFlag("1");
		final int count = projectLevelDictDaoImpl.queryLevelName(projectLevelDictBo.getLevelName());
		if (count > 0) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0325,false);
		}
		projectLevelDictDaoImpl.insert(map(projectLevelDictBo, ProjectLevelDictEntry.class));
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#queryProLevelDict()
	 */
	@Override
	public List<ProjectLevelDictBo> queryProLevelDict(final ProjectLevelDictCondition projectLevelDictCondition) {
		// return projectLevelDictDaoImpl.queryAll();
		return map(projectLevelDictDaoImpl.ProLevelDictByConditioinList(projectLevelDictCondition),
				ProjectLevelDictBo.class);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#updateProLevelDict(com.
	 * rionsoft.rcms.bo.system.ProjectLevelDictBo)
	 */
	@Override
	public void updateProLevelDict(final ProjectLevelDictBo projectLevelDictBo) {
		projectLevelDictDaoImpl.update(map(projectLevelDictBo, ProjectLevelDictEntry.class));
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#updateLevelDictFlag(java
	 * .lang.Long)
	 */
	@Override
	public void updateLevelDictFlag(final Long levelId,final String flag) {
		final ProjectLevelDictEntry dictEntry = new ProjectLevelDictEntry();
		final Set<String> dictEntrySet = new HashSet<String>();
		dictEntry.setFlag(flag);
		dictEntry.setLevelId(levelId);
		dictEntrySet.add("FLAG");
		projectLevelDictDaoImpl.LevelFlagUpdate(dictEntry, dictEntrySet);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#queryUrgentDict(com.
	 * rionsoft.rcms.condition.system.ProjectUrgentDictCondition)
	 */
	@Override
	public List<ProjectUrgentDictBo> queryUrgentDict(final ProjectUrgentDictCondition projectUrgentDictCondition) {
		return map(projectUrgentDictDaoImpl.queryProUrgentDictList(projectUrgentDictCondition),
				ProjectUrgentDictBo.class);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#updateProUrgentDict(com.
	 * rionsoft.rcms.bo.system.ProjectUrgentDictBo)
	 */
	@Override
	public void updateProUrgentDict(final ProjectUrgentDictBo projectUrgentDictBo) {
		projectUrgentDictDaoImpl.update(map(projectUrgentDictBo, ProjectUrgentDictEntry.class));
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#updateUrgentDictFlag(
	 * java.lang.Long)
	 */
	@Override
	public void updateUrgentDictFlag(final Long urgentId,final String flag) {

		final ProjectUrgentDictEntry dictEntry = new ProjectUrgentDictEntry();
		final Set<String> dictEntrySet = new HashSet<String>();
		dictEntry.setFlag(flag);
		dictEntry.setUrgentId(urgentId);
		dictEntrySet.add("FLAG");
		projectUrgentDictDaoImpl.urgentDictFlagUpdate(dictEntry, dictEntrySet);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#proUrgentDictAdd(com.
	 * rionsoft.rcms.bo.system.ProjectUrgentDictBo)
	 */
	@Override
	public void proUrgentDictAdd(final ProjectUrgentDictBo projectUrgentDictBo) {
		projectUrgentDictBo.setFlag("1");
		final int count = projectUrgentDictDaoImpl.queryUrgentName(projectUrgentDictBo.getUrgentName());
		if (count > 0) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0326,false);
		}
		projectUrgentDictDaoImpl.insert(map(projectUrgentDictBo, ProjectUrgentDictEntry.class));

	}

	@Override
	public List<ProjectTypeDictBo> queryProjectList() {
		return map(projectTypeDictDao.queryProjectList(), ProjectTypeDictBo.class);
	}
	
	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#queryProjectChangeList()
	 */
	@Override
	public List<ProjectTypeDictBo> queryProjectChangeList() {
		return map(projectTypeDictDao.queryProjectChangeList(), ProjectTypeDictBo.class);
	}

	@Override
	public List<ProjectLevelDictBo> queryLevel() {
		return map(projectLevelDictDaoImpl.queryLevel(), ProjectLevelDictBo.class);
	}

	@Override
	public List<ProjectUrgentDictBo> queryUrgent() {
		return map(projectUrgentDictDaoImpl.queryUrgent(), ProjectUrgentDictBo.class);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#updateTypeIdListFlag(java.util.List, java.lang.String)
	 */
	@Override
	public void updateTypeIdListFlag(final List<Long> typeIdList, String flag) {
		projectTypeDictDao.updateTypeIdListFlag(typeIdList, flag);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#updateProLevelDictListFlag(java.util.List, java.lang.String)
	 */
	@Override
	public void updateProLevelDictListFlag(List<Long> levelIdList, String flag) {
		projectLevelDictDaoImpl.updateProLevelDictListFlag(levelIdList, flag);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#updateUrgentDictListFlag(java.util.List, java.lang.String)
	 */
	@Override
	public void updateUrgentDictListFlag(List<Long> urgentIdList, String flag) {
		projectUrgentDictDaoImpl.updateUrgentDictListFlag(urgentIdList, flag);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#deleteTypeDictById(java.lang.String)
	 */
	@Override
	public int deleteTypeDictById(String typeCode) {
		return projectTypeDictDao.deleteTypeDictById(typeCode);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.system.IProjectTypeDictBiz#deleteLevelDictById(java.lang.String)
	 */
	@Override
	public int deleteLevelDictById(String levelId) {
		return projectLevelDictDaoImpl.deleteLevelDictById(levelId);
	}

	@Override
	public int deleteUrgentDictById(String urgentId) {
		return projectUrgentDictDaoImpl.deleteUrgentDictById(urgentId);
	}
}
