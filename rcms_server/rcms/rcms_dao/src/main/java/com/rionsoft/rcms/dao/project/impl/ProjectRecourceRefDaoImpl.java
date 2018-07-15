/**
 *
 */
package com.rionsoft.rcms.dao.project.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.project.ProjectRecourceRefCondition;
import com.rionsoft.rcms.condition.project.ProjectRecourceRefListEntry;
import com.rionsoft.rcms.condition.project.ProjectUserListEntry;
import com.rionsoft.rcms.dao.project.IProjectRecourceRefDao;
import com.rionsoft.rcms.entry.project.ProjectRecourceRefEntry;
import com.rionsoft.rcms.entry.user.UserInfoEntry;
import com.rionsoft.support.mybatisplugin.dao.common.annotation.GenerateId;
import com.rionsoft.support.mybatisplugin.dao.common.core.impl.SingleTableDao;

/**
 * @author linzhiqiang
 * @date 2017年4月25日
 */
@Repository
@GenerateId(value = false)
class ProjectRecourceRefDaoImpl extends SingleTableDao<ProjectRecourceRefEntry> implements IProjectRecourceRefDao {
	@Autowired
	private IProjectRecourceRefMapper projectRecourceRefMapper;

	@Override
	public List<ProjectRecourceRefListEntry> projectRfeQuery(final ProjectRecourceRefCondition condition) {
		return projectRecourceRefMapper.projectRfeQuery(condition);
	}

	@Override
	public List<ProjectUserListEntry> projectUserQuery(final ProjectRecourceRefCondition condition) {
		return projectRecourceRefMapper.projectUserQuery(condition);
	}

	@Override
	public List<ProjectUserListEntry> projectUserList(final ProjectRecourceRefCondition condition) {
		return projectRecourceRefMapper.projectUserList(condition);
	}

	@Override
	public void projectDeleteUser(final List<Long> userIdList, final long pkProj) {
		projectRecourceRefMapper.projectDeleteUser(userIdList, pkProj);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.rionsoft.rcms.dao.project.IProjectRecourceRefDao#queryCodeByList(java
	 * .util.List)
	 */
	@Override
	public List<String> queryCodeByList(final List<Long> pkList) {
		return projectRecourceRefMapper.queryCodeByList(pkList);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.rionsoft.rcms.dao.project.IProjectRecourceRefDao#
	 * queryProjectUserCount(long)
	 */
	@Override
	public int queryProjectUserCount(final long userId) {
		final Map<String, Object> map = new HashMap<>();
		map.put("USER_ID", userId);
		int i = super.queryCountByColumns(map);
		return i;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.rionsoft.rcms.dao.project.IProjectRecourceRefDao#
	 * queryProjResByDataCode(com.rionsoft.rcms.condition.project.
	 * ProjectRecourceRefCondition)
	 */
	@Override
	public List<ProjectRecourceRefListEntry> queryProjResByDataCode(ProjectRecourceRefCondition condition) {
		return projectRecourceRefMapper.queryProjResByDataCode(condition);
	}


	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.project.IProjectRecourceRefDao#updateProjectRefUser(com.rionsoft.rcms.entry.project.ProjectRecourceRefEntry)
	 */
	@Override
	public void updateProjectRefUser(final Long userId,final String chargeProj,final Long pkProj) {
		projectRecourceRefMapper.updateProjectRefUser(userId,chargeProj,pkProj);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.project.IProjectRecourceRefDao#queryCountInfo(java.util.List, long)
	 */
	@Override
	public List<UserInfoEntry> queryCountInfo(List<Long> userIdList, long pkProj) {
		
		return projectRecourceRefMapper.queryCountInfo(userIdList,pkProj);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.project.IProjectRecourceRefDao#queryTaskCountInfo(java.util.List, long)
	 */
	@Override
	public List<UserInfoEntry> queryTaskCountInfo(List<Long> userList, long pkTask) {
		return projectRecourceRefMapper.queryTaskCountInfo(userList,pkTask);
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.dao.project.IProjectRecourceRefDao#queryProjectRefCharge(java.lang.Long)
	 */
	@Override
	public int queryProjectRefCharge(final Long pkProj) {
		return projectRecourceRefMapper.queryProjectRefCharge(pkProj);
	}

	
}
