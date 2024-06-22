package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.model.SelectVo;
import rems.common.persistence.CommonMapper;
import rems.system.model.GridTempPolicyMgntVo;
import rems.system.persistence.TempPolicyMgntMapper;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : TempPolicyMgntSvcImpl.java
 * @Description : 권고온도 서비스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 1. 24.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 1. 24. 오후 6:20:16
 * @version 2.0
 * 
 */
@Service
public class TempPolicyMgntSvcImpl implements TempPolicyMgntSvc {

	@Autowired
	private TempPolicyMgntMapper tempPolicyMgntMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( TempPolicyMgntSvcImpl.class );
	
	// 권고온도 내역
	@Transactional
	@Override
	public List<GridTempPolicyMgntVo> retrieveRemsTempPolicyList(HashMap<String, Object> params) {
		LOGGER.error( "retrieveRemsTempPolicyList : " + params );
		
		List<GridTempPolicyMgntVo> list = tempPolicyMgntMapper.retrieveRemsTempPolicyList(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}
	
	// 권고온도 상세내역
	@Override
	public GridTempPolicyMgntVo retrieveRemsTempPolicy(HashMap<String, Object> params) {
		LOGGER.error( "retrieveRemsTempPolicy : " + params );
		
		return tempPolicyMgntMapper.retrieveRemsTempPolicy(params);
	}
	
	// 권고온도 저장
	@Override
	public boolean saveTempPolicyMgnt(GridTempPolicyMgntVo params) {

		LOGGER.error( "saveTempPolicyMgnt : " + params );
		
		boolean rslt   = true;
		int updateRslt = 0;
		//int updateRslt2 = 0;
		
		String monthTempList = params.getMonthTempList();
		
		String[] splitMonthTempList = monthTempList.split(":");
		
		for(int i = 1 ; i < 13 ; i++ ){
			
			String month = "";
			
			if( i < 10 ){
				month = "0"+i;	
			}else{
				month = Integer.toString(i) ;
			}
			HashMap<String,String> map = new HashMap<String,String>();
			map.put( "companyCd",  params.getCompanyCd() );
			map.put( "yyyyMm", params.getYyyy()+month );
			map.put( "recommTemp", splitMonthTempList[i-1] );
			map.put( "regiId", params.getRegiId() );
			map.put( "finalModId", params.getFinalModId() );
			
			// 권고온도 저장
			updateRslt = tempPolicyMgntMapper.saveTempPolicyMgnt(map);

			if( updateRslt == 0){
				rslt = false;
				break;
			}
			
			/* 2017.01.24 유승만
			 * - 차년도 무조건 입력되게 되어있어서 일단 주석처리
			map.put( "yyyyMm", (Integer.toString(Integer.parseInt(params.getYyyy())+1))+month );
			map.put( "recommTemp", splitMonthTempList[i-1] );
			
			updateRslt2 = tempPolicyMgntMapper.saveTempPolicyMgnt(map);
			if( updateRslt == 0 || updateRslt2 == 0 ){
				rslt = false;
				break;
			}
			*/
		}
		return rslt;
	}
	
	// 금년, 차년 select
	@Override
	public List<SelectVo> retrieveYearList() {
		LOGGER.error( "retrieveYearList");
		
		return tempPolicyMgntMapper.retrieveYearList();
	}
}
