/**
 *
 */
package com.rionsoft.rcms.dao.workLoadAccount;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.rionsoft.rcms.condition.workLoadAccount.WorkLoadCondition;
import com.rionsoft.rcms.condition.workLoadAccount.WorkLoadListEntry;

/**
 * @author likeke
 * @date 2017年5月2日
 */
@Repository
public interface IWorkLoadAccountMapper {

	/**
	 * 查询日志中的考核量(按月)
	 *
	 * @author likeke
	 * @date 2017年5月2日
	 * @param condition
	 * @return List<WorkLoadListEntry>
	 */
	List<WorkLoadListEntry> workLoadQueryByMonth(WorkLoadCondition condition);

	/**
	 * 根据权限查询工作量
	 *
	 * @author sungantao
	 * @date 2017年9月15日
	 * @param condition
	 * @return 工作量信息集合
	 */
	List<WorkLoadListEntry> queryWorkLoadByDataCode(WorkLoadCondition condition);

	/**
	 * 查询工作量信息
	 *
	 * @author sungantao
	 * @date 2017年9月19日
	 * @param condition
	 * @return 工作统计量信息
	 */
	List<Map<String, Object>> queryWorkAccountExprot(WorkLoadCondition condition);

}
