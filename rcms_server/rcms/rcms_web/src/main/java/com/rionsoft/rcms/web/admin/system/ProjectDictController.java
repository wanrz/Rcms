package com.rionsoft.rcms.web.admin.system;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.rionsoft.rcms.biz.system.IProjectTypeDictBiz;
import com.rionsoft.rcms.biz.system.bddict.IBdDictBiz;
import com.rionsoft.rcms.biz.system.bddictdetail.IBdDictDetailBiz;
import com.rionsoft.rcms.bo.system.BdDictDetailBo;
import com.rionsoft.rcms.bo.system.ProjectLevelDictBo;
import com.rionsoft.rcms.bo.system.ProjectTypeDictBo;
import com.rionsoft.rcms.bo.system.ProjectUrgentDictBo;
import com.rionsoft.rcms.condition.system.BdDictCondition;
import com.rionsoft.rcms.condition.system.BdDictDetailCondition;
import com.rionsoft.rcms.condition.system.ProjectLevelDictCondition;
import com.rionsoft.rcms.condition.system.ProjectTypeDictCondition;
import com.rionsoft.rcms.condition.system.ProjectUrgentDictCondition;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;

/**
 * @author kongdeshuang
 * @date 2017年4月14日
 */
@Controller
@RequestMapping("/admin/system")
public class ProjectDictController extends BaseController {
	@Autowired
	private IProjectTypeDictBiz projectTypeDictBiz;
	@Autowired
	private IBdDictBiz BdDictBizImpl;
	@Autowired
	private IBdDictDetailBiz bdDictDetailBiz;

	/**
	 * 项目类型字典管理页面条跳转
	 *
	 * @author kongdeshuang
	 * @param map
	 * @param bdDictCondition
	 * @date 2017年4月14日
	 * @return String
	 */
	@RequestMapping("/dictManage.do")
	public String dictManage(final Map<String, Object> map, final BdDictCondition bdDictCondition) {
		map.put("BdDictList", BdDictBizImpl.queryDictList(bdDictCondition));
		return getView("admin/system/dictManage");
	}

	/**
	 * 项目类型字典信息列表查询
	 *
	 * @param map
	 * @param projectTypeDictCondition
	 * @date 2017年4月14日
	 * @return String
	 */
	@RequestMapping("/dictList.ajax")
	public String proTypeDictList(final Map<String, Object> map,
			final ProjectTypeDictCondition projectTypeDictCondition) {
		map.put("proTypeDictList", projectTypeDictBiz.getDictByConditon(projectTypeDictCondition));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 添加项目类型字典
	 *
	 * @author kongdeshuang
	 * @param projectTypeDictBo
	 * @return String
	 * @date 2017年4月19日
	 *
	 */
	@RequestMapping(value = "/proTypeDictAdd.ajax")
	public String proTypeDictAdd(final ProjectTypeDictBo projectTypeDictBo) {
		projectTypeDictBiz.proTypeDictAdd(projectTypeDictBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 项目类型字典修改
	 *
	 * @author kongdeshuang
	 * @date 2017年4月20日
	 * @param request
	 * @param projectTypeDictBo
	 * @return String
	 */
	@RequestMapping(value = "/dictUpdate.ajax")
	public String dictUpdate(final HttpServletRequest request, final ProjectTypeDictBo projectTypeDictBo) {
		projectTypeDictBiz.updateProtypeDict(projectTypeDictBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 根据ID查询字典
	 *
	 * @author kongdeshuang
	 * @date 2017年4月20日
	 * @param typeId
	 * @param model
	 * @param request
	 * @return String
	 */
	@RequestMapping("/queryDictById.ajax")
	public String queryDept(final long typeId, final Map<String, Object> model, final HttpServletRequest request) {
		model.put("proTypeDict", projectTypeDictBiz.queryDictByID(typeId));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 项目类型字典批量封装,解封
	 *
	 * @author 刘教练
	 * @date 2017年9月8日
	 * @param list
	 * @param flag
	 * @return view
	 */
	@RequestMapping(value = { "/binningTypeDictFlag.ajax", "/devanningTypeDictFlag.ajax" })
	public String binningTypeDictFlag(final String list, final String flag) {
		final List<Long> typeIdList = JSON.parseArray(list, Long.class);
		projectTypeDictBiz.updateTypeIdListFlag(typeIdList, flag);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 项目级别字典信息列表查询
	 *
	 * @param map
	 * @param projectLevelDictCondition
	 * @date 2017年4月14日
	 * @return String
	 */
	@RequestMapping("/proLevelDictList.ajax")
	public String proLevelDictList(final Map<String, Object> map,
			final ProjectLevelDictCondition projectLevelDictCondition) {
		map.put("proLevelDictList", projectTypeDictBiz.queryProLevelDict(projectLevelDictCondition));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 添加项目级别字典
	 *
	 * @author kongdeshuang
	 * @param projectLevelDictBo
	 * @return String
	 * @date 2017年4月24日
	 *
	 */
	@RequestMapping(value = "/proLevelDictAdd.ajax")
	public String proLevelDictAdd(final ProjectLevelDictBo projectLevelDictBo) {
		projectTypeDictBiz.proLevelDictAdd(projectLevelDictBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 项目级别字典修改
	 *
	 * @author kongdeshuang
	 * @date 2017年4月24日
	 * @param request
	 * @param projectLevelDictBo
	 * @return String
	 */
	@RequestMapping(value = "/proLevelDictUpdate.ajax")
	public String proLevelDictUpdate(final HttpServletRequest request, final ProjectLevelDictBo projectLevelDictBo) {
		projectTypeDictBiz.updateProLevelDict(projectLevelDictBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 项目级别批量修改封存,解封
	 *
	 * @author 刘教练
	 * @date 2017年9月8日
	 * @param list
	 * @param flag
	 * @return view
	 */
	@RequestMapping(value = { "/binningLevelDictFlag.ajax", "/devanningLevelDictFlag.ajax" })
	public String binningLevelDictFlag(final String list, final String flag) {
		final List<Long> levelIdList = JSON.parseArray(list, Long.class);
		projectTypeDictBiz.updateProLevelDictListFlag(levelIdList, flag);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 项目紧急程度字典信息列表查询
	 *
	 * @param map
	 * @param projectUrgentDictCondition
	 * @date 2017年4月14日
	 * @return String
	 */
	@RequestMapping("/urgentDictList.ajax")
	public String proUrgentDictList(final Map<String, Object> map,
			final ProjectUrgentDictCondition projectUrgentDictCondition) {
		map.put("proUrgentDictList", projectTypeDictBiz.queryUrgentDict(projectUrgentDictCondition));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 添加项目紧急程度字典
	 *
	 * @author kongdeshuang
	 * @param projectUrgentDictBo
	 * @return String
	 * @date 2017年4月24日
	 *
	 */
	@RequestMapping(value = "/proUrgentDictAdd.ajax")
	public String proUrgentDictAdd(final ProjectUrgentDictBo projectUrgentDictBo) {
		projectTypeDictBiz.proUrgentDictAdd(projectUrgentDictBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 项目紧急程度字典修改
	 *
	 * @author kongdeshuang
	 * @date 2017年4月24日
	 * @param request
	 * @param projectUrgentDictBo
	 * @return String
	 */
	@RequestMapping(value = "/proUrgentDictUpdate.ajax")
	public String proUrgentDictUpdate(final HttpServletRequest request, final ProjectUrgentDictBo projectUrgentDictBo) {
		projectTypeDictBiz.updateProUrgentDict(projectUrgentDictBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 项目紧急程度字典批量封装,解封
	 *
	 * @author 刘教练
	 * @date 2017年9月8日
	 * @param list
	 * @param flag
	 * @return view
	 */
	@RequestMapping(value = { "/binningUrgentDictFlag.ajax", "/devanningUrgentDictFlag.ajax" })
	public String binningUrgentDictFlag(final String list, final String flag) {
		final List<Long> urgentIdList = JSON.parseArray(list, Long.class);
		projectTypeDictBiz.updateUrgentDictListFlag(urgentIdList, flag);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 字典小表查询
	 *
	 * @author kongdeshuang
	 * @date 2017年5月10日
	 * @param map
	 * @param bdDictDetailCondition
	 * @return BdDictDetailList
	 */
	@RequestMapping("/BdDictDetailList.ajax")
	public String queryBdDictDetailList(final Map<String, Object> map,
			final BdDictDetailCondition bdDictDetailCondition) {
		map.put("BdDictDetailList", bdDictDetailBiz.queryBdDictDetail(bdDictDetailCondition));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 字典新增
	 *
	 * @author kongdeshuang
	 * @date 2017年5月10日
	 * @param bdDictDetailBo
	 * @return view
	 */
	@RequestMapping(value = "/bdDictDetailAdd.ajax")
	public String bdDictDetailAdd(final BdDictDetailBo bdDictDetailBo) {
		bdDictDetailBiz.bdDictDetailAdd(bdDictDetailBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 修改字典
	 *
	 * @author kongdeshuang
	 * @date 2017年5月10日
	 * @param request
	 * @param bdDictDetailBo
	 * @return view
	 */
	@RequestMapping(value = "/updateDbDictDetail.ajax")
	public String bdDictDetailUpdate(final HttpServletRequest request, final BdDictDetailBo bdDictDetailBo) {
		bdDictDetailBiz.updateDbDictDetail(bdDictDetailBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 字典归档
	 *
	 * @author kongdeshuang
	 * @date 2017年5月10日
	 * @param pkDetail
	 * @return view
	 */
	@RequestMapping("/bdDictDetailFlag.ajax")
	public String bdDictDetailFlag(final long pkDetail) {
		bdDictDetailBiz.updateDictFlag(pkDetail);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 删除项目类型字典
	 *
	 * @author 刘教练
	 * @date 2017年9月13日
	 * @param property
	 * @param model
	 * @return view
	 */
	@RequestMapping("/deleteTypeDictById.ajax")
	public String deleteTypeDictById(final String property, final Map<String, Object> model) {
		model.put("row", projectTypeDictBiz.deleteTypeDictById(property));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 项目级别字典删除
	 *
	 * @author 刘教练
	 * @date 2017年9月13日
	 * @param property
	 * @param model
	 * @return rows
	 */
	@RequestMapping("/deleteLevelDictById.ajax")
	public String deleteLevelDictById(final String property, final Map<String, Object> model) {
		model.put("row", projectTypeDictBiz.deleteLevelDictById(property));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 项目紧急程度字典删除
	 *
	 * @author 刘教练
	 * @date 2017年9月13日
	 * @param property
	 * @param model
	 * @return row
	 */
	@RequestMapping("/deleteUrgentDictById.ajax")
	public String deleteUrgentDictById(final String property, final Map<String, Object> model) {
		model.put("row", projectTypeDictBiz.deleteUrgentDictById(property));
		return getView(ViewEnumType.JSON_VIEW);
	}
}
