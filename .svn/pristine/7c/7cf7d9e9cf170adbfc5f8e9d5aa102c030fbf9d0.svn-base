package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.eqmt.model.SystemVo;
import rems.eqmt.persistence.EqmtElectricMgntMapper;

@Service
public class EqmtElectricMgntSvcImpl implements EqmtElectricMgntSvc {
	
	@Autowired
	private EqmtElectricMgntMapper eqmtElectricMgntMapper;

	@Autowired
	private CommonMapper commonMapper;
	
	@Transactional
	@Override
	public List<SystemVo> retrieveElecMgntList(HashMap<String, Object> params){
		
		List<SystemVo> list = eqmtElectricMgntMapper.retrieveElecMgntList(params);
		
		int cnt = commonMapper.selectTotalCnt();
		
		if( cnt != 0 ){
			list.get(0).setTotal(String.valueOf(cnt));	
		}
		
		return eqmtElectricMgntMapper.retrieveElecMgntList(params);
	}
	
	@Override
	public boolean saveElectricMgnt(SystemVo params){		

		boolean rslt   = false;
		int updateRslt = 0;
		
		// 유지보수업체 저장
		updateRslt = eqmtElectricMgntMapper.saveElectricMgnt(params);
		
		if (updateRslt == 0) {
			rslt = false;
		} else {
			rslt = true;
		}
		
		return rslt;
	}
	
	@Override
	public boolean checkElectricTF(SystemVo gvmVo){
		return eqmtElectricMgntMapper.checkElectricTF(gvmVo);
	}
	
	@Override
	public boolean deleteElectricMgnt(SystemVo gvmVo){
		return eqmtElectricMgntMapper.deleteElectricMgnt(gvmVo);
	}
	
	@Override
	public boolean checkElecCd(HashMap<String, Object> params){
		boolean rslt   = false;
		int countRslt = 0;
		
		// 업체코드 중복 확인
		countRslt = eqmtElectricMgntMapper.checkElecCd(params);

		if (countRslt == 0) {
			rslt = true;
		} else {
			rslt = false;
		}		
		
		return rslt;		
		
		
		
	}
}
