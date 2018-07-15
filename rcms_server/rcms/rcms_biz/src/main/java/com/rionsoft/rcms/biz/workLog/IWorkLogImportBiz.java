/**
 *
 */
package com.rionsoft.rcms.biz.workLog;

import java.util.List;

import com.rionsoft.rcms.entry.workLog.WorkLogEntry;

/**
 * @author loujie
 * @data 2017年5月3日
 */
public interface IWorkLogImportBiz {

	/**
	 * 批量插入日志
	 * 
	 * @author loujie
	 * @data 2017年5月3日
	 * @param entryList
	 */
	void insertWorkLogList(List<WorkLogEntry> entryList);

}
