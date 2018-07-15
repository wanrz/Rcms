/**
 *
 */
package com.rionsoft.rcms.biz.workLoadAccount.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import com.rionsoft.rcms.biz.workLoadAccount.IWorkLoadAccountBiz;
import com.rionsoft.rcms.condition.workLoadAccount.WorkLoadCondition;
import com.rionsoft.rcms.condition.workLoadAccount.WorkLoadListEntry;
import com.rionsoft.rcms.dao.workLoadAccount.IWorkLoadAccountDao;
import com.rionsoft.support.basebo.session.UserLoginBo;
import com.rionsoft.support.basebo.view.ExportFileBo;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.biz.common.constants.SessionConstant;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;
import com.rionsoft.support.mybatisplugin.dao.util.PropertyPlaceholderUtils;

/**
 * @author linzhiqiang
 * @date 2017年5月2日
 */
@Service
public class WorkLoadAccountBizImpl extends BaseBiz implements IWorkLoadAccountBiz {
	@Autowired
	private IWorkLoadAccountDao workLoadAccountDao;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.workLoadAccount.IWorkLoadAccountBiz#workLoadQuery(
	 * com.rionsoft.rcms.condition.workLoadAccount.WorkLoadCondition)
	 */

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.workLoadAccount.WorkLoadAccountBiz#
	 * workLoadQueryByMonth(com.rionsoft.rcms.condition.workLoadAccount.
	 * WorkLoadCondition)
	 */
	@Override
	public List<WorkLoadListEntry> workLoadQuery(final WorkLoadCondition condition, final HttpServletRequest req) {
		if (condition.getCheckDirName() != "" && condition.getCheckDirName() != null) {
			condition.setDeptId(null);
			final String dirSeq = condition.getCheckDirName();
			if (dirSeq.contains("|")) {
				condition.setDirSeq(dirSeq.substring(dirSeq.lastIndexOf("|") + 1));
			} else {
				condition.setDirSeq(dirSeq);
			}
			condition.setDeptName(null);
		}
		if (condition.getCheckDirName2() != "" && condition.getCheckDirName2() != null) {
			condition.setDeptId(null);
			condition.setDirSeq(condition.getCheckDirName2());
			condition.setDeptName(null);
		}
		// 用户权限判断
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		final String adminLoginCode = PropertyPlaceholderUtils.getContextProperty("adminLoginCode");
		final UserLoginBo bo = (UserLoginBo) WebUtils.getSessionAttribute(req, SessionConstant.ADMIN_LOGIN.name());
		condition.setUserId(userId);
		condition.setAdminLoginCode(adminLoginCode);
		condition.setLoginCode(bo.getLoginCode());
		final List<WorkLoadListEntry> oldLoadEntryList = workLoadAccountDao.queryWorkLoadByDataCode(condition);
		final List<WorkLoadListEntry> newLoadEntryList = patchUpForm(oldLoadEntryList);
		return newLoadEntryList;
	}

	/**
	 * 拼凑生成列表
	 *
	 * @author sungantao
	 * @date 2017年9月11日
	 * @param oldLoadEntryList
	 * @return 工作量统计信息
	 */
	public List<WorkLoadListEntry> patchUpForm(final List<WorkLoadListEntry> oldLoadEntryList) {
		final List<WorkLoadListEntry> newLoadEntryList = new ArrayList<WorkLoadListEntry>();
		// 计算每个项目的工作量
		if (oldLoadEntryList.size() > 0) {
			// 项目排序
			Double workTimeTotal = 0.0;
			Double overWorkTimeTotal = 0.0;
			for (final WorkLoadListEntry oldEntry : oldLoadEntryList) {
				workTimeTotal += oldEntry.getWorkTime();
				overWorkTimeTotal += oldEntry.getOverWorkTime();
				if (!newLoadEntryList.isEmpty()) {
					if (oldEntry.getPkProj() != newLoadEntryList.get(newLoadEntryList.size() - 1).getPkProj()) {
						final WorkLoadListEntry total1 = new WorkLoadListEntry();
						final WorkLoadListEntry total2 = new WorkLoadListEntry();
						final String projTotal = "项目小计";
						total1.setUserName(projTotal);
						total1.setWorkTime(workTimeTotal - oldEntry.getWorkTime());
						total1.setOverWorkTime(overWorkTimeTotal - oldEntry.getOverWorkTime());
						final Double count1 = (workTimeTotal - oldEntry.getWorkTime())
								+ (overWorkTimeTotal - oldEntry.getOverWorkTime());
						total1.setCount(count1);
						newLoadEntryList.add(total1);

						final String projTotalWithUnit = "项目小计(人/月)";
						total2.setUserName(projTotalWithUnit);
						total2.setWorkTime(Double.parseDouble(
								String.format("%.2f", (workTimeTotal - oldEntry.getWorkTime()) / (8 * 21.75))));
						total2.setOverWorkTime(Double.parseDouble(
								String.format("%.2f", (overWorkTimeTotal - oldEntry.getOverWorkTime()) / (8 * 21.75))));
						final Double count2 = Double.parseDouble(
								String.format("%.2f", (workTimeTotal - oldEntry.getWorkTime()) / (8 * 21.75)))
								+ Double.parseDouble(String.format("%.2f",
										(overWorkTimeTotal - oldEntry.getOverWorkTime()) / (8 * 21.75)));
						total2.setCount(Double.parseDouble(String.format("%.2f", count2)));
						newLoadEntryList.add(total2);

						workTimeTotal = oldEntry.getWorkTime();
						overWorkTimeTotal = oldEntry.getOverWorkTime();
					}

				}
				newLoadEntryList.add(oldEntry);
			}
			// 最后增加两行
			final WorkLoadListEntry total3 = new WorkLoadListEntry();
			final WorkLoadListEntry total4 = new WorkLoadListEntry();
			final String projTotal = "项目小计";
			total3.setUserName(projTotal);
			total3.setWorkTime(workTimeTotal);
			total3.setOverWorkTime(overWorkTimeTotal);
			final Double count3 = workTimeTotal + overWorkTimeTotal;
			total3.setCount(count3);
			newLoadEntryList.add(total3);

			final String projTotalWithUnit = "项目小计(人/月)";
			total4.setUserName(projTotalWithUnit);
			total4.setWorkTime(Double.parseDouble(String.format("%.2f", workTimeTotal / (8 * 21.75))));
			total4.setOverWorkTime(Double.parseDouble(String.format("%.2f", overWorkTimeTotal / (8 * 21.75))));
			final Double count4 = Double.parseDouble(String.format("%.2f", workTimeTotal / (8 * 21.75)))
					+ Double.parseDouble(String.format("%.2f", overWorkTimeTotal / (8 * 21.75)));
			total4.setCount(Double.parseDouble(String.format("%.2f", count4)));
			newLoadEntryList.add(total4);

			workTimeTotal = 0.0;
			overWorkTimeTotal = 0.0;

		}
		return newLoadEntryList;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.workLoadAccount.IWorkLoadAccountBiz#
	 * exportWorkAccount()
	 */
	@Override
	public ExportFileBo<Map<String, Object>> exportWorkAccount(final HttpServletRequest req) {
		// 根据权限查找相应数据
		final WorkLoadCondition condition = new WorkLoadCondition();
		final Long userId = SessionLocal.getSessionLocal(SessionLocalEnum.LOGIN_USER_ID);
		final String adminLoginCode = PropertyPlaceholderUtils.getContextProperty("adminLoginCode");
		final UserLoginBo bo = (UserLoginBo) WebUtils.getSessionAttribute(req, SessionConstant.ADMIN_LOGIN.name());
		condition.setUserId(userId);
		condition.setAdminLoginCode(adminLoginCode);
		condition.setLoginCode(bo.getLoginCode());
		final List<Map<String, Object>> listMap = workLoadAccountDao.queryWorkAccountExprot(condition);
		final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String s = null;
		try {
			for (final Map<String, Object> map : listMap) {
				s = sdf.format(sdf.parse((String) map.get("yearMonth")));
				System.out.println(sdf.format(sdf.parse((String) map.get("yearMonth"))));
				map.put("yearMonth", s);
			}
		} catch (final ParseException e) {
			e.printStackTrace();
		}

		final String[] fieldNames = { "yearMonth", "projCode", "projName", "userName", "workTime", "overWorkTime" };
		final String[] columnName = { "月份", "项目编号", "项目名称", "人员名称", "正常工时", "加班工时", "合计" };
		final LinkedHashMap<String, String> fieldMap = new LinkedHashMap<>();

		for (int i = 0; i < fieldNames.length; i++) {
			fieldMap.put(fieldNames[i], columnName[i]);
		}

		final String sheetName = "工作量统计表";
		final String fileName = "工作量统计详情";
		final String fileType = "xlsx";
		final ExportFileBo<Map<String, Object>> fileBo = new ExportFileBo<Map<String, Object>>(fileName, fileType);
		fileBo.setDataList(listMap);
		fileBo.setFieldMap(fieldMap);
		fileBo.setSheetName(sheetName);
		return fileBo;
	}

}
