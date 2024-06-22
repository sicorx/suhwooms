package rems.system.ctrl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import rems.system.model.ExcelDataVo;
import rems.system.model.ExcelInvDataVo;
import rems.system.model.ExcelStrConfDataVo;
import rems.system.model.ExcelTemonDataVo;
import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;
import rems.system.service.ExcelUtilSvc;


@Controller
@SessionAttributes("sessionUserVo")
public class ExcelUtilCtrl_cloud {

	/*

	private static final Logger LOGGER = LoggerFactory.getLogger(AuthMgntCtrl.class);

	
	@Autowired
	private ExcelUtilSvc excelUtilSvc;
	
	
	@RequestMapping(value = "/4209", method = {RequestMethod.GET, RequestMethod.POST})
	public String showStoreMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute UserVo userVo,
			ModelMap model) {

		LOGGER.info("StoreinputExcel" );
	
		
		return "system/storeInputExcel";
	}	
	
	

	@RequestMapping(value = "/excelRead", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody List<ExcelDataVo> readExcel(
			@RequestParam(value = "excelFile", required = false) MultipartFile excelFile,
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute UserVo userVo
			) {

		LOGGER.info("excelRead" );
		//MultipartFile excelFile = request.getFile("excelFile");
		
		if(excelFile == null || excelFile.isEmpty())
		{
			throw new RuntimeException("엑셀파일 선택해주세요");
		}
		
		if( excelFile.getOriginalFilename().startsWith("input") )
		{
			
		}
		else
		{
			throw new RuntimeException("잘못된 파일 형식입니다.");
		}
		
		File destFile = new File("C:\\TNM\\" + excelFile.getOriginalFilename() );
				
		try {
			excelFile.transferTo(destFile);
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		List<ExcelDataVo> excelDataList = excelUtilSvc.insertArticleInBoard(destFile);
		
		
		
		for(int i=0; i<excelDataList.size(); i++)
		{
			LOGGER.info( excelDataList.get(i).getStrNm() + " / " + excelDataList.get(i).getAddr() );
			
			// DB Insert 처리를 여기서 수행
			
			HashMap<String,Object> params = new HashMap<String,Object>();
			
			// th_str_info_mst
			
			params.put( "strNm", excelDataList.get(i).getStrNm() );
			params.put( "viewStrCd", excelDataList.get(i).getViewStrCd() );
			params.put( "localAreaCd", excelDataList.get(i).getLocalAreaCd() );
			params.put( "addr", excelDataList.get(i).getAddr() );
			params.put( "companyCd", excelDataList.get(i).getCompanyCd() );
			params.put( "orgCd", excelDataList.get(i).getOrgCd() );
			params.put( "contDemandPower", excelDataList.get(i).getContDemandPower() );
			params.put( "strAreaSpec", excelDataList.get(i).getStrAreaSpec() );
			params.put( "strDirecCd", excelDataList.get(i).getStrDirecCd() );
			params.put( "telNo", excelDataList.get(i).getTelNo() );
			params.put( "remsStartDt", excelDataList.get(i).getRemsStartDt() );
			params.put( "remsEndDt", excelDataList.get(i).getRemsEndDt() );
			params.put( "strUseYn", excelDataList.get(i).getStrUseYn() );
			params.put( "timeDiff", excelDataList.get(i).getTimeDiff() );
			params.put( "strAreaTypeCd", excelDataList.get(i).getStrAreaTypeCd() );
			params.put( "regiId", sessionUserVo.getSessionUserId() );
			params.put( "regiDttm", "now()" );
			params.put( "finalModId", sessionUserVo.getSessionUserId() );
			params.put( "finalModDttm", "now()" );
			
			// th_gw_mst
			params.put( "gwId", excelDataList.get(i).getGwId() );
			params.put( "gwAddr", excelDataList.get(i).getGwAddr() );
			params.put( "gwIp", excelDataList.get(i).getGwIp() );
			params.put( "gwSwVer", excelDataList.get(i).getGwSwVer() );
			params.put( "authYn", excelDataList.get(i).getAuthYn() );
			params.put( "diagnosisModuleType", excelDataList.get(i).getDiagosisModuleType() );
			params.put( "gwUseYn", excelDataList.get(i).getGwUseYn() );
			params.put( "updateTime", excelDataList.get(i).getUpdateTime() );
			params.put( "updateSuccessYn", excelDataList.get(i).getUpdateSuccessYn() );
			
			// th_str_rems_device_cnt_mnt
			params.put( "mainMeter", excelDataList.get(i).getMainMeter() );
			params.put( "excldMeter", excelDataList.get(i).getExcldMeter() );
			params.put( "subMeterLight", excelDataList.get(i).getSubMeterLight() );
			params.put( "subMeterTemp", excelDataList.get(i).getSubMeterTemp() );
			params.put( "dimmer", excelDataList.get(i).getDimmer() );
			params.put( "hacon", excelDataList.get(i).getHacon() );
			params.put( "tSensor", excelDataList.get(i).gettSensor() );
			params.put( "temon", excelDataList.get(i).getTemon() );
			params.put( "zigbee", excelDataList.get(i).getZigbee() );
			params.put( "almon", excelDataList.get(i).getAlmon() );
			params.put( "inv", excelDataList.get(i).getInv() );
			params.put( "sign", excelDataList.get(i).getSign() );
			params.put( "meterCollector", excelDataList.get(i).getMeterCollector() );
			
			// th_str_conf
			params.put( "METR_TYPE_confSp", excelDataList.get(i).getMETR_TYPE_confSp() );
			params.put( "METR_TYPE_confVal", excelDataList.get(i).getMETR_TYPE_confVal() );
			params.put( "METR_TYPE_strConfVal", excelDataList.get(i).getMETR_TYPE_strConfVal() );
			params.put( "METR_TYPE_strConfValOld", excelDataList.get(i).getMETR_TYPE_strConfValOld() );
			params.put( "METR_TYPE_appdtDt", excelDataList.get(i).getMETR_TYPE_appdtDt() );
			
			params.put( "OPER_ELEC_confSp", excelDataList.get(i).getOPER_ELEC_confSp() );
			params.put( "OPER_ELEC_confVal", excelDataList.get(i).getOPER_ELEC_confVal() );
			params.put( "OPER_ELEC_strConfVal", excelDataList.get(i).getOPER_ELEC_strConfVal() );
			params.put( "OPER_ELEC_strConfValOld", excelDataList.get(i).getOPER_ELEC_strConfValOld() );
			params.put( "OPER_ELEC_appdtDt", excelDataList.get(i).getOPER_ELEC_appdtDt() );
			
			params.put( "PEAK_TYPE_confSp", excelDataList.get(i).getPEAK_TYPE_confSp() );
			params.put( "PEAK_TYPE_confVal", excelDataList.get(i).getPEAK_TYPE_confVal() );
			params.put( "PEAK_TYPE_strConfVal", excelDataList.get(i).getPEAK_TYPE_strConfVal() );
			params.put( "PEAK_TYPE_strConfValOld", excelDataList.get(i).getPEAK_TYPE_strConfValOld() );
			params.put( "PEAK_TYPE_appdtDt", excelDataList.get(i).getPEAK_TYPE_appdtDt() );
			
			params.put( "SIGN_DELY_confSp", excelDataList.get(i).getSIGN_DELY_confSp() );
			params.put( "SIGN_DELY_confVal", excelDataList.get(i).getSIGN_DELY_confVal() );
			params.put( "SIGN_DELY_strConfVal", excelDataList.get(i).getSIGN_DELY_strConfVal() );
			params.put( "SIGN_DELY_strConfValOld", excelDataList.get(i).getSIGN_DELY_strConfValOld() );
			params.put( "SIGN_DELY_appdtDt", excelDataList.get(i).getSIGN_DELY_appdtDt() );
			
			params.put( "SIGN_TYPE_confSp", excelDataList.get(i).getSIGN_TYPE_confSp() );
			params.put( "SIGN_TYPE_confVal", excelDataList.get(i).getSIGN_TYPE_confVal() );
			params.put( "SIGN_TYPE_strConfVal", excelDataList.get(i).getSIGN_TYPE_strConfVal() );
			params.put( "SIGN_TYPE_strConfValOld", excelDataList.get(i).getSIGN_TYPE_strConfValOld() );
			params.put( "SIGN_TYPE_appdtDt", excelDataList.get(i).getSIGN_TYPE_appdtDt() );
			
			params.put( "TEMP_LEVL_C0_confSp", excelDataList.get(i).getTEMP_LEVL_C0_confSp() );
			params.put( "TEMP_LEVL_C0_confVal", excelDataList.get(i).getTEMP_LEVL_C0_confVal() );
			params.put( "TEMP_LEVL_C0_strConfVal", excelDataList.get(i).getTEMP_LEVL_C0_strConfVal() );
			params.put( "TEMP_LEVL_C0_strConfValOld", excelDataList.get(i).getTEMP_LEVL_C0_strConfValOld() );
			params.put( "TEMP_LEVL_C0_appdtDt", excelDataList.get(i).getTEMP_LEVL_C0_appdtDt() );
			
			params.put( "TEMP_LEVL_C1_confSp", excelDataList.get(i).getTEMP_LEVL_C1_confSp() );
			params.put( "TEMP_LEVL_C1_confVal", excelDataList.get(i).getTEMP_LEVL_C1_confVal() );
			params.put( "TEMP_LEVL_C1_strConfVal", excelDataList.get(i).getTEMP_LEVL_C1_strConfVal() );
			params.put( "TEMP_LEVL_C1_strConfValOld", excelDataList.get(i).getTEMP_LEVL_C1_strConfValOld() );
			params.put( "TEMP_LEVL_C1_appdtDt", excelDataList.get(i).getTEMP_LEVL_C1_appdtDt() );
			
			params.put( "TEMP_LEVL_H0_confSp", excelDataList.get(i).getTEMP_LEVL_H0_confSp() );
			params.put( "TEMP_LEVL_H0_confVal", excelDataList.get(i).getTEMP_LEVL_H0_confVal() );
			params.put( "TEMP_LEVL_H0_strConfVal", excelDataList.get(i).getTEMP_LEVL_H0_strConfVal() );
			params.put( "TEMP_LEVL_H0_strConfValOld", excelDataList.get(i).getTEMP_LEVL_H0_strConfValOld() );
			params.put( "TEMP_LEVL_H0_appdtDt", excelDataList.get(i).getTEMP_LEVL_H0_appdtDt() );
			
			params.put( "TEMP_LEVL_H1_confSp", excelDataList.get(i).getTEMP_LEVL_H1_confSp() );
			params.put( "TEMP_LEVL_H1_confVal", excelDataList.get(i).getTEMP_LEVL_H1_confVal() );
			params.put( "TEMP_LEVL_H1_strConfVal", excelDataList.get(i).getTEMP_LEVL_H1_strConfVal() );
			params.put( "TEMP_LEVL_H1_strConfValOld", excelDataList.get(i).getTEMP_LEVL_H1_strConfValOld() );
			params.put( "TEMP_LEVL_H1_appdtDt", excelDataList.get(i).getTEMP_LEVL_H1_appdtDt() );
			
			params.put( "TEMP_TYPE_confSp", excelDataList.get(i).getTEMP_TYPE_confSp() );
			params.put( "TEMP_TYPE_confVal", excelDataList.get(i).getTEMP_TYPE_confVal() );
			params.put( "TEMP_TYPE_strConfVal", excelDataList.get(i).getTEMP_TYPE_strConfVal() );
			params.put( "TEMP_TYPE_strConfValOld", excelDataList.get(i).getTEMP_TYPE_strConfValOld() );
			params.put( "TEMP_TYPE_appdtDt", excelDataList.get(i).getTEMP_TYPE_appdtDt() );
			
			params.put( "TEMP_WIND_confSp", excelDataList.get(i).getTEMP_WIND_confSp() );
			params.put( "TEMP_WIND_confVal", excelDataList.get(i).getTEMP_WIND_confVal() );
			params.put( "TEMP_WIND_strConfVal", excelDataList.get(i).getTEMP_WIND_strConfVal() );
			params.put( "TEMP_WIND_strConfValOld", excelDataList.get(i).getTEMP_WIND_strConfValOld() );
			params.put( "TEMP_WIND_appdtDt", excelDataList.get(i).getTEMP_WIND_appdtDt() );

			// th_str_temp_module
			params.put( "temonId", excelDataList.get(i).getTemonId() );
			params.put( "temonType", excelDataList.get(i).getTemonType() );
			params.put( "temonPortNo", excelDataList.get(i).getTemonPortNo() );
			params.put( "temonDeviceType", excelDataList.get(i).getTemonDeviceType() );
			params.put( "temonDeviceLoc", excelDataList.get(i).getTemonDeviceLoc() );
			params.put( "temonContents", excelDataList.get(i).getTemonContents() );
			params.put( "temonMaxTemp", excelDataList.get(i).getTemonMaxTemp() );
			params.put( "temonMinTemp", excelDataList.get(i).getTemonMinTemp() );
			params.put( "temonDelayTime", excelDataList.get(i).getTemonDelayTime() );
			params.put( "temonTempConf", excelDataList.get(i).getTemonTempConf() );
			params.put( "temonTempConf", excelDataList.get(i).getTemonTempConf() );
			params.put( "temonPushTerm", excelDataList.get(i).getTemonPushTerm() );
			params.put( "temonPortUseYn", excelDataList.get(i).getTemonPortUseYn() );
			
			// th_str_inv_hub
			params.put( "invId", excelDataList.get(i).getHubId() );
			params.put( "invType", excelDataList.get(i).getHubDeviceType() );
			params.put( "invPortNo", excelDataList.get(i).getTemonPortNo() );
			params.put( "invDeviceType", excelDataList.get(i).getTemonDeviceType() );
			params.put( "invDeviceLoc", excelDataList.get(i).getTemonDeviceLoc() );
			params.put( "invContents", excelDataList.get(i).getTemonContents() );
			params.put( "invMaxTemp", excelDataList.get(i).getTemonMaxTemp() );
			params.put( "invMinTemp", excelDataList.get(i).getTemonMinTemp() );
			params.put( "invDelayTime", excelDataList.get(i).getTemonDelayTime() );
			params.put( "invTempConf", excelDataList.get(i).getTemonTempConf() );
			params.put( "invTempConf", excelDataList.get(i).getTemonTempConf() );
			params.put( "invPushTerm", excelDataList.get(i).getTemonPushTerm() );
			params.put( "invPortUseYn", excelDataList.get(i).getTemonPortUseYn() );
			
			
			excelDataList.get(i).setStrInfoDB("N");
			excelDataList.get(i).setGwInfoDB("N");
			excelDataList.get(i).setRemsPartCntDB("N");
			excelDataList.get(i).setStrConfDB("N");
			excelDataList.get(i).setTemonInfoDB("N");
			excelDataList.get(i).setInvInfoDB("N");
			
			

		}
		//FileUtils.fileDelete(destFile.getAbsolutePath());
		
		
		
		
		return excelDataList;
		
	}
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/excelInput", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<ExcelDataVo> excelInput(
			@RequestParam(value = "fileName", required = false) String fileName,
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute UserVo userVo
			) {

		LOGGER.info("excelInput : " + fileName );
		
		File destFile = new File("C:\\TNM\\" + fileName );
		
		List<ExcelDataVo> excelDataList = excelUtilSvc.insertArticleInBoard(destFile);
		
		
		List<String> strInfoDBFlag =  new ArrayList<String>();
		List<String> gwInfoDBFlag =  new ArrayList<String>();
		List<String> remsPartCntDBFlag =  new ArrayList<String>();
		List<String> strConfDBFlag =  new ArrayList<String>();
		List<String> temonInfoDBFlag =  new ArrayList<String>();
		List<String> invInfoDBFlag =  new ArrayList<String>();
		
		
		
		for(int i=0; i<excelDataList.size(); i++)
		{
			LOGGER.info( excelDataList.get(i).getStrNm() + " / " + excelDataList.get(i).getAddr() );
			
			// DB Insert 처리를 여기서 수행
			
			HashMap<String,Object> params = new HashMap<String,Object>();
			
			// th_str_info_mst
			
			params.put( "strNm", excelDataList.get(i).getStrNm() );
			params.put( "viewStrCd", excelDataList.get(i).getViewStrCd() );
			params.put( "localAreaCd", excelDataList.get(i).getLocalAreaCd() );
			params.put( "addr", excelDataList.get(i).getAddr() );
			params.put( "companyCd", excelDataList.get(i).getCompanyCd() );
			params.put( "orgCd", excelDataList.get(i).getOrgCd() );
			params.put( "contDemandPower", excelDataList.get(i).getContDemandPower() );
			params.put( "strAreaSpec", excelDataList.get(i).getStrAreaSpec() );
			params.put( "strDirecCd", excelDataList.get(i).getStrDirecCd() );
			params.put( "telNo", excelDataList.get(i).getTelNo() );
			params.put( "remsStartDt", excelDataList.get(i).getRemsStartDt() );
			params.put( "remsEndDt", excelDataList.get(i).getRemsEndDt() );
			params.put( "strUseYn", excelDataList.get(i).getStrUseYn() );
			params.put( "timeDiff", excelDataList.get(i).getTimeDiff() );
			params.put( "strAreaTypeCd", excelDataList.get(i).getStrAreaTypeCd() );
			params.put( "regiId", sessionUserVo.getSessionUserId() );
			params.put( "regiDttm", "now()" );
			params.put( "finalModId", sessionUserVo.getSessionUserId() );
			params.put( "finalModDttm", "now()" );
			
			// th_gw_mst
			params.put( "gwId", excelDataList.get(i).getGwId() );
			params.put( "gwAddr", excelDataList.get(i).getGwAddr() );
			params.put( "gwIp", excelDataList.get(i).getGwIp() );
			params.put( "gwSwVer", excelDataList.get(i).getGwSwVer() );
			params.put( "authYn", excelDataList.get(i).getAuthYn() );
			params.put( "diagnosisModuleType", excelDataList.get(i).getDiagosisModuleType() );
			params.put( "gwUseYn", excelDataList.get(i).getGwUseYn() );
			params.put( "updateTime", excelDataList.get(i).getUpdateTime() );
			params.put( "updateSuccessYn", excelDataList.get(i).getUpdateSuccessYn() );
			
			// th_str_rems_device_cnt_mnt
			params.put( "mainMeter", excelDataList.get(i).getMainMeter() );
			params.put( "excldMeter", excelDataList.get(i).getExcldMeter() );
			params.put( "subMeterLight", excelDataList.get(i).getSubMeterLight() );
			params.put( "subMeterTemp", excelDataList.get(i).getSubMeterTemp() );
			params.put( "dimmer", excelDataList.get(i).getDimmer() );
			params.put( "hacon", excelDataList.get(i).getHacon() );
			params.put( "tSensor", excelDataList.get(i).gettSensor() );
			params.put( "temon", excelDataList.get(i).getTemon() );
			params.put( "zigbee", excelDataList.get(i).getZigbee() );
			params.put( "almon", excelDataList.get(i).getAlmon() );
			params.put( "inv", excelDataList.get(i).getInv() );
			params.put( "sign", excelDataList.get(i).getSign() );
			params.put( "meterCollector", excelDataList.get(i).getMeterCollector() );
			
			excelDataList.get(i).setStrInfoDB("N");
			excelDataList.get(i).setGwInfoDB("N");
			excelDataList.get(i).setRemsPartCntDB("N");
			excelDataList.get(i).setStrConfDB("N");
			excelDataList.get(i).setTemonInfoDB("N");
			excelDataList.get(i).setInvInfoDB("N");
			
			// 매장코드 값 자동으로 가져오기
			String strCd = excelUtilSvc.getStrCdValue(params);
			excelDataList.get(i).setStrCd(strCd);
			params.put( "strCd", strCd );		// 매장코드 자동 입력
			
			
			// 게이트웨이 고유아이디 자동으로 가져오기
			String gwId = excelUtilSvc.getGwIdValue(params);
			excelDataList.get(i).setGwId(gwId);
			params.put( "gwId", gwId );		// 매장코드 자동 입력
			
		
			
			
			// th_str_conf 데이터 생성
			List<ExcelStrConfDataVo> excelStrConfDataListVo = new ArrayList<ExcelStrConfDataVo>(); 
			
			for(int k=0; k<11; k++)
			{
				ExcelStrConfDataVo excelStrConfDataVo = new ExcelStrConfDataVo();	
				switch( k )
				{
					case 0:
						excelStrConfDataVo.setStrCd( strCd );
						excelStrConfDataVo.setConfSp( excelDataList.get(i).getMETR_TYPE_confSp() );
						excelStrConfDataVo.setConfVal( excelDataList.get(i).getMETR_TYPE_confVal() );
						excelStrConfDataVo.setStrConfVal( excelDataList.get(i).getMETR_TYPE_strConfVal() );
						excelStrConfDataVo.setStrConfValOld( excelDataList.get(i).getMETR_TYPE_strConfValOld() );
						excelStrConfDataVo.setAppdtDt( excelDataList.get(i).getMETR_TYPE_appdtDt() );
						excelStrConfDataVo.setRegiId( sessionUserVo.getSessionUserId() );
						excelStrConfDataVo.setFinalModId( sessionUserVo.getSessionUserId() );
						break;
					case 1:
						excelStrConfDataVo.setStrCd( strCd );
						excelStrConfDataVo.setConfSp( excelDataList.get(i).getOPER_ELEC_confSp() );
						excelStrConfDataVo.setConfVal( excelDataList.get(i).getOPER_ELEC_confVal() );
						excelStrConfDataVo.setStrConfVal( excelDataList.get(i).getOPER_ELEC_strConfVal() );
						excelStrConfDataVo.setStrConfValOld( excelDataList.get(i).getOPER_ELEC_strConfValOld() );
						excelStrConfDataVo.setAppdtDt( excelDataList.get(i).getOPER_ELEC_appdtDt() );
						excelStrConfDataVo.setRegiId( sessionUserVo.getSessionUserId() );
						excelStrConfDataVo.setFinalModId( sessionUserVo.getSessionUserId() );
						break;
					case 2:
						excelStrConfDataVo.setStrCd( strCd );
						excelStrConfDataVo.setConfSp( excelDataList.get(i).getPEAK_TYPE_confSp() );
						excelStrConfDataVo.setConfVal( excelDataList.get(i).getPEAK_TYPE_confVal() );
						excelStrConfDataVo.setStrConfVal( excelDataList.get(i).getPEAK_TYPE_strConfVal() );
						excelStrConfDataVo.setStrConfValOld( excelDataList.get(i).getPEAK_TYPE_strConfValOld() );
						excelStrConfDataVo.setAppdtDt( excelDataList.get(i).getOPER_ELEC_appdtDt() );
						excelStrConfDataVo.setRegiId( sessionUserVo.getSessionUserId() );
						excelStrConfDataVo.setFinalModId( sessionUserVo.getSessionUserId() );
						break;
					case 3:
						excelStrConfDataVo.setStrCd( strCd );
						excelStrConfDataVo.setConfSp( excelDataList.get(i).getSIGN_DELY_confSp() );
						excelStrConfDataVo.setConfVal( excelDataList.get(i).getSIGN_DELY_confVal() );
						excelStrConfDataVo.setStrConfVal( excelDataList.get(i).getSIGN_DELY_strConfVal() );
						excelStrConfDataVo.setStrConfValOld( excelDataList.get(i).getSIGN_DELY_strConfValOld() );
						excelStrConfDataVo.setAppdtDt( excelDataList.get(i).getOPER_ELEC_appdtDt() );
						excelStrConfDataVo.setRegiId( sessionUserVo.getSessionUserId() );
						excelStrConfDataVo.setFinalModId( sessionUserVo.getSessionUserId() );
						break;
					case 4:
						excelStrConfDataVo.setStrCd( strCd );
						excelStrConfDataVo.setConfSp( excelDataList.get(i).getSIGN_TYPE_confSp() );
						excelStrConfDataVo.setConfVal( excelDataList.get(i).getSIGN_TYPE_confVal() );
						excelStrConfDataVo.setStrConfVal( excelDataList.get(i).getSIGN_TYPE_strConfVal() );
						excelStrConfDataVo.setStrConfValOld( excelDataList.get(i).getSIGN_TYPE_strConfValOld() );
						excelStrConfDataVo.setAppdtDt( excelDataList.get(i).getOPER_ELEC_appdtDt() );
						excelStrConfDataVo.setRegiId( sessionUserVo.getSessionUserId() );
						excelStrConfDataVo.setFinalModId( sessionUserVo.getSessionUserId() );
						break;
					case 5:
						excelStrConfDataVo.setStrCd( strCd );
						excelStrConfDataVo.setConfSp( excelDataList.get(i).getTEMP_LEVL_C0_confSp() );
						excelStrConfDataVo.setConfVal( excelDataList.get(i).getTEMP_LEVL_C0_confVal() );
						excelStrConfDataVo.setStrConfVal( excelDataList.get(i).getTEMP_LEVL_C0_strConfVal() );
						excelStrConfDataVo.setStrConfValOld( excelDataList.get(i).getTEMP_LEVL_C0_strConfValOld() );
						excelStrConfDataVo.setAppdtDt( excelDataList.get(i).getOPER_ELEC_appdtDt() );
						excelStrConfDataVo.setRegiId( sessionUserVo.getSessionUserId() );
						excelStrConfDataVo.setFinalModId( sessionUserVo.getSessionUserId() );
						break;
					case 6:
						excelStrConfDataVo.setStrCd( strCd );
						excelStrConfDataVo.setConfSp( excelDataList.get(i).getTEMP_LEVL_C1_confSp() );
						excelStrConfDataVo.setConfVal( excelDataList.get(i).getTEMP_LEVL_C1_confVal() );
						excelStrConfDataVo.setStrConfVal( excelDataList.get(i).getTEMP_LEVL_C1_strConfVal() );
						excelStrConfDataVo.setStrConfValOld( excelDataList.get(i).getTEMP_LEVL_C1_strConfValOld() );
						excelStrConfDataVo.setAppdtDt( excelDataList.get(i).getOPER_ELEC_appdtDt() );
						excelStrConfDataVo.setRegiId( sessionUserVo.getSessionUserId() );
						excelStrConfDataVo.setFinalModId( sessionUserVo.getSessionUserId() );
						break;
					case 7:
						excelStrConfDataVo.setStrCd( strCd );
						excelStrConfDataVo.setConfSp( excelDataList.get(i).getTEMP_LEVL_H0_confSp() );
						excelStrConfDataVo.setConfVal( excelDataList.get(i).getTEMP_LEVL_H0_confVal() );
						excelStrConfDataVo.setStrConfVal( excelDataList.get(i).getTEMP_LEVL_H0_strConfVal() );
						excelStrConfDataVo.setStrConfValOld( excelDataList.get(i).getTEMP_LEVL_H0_strConfValOld() );
						excelStrConfDataVo.setAppdtDt( excelDataList.get(i).getOPER_ELEC_appdtDt() );
						excelStrConfDataVo.setRegiId( sessionUserVo.getSessionUserId() );
						excelStrConfDataVo.setFinalModId( sessionUserVo.getSessionUserId() );
						break;
					case 8:
						excelStrConfDataVo.setStrCd( strCd );
						excelStrConfDataVo.setConfSp( excelDataList.get(i).getTEMP_LEVL_H1_confSp() );
						excelStrConfDataVo.setConfVal( excelDataList.get(i).getTEMP_LEVL_H1_confVal() );
						excelStrConfDataVo.setStrConfVal( excelDataList.get(i).getTEMP_LEVL_H1_strConfVal() );
						excelStrConfDataVo.setStrConfValOld( excelDataList.get(i).getTEMP_LEVL_H1_strConfValOld() );
						excelStrConfDataVo.setAppdtDt( excelDataList.get(i).getOPER_ELEC_appdtDt() );
						excelStrConfDataVo.setRegiId( sessionUserVo.getSessionUserId() );
						excelStrConfDataVo.setFinalModId( sessionUserVo.getSessionUserId() );
						break;
					case 9:
						excelStrConfDataVo.setStrCd( strCd );
						excelStrConfDataVo.setConfSp( excelDataList.get(i).getTEMP_TYPE_confSp() );
						excelStrConfDataVo.setConfVal( excelDataList.get(i).getTEMP_TYPE_confVal() );
						excelStrConfDataVo.setStrConfVal( excelDataList.get(i).getTEMP_TYPE_strConfVal() );
						excelStrConfDataVo.setStrConfValOld( excelDataList.get(i).getTEMP_TYPE_strConfValOld() );
						excelStrConfDataVo.setAppdtDt( excelDataList.get(i).getOPER_ELEC_appdtDt() );
						excelStrConfDataVo.setRegiId( sessionUserVo.getSessionUserId() );
						excelStrConfDataVo.setFinalModId( sessionUserVo.getSessionUserId() );
						break;
					case 10:
						excelStrConfDataVo.setStrCd( strCd );
						excelStrConfDataVo.setConfSp( excelDataList.get(i).getTEMP_WIND_confSp() );
						excelStrConfDataVo.setConfVal( excelDataList.get(i).getTEMP_WIND_confVal() );
						excelStrConfDataVo.setStrConfVal( excelDataList.get(i).getTEMP_WIND_strConfVal() );
						excelStrConfDataVo.setStrConfValOld( excelDataList.get(i).getTEMP_WIND_strConfValOld() );
						excelStrConfDataVo.setAppdtDt( excelDataList.get(i).getOPER_ELEC_appdtDt() );
						excelStrConfDataVo.setRegiId( sessionUserVo.getSessionUserId() );
						excelStrConfDataVo.setFinalModId( sessionUserVo.getSessionUserId() );
						break;
					
				
				}
				excelStrConfDataListVo.add(k, excelStrConfDataVo);
				
			}
			
			
			List<ExcelTemonDataVo> excelTemonDataListVo = new ArrayList<ExcelTemonDataVo>();
			for(int k=0; k<16; k++)
			{
				ExcelTemonDataVo excelTemonDataVo = new ExcelTemonDataVo();
				
				excelTemonDataVo.setTemonStrCd( strCd );
				excelTemonDataVo.setTemonId( excelDataList.get(i).getTemonId().get(k) );
				excelTemonDataVo.setTemonType( excelDataList.get(i).getTemonType().get(k) );
				excelTemonDataVo.setTemonPortNo( excelDataList.get(i).getTemonPortNo().get(k) );
				excelTemonDataVo.setTemonDeviceType( excelDataList.get(i).getTemonDeviceType().get(k) );
				excelTemonDataVo.setTemonDeviceLoc( excelDataList.get(i).getTemonDeviceLoc().get(k) );
				excelTemonDataVo.setTemonContents( excelDataList.get(i).getTemonContents().get(k) );
				excelTemonDataVo.setTemonMaxTemp( excelDataList.get(i).getTemonMaxTemp().get(k) );
				excelTemonDataVo.setTemonMinTemp( excelDataList.get(i).getTemonMinTemp().get(k) );
				excelTemonDataVo.setTemonDelayTime( excelDataList.get(i).getTemonDelayTime().get(k) );
				excelTemonDataVo.setTemonTempConf( excelDataList.get(i).getTemonTempConf().get(k) );
				excelTemonDataVo.setTemonPushTerm( excelDataList.get(i).getTemonPushTerm().get(k) );
				excelTemonDataVo.setTemonPortUseYn( excelDataList.get(i).getTemonPortUseYn().get(k) );
				excelTemonDataVo.setTemonRegiId( sessionUserVo.getSessionUserId() );
				excelTemonDataVo.setTemonFinalModId( sessionUserVo.getSessionUserId() );
				excelTemonDataListVo.add(k, excelTemonDataVo);
			}
			
			
			// th_str_inv_module 데이터 생성
			List<ExcelInvDataVo> excelInvDataListVo = new ArrayList<ExcelInvDataVo>();
			for(int k=0; k<8; k++)
			{
				ExcelInvDataVo excelInvDataVo = new ExcelInvDataVo();
				excelInvDataVo.setInvStrCd( strCd );
				excelInvDataVo.setInvId( excelDataList.get(i).getHubId().get(k) );				
				excelInvDataVo.setInvPortNo( excelDataList.get(i).getHubPortNo().get(k) );
				excelInvDataVo.setInvDeviceType( excelDataList.get(i).getHubDeviceType().get(k) );
				excelInvDataVo.setInvDeviceLoc( excelDataList.get(i).getHubDeviceLoc().get(k) );
				excelInvDataVo.setInvDeviceContents( excelDataList.get(i).getHubContents().get(k) );				
				excelInvDataVo.setInvPushTerm( excelDataList.get(i).getHubPushTerm().get(k) );
				excelInvDataVo.setInvPortUseYn( excelDataList.get(i).getHubPortUseYn().get(k) );
				excelInvDataVo.setInvRegiId( sessionUserVo.getSessionUserId() );
				excelInvDataVo.setInvFinalModId( sessionUserVo.getSessionUserId() );
				excelInvDataListVo.add(k, excelInvDataVo);
			}
			
			
			
			
						
			
			// th_str_info_mst 에 insert
			int result1 = excelUtilSvc.insertStrInfoDB(params);
			if( result1 != 0 )
				excelDataList.get(i).setStrInfoDB( "O" );
			else
				excelDataList.get(i).setStrInfoDB( "x" );
			
			
			// th_gw_mst 에 insert
			int result2 = excelUtilSvc.insertGwInfoDB(params);
			if( result2 != 0 )
				excelDataList.get(i).setGwInfoDB( "O" );
			else
				excelDataList.get(i).setGwInfoDB( "x" );
			
			// th_str_rems_device_cnt_mnt 에 insert
			int result3 = excelUtilSvc.insertRemsPartCntDB(params);
			if( result3 != 0 )
				excelDataList.get(i).setRemsPartCntDB( "O" );
			else
				excelDataList.get(i).setRemsPartCntDB( "x" );			
			
			// th_str_conf 에 insert
			HashMap<String, Object> strConfParam = new HashMap<String, Object>();
			strConfParam.put( "excelStrConfDataListVo", excelStrConfDataListVo );	
			int result4 = excelUtilSvc.insertStrConfDB( strConfParam );
			
			if( result4 != 0 )
				excelDataList.get(i).setStrConfDB( "O" );
			else
				excelDataList.get(i).setStrConfDB( "x" );
			
			// th_str_temp_module 에 insert
			HashMap<String, Object> temonParam = new HashMap<String, Object>();
			temonParam.put( "excelTemonDataListVo", excelTemonDataListVo );	
			int result5 = excelUtilSvc.insertTemonInfoDB( temonParam );
			
			if( result5 != 0 )
				excelDataList.get(i).setTemonInfoDB( "O" );
			else
				excelDataList.get(i).setTemonInfoDB( "x" );
			
			// th_str_inv_hub 에 insert
			HashMap<String, Object> invParam = new HashMap<String, Object>();
			invParam.put( "excelInvDataListVo", excelInvDataListVo );	
			int result6 = excelUtilSvc.insertInvInfoDB( invParam );
			
			if( result6 != 0 )
				excelDataList.get(i).setInvInfoDB( "O" );
			else
				excelDataList.get(i).setInvInfoDB( "x" );
			
			
			if( result1 != 0 && result2 != 0 && result3 != 0 && result4 != 0 && result5 != 0 && result6 != 0)
			{
				
				excelDataList.get(i).setAllDataDB( "O" );
				
				LOGGER.info("["+strCd+"] "+ excelDataList.get(i).getStrNm() + " : OK");
				// commit
			}
			else
			{
				// roolback 모든 테이블 지우기
				HashMap<String, Object> deleteParam1 = new HashMap<String, Object>();
				deleteParam1.put("strCd", strCd );
				deleteParam1.put("tableFlag", 1);
				excelUtilSvc.deleteInfoDB( deleteParam1 );
				
				HashMap<String, Object> deleteParam2 = new HashMap<String, Object>();
				deleteParam2.put("strCd", strCd );
				deleteParam2.put("tableFlag", 2);
				excelUtilSvc.deleteInfoDB( deleteParam2 );
				
				HashMap<String, Object> deleteParam3 = new HashMap<String, Object>();
				deleteParam3.put("strCd", strCd );
				deleteParam3.put("tableFlag", 3);
				excelUtilSvc.deleteInfoDB( deleteParam3 );
				
				HashMap<String, Object> deleteParam4 = new HashMap<String, Object>();
				deleteParam4.put("strCd", strCd );
				deleteParam4.put("tableFlag", 4);
				excelUtilSvc.deleteInfoDB( deleteParam4 );
				
				HashMap<String, Object> deleteParam5 = new HashMap<String, Object>();
				deleteParam5.put("strCd", strCd );
				deleteParam5.put("tableFlag", 5);
				excelUtilSvc.deleteInfoDB( deleteParam5 );
				
				HashMap<String, Object> deleteParam6 = new HashMap<String, Object>();
				deleteParam6.put("strCd", strCd );
				deleteParam6.put("tableFlag", 6);
				excelUtilSvc.deleteInfoDB( deleteParam6 );
				
				excelDataList.get(i).setAllDataDB( "x" );
				
				LOGGER.info("["+strCd+"] "+ excelDataList.get(i).getStrNm() + " : --");
				LOGGER.info( result1 + " / " + result2 + " / " + result3 + " / " + result4 + " / " + result5 + " / " +  result6 );
				
			}
			
		
			
		}
		
		
		return excelDataList;
		
	}
	
	
	*/
	
}
	
	
	
	
	
	
	
	
	
	
	
	
