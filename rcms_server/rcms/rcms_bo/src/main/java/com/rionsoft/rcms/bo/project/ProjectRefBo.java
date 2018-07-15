/**
 *
 */
package com.rionsoft.rcms.bo.project;

import java.util.List;

import com.rionsoft.support.basebo.BaseBo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author linzhiqiang
 * @date 2017年4月26日
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProjectRefBo extends BaseBo {
	private List<ProjectRecourceRefBo> refBoList;
}
