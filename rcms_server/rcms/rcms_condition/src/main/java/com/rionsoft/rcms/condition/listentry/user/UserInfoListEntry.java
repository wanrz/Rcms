/**
 *
 */
package com.rionsoft.rcms.condition.listentry.user;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.rionsoft.support.condition.IListEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author likeke
 * @date 2017年4月14日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class UserInfoListEntry implements IListEntry {

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
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date entryDate;
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
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date graduateDate;
	/* 参加工作时间 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startWorkDate;
	/* 出生日期 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthday;
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
	private Integer dirId;
	/* 部门名称 */
	private String dirName;
	/* 部门岗位 */
	private String deptPosition;
	/* 岗位级别 */
	private String positionDegree;
	/* 上岗时间 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date positionTime;
	/* 合同类别 */
	private String contractType;
	/* 合同开始时间 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date contractStartTime;
	/* 合同终止时间 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date contractEndTime;
	/* 职工类别 */
	private String employeeType;
	/* 职工工资类别 */
	private String employeeWagesType;
	/* 试用开始日期 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date probationStart;
	/* 试用结束日期 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date probationEnd;

}
