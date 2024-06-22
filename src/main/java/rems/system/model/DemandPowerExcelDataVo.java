package rems.system.model;

import rems.common.model.GridVo;

public class DemandPowerExcelDataVo extends GridVo<DemandPowerExcelDataVo>{

	private String strCd;					// 매장코드
	private String strNm;					// 매장명
	private String calculateYn;				// 계약전력 산출 유무
	private String storeArea;				// 매장면적
	private String electricentCd;			// 전기업체코드
	
	private String deviceGroup;				// 장비 분류
	private String deviceNm;				// 장비명
	private String deviceCnt;				// 수량
	private String deviceUnit;				// 단위
	private String deviceStandard;					// 규격(가로*세로*높이)
	private String consumWatage;			// 소비전력(W)
	private String useWatage;				// 사용소비전력(W)
	private String note;					// 비고
	
	private int rowNum;						// 행개수
	
	

	private String consumWatageSum;			// 소비전력합
	
	private String demandPower;				// 계약전력
	
	private String recommendDemandPower;	// 추천계약전력

	
	
	
	public String getDeviceUnit() {
		return deviceUnit;
	}

	public void setDeviceUnit(String deviceUnit) {
		this.deviceUnit = deviceUnit;
	}

	public String getDeviceStandard() {
		return deviceStandard;
	}

	public void setDeviceStandard(String deviceStandard) {
		this.deviceStandard = deviceStandard;
	}

	public String getStoreArea() {
		return storeArea;
	}

	public void setStoreArea(String storeArea) {
		this.storeArea = storeArea;
	}

	public int getRowNum() {
		return rowNum;
	}

	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}
	
	public String getDeviceGroup() {
		return deviceGroup;
	}

	public void setDeviceGroup(String deviceGroup) {
		this.deviceGroup = deviceGroup;
	}

	public String getStrCd() {
		return strCd;
	}

	public String getElectricentCd() {
		return electricentCd;
	}

	public void setElectricentCd(String electricentCd) {
		this.electricentCd = electricentCd;
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

	public String getCalculateYn() {
		return calculateYn;
	}

	public void setCalculateYn(String caculateYn) {
		this.calculateYn = caculateYn;
	}

	public String getDeviceNm() {
		return deviceNm;
	}

	public void setDeviceNm(String deviceNm) {
		this.deviceNm = deviceNm;
	}

	public String getDeviceCnt() {
		return deviceCnt;
	}

	public void setDeviceCnt(String deviceCnt) {
		this.deviceCnt = deviceCnt;
	}

	public String getConsumWatage() {
		return consumWatage;
	}

	public void setConsumWatage(String consumWatage) {
		this.consumWatage = consumWatage;
	}

	public String getUseWatage() {
		return useWatage;
	}

	public void setUseWatage(String useWatage) {
		this.useWatage = useWatage;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getConsumWatageSum() {
		return consumWatageSum;
	}

	public void setConsumWatageSum(String consumWatageSum) {
		this.consumWatageSum = consumWatageSum;
	}

	public String getDemandPower() {
		return demandPower;
	}

	public void setDemandPower(String demandPower) {
		this.demandPower = demandPower;
	}

	public String getRecommendDemandPower() {
		return recommendDemandPower;
	}

	public void setRecommendDemandPower(String recommendDemandPower) {
		this.recommendDemandPower = recommendDemandPower;
	}

	
	
	
	
}