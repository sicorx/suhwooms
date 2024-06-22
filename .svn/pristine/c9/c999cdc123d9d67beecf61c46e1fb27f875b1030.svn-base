package rems.closing.persistence;

import java.util.HashMap;
import java.util.List;

import rems.common.model.SelectVo;
import rems.system.model.GridClosingVo;

public interface ClosingMapper {
	
	// 조회조건의 마감년월 셀렉트 박스 조회
	public List<SelectVo> retrieveSearchComboList();
	
	// 그리드의 마감년월 콤보박스
	public List<SelectVo> retrieveGridComboList();
	
	// 마감 리스트 조회
	public List<GridClosingVo> retrieveClosingList(HashMap<String, Object> params);
	
	//수량변경 - 정보변경
	public void saveModifyNumber(HashMap<String, Object> params);
	
	//수량변경 - 아이템 상세 변경
	public void saveModifyNumberDetail(HashMap<String, Object> params);
	
	//벤더확정
	public void updateFixVendor(HashMap<String, Object> params);
	
	//마감확정
	public void updateFixClosing(HashMap<String, Object> params);
		
	//마감월변경
	public void updateModifyClosingMon(HashMap<String, Object> params);
	
	//엑셀다운로드
	public List<HashMap<String, Object>> downloadClosingMngtExcel(HashMap<String, Object> params);
}
