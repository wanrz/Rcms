/**
 *
 */
package com.rionsoft.rcms.bo.user;

import java.security.MessageDigest;

import com.rionsoft.support.basebo.common.file.ExcelBaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年5月9日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ExcelUserBo extends ExcelBaseBo {
	/* 用户编号 */
	private long userId;
	/* 登录名 */
	private String loginCode;
	/* 登录密码 */
	private String password;
	/* 员工姓名 */
	private String userName;
	/* 工号 */
	private String userCode;
	/* 照片 */
	private String photo;
	/* 性别 */
	private String gender;
	/* 民族 */
	private String nation;
	/* 籍贯 */
	private String nativePlace;
	/* 家庭住址 */
	private String homeAdd;
	/* 现住址 */
	private String currentAdd;
	/* 职称 */
	private String professionalRanks;
	/* 手机 */
	private String cellPhone;
	/* 电话 */
	private String officePhone;
	/* 紧急联系人 */
	private String emergencyMan;
	/* 紧急联系电话 */
	private String emergencyPhone;
	/* 家庭电话 */
	private String homePhone;
	/* 入职时间 */
	private String entryDate;
	/* 用户状态 */
	private String userStatus;
	/* 政治面貌 */
	private String politicsStatus;
	/* 学历 */
	private String education;
	/* 学位 */
	private String degree;
	/* 毕业学校 */
	private String graduateSchool;
	/* 专业 */
	private String specialty;
	/* 毕业日期 */
	private String graduateDate;
	/* 参加工作时间 */
	private String startWorkDate;
	/* 出生日期 */
	private String birthday;
	/* 身份证 */
	private String idNumber;
	/* 电子邮箱 */
	private String email;
	/* qq号 */
	private String qq;
	/* 公积金账户 */
	private String housingFundAccount;
	/* 岗位 */
	private String position;
	/* 部门 */
	private Long dirId;
	/* 部门岗位 */
	private String deptPosition;
	/* 岗位级别 */
	private String positionDegree;
	/* 上岗时间 */
	private String positionTime;
	/* 合同类别 */
	private String contractType;
	/* 合同开始时间 */
	private String contractStartTime;
	/* 合同终止时间 */
	private String contractEndTime;
	/* 职工类别 */
	private String employeeType;
	/* 职工工资类别 */
	private String employeeWagesType;
	/* 试用开始日期 */
	private String probationStart;
	/* 试用结束日期 */
	private String probationEnd;
	/* 部门名称 */
	private String dirName;
	/* 工作状态 */
	private String workStatus;
	/* 婚姻状况 */
	private String maritalStatus;
	/* 备注 */
	private String beizhu;
	/* 合同类别名称 */
	private String contractTypeName;
	/* 职工类别名称 */
	private String employeeTypeName;
	/* 职工工资类别名称 */
	private String employeeWagesTypeName;

	@Override
	public void setValue(final int i, final String s) {

		switch (i) {
		case 0:
			this.setUserName(s.trim());
			break;

		case 1:
			this.setUserCode(s.trim());
			break;

		case 2:
			this.setDirName(s.trim());
			break;

		case 3:
			this.setPassword(MD5(s.trim()));
			break;

		case 4:
			this.setLoginCode(s.trim());
			break;
		case 5:
			this.setGender(s.trim());
			break;
		case 6:
			this.setProfessionalRanks(s.trim());
			break;

		case 7:
			this.setOfficePhone(s.trim());
			break;

		case 8:
			this.setCellPhone(s.trim());
			break;

		case 9:
			this.setEntryDate(s.trim());
			break;

		case 10:
			this.setPosition(s.trim());
			break;

		case 11:
			this.setWorkStatus(s.trim());
			break;

		case 12:
			this.setPoliticsStatus(s.trim());
			break;

		case 13:
			this.setMaritalStatus(s.trim());
			break;

		case 14:
			this.setDegree(s.trim());
			break;

		case 15:
			this.setEducation(s.trim());
			break;

		case 16:
			this.setStartWorkDate(s.trim());
			break;

		case 17:
			this.setBirthday(s.trim());
			break;

		case 18:
			this.setIdNumber(s.trim());
			break;

		case 19:
			this.setEmergencyPhone(s.trim());
			break;

		case 20:
			this.setNation(s.trim());
			break;

		case 21:
			this.setEmergencyMan(s.trim());
			break;

		case 22:
			this.setEmail(s.trim());
			break;

		case 23:
			this.setQq(s.trim());
			break;

		case 24:
			this.setGraduateSchool(s.trim());
			break;

		case 25:
			this.setSpecialty(s.trim());
			break;

		case 26:
			this.setNativePlace(s.trim());
			break;
		case 27:
			this.setHomeAdd(s.trim());
			break;
		case 28:
			this.setBeizhu(s.trim());
			break;

		case 29:
			this.setHomePhone(s.trim());
			break;

		case 30:
			this.setHousingFundAccount(s.trim());
			break;

		case 31:
			this.setDeptPosition(s.trim());
			break;

		case 32:
			this.setPositionDegree(s.trim());
			break;

		case 33:
			this.setPositionTime(s.trim());
			break;

		case 34:
			this.setContractType(s.trim());
			break;

		case 35:
			this.setContractStartTime(s.trim());
			break;

		case 36:
			this.setContractEndTime(s.trim());
			break;

		case 37:
			this.setEmployeeType(s.trim());
			break;

		case 38:
			this.setEmployeeWagesType(s.trim());
			break;
		case 39:
			this.setProbationStart(s.trim());
			break;
		case 40:
			this.setProbationEnd(s.trim());
			break;

		case 41:
			this.setGraduateDate(s.trim());
			break;
			
		case 42:
			this.setCurrentAdd(s.trim());
			break;

		default:
			break;
		}
	}

	@SuppressWarnings({ "javadoc" })
	public static String MD5(final String inStr) {
		if (inStr == null || inStr == "") {
			return inStr;
		}
		MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (final Exception e) {
			System.out.println(e.toString());
			e.printStackTrace();
			return "";
		}
		final char[] charArray = inStr.toCharArray();
		final byte[] byteArray = new byte[charArray.length];

		for (int i = 0; i < charArray.length; i++) {
			byteArray[i] = (byte) charArray[i];
		}

		final byte[] md5Bytes = md5.digest(byteArray);

		final StringBuffer hexValue = new StringBuffer();

		for (int i = 0; i < md5Bytes.length; i++) {
			final int val = (md5Bytes[i]) & 0xff;
			if (val < 16) {
				hexValue.append("0");
			}
			hexValue.append(Integer.toHexString(val));
		}

		return hexValue.toString();
	}
}
