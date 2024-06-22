package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.system.model.GridVendorMgntVo;
import rems.system.persistence.VendorMgntMapper;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : VendorMgntSvcImpl.java
 * @Description : 유지보수업체 서비스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 1. 26.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 1. 26. 오후 3:32:06
 * @version 2.0
 * 
 */
@Service
public class VendorMgntSvcImpl implements VendorMgntSvc {

	@Autowired
	private VendorMgntMapper vendorMgntMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( VendorMgntSvcImpl.class );
	
	// 유지보수업체 목록
	@Transactional
	@Override
	public List<GridVendorMgntVo> retrieveRemsVendorList(HashMap<String, Object> params) {
		LOGGER.error( "retrieveRemsVendorList : " + params );
		
		List<GridVendorMgntVo> list = vendorMgntMapper.retrieveRemsVendorList(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}
	
	// 업체코드 중복 확인
	@Override
	public boolean checkVendorCd(HashMap<String, Object> params) {
		LOGGER.error( "checkVendorCd : " + params );
		
		boolean rslt   = false;
		int countRslt = 0;
		
		// 업체코드 중복 확인
		countRslt = vendorMgntMapper.checkVendorCd(params);

		if (countRslt == 0) {
			rslt = true;
		} else {
			rslt = false;
		}		
		
		return rslt;
	}
	
	// 유지보수업체 저장
	@Override
	public boolean saveRemsVendorMgnt(GridVendorMgntVo params) {
		LOGGER.error( "saveRemsVendorMgnt : " + params );
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		// 유지보수업체 저장
		updateRslt = vendorMgntMapper.saveRemsVendorMgnt(params);
		
		if (updateRslt == 0) {
			rslt = false;
		} else {
			rslt = true;
		}
		
		return rslt;
	}
	
	// 엔지니어 등록 유무 체크
	@Override
	public boolean checkEngineerTF(GridVendorMgntVo params) {
		LOGGER.error( "checkEngineerTF : " + params );
		
		boolean rslt   = false;
		int countRslt = 0;
		
		// 엔지니어 등록 유무 체크
		countRslt = vendorMgntMapper.checkEngineerTF(params);

		if (countRslt == 0) {
			rslt = false;
		} else {
			rslt = true;
		}		
		
		return rslt;
	}
		
	
}
