package rems.eqmt.model;

import rems.common.model.GridVo;

public class SystemVo extends GridVo<SystemVo> {

	String userId;
	String userNm;
	String sysCnt;
	String menuId;
	String menuNm;
	String authId;
	String authNm;
	
	String strCd;
	String orgCd;
	String viewStrCd;
	String strNm;
	String orgFullName;
	String remsStartDt;
	String vendorNm;
	String lastYmdh;
	String lapseDay;
	
	String regiId;
	
	String electricentCd;
	String electricentNm;
	String useYn;
	String finalModId;
	String finalModNm;
	String finalModDttm;
	
	String useYnNm;
	
	String orgNm;
	String gwCnt;
	String temonCnt;
	String lineSensorCnt;
	String haconCnt;
	String tSensorCnt;
	String meterCnt;
	String ctCnt;
	String zigbeeCnt;
	String almonCnt;
	String invCnt;
	String signCnt;
	String emsBox;
	String remsDt;
	String companyCd;
	
	
	String strAreaSpec;
	String demandPower;
	String recommDemandPower;
	String judge;
	String yearMon;
	String maxUseWatage;
	String useWatageDiff;
	String totalWatage;
	String avgWatage;
	String operDayCnt;
	
	String no;
	String remsDeivceVendor;
	String testDt;
	String contents;
	String gwAddr;

	String alarmDateS;
	String alarmMessage;
	String deviceLoc;
	String asVendorNm;
	String alarmDateE;
	String lapseHour;
	String asContents;
	String asNote;
	String alarmCnt;
	
	String cntGw;
	String cntTemon;
	String cntLine;
	String cntHacon;
	String cntTsensor;
	String cntMeter;
	String cntCt;
	
	String maxWatage;
	
	
	
	
	public String getMaxWatage() {
		return maxWatage;
	}
	public void setMaxWatage(String maxWatage) {
		this.maxWatage = maxWatage;
	}
	public String getCompanyCd() {
		return companyCd;
	}
	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}
	public String getCntGw() {
		return cntGw;
	}
	public void setCntGw(String cntGw) {
		this.cntGw = cntGw;
	}
	public String getCntTemon() {
		return cntTemon;
	}
	public void setCntTemon(String cntTemon) {
		this.cntTemon = cntTemon;
	}
	public String getCntLine() {
		return cntLine;
	}
	public void setCntLine(String cntLine) {
		this.cntLine = cntLine;
	}
	public String getCntHacon() {
		return cntHacon;
	}
	public void setCntHacon(String cntHacon) {
		this.cntHacon = cntHacon;
	}
	public String getCntTsensor() {
		return cntTsensor;
	}
	public void setCntTsensor(String cntTsensor) {
		this.cntTsensor = cntTsensor;
	}
	public String getCntMeter() {
		return cntMeter;
	}
	public void setCntMeter(String cntMeter) {
		this.cntMeter = cntMeter;
	}
	public String getCntCt() {
		return cntCt;
	}
	public void setCntCt(String cntCt) {
		this.cntCt = cntCt;
	}
	public String getAlarmDateS() {
		return alarmDateS;
	}
	public void setAlarmDateS(String alarmDateS) {
		this.alarmDateS = alarmDateS;
	}
	public String getAlarmMessage() {
		return alarmMessage;
	}
	public void setAlarmMessage(String alarmMessage) {
		this.alarmMessage = alarmMessage;
	}
	public String getDeviceLoc() {
		return deviceLoc;
	}
	public void setDeviceLoc(String deviceLoc) {
		this.deviceLoc = deviceLoc;
	}
	public String getAsVendorNm() {
		return asVendorNm;
	}
	public void setAsVendorNm(String asVendorNm) {
		this.asVendorNm = asVendorNm;
	}
	public String getAlarmDateE() {
		return alarmDateE;
	}
	public void setAlarmDateE(String alarmDateE) {
		this.alarmDateE = alarmDateE;
	}
	public String getLapseHour() {
		return lapseHour;
	}
	public void setLapseHour(String lapseHour) {
		this.lapseHour = lapseHour;
	}
	public String getAsContents() {
		return asContents;
	}
	public void setAsContents(String asContents) {
		this.asContents = asContents;
	}
	public String getAsNote() {
		return asNote;
	}
	public void setAsNote(String asNote) {
		this.asNote = asNote;
	}
	public String getAlarmCnt() {
		return alarmCnt;
	}
	public void setAlarmCnt(String alarmCnt) {
		this.alarmCnt = alarmCnt;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getRemsDeivceVendor() {
		return remsDeivceVendor;
	}
	public void setRemsDeivceVendor(String remsDeivceVendor) {
		this.remsDeivceVendor = remsDeivceVendor;
	}
	public String getTestDt() {
		return testDt;
	}
	public void setTestDt(String testDt) {
		this.testDt = testDt;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getGwAddr() {
		return gwAddr;
	}
	public void setGwAddr(String gwAddr) {
		this.gwAddr = gwAddr;
	}

	public String getStrAreaSpec() {
		return strAreaSpec;
	}
	public void setStrAreaSpec(String strAreaSpec) {
		this.strAreaSpec = strAreaSpec;
	}
	public String getDemandPower() {
		return demandPower;
	}
	public void setDemandPower(String demandPower) {
		this.demandPower = demandPower;
	}
	public String getRecommDemandPower() {
		return recommDemandPower;
	}
	public void setRecommDemandPower(String recommDemandPower) {
		this.recommDemandPower = recommDemandPower;
	}
	public String getJudge() {
		return judge;
	}
	public void setJudge(String judge) {
		this.judge = judge;
	}
	public String getYearMon() {
		return yearMon;
	}
	public void setYearMon(String yearMon) {
		this.yearMon = yearMon;
	}
	public String getMaxUseWatage() {
		return maxUseWatage;
	}
	public void setMaxUseWatage(String maxUseWatage) {
		this.maxUseWatage = maxUseWatage;
	}
	public String getUseWatageDiff() {
		return useWatageDiff;
	}
	public void setUseWatageDiff(String useWatageDiff) {
		this.useWatageDiff = useWatageDiff;
	}
	public String getTotalWatage() {
		return totalWatage;
	}
	public void setTotalWatage(String totalWatage) {
		this.totalWatage = totalWatage;
	}
	public String getAvgWatage() {
		return avgWatage;
	}
	public void setAvgWatage(String avgWatage) {
		this.avgWatage = avgWatage;
	}
	public String getOperDayCnt() {
		return operDayCnt;
	}
	public void setOperDayCnt(String operDayCnt) {
		this.operDayCnt = operDayCnt;
	}
	public String getOrgNm() {
		return orgNm;
	}
	public void setOrgNm(String orgNm) {
		this.orgNm = orgNm;
	}
	public String getGwCnt() {
		return gwCnt;
	}
	public void setGwCnt(String gwCnt) {
		this.gwCnt = gwCnt;
	}
	public String getTemonCnt() {
		return temonCnt;
	}
	public void setTemonCnt(String temonCnt) {
		this.temonCnt = temonCnt;
	}
	public String getLineSensorCnt() {
		return lineSensorCnt;
	}
	public void setLineSensorCnt(String lineSensorCnt) {
		this.lineSensorCnt = lineSensorCnt;
	}
	public String getHaconCnt() {
		return haconCnt;
	}
	public void setHaconCnt(String haconCnt) {
		this.haconCnt = haconCnt;
	}
	public String gettSensorCnt() {
		return tSensorCnt;
	}
	public void settSensorCnt(String tSensorCnt) {
		this.tSensorCnt = tSensorCnt;
	}
	public String getMeterCnt() {
		return meterCnt;
	}
	public void setMeterCnt(String meterCnt) {
		this.meterCnt = meterCnt;
	}
	public String getCtCnt() {
		return ctCnt;
	}
	public void setCtCnt(String ctCnt) {
		this.ctCnt = ctCnt;
	}
	public String getZigbeeCnt() {
		return zigbeeCnt;
	}
	public void setZigbeeCnt(String zigbeeCnt) {
		this.zigbeeCnt = zigbeeCnt;
	}
	public String getAlmonCnt() {
		return almonCnt;
	}
	public void setAlmonCnt(String almonCnt) {
		this.almonCnt = almonCnt;
	}
	public String getInvCnt() {
		return invCnt;
	}
	public void setInvCnt(String invCnt) {
		this.invCnt = invCnt;
	}
	public String getSignCnt() {
		return signCnt;
	}
	public void setSignCnt(String signCnt) {
		this.signCnt = signCnt;
	}
	public String getEmsBox() {
		return emsBox;
	}
	public void setEmsBox(String emsBox) {
		this.emsBox = emsBox;
	}
	public String getRemsDt() {
		return remsDt;
	}
	public void setRemsDt(String remsDt) {
		this.remsDt = remsDt;
	}
	public String getUseYnNm() {
		return useYnNm;
	}
	public void setUseYnNm(String useYnNm) {
		this.useYnNm = useYnNm;
	}
	public String getElectricentCd() {
		return electricentCd;
	}
	public void setElectricentCd(String electricentCd) {
		this.electricentCd = electricentCd;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getFinalModNm() {
		return finalModNm;
	}
	public void setFinalModNm(String finalModNm) {
		this.finalModNm = finalModNm;
	}
	public String getFinalModDttm() {
		return finalModDttm;
	}
	public void setFinalModDttm(String finalModDttm) {
		this.finalModDttm = finalModDttm;
	}
	public String getRegiId() {
		return regiId;
	}
	public void setRegiId(String regiId) {
		this.regiId = regiId;
	}
	public String getFinalModId() {
		return finalModId;
	}
	public void setFinalModId(String finalModId) {
		this.finalModId = finalModId;
	}
	public String getStrCd() {
		return strCd;
	}
	public void setStrCd(String strCd) {
		this.strCd = strCd;
	}
	public String getViewStrCd() {
		return viewStrCd;
	}
	public void setViewStrCd(String viewStrCd) {
		this.viewStrCd = viewStrCd;
	}
	public String getStrNm() {
		return strNm;
	}
	public void setStrNm(String strNm) {
		this.strNm = strNm;
	}
	public String getOrgFullName() {
		return orgFullName;
	}
	public void setOrgFullName(String orgFullName) {
		this.orgFullName = orgFullName;
	}
	public String getRemsStartDt() {
		return remsStartDt;
	}
	public void setRemsStartDt(String remsStartDt) {
		this.remsStartDt = remsStartDt;
	}
	public String getVendorNm() {
		return vendorNm;
	}
	public void setVendorNm(String vendorNm) {
		this.vendorNm = vendorNm;
	}
	public String getElectricentNm() {
		return electricentNm;
	}
	public void setElectricentNm(String electricentNm) {
		this.electricentNm = electricentNm;
	}
	public String getLastYmdh() {
		return lastYmdh;
	}
	public void setLastYmdh(String lastYmdh) {
		this.lastYmdh = lastYmdh;
	}
	public String getLapseDay() {
		return lapseDay;
	}
	public void setLapseDay(String lapseDay) {
		this.lapseDay = lapseDay;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getSysCnt() {
		return sysCnt;
	}
	public void setSysCnt(String sysCnt) {
		this.sysCnt = sysCnt;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getMenuNm() {
		return menuNm;
	}
	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getAuthNm() {
		return authNm;
	}
	public void setAuthNm(String authNm) {
		this.authNm = authNm;
	}
	public String getOrgCd() {
		return orgCd;
	}
	public void setOrgCd(String orgCd) {
		this.orgCd = orgCd;
	}
	
	
}
