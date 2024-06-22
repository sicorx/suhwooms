package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.model.SelectVo;
import rems.system.model.AuthVo;
import rems.system.model.BleAuthVo;
import rems.system.model.GridStoreMgntVo;
import rems.system.persistence.AuthMgntMapper;

@Service
public class AuthMgntSvcImpl implements AuthMgntSvc {

	@Autowired
	private AuthMgntMapper mapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( AuthMgntSvcImpl.class );
	
	@Override
	public List<HashMap<String, Object>> retrieveRemsAuthMgnt(HashMap<String, Object> params) {
		LOGGER.info( "retrieveRemsAuthMgnt : " + params );
		
		return mapper.retrieveRemsAuthMgnt(params);
	}
	
	@Override
	public List<SelectVo> retrieveAuthSpList() {

		LOGGER.info( "retrieveAuthSpList : " );
		
		return mapper.retrieveAuthSpList();
	}
	
	@Override
	public boolean getAuthCd(String param) {
		
		LOGGER.info( "getAuthCd : " );
		
		boolean rslt = false;
		
		int cnt = mapper.getAuthCd(param);
		
		if(cnt == 0 ){
			rslt = true;
		}
		
		return rslt;	
	}
	
	@Override
	public AuthVo retrieveAuthDtl(HashMap<String, String> params) {
		LOGGER.info( "retrieveAuthDtl : " + params );
		
		return mapper.retrieveAuthDtl(params);
	}
	
	@Override
	public List<AuthVo> retrieveAuthListDtl(HashMap<String, String> params) {
		LOGGER.info( "retrieveAuthListDtl : " + params );
		
		return mapper.retrieveAuthListDtl(params);
	}
		
	@Override
	@Transactional
	public boolean saveRemsAuthMgnt(AuthVo param) {

		LOGGER.info( "saveRemsAuthMgnt : ");
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		updateRslt = mapper.saveRemsAuthMgnt(param);
		
		if(updateRslt == 0){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}
	
	@Override
	@Transactional
	public boolean delRemsAuthMgnt(List<HashMap<String, Object>> params, String companyCd, String userId, String now) {

		LOGGER.info( "delRemsAuthMgnt : " + params );
		
		boolean rslt = true;
		int cudRslt  = 0;
		
		for(int i = 0; i < params.size(); i++) {
			HashMap<String, Object> delData = params.get(i);
			delData.put("companyCd", companyCd);
			delData.put("userId", userId);
			delData.put("now", now);
			
			cudRslt = mapper.delRemsAuthMgnt(delData);	

			if( cudRslt == 0 ){
				
				rslt = false;
				break;
			}
		}
		
		return rslt;
	}	
	
	
	@Override
	public List<GridStoreMgntVo> retrieveBleStoreList() {
		LOGGER.info( "retrieveBleStoreList :" );
		
		return mapper.retrieveBleStoreList();
	}
	
	
	// 업데이트 확인
	@Override
	public BleAuthVo retrieveREQ_CHECK_UPDATE( HashMap<String,Object> params ) {
		LOGGER.info( "retrieveREQ_CHECK_UPDATE :" );
		
		return mapper.retrieveREQ_CHECK_UPDATE( params );
	}
	
	// 사용자 인증
	@Override
	public BleAuthVo retrieveREQ_AUTH_USER( HashMap<String,Object> params ) {
		LOGGER.info( "retrieveREQ_AUTH_USER :" );
		
		return mapper.retrieveREQ_AUTH_USER( params);
	}	
		
	// BLE 인증번호 확인
	@Override
	public BleAuthVo retrieveREQ_VERIFY_BLE( HashMap<String,Object> params ) {
		LOGGER.info( "retrieveREQ_VERIFY_BLE :" );
		
		return mapper.retrieveREQ_VERIFY_BLE( params);
	}	
	
	// 매장확인
	@Override
	public BleAuthVo retrieveREQ_CHECK_STORE(HashMap<String,Object> params ) {
		LOGGER.info( "retrieveREQ_CHECK_STORE :" );
		
		return mapper.retrieveREQ_CHECK_STORE( params );
	}
	@Override
	public List<BleAuthVo> retrieveREQ_CHECK_STORE_ALL(HashMap<String,Object> params ) {
		LOGGER.info( "retrieveREQ_CHECK_STORE_ALL :" );
		
		return mapper.retrieveREQ_CHECK_STORE_ALL( params );
	}
	
	// 매장등록 
	@Override
	public int retrieveREQ_REG_STORE(HashMap<String,Object> params ) {
		LOGGER.info( "retrieveREQ_REG_STORE :" );
		
		return mapper.retrieveREQ_REG_STORE( params );
	}
	
	
	// G/W 정보 통보 확인
	@Override
	public int retrieveREQ_NOTI_GW_INFO( HashMap<String,Object> params ) {
		LOGGER.info( "retrieveREQ_NOTI_GW_INFO :" );
		
		return mapper.retrieveREQ_NOTI_GW_INFO( params );
	}
	
	@Override
	public int retrieveREQ_NOTI_GW_INFO_BLE_CHECK_MST( HashMap<String,Object> params ) {
		LOGGER.info( "retrieveREQ_NOTI_GW_INFO_BLE_CHECK_MST :" );
		
		return mapper.retrieveREQ_NOTI_GW_INFO_BLE_CHECK_MST( params );
	}
	
	
	@Override
	public int retrieveREQ_NOTI_GW_INFO_BLE_MST( HashMap<String,Object> params ) {
		LOGGER.info( "retrieveREQ_NOTI_GW_INFO_BLE_MST :" );
		
		return mapper.retrieveREQ_NOTI_GW_INFO_BLE_MST( params );
	}
	
	@Override
	public int retrieveREQ_NOTI_GW_INFO_ELEC_MST( HashMap<String,Object> params ) {
		LOGGER.info( "retrieveREQ_NOTI_GW_INFO_ELEC_MST :" );
		
		return mapper.retrieveREQ_NOTI_GW_INFO_ELEC_MST( params );
	}
	
	@Override
	public int retrieveREQ_NOTI_GW_INFO_DEVICE_MST( HashMap<String,Object> params ) {
		LOGGER.info( "retrieveREQ_NOTI_GW_INFO_DEVICE_MST :" );
		
		return mapper.retrieveREQ_NOTI_GW_INFO_DEVICE_MST( params );
	}
	
	@Override
	public int retrieveREQ_NOTI_GW_INFO_SENSOR_MST( HashMap<String,Object> params ) {
		LOGGER.info( "retrieveREQ_NOTI_GW_INFO_SENSOR_MST :" );
		
		return mapper.retrieveREQ_NOTI_GW_INFO_SENSOR_MST( params );
	}
	
	
	
	
	
	
	
	
	
	@Override
	public BleAuthVo retrieveREQ_STORE_INFO_ELEC( HashMap<String,Object> params )
	{
		LOGGER.info( "retrieveREQ_STORE_INFO_ELEC :" );
		
		return mapper.retrieveREQ_STORE_INFO_ELEC( params );
	}
	
	@Override
	public List<BleAuthVo> retrieveREQ_STORE_INFO_TEMON( HashMap<String,Object> params )
	{
		LOGGER.info( "retrieveREQ_STORE_INFO_TEMON :" );
		
		return mapper.retrieveREQ_STORE_INFO_TEMON( params );
	}
	
	@Override
	public List<BleAuthVo> retrieveREQ_STORE_INFO_ZIGBEE( HashMap<String,Object> params )
	{
		LOGGER.info( "retrieveREQ_STORE_INFO_ZIGBEE :" );
		
		return mapper.retrieveREQ_STORE_INFO_ZIGBEE( params );
	}
	
	
	
	@Override
	public int saveGwInfoDeviceMst( HashMap<String,Object> params )
	{
		LOGGER.info( "saveGwInfoDeviceMst :" );
		
		return mapper.saveGwInfoDeviceMst( params );
	}
	
	@Override
	public int saveElecChannelCnt( HashMap<String,Object> params )
	{
		LOGGER.info( "saveElecChannelCnt :" );
		
		return mapper.saveElecChannelCnt( params );
	}
		
	@Override
	public int saveStoreCode( HashMap<String,Object> params )
	{
		LOGGER.info( "saveStoreCode :" );
		
		return mapper.saveStoreCode( params );
	}
	
	
	
	@Override
	public int saveUserMst( HashMap<String,Object> params )
	{
		LOGGER.info( "saveUserMst :" );
		
		return mapper.saveUserMst( params );
	}
	
	@Override
	public int saveUserAuth( HashMap<String,Object> params )
	{
		LOGGER.info( "saveUserAuth :" );
		
		return mapper.saveUserAuth( params );
	}
	
	@Override
	public int saveUserStrMap( HashMap<String,Object> params )
	{
		LOGGER.info( "saveUserStrMap :" );
		
		return mapper.saveUserStrMap( params );
	}
	
	
	
	
}
