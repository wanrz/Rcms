package com.rionsoft.rcms.biz.role;

import java.util.List;

import com.rionsoft.rcms.bo.role.RoleDataTypeBo;

/**
 * @author <a href="1254046525@qq.com">likeke <a>
 * @date 2017-04-24
 */
public interface IAuthRoleDataBiz {
	/**
	 * 查询所有数据权限类型
	 *
	 * @author likeke
	 * @date 2017年4月24日
	 * @return List<RoleDataTypeBo>
	 */
	List<RoleDataTypeBo> queryAllData();
}
