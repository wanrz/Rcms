/**
 *
 */
package com.rionsoft.rcms.dao.role;

import java.util.List;

import com.rionsoft.rcms.entry.role.AuthMenuEntry;
import com.rionsoft.support.mybatisplugin.dao.common.core.ISingleTableDao;
import com.rionsoft.support.mybatisplugin.dao.common.core.IWholeTableQuery;

/**
 * @author likeke
 * @date 2017年4月24日
 */
public interface IAuthMenuDao extends ISingleTableDao<AuthMenuEntry>, IWholeTableQuery<AuthMenuEntry> {
	/**
	 * 根据用户id查询用户所有菜单信息
	 *
	 * @param userId
	 * @param loginCode
	 * @param adminLoginCode
	 * @return 资源信息
	 */
	List<AuthMenuEntry> queryAuthMenuByUserId(long userId, String loginCode, String adminLoginCode);
}
