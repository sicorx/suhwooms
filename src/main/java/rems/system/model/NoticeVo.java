package rems.system.model;

import rems.common.model.GridVo;

public class NoticeVo extends GridVo<NoticeVo> {
	
	String noticeId;
	String companyCd;
	String title;	
	String contents;
	String pubId;
	String pubAuthNm;
	String noticeTypeCd;
	String noticeTypeNm;
	String pubYn;
	String pubDttm;
	String pubStartDt;
	String pubEndDt;
	String authId;
	String orgCd;
	String regiId;
	String finalModId;
	
	String userNm;
	String targetNames;
	String viewCnt;
	
	
	
	
	
	
	public String getPubAuthNm() {
		return pubAuthNm;
	}
	public void setPubAuthNm(String pubAuthNm) {
		this.pubAuthNm = pubAuthNm;
	}
	public String getNoticeTypeNm() {
		return noticeTypeNm;
	}
	public void setNoticeTypeNm(String noticeTypeNm) {
		this.noticeTypeNm = noticeTypeNm;
	}
	public String getPubDttm() {
		return pubDttm;
	}
	public void setPubDttm(String pubDttm) {
		this.pubDttm = pubDttm;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getTargetNames() {
		return targetNames;
	}
	public void setTargetNames(String targetNames) {
		this.targetNames = targetNames;
	}
	public String getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(String viewCnt) {
		this.viewCnt = viewCnt;
	}
	public String getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}
	public String getCompanyCd() {
		return companyCd;
	}
	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	
	
	
	
	
	public String getPubId() {
		return pubId;
	}
	public void setPubId(String pubId) {
		this.pubId = pubId;
	}
	public String getNoticeTypeCd() {
		return noticeTypeCd;
	}
	public void setNoticeTypeCd(String noticeTypeCd) {
		this.noticeTypeCd = noticeTypeCd;
	}	
	public String getPubYn() {
		return pubYn;
	}
	public void setPubYn(String pubYn) {
		this.pubYn = pubYn;
	}
	public String getPubStartDt() {
		return pubStartDt;
	}
	public void setPubStartDt(String pubStartDt) {
		this.pubStartDt = pubStartDt;
	}
	public String getPubEndDt() {
		return pubEndDt;
	}
	public void setPubEndDt(String pubEndDt) {
		this.pubEndDt = pubEndDt;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getOrgCd() {
		return orgCd;
	}
	public void setOrgCd(String orgCd) {
		this.orgCd = orgCd;
	}
	public String getRegiId() {
		return regiId;
	}
	public void setRegiId(String regiId) {
		this.regiId = regiId;
	}
	public String getFinalModId() {
		return finalModId;
	}
	public void setFinalModId(String finalModId) {
		this.finalModId = finalModId;
	}
}
