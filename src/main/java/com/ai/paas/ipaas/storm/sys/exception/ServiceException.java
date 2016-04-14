package com.ai.paas.ipaas.storm.sys.exception;

import org.apache.log4j.Logger;

public class ServiceException extends RuntimeException{
	private static final long serialVersionUID = 5216697921706744202L;
	private Logger logger=Logger.getLogger(ServiceException.class);
	public ServiceException(){
		super("出现业务处理操作异常");
		this.logger.error("出现业务处理操作异常");
	}
	public ServiceException(String message){
		super(message);
		this.logger.error(message);
	}
	public ServiceException(String message, Throwable cause) {
		super(message, cause);
		this.logger.error(message);
	}
	public ServiceException(Throwable cause) {
        super("出现业务处理操作异常",cause);
        this.logger.error("出现业务处理操作异常");
	}
}
