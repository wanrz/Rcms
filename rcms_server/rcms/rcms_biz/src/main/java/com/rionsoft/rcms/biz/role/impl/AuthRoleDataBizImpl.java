package com.rionsoft.rcms.biz.role.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rionsoft.rcms.biz.role.IAuthRoleDataBiz;
import com.rionsoft.rcms.bo.role.RoleDataTypeBo;
import com.rionsoft.rcms.dao.role.IRoleDataTypeDao;
import com.rionsoft.support.biz.BaseBiz;

/**
 * @author <a href="1254046525@qq.com">likeke <a>
 * @date 2017-04-24
 */
@Service
class AuthRoleDataBizImpl extends BaseBiz implements IAuthRoleDataBiz {
	@Autowired
	private IRoleDataTypeDao roleDataTypedao;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.rcms.biz.role.IAuthRoleDataBiz#queryAllData()
	 */
	@Override
	public List<RoleDataTypeBo> queryAllData() {

		return map(roleDataTypedao.queryAll(), RoleDataTypeBo.class);
	}
}
