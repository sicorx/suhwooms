package rems.system.model;

import rems.common.model.GridVo;

public class AuthVo extends GridVo<AuthVo>{

	private String companyCd;
	private String authCd;
	private String authSp;
	private String authId;			// authCd => authId 변경
	private String authNm;
	private String authDesc;
	private String useYn;
	private String regiId;
	private String regiDttm;
	private String finalModId;
	private String finalModUserNm;
	private String finalModDttm;
	private String now;
	boolean rslt = false;
	
	
	
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getCompanyCd() {
		return companyCd;
	}
	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}
	public String getAuthCd() {
		return authCd;
	}
	public void setAuthCd(String authCd) {
		this.authCd = authCd;
	}
	public String getAuthSp() {
		return authSp;
	}
	public void setAuthSp(String authSp) {
		this.authSp = authSp;
	}
	public String getAuthNm() {
		return authNm;
	}
	public void setAuthNm(String authNm) {
		this.authNm = authNm;
	}
	public String getAuthDesc() {
		return authDesc;
	}
	public void setAuthDesc(String authDesc) {
		this.authDesc = authDesc;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getRegiId() {
		return regiId;
	}
	public void setRegiId(String regiId) {
		this.regiId = regiId;
	}
	public String getRegiDttm() {
		return regiDttm;
	}
	public void setRegiDttm(String regiDttm) {
		this.regiDttm = regiDttm;
	}
	public String getFinalModId() {
		return finalModId;
	}
	public void setFinalModId(String finalModId) {
		this.finalModId = finalModId;
	}
	public String getFinalModUserNm() {
		return finalModUserNm;
	}
	public void setFinalModUserNm(String finalModUserNm) {
		this.finalModUserNm = finalModUserNm;
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
	public boolean isRslt() {
		return rslt;
	}
	public void setRslt(boolean rslt) {
		this.rslt = rslt;
	}
	
}