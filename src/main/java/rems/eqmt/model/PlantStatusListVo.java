package rems.eqmt.model;

import rems.common.model.GridVo;

public class PlantStatusListVo  extends GridVo<PlantStatusListVo> {

	private String strCd;
	private String viewStrCd;	
	private String strNm;	
	private String portNo;
	private String temonId;
	private String temonType;
	private String temonTypeName;
	private String orgFullNm;
	private String alarmCnt;
	
	private String hubId;
	private String deviceType;
	private String deviceLoc;
	private String deviceNm;
	private String maxSensTemp;
	private String minSensTemp;
	private String maxTemp;
	private String minTemp;
	private String delayTime;
	
	private String yyyymm;	 
	private String oscout;
	private String oscback;
	private String rif;
	private String wic;
	
	private String yyyymmdd;
	private String hhmin;
	private String hhmm;
	private String sensTemp;
		
	
	public String getTemonTypeName() {
		return temonTypeName;
	}
	public void setTemonTypeName(String temonTypeName) {
		this.temonTypeName = temonTypeName;
	}
	public String getStrNm() {
		return strNm;
	}
	public void setStrNm(String strNm) {
		this.strNm = strNm;
	}
	public String getMaxSensTemp() {
		return maxSensTemp;
	}
	public void setMaxSensTemp(String maxSensTemp) {
		this.maxSensTemp = maxSensTemp;
	}
	public String getMinSensTemp() {
		return minSensTemp;
	}
	public void setMinSensTemp(String minSensTemp) {
		this.minSensTemp = minSensTemp;
	}
	public String getViewStrCd() {
		return viewStrCd;
	}
	public void setViewStrCd(String viewStrCd) {
		this.viewStrCd = viewStrCd;
	}
	public String getOrgFullNm() {
		return orgFullNm;
	}
	public void setOrgFullNm(String orgFullNm) {
		this.orgFullNm = orgFullNm;
	}
	public String getAlarmCnt() {
		return alarmCnt;
	}
	public void setAlarmCnt(String alarmCnt) {
		this.alarmCnt = alarmCnt;
	}
	public String getHhmm() {
		return hhmm;
	}
	public void setHhmm(String hhmm) {
		this.hhmm = hhmm;
	}		
	public String getSensTemp() {
		return sensTemp;
	}
	public void setSensTemp(String sensTemp) {
		this.sensTemp = sensTemp;
	}
	public String getStrCd() {
		return strCd;
	}
	public void setStrCd(String strCd) {
		this.strCd = strCd;
	}
	public String getPortNo() {
		return portNo;
	}
	public void setPortNo(String portNo) {
		this.portNo = portNo;
	}
	public String getTemonId() {
		return temonId;
	}
	public void setTemonId(String temonId) {
		this.temonId = temonId;
	}
	public String getTemonType() {
		return temonType;
	}
	public void setTemonType(String temonType) {
		this.temonType = temonType;
	}
	public String getHubId() {
		return hubId;
	}
	public void setHubId(String hubId) {
		this.hubId = hubId;
	}	
	public String getDeviceType() {
		return deviceType;
	}
	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}
	public String getDeviceLoc() {
		return deviceLoc;
	}
	public void setDeviceLoc(String deviceLoc) {
		this.deviceLoc = deviceLoc;
	}
	public String getDeviceNm() {
		return deviceNm;
	}
	public void setDeviceNm(String deviceNm) {
		this.deviceNm = deviceNm;
	}
	public String getMaxTemp() {
		return maxTemp;
	}
	public void setMaxTemp(String maxTemp) {
		this.maxTemp = maxTemp;
	}
	public String getMinTemp() {
		return minTemp;
	}
	public void setMinTemp(String minTemp) {
		this.minTemp = minTemp;
	}
	public String getDelayTime() {
		return delayTime;
	}
	public void setDelayTime(String delayTime) {
		this.delayTime = delayTime;
	}
	public String getYyyymm() {
		return yyyymm;
	}
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	public String getOscout() {
		return oscout;
	}
	public void setOscout(String oscout) {
		this.oscout = oscout;
	}
	public String getOscback() {
		return oscback;
	}
	public void setOscback(String oscback) {
		this.oscback = oscback;
	}
	public String getRif() {
		return rif;
	}
	public void setRif(String rif) {
		this.rif = rif;
	}
	public String getWic() {
		return wic;
	}
	public void setWic(String wic) {
		this.wic = wic;
	}
	public String getYyyymmdd() {
		return yyyymmdd;
	}
	public void setYyyymmdd(String yyyymmdd) {
		this.yyyymmdd = yyyymmdd;
	}
	public String getHhmin() {
		return hhmin;
	}
	public void setHhmin(String hhmin) {
		this.hhmin = hhmin;
	}

}
