/**
 *
 */
package com.rionsoft.rcms.biz.user.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.util.WebUtils;

import com.rionsoft.rcms.biz.constant.RCMSExceptionCodeEnum;
import com.rionsoft.rcms.biz.role.IAuthRoleBiz;
import com.rionsoft.rcms.biz.task.ITaskImportBiz;
import com.rionsoft.rcms.biz.user.IUserInfoBiz;
import com.rionsoft.rcms.bo.constant.UserEnum;
import com.rionsoft.rcms.bo.user.ExcelUserBo;
import com.rionsoft.rcms.bo.user.UserInfoBo;
import com.rionsoft.rcms.condition.listentry.user.UserInfoListEntry;
import com.rionsoft.rcms.condition.user.UserCondition;
import com.rionsoft.rcms.dao.department.IAuthDirDao;
import com.rionsoft.rcms.dao.project.IProjectRecourceRefDao;
import com.rionsoft.rcms.dao.user.IUserInfoDao;
import com.rionsoft.rcms.dao.workLog.IWorkLogDao;
import com.rionsoft.rcms.entry.department.AuthDirEntry;
import com.rionsoft.rcms.entry.role.AuthDataTypeEntry;
import com.rionsoft.rcms.entry.user.UserInfoEntry;
import com.rionsoft.support.basebo.common.file.FileUploadBo;
import com.rionsoft.support.basebo.session.UserLoginBo;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.biz.common.constants.SessionConstant;
import com.rionsoft.support.biz.common.error.RionsoftException;
import com.rionsoft.support.biz.util.SysFilePathPropertyUtil;
import com.rionsoft.support.biz.util.excel.FileUtils;
import com.rionsoft.support.biz.util.excel.ReadExcelUtils;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;
import com.rionsoft.support.mybatisplugin.dao.util.PropertyPlaceholderUtils;

/**
 * @author likeke
 * @date 2017年4月17日
 */
@Service
public class UserInfoBizImpl extends BaseBiz implements IUserInfoBiz {
	@Autowired
	private IUserInfoDao userInfoDao;
	@Autowired
	private IAuthRoleBiz authRoleBizImpl;
	@Autowired
	private IAuthDirDao authDirDaoImpl;
	@Autowired
	private ITaskImportBiz importBiz;
	@Autowired
	private IWorkLogDao workLogDao;
	@Autowired
	private IProjectRecourceRefDao projectRecourceRefDaoImpl;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.user.IUserInfoBiz#saveUserInfo(com.rionsoft.rcms.bo
	 * .user.UserInfoBo)
	 */
	@Override
	@Transactional
	public void addUserInfo(final UserInfoBo bo, final HttpServletRequest request, final List<Long> roleId) {
		final Map<String, FileUploadBo> uploadFileMap = SessionLocal.getSessionLocal(SessionLocalEnum.UPLOAD_FILE);
		final FileUploadBo userPhoto = uploadFileMap.get("userPhoto");
		if (userPhoto != null && userPhoto.getFileSize() > 0) {
			bo.setPhoto(savePhoto(userPhoto, request));
		}
		final int loginCodeCount = userInfoDao.queryLoginCodeCount(bo.getLoginCode());
		if (loginCodeCount != 0) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0321, false, bo.getLoginCode());
		}
		final UserInfoEntry entry = map(bo, UserInfoEntry.class);
		entry.setUserStatus(UserEnum.UserStatusEnum.EFFECTIVE.getCode());
		userInfoDao.insert(entry);
		authRoleBizImpl.userRoleAdd(roleId, entry.getUserId());

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.user.IUserInfoBiz#queryByCondition(com.rionsoft.
	 * rcms.condition.user.UserCondition, javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public List<UserInfoListEntry> queryByCondition(final UserCondition userCondition, final HttpServletRequest req) {
		if (userCondition.getCheckDirName() != "" && userCondition.getCheckDirName() != null) {
			userCondition.setDirId(null);
			userCondition.setDirSeq(userCondition.getCheckDirName());
			userCondition.setDirName(null);
		}
		if (userCondition.getCheckDirName2() != "" && userCondition.getCheckDirName2() != null) {
			userCondition.setDirId(null);
			userCondition.setDirName(null);
		}
		// 用户权限判断
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		final String adminLoginCode = PropertyPlaceholderUtils.getContextProperty("adminLoginCode");
		final UserLoginBo bo = (UserLoginBo) WebUtils.getSessionAttribute(req, SessionConstant.ADMIN_LOGIN.name());
		userCondition.setUserIds(userId);
		userCondition.setLoginCodes(bo.getLoginCode());
		userCondition.setAdminLoginCode(adminLoginCode);
		return userInfoDao.queryByDataCode(userCondition);
	}

	/**
	 * 保存照片
	 *
	 * @param userPhoto
	 * @param request
	 * @return 照片路径。如果userPhoto为空，返回null
	 */
	private String savePhoto(final FileUploadBo userPhoto, final HttpServletRequest request) {
		if (userPhoto == null) {
			return null;
		}
		/*
		 * 文件名称暂定为用户UUID+xls。如： ffde9f679a904cb2a7166ab04e5cd74e.jpg
		 */
		final String fileName = UUID.randomUUID().toString() + userPhoto.FILE_DOT + userPhoto.getFileType();
		final String photoRootPath = SysFilePathPropertyUtil.getProperty("photo") + File.separator;
		/* 服务器保存目录路径 */
		final String fileDir = request.getSession().getServletContext().getRealPath("") + photoRootPath;
		FileUtils.copy(userPhoto.getTempFile(), fileDir + fileName);
		return photoRootPath + fileName;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.user.IUserInfoBiz#deletUser(java.util.List)
	 */
	@Override
	public void deletUser(final List<Long> userId) {
		userInfoDao.deleteByIds(userId);
		authRoleBizImpl.deleteUserRoleByIds(userId);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.user.IUserInfoBiz#querById(java.lang.Long)
	 */
	@Override
	public UserInfoBo querById(final Long userId) {
		final UserInfoBo bo = map(userInfoDao.queryByID(userId), UserInfoBo.class);
		bo.setDirName(authDirDaoImpl.queryByID(bo.getDirId()).getDirName());
		return bo;

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.user.IUserInfoBiz#userUpdate(com.rionsoft.rcms.bo.
	 * user.UserInfoBo, javax.servlet.http.HttpServletRequest, java.util.List)
	 */
	@Override
	@Transactional
	public void userUpdate(final UserInfoBo userInfoBo, final HttpServletRequest request, final List<Long> roleId,
			final String oldPhoto) {
		final Map<String, FileUploadBo> uploadFileMap = SessionLocal.getSessionLocal(SessionLocalEnum.UPLOAD_FILE);
		final FileUploadBo userPhoto = uploadFileMap.get("userPhoto");

		if (userPhoto != null && userPhoto.getFileSize() > 0) {
			final String filePath1 = request.getSession().getServletContext().getRealPath("") + oldPhoto;
			final File fileOld = new File(filePath1);
			fileOld.delete();
			userInfoBo.setPhoto(savePhoto(userPhoto, request));
		} else {
			userInfoBo.setPhoto(oldPhoto);
		}
		userInfoBo.setUserStatus(UserEnum.UserStatusEnum.EFFECTIVE.getCode());
		userInfoDao.update(map(userInfoBo, UserInfoEntry.class));
		authRoleBizImpl.userRoleUpdate(roleId, userInfoBo.getUserId());

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.user.IUserInfoBiz#userArchive(java.util.List)
	 */
	@Override
	public void userArchive(final List<Long> userId, final String userStatus) {
		if (!userId.isEmpty()) {
			userInfoDao.userArchive(userId, userStatus);
		}

	}

	@Override
	public int userExcel(final FileUploadBo fileUploadBo) {
		final List<ExcelUserBo> boList = ReadExcelUtils.readNormalTempleteExcel(fileUploadBo.getTempFile(),
				ExcelUserBo.class);
		if (CollectionUtils.isEmpty(boList)) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0301, false);
		}
		final List<UserInfoEntry> entryList = mapToEntryList(boList, UserInfoEntry.class);
		final List<String> exist = userInfoDao.selectExist(entryList);
		if (CollectionUtils.isNotEmpty(exist)) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0447, false, exist.get(0));
		}

		final List<AuthDirEntry> dirList = userInfoDao.queryAuthDir();
		Map<String, Long> dirMap = new HashMap<>();
		for (final AuthDirEntry dir : dirList) {
			dirMap.put(String.valueOf(dir.getDirName()),dir.getDirId());
		}
		// final List<BdDictDetailEntry> contractList =
		// userInfoDao.queryContract();
		// final List<BdDictDetailEntry> employeeList =
		// userInfoDao.queryEmployee();
		// final List<BdDictDetailEntry> wagesList = userInfoDao.queryWages();
		for (final ExcelUserBo bo : boList) {
			bo.setUserStatus("1");
			/** 验证人员姓名不能为空 **/
			if (StringUtils.isEmpty(bo.getUserName())) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0401, false);
			}
			/** 验证人员姓名长度 **/
			if (bo.getUserName().length() > 13) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0402, false, bo.getUserName());
			}
			/** 验证登录名不能为空 **/
			if (StringUtils.isEmpty(bo.getLoginCode())) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0403, false);
			}
			/** 验证登录名长度不超过20 **/
			if (bo.getLoginCode().length() > 20) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0404, false, bo.getLoginCode());
			}
			/** 验证工号不能为空 **/
			if (StringUtils.isEmpty(bo.getUserCode())) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0405, false);
			}
			/** 员工号格式不正确 **/
			if (!bo.getUserCode().matches("[a-zA-Z0-9_]{0,20}$")) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0406, false);
			}

			/** 验证工号是否只是由字母数字和下划线组成 **/
			// final String codeEL = "^[0-9]*$";
			// final Pattern codePattern = Pattern.compile(codeEL);
			// final Matcher code = codePattern.matcher(bo.getUserCode());
			//
			// final boolean codeFlag = code.matches();
			//
			// if (!codeFlag) {
			// throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0407,
			// bo.getUserCode());
			// }
			/** 部门不能为空*/
			if (StringUtils.isEmpty(bo.getDirName())) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0407, false, bo.getUserCode());
			}
			/** 部门不存在或部门填写错误*/
			if ((dirMap.get(bo.getDirName())) == null) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0458, false, bo.getUserCode());
			}
			for (final AuthDirEntry entry : dirList) {
				if (bo.getDirName().equals(entry.getDirName())) {
					bo.setDirId(entry.getDirId());
				}
			}
			/** 密码不能为空 **/
			if (StringUtils.isEmpty(bo.getPassword())) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0408, false, bo.getUserName());
			}
			/** 密码格式 **/
			if (!bo.getPassword().matches("[a-zA-Z0-9_]{1,50}$")) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0409, false, bo.getUserName());
			}
			/** 验证性别长度 **/
			if (StringUtils.isNotEmpty(bo.getGender()) && bo.getGender().length() > 2) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0412, false, bo.getUserName());
			}

			/** 入职日期不能为空 */
			if (StringUtils.isEmpty(bo.getEntryDate())) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0454, false, bo.getUserName());
			}
			/** 入职日期格式不正确**/
			if (!bo.getEntryDate().matches("((?:19|20)\\d\\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$")) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0455, false, bo.getUserName());
			}
			/**电话长度过长**/
			if (StringUtils.isNotEmpty(bo.getOfficePhone()) && bo.getOfficePhone().length() > 20) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0414, false, bo.getUserName());
			}
			// final String dateEL = "[0-9]{4}-[0-9]{2}-[0-9]{2}";
			// final Pattern p = Pattern.compile(dateEL);
			// final Matcher entryDate = p.matcher(bo.getEntryDate());
			// final boolean entryDateFlag = entryDate.matches();
			// if (!entryDateFlag) {
			// throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0415,
			// bo.getUserCode());
			// }
			/** 验证岗位长度 **/
			if (StringUtils.isNotEmpty(bo.getPosition()) && bo.getPosition().length() > 10) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0416, false, bo.getUserCode());
			}
			/** 验证工作状态长度 **/
			if (StringUtils.isNotEmpty(bo.getWorkStatus()) && bo.getWorkStatus().length() > 20) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0417, false, bo.getUserCode());
			}
			/** 验证政治面貌长度 **/
			if (StringUtils.isNotEmpty(bo.getPoliticsStatus()) && bo.getPoliticsStatus().length() > 10) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0418, false, bo.getUserCode());
			}
			/** 验证婚姻状况长度 **/
			if (StringUtils.isNotEmpty(bo.getMaritalStatus()) && bo.getMaritalStatus().length() > 10) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0419, false, bo.getUserCode());
			}
			/** 验证学位长度 **/
			if (StringUtils.isNotEmpty(bo.getDegree()) && bo.getDegree().length() > 3) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0420, false, bo.getUserCode());
			}
			/** 验证学历长度 **/
			if (StringUtils.isNotEmpty(bo.getEducation()) && bo.getEducation().length() > 10) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0421, false, bo.getUserCode());
			}

			/** 验证紧急联系电话长度 **/
			if (StringUtils.isNotEmpty(bo.getEmergencyPhone()) && bo.getEmergencyPhone().length() > 20) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0423, false, bo.getUserCode());
			}
			/** 验证身份证长度 **/
			if (StringUtils.isNotEmpty(bo.getIdNumber())) {
				if (!bo.getIdNumber().matches(
						"[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$|^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|[xX])$")) {
					throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0439, false, bo.getUserCode(),
							bo.getIdNumber());
				}
			}
			/** 验证手机号不能为空 **/
			if (StringUtils.isEmpty(bo.getCellPhone())) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0469, false, bo.getUserCode(),
						bo.getIdNumber());
			}
			/** 验证手机号格式是否正确 **/
			if (!bo.getCellPhone().matches("^[1][0-9]{10}$")) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0470, false, bo.getUserCode(),
						bo.getIdNumber());
			}
			/** 民族不能为空 **/
			if (StringUtils.isEmpty(bo.getNation())) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0441, false, bo.getUserCode());
			}
			/** 验证民族长度 **/
			if (bo.getNation().length() > 20) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0442, false, bo.getUserCode());
			}
			/** 验证联系人长度 **/
			if (StringUtils.isNotEmpty(bo.getEmergencyMan()) && bo.getEmergencyMan().length() > 6) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0425, false, bo.getUserCode());
			}
			/** 验证邮箱长度 **/
			if (StringUtils.isNotEmpty(bo.getEmail()) && bo.getEmail().length() > 30) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0426, false, bo.getUserCode());
			}
			/** qq账号 **/
			if (StringUtils.isNotEmpty(bo.getQq()) && bo.getQq().length() > 30) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0427, false, bo.getUserCode());
			}
			/** 毕业学校 **/
			if (StringUtils.isNotEmpty(bo.getGraduateSchool()) && bo.getGraduateSchool().length() > 16) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0428, false, bo.getUserCode());
			}

			/** 所学专业 **/
			if (StringUtils.isNotEmpty(bo.getSpecialty()) && bo.getSpecialty().length() > 16) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0429, false, bo.getUserCode());
			}
			/** 籍贯不能为空 **/
			if (StringUtils.isEmpty(bo.getNativePlace())) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0430, false, bo.getUserCode());
			}
			/** 籍贯长度 **/
			if (bo.getNativePlace().length() > 65) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0431, false, bo.getUserCode());
			}
			/** 家庭住址不能为空 **/
			if (StringUtils.isEmpty(bo.getHomeAdd())) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0459, false, bo.getUserCode());
			}
			/** 家庭住址 **/
			if (bo.getHomeAdd().length() > 33) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0460, false, bo.getUserCode());
			}
			/** 现住址不能为空 **/
			if (StringUtils.isEmpty(bo.getCurrentAdd())) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0456, false, bo.getUserCode());
			}
			/** 现住址长度 **/
			if (bo.getCurrentAdd().length() > 33) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0457, false, bo.getUserCode());
			}
			/** 家庭电话 **/
			if (StringUtils.isNotEmpty(bo.getHomePhone()) && bo.getHomePhone().length() > 20) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0432, false, bo.getUserCode());
			}
			/** 住房公积金账号 **/
			if (StringUtils.isNotEmpty(bo.getHousingFundAccount()) && bo.getHousingFundAccount().length() > 30) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0433, false, bo.getUserCode());
			}
			/** 部门岗位长度 **/
			if (StringUtils.isNotEmpty(bo.getDeptPosition()) && bo.getDeptPosition().length() > 6) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0434, false, bo.getUserCode());
			}
			/** 岗位级别长度 **/
			if (StringUtils.isNotEmpty(bo.getPositionDegree()) && bo.getPositionDegree().length() > 10) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0435, false, bo.getUserCode());
			}
			/** 合同开始日期不能为空 */
			if (StringUtils.isEmpty(bo.getContractStartTime())) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0461, false, bo.getUserCode());
			}
			/** 合同开始日期格式 **/
			if (!bo.getContractStartTime().matches("((?:19|20)\\d\\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$")) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0462, false, bo.getUserCode());
			}

			if (StringUtils.isNotEmpty(bo.getContractEndTime())) {
				/** 合同结束日期 **/
				if (!bo.getContractEndTime().matches("((?:19|20)\\d\\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$")) {
					throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0463, false, bo.getUserCode());
				}
				/** 合同结束日期必须大于合同开始日期 **/
				if (bo.getContractEndTime().compareTo(bo.getContractStartTime()) < 0) {
					throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0464, false, bo.getUserCode());
				}

			}
			/** 试用开始日期 **/
			if (StringUtils.isNotEmpty(bo.getProbationStart())) {
				if (!bo.getProbationStart()
						.matches("((?:19|20)\\d\\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$")) {
					throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0465, false, bo.getUserCode());
				}
			}
			/** 试用结束日期 **/
			if (StringUtils.isNotEmpty(bo.getProbationEnd())) {
				if (!bo.getProbationEnd().matches("((?:19|20)\\d\\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$")) {
					throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0466, false, bo.getUserCode());
				}

				/** 试用结束日期必须大于试用开始日期 **/
				if (StringUtils.isNotEmpty(bo.getProbationStart()) && bo.getProbationEnd().compareTo(bo.getProbationStart()) < 0) {
					throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0467, false, bo.getUserCode());
				}

			}
			/** 合同类别 **/
			if (StringUtils.isNotEmpty(bo.getContractType()) && bo.getContractType().length() > 20) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0436, false, bo.getUserCode());
			}
			/** 职工类别 **/
			if (StringUtils.isNotEmpty(bo.getEmployeeType()) && bo.getEmployeeType().length() > 20) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0437, false, bo.getUserCode());
			}
			/** 职工工资类别 **/
			if (StringUtils.isNotEmpty(bo.getEmployeeWagesType()) && bo.getEmployeeWagesType().length() > 20) {
				throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0438, false, bo.getUserCode());
			}
			if (bo.getGender().equals("男")) {
				bo.setGender("00");
			} else if (bo.getGender().equals("女")) {
				bo.setGender("01");
			} else {
				bo.setGender("02");
			}

		}
		return importBiz.importUserList(boList);
	}

	@Override
	public UserInfoListEntry queryPassword() {
		final long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);

		return userInfoDao.queryPassword(userId);
	}

	@Override
	public void updatePassword(final long userId, final String password, final String oldPassword) {
		final UserInfoListEntry entry = userInfoDao.queryPassword(userId);
		if (oldPassword.equals(entry.getPassword())) {
			userInfoDao.updatePassword(userId, password);
		} else {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0327, false);
		}

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.user.IUserInfoBiz#userDelete(long)
	 */
	@Override
	public void userDelete(final long userId) {
		final Integer countWorkLogUser = workLogDao.queryWorkLogUserCount(userId);
		if (countWorkLogUser > 0) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0021, false);
		}
		final Integer countProjectRecourceRefUser = projectRecourceRefDaoImpl.queryProjectUserCount(userId);
		if (countProjectRecourceRefUser > 0) {
			throw new RionsoftException(RCMSExceptionCodeEnum.A_RCMSBZ0022, false);
		}
		userInfoDao.deleteByID(userId);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.user.IUserInfoBiz#queryAuthRoleByUserId(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@Override
	public List<AuthDataTypeEntry> queryAuthRoleByUserId(final UserCondition userCondition) {
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		userCondition.setUserId(userId);
		return userInfoDao.queryAuthRoleByUserId(userCondition);
	}
}
