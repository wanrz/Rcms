/**
 *
 */
package com.rionsoft.rcms.biz.workLog.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rionsoft.rcms.biz.workLog.IWorkLogImportBiz;
import com.rionsoft.rcms.entry.workLog.WorkLogEntry;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.biz.common.insertlist.ITableInsertListBiz;

/**
 * @author loujie
 * @data 2017年5月3日
 */
@Service
public class IWorkLogImportBizImpl extends BaseBiz implements IWorkLogImportBiz {

	@Autowired
	private ITableInsertListBiz iTableInsertListBiz;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.workLog.IWorkLogImportBiz#insertWorkLogList(java.
	 * util.List)
	 */
	@Override
	public void insertWorkLogList(final List<WorkLogEntry> entryList) {
		//iTableInsertListBiz.insertList(entryList, WorkLogEntry.class, false);
		iTableInsertListBiz.insertWithUnionFieldPkList(entryList, WorkLogEntry.class, false);
	}
}
