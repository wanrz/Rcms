/**
 *
 */
package com.rionsoft.rcms.biz.common.cache;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.rionsoft.rcms.bo.role.AuthMenuBo;
import com.rionsoft.support.mybatisplugin.dao.util.PropertyPlaceholderUtils;

/**
 * @author <a href="mailto:dailycode@163.com"> liyw <a><br>
 *         2016年11月22日
 *
 */
public class CacheUtil {

	/** 系统所有菜单缓存 */
	private final static Map<String, List<AuthMenuBo>> CACHE_SYS_MENU = Collections
			.synchronizedMap(new HashMap<String, List<AuthMenuBo>>());

	/** 系统所有操作url缓存 */
	private final static Map<String, String> CACHE_SYS_NAME = Collections
			.synchronizedMap(new HashMap<String, String>());

	/**
	 * 缓存系统名称
	 *
	 * @param name
	 */
	public static void cacheSysName(final String name) {
		CACHE_SYS_NAME.put(CacheEnum.SYS_NAME_1480037854615.name(), name);
	}

	/**
	 * 缓存系统名称
	 *
	 * @return name
	 */
	public static String getSysName() {
		return CACHE_SYS_NAME.get(CacheEnum.SYS_NAME_1480037854615.name());
	}

	/**
	 * 缓存系统菜单
	 *
	 * @param menuList
	 */
	public static void cacheSysMenu(final List<AuthMenuBo> menuList) {
		CACHE_SYS_MENU.put(CacheEnum.SYS_MENU_1479869546519.name(), menuList);
	}

	/**
	 * 获取系统菜单
	 *
	 * @return 系统菜单
	 */
	public static List<AuthMenuBo> getSysMenu() {
		return CACHE_SYS_MENU.get(CacheEnum.SYS_MENU_1479869546519.name());
	}

	/**
	 * 是否是超级管理员
	 * 
	 * @author 刘教练
	 * @date 2017年10月23日
	 * @param loginCode
	 * @return true：是；fals:否
	 */
	public static boolean isAdmin(final String loginCode) {
		return StringUtils.equalsIgnoreCase(PropertyPlaceholderUtils.getContextProperty("adminLoginCode"), loginCode);
	}
}
