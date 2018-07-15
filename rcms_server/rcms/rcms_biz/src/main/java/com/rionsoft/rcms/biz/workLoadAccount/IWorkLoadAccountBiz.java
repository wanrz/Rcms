/**
 *
 */
package com.rionsoft.rcms.biz.workLoadAccount;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.rionsoft.rcms.condition.workLoadAccount.WorkLoadCondition;
import com.rionsoft.rcms.condition.workLoadAccount.WorkLoadListEntry;
import com.rionsoft.support.basebo.view.ExportFileBo;

/**
 * @author linzhiqiang
 * @date 2017年5月2日
 */
public interface IWorkLoadAccountBiz {
	/**
	 * 查询日志中的考核量
	 *
	 * @author likeke
	 * @date 2017年5月2日
	 * @param condition
	 * @param req
	 * @return List<WorkLoadListEntry>
	 */
	List<WorkLoadListEntry> workLoadQuery(WorkLoadCondition condition, final HttpServletRequest req);

	/**
	 * 导出工作量统计
	 *
	 * @author sungantao
	 * @date 2017年9月19日
	 * @param req
	 * @return 工作量统计
	 */
	ExportFileBo<Map<String, Object>> exportWorkAccount(final HttpServletRequest req);

}
