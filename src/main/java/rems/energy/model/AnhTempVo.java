package rems.energy.model;

public class AnhTempVo {

	private String storeCount;
	private String totalUse;
	private String avgUse;
	private String avgUsePerArea;
	
	private String companyCd;
	private String yyyymm;
	private String predict;
	
	private String temp;
	private String light;
	private String etc;
	
	private Double outTmTemp;
	private Double outOmTemp;
	private Double inTmTemp;
	private Double inOmTemp;
	
	public String getStoreCount() {
		return storeCount;
	}
	public void setStoreCount(String storeCount) {
		this.storeCount = storeCount;
	}
	public String getTotalUse() {
		return totalUse;
	}
	public void setTotalUse(String totalUse) {
		this.totalUse = totalUse;
	}
	public String getAvgUse() {
		return avgUse;
	}
	public void setAvgUse(String avgUse) {
		this.avgUse = avgUse;
	}
	public String getAvgUsePerArea() {
		return avgUsePerArea;
	}
	public void setAvgUsePerArea(String avgUsePerArea) {
		this.avgUsePerArea = avgUsePerArea;
	}
	public String getCompanyCd() {
		return companyCd;
	}
	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}
	public String getYyyymm() {
		return yyyymm;
	}
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	public String getPredict() {
		return predict;
	}
	public void setPredict(String predict) {
		this.predict = predict;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public String getLight() {
		return light;
	}
	public void setLight(String light) {
		this.light = light;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	
	public Double getOutTmTemp() {
		return outTmTemp;
	}
	public void setOutTmTemp(Double outTmTemp) {
		this.outTmTemp = outTmTemp;
	}
	
	public Double getOutOmTemp() {
		return outOmTemp;
	}
	public void setOutOmTemp(Double outOmTemp) {
		this.outOmTemp = outOmTemp;
	}
	
	public Double getInTmTemp() {
		return inTmTemp;
	}
	public void setInTmTemp(Double inTmTemp) {
		this.inTmTemp = inTmTemp;
	}
	
	public Double getInOmTemp() {
		return inOmTemp;
	}
	public void setInOmTemp(Double inOmTemp) {
		this.inOmTemp = inOmTemp;
	}
}
