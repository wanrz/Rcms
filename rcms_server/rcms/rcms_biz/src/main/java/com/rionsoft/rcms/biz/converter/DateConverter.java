/**
 *
 */
package com.rionsoft.rcms.biz.converter;

import static com.rionsoft.support.biz.util.DatePattern.YYYY_MM_DD;
import static com.rionsoft.support.biz.util.DatePattern.YYYY_MM_DD_HH_MM_SS;
import static com.rionsoft.support.biz.util.DatePattern.YYYY_MM_DD_HH_MM_SS_SSS;
import static java.util.Collections.unmodifiableMap;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.dozer.CustomConverter;
import org.dozer.MappingException;
import org.springframework.util.Assert;

import com.rionsoft.support.biz.util.DatePattern;

import lombok.extern.slf4j.Slf4j;

/**
 * @author shuzijian
 * @date 2016年11月17日
 */
@Slf4j
public class DateConverter implements CustomConverter {

	private static final Map<Class<?>, Constructor<?>> DATE_CONSTRUCTOR;
	private static final Map<Class<?>, List<DatePattern>> DATE_PATTERNS_MAP;
	/**
	 *
	 */
	private static final String INIT_ERROR = "日期类型初始化失败：";

	static {
		final List<DatePattern> defaultTimePatterns = Arrays.asList(YYYY_MM_DD_HH_MM_SS_SSS, YYYY_MM_DD_HH_MM_SS,
				YYYY_MM_DD);

		final Map<Class<?>, List<DatePattern>> patternsMap = new HashMap<Class<?>, List<DatePattern>>();
		patternsMap.put(Timestamp.class, defaultTimePatterns);
		patternsMap.put(Time.class, defaultTimePatterns);

		final List<DatePattern> defaultDatePatterns = Arrays.asList(YYYY_MM_DD);
		patternsMap.put(java.sql.Date.class, defaultDatePatterns);
		patternsMap.put(Date.class, defaultDatePatterns);

		DATE_PATTERNS_MAP = unmodifiableMap(patternsMap);

		DATE_CONSTRUCTOR = unmodifiableMap(findAllCandicateConstructor(DATE_PATTERNS_MAP.keySet()));
	}

	/**
	 * 找到所有日期类型的可选构造函数，这些public构造函数必须带一个小写long型参数，否则不支持
	 *
	 * @param wholeSupportDateType
	 *            所有支持的日期类型
	 * @return 这些日期类型的构造函数映射
	 */
	private static Map<Class<?>, Constructor<?>> findAllCandicateConstructor(final Set<Class<?>> wholeSupportDateType) {
		final Map<Class<?>, Constructor<?>> constructMap = new HashMap<Class<?>, Constructor<?>>();
		for (final Class<?> dateType : wholeSupportDateType) {
			Constructor<?> longConstructor = null;
			final Constructor<?>[] constructors = dateType.getConstructors();
			for (final Constructor<?> constructor : constructors) {
				final Class<?>[] parameters = constructor.getParameterTypes();
				if (Arrays.equals(parameters, new Class<?>[] { Long.TYPE })) {
					longConstructor = constructor;
					break;
				}
			}
			Assert.notNull(longConstructor, "日期类型必须有一个带long型参数的构造函数");

			constructMap.put(dateType, longConstructor);
		}
		return constructMap;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see org.dozer.CustomConverter#convert(java.lang.Object,
	 * java.lang.Object, java.lang.Class, java.lang.Class)
	 */
	@Override
	public Object convert(final Object existingDestinationFieldValue, final Object sourceFieldValue,
			final Class<?> destinationClass, final Class<?> sourceClass) {
		if ((sourceFieldValue == null)
				|| ((sourceFieldValue instanceof java.lang.String) && StringUtils.isBlank((String) sourceFieldValue))) {
			return null;
		}
		if (sourceFieldValue instanceof java.lang.String) {
			return convertFromString((String) sourceFieldValue, destinationClass);
		} else if (sourceFieldValue instanceof java.util.Date) {
			return convertFromDate((Date) sourceFieldValue);
		}

		throw new MappingException("Can't convert from(" + sourceFieldValue + " to " + destinationClass.getName()
				+ ") with converter (" + this.getClass().getName() + ")!");
	}

	/**
	 * 从Date转换对象
	 *
	 * @param sourceFieldValue
	 *            待转换对象
	 * @return 字符串
	 */
	private Object convertFromDate(final Date sourceFieldValue) {
		if (sourceFieldValue instanceof java.sql.Timestamp) {
			return YYYY_MM_DD_HH_MM_SS_SSS.format(sourceFieldValue);
		}
		return YYYY_MM_DD.format(sourceFieldValue);
	}

	/**
	 * 从String转换对象
	 *
	 * @param sourceFieldValue
	 *            待转换对象
	 * @param destinationClass
	 *            目标对象类型
	 * @return 日期
	 */
	private Date convertFromString(final String sourceFieldValue, final Class<?> destinationClass) {
		Assert.isTrue(DATE_PATTERNS_MAP.containsKey(destinationClass), "不可接受的日期目标类型:" + destinationClass);

		final Constructor<?> longConstructor = DATE_CONSTRUCTOR.get(destinationClass);
		final Date instance = createInstance(destinationClass, longConstructor);
		return generalConvert(sourceFieldValue, instance);
	}

	private Date createInstance(final Class<?> destinationClass, final Constructor<?> longConstructor) {
		Date instance = null;
		try {
			instance = (Date) longConstructor.newInstance(0);
		} catch (final InstantiationException e) {
			throw new IllegalArgumentException(INIT_ERROR + destinationClass, e);
		} catch (final IllegalAccessException e) {
			throw new IllegalArgumentException(INIT_ERROR + destinationClass, e);
		} catch (final IllegalArgumentException e) {
			throw new IllegalArgumentException(INIT_ERROR + destinationClass, e);
		} catch (final InvocationTargetException e) {
			throw new IllegalArgumentException(INIT_ERROR + destinationClass, e);
		}
		return instance;
	}

	private Date generalConvert(final String dateString, final Date result) {
		for (final DatePattern datePattern : DATE_PATTERNS_MAP.get(result.getClass())) {
			Date parseResult = null;
			try {
				parseResult = datePattern.parse(dateString);
			} catch (final IllegalArgumentException e) {
				log.debug(e.getMessage());
				continue;
			}
			if (parseResult != null) {
				result.setTime(parseResult.getTime());
				return result;
			}
		}

		Assert.isTrue(false, "日期转换失败：" + dateString);
		return null;
	}

}
