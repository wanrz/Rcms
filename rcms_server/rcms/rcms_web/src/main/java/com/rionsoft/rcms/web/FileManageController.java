package com.rionsoft.rcms.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.rionsoft.support.biz.util.SysFilePathPropertyUtil;

/**
 * Class Name: FileManageController.java Function: 在线编辑器控制器
 *
 * @author ZMY
 * @DateTime 2015年8月10日 下午8:26:50
 * @version 1.0
 */
@Controller
public class FileManageController extends BaseController {
	private final String PATH_LINE = File.separator;

	/**  */
	Log logger = LogFactory.getLog(FileManageController.class);

	/**
	 * 文件上传
	 *
	 * @param request
	 *            {@link HttpServletRequest}
	 * @param response
	 *            {@link HttpServletResponse}
	 * @param imgFile
	 */
	@RequestMapping("/kindeditorFileUpload.do")
	@ResponseBody
	public void fileUpload(final HttpServletRequest request, final HttpServletResponse response,
			@RequestParam("imgFile") final MultipartFile[] imgFile) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();

			// 文件保存本地目录路径
			String savePath = request.getSession().getServletContext().getRealPath(PATH_LINE)
					+ SysFilePathPropertyUtil.getProperty("kindeditor") + PATH_LINE;
			// 文件保存目录URL
			String saveUrl = request.getContextPath() + PATH_LINE + SysFilePathPropertyUtil.getProperty("kindeditor")
					+ PATH_LINE;

			if (!ServletFileUpload.isMultipartContent(request)) {
				out.print(getError("请选择文件。"));
				return;
			}
			// 检查目录
			final File uploadDir = new File(savePath);
			// 检查目录写权限
			if (!uploadDir.canWrite()) {
				out.print(getError("上传目录没有写权限。"));
				return;
			}

			String dirName = request.getParameter("dir");
			if (dirName == null) {
				dirName = "image";
			}

			// 定义允许上传的文件扩展名
			final Map<String, String> extMap = new HashMap<String, String>();
			extMap.put("image", "gif,jpg,jpeg,png,bmp");
			extMap.put("flash", "swf,flv");
			extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
			extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,xml,txt,zip,rar,gz,bz2");

			if (!extMap.containsKey(dirName)) {
				out.print(getError("目录名不正确。"));
				return;
			}
			// 创建文件夹
			savePath += dirName + PATH_LINE;
			saveUrl += dirName + PATH_LINE;
			final File saveDirFile = new File(savePath);
			if (!saveDirFile.exists()) {
				saveDirFile.mkdirs();
			}

			final SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			final String ymd = sdf.format(new Date());
			savePath += ymd + PATH_LINE;
			saveUrl += ymd + PATH_LINE;
			final File dirFile = new File(savePath);
			if (!dirFile.exists()) {
				dirFile.mkdirs();
			}

			// 最大文件大小
			final long maxSize = 15000000;

			// 保存文件
			for (final MultipartFile iFile : imgFile) {
				final String fileName = iFile.getOriginalFilename();

				// 检查文件大小
				if (iFile.getSize() > maxSize) {
					out.print(getError("上传文件大小超过限制。"));
					return;
				}
				// 检查扩展名
				final String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
				if (!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)) {
					out.print(getError("上传文件扩展名是不允许的扩展名。\n只允许" + extMap.get(dirName) + "格式。"));
					return;
				}

				final SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
				final String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;
				try {
					final File uploadedFile = new File(savePath, newFileName);

					// 写入文件
					iFile.transferTo(uploadedFile);
				} catch (final Exception e) {
					out.print(getError("上传文件失败。"));
					return;
				}

				final JSONObject obj = new JSONObject();
				obj.put("error", 0);
				obj.put("url", saveUrl + newFileName);

				out.print(obj.toString());
			}
		} catch (final Exception e) {
			logger.error(null, e);
		} finally {
			if (out != null) {
				out.close();
			}
		}

	}

	private Map<String, Object> getError(final String errorMsg) {
		final Map<String, Object> errorMap = new HashMap<String, Object>();
		errorMap.put("error", 1);
		errorMap.put("message", errorMsg);
		return errorMap;
	}

	/**
	 * 文件空间
	 *
	 * @param request
	 *            {@link HttpServletRequest}
	 * @param response
	 *            {@link HttpServletResponse}
	 */
	@SuppressWarnings("synthetic-access")
	@RequestMapping("/kindeditorFileManager.do")
	@ResponseBody
	public void fileManager(final HttpServletRequest request, final HttpServletResponse response) {
		PrintWriter out = null;
		try {
			// 根目录路径，可以指定绝对路径
			String rootPath = request.getSession().getServletContext().getRealPath(PATH_LINE) + "kindeditor" + PATH_LINE
					+ "attached" + PATH_LINE;
			// 根目录URL，可以指定绝对路径，比如 http://www.yoursite.com/attached/
			String rootUrl = request.getContextPath() + PATH_LINE + "kindeditor" + PATH_LINE + "attached" + PATH_LINE;

			response.setContentType("application/json; charset=UTF-8");
			out = response.getWriter();

			// 图片扩展名
			final String[] fileTypes = new String[] { "gif", "jpg", "jpeg", "png", "bmp" };

			final String dirName = request.getParameter("dir");
			if (dirName != null) {
				if (!Arrays.<String>asList(new String[] { "image", "flash", "media", "file" }).contains(dirName)) {
					out.print("无效的文件夹。");

					return;
				}
				rootPath += dirName + PATH_LINE;
				rootUrl += dirName + PATH_LINE;
				final File saveDirFile = new File(rootPath);
				if (!saveDirFile.exists()) {
					saveDirFile.mkdirs();
				}
			}
			// 根据path参数，设置各路径和URL
			final String path = request.getParameter("path") != null ? request.getParameter("path") : "";
			final String currentPath = rootPath + path;
			final String currentUrl = rootUrl + path;
			final String currentDirPath = path;
			String moveupDirPath = "";
			if (!"".equals(path)) {
				final String str = currentDirPath.substring(0, currentDirPath.length() - 1);
				moveupDirPath = str.lastIndexOf(PATH_LINE) >= 0 ? str.substring(0, str.lastIndexOf(PATH_LINE) + 1) : "";
			}

			// 排序形式，name or size or type
			final String order = request.getParameter("order") != null ? request.getParameter("order").toLowerCase()
					: "name";

			// 不允许使用..移动到上一级目录
			if (path.indexOf("..") >= 0) {
				out.print("访问权限拒绝。");

				return;
			}
			// 最后一个字符不是/
			if (!"".equals(path) && !path.endsWith(PATH_LINE)) {
				out.print("无效的访问参数验证。");

				return;
			}
			// 目录不存在或不是目录
			final File currentPathFile = new File(currentPath);
			if (!currentPathFile.isDirectory()) {
				out.print("文件夹不存在。");

				return;
			}

			// 遍历目录取的文件信息
			final List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
			if (currentPathFile.listFiles() != null) {
				for (final File file : currentPathFile.listFiles()) {
					final Hashtable<String, Object> hash = new Hashtable<String, Object>();
					final String fileName = file.getName();
					if (file.isDirectory()) {
						hash.put("is_dir", true);
						hash.put("has_file", (file.listFiles() != null));
						hash.put("filesize", 0L);
						hash.put("is_photo", false);
						hash.put("filetype", "");
					} else if (file.isFile()) {
						final String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
						hash.put("is_dir", false);
						hash.put("has_file", false);
						hash.put("filesize", file.length());
						hash.put("is_photo", Arrays.<String>asList(fileTypes).contains(fileExt));
						hash.put("filetype", fileExt);
					}
					hash.put("filename", fileName);
					hash.put("datetime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(file.lastModified()));
					fileList.add(hash);
				}
			}

			if ("size".equals(order)) {
				Collections.sort(fileList, new SizeComparator());
			} else if ("type".equals(order)) {
				Collections.sort(fileList, new TypeComparator());
			} else {
				Collections.sort(fileList, new NameComparator());
			}

			final JSONObject result = new JSONObject();
			result.put("moveup_dir_path", moveupDirPath);
			result.put("current_dir_path", currentDirPath);
			result.put("current_url", currentUrl);
			result.put("total_count", fileList.size());
			result.put("file_list", fileList);

			out.println(result.toString());

		} catch (final IOException e) {
			logger.error(null, e);
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	private class NameComparator implements Comparator<Map<String, Object>> {
		@Override
		public int compare(final Map<String, Object> hashA, final Map<String, Object> hashB) {
			if (((Boolean) hashA.get("is_dir")) && !((Boolean) hashB.get("is_dir"))) {
				return -1;
			} else if (!((Boolean) hashA.get("is_dir")) && ((Boolean) hashB.get("is_dir"))) {
				return 1;
			} else {
				return ((String) hashA.get("filename")).compareTo((String) hashB.get("filename"));
			}
		}
	}

	private class SizeComparator implements Comparator<Map<String, Object>> {
		@Override
		public int compare(final Map<String, Object> hashA, final Map<String, Object> hashB) {
			if (((Boolean) hashA.get("is_dir")) && !((Boolean) hashB.get("is_dir"))) {
				return -1;
			} else if (!((Boolean) hashA.get("is_dir")) && ((Boolean) hashB.get("is_dir"))) {
				return 1;
			} else {
				if (((Long) hashA.get("filesize")) > ((Long) hashB.get("filesize"))) {
					return 1;
				} else if (((Long) hashA.get("filesize")) < ((Long) hashB.get("filesize"))) {
					return -1;
				} else {
					return 0;
				}
			}
		}
	}

	private class TypeComparator implements Comparator<Map<String, Object>> {
		@Override
		public int compare(final Map<String, Object> hashA, final Map<String, Object> hashB) {
			if (((Boolean) hashA.get("is_dir")) && !((Boolean) hashB.get("is_dir"))) {
				return -1;
			} else if (!((Boolean) hashA.get("is_dir")) && ((Boolean) hashB.get("is_dir"))) {
				return 1;
			} else {
				return ((String) hashA.get("filetype")).compareTo((String) hashB.get("filetype"));
			}
		}
	}

	/**
	 *
	 * @param request
	 * @param response
	 */
	@RequestMapping("/DownloadAffix.do")
	@ResponseBody
	public void DownloadAffix(final HttpServletRequest request, final HttpServletResponse response) {
		try {
			final String saveUrl = new String(request.getParameter("path").getBytes("ISO-8859-1"), "UTF-8");
			final String path = request.getContextPath() + PATH_LINE + saveUrl;
			final File file = new File(path);

			final FileInputStream in = new FileInputStream(path);
			final int len = in.available();
			final byte[] bytes = new byte[len];
			in.read(bytes);

			response.reset();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Disposition", "attachment;filename=" + file.getName());
			response.setContentLength(len);

			final javax.servlet.ServletOutputStream out = response.getOutputStream();
			out.write(bytes);
			out.flush();
			in.close();
			out.close();
		} catch (final Exception e) {
			e.printStackTrace();
		}
	}
}
