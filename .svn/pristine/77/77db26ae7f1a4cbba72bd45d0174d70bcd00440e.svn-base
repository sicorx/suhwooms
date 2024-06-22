package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.system.model.GridStoreInverterMgntVo;
import rems.system.model.GridStoreMgntVo;
import rems.system.model.StoreInverterDataVo;
import rems.system.persistence.StoreInverterMgntMapper;

@Service
public class StoreInverterMgntSvcImpl implements StoreInverterMgntSvc {

	@Autowired
	private StoreInverterMgntMapper storeInverterMgntMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( StoreMgntSvcImpl.class );
	
	@Transactional
	@Override
	public List<GridStoreInverterMgntVo> retrieveInverterMgnt(HashMap<String, Object> params) {
		LOGGER.info( "retrieveInverterMgnt : " + params );
		
			List<GridStoreInverterMgntVo> list = storeInverterMgntMapper.retrieveInverterMgnt(params);
		
		int cnt = commonMapper.selectTotalCnt();
		if( cnt != 0 )		
			list.get(0).setTotal(String.valueOf(cnt));				
		
		return list;
	}
	
	@Override
	public List<GridStoreInverterMgntVo> retrieveStoreInverterMgntDtl(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreInverterMgntDtl : " + params );
		
		return storeInverterMgntMapper.retrieveStoreInverterMgntDtl(params);
	}
	
	@Override
	public boolean saveStoreInverterMgnt(StoreInverterDataVo params) {
		LOGGER.info( "saveStoreInverterMgnt : " + params );
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		String hubIdList = params.getHubIdList();
		String[] splitHubIdList = hubIdList.split(":");
		
		String portNoList = params.getPortNoList();
		String[] splitPortNoList = portNoList.split(":");
		
		String deviceTypeList = params.getDeviceTypeList();
		String[] splitDeviceTypeList = deviceTypeList.split(":");

		String deviceLocList = params.getDeviceLocList();
		String[] splitDeviceLocList = deviceLocList.split(":");
		
		String contentsList = params.getContentsList();
		String[] splitContentsList = contentsList.split(":");
		
		String pushTermList = params.getPushTermList();
		String[] splitPushTermList = pushTermList.split(":");
		
		String useYnList = params.getUseYnList();
		String[] splitUseYnList = useYnList.split(":");
		
		GridStoreInverterMgntVo gsimVo = new GridStoreInverterMgntVo();
		
		for( int i = 0 ; i < 8 ; i++ ){
			
			if( splitHubIdList.length > 0 ){
				gsimVo.setHubId(splitHubIdList[i]);  
			}else{
				gsimVo.setHubId("");
			}
			if( splitPortNoList.length > 0 ){
				gsimVo.setPortNo(splitPortNoList[i]);  
			}else{
				gsimVo.setPortNo("");
			}
			if( splitPortNoList.length == 0 || splitHubIdList.length == 0 ){
				continue;
			}
			if( splitDeviceTypeList.length > 0 && splitDeviceTypeList.length -1 >=  i  ){
				gsimVo.setDeviceType(splitDeviceTypeList[i]);
			}else{
				gsimVo.setDeviceType("");
			}
			if( splitDeviceLocList.length > 0 && splitDeviceLocList.length-1 >=  i){
				gsimVo.setDeviceLoc(splitDeviceLocList[i]);  
			}else{
				gsimVo.setDeviceLoc("");
			}
			if( splitContentsList.length > 0 && splitContentsList.length -1>=  i){
				gsimVo.setContents(splitContentsList[i]);  
			}else{
				gsimVo.setContents("");
			}
			if( splitPushTermList.length > 0 && splitPushTermList.length -1>=  i){
				gsimVo.setPushTerm(splitPushTermList[i]);  
			}else{
				gsimVo.setPushTerm("");
			}
			if( splitUseYnList.length > 0  && splitUseYnList.length -1>=  i){
				gsimVo.setUseYn(splitUseYnList[i]);
			}else{
				gsimVo.setUseYn("");
			}
			
			gsimVo.setStrCd(params.getStrCd());
			gsimVo.setRegiId(params.getRegiId());
			gsimVo.setFinalModId(params.getFinalModId());
			gsimVo.setNow(params.getNow());
			
			int result = storeInverterMgntMapper.saveStoreInverterMgnt(gsimVo);
			if( result == 0 ){
				break;
			}else{
				updateRslt = updateRslt + 1;
			}
		}
		System.out.println();
		if(updateRslt == 8){
			rslt = true;
		}
		
		return rslt;
	}
	
	@Override
	public boolean deleteStoreInverterMgnt(HashMap<String, Object> params) {
		LOGGER.info( "deleteStoreInverterMgnt : " + params );
		
		boolean rslt   = false;
		int delRslt = 0;
		
		delRslt = storeInverterMgntMapper.deleteStoreInverterMgnt(params);
		
		if(delRslt == 0){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}
	
	@Override
	public int saveStoreInverterMgnt_init(HashMap<String, Object> params )
	{
		LOGGER.info( "saveStoreInverterMgnt_init : " + params );		
		return storeInverterMgntMapper.saveStoreInverterMgnt_init(params);
	}
	
	@Override
	public int delStoreInverterMgnt(HashMap<String, Object> params )
	{
		LOGGER.info( "delStoreInverterMgnt : " + params );		
		return storeInverterMgntMapper.delStoreInverterMgnt(params);
	}
	
}
	
	
