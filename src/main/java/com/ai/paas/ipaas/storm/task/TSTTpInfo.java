//package com.ai.paas.ipaas.storm.task;
//
//import com.ai.pass.ipaas.rcs.common.IFlowDefine;
//import com.ai.pass.ipaas.rcs.common.RCSBuilder;
//import com.ai.pass.ipaas.rcs.param.BoltParam;
//import com.ai.pass.ipaas.rcs.param.SpoutParam;
//import java.util.Map;
//
//public class TSTTpInfo {
//	 
//    @SuppressWarnings("unchecked")
//    public static void main(String[] args)
//    {
//              RCSBuilder builder = new RCSBuilder();
//              //从jar包里面搜索该接口的实现,改为从命令行输入
//              //通过java反射，创建输入类的实例
//              Class<IFlowDefine> aClass = null;  //WordCounter.TopologyMain
//              IFlowDefine aFlowDefine = null;
//              try {
//                       aClass = (Class<IFlowDefine>) Class.forName("WordCounter.TopologyMain");
//              } catch (ClassNotFoundException e) {
//                       // TODO Auto-generated catch block
//                       e.printStackTrace();
//              }
//              try {
//                       aFlowDefine = (IFlowDefine)aClass.newInstance();
//              } catch (InstantiationException | IllegalAccessException e) {
//                       // TODO Auto-generated catch block
//                       e.printStackTrace();
//              }
//             
//              aFlowDefine.define(args, builder);
//             
//              Map<String, BoltParam> aBoltMap = builder.getmBoltInfo();
//              Map<String, SpoutParam> aSpoutMap = builder.getmSpoutInfo();
//             
//    }
//}