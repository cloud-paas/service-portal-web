package com.ai.paas.ipaas.storm.sys.conf;

/**
 * storm集群信息
 * @author dongteng
 * storm运行参数配置
 */
public class StormParam {
  public static final class StartParam{
	  public static final String level = "SYS";
	  public static final String dbConnect = "jdbc:mysql://10.1.228.202:31316/devrdb21?characterEncoding=utf8";
      public static final String uname = "devrdbusr21";
      public static final String password = "devrdbusr21";
  }
  
  public static final class StopParam{
	  
  }
}
