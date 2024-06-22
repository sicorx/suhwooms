package rems.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.model.AreaVo;
import rems.common.model.SelectVo;
import rems.common.model.UserMngVo;
import rems.common.persistence.CommonMapper;
import rems.system.model.AuthVo;
import rems.system.model.ComCodeVo;
import rems.system.model.GridOrgMgntVo;
import rems.system.model.GridStoreMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.common.service
 * @Class Name : CommonSvcImpl.java
 * @Description : 공통 서비스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 1. 24.     유승만      최초생성
 * @ 2017. 1. 24.     유승만      공통코드(retrieveComCodeList) 추가
 * 
 * @author 유승만
 * @since 2017. 1. 24. 오후 6:26:16
 * @version 2.0
 * 
 */
@Service
public class CommonSvcImpl implements CommonSvc {

	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( CommonSvcImpl.class );
	
	// 시스템 현재일자
	@Override
	public String retrieveSysdate() {

		String rslt = commonMapper.retrieveSysdate();
		
		LOGGER.error( "retrieveSysdate : " + rslt );
		
		return rslt;
	}

	// 조직 조회 카운트
	@Override
	public GridOrgMgntVo retrieveOrgCdCnt(HashMap<String, Object> params) {
		LOGGER.error( "retrieveOrgCdCnt : " + params );
		
		return commonMapper.retrieveOrgCdCnt(params);
	}
	
	// 조직 목록(팝업)
	@Override
	public List<Map<String, Object>> retrieveOrgCd(HashMap<String, Object> params) {
		LOGGER.error( "retrieveOrgCd : " + params );
		
		return commonMapper.retrieveOrgCd(params);
	}
	
	// 조직 목록 공지사항코드(팝업)
	@Override
	public List<Map<String, Object>> retrieveOrgCdNoticeId(HashMap<String, Object> params) {
		LOGGER.error( "retrieveOrgCdNoticeId : " + params );
		
		return commonMapper.retrieveOrgCdNoticeId(params);
	}
	
	// 매장 조회 카운트
	@Override	
	public GridStoreMgntVo retrieveStoreCnt(HashMap<String, Object> params) {
		LOGGER.error( "retrieveStoreCnt : " + params );
		
		return commonMapper.retrieveStoreCnt(params);
	}
	
	
	
	// 매장 조회 목록(팝업)
	@Transactional
	@Override
	public List<GridStoreMgntVo> retrieveStrCd(HashMap<String, Object> params) {
		LOGGER.error( "retrieveStrCd : " + params );
		
		List<GridStoreMgntVo> list = commonMapper.retrieveStrCd(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}

	
	@Override
	public List<Map<String, Object>> retrieveOrg(HashMap<String, Object> param) {
		
		LOGGER.info( "retrieveOrg : " + param );
		
		return commonMapper.retrieveOrg( param );
	}
	
	@Override  
	public List<UserMngVo> retrieveUserList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveUserList : " + params );
		
		return commonMapper.retrieveUserList(params);
	}
	
	// 기상지역 조회 카운트
	@Override
	public AreaVo retrieveAreaCdCnt(HashMap<String, Object> params) {
		LOGGER.error( "retrieveAreaCdCnt : " + params );
		
		return commonMapper.retrieveAreaCdCnt(params);
	}
	
	// 기상지역 목록(팝업)
	@Transactional
	@Override
	public List<AreaVo> retrieveAreaCd(HashMap<String, Object> params) {
		LOGGER.error( "retrieveAreaCd : " + params );
		
		List<AreaVo> list = commonMapper.retrieveAreaCd(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}

	@Override
	public List<AreaVo> retrieveAreaNm(HashMap<String, Object> params) {
		LOGGER.info( "retrieveAreaNm : " + params );
		
		return commonMapper.retrieveAreaNm(params);
	}

	@Override
	public List<AreaVo> retrieveCityNm(HashMap<String, Object> params) {
		LOGGER.info( "retrieveCityNm : " + params );
		
		return commonMapper.retrieveCityNm(params);
	}

	@Override
	public List<AreaVo> retrieveDongNm(HashMap<String, Object> params) {
		LOGGER.info( "retrieveDongNm : " + params );
		
		return commonMapper.retrieveDongNm(params);
	}

	// 회사 select
	@Override
	public List<SelectVo> retrieveCompanyCd(HashMap<String, Object> params) {
		LOGGER.info( "retrieveCompanyCd : " + params );
		
		return commonMapper.retrieveCompanyCd(params);
	}
	
	@Override
	public List<HashMap<String, Object>> retrieveYearMonth(HashMap<String, Object> params) {

		LOGGER.info( "retrieveYearMonth : " + params );
		
		return commonMapper.retrieveYearMonth(params);
	}
	
	@Override
	public List<GridStoreMgntVo> retrieveStoreRemsPartStoreList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreRemsPartStoreList : " + params );
		
		return commonMapper.retrieveStoreRemsPartStoreList(params);
	}
	
	@Override
	public List<GridStoreMgntVo> retrieveStoreInverterStoreList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreInverterStoreList : " + params );
		
		return commonMapper.retrieveStoreInverterStoreList(params);
	}
	
	@Override
	public List<GridStoreMgntVo> retrieveStoreConfigStoreList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreConfigStoreList : " + params );
		
		return commonMapper.retrieveStoreConfigStoreList(params);
	}
	
	@Override
	public List<GridStoreMgntVo> retrieveGwStoreList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveGwStoreList : " + params );
		
		return commonMapper.retrieveGwStoreList(params);
	}
	
	@Override
	public List<GridStoreMgntVo> retrieveFacilityStoreList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveFacilityStoreList : " + params );
		
		return commonMapper.retrieveFacilityStoreList(params);
	}
	
	@Override
	public List<SelectVo> retrieveEquipmentTypeList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveEquipmentTypeList : " + params );
		
		return commonMapper.retrieveEquipmentTypeList(params);
	}
	
	// 업체목록 select
	@Override
	public List<SelectVo> retrieveVendorList(HashMap<String, Object> params) {
		LOGGER.error( "retrieveVendorList : " + params );
		
		return commonMapper.retrieveVendorList(params);
	}
	
	// 공통코드 select
	@Override
	public List<ComCodeVo> retrieveComCodeList(ComCodeVo params) {		

		LOGGER.error( "retrieveComCodeList" );
		
		return commonMapper.retrieveComCodeList( params );
	}
	
	@Override
	public List<AuthVo> retrieveAuthNmList(HashMap<String, Object> params) {		

		LOGGER.error( "retrieveAuthNmList" );
		
		return commonMapper.retrieveAuthNmList( params );
	}
}
