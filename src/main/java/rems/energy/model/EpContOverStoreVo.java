package rems.energy.model;

public class EpContOverStoreVo {

	private String yymm;
	private String yyyymm;
	private String peakCount;
	private String companyCd;
		
	private String avgCont;
	private String max;
	private String min;
	private String stdev;
	private String avgTotal;
	private String avgTemp;
	private String avgLight;
	
	public String getYymm() {
		return yymm;
	}
	public void setYymm(String yymm) {
		this.yymm = yymm;
	}
	public String getYyyymm() {
		return yyyymm;
	}
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	public String getPeakCount() {
		return peakCount;
	}
	public void setPeakCount(String peakCount) {
		this.peakCount = peakCount;
	}
	public String getCompanyCd() {
		return companyCd;
	}
	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}

	public String getAvgCont() {
		return avgCont;
	}
	public void setAvgCont(String avgCont) {
		this.avgCont = avgCont;
	}
	public String getMax() {
		return max;
	}
	public void setMax(String max) {
		this.max = max;
	}
	public String getMin() {
		return min;
	}
	public void setMin(String min) {
		this.min = min;
	}
	public String getStdev() {
		return stdev;
	}
	public void setStdev(String stdev) {
		this.stdev = stdev;
	}
	public String getAvgTotal() {
		return avgTotal;
	}
	public void setAvgTotal(String avgTotal) {
		this.avgTotal = avgTotal;
	}
	public String getAvgTemp() {
		return avgTemp;
	}
	public void setAvgTemp(String avgTemp) {
		this.avgTemp = avgTemp;
	}
	public String getAvgLight() {
		return avgLight;
	}
	public void setAvgLight(String avgLight) {
		this.avgLight = avgLight;
	}
}