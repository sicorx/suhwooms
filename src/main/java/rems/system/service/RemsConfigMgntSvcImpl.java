package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.system.model.GridRemsDeviceMgntVo;
import rems.system.model.RemsConfigMgntVo;
import rems.system.model.RemsConfigMstVo;
import rems.system.persistence.RemsConfigMgntMapper;

@Service
public class RemsConfigMgntSvcImpl implements RemsConfigMgntSvc {

	@Autowired
	private RemsConfigMgntMapper remsConfigMgntMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	
	private static final Logger LOGGER = LoggerFactory.getLogger( RemsConfigMgntSvcImpl.class );
		
	@Transactional
	@Override
	public List<RemsConfigMgntVo> retrieveRemsConfigDataList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveRemsConfigDataList : " + params );
		
		List<RemsConfigMgntVo> list = remsConfigMgntMapper.retrieveRemsConfigDataList(params);
		
		int cnt = commonMapper.selectTotalCnt();
		if( cnt != 0 )		
			list.get(0).setTotal(String.valueOf(cnt));				
		
		return list;
	}
	
	@Override
	public RemsConfigMstVo retrieveRemsConfMst() {
		LOGGER.info( "retrieveRemsConfMst : " );
		
		return remsConfigMgntMapper.retrieveRemsConfMst();
	}
	
	@Override
	public String retrieveStoreContractPower(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreContractPower : "+params );
		
		return remsConfigMgntMapper.retrieveStoreContractPower(params);
	}
	
	@Override
	public GridRemsDeviceMgntVo retrieveStoreRemsPart(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreRemsPart : "+params );
		
		return remsConfigMgntMapper.retrieveStoreRemsPart(params);
	}
	
	// @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor={java.lang.Exception.class, java.lang.RuntimeException.class})
	@Override
	public boolean saveRemsConfigMgnt(HashMap<String,Object> params) {

		LOGGER.info( "saveRemsConfigMgnt : " + params );
		
		HashMap<String,Object> params1 = (HashMap<String,Object>)params.get("PEAK_TYPE");
		HashMap<String,Object> params2 = (HashMap<String,Object>)params.get("TEMP_TYPE");
		HashMap<String,Object> params3 = (HashMap<String,Object>)params.get("OPER_ELEC");
		HashMap<String,Object> params4 = (HashMap<String,Object>)params.get("TEMP_LEVL_C0");
		HashMap<String,Object> params5 = (HashMap<String,Object>)params.get("TEMP_LEVL_C1");
		HashMap<String,Object> params6 = (HashMap<String,Object>)params.get("TEMP_LEVL_H0");
		HashMap<String,Object> params7 = (HashMap<String,Object>)params.get("TEMP_LEVL_H1");
		HashMap<String,Object> params8 = (HashMap<String,Object>)params.get("SIGN_DELY");
		HashMap<String,Object> params9 = (HashMap<String,Object>)params.get("SIGN_TYPE");
		HashMap<String,Object> params10 = (HashMap<String,Object>)params.get("SIGN_OPER");
		HashMap<String,Object> params11 = (HashMap<String,Object>)params.get("SIGN_STOW");
		HashMap<String,Object> params12 = (HashMap<String,Object>)params.get("SIGN_STOD");
		HashMap<String,Object> params13 = (HashMap<String,Object>)params.get("SIGN_STOT");
		
		int deleteRslt1 = 0;
		int deleteRslt2 = 0;
		int deleteRslt3 = 0;
		int deleteRslt4 = 0;
		int deleteRslt5 = 0;
		int deleteRslt6 = 0;
		int deleteRslt7 = 0;
		int deleteRslt8 = 0;
		int deleteRslt9 = 0;		
		int deleteRslt10 = 0;
		int deleteRslt11 = 0;
		int deleteRslt12 = 0;
		int deleteRslt13 = 0;
		
		boolean rslt   = false;
		int updateRslt0 = 0;
		int updateRslt1 = 0;
		int updateRslt2 = 0;
		int updateRslt3 = 0;
		int updateRslt4 = 0;
		int updateRslt5 = 0;
		int updateRslt6 = 0;
		int updateRslt7 = 0;
		int updateRslt8 = 0;
		int updateRslt9 = 0;		
		int updateRslt10 = 0;
		int updateRslt11 = 0;
		int updateRslt12 = 0;
		int updateRslt13 = 0;
		
		if(params1.get("mode").equals("A")) {
			deleteRslt1 = remsConfigMgntMapper.deleteRemsConfigMgnt(params1);
		}
		if(params2.get("mode").equals("A")) {
			deleteRslt2 = remsConfigMgntMapper.deleteRemsConfigMgnt(params2);
		}
		if(params3.get("mode").equals("A")) {
			deleteRslt3 = remsConfigMgntMapper.deleteRemsConfigMgnt(params3);
		}
		if(params4.get("mode").equals("A")) {
			deleteRslt4 = remsConfigMgntMapper.deleteRemsConfigMgnt(params4);
		}
		if(params5.get("mode").equals("A")) {
			deleteRslt5 = remsConfigMgntMapper.deleteRemsConfigMgnt(params5);
		}
		if(params6.get("mode").equals("A")) {
			deleteRslt6 = remsConfigMgntMapper.deleteRemsConfigMgnt(params6);
		}
		if(params7.get("mode").equals("A")) {
			deleteRslt7 = remsConfigMgntMapper.deleteRemsConfigMgnt(params7);
		}
		if(params8.get("mode").equals("A")) {
			deleteRslt8 = remsConfigMgntMapper.deleteRemsConfigMgnt(params8);
		}
		if(params9.get("mode").equals("A")) {
			deleteRslt9 = remsConfigMgntMapper.deleteRemsConfigMgnt(params9);
		}
		if(params10.get("mode").equals("A")) {
			deleteRslt10 = remsConfigMgntMapper.deleteRemsConfigMgnt(params10);
		}
		if(params11.get("mode").equals("A")) {
			deleteRslt11 = remsConfigMgntMapper.deleteRemsConfigMgnt(params11);
		}
		if(params12.get("mode").equals("A")) {
			deleteRslt12 = remsConfigMgntMapper.deleteRemsConfigMgnt(params12);
		}
		if(params13.get("mode").equals("A")) {
			deleteRslt13 = remsConfigMgntMapper.deleteRemsConfigMgnt(params13);
		}
		
		updateRslt0 = remsConfigMgntMapper.updateStoreContractPower( (HashMap<String,Object>)params.get("DEMAND_POWER") );		
		updateRslt1 = remsConfigMgntMapper.saveRemsConfigMgnt( params1 );
		updateRslt2 = remsConfigMgntMapper.saveRemsConfigMgnt( params2 );
		updateRslt3 = remsConfigMgntMapper.saveRemsConfigMgnt( params3 );
		updateRslt4 = remsConfigMgntMapper.saveRemsConfigMgnt( params4 );
		updateRslt5 = remsConfigMgntMapper.saveRemsConfigMgnt( params5 );
		updateRslt6 = remsConfigMgntMapper.saveRemsConfigMgnt( params6 );
		updateRslt7 = remsConfigMgntMapper.saveRemsConfigMgnt( params7 );
		updateRslt8 = remsConfigMgntMapper.saveRemsConfigMgnt( params8 );
		updateRslt9 = remsConfigMgntMapper.saveRemsConfigMgnt( params9 );
		
		updateRslt10 = remsConfigMgntMapper.saveRemsConfigMgnt( params10 );
		updateRslt11 = remsConfigMgntMapper.saveRemsConfigMgnt( params11 );
		updateRslt12 = remsConfigMgntMapper.saveRemsConfigMgnt( params12 );
		updateRslt13 = remsConfigMgntMapper.saveRemsConfigMgnt( params13 );
		
		
		
		
		if(		updateRslt1 == 0 &&
				updateRslt2 == 0 &&
				updateRslt3 == 0 &&
				updateRslt4 == 0 &&
				updateRslt5 == 0 &&
				updateRslt6 == 0 &&
				updateRslt7 == 0 &&
				updateRslt8 == 0 &&
				updateRslt9 == 0 &&
				updateRslt10 == 0 &&
				updateRslt11 == 0 &&
				updateRslt12 == 0 &&
				updateRslt13 == 0 
				 
		){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}
	
	@Override
	public RemsConfigMgntVo retrieveRemsConfigParticularData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveRemsConfigParticularData : " + params );
		
		return remsConfigMgntMapper.retrieveRemsConfigParticularData(params);
	}
	
	@Override
	public RemsConfigMstVo retrieveRemsConfigTempLevelData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveRemsConfigTempLevelData : " + params );
		
		return remsConfigMgntMapper.retrieveRemsConfigTempLevelData(params);
	}
	
	@Override
	public boolean updateStoreContractPower(HashMap<String, Object> params) {

		LOGGER.info( "updateStoreContractPower : " + params );
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		updateRslt = remsConfigMgntMapper.updateStoreContractPower(params);
		
		if(updateRslt == 0){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}
	
	@Override
	public boolean deleteRemsConfigPaticularData(HashMap<String, Object> params) {

		LOGGER.info( "deleteRemsConfigPaticularData : " + params );
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		updateRslt = remsConfigMgntMapper.deleteRemsConfigPaticularData(params);
		
		if(updateRslt == 0){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}
	
	@Override	
	public int saveConfigMgnt_init(HashMap<String, Object> params){
		LOGGER.info( "saveConfigMgnt_init : " + params );		
		return remsConfigMgntMapper.saveConfigMgnt_init(params);
	}
	
	@Override	
	public int delConfigMgnt(HashMap<String, Object> params){
		LOGGER.info( "delConfigMgnt : " + params );		
		return remsConfigMgntMapper.delConfigMgnt(params);
	}
	
	//엑셀다운로드
	@Override
	public List<HashMap<String, Object>> downloadRemsConfigDataListExcel(HashMap<String, Object> params) {
		LOGGER.info( "downloadRemsConfigDataListExcel : " + params );
		
		return remsConfigMgntMapper.downloadRemsConfigDataListExcel(params);
	}
	
}
