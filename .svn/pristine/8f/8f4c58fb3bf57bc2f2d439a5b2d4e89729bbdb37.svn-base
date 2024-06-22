package rems.system.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.common.model.SelectVo;
import rems.system.model.GridOrgMgntVo;
import rems.system.model.GridStoreMgntVo;
import rems.system.persistence.OrgMgntMapper;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : OrgMgntSvcImpl.java
 * @Description : 조직 서비스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 9.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 9. 오후 3:05:32
 * @version 2.0
 * 
 */
@Service
public class OrgMgntSvcImpl implements OrgMgntSvc {
	@Autowired
	private OrgMgntMapper mapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( OrgMgntSvcImpl.class );

	// 조직 목록
	@Override
	public List<Map<String, Object>> retrieveOrgList(HashMap<String, Object> params) {
		LOGGER.error( "retrieveOrgList : " + params );
		
		return mapper.retrieveOrgList(params);
	}
	
	// 조직 저장
	@SuppressWarnings("unchecked")
	public void saveOrgBatch(HashMap<String, Object> insertMap, HashMap<String, Object> updateMap, HashMap<String, Object> deleteMap) {
        LOGGER.error("saveOrgBatch\ninsertMap\n{}\nupdateMap\n{}\ndeleteMap\n{}", new Object[]{updateMap, deleteMap});

        List<HashMap<String, String>> insertList = (List<HashMap<String, String>>) insertMap.get("list");
        List<HashMap<String, String>> updateList = (List<HashMap<String, String>>) updateMap.get("list");
        List<String> deleteList = (List<String>) deleteMap.get("list");

        if (deleteList != null && deleteList.size() > 0) {
        	// 조직 삭제
        	mapper.deleteOrgBatch(deleteMap);
        	
        	// 매장 삭제(삭제된 조직코드를 매장에서 null)
        	mapper.updateOrgCdNullStrMgnt(deleteMap);
        }
        
        if (updateList != null && updateList.size() > 0) {
        	// 조직 수정
        	mapper.updateOrgBatch(updateMap);
        }
        
        if (insertList != null && insertList.size() > 0) {
        	// 조직 등록
        	mapper.insertOrgBatch(insertMap);
        }
    }
	
	// 매장 목록
	public List<GridStoreMgntVo> retrieveStrList(HashMap<String, Object> params) {
		LOGGER.error( "retrieveStrList : " + params );
		
		return mapper.retrieveStrList(params);
	}
	
	// 매장에 조직코드 저장
	@Override
	public boolean updateStrMgntOrgCd(HashMap<String, Object> params) {
		LOGGER.error( "updateStrMgntOrgCd : " + params );
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		// 매장에 조직코드 저장
		updateRslt = mapper.updateStrMgntOrgCd(params);
		
		if (updateRslt == 0) {
			rslt = false;
		} else {
			rslt = true;
		}
		
		return rslt;
	}
	
	// 매장 삭제(매장에서 조직코드 null)
	@Override
	public boolean updateStrMgntOrgCdNull(HashMap<String, Object> params) {
		LOGGER.error( "updateStrMgntOrgCdNull : " + params );
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		// 매장 삭제(매장에서 조직코드 null)
		updateRslt = mapper.updateStrMgntOrgCdNull(params);
		
		if (updateRslt == 0) {
			rslt = false;
		} else {
			rslt = true;
		}
		
		return rslt;
	}
	
	
	
	
	
	
	@Override
	public List<SelectVo> retrieveDepth1CdList(HashMap<String, Object> params) {
		return mapper.retrieveDepth1CdList(params);
	}

	@Override
	public List<GridOrgMgntVo> searchOrgList(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		return mapper.searchOrgList(params);
	}

	@Override
	public boolean retrieveSaveOrgMgnt(GridOrgMgntVo gomVo) {
		LOGGER.info( "saveEngineerMgnt : " + gomVo );
		
		boolean rslt   = false;
		int insertRslt = 0;
		
		//updateRslt = mapper.saveOrgMgnt(gomVo);
		LOGGER.info( "orgCnt : " + gomVo.getOrgCd() );
		if(gomVo.getOrgCd() == "" || gomVo.getOrgCd() == null){
			String orgCnt = mapper.getOrgCdCnt(gomVo);
			LOGGER.info( "orgCnt : " + orgCnt );
			String newOrgCd = gomVo.getUperOrgCd();
			orgCnt = Integer.toString((Integer.parseInt(orgCnt) + 1));
			if(orgCnt.length() == 1){
				orgCnt = "00" + orgCnt;
			}else if(orgCnt.length() == 2){
				orgCnt = "0" + orgCnt;
			}
			if(gomVo.getDepthLvl().equals("1")){
				gomVo.setOrgCd(orgCnt);
			}else{
				gomVo.setOrgCd(newOrgCd + orgCnt);
			}
		}
		
		
		insertRslt = mapper.retrieveSaveOrgMgnt(gomVo);
		
		if(insertRslt == 0){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}

	@Override
	public GridOrgMgntVo searchOrgCd(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		return mapper.searchOrgCd(params);
	}

	@Override
	public boolean deleteOrgMgnt(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		int result = 0;
		try{
			result = mapper.deleteOrgMgnt(params);
		}catch(Exception e){
			LOGGER.info(e.toString());
		}
		if(result == 0){
			return false;
		}else{
			return true;
		}
	}
}