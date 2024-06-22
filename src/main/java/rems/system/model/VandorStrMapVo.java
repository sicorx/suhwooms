package rems.system.model;

import rems.common.model.GridVo;

public class VandorStrMapVo extends GridVo<VandorStrMapVo> {
	private String companyCd;
	private String companyNm;
	private String strCd;
	private String strNm;
	private String addr;
	private String vendorCd;
	private String vendorNm;
	private String remsStartDt;
	
	public String getCompanyCd() {
		return companyCd;
	}
	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}
	public String getCompanyNm() {
		return companyNm;
	}
	public void setCompanyNm(String companyNm) {
		this.companyNm = companyNm;
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
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
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
	public String getRemsStartDt() {
		return remsStartDt;
	}
	public void setRemsStartDt(String remsStartDt) {
		this.remsStartDt = remsStartDt;
	}
	
}