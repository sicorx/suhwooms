package rems.system.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.system.model.HVACPolicyMgntVo;
import rems.system.persistence.HVACPolicyMgntMapper;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : HVACPolicyMgntSvcImpl.java
 * @Description : 냉난방정책 서비스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 1. 25.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 1. 25. 오전 10:17:49
 * @version 2.0
 * 
 */
@Service
public class HVACPolicyMgntSvcImpl implements HVACPolicyMgntSvc {
	@Autowired
	private HVACPolicyMgntMapper mapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( HVACPolicyMgntSvcImpl.class );
	
	// 냉난방정책 상세내역
	@Override
	public HVACPolicyMgntVo retrieveSeasonPolicyMgnt(HashMap<String, Object> params) {
		LOGGER.error( "retrieveSeasonPolicyMgnt : " + params );
		
		return mapper.retrieveSeasonPolicyMgnt(params);
	}
	
	// 냉난방정책 저장
	@Override
	public boolean saveAirConditionPolicyMgnt(HVACPolicyMgntVo params) {
		LOGGER.error( "saveAirConditionPolicyMgnt : " + params );
		
		boolean rslt   = true;
		int updateRslt = 0;
		
		String monthTempList = params.getMonthTempList();
		
		String[] splitMonthTempList = monthTempList.split(":");
		
		for(int i = 1 ; i <= splitMonthTempList.length ; i++ ){
			
			String month = "";
			
			if( i < 10 ){
				month = "0"+i;	
			}else{
				month = Integer.toString(i) ;
			}
			HashMap<String,String> map = new HashMap<String,String>();
			map.put( "companyCd",  params.getCompanyCd() );
			map.put( "mm", month );
			map.put( "mode", splitMonthTempList[i-1] );
			map.put( "regiId", params.getRegiId() );
			map.put( "finalModId", params.getFinalModId() );
			
			// 냉난방정책 저장
			updateRslt = mapper.saveAirConditionPolicyMgnt(map);
			
			if( updateRslt == 0){
				rslt = false;
				break;
			}
		}
		return rslt;
	}
}