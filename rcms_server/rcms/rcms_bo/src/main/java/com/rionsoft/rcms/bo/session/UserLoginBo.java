/**
 *
 */
package com.rionsoft.rcms.bo.session;

import java.io.Serializable;
import java.sql.Timestamp;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author likeke
 * @date 2017年4月25日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class UserLoginBo extends BaseBo implements Serializable {
	/**  */
	private static final long serialVersionUID = 2911120110752277089L;
	private String loginIp;
	private Long userId;
	private String loginCode;
	private String password;
	private String userCode;
	private String userName;
	private Long dirId;
	private Timestamp loginTime;
}