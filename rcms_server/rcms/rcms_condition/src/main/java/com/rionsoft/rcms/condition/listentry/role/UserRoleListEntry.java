/**
 *
 */
package com.rionsoft.rcms.condition.listentry.role;

import java.util.List;

import com.rionsoft.support.condition.IListEntry;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author likeke
 * @date 2017年4月17日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class UserRoleListEntry implements IListEntry {
	/* 用户ID */
	private long userId;
	/* 用户角色 */
	private List<AuthRoleListEntry> roleList;
	/* 用户角色View */
	@SuppressWarnings("unused")
	private String roleListView;
	/* 用户姓名 */
	private String userName;
	/* 登录名 */
	private String loginCode;
	/* 员工状态 */
	private String userStatus;
	/* 员工所在部门 */
	private Long dirId;
	/* 员工所在部门名称 */
	private String dirName;

	/**
	 * @author likeke
	 * @date 2017年4月18日
	 * @return 用户角色View
	 */
	public String getRoleListView() {
		final StringBuilder view = new StringBuilder();
		if (roleList != null && roleList.size() > 0) {
			for (final AuthRoleListEntry entry : roleList) {
				view.append(entry.getRoleName() + ",");
			}
			view.deleteCharAt(view.length() - 1);
		} else {
			view.append("暂未授予角色");
		}
		return view.toString();
	}
}
