package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.system.model.GridMaintainEngineerMgntVo;
import rems.system.persistence.EngineerStrMapMapper;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : EngineerStrMapSvcImpl.java
 * @Description : 엔지니어매장할당 서비스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 3. 2.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 3. 2. 오후 6:04:12
 * @version 2.0
 * 
 */
@Service
public class EngineerStrMapSvcImpl implements EngineerStrMapSvc {
	
	@Autowired
	private EngineerStrMapMapper esmMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( EngineerStrMapSvcImpl.class );

	// 엔지니어 목록
	@Transactional
	@Override
	public List<GridMaintainEngineerMgntVo> searchVendorEngineerList(HashMap<String, Object> params) {
		LOGGER.error("searchVendorEngineerList : " + params);
		
		List<GridMaintainEngineerMgntVo> list = esmMapper.searchVendorEngineerList(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}

	// 엔지니어 할당된 매장 목록	
	@Override
	public List<GridMaintainEngineerMgntVo> searchEngineerStrList(HashMap<String, Object> params) {
		LOGGER.error("searchEngineerStrList : " + params);
		
		return esmMapper.searchEngineerStrList(params);
	}	
	
	// 할당매장선택 목록
	@Transactional
	@Override
	public List<GridMaintainEngineerMgntVo> searchStrEngineerList(HashMap<String, Object> params) {
		LOGGER.error("searchStrEngineerList : " + params);
		
		List<GridMaintainEngineerMgntVo> list = esmMapper.searchStrEngineerList(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}

	// 할당된 매장 삭제
	@Override
	public boolean deleteStrMappingEngineer(HashMap<String, Object> params) {
		LOGGER.error( "deleteStrMappingEngineer : " + params );
		
		boolean rslt   = false;
		int delRslt = 0;
		
		// 할당된 매장 삭제
		delRslt = esmMapper.deleteStrMappingEngineer(params);
		
		if (delRslt == 0) {
			rslt = false;
		} else {
			rslt = true;
		}
		
		return rslt;
	}
	
	// 할당된 매장 등록
	@Override
	public boolean insertStrMappingEngineer(HashMap<String, Object> params) {
		LOGGER.error( "insertStrMappingEngineer : " + params );
		
		boolean rslt   = false;
		int insertRslt = 0;
		
		// 할당된 매장 등록
		insertRslt = esmMapper.insertStrMappingEngineer(params);
		
		if (insertRslt == 0) {
			rslt = false;
		} else{
			rslt = true;
		}
		
		return rslt;
	}	
		
}