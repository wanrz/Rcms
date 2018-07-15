/**
 *
 */
package com.rionsoft.rcms.biz.util;

import java.util.List;

import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONArray;
import net.sf.json.util.JSONUtils;

/**
 *
 * @author <a href="mailto:dailycode@163.com"> liyw <a><br>
 *         2016年12月28日
 *
 */
public final class JsonUtil {

	static {
		final String[] dateFormats = new String[] { "yyyy-MM-dd" };
		JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(dateFormats));
	}

	/**
	 * 将json数组转成集合对象
	 *
	 * @param jsonString
	 * @param clazz
	 * @return 集合
	 */
	@SuppressWarnings("unchecked")
	public static <E> List<E> toCollection(final String jsonString, final Class<E> clazz) {
		return (List<E>) JSONArray.toCollection(JSONArray.fromObject(jsonString), clazz);
	}

}
