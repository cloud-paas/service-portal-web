package com.ai.paas.ipaas.storm.task.param;

import java.util.List;
/**
 * main 参数 topology
 * @author weichuang
 *
 */
public class MainArgTopology {
	private String topologyName;
	private int numWorkers;
	private List<MainArgSpout> spouts;
	private List<MainArgBolt> bolts;

	public String getTopologyName() {
		return topologyName;
	}

	public void setTopologyName(String topologyName) {
		this.topologyName = topologyName;
	}

	public int getNumWorkers() {
		return numWorkers;
	}

	public void setNumWorkers(int numWorkers) {
		this.numWorkers = numWorkers;
	}

	public List<MainArgSpout> getSpouts() {
		return spouts;
	}

	public void setSpouts(List<MainArgSpout> spouts) {
		this.spouts = spouts;
	}

	public List<MainArgBolt> getBolts() {
		return bolts;
	}

	public void setBolts(List<MainArgBolt> bolts) {
		this.bolts = bolts;
	}
}
