package com.rionsoft.rcms.web.common.listener;

import java.io.File;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.rionsoft.rcms.web.common.SysFilePathEnum;
import com.rionsoft.support.biz.util.SysFilePathPropertyUtil;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SystemConstantEnum;

/**
 *
 * @author <a href="mailto:dailycode@163.com"> liyw <a><br>
 *         2016年11月23日
 *
 */
public class SystemResourcesInitServletContextListener implements ServletContextListener {
	/**  */
	private final Log logger = LogFactory.getLog(SystemResourcesInitServletContextListener.class);

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * javax.servlet.ServletContextListener#contextInitialized(javax.servlet.
	 * ServletContextEvent)
	 */
	@SuppressWarnings("deprecation")
	@Override
	public void contextInitialized(final ServletContextEvent sce) {
		// final ApplicationContext app =
		// WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
		// app.getBean(beanName);

		logger.debug("初始化系统文件参数开始-->");
		File file = null;
		final String realPath = sce.getServletContext().getRealPath("/");

		SessionLocal.setConstant(SystemConstantEnum.SERVER_PATH, realPath);

		for (final SysFilePathEnum sysFile : SysFilePathEnum.values()) {
			file = new File(realPath, SysFilePathPropertyUtil.getProperty(sysFile.name()));
			if (!file.exists()) {
				file.mkdirs();
			}
		}
		logger.debug("初始化系统文件参数结束<--");
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see javax.servlet.ServletContextListener#contextDestroyed(javax.servlet.
	 * ServletContextEvent)
	 */
	@Override
	public void contextDestroyed(final ServletContextEvent sce) {
		// TODO Auto-generated method stub

	}
}
