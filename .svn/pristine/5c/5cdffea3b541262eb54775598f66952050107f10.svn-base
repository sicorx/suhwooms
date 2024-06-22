package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.energy.model.SemsVo;
import rems.eqmt.model.SystemVo;
import rems.eqmt.persistence.EqmtStoreLogMapper;

@Service
public class EqmtStoreLogSvcImpl implements EqmtStoreLogSvc {

	@Autowired
	private EqmtStoreLogMapper eqmtStoreLogMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	@Transactional
	@Override
	public List<SystemVo> retrieveStoreLogList(HashMap<String, Object> params){
	
		List<SystemVo> list = eqmtStoreLogMapper.retrieveStoreLogList(params);
		
		int cnt = commonMapper.selectTotalCnt();
		
		if( cnt != 0 ){
			list.get(0).setTotal(String.valueOf(cnt));	
		}
		
		return list;
	}
	
	@Override
	public List<HashMap<String, Object>> downloadEqmtStoreLogExcel(HashMap<String, Object> params) {
		
		List<HashMap<String, Object>> list = eqmtStoreLogMapper.downloadEqmtStoreLogExcel(params);
		
		return list;
	}
}
