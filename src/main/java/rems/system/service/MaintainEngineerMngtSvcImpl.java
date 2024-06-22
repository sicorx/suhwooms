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
import rems.system.model.GridUserMgntVo;
import rems.system.persistence.MaintainEngineerMngtMapper;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : MaintainEngineerMngtSvcImpl.java
 * @Description : 엔지니어관리 서비스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 3. 8.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 3. 8. 오후 4:30:02
 * @version 2.0
 * 
 */
@Service
public class MaintainEngineerMngtSvcImpl implements MaintainEngineerMngtSvc {
	
	@Autowired
	private MaintainEngineerMngtMapper memMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( MaintainEngineerMngtSvcImpl.class );
	
	// 엔지니어 목록
	@Transactional
	@Override
	public List<GridMaintainEngineerMgntVo> searchMaintainEngineerList(HashMap<String, Object> params) {
		LOGGER.error( "searchMaintainEngineerList : " + params );
		
		List<GridMaintainEngineerMgntVo> list = memMapper.searchMaintainEngineerList(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}
	
	// 엔지니어 저장
	@Override
	public boolean saveEngineerMgnt(GridUserMgntVo gumVo) {
		LOGGER.error( "saveEngineerMgnt : " + gumVo );
		
		boolean rslt   = false;
		int updateRslt = 0;
		int updateRslt2 = 0;
		
		// 엔지니어 저장
		updateRslt = memMapper.saveEngineerMgnt(gumVo);
		
		updateRslt2 = memMapper.saveEngineerAuthMgnt(gumVo);
		
		if (updateRslt == 0 || updateRslt2 == 0) {
			rslt = false;
		} else {
			rslt = true;
		}
		
		return rslt;
	}
	
	@Override
	public List<HashMap<String, Object>> downloadMaintainEngineerListrExcel(HashMap<String, Object> params) {
		LOGGER.info( "downloadMaintainEngineerListrExcel : " + params );
		
		List<HashMap<String, Object>> list = memMapper.downloadMaintainEngineerListrExcel(params);
		
		return list;
	}

	/*@Override
	public List<GridMaintainEngineerMgntVo> searchMaintainEngineerExcelList(HashMap<String, Object> params) {
		return memMapper.searchMaintainEngineerExcelList(params);
	}*/
	
}