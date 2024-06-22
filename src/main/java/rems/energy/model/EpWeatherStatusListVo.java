package rems.energy.model;

public class EpWeatherStatusListVo {

	private String yyyymm;
	private String sunnyCount;
	private String cloudyCount;
	private String rowCount;


	public String getYyyymm() {
		return yyyymm;
	}
	
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	
	
	public String getSunnyCount() {
		return sunnyCount;
	}
	
	public void setSunnyCount(String sunnyCount) {
		this.sunnyCount = sunnyCount;
	}
	
	
	public String getCloudyCount() {
		return cloudyCount;
	}
	
	public void setCloudyCount(String cloudyCount) {
		this.cloudyCount = cloudyCount;
	}
	
	
	public String getRowCount() {
		return rowCount;
	}
	
	public void setRowCount(String rowCount) {
		this.rowCount = rowCount;
	}
}
