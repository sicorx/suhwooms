package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.system.model.GwVo;
import rems.system.persistence.GwMgntMapper;
 
/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : GwMgntSvcImpl.java
 * @Description : 게이트웨이 서비스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 8.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 8. 오후 1:46:45
 * @version 2.0
 * 
 */
@Service
public class GwMgntSvcImpl implements GwMgntSvc {

	@Autowired
	private GwMgntMapper gwMgntMapper;
	
	@Autowired
	private CommonMapper commonMapper;
		
	private static final Logger LOGGER = LoggerFactory.getLogger( GwMgntSvcImpl.class );
	
	// 게이트웨이 목록
	@Transactional
	@Override
	public List<GwVo> retrieveGwListMgnt(HashMap<String, Object> params) {
		LOGGER.error( "retrieveGwListMgnt : " + params );
		
		List<GwVo> list = gwMgntMapper.retrieveGwListMgnt(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}
	
	// 게이트웨이 중복 확인
	@Override
	public boolean checkGwId(HashMap<String, Object> params) {
		LOGGER.error( "checkGwId : " + params );
		
		boolean rslt   = false;
		int countRslt = 0;
		
		// 게이트웨이 중복 확인
		countRslt = gwMgntMapper.checkGwId(params);

		if (countRslt == 0) {
			rslt = true;
		} else {
			rslt = false;
		}		
		
		return rslt;
	}
	
	// 게이트웨이 저장 
	@Override
	public boolean saveGWMgnt(GwVo params) {
		LOGGER.error( "saveGWMgnt : " + params );
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		// 게이트웨이 저장 
		updateRslt = gwMgntMapper.saveGWMgnt(params);
		
		if (updateRslt == 0) {
			rslt = false;
		} else {
			rslt = true;
		}
		
		return rslt;
	}
	
	// 게이트웨이 지우기 
	@Override
	public int delGWMgnt(HashMap<String, Object> params) {
		
		return gwMgntMapper.delGWMgnt(params);
	}
	
	@Override
	public int getGwId() {
		LOGGER.info( "getGwId : " );
		
		int rslt = 0;
		
		rslt = gwMgntMapper.getGwId();
		
		return rslt;
	}	

	@Override
	public List<HashMap<String,Object>> retrieveGwListExcelMgnt(HashMap<String, Object> params) {		
		
		LOGGER.error( "retrieveAuthNmList" );
		
		return gwMgntMapper.retrieveGwListExcelMgnt( params );
	}
}
