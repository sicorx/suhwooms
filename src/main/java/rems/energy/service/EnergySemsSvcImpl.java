package rems.energy.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.model.SelectVo;
import rems.common.persistence.CommonMapper;
import rems.energy.model.SemsVo;
import rems.energy.persistence.EnergySemsMapper;


@Service
public class EnergySemsSvcImpl implements EnergySemsSvc {
	
	@Autowired
	private EnergySemsMapper energySemsMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	@Transactional
	@Override
	public List<SemsVo> retrieveSems(HashMap<String, Object> params){
		
		List<SemsVo> list = energySemsMapper.retrieveSems(params);
		//energySemsMapper.retrieveSems(params);
		
		int cnt = commonMapper.selectTotalCnt();
		
		if( cnt != 0 ){
			list.get(0).setTotal(String.valueOf(cnt));	
		}
		
		
		return list;
	}

	@Override
	public List<SelectVo> retrieveVendorList(HashMap<String, Object> params){
		return energySemsMapper.retrieveVendorList(params);
	}
	
	
	
	
	@Override
	public List<HashMap<String, Object>> retrieveExcelSems(HashMap<String, Object> params) {
		//LOGGER.info( "retrieveExcelSems : " + params );
		
		List<HashMap<String, Object>> list = energySemsMapper.retrieveExcelSems(params);
		
		return list;
	}
}
