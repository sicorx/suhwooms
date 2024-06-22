package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.eqmt.model.SystemVo;
import rems.eqmt.persistence.EqmtStoreSemsMapper;

@Service
public class EqmtStoreSemsSvcImpl implements EqmtStoreSemsSvc {
	
	@Autowired
	EqmtStoreSemsMapper eqmtStoreSemsMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	@Transactional
	@Override
	public List<SystemVo> retrieveStoreSemsList(HashMap<String, Object> params){
		
		List<SystemVo> list = eqmtStoreSemsMapper.retrieveStoreSemsList(params);
		
		int cnt = commonMapper.selectTotalCnt();
		
		if( cnt != 0 ){
			list.get(0).setTotal(String.valueOf(cnt));	
		}
		
		return list;
		
	}
	
	@Override
	public List<HashMap<String, Object>> retrieveExcelStoreSemsList(HashMap<String, Object> params) {		
		
		List<HashMap<String, Object>> list = eqmtStoreSemsMapper.retrieveExcelStoreSemsList(params);
		
		return list;
	}
}
