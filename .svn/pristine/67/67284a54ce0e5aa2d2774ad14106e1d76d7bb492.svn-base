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

import rems.system.model.ExcelDataVo;
import rems.system.persistence.ExcelUtilMapper;
import rems.util.excel.ExcelRead;
import rems.util.excel.ReadOption;

@Service
public class ExcelUtilImpl implements ExcelUtilSvc {

	@Autowired
	private ExcelUtilMapper mapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( ExcelUtilImpl.class );
	
	@Override
	public List<ExcelDataVo> insertArticleInBoard(File destFile)
	{
		ReadOption readOption = new ReadOption();
		LOGGER.info("READ: " + destFile.getAbsolutePath());
		readOption.setFilePath(destFile.getAbsolutePath());
		readOption.setOutputColumns("A","B","C","D","E",
				"F","G","H","I","J",
				"K","L","M","N","O",
				"P","Q","R","S","T",
				"U","V","W","X","Y",
				"Z",
				"AA","AB","AC","AD","AE",
				"AF","AG","AH","AI","AJ",
				"AK","AL","AM","AN","AO",
				"AP","AQ","AR","AS","AT",
				"AU","AV","AW","AX","AY","AZ",
				"BA","BB"
				);
		readOption.setStartRow(3);
		
		List<Map<String, String>> excelContent = ExcelRead.read(readOption);
				
		List<ExcelDataVo> excelDataList = new ArrayList<ExcelDataVo>();
		ExcelDataVo excelDataVo = null;
		for(Map<String,String> article : excelContent)
		{
			excelDataVo = new ExcelDataVo();
			
			excelDataVo.setStrCd( 							null );	// 계산
			excelDataVo.setStrNm( 							article.get("A") );
			excelDataVo.setAddr(							article.get("B") );
			excelDataVo.setLocalAreaCd( 					article.get("C") );
			excelDataVo.setViewStrCd( 						article.get("D") );
			excelDataVo.setCompanyCd(						article.get("E") );	// fix
			excelDataVo.setOrgCd(							null );					// fix
			excelDataVo.setContDemandPower(					article.get("F") );
			excelDataVo.setStrAreaSpec(						article.get("G") );
			excelDataVo.setStrDirecCd(						"Y" );					// fix
			excelDataVo.setTelNo(							null );					// fix
			excelDataVo.setRemsStartDt(						article.get("H") );
			excelDataVo.setRemsEndDt(						null );					// fix
			excelDataVo.setStrUseYn(						"Y" );
			excelDataVo.setTimeDiff(						"0" );					// fix
			excelDataVo.setStrAreaTypeCd(					null );					// fix
			
			excelDataVo.setGwId(							null );	// 계산
			excelDataVo.setGwAddr(							"000000000000" );		// fix			 
			
			excelDataVo.setGwIp(							null );	// fix			
			excelDataVo.setGwSwVer(							null );					// fix
			excelDataVo.setAuthYn(							"N" );					// fix
			excelDataVo.setDiagosisModuleType(				"0" );					// fix
			excelDataVo.setGwUseYn(							"Y" );					// fix
			excelDataVo.setUpdateTime(						null );					// fix
			excelDataVo.setUpdateSuccessYn(					null );					// fix
			
			excelDataVo.setMainMeter(						article.get("I") );
			excelDataVo.setExcldMeter(						article.get("K") );
			excelDataVo.setSubMeterLight(					"0" );					// fix
			excelDataVo.setSubMeterTemp(					article.get("J") );
			excelDataVo.setDimmer(							"0" );					// fix
			excelDataVo.setHacon(							article.get("L") );
			excelDataVo.settSensor(							article.get("M") );
			excelDataVo.setTemon(							article.get("N") );
			excelDataVo.setZigbee(							"0" );					// fix
			excelDataVo.setAlmon(							"0" );					// fix
			excelDataVo.setInv(								article.get("O") );
			excelDataVo.setSign(							article.get("P") );
			excelDataVo.setMeterCollector(					"1" );					// fix

			excelDataVo.setMETR_TYPE_confSp(				"METR_TYPE" );			// fix
			excelDataVo.setMETR_TYPE_confVal(				"DT" );					// fix
			excelDataVo.setMETR_TYPE_strConfVal(			null );					// fix
			excelDataVo.setMETR_TYPE_strConfValOld(			null );					// fix
			excelDataVo.setMETR_TYPE_appdtDt(				article.get("H") );		
			
			
			excelDataVo.setOPER_ELEC_confSp(				"OPER_ELEC" );			// fix
			excelDataVo.setOPER_ELEC_confVal(				"TM" );					// fix
			excelDataVo.setOPER_ELEC_strConfVal(			article.get("Q") );
			excelDataVo.setOPER_ELEC_strConfValOld(			article.get("Q") );
			excelDataVo.setOPER_ELEC_appdtDt( 				article.get("H") );
			
			excelDataVo.setPEAK_TYPE_confSp(				"PEAK_TYPE" );			// fix
			excelDataVo.setPEAK_TYPE_confVal(				article.get("R") );
			excelDataVo.setPEAK_TYPE_strConfVal(			article.get("S") );
			excelDataVo.setPEAK_TYPE_strConfValOld(			article.get("S") );
			excelDataVo.setPEAK_TYPE_appdtDt( 				article.get("H") );
			
			excelDataVo.setSIGN_DELY_confSp(				"SIGN_DELY" );			// fix
			excelDataVo.setSIGN_DELY_confVal(				"SD" );
			excelDataVo.setSIGN_DELY_strConfVal(			article.get("U") + "," + article.get("V") );
			excelDataVo.setSIGN_DELY_strConfValOld(			article.get("U") + "," + article.get("V") );
			excelDataVo.setSIGN_DELY_appdtDt( 				article.get("H") );
			
			excelDataVo.setSIGN_TYPE_confSp(				"SIGN_TYPE" );			// fix
			excelDataVo.setSIGN_TYPE_confVal(				article.get("T") );
			excelDataVo.setSIGN_TYPE_strConfVal(			"18:00,08:00" );		// fix
			excelDataVo.setSIGN_TYPE_strConfValOld(			"18:00,08:00" );		// fix
			excelDataVo.setSIGN_TYPE_appdtDt( 				article.get("H") );
			
			excelDataVo.setTEMP_LEVL_C0_confSp(				"TEMP_LEVL" );			// fix
			excelDataVo.setTEMP_LEVL_C0_confVal(			"C0" );					// fix
			excelDataVo.setTEMP_LEVL_C0_strConfVal(			article.get("W") );
			excelDataVo.setTEMP_LEVL_C0_strConfValOld(		article.get("W") );
			excelDataVo.setTEMP_LEVL_C0_appdtDt( 			article.get("H") );
			
			excelDataVo.setTEMP_LEVL_C1_confSp(				"TEMP_LEVL" );			// fix
			excelDataVo.setTEMP_LEVL_C1_confVal(			"C1" );					// fix
			excelDataVo.setTEMP_LEVL_C1_strConfVal(			article.get("X") );
			excelDataVo.setTEMP_LEVL_C1_strConfValOld(		article.get("X") );
			excelDataVo.setTEMP_LEVL_C1_appdtDt(			article.get("H") );
			
			excelDataVo.setTEMP_LEVL_H0_confSp(				"TEMP_LEVL" );			// fix
			excelDataVo.setTEMP_LEVL_H0_confVal(			"H0" );					// fix
			excelDataVo.setTEMP_LEVL_H0_strConfVal(			article.get("Y") );
			excelDataVo.setTEMP_LEVL_H0_strConfValOld(		article.get("Y") );
			excelDataVo.setTEMP_LEVL_H0_appdtDt( 			article.get("H") );
			
			excelDataVo.setTEMP_LEVL_H1_confSp(				"TEMP_LEVL" );			// fix
			excelDataVo.setTEMP_LEVL_H1_confVal(			"H1" );					// fix
			excelDataVo.setTEMP_LEVL_H1_strConfVal(			article.get("Z") );
			excelDataVo.setTEMP_LEVL_H1_strConfValOld(		article.get("Z") );
			excelDataVo.setTEMP_LEVL_H1_appdtDt( 			article.get("H") );
			
			excelDataVo.setTEMP_TYPE_confSp(				"TEMP_TYPE" );			// fix
			excelDataVo.setTEMP_TYPE_confVal(				article.get("AA") );
			excelDataVo.setTEMP_TYPE_strConfVal(			article.get("AB") );
			excelDataVo.setTEMP_TYPE_strConfValOld(			article.get("AB") );
			excelDataVo.setTEMP_TYPE_appdtDt( 				article.get("H") );
			
			excelDataVo.setTEMP_WIND_confSp(				"TEMP_WIND" );			// fix
			excelDataVo.setTEMP_WIND_confVal(				"L1" );					// fix
			excelDataVo.setTEMP_WIND_strConfVal(			null );					// fix
			excelDataVo.setTEMP_WIND_strConfValOld(			null );					// fix
			excelDataVo.setTEMP_WIND_appdtDt(				article.get("H") );
			
			
		
			
			List<String> temonId = new ArrayList<String>();
			List<String> temonType = new ArrayList<String>();
			List<String> temonPortNo = new ArrayList<String>();
			List<String> temonDeviceType = new ArrayList<String>();
			List<String> temonDeviceLoc = new ArrayList<String>();
			List<String> temonContents = new ArrayList<String>();
			List<String> temonMaxTemp = new ArrayList<String>();
			List<String> temonMinTemp = new ArrayList<String>();
			List<String> temonDelayTime = new ArrayList<String>();
			List<String> temonTempConf = new ArrayList<String>();
			List<String> temonPushTerm = new ArrayList<String>();
			List<String> temonPortUseYn = new ArrayList<String>();
			
			for(int i=0; i<16; i++)
			{
				// TH_STR_TEMP_MODULE
				String deviceLoc_Temp = "";
				switch( i )
				{
					case 0:		deviceLoc_Temp =  article.get("AC"); break;
					case 1:		deviceLoc_Temp =  article.get("AD"); break;
					case 2:		deviceLoc_Temp =  article.get("AE"); break;
					case 3:		deviceLoc_Temp =  article.get("AF"); break;
					case 4:		deviceLoc_Temp =  article.get("AG"); break;
					case 5:		deviceLoc_Temp =  article.get("AH"); break;
					case 6:		deviceLoc_Temp =  article.get("AI"); break;
					case 7:		deviceLoc_Temp =  article.get("AJ"); break;
					case 8:		deviceLoc_Temp =  article.get("AK"); break;
					case 9:		deviceLoc_Temp =  article.get("AL"); break;
					case 10:	deviceLoc_Temp =  article.get("AM"); break;
					case 11:	deviceLoc_Temp =  article.get("AN"); break;
					case 12:	deviceLoc_Temp =  article.get("AO"); break;
					case 13:	deviceLoc_Temp =  article.get("AP"); break;
					case 14:	deviceLoc_Temp =  article.get("AQ"); break;
					case 15:	deviceLoc_Temp =  article.get("AR"); break;
				}
				temonId.add(					i, "1" );
				temonType.add(					i, "T" );
				temonPortNo.add(				i, String.valueOf(i+1).toString() );
				temonDeviceType.add(			i, getDeviceType( deviceLoc_Temp ) ); 
				temonDeviceLoc.add(				i, deviceLoc_Temp );
				temonMaxTemp.add(       		i, getMaxTemp( deviceLoc_Temp ) );
				temonMinTemp.add(       		i, getMinTemp( deviceLoc_Temp ) );
				temonDelayTime.add(     		i, getDelayTime( deviceLoc_Temp ) );
				if( "".equals(deviceLoc_Temp) )
					temonPortUseYn.add(        	i, "N" );
				else
					temonPortUseYn.add(         i, "Y" );
				temonContents.add(              i, "" );			// fix
				temonTempConf.add(              i, "0" );			// fix
				temonPushTerm.add(              i, "180" );			// fix
					
			}
			excelDataVo.setTemonId(temonId);
			excelDataVo.setTemonType(temonType);
			excelDataVo.setTemonPortNo(temonPortNo);
			excelDataVo.setTemonDeviceType(temonDeviceType);
			excelDataVo.setTemonDeviceLoc(temonDeviceLoc);
			excelDataVo.setTemonContents(temonContents);
			excelDataVo.setTemonMaxTemp(temonMaxTemp);
			excelDataVo.setTemonMinTemp(temonMinTemp);
			excelDataVo.setTemonDelayTime(temonDelayTime);
			excelDataVo.setTemonTempConf(temonTempConf);
			excelDataVo.setTemonPushTerm(temonPushTerm);
			excelDataVo.setTemonPortUseYn(temonPortUseYn);
			
			
			List<String> hubId = new ArrayList<String>();
			List<String> hubPortNo = new ArrayList<String>();
			List<String> hubDeviceType = new ArrayList<String>();
			List<String> hubDeviceLoc = new ArrayList<String>();
			List<String> hubContents = new ArrayList<String>();
			List<String> hubPushTerm = new ArrayList<String>();
			List<String> hubPortUseYn = new ArrayList<String>();
			
			for(int i=0; i<8; i++)
			{
				// TH_STR_TEMP_MODULE
				String deviceLoc_Temp = "";
				switch( i )
				{
					case 0:		deviceLoc_Temp =  article.get("AS"); break;
					case 1:		deviceLoc_Temp =  article.get("AT"); break;
					case 2:		deviceLoc_Temp =  article.get("AU"); break;
					case 3:		deviceLoc_Temp =  article.get("AV"); break;
					case 4:		deviceLoc_Temp =  article.get("AW"); break;
					case 5:		deviceLoc_Temp =  article.get("AX"); break;
					case 6:		deviceLoc_Temp =  article.get("AY"); break;
					case 7:		deviceLoc_Temp =  article.get("AZ"); break;
				}
				hubId.add(					i, "1" );
				hubPortNo.add(				i, String.valueOf(i+1).toString() );
				hubDeviceType.add(			i, getDeviceType( deviceLoc_Temp ) ); 
				hubDeviceLoc.add(				i, deviceLoc_Temp );
				if( "".equals(deviceLoc_Temp) )
					hubPortUseYn.add(        	i, "N" );
				else
					hubPortUseYn.add(         i, "Y" );
				
				hubContents.add(              i, "" );			// fix
				hubPushTerm.add(              i, "180" );			// fix
					
			}
			excelDataVo.setHubId(hubId);
			excelDataVo.setHubPortNo(hubPortNo);
			excelDataVo.setHubDeviceType(hubDeviceType);
			excelDataVo.setHubDeviceLoc(hubDeviceLoc);
			excelDataVo.setHubContents(hubContents);
			excelDataVo.setHubPushTerm(hubPushTerm);
			excelDataVo.setHubPortUseYn(hubPortUseYn);
			
			
			if( article.get("BA").startsWith("다원") )
			{
				excelDataVo.setElectricEnt("DAWON_ENT");
				
			}
			else if( article.get("BA").startsWith("럭키") )
			{
				excelDataVo.setElectricEnt("LUCKY_ENT");
			}
			else if( article.get("BA").startsWith("우성") )
			{
				excelDataVo.setElectricEnt("WOOSUNG_ENT");
			}
			else
			{				
				excelDataVo.setElectricEnt("TNM_ENT");
			}
			
			excelDataVo.setRegiId("test");
			excelDataVo.setRegiDttm("now()");
			excelDataVo.setFinalModId("test");
			excelDataVo.setFinalModDttm("now()");
			
			
			excelDataList.add( excelDataVo );
			
			
			LOGGER.info( article.get("A") + "/" + article.get("B") + "/" + article.get("C") + "/" + article.get("D") + "/" + article.get("E") + "/" +
					article.get("F") + "/" + article.get("G") + "/" + article.get("H") + "/" + article.get("I") + "/" + article.get("J") + "/" +
					article.get("K") + "/" + article.get("L") + "/" + article.get("M") + "/" + article.get("N") + "/" + article.get("O") + "/" +
					article.get("P") + "/" + article.get("Q") + "/" + article.get("R") + "/" + article.get("S") + "/" + article.get("T") + "/" +
					article.get("U") + "/" + article.get("V") + "/" + article.get("W") + "/" + article.get("X") + "/" + article.get("Y") + "/" +
					article.get("Z") + "/" + 
					article.get("AA") + "/" + article.get("AB") + "/" + article.get("AC") + "/" + article.get("AD") + "/" + article.get("AE") + "/" +
					article.get("AF") + "/" + article.get("AG") + "/" + article.get("AH") + "/" + article.get("AI") + "/" + article.get("AJ") + "/" +
					article.get("AK") + "/" + article.get("AL") + "/" + article.get("AM") + "/" + article.get("AN") + "/" + article.get("AO") + "/" +
					article.get("AP") + "/" + article.get("AQ") + "/" + article.get("AR") + "/" + article.get("AS") + "/" + article.get("AT") + "/" +
					article.get("AU") + "/" + article.get("AV") + "/" + article.get("AW") + "/" + article.get("AX") + "/" + article.get("AY") + "/" +
					article.get("AZ") + "/" + article.get("BA")
					);
			//this.insertArticleInBoard(aVo);
			
		}
		
		return excelDataList;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	// Device Type 구하기
	public String getDeviceType( String DeviceLoc )
	{
		String val = "R";		// defalut type
		
		if( DeviceLoc == null )
			return val;
		
		if( 	 DeviceLoc.toUpperCase().startsWith("WIC") || DeviceLoc.toUpperCase().startsWith("INV_WIC") )
			val = "W"; 
		else if( DeviceLoc.toUpperCase().startsWith("OSC") || DeviceLoc.toUpperCase().startsWith("INV_OSC") )
			val = "O";
		else if( DeviceLoc.toUpperCase().startsWith("RIF") )
			val = "R";
		else if( DeviceLoc.toUpperCase().startsWith("RIC") )
			val = "R";
		else if( DeviceLoc.toUpperCase().startsWith("ICC") )
			val = "I";
		else 
			val = "I";
		
		return val;
	}
	
	// 상한 온도 구하기
	public String getMaxTemp( String DeviceLoc )
	{
		String val = "50";		// defalut value
		
		if( DeviceLoc == null )
			return val;
		
		if( 	 DeviceLoc.toUpperCase().startsWith("WIC") || DeviceLoc.toUpperCase().startsWith("INV_WIC") )
			val = "15"; 
		else if( DeviceLoc.toUpperCase().startsWith("OSC") || DeviceLoc.toUpperCase().startsWith("INV_OSC") )
			val = "15";
		else if( DeviceLoc.toUpperCase().startsWith("RIF") )
			val = "-10";
		else if( DeviceLoc.toUpperCase().startsWith("RIC") )
			val = "10";
		else if( DeviceLoc.toUpperCase().startsWith("ICC") )
			val = "-10";
		else 
			val = "50";
		
		return val;
	}
	
	// 하한 온도 구하기
	public String getMinTemp( String DeviceLoc )
	{
		String val = "-50";		// defalut value
		
		if( DeviceLoc == null )
			return val;
		
		if( 	 DeviceLoc.toUpperCase().startsWith("WIC") || DeviceLoc.toUpperCase().startsWith("INV_WIC") )
			val = "2"; 
		else if( DeviceLoc.toUpperCase().startsWith("OSC") || DeviceLoc.toUpperCase().startsWith("INV_OSC") )
			val = "2";
		else if( DeviceLoc.toUpperCase().startsWith("RIF") )
			val = "-50";
		else if( DeviceLoc.toUpperCase().startsWith("RIC") )
			val = "-10";
		else if( DeviceLoc.toUpperCase().startsWith("ICC") )
			val = "-50";
		else 
			val = "-50";
		
		return val;
	}
	
	// 딜레이 시간  구하기
	public String getDelayTime( String DeviceLoc )
	{
		String val = "90";		// defalut value
		
		if( DeviceLoc == null )
			return val;
		
		if( 	 DeviceLoc.toUpperCase().startsWith("WIC") || DeviceLoc.toUpperCase().startsWith("INV_WIC") )
			val = "90"; 
		else if( DeviceLoc.toUpperCase().startsWith("OSC") || DeviceLoc.toUpperCase().startsWith("INV_OSC") )
			val = "35";
		else if( DeviceLoc.toUpperCase().startsWith("RIF") )
			val = "20";
		else if( DeviceLoc.toUpperCase().startsWith("RIC") )
			val = "40";
		else if( DeviceLoc.toUpperCase().startsWith("ICC") )
			val = "20";
		else 
			val = "90";
		
		return val;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	@Override
	public int insertStrInfoDB(HashMap<String, Object> params)
	{
		LOGGER.info( "insertStrInfoDB : " + params );		
		return mapper.insertStrInfoDB(params);
	};
	
	@Override
	public int insertGwInfoDB(HashMap<String, Object> params)
	{
		LOGGER.info( "insertGwInfoDB : " + params );		
		return mapper.insertGwInfoDB(params);
	};
	
	@Override
	public int insertRemsPartCntDB(HashMap<String, Object> params)
	{
		LOGGER.info( "insertRemsPartCntDB : " + params );		
		return mapper.insertRemsPartCntDB(params);
	};
	
	@Override
	public int insertStrConfDB(HashMap<String, Object> params)
	{
		LOGGER.info( "insertStrConfDB : " + params );		
		return mapper.insertStrConfDB(params);
	};
	
	@Override
	public int insertTemonInfoDB(HashMap<String, Object> params)
	{
		LOGGER.info( "insertTemonInfoDB : " + params );		
		return mapper.insertTemonInfoDB(params);
	};
	
	@Override
	public int insertInvInfoDB(HashMap<String, Object> params)
	{
		LOGGER.info( "insertInvInfoDB : " + params );		
		return mapper.insertInvInfoDB(params);
	};
	
	@Override
	public int insertElectricEntDB(HashMap<String, Object> params )
	{
		LOGGER.info( "insertElectricEntDB : " + params );		
		return mapper.insertElectricEntDB(params);
	};
	
	
	
	
	@Override
	public String getStrCdValue(HashMap<String, Object> params)
	{
		LOGGER.info( "getStrCdValue : " + params );		
		return mapper.getStrCdValue(params);
	};
	
	@Override
	public String getGwIdValue(HashMap<String, Object> params)
	{
		LOGGER.info( "getGwIdValue : " + params );		
		return mapper.getGwIdValue(params);
	};
	
	@Override
	public void deleteInfoDB(HashMap<String, Object> params)
	{
		LOGGER.info( "deleteInfoDb : " + params );		
		mapper.deleteInfoDB(params);
	};
	
	
}
