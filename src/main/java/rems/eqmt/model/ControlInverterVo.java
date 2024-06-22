package rems.eqmt.model;

import rems.common.model.GridVo;

public class ControlInverterVo extends GridVo<ControlInverterVo> {
 
	String strCd = "";
	int hubId = 0;
	int portNo = 0;
	int gwId = 0;
	
	int alarmMaskFlag = 0;
	int operModeFlag = 0;
	int sensTempConfFlag = 0;
	int maxTempAlarmYnFlag = 0;
	int maxTempFlag = 0;
	int minTempAlarmYnFlag = 0;
	int minTempFlag = 0;
	
	int defrostTempConfFlag = 0;
	int defrostTermFlag = 0;
	int defrostDelayFlag = 0;
	int dewaterDelayFlag = 0;
	
	int controlFlag1 = 0;
	int controlFlag2 = 0;
	
	int maxTempAlarmMask = 0;
	int minTempAlarmMask = 0;
	int sensTempMask = 0;
	int defrostSensTempMask = 0;
	int highPressureMask = 0;
	int lowPressureMask = 0;
	int compMask = 0;
	int linkMask = 0;
	
	int alarmMask1 = 0;
	int alarmMask2 = 0;
	
	int operMode = 0;
	float sensTempConf = 0;
	
	int maxTempAlarmYn = 0;
	int maxTemp = 0 ;
	int minTempAlarmYn = 0;
	int minTemp = 0;
	
	int defrostTempConf = 0;
	int defrostTerm = 0;
	int defrostDelay = 0;
	int dewaterDelay = 0;
	
	public String getStrCd() {
		return strCd;
	}
	public void setStrCd(String strCd) {
		this.strCd = strCd;
	}
	public int getHubId() {
		return hubId;
	}
	public void setHubId(int hubId) {
		this.hubId = hubId;
	}
	public int getPortNo() {
		return portNo;
	}
	public void setPortNo(int portNo) {
		this.portNo = portNo;
	}
	public int getGwId() {
		return gwId;
	}
	public void setGwId(int gwId) {
		this.gwId = gwId;
	}
	public int getAlarmMaskFlag() {
		return alarmMaskFlag;
	}
	public void setAlarmMaskFlag(int alarmMaskFlag) {
		this.alarmMaskFlag = alarmMaskFlag;
	}
	public int getOperModeFlag() {
		return operModeFlag;
	}
	public void setOperModeFlag(int operModeFlag) {
		this.operModeFlag = operModeFlag;
	}
	public int getSensTempConfFlag() {
		return sensTempConfFlag;
	}
	public void setSensTempConfFlag(int sensTempConfFlag) {
		this.sensTempConfFlag = sensTempConfFlag;
	}
	public int getMaxTempAlarmYnFlag() {
		return maxTempAlarmYnFlag;
	}
	public void setMaxTempAlarmYnFlag(int maxTempAlarmYnFlag) {
		this.maxTempAlarmYnFlag = maxTempAlarmYnFlag;
	}
	public int getMaxTempFlag() {
		return maxTempFlag;
	}
	public void setMaxTempFlag(int maxTempFlag) {
		this.maxTempFlag = maxTempFlag;
	}
	public int getMinTempAlarmYnFlag() {
		return minTempAlarmYnFlag;
	}
	public void setMinTempAlarmYnFlag(int minTempAlarmYnFlag) {
		this.minTempAlarmYnFlag = minTempAlarmYnFlag;
	}
	public int getMinTempFlag() {
		return minTempFlag;
	}
	public void setMinTempFlag(int minTempFlag) {
		this.minTempFlag = minTempFlag;
	}
	public int getDefrostTempConfFlag() {
		return defrostTempConfFlag;
	}
	public void setDefrostTempConfFlag(int defrostTempConfFlag) {
		this.defrostTempConfFlag = defrostTempConfFlag;
	}
	public int getDefrostTermFlag() {
		return defrostTermFlag;
	}
	public void setDefrostTermFlag(int defrostTermFlag) {
		this.defrostTermFlag = defrostTermFlag;
	}
	public int getDefrostDelayFlag() {
		return defrostDelayFlag;
	}
	public void setDefrostDelayFlag(int defrostDelayFlag) {
		this.defrostDelayFlag = defrostDelayFlag;
	}
	public int getDewaterDelayFlag() {
		return dewaterDelayFlag;
	}
	public void setDewaterDelayFlag(int dewaterDelayFlag) {
		this.dewaterDelayFlag = dewaterDelayFlag;
	}
	public int getControlFlag1() {
		return controlFlag1;
	}
	public void setControlFlag1(int controlFlag1) {
		this.controlFlag1 = controlFlag1;
	}
	public int getControlFlag2() {
		return controlFlag2;
	}
	public void setControlFlag2(int controlFlag2) {
		this.controlFlag2 = controlFlag2;
	}
	public int getMaxTempAlarmMask() {
		return maxTempAlarmMask;
	}
	public void setMaxTempAlarmMask(int maxTempAlarmMask) {
		this.maxTempAlarmMask = maxTempAlarmMask;
	}
	public int getMinTempAlarmMask() {
		return minTempAlarmMask;
	}
	public void setMinTempAlarmMask(int minTempAlarmMask) {
		this.minTempAlarmMask = minTempAlarmMask;
	}
	public int getSensTempMask() {
		return sensTempMask;
	}
	public void setSensTempMask(int sensTempMask) {
		this.sensTempMask = sensTempMask;
	}
	public int getDefrostSensTempMask() {
		return defrostSensTempMask;
	}
	public void setDefrostSensTempMask(int defrostSensTempMask) {
		this.defrostSensTempMask = defrostSensTempMask;
	}
	public int getHighPressureMask() {
		return highPressureMask;
	}
	public void setHighPressureMask(int highPressureMask) {
		this.highPressureMask = highPressureMask;
	}
	public int getLowPressureMask() {
		return lowPressureMask;
	}
	public void setLowPressureMask(int lowPressureMask) {
		this.lowPressureMask = lowPressureMask;
	}
	public int getCompMask() {
		return compMask;
	}
	public void setCompMask(int compMask) {
		this.compMask = compMask;
	}
	public int getLinkMask() {
		return linkMask;
	}
	public void setLinkMask(int linkMask) {
		this.linkMask = linkMask;
	}
	public int getAlarmMask1() {
		return alarmMask1;
	}
	public void setAlarmMask1(int alarmMask1) {
		this.alarmMask1 = alarmMask1;
	}
	public int getAlarmMask2() {
		return alarmMask2;
	}
	public void setAlarmMask2(int alarmMask2) {
		this.alarmMask2 = alarmMask2;
	}
	public int getOperMode() {
		return operMode;
	}
	public void setOperMode(int operMode) {
		this.operMode = operMode;
	}
	public float getSensTempConf() {
		return sensTempConf;
	}
	public void setSensTempConf(float sensTempConf) {
		this.sensTempConf = sensTempConf;
	}
	public int getMaxTempAlarmYn() {
		return maxTempAlarmYn;
	}
	public void setMaxTempAlarmYn(int maxTempAlarmYn) {
		this.maxTempAlarmYn = maxTempAlarmYn;
	}
	public int getMaxTemp() {
		return maxTemp;
	}
	public void setMaxTemp(int maxTemp) {
		this.maxTemp = maxTemp;
	}
	public int getMinTempAlarmYn() {
		return minTempAlarmYn;
	}
	public void setMinTempAlarmYn(int minTempAlarmYn) {
		this.minTempAlarmYn = minTempAlarmYn;
	}
	public int getMinTemp() {
		return minTemp;
	}
	public void setMinTemp(int minTemp) {
		this.minTemp = minTemp;
	}
	public int getDefrostTempConf() {
		return defrostTempConf;
	}
	public void setDefrostTempConf(int defrostTempConf) {
		this.defrostTempConf = defrostTempConf;
	}
	public int getDefrostTerm() {
		return defrostTerm;
	}
	public void setDefrostTerm(int defrostTerm) {
		this.defrostTerm = defrostTerm;
	}
	public int getDefrostDelay() {
		return defrostDelay;
	}
	public void setDefrostDelay(int defrostDelay) {
		this.defrostDelay = defrostDelay;
	}
	public int getDewaterDelay() {
		return dewaterDelay;
	}
	public void setDewaterDelay(int dewaterDelay) {
		this.dewaterDelay = dewaterDelay;
	}
	
}