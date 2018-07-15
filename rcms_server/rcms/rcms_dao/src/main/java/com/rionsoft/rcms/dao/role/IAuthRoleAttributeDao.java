/**
 *
 */
package com.rionsoft.rcms.dao.role;

import com.rionsoft.rcms.entry.role.AuthRoleAttributeEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.ITableInsertList;
import com.rionsoft.support.mybatisplugin.dao.common.core.IWholeTableQuery;

/**
 * @author likeke
 * @date 2017年4月15日
 */
public interface IAuthRoleAttributeDao extends ISingleTableDao<AuthRoleAttributeEntry>,
		IWholeTableQuery<AuthRoleAttributeEntry>, ITableInsertList<AuthRoleAttributeEntry> {
	//
}
