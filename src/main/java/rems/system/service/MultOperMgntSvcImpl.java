package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.model.UserMngVo;
import rems.common.persistence.CommonMapper;
import rems.system.model.GridStoreMgntVo;
import rems.system.persistence.MultOperMgntMapper;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : MultOperMgntSvcImpl.java
 * @Description : 복수경영주 서비스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 1.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 1. 오후 2:48:47
 * @version 2.0
 * 
 */
@Service
public class MultOperMgntSvcImpl implements MultOperMgntSvc {

	@Autowired
	private MultOperMgntMapper MultOperMgntMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( StoreMgntSvcImpl.class );

	// 경영자 목록
	@Transactional
	@Override
	public List<UserMngVo> retrieveUserList(HashMap<String, Object> params) {
		LOGGER.error( "retrieveUserList : " + params );
		
		List<UserMngVo> list = MultOperMgntMapper.retrieveUserList(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}
	
	// 소유매장 목록	
	@Override
	public List<GridStoreMgntVo> retrieveRemsStoreMgnt(HashMap<String, Object> params) {
		LOGGER.error( "retrieveRemsStoreMgnt : " + params );
		
		return MultOperMgntMapper.retrieveRemsStoreMgnt(params);
	}
	
	// 전체매장 목록
	@Transactional
	@Override
	public List<GridStoreMgntVo> retrieveOperRemsStoreMgnt(HashMap<String, Object> params) {
		LOGGER.error( "retrieveOperRemsStoreMgnt : " + params );
		
		List<GridStoreMgntVo> list = MultOperMgntMapper.retrieveOperRemsStoreMgnt(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}
	
	// 소유매장 삭제
	@Override
	public boolean deleteStrMapMgnt(HashMap<String, Object> params) {
		LOGGER.error( "deleteStrMapMgnt : " + params );
		
		boolean rslt   = false;
		int delRslt = 0;
		
		// 소유매장 삭제
		delRslt = MultOperMgntMapper.deleteStrMapMgnt(params);
		
		if (delRslt == 0) {
			rslt = false;
		} else {
			rslt = true;
		}
		
		return rslt;
	}
	
	// 소유매장 등록
	@Override
	public boolean saveStrMapMgnt(HashMap<String, Object> params) {
		LOGGER.error( "saveStrMapMgnt : " + params );
		
		boolean rslt   = false;
		int insertRslt = 0;
		
		insertRslt = MultOperMgntMapper.saveStrMapMgnt(params);
		
		if (insertRslt == 0) {
			rslt = false;
		} else{
			rslt = true;
		}
		
		return rslt;
	}
}
