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
import rems.system.persistence.EngineerMapMapper;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : EngineerMapSvcImpl.java
 * @Description : 매장할당현황조회 서비스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 3. 6.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 3. 6. 오후 4:04:40
 * @version 2.0
 * 
 */
@Service
public class EngineerMapSvcImpl implements EngineerMapSvc {
	
	@Autowired
	private EngineerMapMapper emMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( EngineerMapSvcImpl.class );
	
	// 매장할당현황조회 목록
	@Transactional
	@Override
	public List<GridMaintainEngineerMgntVo> retrieveEngineerStrList(HashMap<String, Object> params) {
		LOGGER.error("retrieveEngineerStrList : " + params);
		
		List<GridMaintainEngineerMgntVo> list = emMapper.retrieveEngineerStrList(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}
	
	@Override
	public List<HashMap<String, Object>> retrieveExcelEngineerStrList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveExcelEngineerStrList : " + params );
		
		List<HashMap<String, Object>> list = emMapper.retrieveExcelEngineerStrList(params);
		
		return list;
	}
		
}