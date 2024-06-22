package rems.system.model;

import rems.common.model.GridVo;

public class MenuVo extends GridVo<GwVo>{

	private String companyCd;
	private String locale;
	private String menuId;
	private String depthLvl;
	private String uperMenu;
	private String menuNm;
	private String menuType;
	private String menuTypeNm;
	private String seq;
	private String useYn;
	private String regiId;
	private String regiDttm;
	private String finalModId;
	private String finalModUserNm;
	private String finalModDttm;
	private String now;
	boolean rslt = false;
	
	public String getCompanyCd() {
		return companyCd;
	}
	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getDepthLvl() {
		return depthLvl;
	}
	public void setDepthLvl(String depthLvl) {
		this.depthLvl = depthLvl;
	}
	public String getUperMenu() {
		return uperMenu;
	}
	public void setUperMenu(String uperMenu) {
		this.uperMenu = uperMenu;
	}
	public String getMenuNm() {
		return menuNm;
	}
	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}
	public String getMenuType() {
		return menuType;
	}
	public void setMenuType(String menuType) {
		this.menuType = menuType;
	}
	public String getMenuTypeNm() {
		return menuTypeNm;
	}
	public void setMenuTypeNm(String menuTypeNm) {
		this.menuTypeNm = menuTypeNm;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
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