package com.ai.paas.ipaas.storm.task.param;
/**
 * main 参数 bolt
 * @author weichuang
 *
 */
public class MainArgBolt {
	private String boltName;
	private String boltClassName;
	private int threads;
	/**
	 * 多个，逗号分隔符
	 */
	private String groupingTypes;
	/**
	 * 多个，逗号分隔符
	 */
	private String groupingSpoutOrBolts;

	public String getBoltName() {
		return boltName;
	}

	public void setBoltName(String boltName) {
		this.boltName = boltName;
	}

	public String getBoltClassName() {
		return boltClassName;
	}

	public void setBoltClassName(String boltClassName) {
		this.boltClassName = boltClassName;
	}

	public int getThreads() {
		return threads;
	}

	public void setThreads(int threads) {
		this.threads = threads;
	}

	public String getGroupingTypes() {
		return groupingTypes;
	}

	public void setGroupingTypes(String groupingTypes) {
		this.groupingTypes = groupingTypes;
	}

	public String getGroupingSpoutOrBolts() {
		return groupingSpoutOrBolts;
	}

	public void setGroupingSpoutOrBolts(String groupingSpoutOrBolts) {
		this.groupingSpoutOrBolts = groupingSpoutOrBolts;
	}
}
