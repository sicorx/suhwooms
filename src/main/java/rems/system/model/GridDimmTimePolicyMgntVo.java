package rems.system.model;

import rems.common.model.GridVo;

public class GridDimmTimePolicyMgntVo extends GridVo<GridDimmTimePolicyMgntVo> {
	
	private String companyCd;
	private String dimCd;
	private String unsundimmtime;
	private String sundimmtime;
	private String SessionUserId;
	private String timeSunDimmList;
	private String timeUnSunDimmList;
	private String regiId;
	private String regiIdDttm;
	
	public String getCompanyCd() {
		return companyCd;
	}
	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}
	public String getRegiId() {
		return regiId;
	}
	public void setRegiId(String regiId) {
		this.regiId = regiId;
	}
	public String getRegiIdDttm() {
		return regiIdDttm;
	}
	public void setRegiIdDttm(String regiIdDttm) {
		this.regiIdDttm = regiIdDttm;
	}
	public String getDimCd() {
		return dimCd;
	}
	public void setDimCd(String dimCd) {
		this.dimCd = dimCd;
	}
	public String getUnsundimmtime() {
		return unsundimmtime;
	}
	public void setUnsundimmtime(String unsundimmtime) {
		this.unsundimmtime = unsundimmtime;
	}
	public String getSundimmtime() {
		return sundimmtime;
	}
	public void setSundimmtime(String sundimmtime) {
		this.sundimmtime = sundimmtime;
	}
	public String getSessionUserId() {
		return SessionUserId;
	}
	public void setSessionUserId(String sessionUserId) {
		SessionUserId = sessionUserId;
	}
	public String getTimeSunDimmList() {
		return timeSunDimmList;
	}
	public void setTimeSunDimmList(String timeSunDimmList) {
		this.timeSunDimmList = timeSunDimmList;
	}
	public String getTimeUnSunDimmList() {
		return timeUnSunDimmList;
	}
	public void setTimeUnSunDimmList(String timeUnSunDimmList) {
		this.timeUnSunDimmList = timeUnSunDimmList;
	}

}
