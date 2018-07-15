/**
 *
 */
package com.rionsoft.rcms.dao.project.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.project.ProjectCondition;
import com.rionsoft.rcms.condition.project.ProjectListEntry;
import com.rionsoft.rcms.dao.project.IProjectDao;
import com.rionsoft.rcms.entry.project.ProjectEntry;
import com.rionsoft.support.mybatisplugin.dao.common.annotation.GenerateId;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author linzhiqiang
 * @date 2017年4月19日
 */
@Repository
@GenerateId(value = true)
class ProjectDaoImpl extends SingleTableDao<ProjectEntry> implements IProjectDao {
	@Autowired
	private IProjectMapper projectMapper;

	@Override
	public List<ProjectListEntry> projectQuery(final ProjectCondition projectCondition) {

		return projectMapper.projectQuery(projectCondition);
	}

	@Override
	public ProjectListEntry queryProject(final long pkProj) {
		return projectMapper.queryProject(pkProj);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.project.IProjectDao#queryProjectDetails(long)
	 */
	@Override
	public List<ProjectListEntry> queryProjectDetails(final ProjectCondition condition) {
		return projectMapper.queryProjectDetails(condition);
	}

	@Override
	public int queryNumber(final String code2) {
		return projectMapper.queryNumber(code2);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.project.IProjectDao#queryProjectContrast(long,
	 * int)
	 */
	@Override
	public List<ProjectListEntry> queryProjectContrast(final long pkProj, final int version) {
		return projectMapper.queryProjectContrast(pkProj, version);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.project.IProjectDao#queryProjectTodo(java.util.
	 * List)
	 */
	@Override
	public List<ProjectEntry> queryProjectTodo(final List<Long> idList) {
		final Map<String, Object> map = new HashMap<>();
		map.put("PK_PROJ", idList);
		return super.queryListByColumns(map);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.rionsoft.rcms.dao.project.IProjectDao#deleteProj(java.util.List)
	 */
	@Override
	public void deleteProj(final List<Long> pkList) {
		super.deleteListByIdList(pkList);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.dao.project.IProjectDao#queryProjById(long)
	 */
	@Override
	public int queryProjById(final long dirId) {
		final Map<String, Object> map = new HashMap<>();
		map.put("DEPT_ID", dirId);
		return queryCountByColumns(map);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.dao.project.IProjectDao#queryByIdList(java.util.List)
	 */
	@Override
	public List<String> queryByList(final List<Long> pkList) {
		return projectMapper.queryByList(pkList);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.rionsoft.rcms.dao.project.IProjectDao#queryProjectByDataCode(com.
	 * rionsoft.rcms.condition.project.ProjectCondition)
	 */
	@Override
	public List<ProjectListEntry> queryProjectByDataCode(ProjectCondition projectCondition) {
		return projectMapper.queryProjectByDataCode(projectCondition);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.rionsoft.rcms.dao.project.IProjectDao#projectContrast(com.rionsoft.
	 * rcms.condition.project.ProjectCondition)
	 */
	@Override
	public List<ProjectListEntry> projectContrast(ProjectCondition condition) {
		return projectMapper.projectContrast(condition);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.project.IProjectDao#queryProjectByProjOperator(com.rionsoft.rcms.condition.project.ProjectCondition)
	 */
	@Override
	public List<ProjectListEntry> queryProjectByProjOperator(ProjectCondition condition) {
		return projectMapper.queryProjectByProjOperator(condition);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.project.IProjectDao#projectListByApprovalTime(com.rionsoft.rcms.condition.project.ProjectCondition)
	 */
	@Override
	public List<ProjectListEntry> projectListByApprovalTime(ProjectCondition condition) {
		return projectMapper.projectListByApprovalTime(condition);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.project.IProjectDao#userInProjectByProjOperator(long)
	 */
	@Override
	public List<ProjectListEntry> userInProjectByProjOperator(long userId,String loginCode) {
		 return projectMapper.userInProjectByProjOperator(userId,loginCode);
		
	}

}
