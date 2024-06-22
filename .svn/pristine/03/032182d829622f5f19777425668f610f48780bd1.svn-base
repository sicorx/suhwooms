package rems.system.service;

import java.util.HashMap;
import java.util.List;

import rems.common.model.SelectVo;
import rems.system.model.AuthVo;
import rems.system.model.BleAuthVo;
import rems.system.model.GridStoreMgntVo;

public interface AuthMgntSvc {
	
	public List<HashMap<String, Object>> retrieveRemsAuthMgnt(HashMap<String, Object> params);
	
	public List<SelectVo> retrieveAuthSpList();
	
	public boolean getAuthCd(String param);
	
	public AuthVo retrieveAuthDtl(HashMap<String, String> params);
	
	public List<AuthVo> retrieveAuthListDtl(HashMap<String, String> params);
		
	public boolean saveRemsAuthMgnt(AuthVo param);
	
	
	public boolean delRemsAuthMgnt(List<HashMap<String, Object>> params, String companyCd, String userId, String now);
	
	public List<GridStoreMgntVo> retrieveBleStoreList();
	
	// 업데이트 확인
	public BleAuthVo retrieveREQ_CHECK_UPDATE( HashMap<String,Object> params );
	
	// 사용자 인증
	public BleAuthVo retrieveREQ_AUTH_USER( HashMap<String,Object> params );
	
	// BLE 인증번호 확인
	public BleAuthVo retrieveREQ_VERIFY_BLE( HashMap<String,Object> params );
	
	// 매장확인
	public BleAuthVo retrieveREQ_CHECK_STORE( HashMap<String,Object> params );
	public List<BleAuthVo> retrieveREQ_CHECK_STORE_ALL( HashMap<String,Object> params );
	
	// 매장등록
	public int retrieveREQ_REG_STORE(HashMap<String,Object> params );
	
	// G/W 정보 통보 확인
	public int retrieveREQ_NOTI_GW_INFO( HashMap<String,Object> params );
		
	
	public int retrieveREQ_NOTI_GW_INFO_BLE_CHECK_MST( HashMap<String,Object> params );	
	
	public int retrieveREQ_NOTI_GW_INFO_BLE_MST( HashMap<String,Object> params );
	
	public int retrieveREQ_NOTI_GW_INFO_ELEC_MST( HashMap<String,Object> params );
	
	public int retrieveREQ_NOTI_GW_INFO_DEVICE_MST( HashMap<String,Object> params );
	
	public int retrieveREQ_NOTI_GW_INFO_SENSOR_MST( HashMap<String,Object> params );
	
	
	// G/W 및 매장정보 확인
	public BleAuthVo retrieveREQ_STORE_INFO_ELEC( HashMap<String,Object> params );
	public List<BleAuthVo> retrieveREQ_STORE_INFO_TEMON( HashMap<String,Object> params );
	public List<BleAuthVo> retrieveREQ_STORE_INFO_ZIGBEE( HashMap<String,Object> params );

	
	public int saveGwInfoDeviceMst( HashMap<String,Object> params );
	public int saveElecChannelCnt( HashMap<String,Object> params );
	
	public int saveStoreCode( HashMap<String,Object> params );
	
	public int saveUserMst( HashMap<String,Object> params );
	
	public int saveUserAuth( HashMap<String,Object> params );
	
	public int saveUserStrMap( HashMap<String,Object> params );
	
}
