/**
 *
 */
package com.rionsoft.rcms.web.task;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

/**
 *
 * @author <a href="mailto:dailycode@163.com"> liyw <a><br>
 *         2017年2月7日
 *
 */
@Component
public class DemoTask {

	/**  */
	Log logger = LogFactory.getLog(DemoTask.class);

	/**
	 *
	 */
	public void demo() {
		logger.debug("定时任务启动...");
	}
}
