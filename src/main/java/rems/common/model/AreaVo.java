package rems.common.model;

public class AreaVo extends GridVo<AreaVo>{

	private String areaCnt;
	private String areaCd;
	private String fullAreaNm;
	private String areaNm;
	private String cityNm;
	private String dongNm;

	
	public String getAreaCnt() {
		return areaCnt;
	}

	public void setAreaCnt(String areaCnt) {
		this.areaCnt = areaCnt;
	}

	public String getAreaCd() {
		return areaCd;
	}
	
	public void setAreaCd(String areaCd) {
		this.areaCd = areaCd;
	}
	
	
	public String getFullAreaNm() {
		return fullAreaNm;
	}
	
	public void setFullAreaNm(String fullAreaNm) {
		this.fullAreaNm = fullAreaNm;
	}
	
	
	public String getAreaNm() {
		return areaNm;
	}
	
	public void setAreaNm(String areaNm) {
		this.areaNm = areaNm;
	}
	
	
	public String getCityNm() {
		return cityNm;
	}
	
	public void setCityNm(String cityNm) {
		this.cityNm = cityNm;
	}
	
	
	public String getDongNm() {
		return dongNm;
	}
	
	public void setDongNm(String dongNm) {
		this.dongNm = dongNm;
	}
}
