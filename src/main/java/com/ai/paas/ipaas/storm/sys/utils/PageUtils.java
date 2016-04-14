package com.ai.paas.ipaas.storm.sys.utils;

import javax.servlet.http.HttpServletRequest;

import com.ai.paas.ipaas.page.model.PageEntity;
import com.ai.paas.ipaas.page.model.PagingResult;

public class PageUtils {
	public static void setTotalPages(HttpServletRequest request,PageEntity pageEntity,@SuppressWarnings("rawtypes") PagingResult pagingResult){
		int totalPages =0;
		if (pagingResult.getTotalSize()%pageEntity.getSize() == 0) {
			totalPages = pagingResult.getTotalSize()/pageEntity.getSize();
		}else {
			totalPages = pagingResult.getTotalSize()/pageEntity.getSize() + 1;
		}
		request.setAttribute("totalPages", totalPages);
	}
}
