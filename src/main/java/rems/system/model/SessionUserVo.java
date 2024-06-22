package rems.system.model;

import java.util.ArrayList;

import rems.util.*;

public class SessionUserVo {

	private String sessionUserId;
	private String sessionUserPw;
	private String sessionUserNm;
	private String sessionCompanyCd;
	private String sessionCompanyNm;
	private String sessionVendorCd;
	private String sessionVendorNm;
	private String sessionStrCd;
	private String sessionStrNm;
	private String sessionViewStrCd;
	private String sessionLocalAreaCd;
	private String sessionAuthSp;
	private String sessionAuthId;
	private String sessionUserAuthCd;
	private String sessionGcmRegiId;
	private String sessionUseYn;
	private String sessionGwId;
	private String sessionRemsStartDt;
	private String sessionAuthYn;
	private String sessionTimeDiff;
	private String sessionEulaYn;
	private String sessionUserNewPw;
	private String sessionAccessType;
	private String sessionYyyyMmDd;
	private String sessionYyyyMm;
	private ArrayList<String> sessionSeperator;
	private String sessionMinVal;
	private String now;

	private String sessionScrStrCd;
	private String sessionScrStrNm;
	private String sessionScrViewStrCd;
	
	private String sessionElectricentCd;
	private String sessionElectricentNm;
	
	private String encKey = Constants.ENCRYPT_KEY;

	public String showData() {
		
		String rslt = "";
		
		rslt += "\n";
		rslt += "[회사 코드   : " + sessionCompanyCd   + "]\n";      
		rslt += "[점포 코드   : " + sessionStrCd       + "]\n";      
		rslt += "[실점포 코드 : " + sessionViewStrCd   + "]\n";      
		rslt += "[지역 코드   : " + sessionLocalAreaCd + "]\n";
		rslt += "[사용자ID    : " + sessionUserId      + "]\n";
		rslt += "[권한Sp      : " + sessionAuthSp      + "]\n";
		rslt += "[권한Id      : " + sessionAuthId	   + "]\n";
		rslt += "[현재일      : " + sessionYyyyMmDd    + "]\n";
		rslt += "[현재월      : " + sessionYyyyMm      + "]\n";		
		rslt += "[현재시간    : " + TimezoneUtils.retrieveNowByTimediff(sessionTimeDiff) + "]\n";
		rslt += "\n";
		
		return rslt;
	}
	
	
	
	public String getSessionElectricentCd() {
		return sessionElectricentCd;
	}



	public void setSessionElectricentCd(String sessionElectricentCd) {
		this.sessionElectricentCd = sessionElectricentCd;
	}



	public String getSessionElectricentNm() {
		return sessionElectricentNm;
	}



	public void setSessionElectricentNm(String sessionElectricentNm) {
		this.sessionElectricentNm = sessionElectricentNm;
	}



	public String getSessionAuthId() {
		return sessionAuthId;
	}

	public void setSessionAuthId(String sessionAuthId) {
		this.sessionAuthId = sessionAuthId;
	}

	public String getSessionScrStrCd() {
		return sessionScrStrCd;
	}

	public void setSessionScrStrCd(String sessionScrStrCd) {
		this.sessionScrStrCd = sessionScrStrCd;
	}

	public String getSessionScrStrNm() {
		return sessionScrStrNm;
	}

	public void setSessionScrStrNm(String sessionScrStrNm) {
		this.sessionScrStrNm = sessionScrStrNm;
	}

	public String getSessionScrViewStrCd() {
		return sessionScrViewStrCd;
	}

	public void setSessionScrViewStrCd(String sessionScrViewStrCd) {
		this.sessionScrViewStrCd = sessionScrViewStrCd;
	}

	public String getSessionUserId() {
		return sessionUserId;
	}

	public void setSessionUserId(String sessionUserId) {
		this.sessionUserId = sessionUserId;
	}

	public String getSessionUserPw() {
		return sessionUserPw;
	}

	public void setSessionUserPw(String sessionUserPw) {
		this.sessionUserPw = sessionUserPw;
	}

	public String getSessionUserNm() {
		return sessionUserNm;
	}

	public void setSessionUserNm(String sessionUserNm) {
		this.sessionUserNm = sessionUserNm;
	}

	public String getSessionCompanyCd() {
		return sessionCompanyCd;
	}

	public void setSessionCompanyCd(String sessionCompanyCd) {
		this.sessionCompanyCd = sessionCompanyCd;
	}

	public String getSessionCompanyNm() {
		return sessionCompanyNm;
	}

	public void setSessionCompanyNm(String sessionCompanyNm) {
		this.sessionCompanyNm = sessionCompanyNm;
	}

	public String getSessionVendorCd() {
		return sessionVendorCd;
	}

	public void setSessionVendorCd(String sessionVendorCd) {
		this.sessionVendorCd = sessionVendorCd;
	}

	public String getSessionVendorNm() {
		return sessionVendorNm;
	}

	public void setSessionVendorNm(String sessionVendorNm) {
		this.sessionVendorNm = sessionVendorNm;
	}

	public String getSessionStrCd() {
		return sessionStrCd;
	}

	public void setSessionStrCd(String sessionStrCd) {
		this.sessionStrCd = sessionStrCd;
	}

	public String getSessionStrNm() {
		return sessionStrNm;
	}

	public void setSessionStrNm(String sessionStrNm) {
		this.sessionStrNm = sessionStrNm;
	}

	public String getSessionViewStrCd() {
		return sessionViewStrCd;
	}

	public void setSessionViewStrCd(String sessionViewStrCd) {
		this.sessionViewStrCd = sessionViewStrCd;
	}

	public String getSessionLocalAreaCd() {
		return sessionLocalAreaCd;
	}

	public void setSessionLocalAreaCd(String sessionLocalAreaCd) {
		this.sessionLocalAreaCd = sessionLocalAreaCd;
	}

	public String getSessionAuthSp() {
		return sessionAuthSp;
	}

	public void setSessionAuthSp(String sessionAuthSp) {
		this.sessionAuthSp = sessionAuthSp;
	}

	public String getSessionUserAuthCd() {
		return sessionUserAuthCd;
	}

	public void setSessionUserAuthCd(String sessionUserAuthCd) {
		this.sessionUserAuthCd = sessionUserAuthCd;
	}

	public String getSessionGcmRegiId() {
		return sessionGcmRegiId;
	}

	public void setSessionGcmRegiId(String sessionGcmRegiId) {
		this.sessionGcmRegiId = sessionGcmRegiId;
	}

	public String getSessionUseYn() {
		return sessionUseYn;
	}

	public void setSessionUseYn(String sessionUseYn) {
		this.sessionUseYn = sessionUseYn;
	}

	public String getSessionGwId() {
		return sessionGwId;
	}

	public void setSessionGwId(String sessionGwId) {
		this.sessionGwId = sessionGwId;
	}

	public String getSessionRemsStartDt() {
		return sessionRemsStartDt;
	}

	public void setSessionRemsStartDt(String sessionRemsStartDt) {
		this.sessionRemsStartDt = sessionRemsStartDt;
	}

	public String getSessionAuthYn() {
		return sessionAuthYn;
	}

	public void setSessionAuthYn(String sessionAuthYn) {
		this.sessionAuthYn = sessionAuthYn;
	}

	public String getSessionTimeDiff() {
		return sessionTimeDiff;
	}

	public void setSessionTimeDiff(String sessionTimeDiff) {
		this.sessionTimeDiff = sessionTimeDiff;
	}

	public String getSessionEulaYn() {
		return sessionEulaYn;
	}

	public void setSessionEulaYn(String sessionEulaYn) {
		this.sessionEulaYn = sessionEulaYn;
	}

	public String getSessionUserNewPw() {
		return sessionUserNewPw;
	}

	public void setSessionUserNewPw(String sessionUserNewPw) {
		this.sessionUserNewPw = sessionUserNewPw;
	}

	public String getSessionAccessType() {
		return sessionAccessType;
	}

	public void setSessionAccessType(String sessionAccessType) {
		this.sessionAccessType = sessionAccessType;
	}

	public String getSessionYyyyMmDd() {
		return sessionYyyyMmDd;
	}

	public void setSessionYyyyMmDd(String sessionYyyyMmDd) {
		this.sessionYyyyMmDd = sessionYyyyMmDd;
	}

	public String getSessionYyyyMm() {
		return sessionYyyyMm;
	}

	public void setSessionYyyyMm(String sessionYyyyMm) {
		this.sessionYyyyMm = sessionYyyyMm;
	}

	public ArrayList<String> getSessionSeperator() {
		return sessionSeperator;
	}

	public void setSessionSeperator(ArrayList<String> sessionSeperator) {
		this.sessionSeperator = sessionSeperator;
	}

	public String getSessionMinVal() {
		return sessionMinVal;
	}

	public void setSessionMinVal(String sessionMinVal) {
		this.sessionMinVal = sessionMinVal;
	}

	public String getNow() {
		return now;
	}

	public void setNow(String now) {
		this.now = now;
	}

	public String getEncKey() {
		return encKey;
	}

	public void setEncKey(String encKey) {
		this.encKey = encKey;
	}
	
	
}