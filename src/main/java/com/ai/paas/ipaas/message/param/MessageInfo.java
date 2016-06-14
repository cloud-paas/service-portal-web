package com.ai.paas.ipaas.message.param;

import java.sql.Timestamp;

/**
 * @author zhaogw
 *
 */
public class MessageInfo {
	private long queueId;
	private String queueName;
	private String queuePwd;
	private String queueNameEn;
	private String configSend;
	private String configSendPath;
	private String configRecive;
	private String configRecivePath;
	private String operId;
	private String userName;
	private String zkAddress;
	private String zkPassword;
	private Timestamp createTime;
	private Timestamp modifyTime;
	private String serviceId;
	private String partitions;
	private String desPartitions;
	private String replications;
	private String maxProducer;
	private String state;
	private String remark;
	
	public long getQueueId() {
		return queueId;
	}
	public void setQueueId(long queueId) {
		this.queueId = queueId;
	}
	public String getQueueName() {
		return queueName;
	}
	public void setQueueName(String queueName) {
		this.queueName = queueName;
	}
	public String getQueuePwd() {
		return queuePwd;
	}
	public void setQueuePwd(String queuePwd) {
		this.queuePwd = queuePwd;
	}
	public String getQueueNameEn() {
		return queueNameEn;
	}
	public void setQueueNameEn(String queueNameEn) {
		this.queueNameEn = queueNameEn;
	}
	public String getConfigSend() {
		return configSend;
	}
	public void setConfigSend(String configSend) {
		this.configSend = configSend;
	}
	public String getConfigSendPath() {
		return configSendPath;
	}
	public void setConfigSendPath(String configSendPath) {
		this.configSendPath = configSendPath;
	}
	public String getConfigRecive() {
		return configRecive;
	}
	public void setConfigRecive(String configRecive) {
		this.configRecive = configRecive;
	}
	public String getConfigRecivePath() {
		return configRecivePath;
	}
	public void setConfigRecivePath(String configRecivePath) {
		this.configRecivePath = configRecivePath;
	}
	public String getOperId() {
		return operId;
	}
	public void setOperId(String operId) {
		this.operId = operId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getZkAddress() {
		return zkAddress;
	}
	public void setZkAddress(String zkAddress) {
		this.zkAddress = zkAddress;
	}
	public String getZkPassword() {
		return zkPassword;
	}
	public void setZkPassword(String zkPassword) {
		this.zkPassword = zkPassword;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	public Timestamp getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(Timestamp modifyTime) {
		this.modifyTime = modifyTime;
	}
	public String getServiceId() {
		return serviceId;
	}
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}
	public String getPartitions() {
		return partitions;
	}
	public void setPartitions(String partitions) {
		this.partitions = partitions;
	}
	
	public String getDesPartitions() {
		return desPartitions;
	}
	public void setDesPartitions(String desPartitions) {
		this.desPartitions = desPartitions;
	}
	public String getReplications() {
		return replications;
	}
	public void setReplications(String replications) {
		this.replications = replications;
	}
	public String getMaxProducer() {
		return maxProducer;
	}
	public void setMaxProducer(String maxProducer) {
		this.maxProducer = maxProducer;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
}
