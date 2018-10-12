package com.redscarf.admin.modules.g7.entity;

import com.redscarf.admin.common.persistence.DataEntity;
import org.hibernate.validator.constraints.Length;

/**
 * 公众号导入日志生成Entity
 * @author LeeJohn
 * @version 2016-11-17
 */
public class OffiAcctImportLog extends DataEntity<OffiAcctImportLog> {
	
	private static final long serialVersionUID = 1L;
	private String batchId;		// 导入批次号
	private String alias;		// 微信ID
	private String nikiName;    //微信昵称
	private String userName;    //微信用户名
	private String serviceTypeInfo;  //微信认证类型
	private String articleUrl;		// 公众号文章URL
	private String triggerName;		// 监控时间表达式
	private String status;		// 微信状态
	
	public OffiAcctImportLog() {
		super();
	}

	public OffiAcctImportLog(String id){
		super(id);
	}

	@Length(min=1, max=12, message="导入批次号长度必须介于 1 和 12 之间")
	public String getBatchId() {
		return batchId;
	}

	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}
	
	@Length(min=1, max=64, message="微信ID长度必须介于 1 和 64 之间")
	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	@Length(min=1, max=64, message="微信昵称长度必须介于 1 和 64 之间")
	public String getNikiName() {
		return nikiName;
	}

	public void setNikiName(String nikiName) {
		this.nikiName = nikiName;
	}

	@Length(min=1, max=64, message="微信用户名长度必须介于 1 和 64 之间")
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Length(min=1, max=64, message="微信认证类型长度必须介于 1 和 64 之间")
	public String getServiceTypeInfo() {
		return serviceTypeInfo;
	}

	public void setServiceTypeInfo(String serviceTypeInfo) {
		this.serviceTypeInfo = serviceTypeInfo;
	}

	@Length(min=0, max=256, message="微信BIZ长度必须介于 0 和 256 之间")
	public String getArticleUrl() {
		return articleUrl;
	}

	public void setArticleUrl(String articleUrl) {
		this.articleUrl = articleUrl;
	}

	@Length(min=0, max=64, message="监控时间表达式名称长度必须介于 0 和 64 之间")
	public String getTriggerName() {
		return triggerName;
	}

	public void setTriggerName(String triggerName) {
		this.triggerName = triggerName;
	}

	@Length(min=0, max=4, message="微信状态长度必须介于 0 和 4 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}