package rems.system.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.system.model.DemandPowerExcelDataVo;
import rems.system.persistence.DemandPowerExcelUtilMapper;
import rems.util.excel.ExcelRead;
import rems.util.excel.ReadOption;

@Service
public class DemandPowerExcelUtilImpl implements DemandPowerExcelUtilSvc {

	@Autowired
	private DemandPowerExcelUtilMapper mapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( DemandPowerExcelUtilImpl.class );
	
	@Override
	public List<DemandPowerExcelDataVo> insertArticleInBoard(File destFile)
	{
		ReadOption readOption = new ReadOption();
		LOGGER.info("READ: " + destFile.getAbsolutePath());
		
		readOption.setFilePath(destFile.getAbsolutePath());
		readOption.setOutputColumns("A","B","C","D","E",
				"F","G","H"
				);
		readOption.setStartRow(6);		// 시작 row 번호
		
		List<Map<String, String>> excelContent = ExcelRead.demandPowerExcelRead(readOption);
				
		List<DemandPowerExcelDataVo> excelDataList = new ArrayList<DemandPowerExcelDataVo>();
		
		DemandPowerExcelDataVo excelDataVo = null;
		
		int valFlag = 0;
		int rowNum = 0;
		
		for(Map<String,String> article : excelContent)
		{	
			
			excelDataVo = new DemandPowerExcelDataVo();
			
			excelDataVo.setRowNum( rowNum );
			if( valFlag == 1 )			
			{
				
				excelDataVo.setConsumWatageSum( article.get("F") );		// 소비전력
				excelDataVo.setDemandPower( article.get("G") );	// 계약전력
				
				LOGGER.info( "["+rowNum+"]소비전력 : " + article.get("F") );
				LOGGER.info( "["+rowNum+"]계약전력 : " + article.get("G") );
				valFlag = 0;
				
				//ExcelRead.setDemandPower( readOption, rowNum+3 );
				
				excelDataList.add( excelDataVo );
				break;
			}
			else
			{
				excelDataVo.setDeviceGroup( 	article.get("A") );		// 분류
				excelDataVo.setDeviceNm(		article.get("B") );		// 장비명
				excelDataVo.setDeviceCnt(		article.get("C") );		// 수량
				excelDataVo.setDeviceUnit(		article.get("D") );		// 단위
				excelDataVo.setDeviceStandard(	article.get("E") );		// 규격(가로*세로*높이)				
				excelDataVo.setConsumWatage(	article.get("F") );		// 소비전력(W)
				excelDataVo.setUseWatage(		article.get("G") );		// 사용소비전력(W)
				excelDataVo.setNote(			article.get("H") );		// 비고
			}
			
			if( article.get("G").equals("계약전력")  )
			{				
				LOGGER.info("["+rowNum+"]계약전력!!");
				valFlag = 1;
			}
			else
			{
				valFlag = 0;
			}
			
			excelDataList.add( excelDataVo );			
			rowNum++;
		}
		
		
		return excelDataList;
	}
	
	@Transactional
	@Override
	public List<DemandPowerExcelDataVo> getDemandPowerStoreList(HashMap<String, Object> params)
	{
		LOGGER.info( "getDemandPowerStoreList : " + params );
		
		List<DemandPowerExcelDataVo> list = mapper.getDemandPowerStoreList(params);
		
		int cnt = commonMapper.selectTotalCnt();
		
		if( cnt != 0 ){
			list.get(0).setTotal(String.valueOf(cnt));	
		}
		return list;
	};
	
	@Override
	public int insertRecommendDemandPower(HashMap<String, Object> params)
	{
		LOGGER.info( "insertRecommendDemandPower : " + params );		
		return mapper.insertRecommendDemandPower(params);
		
	}


	@Override
	public int insertStoreArea(HashMap<String, Object> params) 
	{
		LOGGER.info( "insertStoreArea : " + params );		
		return mapper.insertStoreArea(params);
	};
	
	
	@Override
	public int insertStorePeak(HashMap<String, Object> params) 
	{
		LOGGER.info( "insertStorePeak : " + params );		
		return mapper.insertStorePeak(params);
	};
	
	
	@Override
	public int saveElectricEnt_init(HashMap<String, Object> params) 
	{
		LOGGER.info( "saveElectricEnt_init : " + params );		
		return mapper.saveElectricEnt_init(params);
	};
	
	@Override
	public int updateElectricEnt(HashMap<String, Object> params) 
	{
		LOGGER.info( "updateElectricEnt : " + params );		
		return mapper.updateElectricEnt(params);
	};
	
	public int delElectricEnt(HashMap<String, Object> params) 
	{
		LOGGER.info( "delElectricEnt : " + params );		
		return mapper.delElectricEnt(params);
	};
	
	@Override
	public List<HashMap<String, Object>> retrieveExcelDemandPowerStoreList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveExcelDemandPowerStoreList : " + params );
		
		List<HashMap<String, Object>> list = mapper.retrieveExcelDemandPowerStoreList(params);
		
		return list;
	}
	
}
