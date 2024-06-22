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
import rems.system.model.GridMaintainEngineerMgntVo;
import rems.system.model.VandorStrMapVo;
import rems.system.persistence.VandorStrMapMapper;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : VandorStrMapSvcImpl.java
 * @Description : 업체매장할당 서비스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 16.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 16. 오후 1:00:43
 * @version 2.0
 * 
 */
@Service
public class VandorStrMapSvcImpl implements VandorStrMapSvc {
	@Autowired
	private VandorStrMapMapper vsmMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( VandorStrMapSvcImpl.class );

	// 할당된 매장목록 검색
	@Override
	public List<VandorStrMapVo> searchMapedStrList(HashMap<String, Object> params) {
		LOGGER.error("searchMapedStrList : " + params);
		
		return vsmMapper.searchMapedStrList(params);
	}
		
	// 할당매장선택 목록
	@Transactional
	@Override
	public List<VandorStrMapVo> searchCompanyStrList(HashMap<String, Object> params) {
		LOGGER.error("searchCompanyStrList : " + params);
		
		List<VandorStrMapVo> list = vsmMapper.searchCompanyStrList(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}

	// 할당된매장 삭제
	@Override
	public boolean deleteStrMappingVendor(HashMap<String, Object> params) {
		LOGGER.error( "deleteStrMappingVendor : " + params );
		
		boolean rslt   = false;
		int delRslt = 0;
		
		// 엔지니어 맵핑 삭제
		vsmMapper.deleteEngineerStrMapping(params);
		
		// 할당된매장 삭제
		delRslt = vsmMapper.deleteStrMappingVendor(params);
		
		if (delRslt == 0) {
			rslt = false;
		} else {
			rslt = true;
		}
		
		return rslt;
	}
	
	// 할당된매장 등록
	@Override
	public boolean insertStrMappingVendor(HashMap<String, Object> params) {
		LOGGER.error( "insertStrMappingVendor : " + params );
		
		boolean rslt   = false;
		int insertRslt = 0;
		
		// 할당된매장 등록
		insertRslt = vsmMapper.insertStrMappingVendor(params);
		
		if (insertRslt == 0) {
			rslt = false;
		} else{
			rslt = true;
		}
		
		return rslt;
	}
	
	// 할당된 매장목록 검색
	@Override
	public List<HashMap<String, Object>> searchCompanyStrListExcel(HashMap<String, Object> params) {		
		List<HashMap<String, Object>> list = vsmMapper.searchCompanyStrListExcel(params);
		
		return list;
	}
	
	@Override
	public List<SelectVo> retrieveVendorList(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		return vsmMapper.retrieveVendorList(params);
	}

	@Override
	public List<SelectVo> retrieveAllVandorCdList() {
		// TODO Auto-generated method stub
		return vsmMapper.retrieveAllVandorCdList();
	}

	@Override
	public List<GridMaintainEngineerMgntVo> searchVendorEngineerStrList(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		return vsmMapper.searchVendorEngineerStrList(params);
	}
}