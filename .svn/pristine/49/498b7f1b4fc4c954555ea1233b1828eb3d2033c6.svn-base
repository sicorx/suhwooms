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
import rems.system.persistence.RemsDeviceMgntMapper;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : RemsDeviceMgntSvcImpl.java
 * @Description : 렘스장비 서비스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 9.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 9. 오전 10:50:51
 * @version 2.0
 * 
 */
@Service
public class RemsDeviceMgntSvcImpl implements RemsDeviceMgntSvc {

	@Autowired
	private RemsDeviceMgntMapper mapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( RemsDeviceMgntSvcImpl.class );
	
	// 렘스장비 목록
	@Transactional
	@Override
	public List<GridRemsDeviceMgntVo> retrieveStoreRemsMgnt(HashMap<String, Object> params) {
		LOGGER.error( "retrieveStoreRemsMgnt : " + params );
		
		List<GridRemsDeviceMgntVo> list = mapper.retrieveStoreRemsMgnt(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}
	
	// 렘스장비 저장
	@Override
	public boolean saveStoreRemsMgnt(GridRemsDeviceMgntVo params) {
		LOGGER.error( "saveStoreRemsMgnt : " + params );
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		// 렘스장비 저장
		updateRslt = mapper.saveStoreRemsMgnt(params);
		
		if (updateRslt == 0) {
			rslt = false;
		} else {
			rslt = true;
		}
		
		return rslt;
	}
	
	// 렘스장비 지우기
	@Override
	public int delStoreRemsMgnt(HashMap<String, Object> params) {
		return mapper.delStoreRemsMgnt(params);		
		
	}
	
	//엑셀다운로드
	@Override
	public List<HashMap<String,Object>> downloadstoreRemsMgntExcel(HashMap<String, Object> params) {		
		
		LOGGER.error( "retrieveAuthNmList" );
		
		return mapper.downloadstoreRemsMgntExcel( params );
	}
}
