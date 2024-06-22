package rems.closing.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.closing.persistence.ClosingMapper;
import rems.common.model.SelectVo;
import rems.common.persistence.CommonMapper;
import rems.system.model.GridClosingVo;

@Service
public class ClosingSvcImpl implements ClosingSvc {

	@Autowired
	private ClosingMapper closingMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( ClosingSvcImpl.class );
	

	// 조회조건의 마감년월 셀렉트 박스 조회
	@Override
	public List<SelectVo> retrieveSearchComboList() {
		
		LOGGER.error( "retrieveSearchComboList" );
		
		return closingMapper.retrieveSearchComboList();
	}

	// 그리드의 마감년월 콤보박스
	@Override
	public List<SelectVo> retrieveGridComboList() {

		LOGGER.error( "retrieveGridComboList" );
		
		return closingMapper.retrieveGridComboList();
	}

	// 마감 리스트 조회
	@Transactional
	@Override
	public List<GridClosingVo> retrieveClosingList(HashMap<String, Object> params) {

		LOGGER.error( "retrieveClosingList" );
		
		List<GridClosingVo> list = closingMapper.retrieveClosingList(params);
		
		int cnt = commonMapper.selectTotalCnt();
		if( cnt != 0 ) {
			list.get(0).setTotal(String.valueOf(cnt));
		}
		return list;
	}

	//수량변경 - 정보변경
	@Override
	public void saveModifyNumber(HashMap<String, Object> params) {
		closingMapper.saveModifyNumber(params);
	}
	
	//수량변경 - 아이템 상세 변경
	@Override
	public void saveModifyNumberDetail(HashMap<String, Object> params) {
		closingMapper.saveModifyNumberDetail(params);;
	}

	//벤더확정
	@Override
	public void updateFixVendor(HashMap<String, Object> params) {
		closingMapper.updateFixVendor(params);
	}

	//마감확정
	@Override
	public void updateFixClosing(HashMap<String, Object> params) {
		closingMapper.updateFixClosing(params);
	}

	//마감월변경
	@Override
	public void updateModifyClosingMon(HashMap<String, Object> params) {
		closingMapper.updateModifyClosingMon(params);
	}
	
	//엑셀다운로드
	@Override
	public List<HashMap<String, Object>> downloadClosingMngtExcel(HashMap<String, Object> params) {
		LOGGER.info( "retrieveExcelEngineerStrList : " + params );
		
		List<HashMap<String, Object>> list = closingMapper.downloadClosingMngtExcel(params);
		
		return list;
	}
}
