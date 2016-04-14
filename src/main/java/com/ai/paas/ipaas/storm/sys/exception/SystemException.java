package com.ai.paas.ipaas.storm.sys.exception;

import java.io.Serializable;

/**
 * 系统异常
 */
public class SystemException extends RuntimeException implements Serializable {

	private static final long serialVersionUID = 3787730660315875183L;

	private String message;
	private String code;
	private String title = "系统出错了！";

	public SystemException(String message) {
		super(message);
		this.message = message;
	}

	public SystemException(String title, String code, String message) {
		super(message);
		this.message = message;
		this.code = code;
		this.title = title;
	}

	public String getCode() {
		return code;
	}

	public String getMessage() {
		return message;
	}

	public String getTitle() {
		return title;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
