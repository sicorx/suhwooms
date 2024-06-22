package rems.monitoring.persistence;

import java.util.HashMap;
import java.util.List;

import rems.monitoring.model.MonitoringStoreDataVo;
import rems.system.model.DashBoardStoreDataVo;
import rems.system.model.GridStoreMgntVo;

public interface MonitoringMgntMapper {

	// 매장 정보
	public MonitoringStoreDataVo monitoringStoreMstData(HashMap<String, Object> params);
	
	// 경영주 매장 개수
	public String monitoringStoreCount(HashMap<String, Object> params);
	
	// 시설물현황
	public List<DashBoardStoreDataVo> monitoringStoreEqmtData(HashMap<String, Object> params);
	
	// 매장 조회 목록(팝업)
	public List<GridStoreMgntVo> monitoringRetrieveStrCd(HashMap<String, Object> params);
}
