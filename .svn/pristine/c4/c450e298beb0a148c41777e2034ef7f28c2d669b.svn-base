package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.eqmt.model.SystemVo;
import rems.eqmt.persistence.EqmtSystemHistoryMapper;

@Service
public class EqmtSystemHistorySvcImpl implements EqmtSystemHistorySvc {
	
	@Autowired
	private EqmtSystemHistoryMapper eqmtSystemHistoryMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	@Override
	public List<SystemVo> retrieveAuthIdList(HashMap<String, Object> params){
		return eqmtSystemHistoryMapper.retrieveAuthIdList(params);
	}

	
	@Transactional
	@Override
	public List<SystemVo> retrieveSysHistory(HashMap<String, Object> params){
		
		List<SystemVo> list = eqmtSystemHistoryMapper.retrieveSysHistory(params);
		
		int cnt = commonMapper.selectTotalCnt();
		
		if( cnt != 0 ){
			list.get(0).setTotal(String.valueOf(cnt));	
		}
		
		return list;
	}

	@Transactional
	@Override
	public List<SystemVo> retrieveSysHistory2(HashMap<String, Object> params){
		
		List<SystemVo> list = eqmtSystemHistoryMapper.retrieveSysHistory2(params);
		
		int cnt = commonMapper.selectTotalCnt();
		
		if( cnt != 0 ){
			list.get(0).setTotal(String.valueOf(cnt));	
		}
		
		return list;
		
	}	
}
