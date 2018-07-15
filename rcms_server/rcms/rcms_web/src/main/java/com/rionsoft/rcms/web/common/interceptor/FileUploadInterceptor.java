/**
 *
 */
package com.rionsoft.rcms.web.common.interceptor;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.rionsoft.support.basebo.common.file.FileUploadBo;
import com.rionsoft.support.biz.util.excel.FileType;
import com.rionsoft.support.biz.util.excel.FileUtils;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocal;
import com.rionsoft.support.mybatisplugin.dao.common.session.SessionLocalEnum;

/**
 * 处理文件上传的拦截器
 *
 * @author shuzijian
 * @date 2016年12月27日
 */
public class FileUploadInterceptor implements HandlerInterceptor {

	/*
	 * (non-Javadoc)
	 *
	 * @see org.springframework.web.servlet.HandlerInterceptor#preHandle(javax.
	 * servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object)
	 */
	@Override
	public boolean preHandle(final HttpServletRequest request, final HttpServletResponse response, final Object handler)
			throws Exception {
		if (!ServletFileUpload.isMultipartContent(request)) {
			return true;
		}
		final MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		final MultiValueMap<String, MultipartFile> fileMap = multipartRequest.getMultiFileMap();
		final Iterator<Entry<String, List<MultipartFile>>> fileIterator = fileMap.entrySet().iterator();
		final Map<String, FileUploadBo> fileUploadMap = new HashMap<String, FileUploadBo>();
		while (fileIterator.hasNext()) {
			final Entry<String, List<MultipartFile>> fileEntry = fileIterator.next();
			final String inputName = fileEntry.getKey();
			final List<MultipartFile> multipartFiles = fileEntry.getValue();
			final MultipartFile multipartFile = multipartFiles.get(0);
			final FileUploadBo fileUploadBo = new FileUploadBo();
			fileUploadBo.setFileName(
					StringUtils.substringBeforeLast(multipartFile.getOriginalFilename(), FileUtils.FILE_DOT));
			fileUploadBo.setFileType(
					StringUtils.substringAfterLast(multipartFile.getOriginalFilename(), FileUtils.FILE_DOT));
			fileUploadBo.setFileSize(multipartFile.getSize());
			final File file = FileUtils.createTempFile(FileType.TMP);
			multipartFile.transferTo(file);
			fileUploadBo.setTempFile(file);
			fileUploadMap.put(inputName, fileUploadBo);
		}
		SessionLocal.setSessionLocal(SessionLocalEnum.UPLOAD_FILE, fileUploadMap);
		return true;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see org.springframework.web.servlet.HandlerInterceptor#postHandle(javax.
	 * servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object, org.springframework.web.servlet.ModelAndView)
	 */
	@Override
	public void postHandle(final HttpServletRequest request, final HttpServletResponse response, final Object handler,
			final ModelAndView modelAndView) throws Exception {
		//
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * org.springframework.web.servlet.HandlerInterceptor#afterCompletion(javax.
	 * servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object, java.lang.Exception)
	 */
	@Override
	public void afterCompletion(final HttpServletRequest request, final HttpServletResponse response,
			final Object handler, final Exception ex) throws Exception {
		if (!ServletFileUpload.isMultipartContent(request)) {
			return;
		}
		final Map<String, FileUploadBo> fileUploadMap = SessionLocal.getSessionLocal(SessionLocalEnum.UPLOAD_FILE);
		final Iterator<FileUploadBo> fileIterator = fileUploadMap.values().iterator();
		while (fileIterator.hasNext()) {
			final FileUploadBo fileUploadBo = fileIterator.next();
			if (fileUploadBo.getDestFilePath() != null) {
				// 保存文件
			} else {
				final File file = fileUploadBo.getTempFile();
				if (file.exists()) {
					file.delete();
				}
			}
		}
	}

}
