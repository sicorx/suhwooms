package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.eqmt.model.SystemVo;
import rems.eqmt.persistence.ElecZeroStoreMapper;

@Service
public class ElecZeroStoreSvcImpl implements ElecZeroStoreSvc {
	
	@Autowired
	private ElecZeroStoreMapper elecZeroStoreMapper;
	
	@Autowired
	private CommonMapper commonMapper;

	@Transactional
	@Override
	public List<SystemVo> retrieveElecStore(HashMap<String, Object> params){
		
		List<SystemVo> list = elecZeroStoreMapper.retrieveElecStore(params);
		
		int cnt = commonMapper.selectTotalCnt();
		
		if( cnt != 0 ){
			list.get(0).setTotal(String.valueOf(cnt));	
		}
		
		return list;
		
	}
	
	@Override
	public List<SystemVo> retrieveAuthList(HashMap<String, Object> params){
		return elecZeroStoreMapper.retrieveAuthList(params);
	}
	
	@Override
	public List<HashMap<String, Object>> retrieveElecStoreExcel(HashMap<String, Object> params) {		
		
		List<HashMap<String, Object>> list = elecZeroStoreMapper.retrieveElecStoreExcel(params);
		
		return list;
	}

}
