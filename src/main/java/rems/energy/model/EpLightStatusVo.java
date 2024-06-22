package rems.energy.model;

public class EpLightStatusVo {

	private String storeCount;
	private String lightUse;
	private String avgUse;
	private String avgUsePerArea;
	
	private String companyCd;
	private String yyyymm;
	private String light;
	
	public String getStoreCount() {
		return storeCount;
	}
	public void setStoreCount(String storeCount) {
		this.storeCount = storeCount;
	}
	public String getLightUse() {
		return lightUse;
	}
	public void setLightUse(String lightUse) {
		this.lightUse = lightUse;
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

	public String getLight() {
		return light;
	}
	public void setLight(String light) {
		this.light = light;
	}

}
