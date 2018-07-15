/**
 *
 */
package com.rionsoft.rcms.biz.project.impl;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.util.WebUtils;

import com.rionsoft.rcms.biz.common.cache.CacheUtil;
import com.rionsoft.rcms.biz.constant.RCMSExceptionCodeEnum;
import com.rionsoft.rcms.biz.project.IProjectBiz;
import com.rionsoft.rcms.biz.project.IProjectRecourceRefBiz;
import com.rionsoft.rcms.bo.constant.ProjectStatusEnum;
import com.rionsoft.rcms.bo.project.ProjectBo;
import com.rionsoft.rcms.bo.project.ProjectRecourceRefBo;
import com.rionsoft.rcms.condition.project.ProjectCondition;
import com.rionsoft.rcms.condition.project.ProjectListEntry;
import com.rionsoft.rcms.dao.project.IProjectDao;
import com.rionsoft.rcms.dao.project.IProjectRecourceRefDao;
import com.rionsoft.rcms.dao.project.impl.IProjectRecourceRefMapper;
import com.rionsoft.rcms.entry.project.ProjectEntry;
import com.rionsoft.support.basebo.session.UserLoginBo;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.biz.common.constants.SessionConstant;
import com.rionsoft.support.biz.common.error.RionsoftException;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;
import com.rionsoft.support.mybatisplugin.dao.util.PropertyPlaceholderUtils;

/**
 * @author linzhiqiang
 * @date 2017年4月19日
 */
@Service
public class ProjectBizImpl extends BaseBiz implements IProjectBiz {
	@Autowired
	private IProjectDao projectDao;
	@Autowired
	private IProjectRecourceRefDao refDao;
	@Autowired
	private IProjectRecourceRefMapper projectRecourceRefMapper;
	@Autowired
	private IProjectRecourceRefBiz projectRecourceRefBiz;

	@Override
	@Transactional
	public void projectSave(final ProjectBo projectBo) {
		projectDao.insert(map(projectBo, ProjectEntry.class));
	}

	@Override
	public List<ProjectBo> projectChangeQuery(final ProjectCondition projectCondition, final HttpServletRequest req) {
		if (projectCondition.getCheckDirName() != "" && projectCondition.getCheckDirName() != null) {
			projectCondition.setDeptId(null);
			final String dirSeq = projectCondition.getCheckDirName();
			if (dirSeq.contains("|")) {
				projectCondition.setDirSeq(dirSeq.substring(dirSeq.lastIndexOf("|") + 1));
			} else {
				projectCondition.setDirSeq(dirSeq);
			}
			projectCondition.setDeptName(null);
		}
		if (projectCondition.getCheckDirName2() != "" && projectCondition.getCheckDirName2() != null) {
			projectCondition.setDeptId(null);
			projectCondition.setDirSeq(projectCondition.getCheckDirName2());
			projectCondition.setDeptName(null);
		}

		// 用户权限判断
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		final String adminLoginCode = PropertyPlaceholderUtils.getContextProperty("adminLoginCode");
		final UserLoginBo bo = (UserLoginBo) WebUtils.getSessionAttribute(req, SessionConstant.ADMIN_LOGIN.name());
		projectCondition.setUserId(userId);
		projectCondition.setAdminLoginCode(adminLoginCode);
		projectCondition.setLoginCode(bo.getLoginCode());

		final List<ProjectBo> boList = mapListEntry(projectDao.projectQuery(projectCondition), ProjectBo.class);
		for (final ProjectBo projectBo : boList) {
			projectBo.setStatus(ProjectStatusEnum.getType(projectBo.getStatus()));
		}
		return boList;
	}

	@Override
	public ProjectBo queryProject(final long pkProj) {
		final ProjectListEntry projectEntry = projectDao.queryProject(pkProj);
		return map(projectEntry, ProjectBo.class);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.project.IProjectBiz#projectUpdate(com.rionsoft.rcms
	 * .bo.project.ProjectBo)
	 */
	@Override
	public void projectUpdate(final ProjectBo projectBo) {
		if (!projectBo.getStatus().equals("01")) {
			changeManager(projectBo);
		}
		projectDao.update(map(projectBo, ProjectEntry.class));
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.project.IProjectBiz#changeProject(com.rionsoft.rcms
	 * .bo.project.ProjectBo)
	 */
	@Override
	@Transactional
	public void changeProject(final ProjectBo projectBo) {
		final List<ProjectEntry> list = projectDao.queryHisByID(projectBo.getPkProj());
		final List<ProjectEntry> listEntry = new ArrayList<>();
		final ProjectEntry oldEntry = projectDao.queryByID(projectBo.getPkProj());
		if (!projectBo.getStatus().equals("01")) {
			changeManager(projectBo);
		}
		final ProjectEntry newEntry = map(projectBo, ProjectEntry.class);
		projectDao.update(newEntry);
		listEntry.add(newEntry);
		if (list.isEmpty()) {
			listEntry.add(oldEntry);
		}
		projectDao.insertHis(listEntry);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.project.IProjectBiz#queryProjectDetails(long)
	 */
	@Override
	public List<ProjectBo> queryProjectDetails(final ProjectCondition condition) {
		final List<ProjectBo> boList = mapListEntry(projectDao.queryProjectDetails(condition), ProjectBo.class);
		for (final ProjectBo bo : boList) {
			bo.setStatus(ProjectStatusEnum.getType(bo.getStatus()));
		}
		return boList;
	}

	@Override
	public String getProjectCode(final String typeCode) {
		final SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		final Date date = new Date();
		final String str = sdf.format(date);
		final String code = str.substring(2, 6);
		final String code1 = str.substring(2, 4);
		final String code2 = typeCode + code1;
		final int kk = projectDao.queryNumber(code2);
		final int a = kk + 1;
		final DecimalFormat df = new DecimalFormat("000");
		final String n = df.format(a);
		final String projCode = typeCode + code + n;
		return projCode;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.project.IProjectBiz#queryProjectContrast(long,
	 * int)
	 */
	@Override
	public List<ProjectBo> queryProjectContrast(final long pkProj, final int version) {
		final List<ProjectBo> boList = mapListEntry(projectDao.queryProjectContrast(pkProj, version), ProjectBo.class);
		for (final ProjectBo bo : boList) {
			bo.setStatus(ProjectStatusEnum.getType(bo.getStatus()));
		}
		return boList;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.project.IProjectBiz#queryCount(long)
	 */
	@Override
	public int queryCount(final long pkProj) {
		return projectDao.queryHisByID(pkProj).size();
	}

	@Override
	public void deleteProj(final List<Long> pkList) {
		final List<String> codeList = projectDao.queryByList(pkList);
		if (codeList.size() > 0) {
			String list = "";
			for (final String code : codeList) {
				list = list + code + ",";
			}
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0323, false, list.substring(0, list.length() - 1),
					"包含任务");
		}
		final List<String> listCode = refDao.queryCodeByList(pkList);
		if (listCode.size() > 0) {
			String list = "";
			for (final String code : listCode) {
				list = list + code + ",";
			}
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0323, false, list.substring(0, list.length() - 1),
					"已经资源分配过");
		}
		projectDao.deleteProj(pkList);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.project.IProjectBiz#projectQuery(com.rionsoft.rcms.
	 * condition.project.ProjectCondition,
	 * javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public List<ProjectBo> projectQuery(final ProjectCondition projectCondition, final HttpServletRequest req) {
		if (projectCondition.getCheckDirName() != "" && projectCondition.getCheckDirName() != null) {
			projectCondition.setDeptId(null);
			final String dirSeq = projectCondition.getCheckDirName();
			if (dirSeq.contains("|")) {
				projectCondition.setDirSeq(dirSeq.substring(dirSeq.lastIndexOf("|") + 1));
			} else {
				projectCondition.setDirSeq(dirSeq);
			}
			projectCondition.setDeptName(null);
		}
		if (projectCondition.getCheckDirName2() != "" && projectCondition.getCheckDirName2() != null) {
			projectCondition.setDeptId(null);
			projectCondition.setDirSeq(projectCondition.getCheckDirName2());
			projectCondition.setDeptName(null);
		}

		// 用户权限判断
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		final String adminLoginCode = PropertyPlaceholderUtils.getContextProperty("adminLoginCode");
		final UserLoginBo bo = (UserLoginBo) WebUtils.getSessionAttribute(req, SessionConstant.ADMIN_LOGIN.name());
		projectCondition.setUserId(userId);
		projectCondition.setAdminLoginCode(adminLoginCode);
		projectCondition.setLoginCode(bo.getLoginCode());

		final List<ProjectBo> newProjectBo = mapListEntry(projectDao.queryProjectByDataCode(projectCondition),
				ProjectBo.class);
		for (final ProjectBo projectBo : newProjectBo) {
			projectBo.setStatus(ProjectStatusEnum.getType(projectBo.getStatus()));
		}
		return newProjectBo;
	}

	private void changeManager(final ProjectBo projectBo) {
		final ProjectListEntry queryProject = projectDao.queryProject(projectBo.getPkProj());
		final List<Long> userIdlist = new ArrayList<>();
		userIdlist.add((long) queryProject.getPmId());
		userIdlist.add((long) projectBo.getPmId());
		projectRecourceRefMapper.projectDeleteUser(userIdlist, queryProject.getPkProj());
		final List<ProjectRecourceRefBo> refBoList = new ArrayList<>();
		final ProjectRecourceRefBo refbo = new ProjectRecourceRefBo();
		refbo.setPkProj(projectBo.getPkProj());
		refbo.setUserId((long) projectBo.getPmId());
		refbo.setChargeProj("2");
		refBoList.add(refbo);
		projectRecourceRefBiz.projectUserSave(refBoList);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.project.IProjectBiz#projectContrast(com.rionsoft.
	 * rcms.condition.project.ProjectCondition)
	 */
	@Override
	public List<ProjectBo> projectContrast(final ProjectCondition condition) {
		return mapListEntry(projectDao.projectContrast(condition), ProjectBo.class);
	}

	@Override
	public List<ProjectBo> queryProjectByProjOperator(final ProjectCondition projectCondition,
			final HttpServletRequest req) {
		if (projectCondition.getCheckDirName() != "" && projectCondition.getCheckDirName() != null) {
			projectCondition.setDeptId(null);
			final String dirSeq = projectCondition.getCheckDirName();
			if (dirSeq.contains("|")) {
				projectCondition.setDirSeq(dirSeq.substring(dirSeq.lastIndexOf("|") + 1));
			} else {
				projectCondition.setDirSeq(dirSeq);
			}
			projectCondition.setDeptName(null);
		}
		if (projectCondition.getCheckDirName2() != "" && projectCondition.getCheckDirName2() != null) {
			projectCondition.setDeptId(null);
			projectCondition.setDirSeq(projectCondition.getCheckDirName2());
			projectCondition.setDeptName(null);
		}

		// 用户权限判断
		UserLoginBo userLoginBo = SessionLocal.getSessionLocal(SessionLocalEnum.USER_LOGIN_INFO);
		projectCondition.setUserId(userLoginBo.getUserId());
		projectCondition.setLoginCode(String.valueOf(CacheUtil.isAdmin(userLoginBo.getLoginCode())));
		final List<ProjectBo> newProjectBo = mapListEntry(projectDao.queryProjectByProjOperator(projectCondition),
				ProjectBo.class);
		for (final ProjectBo projectBo : newProjectBo) {
			projectBo.setStatus(ProjectStatusEnum.getType(projectBo.getStatus()));
		}
		return newProjectBo;
	}

	/* (non-Javadoc)
	 * @see com.rionsoft.rcms.biz.project.IProjectBiz#userInProjectByProjOperator(long)
	 */
	@Override
	public List<ProjectBo> userInProjectByProjOperator(long userId,String loginCode) {
		return mapListEntry(projectDao.userInProjectByProjOperator(userId,loginCode), ProjectBo.class);
	}
}
