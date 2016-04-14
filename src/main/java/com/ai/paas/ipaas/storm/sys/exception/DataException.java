package com.ai.paas.ipaas.storm.sys.exception;

import java.io.Serializable;

public class DataException extends RuntimeException implements Serializable {

	private static final long serialVersionUID = 3787730660315875183L;

	private String message;
	private String code;
	private String title = "数据出错了！";

	public DataException(String title, String code, String message) {
		super(message);
		this.message = message;
		this.code = code;
		this.title = title;
	}

	public DataException(String message) {
		super(message);
		this.message = message;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

}
