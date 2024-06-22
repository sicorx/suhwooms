package rems.system.model;

import rems.common.model.GridVo;

public class StoreInverterDataVo extends GridVo<StoreInverterDataVo> {

	private String strCd;
	private String hubIdList = "";
	private String portNoList = "";
	private String deviceTypeList = "";
	private String deviceLocList = "";
	private String contentsList = "";
	private String pushTermList = "";
	private String useYnList = "";
	private String regiId;
	private String regiDttm;
	private String finalModId;
	private String finalModDttm;
	private String regiNm;
	private String now;
	private String orgFullNm;
	
	
	public String getOrgFullNm() {
		return orgFullNm;
	}
	public void setOrgFullNm(String orgFullNm) {
		this.orgFullNm = orgFullNm;
	}
	public String getStrCd() {
		return strCd;
	}
	public void setStrCd(String strCd) {
		this.strCd = strCd;
	}
	public String getHubIdList() {
		return hubIdList;
	}
	public void setHubIdList(String hubIdList) {
		this.hubIdList = hubIdList;
	}
	public String getPortNoList() {
		return portNoList;
	}
	public void setPortNoList(String portNoList) {
		this.portNoList = portNoList;
	}
	public String getDeviceTypeList() {
		return deviceTypeList;
	}
	public void setDeviceTypeList(String deviceTypeList) {
		this.deviceTypeList = deviceTypeList;
	}
	public String getDeviceLocList() {
		return deviceLocList;
	}
	public void setDeviceLocList(String deviceLocList) {
		this.deviceLocList = deviceLocList;
	}
	public String getContentsList() {
		return contentsList;
	}
	public void setContentsList(String contentsList) {
		this.contentsList = contentsList;
	}
	public String getPushTermList() {
		return pushTermList;
	}
	public void setPushTermList(String pushTermList) {
		this.pushTermList = pushTermList;
	}
	public String getUseYnList() {
		return useYnList;
	}
	public void setUseYnList(String useYnList) {
		this.useYnList = useYnList;
	}
	public String getRegiId() {
		return regiId;
	}
	public void setRegiId(String regiId) {
		this.regiId = regiId;
	}
	public String getRegiDttm() {
		return regiDttm;
	}
	public void setRegiDttm(String regiDttm) {
		this.regiDttm = regiDttm;
	}
	public String getFinalModId() {
		return finalModId;
	}
	public void setFinalModId(String finalModId) {
		this.finalModId = finalModId;
	}
	public String getFinalModDttm() {
		return finalModDttm;
	}
	public void setFinalModDttm(String finalModDttm) {
		this.finalModDttm = finalModDttm;
	}
	public String getRegiNm() {
		return regiNm;
	}
	public void setRegiNm(String regiNm) {
		this.regiNm = regiNm;
	}
	public String getNow() {
		return now;
	}
	public void setNow(String now) {
		this.now = now;
	}
}