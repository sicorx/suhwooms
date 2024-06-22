package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.common.model.UserMngVo;
import rems.system.model.GridStoreMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.persistence
 * @Class Name : MultOperMgntMapper.java
 * @Description : 복수경영주 서비스 맵퍼
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 1.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 1. 오후 2:49:33
 * @version 2.0
 * 
 */
public interface MultOperMgntMapper {

	// 경영자 목록
	public List<UserMngVo> retrieveUserList(HashMap<String, Object> params);
	
	// 소유매장 목록
	public List<GridStoreMgntVo> retrieveRemsStoreMgnt(HashMap<String, Object> params);
	
	// 전체매장 목록
	public List<GridStoreMgntVo> retrieveOperRemsStoreMgnt(HashMap<String, Object> params);
	
	// 소유매장 삭제
	public int deleteStrMapMgnt(HashMap<String, Object> params);
		
	// 소유매장 등록
	public int saveStrMapMgnt(HashMap<String, Object> params);
}
