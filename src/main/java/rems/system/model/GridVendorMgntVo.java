package rems.system.model;

import rems.common.model.GridVo;

public class GridVendorMgntVo extends GridVo<GridVendorMgntVo> {

	private String vendorCd;
	private String vendorNm;
	private String useYn;
	private String useYnNm;
	private String companyCd;
	private String finalUserNm;
	
	private String regiId;
	private String regiIdDttm;
	private String finalModId;
	private String finalModDttm;
	
	private String now;

	public String getFinalUserNm() {
		return finalUserNm;
	}

	public void setFinalUserNm(String finalUserNm) {
		this.finalUserNm = finalUserNm;
	}

	public String getCompanyCd() {
		return companyCd;
	}

	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}

	public String getVendorCd() {
		return vendorCd;
	}

	public void setVendorCd(String vendorCd) {
		this.vendorCd = vendorCd;
	}

	public String getVendorNm() {
		return vendorNm;
	}

	public void setVendorNm(String vendorNm) {
		this.vendorNm = vendorNm;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
	public String getUseYnNm() {
		return useYnNm;
	}

	public void setUseYnNm(String useYnNm) {
		this.useYnNm = useYnNm;
	}

	public String getRegiId() {
		return regiId;
	}

	public void setRegiId(String regiId) {
		this.regiId = regiId;
	}

	public String getRegiIdDttm() {
		return regiIdDttm;
	}

	public void setRegiIdDttm(String regiIdDttm) {
		this.regiIdDttm = regiIdDttm;
	}

	public String getFinalModId() {
		return finalModId;
	}

	public void setFinalModId(String finalModId) {
		this.finalModId = finalModId;
	}

	public String getFinalModDttm() {
		return finalModDttm;
	}

	public void setFinalModDttm(String finalModDttm) {
		this.finalModDttm = finalModDttm;
	}

	public String getNow() {
		return now;
	}

	public void setNow(String now) {
		this.now = now;
	}
}
