package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.eqmt.model.SystemVo;
import rems.eqmt.persistence.EqmtEnergyMapper;

@Service
public class EqmtEnergySvcImpl implements EqmtEnergySvc {
	
	@Autowired
	private EqmtEnergyMapper eqmtEnergyMapper;

	@Autowired
	private CommonMapper commonMapper;
	
	@Transactional
	@Override
	public List<SystemVo> retrieveEnergyList(HashMap<String, Object> params){
		
		List<SystemVo> list = eqmtEnergyMapper.retrieveEnergyList(params);
		
		int cnt = commonMapper.selectTotalCnt();
		
		if( cnt != 0 ){
			list.get(0).setTotal(String.valueOf(cnt));	
		}
		
		
		return list;
	}
	
	@Override
	public List<HashMap<String, Object>> retrieveExcelEnergyList(HashMap<String, Object> params) {
		
		List<HashMap<String, Object>> list = eqmtEnergyMapper.retrieveExcelEnergyList(params);
		
		return list;
	}
}
