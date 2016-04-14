package com.ai.paas.ipaas.storm.task.param;
/**
 * main 参数 spout
 * @author weichuang
 *
 */
public class MainArgSpout {
	private String spoutName;
	private String spoutClassName;
	private int threads;

	public String getSpoutName() {
		return spoutName;
	}

	public void setSpoutName(String spoutName) {
		this.spoutName = spoutName;
	}

	public String getSpoutClassName() {
		return spoutClassName;
	}

	public void setSpoutClassName(String spoutClassName) {
		this.spoutClassName = spoutClassName;
	}

	public int getThreads() {
		return threads;
	}

	public void setThreads(int threads) {
		this.threads = threads;
	}
}
