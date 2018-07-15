package com.rionsoft.rcms.bo.role;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author <a href="1254046525@qq.com">likeke <a>
 * @date 2017-04-24
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AuthRoleDataBo extends BaseBo {
	private Long roleId;
	private Long dataId;
}
