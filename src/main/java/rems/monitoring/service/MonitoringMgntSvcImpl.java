package rems.monitoring.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.monitoring.model.MonitoringStoreDataVo;
import rems.monitoring.persistence.MonitoringMgntMapper;
import rems.system.model.DashBoardStoreDataVo;
import rems.system.model.GridStoreMgntVo;

@Service
public class MonitoringMgntSvcImpl implements MonitoringMgntSvc {

	@Autowired
	private MonitoringMgntMapper monitoringMgntMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( MonitoringMgntSvcImpl.class );
	
	// 매장 정보
	@Override
	public MonitoringStoreDataVo monitoringStoreMstData(HashMap<String, Object> params) {
		LOGGER.info( "monitoringStoreMstData : " + params );
		
		return monitoringMgntMapper.monitoringStoreMstData(params);
	}
	
	// 경영주 매장 개수
	@Override
	public String monitoringStoreCount(HashMap<String, Object> params) {
		LOGGER.info( "monitoringStoreCount : " + params );
		
		return monitoringMgntMapper.monitoringStoreCount(params);
	}
	
	// 시설물 알람 처리 현황
	@Override
	public List<DashBoardStoreDataVo> monitoringStoreEqmtData(HashMap<String, Object> params) {
		LOGGER.info( "monitoringStoreEqmtData : " + params );
		
		return monitoringMgntMapper.monitoringStoreEqmtData(params);
	}
	
	// 매장 조회 목록(팝업)
	@Transactional
	@Override
	public List<GridStoreMgntVo> monitoringRetrieveStrCd(HashMap<String, Object> params) {
		LOGGER.error( "retrieveStrCd : " + params );
		
		List<GridStoreMgntVo> list = monitoringMgntMapper.monitoringRetrieveStrCd(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}

}
