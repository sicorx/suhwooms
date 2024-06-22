package rems.common.model;

public class UserMngVo extends GridVo<UserMngVo>{

	private String authNm;
	private String orgCd;
	private String orgNm;
	private String companyCd;
	private String userId;
	private String userNm;
	private String orgStrCd;
	private String strCnt;
	
	public String getAuthNm() {
		return authNm;
	}
	public void setAuthNm(String authNm) {
		this.authNm = authNm;
	}
	public String getOrgCd() {
		return orgCd;
	}
	public void setOrgCd(String orgCd) {
		this.orgCd = orgCd;
	}
	public String getOrgNm() {
		return orgNm;
	}
	public void setOrgNm(String orgNm) {
		this.orgNm = orgNm;
	}
	public String getCompanyCd() {
		return companyCd;
	}
	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getOrgStrCd() {
		return orgStrCd;
	}
	public void setOrgStrCd(String orgStrCd) {
		this.orgStrCd = orgStrCd;
	}
	public String getStrCnt() {
		return strCnt;
	}
	public void setStrCnt(String strCnt) {
		this.strCnt = strCnt;
	}	
	
}
