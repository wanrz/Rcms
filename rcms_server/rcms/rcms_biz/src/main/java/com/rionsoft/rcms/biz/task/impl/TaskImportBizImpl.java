/**
 *
 */
package com.rionsoft.rcms.biz.task.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rionsoft.rcms.biz.task.ITaskImportBiz;
import com.rionsoft.rcms.bo.task.ExcelTaskBo;
import com.rionsoft.rcms.bo.task.TaskUserRefBo;
import com.rionsoft.rcms.bo.user.ExcelUserBo;
import com.rionsoft.rcms.entry.task.TaskEntry;
import com.rionsoft.rcms.entry.task.TaskUserRefEntry;
import com.rionsoft.rcms.entry.user.UserInfoEntry;
import com.rionsoft.support.biz.BaseBiz;
import com.rionsoft.support.biz.common.insertlist.ITableInsertListBiz;

/**
 * @author loujie
 * @data 2017年4月26日
 */
@Service
public class TaskImportBizImpl extends BaseBiz implements ITaskImportBiz {
	@Autowired
	private ITableInsertListBiz iTableInsertListBiz;

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.rionsoft.rcms.biz.task.ITaskImportBiz#importTaskList(java.util.List)
	 */
	@Override
	public int importTaskList(final List<ExcelTaskBo> boList) {
		final List<TaskEntry> entryList = mapToEntryList(boList, TaskEntry.class);
		iTableInsertListBiz.insertWithUnionFieldPkList(entryList, TaskEntry.class, false,170);
		return entryList.size();
	}

	@Override
	public int importUserList(final List<ExcelUserBo> boList) {
		final List<UserInfoEntry> entryList = mapToEntryList(boList, UserInfoEntry.class);
		iTableInsertListBiz.insertWithSingleFieldPkList(entryList, UserInfoEntry.class, false,40);
		return entryList.size();
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.task.ITaskImportBiz#addUser(java.util.List)
	 */
	@Override
	public void addUser(final List<TaskUserRefBo> boList) {
		final List<TaskUserRefEntry> entryList = mapToEntryList(boList, TaskUserRefEntry.class);
		iTableInsertListBiz.insertWithUnionFieldPkList(entryList, TaskUserRefEntry.class, true);
	}

}
