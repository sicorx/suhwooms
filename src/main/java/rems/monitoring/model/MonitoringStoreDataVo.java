package rems.monitoring.model;

import rems.common.model.GridVo;

public class MonitoringStoreDataVo extends GridVo<MonitoringStoreDataVo> {

	private String companyCd;
	private String userId;
	private String strCd;
	private String strNm;
	private String orgCd;	
	private String viewStrCd;
	private String addr;
	private String telNo;
	private String tempStat;
	private String tempUnitStat;
	private String signStat;
	private String semsStat;
	
	// 대시보드
	private String contPower;			// 계약전력
	private String totalMain;			// 일평균 메인 전력 사용량
	private String freePower;			// 일평균 메인 여유전력량
	
	private String storeCount;			// 전체 매장수
	private String totalAvgUse;			// 일평균 총 사용량
	private String avgUse;				// 일평균 매장별 사용량
	private String totalUse;			// 전력 사용량
	private String semsAbnormalStrCnt;	// SENS 이상매장
	
	
	public String getCompanyCd() {
		return companyCd;
	}
	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTotalMain() {
		return totalMain;
	}
	public void setTotalMain(String totalMain) {
		this.totalMain = totalMain;
	}
	public String getStoreCount() {
		return storeCount;
	}
	public void setStoreCount(String storeCount) {
		this.storeCount = storeCount;
	}
	public String getTotalAvgUse() {
		return totalAvgUse;
	}
	public void setTotalAvgUse(String totalAvgUse) {
		this.totalAvgUse = totalAvgUse;
	}
	public String getAvgUse() {
		return avgUse;
	}
	public void setAvgUse(String avgUse) {
		this.avgUse = avgUse;
	}
	public String getTotalUse() {
		return totalUse;
	}
	public void setTotalUse(String totalUse) {
		this.totalUse = totalUse;
	}
	public String getSemsAbnormalStrCnt() {
		return semsAbnormalStrCnt;
	}
	public void setSemsAbnormalStrCnt(String semsAbnormalStrCnt) {
		this.semsAbnormalStrCnt = semsAbnormalStrCnt;
	}
	public String getContPower() {
		return contPower;
	}
	public void setContPower(String contPower) {
		this.contPower = contPower;
	}
	public String getTempUnitStat() {
		return tempUnitStat;
	}
	public void setTempUnitStat(String tempUnitStat) {
		this.tempUnitStat = tempUnitStat;
	}
	public String getStrCd() {
		return strCd;
	}
	public void setStrCd(String strCd) {
		this.strCd = strCd;
	}
	public String getStrNm() {
		return strNm;
	}
	public void setStrNm(String strNm) {
		this.strNm = strNm;
	}
	public String getOrgCd() {
		return orgCd;
	}
	public void setOrgCd(String orgCd) {
		this.orgCd = orgCd;
	}
	public String getViewStrCd() {
		return viewStrCd;
	}
	public void setViewStrCd(String viewStrCd) {
		this.viewStrCd = viewStrCd;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getTempStat() {
		return tempStat;
	}
	public void setTempStat(String tempStat) {
		this.tempStat = tempStat;
	}
	public String getSignStat() {
		return signStat;
	}
	public void setSignStat(String signStat) {
		this.signStat = signStat;
	}
	public String getSemsStat() {
		return semsStat;
	}
	public void setSemsStat(String semsStat) {
		this.semsStat = semsStat;
	}
	public String getFreePower() {
		return freePower;
	}
	public void setFreePower(String freePower) {
		this.freePower = freePower;
	}
}