package rems.system.model;

import java.util.ArrayList;

import rems.util.*;

public class UserVo {

	private String userId;
	private String userPw;
	private String userNm;
	private String companyCd;
	private String companyNm;
	private String strCd;
	private String strNm;
	private String viewStrCd;
	private String localAreaCd;
	private String userType;
	private String userRollType;
	private String gcmRegiId;
	private String useYn;
	private String gwId;
	private String remsStartDt;
	private String authYn;
	private String timeDiff;
	private String emailAddress;
	private String eulaYn;
	private String userNewPw;
	private String accessType;
	private String yyyymmdd;
	private String yyyymm;
	private ArrayList<String> separator;
	private String minVal;
	

	private String now;
	private String orgFullNm;
	private String resultYn;  //시설물알림 추가
	

	private String encKey = Constants.ENCRYPT_KEY;

	
	
	public String getOrgFullNm() {
		return orgFullNm;
	}
	public void setOrgFullNm(String orgFullNm) {
		this.orgFullNm = orgFullNm;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	
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
	
	public String getViewStrCd() {
		return viewStrCd;
	}
	public void setViewStrCd(String viewStrCd) {
		this.viewStrCd = viewStrCd;
	}
	
	public String getLocalAreaCd() {
		return localAreaCd;
	}
	public void setLocalAreaCd(String localAreaCd) {
		this.localAreaCd = localAreaCd;
	}
	
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	
	public String getUserRollType() {
		return userRollType;
	}
	public void setUserRollType(String userRollType) {
		this.userRollType = userRollType;
	}
	
	public String getGcmRegiId() {
		return gcmRegiId;
	}
	
	public void setGcmRegiId(String gcmRegiId) {
		this.gcmRegiId = gcmRegiId;
	}
	
	public String getUseYn() {
		return useYn;
	}
	
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
	public String getGwId() {
		return gwId;
	}
	public void setGwId(String gwId) {
		this.gwId = gwId;
	}
	
	public String getRemsStartDt() {
		return remsStartDt;
	}
	public void setRemsStartDt(String remsStartDt) {
		this.remsStartDt = remsStartDt;
	}

	public String getAuthYn() {
		return authYn;
	}
	public void setAuthYn(String authYn) {
		this.authYn = authYn;
	}
	
	public String getEmailAddress() {
		return emailAddress;
	}
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getTimeDiff() {
		return timeDiff;
	}
	public void setTimeDiff(String timeDiff) {
		this.timeDiff = timeDiff;
	}	
	
	public String getEulaYn() {
		return eulaYn;
	}
	public void setEulaYn(String eulaYn) {
		this.eulaYn = eulaYn;
	}
	
	public String getUserNewPw() {
		return userNewPw;
	}
	public void setUserNewPw(String userNewPw) {
		this.userNewPw = userNewPw;
	}
	
	public String getAccessType() {
		return accessType;
	}
	public void setAccessType(String accessType) {
		this.accessType = accessType;
	}
	
	public String getYyyymmdd() {
		return yyyymmdd;
	}
	public void setYyyymmdd(String yyyymmdd) {
		this.yyyymmdd = yyyymmdd;
	}

	public String getYyyymm() {
		return yyyymm;
	}
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}	
	
	public ArrayList<String> getSeparator() {
		return separator;
	}

	public void setSeparator(ArrayList<String> separator) {
		this.separator = separator;
	}

	public String getMinVal() {
		return minVal;
	}

	public void setMinVal(String minVal) {
		this.minVal = minVal;
	}

	public String getEncKey() {
		return encKey;
	}

	public String getNow() {
		return now;
	}
	public void setNow(String now) {
		this.now = now;
	}
	public String getResultYn() {
		return resultYn;
	}
	public void setResultYn(String resultYn) {
		this.resultYn = resultYn;
	}
	public String showData() {
		
		String rslt = "";
		
		rslt += "\n";
		rslt += "[회사 코드   : " + companyCd   + "]\n";      
		rslt += "[점포 코드   : " + strCd       + "]\n";      
		rslt += "[실점포 코드 : " + viewStrCd   + "]\n";      
		rslt += "[지역 코드   : " + localAreaCd + "]\n";
		rslt += "[사용자ID    : " + userId      + "]\n";
		rslt += "[현재일      : " + yyyymmdd    + "]\n";
		rslt += "[현재월      : " + yyyymm      + "]\n";
		rslt += "[현재시간    : " + TimezoneUtils.retrieveNowByTimediff(timeDiff) + "]\n";
		rslt += "\n";
		
		return rslt;
		
	}
}
