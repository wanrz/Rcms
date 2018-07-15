package com.rionsoft.rcms.web.common.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rionsoft.support.basebo.common.view.ViewEnumType;
import com.rionsoft.support.basebo.view.ExportFileBo;
import com.rionsoft.support.biz.export.strategy.ExportType;
import com.rionsoft.support.biz.export.strategy.IExportStrategyContainerBiz;
import com.rionsoft.support.biz.util.excel.FileType;
import com.rionsoft.support.biz.util.excel.FileUtils;

import lombok.SneakyThrows;

/**
 *
 *
 * @author yujing
 * @date 2016年12月28日
 */
@Service
public class ExportView extends BaseView {

	@Autowired
	private IExportStrategyContainerBiz exportStrategyContainerBiz;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.rionsoft.roep.web.common.view.BaseView#getViewType()
	 */
	@Override
	public ViewEnumType getViewType() {
		return ViewEnumType.EXPORT_VIEW;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * org.springframework.web.servlet.view.AbstractView#renderMergedOutputModel
	 * (java.util.Map, javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse)
	 */
	@SuppressWarnings("unchecked")
	@Override
	protected void renderMergedOutputModel(final Map<String, Object> model, final HttpServletRequest request,
			final HttpServletResponse response) throws Exception {
		final ExportFileBo<T> fileBo = (ExportFileBo<T>) model.get("exportFilebo");
		exportStrategyContainerBiz.getStrategy(ExportType.getExportType(fileBo.getFileType())).exportFile(fileBo);
		setResponse(request, response, fileBo);
		transportFile(response, fileBo);
	}

	/**
	 * 设置httpServletResponse头信息
	 *
	 * @author yujing
	 * @date 2017年1月1日
	 * @param httpServletResponse
	 *            response
	 * @param fileBo
	 *            导出文件Bo
	 * @throws UnsupportedEncodingException
	 */
	@SneakyThrows(UnsupportedEncodingException.class)
	private void setResponse(final HttpServletRequest request, final HttpServletResponse httpServletResponse,
			final ExportFileBo<T> fileBo) {
		httpServletResponse.setContentType(fileBo.getContentType());
		httpServletResponse.setHeader("Content-type", fileBo.getContentType());
		httpServletResponse.setHeader("Content-Disposition",
				"attachment; filename=" + getEncodingFileName(request, fileBo.getFullFileName()));
		httpServletResponse.setHeader("Pragma", "public");
		httpServletResponse.setHeader("Cache-Control", "no-cache");
		httpServletResponse.setHeader("Expires", "0");
		httpServletResponse.setHeader("Content-Transfer-Encoding", "binary");
		httpServletResponse.setCharacterEncoding("UTF-8");
	}

	/**
	 * 根据文件头转义文件名
	 *
	 * @author shuzijian
	 * @date 2017年1月5日
	 * @param request
	 * @param fileBo
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	private String getEncodingFileName(final HttpServletRequest request, final String originalFileName)
			throws UnsupportedEncodingException {
		final String userAgent = request.getHeader("User-Agent");
		String fileName;
		if (userAgent.contains("MSIE") || userAgent.contains("Trident")) {
			fileName = URLEncoder.encode(originalFileName, "UTF-8");
		} else {
			fileName = new String(originalFileName.getBytes("UTF-8"), "ISO-8859-1");
		}
		return fileName;
	}

	@SneakyThrows(IOException.class)
	private void transportFile(final HttpServletResponse httpServletResponse, final ExportFileBo<T> fileBo) {

		final int bomHeadbytesLength = 0;
		OutputStream outputStream = null;
		InputStream inputStream = null;
		try {
			outputStream = httpServletResponse.getOutputStream();
			if (null != fileBo.getTempFile()) {
				inputStream = new FileInputStream(fileBo.getTempFile());
				httpServletResponse.setHeader("Content-Length",
						String.valueOf(fileBo.getTempFile().length() + bomHeadbytesLength));
			} else {
				final File file = FileUtils.createTempFile(FileType.getFileType(fileBo.getFileType()));
				httpServletResponse.setHeader("Content-Length", String.valueOf(file.length() + bomHeadbytesLength));
				inputStream = new FileInputStream(file);
			}

			while (inputStream.available() > 0) {
				// TODO 限制了输出字节数
				final int readSize = Math.min(inputStream.available(), 102400);
				final byte[] buffer = new byte[readSize];
				inputStream.read(buffer);
				outputStream.write(buffer);
				outputStream.flush();
			}

		} finally {
			if (inputStream != null) {
				inputStream.close();
			}
			if (fileBo.isClearFlag() && null != fileBo.getTempFile()) {
				final File file = fileBo.getTempFile();
				if (file.exists()) {
					file.delete();
				}
			}
			if (outputStream != null) {
				outputStream.close();
			}
		}
	}

}
