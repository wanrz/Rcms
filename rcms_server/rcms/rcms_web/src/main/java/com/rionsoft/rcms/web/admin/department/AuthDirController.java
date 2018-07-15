/**
 *
 */
package com.rionsoft.rcms.web.admin.department;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rionsoft.rcms.biz.code.SequenceTypeEnum;
import com.rionsoft.rcms.biz.department.IAuthDirBiz;
import com.rionsoft.rcms.bo.department.AuthDirBo;
import com.rionsoft.rcms.web.BaseController;
import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.biz.sequence.IManageSequenceBiz;

/**
 * 部门管理
 *
 * @author likeke
 * @date 2017年4月13日
 */
@Controller
@RequestMapping("admin/department")
public class AuthDirController extends BaseController {
	@Autowired
	private IAuthDirBiz dirBizImpl;
	@Autowired
	private IManageSequenceBiz manageSequenceBiz;

	/**
	 * 部门管理管理菜单入口
	 *
	 * @author likeke
	 * @date 2017年4月13日
	 * @return String
	 * @param map
	 */
	@RequestMapping("/deptManage.do")
	public String auth(final Map<String, Object> map) {
		// map.put("userCodeSeq",
		// manageSequenceBiz.getSequenceNo(SequenceTypeEnum.DEPTCODE.getEnumName()));
		return getView("admin/department/deptManage");
	}

	/**
	 * 查询目录根节点
	 *
	 * @author loujie
	 * @data 2016年11月28日
	 * @param dirType
	 *            目录类型
	 * @param model
	 * @param request
	 * @return view
	 */
	@RequestMapping("/dirTree.ajax")
	public String dirTree(final String dirType, final Map<String, Object> model, final HttpServletRequest request) {
		model.put("treeRootList", dirBizImpl.queryTreeRoot());
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 部门新增
	 *
	 * @author linzhiqiang
	 * @date 2017年4月14日
	 * @param request
	 * @param authDirBo
	 * @return view
	 */
	@RequestMapping(value = "/deptSave.ajax")
	public String deptSave(final HttpServletRequest request, final AuthDirBo authDirBo) {
		dirBizImpl.deptSave(authDirBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 部门修改
	 *
	 * @author linzhiqiang
	 * @date 2017年4月14日
	 * @param request
	 * @param authDirBo
	 * @return view
	 */
	@RequestMapping(value = "/deptUpdate.ajax")
	public String deptUpdate(final HttpServletRequest request, final AuthDirBo authDirBo) {
		dirBizImpl.deptUpdate(authDirBo);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 部门查询
	 *
	 * @author linzhiqiang
	 * @date 2017年4月17日
	 * @param dirId
	 * @param model
	 * @param request
	 * @return view
	 */
	@RequestMapping("/queryDept.ajax")
	public String queryDept(final long dirId, final Map<String, Object> model, final HttpServletRequest request) {
		model.put("authDir", dirBizImpl.queryDept(dirId));
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 部门删除
	 *
	 * @author linzhiqiang
	 * @date 2017年4月18日
	 * @param dirId
	 * @param dirSeq
	 * @param request
	 * @return view
	 */
	@RequestMapping("/deptDelete.ajax")
	public String deptDelete(final long dirId, final String dirSeq, final HttpServletRequest request) {
		dirBizImpl.deptDelete(dirId, dirSeq);
		return getView(ViewEnumType.JSON_VIEW);
	}

	/**
	 * 新增自动添加部门编码
	 * 
	 * @author linzhiqiang
	 * @date 2017年5月8日
	 * @param model
	 * @return view
	 */
	@RequestMapping("/deptSeqCode.ajax")
	public String deptSeqCode(final Map<String, Object> model) {
		model.put("userCodeSeq", manageSequenceBiz.getSequenceNo(SequenceTypeEnum.DEPTCODE.getEnumName()));
		return getView(ViewEnumType.JSON_VIEW);
	}

}
