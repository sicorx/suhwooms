package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.system.model.GridStoreMgntVo;
import rems.system.persistence.StoreMgntMapper;

@Service
public class StoreMgntSvcImpl implements StoreMgntSvc {

	@Autowired
	private StoreMgntMapper storeMgntMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( StoreMgntSvcImpl.class );
	
	@Transactional
	@Override
	public List<GridStoreMgntVo> retrieveRemsStoreMgnt(HashMap<String, Object> params) {
		LOGGER.info( "retrieveRemsStoreMgnt : " + params );		
		
		List<GridStoreMgntVo> list = storeMgntMapper.retrieveRemsStoreMgnt(params);
		
		int cnt = commonMapper.selectTotalCnt();
		if( cnt != 0 )		
			list.get(0).setTotal(String.valueOf(cnt));				
		
		return list;
	}
	
	@Override
	public GridStoreMgntVo retrieveRemsStoreMgntDtl(HashMap<String, Object> params) {
		LOGGER.info( "retrieveRemsStoreMgntDtl : " + params );
		
		return storeMgntMapper.retrieveRemsStoreMgntDtl(params);
	}
	
	@Override
	public String getMaxStrCd(HashMap<String, Object> params) {
		LOGGER.info( "getMaxStrCd : "+ params );
		
		return storeMgntMapper.getMaxStrCd(params);
	}
	
	@Override
	public boolean getViewStrCd(HashMap<String, Object> params) {
		LOGGER.info( "getViewStrCd : " + params );
	
		boolean rslt   = false;
		int countRslt = 0;
		
		countRslt = storeMgntMapper.getViewStrCd(params);

		if(countRslt == 0){
			rslt = true;
		}
		else{
			rslt = false;
		}		
		
		return rslt;
	}
	
	@Override
	public boolean saveRemsStoreMgnt(GridStoreMgntVo params) {
		LOGGER.info( "saveRemsStoreMgnt : " + params );
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		updateRslt = storeMgntMapper.saveRemsStoreMgnt(params);
		
		if(updateRslt == 0){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}
	
	
	@Override
	public boolean saveRemsStoreMgnt_init(GridStoreMgntVo params) {
		LOGGER.info( "saveRemsStoreMgnt_init : " + params );
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		updateRslt = storeMgntMapper.saveRemsStoreMgnt_init(params);
		
		if(updateRslt == 0){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}
	
	@Override
	public int delRemsStoreMgnt(HashMap<String, Object> params) {
		LOGGER.info( "delRemsStoreMgnt : " + params );
		
		return storeMgntMapper.delRemsStoreMgnt(params);
	}

	@Override
	public List<HashMap<String, Object>> retrieveExcelRemsStoreList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveExcelRemsStoreList : " + params );
		
		List<HashMap<String, Object>> list = storeMgntMapper.retrieveExcelRemsStoreList(params);
		
		return list;
	}
	
	@Override
	public List<HashMap<String, Object>> retrieveExcelRemsMgntStoreList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveExcelRemsMgntStoreList : " + params );
		
		List<HashMap<String, Object>> list = storeMgntMapper.retrieveExcelRemsMgntStoreList(params);
		
		return list;
	}
	
	@Override
	public boolean updateEnvConfMst(HashMap<String, Object> params) {
		LOGGER.info( "updateEnvConfMst : " + params );
		
		boolean rslt   = false;
		int countRslt = 0;
		
		countRslt = storeMgntMapper.updateEnvConfMst(params);

		if(countRslt == 0){
			rslt = true;
		}
		else{
			rslt = false;
		}		
		
		return rslt;
	}

	@Override
	public int saveSignManualCtrlInfo_init(GridStoreMgntVo params) {
		LOGGER.info( "saveConfigMgnt_init : " + params );		
		return storeMgntMapper.saveSignManualCtrlInfo_init(params);
	}
	
	@Override
	public int delSignManualCtrlInfo(HashMap<String, Object> params) {
		LOGGER.info( "delSignManualCtrlInfo : " + params );
		
		return storeMgntMapper.delSignManualCtrlInfo(params);
	}
	
}
