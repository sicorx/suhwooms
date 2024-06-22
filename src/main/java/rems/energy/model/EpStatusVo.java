package rems.energy.model;

public class EpStatusVo {

	private String storeCount;
	private String totalUse;
	private String avgUse;
	private String avgUsePerArea;
	private String main;
	
	private String companyCd;
	
	private String predict;
	
	private String yyyy;
	private String mm;
	private String dd;
	private String hh;
	private String yyyymm;
	private String yyyymmdd;
	
	private String total;			// 메인 전력량
	private String temp;			// 냉난방 전력량
	private String light;			// 미사용
	private String etc;				// 메인 전력량 - 냉난방 전력량
	private String forecastTemp;	// 실외온도
	private String tSensorTemp;		// 실내온도
	private String contMinusTotal;		// 실내온도
	
	public String getContMinusTotal() {
		return contMinusTotal;
	}
	public void setContMinusTotal(String contMinusTotal) {
		this.contMinusTotal = contMinusTotal;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getYyyymmdd() {
		return yyyymmdd;
	}
	public void setYyyymmdd(String yyyymmdd) {
		this.yyyymmdd = yyyymmdd;
	}
	public String getDd() {
		return dd;
	}
	public void setDd(String dd) {
		this.dd = dd;
	}
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
	
	public String getYyyy() {
		return yyyy;
	}
	
	public void setYyyy(String yyyy) {
		this.yyyy = yyyy;
	}
	
	public String getMm() {
		return mm;
	}
	
	public void setMm(String mm) {
		this.mm = mm;
	}
	
	public String getHh() {
		return hh;
	}
	public void setHh(String hh) {
		this.hh = hh;
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
	public String getMain() {
		return main;
	}
	public void setMain(String main) {
		this.main = main;
	}
}
