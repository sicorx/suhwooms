package rems.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import rems.common.model.AreaVo;
import rems.common.model.SelectVo;
import rems.common.model.UserMngVo;
import rems.system.model.AuthVo;
import rems.system.model.ComCodeVo;
import rems.system.model.GridOrgMgntVo;
import rems.system.model.GridStoreMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.common.service
 * @Class Name : CommonSvc.java
 * @Description : 공통 서비스 인터페이스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 1. 24.     유승만      최초생성
 * @ 2017. 1. 24.     유승만      공통코드(retrieveComCodeList) 추가
 * 
 * @author 유승만
 * @since 2017. 1. 24. 오후 6:25:06
 * @version 2.0
 * 
 */
public interface CommonSvc {
	
	// 시스템 현재일자
	public String retrieveSysdate();

	// 조직 조회 카운트
	public GridOrgMgntVo retrieveOrgCdCnt(HashMap<String, Object> params);
	
	// 조직 목록(팝업)
	public List<Map<String, Object>> retrieveOrgCd(HashMap<String, Object> params);
	
	// 조직 목록 공지사항코드(팝업)
	public List<Map<String, Object>> retrieveOrgCdNoticeId(HashMap<String, Object> params);
	
	
	// 매장 조회 카운트
	public GridStoreMgntVo retrieveStoreCnt(HashMap<String, Object> params);	
	
	// 매장 조회 목록(팝업)
	public List<GridStoreMgntVo> retrieveStrCd(HashMap<String, Object> params);
	
	public List<Map<String, Object>> retrieveOrg(HashMap<String, Object> param);
	
	public List<UserMngVo> retrieveUserList(HashMap<String, Object> params);
	
	// 기상지역 조회 카운트
	public AreaVo retrieveAreaCdCnt(HashMap<String, Object> params);
	
	// 기상지역 목록(팝업)
	public List<AreaVo> retrieveAreaCd(HashMap<String, Object> params);
	
	public List<AreaVo> retrieveAreaNm(HashMap<String, Object> params);
	
	public List<AreaVo> retrieveCityNm(HashMap<String, Object> params);
	
	public List<AreaVo> retrieveDongNm(HashMap<String, Object> params);
	
	// 회사 select
	public List<SelectVo> retrieveCompanyCd(HashMap<String, Object> params);
	
	public List<HashMap<String, Object>> retrieveYearMonth(HashMap<String, Object> params);
	
	public List<GridStoreMgntVo> retrieveStoreRemsPartStoreList(HashMap<String, Object> params);
	
	public List<GridStoreMgntVo> retrieveStoreInverterStoreList(HashMap<String, Object> params);
	
	public List<GridStoreMgntVo> retrieveStoreConfigStoreList(HashMap<String, Object> params);
	
	public List<GridStoreMgntVo> retrieveGwStoreList(HashMap<String, Object> params);
	
	public List<GridStoreMgntVo> retrieveFacilityStoreList(HashMap<String, Object> params);
	
	public List<SelectVo> retrieveEquipmentTypeList(HashMap<String, Object> params);
	
	// 업체목록 select
	public List<SelectVo> retrieveVendorList(HashMap<String, Object> params);
	
	// 공통코드 select
	public List<ComCodeVo> retrieveComCodeList(ComCodeVo params);
	
	public List<AuthVo> retrieveAuthNmList(HashMap<String, Object> params);

}
