package com.ai.paas.ipaas.virtual.vo;

import java.sql.Timestamp;

public class virtualMachineVo {
	 /*private String curType;//云类别
	 private String applyUser;//申请人
	 private String applyDepartment;//申请部门
	 private String applyuserPhone;//联系电话
	 private String applyuserEmail;//邮箱地址
	 private String applyReason;//申请原因
	 
	 private String projectName;//成本中心/名称
	 private Integer projectNum;//用户数
	 private Integer projectCount;//并发访问量
	 private String projectExplain;//用途说明
	 private String projectNot;//业务描述
	 private Timestamp currentTime;//当前时间
	 private Timestamp projectEndTime;//到期时间
	 
	 private String virtualType;//虚拟机类型
	 private String virtualCpu;//CPU
	 private String virtualRam;//内存
	 private String virtualHard;//数据盘
	 
	 private String netType;//链路类型
	 private String netBandW;//公司宽带
	 private Integer netNum;//公网数量
	 
	 private String SysTem;//操作系统
     private String SysTemChild;//操作系统版本
	 private String SysOtherTem;////其他操作系统
	 private String storageSoft;//存储软件
	 private String environmentSoft;//运行环境软件
	 private String otherExplain;//其他补充说明
*/	 
	private Long orderDetailId;    //订单编码
    private String costCenterCode; //成本中心编码
    private String costCenterName; //成本中心名称
    private Long userMaxNumbers;   //用户量
    private Long concurrentNumbers;//并发访问量
    private String applyType;      //资源申请方式
    private String useType;        //用途说明
    private String applyDesc;      //业务描述
    
    private String operateType;

    private String userId;

    private String prodType;

    private String prodId;

    private String prodByname;

    private String prodParamZh;

    private Timestamp orderAppDate;

    private Timestamp preOpenDate;

    private String openStatus;

    private String openParam;

    private String openResult;

    private Timestamp openDate;

    private String orderCheckStatus;

    private String orderCheckResult;

    private Timestamp orderCheckDate;

    private String orderCheckDesc;

    private String orderStatus;

    private String userServId;

    private String userServIpaasId;

    private String userServIpaasPwd;

    private String applicant;

    private String applicantDept;

    private String applicantTel;

    private String applicantEmail;

    private String applicantReason;

    private String applicantDesc;

    private Timestamp expirationDate;

    private String belongCloud;

    private String wfInstId;

    private String prodParam;
	 
    
    

    public Long getOrderDetailId() {
		return orderDetailId;
	}

	public void setOrderDetailId(Long orderDetailId) {
		this.orderDetailId = orderDetailId;
	}

	public String getCostCenterCode() {
		return costCenterCode;
	}

	public void setCostCenterCode(String costCenterCode) {
		this.costCenterCode = costCenterCode;
	}

	public String getCostCenterName() {
		return costCenterName;
	}

	public void setCostCenterName(String costCenterName) {
		this.costCenterName = costCenterName;
	}

	public Long getUserMaxNumbers() {
		return userMaxNumbers;
	}

	public void setUserMaxNumbers(Long userMaxNumbers) {
		this.userMaxNumbers = userMaxNumbers;
	}

	public Long getConcurrentNumbers() {
		return concurrentNumbers;
	}

	public void setConcurrentNumbers(Long concurrentNumbers) {
		this.concurrentNumbers = concurrentNumbers;
	}

	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	public String getUseType() {
		return useType;
	}

	public void setUseType(String useType) {
		this.useType = useType;
	}

	public String getApplyDesc() {
		return applyDesc;
	}

	public void setApplyDesc(String applyDesc) {
		this.applyDesc = applyDesc;
	}

	public String getOperateType() {
		return operateType;
	}

	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getProdType() {
		return prodType;
	}

	public void setProdType(String prodType) {
		this.prodType = prodType;
	}

	public String getProdId() {
		return prodId;
	}

	public void setProdId(String prodId) {
		this.prodId = prodId;
	}

	public String getProdByname() {
		return prodByname;
	}

	public void setProdByname(String prodByname) {
		this.prodByname = prodByname;
	}

	public String getProdParamZh() {
		return prodParamZh;
	}

	public void setProdParamZh(String prodParamZh) {
		this.prodParamZh = prodParamZh;
	}

	public Timestamp getOrderAppDate() {
		return orderAppDate;
	}

	public void setOrderAppDate(Timestamp orderAppDate) {
		this.orderAppDate = orderAppDate;
	}

	public Timestamp getPreOpenDate() {
		return preOpenDate;
	}

	public void setPreOpenDate(Timestamp preOpenDate) {
		this.preOpenDate = preOpenDate;
	}

	public String getOpenStatus() {
		return openStatus;
	}

	public void setOpenStatus(String openStatus) {
		this.openStatus = openStatus;
	}

	public String getOpenParam() {
		return openParam;
	}

	public void setOpenParam(String openParam) {
		this.openParam = openParam;
	}

	public String getOpenResult() {
		return openResult;
	}

	public void setOpenResult(String openResult) {
		this.openResult = openResult;
	}

	public Timestamp getOpenDate() {
		return openDate;
	}

	public void setOpenDate(Timestamp openDate) {
		this.openDate = openDate;
	}

	public String getOrderCheckStatus() {
		return orderCheckStatus;
	}

	public void setOrderCheckStatus(String orderCheckStatus) {
		this.orderCheckStatus = orderCheckStatus;
	}

	public String getOrderCheckResult() {
		return orderCheckResult;
	}

	public void setOrderCheckResult(String orderCheckResult) {
		this.orderCheckResult = orderCheckResult;
	}

	public Timestamp getOrderCheckDate() {
		return orderCheckDate;
	}

	public void setOrderCheckDate(Timestamp orderCheckDate) {
		this.orderCheckDate = orderCheckDate;
	}

	public String getOrderCheckDesc() {
		return orderCheckDesc;
	}

	public void setOrderCheckDesc(String orderCheckDesc) {
		this.orderCheckDesc = orderCheckDesc;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getUserServId() {
		return userServId;
	}

	public void setUserServId(String userServId) {
		this.userServId = userServId;
	}

	public String getUserServIpaasId() {
		return userServIpaasId;
	}

	public void setUserServIpaasId(String userServIpaasId) {
		this.userServIpaasId = userServIpaasId;
	}

	public String getUserServIpaasPwd() {
		return userServIpaasPwd;
	}

	public void setUserServIpaasPwd(String userServIpaasPwd) {
		this.userServIpaasPwd = userServIpaasPwd;
	}

	public String getApplicant() {
		return applicant;
	}

	public void setApplicant(String applicant) {
		this.applicant = applicant;
	}

	public String getApplicantDept() {
		return applicantDept;
	}

	public void setApplicantDept(String applicantDept) {
		this.applicantDept = applicantDept;
	}

	public String getApplicantTel() {
		return applicantTel;
	}

	public void setApplicantTel(String applicantTel) {
		this.applicantTel = applicantTel;
	}

	public String getApplicantEmail() {
		return applicantEmail;
	}

	public void setApplicantEmail(String applicantEmail) {
		this.applicantEmail = applicantEmail;
	}

	public String getApplicantReason() {
		return applicantReason;
	}

	public void setApplicantReason(String applicantReason) {
		this.applicantReason = applicantReason;
	}

	public String getApplicantDesc() {
		return applicantDesc;
	}

	public void setApplicantDesc(String applicantDesc) {
		this.applicantDesc = applicantDesc;
	}

	public Timestamp getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(Timestamp expirationDate) {
		this.expirationDate = expirationDate;
	}

	public String getBelongCloud() {
		return belongCloud;
	}

	public void setBelongCloud(String belongCloud) {
		this.belongCloud = belongCloud;
	}

	public String getWfInstId() {
		return wfInstId;
	}

	public void setWfInstId(String wfInstId) {
		this.wfInstId = wfInstId;
	}

	public String getProdParam() {
		return prodParam;
	}

	public void setProdParam(String prodParam) {
		this.prodParam = prodParam;
	}

	
	
	 


}
