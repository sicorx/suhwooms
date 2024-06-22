package rems.system.model;

import rems.common.model.GridVo;

public class DashBoardStoreDataVo extends GridVo<DashBoardStoreDataVo> {

	private String strCd;
	private String strNm;
	private String orgCd;	
	private String viewStrCd;
	private String addr;
	private String telNo;
	private String weatherCd;
	private String forecastTemp;
	private String tSensorTemp;
	private String tempStat;
	private String tempUnitStat;
	private String signStat;
	private String semsStat;
	
	private String contKilo;
	private String lastMonthUsage;
	private String curMonthUsage;
	private String curPredictUsage;
	
	private String yyyymmdd;
	private String yyyymm;
	private String total;
	private String temp;
	private String etc;
	
	private String yResult;
	private String nResult;
	private String resultCnt;
	
	private String deviceLoc;
	private String sensTemp;
	private String normalYn;
	private String alarmCnt;
	
	// 대시보드
	private String storeCount;			// 전체 매장수
	private String totalAvgUse;			// 일평균 총 사용량
	private String avgUse;				// 일평균 매장별 사용량
	private String totalUse;			// 전력 사용량
	private String semsAbnormalStrCnt;	// SENS 이상매장
	
	private String contPower;			// 계약전력
	private String totalMain;			// 일평균 메인 전력 사용량
	private String freePower;			// 일평균 메인 여유전력량
	
	
	private String title;				// 공지사항 - 게시글 제목
	private String userNm;				// 공지사항 - 게시글 작성자
	private String pubDttm;				// 공지사항 - 게시글 작성일시
	
	private String peakCnt;				// 피크 매장 수
	
	private String eqmtCnt;				// 비정상 매장 수
	private String eqstCnt;				// 시설물장애 매장 수
	private String notiCnt;				// 공지사항 수
	private String zeroCnt;				// dd데이터누락 수
	
	private String authId;
	
	
	public String getZeroCnt() {
		return zeroCnt;
	}
	public void setZeroCnt(String zeroCnt) {
		this.zeroCnt = zeroCnt;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getEqmtCnt() {
		return eqmtCnt;
	}
	public void setEqmtCnt(String eqmtCnt) {
		this.eqmtCnt = eqmtCnt;
	}
	public String getEqstCnt() {
		return eqstCnt;
	}
	public void setEqstCnt(String eqstCnt) {
		this.eqstCnt = eqstCnt;
	}
	public String getNotiCnt() {
		return notiCnt;
	}
	public void setNotiCnt(String notiCnt) {
		this.notiCnt = notiCnt;
	}
	
	public String getPeakCnt() {
		return peakCnt;
	}
	public void setPeakCnt(String peakCnt) {
		this.peakCnt = peakCnt;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getPubDttm() {
		return pubDttm;
	}
	public void setPubDttm(String pubDttm) {
		this.pubDttm = pubDttm;
	}
	public String getYyyymm() {
		return yyyymm;
	}
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
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
	public String getWeatherCd() {
		return weatherCd;
	}
	public void setWeatherCd(String weatherCd) {
		this.weatherCd = weatherCd;
	}
	public String getForecastTemp() {
		return forecastTemp;
	}
	public void setForecastTemp(String forecastTemp) {
		this.forecastTemp = forecastTemp;
	}
	public String gettSensorTemp() {
		return tSensorTemp;
	}
	public void settSensorTemp(String tSensorTemp) {
		this.tSensorTemp = tSensorTemp;
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
	public String getContKilo() {
		return contKilo;
	}
	public void setContKilo(String contKilo) {
		this.contKilo = contKilo;
	}
	public String getLastMonthUsage() {
		return lastMonthUsage;
	}
	public void setLastMonthUsage(String lastMonthUsage) {
		this.lastMonthUsage = lastMonthUsage;
	}
	public String getCurMonthUsage() {
		return curMonthUsage;
	}
	public void setCurMonthUsage(String curMonthUsage) {
		this.curMonthUsage = curMonthUsage;
	}
	public String getCurPredictUsage() {
		return curPredictUsage;
	}
	public void setCurPredictUsage(String curPredictUsage) {
		this.curPredictUsage = curPredictUsage;
	}
	public String getYyyymmdd() {
		return yyyymmdd;
	}
	public void setYyyymmdd(String yyyymmdd) {
		this.yyyymmdd = yyyymmdd;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getyResult() {
		return yResult;
	}
	public void setyResult(String yResult) {
		this.yResult = yResult;
	}
	public String getnResult() {
		return nResult;
	}
	public void setnResult(String nResult) {
		this.nResult = nResult;
	}
	public String getResultCnt() {
		return resultCnt;
	}
	public void setResultCnt(String resultCnt) {
		this.resultCnt = resultCnt;
	}
	public String getDeviceLoc() {
		return deviceLoc;
	}
	public void setDeviceLoc(String deviceLoc) {
		this.deviceLoc = deviceLoc;
	}
	public String getSensTemp() {
		return sensTemp;
	}
	public void setSensTemp(String sensTemp) {
		this.sensTemp = sensTemp;
	}
	public String getNormalYn() {
		return normalYn;
	}
	public void setNormalYn(String normalYn) {
		this.normalYn = normalYn;
	}
	public String getAlarmCnt() {
		return alarmCnt;
	}
	public void setAlarmCnt(String alarmCnt) {
		this.alarmCnt = alarmCnt;
	}
	public String getFreePower() {
		return freePower;
	}
	public void setFreePower(String freePower) {
		this.freePower = freePower;
	}
}