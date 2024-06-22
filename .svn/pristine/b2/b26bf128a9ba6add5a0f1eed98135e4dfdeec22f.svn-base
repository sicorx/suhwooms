package rems.system.ctrl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import rems.common.model.GridVo;
import rems.common.model.SelectVo;
import rems.common.service.CommonSvc;
import rems.system.model.GridRemsDeviceMgntVo;
import rems.system.model.RemsConfigMgntVo;
import rems.system.model.RemsConfigMstVo;
import rems.system.model.SessionUserVo;
import rems.system.service.RemsConfigMgntSvc;
import rems.util.ExcelWriter;
import rems.util.TimezoneUtils;

@Controller
@SessionAttributes("sessionUserVo")
public class RemsConfigMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(RemsConfigMgntCtrl.class);

	@Autowired
	private RemsConfigMgntSvc remsConfigMgntSvc;
	
	@Autowired
	private CommonSvc commonSvc;

	/**
	 * 시스템관리 - 솔루션관리 - 램스환경
	 * 
	 * @author JooYoung
	 * @param seesionuserVo : 세션 변수 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/4403", method = {RequestMethod.GET, RequestMethod.POST})
	public String showUserMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrOrgNm", required = false) String scrOrgNm,			
			ModelMap model) {

		LOGGER.info("selectVoList" );
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		
		//회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt.size();
		
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoListCnt", selectVoListCnt );
		
		HashMap<String,Object> scr_params = new HashMap<String,Object>();
		scr_params.put( "scrStrNm", 	scrStrNm );			// 매장명/코드
		scr_params.put( "scrOrgCd", 	scrOrgCd );			// 조직코드
		scr_params.put( "scrOrgNm", 	scrOrgNm );			// 조직명
		
		model.addAttribute("scrValue", scr_params );
		
		return "system/remsConfigMgnt";
	}
	

	/**
	 * 메서드의 기능설명은 한 두줄로 간결하게..
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveRemsConfigDataList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<RemsConfigMgntVo> retrieveRemsConfigDataList(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrOrgNm", required = false) String scrOrgNm,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveRemsConfigDataList : " + scrCompanyCd + ", " + scrOrgCd + ", " + scrStrCd);
		LOGGER.info("retrieveRemsConfigDataList : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );
		params.put( "strCd", scrStrCd );		
		params.put( "strNm", scrStrNm );
		params.put( "orgCd", scrOrgCd );
		params.put( "OrgNm", scrOrgNm );
		
		List<RemsConfigMgntVo> rslt = remsConfigMgntSvc.retrieveRemsConfigDataList( params );
		
		int records = rslt.size();
		
		GridVo<RemsConfigMgntVo> gridVo = new GridVo<RemsConfigMgntVo>();
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		
		return gridVo;
	}
	
	
	/**
	 * 램스 환경 정보 수정
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/remsConfigMgntPop", method = {RequestMethod.GET, RequestMethod.POST})
	public String remsConfigDataMgntNew(
			@RequestParam(value = "strCd", required = false) 		String strCd,
			@RequestParam(value = "viewStrCd", required = false) 	String viewStrCd,
			@RequestParam(value = "strNm", required = false) 		String strNm,			
			@RequestParam(value = "companyCd", required = false) 	String companyCd,
			@RequestParam(value = "companyNm", required = false) 	String companyNm,	
			@RequestParam(value = "scrStrNm", required = false) 	String scrStrNm,			
			@RequestParam(value = "scrOrgCd", required = false) 	String scrOrgCd,
			@RequestParam(value = "scrOrgNm", required = false) 	String scrOrgNm,
			ModelMap model) {
		
		LOGGER.info("remsConfigDataMgntPop" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		params.put( "viewStrCd", viewStrCd );
		params.put( "strNm", strNm );
		params.put( "companyCd", companyCd );
		params.put( "companyNm", companyNm );
		
		// 뒤로가기 History 변수
		HashMap<String,Object> history = new HashMap<String,Object>();
		history.put( "scrStrNm", 			scrStrNm );		
		history.put( "scrOrgCd", 			scrOrgCd );
		history.put( "scrOrgNm", 			scrOrgNm );
		
		model.addAttribute("history", 	history);
		
		RemsConfigMstVo vo = new RemsConfigMstVo();
		vo = remsConfigMgntSvc.retrieveRemsConfMst();
		
		model.addAttribute("companyCd", companyCd);
		model.addAttribute("companyNm", companyNm);
		model.addAttribute("rcmVo", vo);
		model.addAttribute("userVo", params);
		
		int gwId = Integer.valueOf( strCd.substring(3));
		
		System.out.println("GWID : " + gwId );
		
		if( gwId < 4000 )
			return "system/remsConfigMgntPop15";
		else
			return "system/remsConfigMgntPop";
	}
	
	@RequestMapping(value = "/retrieveStoreContractPower", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String retrieveStoreContractPower(
			@RequestParam(value = "strCd", required = false) String strCd,
			ModelMap model) {
		
		LOGGER.info("retrieveStoreContractPower" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		
		String rslt = remsConfigMgntSvc.retrieveStoreContractPower(params);
		
		return rslt;
	}
	@RequestMapping(value = "/retrieveRemsConfigParticularData", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody RemsConfigMgntVo retrieveRemsConfigParticularData(
			@RequestParam(value = "strCd", required = false) String strCd,
			@RequestParam(value = "mode", required = false) String mode,
			ModelMap model) {
		
		LOGGER.info("retrieveRemsConfigParticularData" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		params.put( "confSp", mode );
		
		RemsConfigMgntVo rcmVo = new RemsConfigMgntVo();
		
		rcmVo = remsConfigMgntSvc.retrieveRemsConfigParticularData(params);
		
		return rcmVo;
	}
	
	@RequestMapping(value = "/retrieveRemsConfigTempLevelData", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody RemsConfigMstVo retrieveRemsConfigTempLevelData(
			@RequestParam(value = "strCd", required = false) String strCd,
			@RequestParam(value = "mode", required = false) String mode,
			ModelMap model) {
		
		LOGGER.info("retrieveRemsConfigTempLevelData" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		params.put( "confSp", mode );
		
		RemsConfigMstVo rcmVo = new RemsConfigMstVo();
		
		rcmVo = remsConfigMgntSvc.retrieveRemsConfigTempLevelData(params);

		return rcmVo;
	}
	
	@RequestMapping(value = "/retrieveStoreRemsPart", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody GridRemsDeviceMgntVo retrieveStoreRemsPart(
			@RequestParam(value = "strCd", required = false) String strCd,
			ModelMap model) {
		
		LOGGER.info("retrieveStoreRemsPart" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		
		GridRemsDeviceMgntVo gsrnVo = remsConfigMgntSvc.retrieveStoreRemsPart(params);
		
		return gsrnVo;
	}
	
	/**
	 * 매장 램스환경 정보 수정(저장) SEMS 1.5
	 * 
	 * @author JooYoung
	 * @param companyCd : 회사 코드
	 * @param companyNm : 회사 명
	 * @param strCd : 시스템 점포 코드
	 * @param strNm : 점포 명
	 * @param companyCd : 회사코드
	 * @param companyCd : 회사코드
	 * @param companyCd : 회사코드
	 * @param companyCd : 회사코드
	 * @param companyCd : 회사코드
	 * @param companyCd : 회사코드
	 * @param companyCd : 회사코드 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/saveRemsConfigDataMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveRemsConfigDataMgnt(
			@ModelAttribute("sessionUserVo") 						SessionUserVo sessionUserVo,
			@RequestParam(value = "companyCd", required = false) 	String companyCd,
			@RequestParam(value = "companyNm", required = false) 	String companyNm,
			@RequestParam(value = "strCd", required = false) 		String strCd,
			@RequestParam(value = "strNm", required = false) 		String strNm,						
			@RequestParam(value = "peakMode", required = false) 	String peakMode,
			@RequestParam(value = "peakVal", required = false) 		String peakVal,
			@RequestParam(value = "peakValOld", required = false) 	String peakValOld,
			
			@RequestParam(value = "tempMode", required = false) 	String tempMode,
			@RequestParam(value = "tempVal", required = false) 		String tempVal,			
			@RequestParam(value = "tempValOld", required = false) 	String tempValOld,			
			@RequestParam(value = "tempOper", required = false) 	String tempOper,
			@RequestParam(value = "tempOperOld", required = false) 	String tempOperOld,
			@RequestParam(value = "c0", required = false) 			String c0,
			@RequestParam(value = "c1", required = false) 			String c1,
			@RequestParam(value = "h0", required = false) 			String h0,
			@RequestParam(value = "h1", required = false) 			String h1,
			@RequestParam(value = "c0Old", required = false) 		String c0Old,
			@RequestParam(value = "c1Old", required = false) 		String c1Old,
			@RequestParam(value = "h0Old", required = false) 		String h0Old,
			@RequestParam(value = "h1Old", required = false) 		String h1Old,
			
			@RequestParam(value = "signMode", required = false) 	String signMode,
			@RequestParam(value = "signVal", required = false) 		String signVal,
			@RequestParam(value = "signValOld", required = false) 	String signValOld,
			@RequestParam(value = "signDelay", required = false) 	String signDelay,	
			@RequestParam(value = "signDelayOld", required = false) String signDelayOld,	
			
			
			
			BindingResult bindingResult,
			ModelMap model,
			HttpSession session) throws Exception {
		
		LOGGER.info("saveRemsConfigDataMgnt : "+sessionUserVo.getSessionUserId()+companyCd+companyNm );

		boolean rslt0, rslt1, rslt2, rslt3, rslt4, rslt5, rslt6, rslt7, rslt8, rslt9 = false;		
		
		// 피크데이터 데이터 지우기 ( th_str_conf 테이블 )
		//remsConfigMgntSvc.deleteRemsConfigPaticularData(params);		
		// 계약전력 업데이트 ( th_str_info_mst 테이블 )
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", 			strCd );
		params.put( "peakVal", 			peakVal );
		params.put( "userId", 			sessionUserVo.getSessionUserId() );	
		rslt0 = remsConfigMgntSvc.updateStoreContractPower( params );		
		
		HashMap<String,Object> paramsA = new HashMap<String,Object>();
		
		// 계약전력 업데이트 ( th_str_conf 테이블 )		
		HashMap<String,Object> peakParams = new HashMap<String,Object>();
		peakParams.put( "mode",				"A" );
		peakParams.put( "strCd", 			strCd );
		peakParams.put( "confSp", 			"PEAK_TYPE" );
		peakParams.put( "confVal", 			peakMode );
		peakParams.put( "strConfVal", 		Math.ceil( Integer.valueOf(peakVal) / 12) );
		peakParams.put( "strConfValOld", 	Math.ceil( Integer.valueOf(peakValOld) / 12) );
		peakParams.put( "userId", 			sessionUserVo.getSessionUserId() );	
		
		//rslt1 = remsConfigMgntSvc.saveRemsConfigMgnt( peakParams );
		
		// 냉난방 데이터 지우기 ( th_str_conf 테이블 )
		//remsConfigMgntSvc.deleteRemsConfigPaticularData(params);

		// TEMP TYPE 정보 업데이트
		HashMap<String,Object> tempParams1 = new HashMap<String,Object>();
		tempParams1.put( "mode",			"A" );
		tempParams1.put( "strCd", 			strCd );
		tempParams1.put( "confSp", 			"TEMP_TYPE" );
		tempParams1.put( "confVal", 		tempMode );
		tempParams1.put( "strConfVal", 		tempVal );
		tempParams1.put( "strConfValOld", 	tempValOld );
		tempParams1.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt2 = remsConfigMgntSvc.saveRemsConfigMgnt( tempParams1 );
		
		
	
		
		// OPER ELEC 정보 업데이트
		HashMap<String,Object> tempParams2 = new HashMap<String,Object>();
		tempParams2.put( "mode",			"B" );
		tempParams2.put( "strCd", 			strCd );
		tempParams2.put( "confSp", 			"OPER_ELEC" );
		tempParams2.put( "confVal", 		"TM" );
		tempParams2.put( "strConfVal", 		tempOper );
		tempParams2.put( "strConfValOld", 	tempOperOld );
		tempParams2.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt3 = remsConfigMgntSvc.saveRemsConfigMgnt( tempParams2 );
		
		// TEMP LEVL 냉방 OFF 정보 업데이트
		HashMap<String,Object> tempParams3 = new HashMap<String,Object>();
		tempParams3.put( "mode",			"B" );
		tempParams3.put( "strCd", 			strCd );
		tempParams3.put( "confSp", 			"TEMP_LEVL" );
		tempParams3.put( "confVal", 		"C0" );
		tempParams3.put( "strConfVal", 		c0 );
		tempParams3.put( "strConfValOld", 	c0Old );
		tempParams3.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt4 = remsConfigMgntSvc.saveRemsConfigMgnt( tempParams3 );
		
		
		// TEMP LEVL 냉방 ON 정보 업데이트
		HashMap<String,Object> tempParams4 = new HashMap<String,Object>();
		tempParams4.put( "mode",			"B" );
		tempParams4.put( "strCd", 			strCd );
		tempParams4.put( "confSp", 			"TEMP_LEVL" );
		tempParams4.put( "confVal", 		"C1" );
		tempParams4.put( "strConfVal", 		c1 );
		tempParams4.put( "strConfValOld", 	c1Old );
		tempParams4.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt5 = remsConfigMgntSvc.saveRemsConfigMgnt( tempParams4 );
		
		
		// TEMP LEVL 난방 OFF 정보 업데이트
		HashMap<String,Object> tempParams5 = new HashMap<String,Object>();
		tempParams5.put( "mode",			"B" );
		tempParams5.put( "strCd", 			strCd );
		tempParams5.put( "confSp", 			"TEMP_LEVL" );
		tempParams5.put( "confVal", 		"H0" );
		tempParams5.put( "strConfVal", 		h0 );
		tempParams5.put( "strConfValOld", 	h0Old );
		tempParams5.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt6 = remsConfigMgntSvc.saveRemsConfigMgnt( tempParams5 );
																
		// TEMP LEVL 난방 ON 정보 업데이트
		HashMap<String,Object> tempParams6 = new HashMap<String,Object>();
		tempParams6.put( "mode",			"B" );
		tempParams6.put( "strCd", 			strCd );
		tempParams6.put( "confSp", 			"TEMP_LEVL" );
		tempParams6.put( "confVal", 		"H1" );
		tempParams6.put( "strConfVal", 		h1 );
		tempParams6.put( "strConfValOld", 	h1Old );
		tempParams6.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt7 = remsConfigMgntSvc.saveRemsConfigMgnt( tempParams6 );
		
		// SIGN DELAY 정보 업데이트
		HashMap<String,Object> signParams1 = new HashMap<String,Object>();
		signParams1.put( "mode",			"B" );
		signParams1.put( "strCd", 			strCd );
		signParams1.put( "confSp", 			"SIGN_DELY" );
		signParams1.put( "confVal", 		"SD" );
		signParams1.put( "strConfVal", 		signDelay );
		signParams1.put( "strConfValOld", 	signDelayOld );
		signParams1.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt8 = remsConfigMgntSvc.saveRemsConfigMgnt( signParams1 );
		
		// SIGN TYPE 정보 업데이트
		HashMap<String,Object> signParams2 = new HashMap<String,Object>();
		signParams2.put( "mode",			"A" );
		signParams2.put( "strCd", 			strCd );
		signParams2.put( "confSp", 			"SIGN_TYPE" );
		signParams2.put( "confVal", 		signMode );
		signParams2.put( "strConfVal", 		signVal );
		signParams2.put( "strConfValOld", 	signValOld );
		signParams2.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt9 = remsConfigMgntSvc.saveRemsConfigMgnt( signParams2 );
		
		
		
		// SIGN OPER
		HashMap<String,Object> signParams3 = new HashMap<String,Object>();
		signParams3.put( "mode",			"A" );
		signParams3.put( "strCd", 			strCd );
		signParams3.put( "confSp", 			"SIGN_OPER" );
		signParams3.put( "confVal", 		"L1" );
		signParams3.put( "strConfVal", 		"08:00,08:00" );
		signParams3.put( "strConfValOld", 	"08:00,08:00" );
		signParams3.put( "userId", 			sessionUserVo.getSessionUserId() );
		
		// SIGN STOW 정보 업데이트
		HashMap<String,Object> signParams4 = new HashMap<String,Object>();
		signParams4.put( "mode",			"A" );
		signParams4.put( "strCd", 			strCd );
		signParams4.put( "confSp", 			"SIGN_STOW" );
		signParams4.put( "confVal", 		"SW" );
		signParams4.put( "strConfVal", 		"0,0");
		signParams4.put( "strConfValOld", 	"0,0");
		signParams4.put( "userId", 			sessionUserVo.getSessionUserId() );
		
		// SIGN STOD 정보 업데이트
		HashMap<String,Object> signParams5 = new HashMap<String,Object>();
		signParams5.put( "mode",			"A" );
		signParams5.put( "strCd", 			strCd );
		signParams5.put( "confSp", 			"SIGN_STOD" );
		signParams5.put( "confVal", 		"SD" );
		signParams5.put( "strConfVal", 		"0,0" );
		signParams5.put( "strConfValOld", 	"0,0" );
		signParams5.put( "userId", 			sessionUserVo.getSessionUserId() );
		
		// SIGN STOT
		HashMap<String,Object> signParams6 = new HashMap<String,Object>();
		signParams6.put( "mode",			"A" );
		signParams6.put( "strCd", 			strCd );
		signParams6.put( "confSp", 			"SIGN_STOT" );
		signParams6.put( "confVal", 		"ST" );
		signParams6.put( "strConfVal", 		"0,0" );
		signParams6.put( "strConfValOld", 	"0,0" );
		signParams6.put( "userId", 			sessionUserVo.getSessionUserId() );
		
		
		
		
		paramsA.put("DEMAND_POWER", 	params);
		paramsA.put("PEAK_TYPE", 		peakParams);
		paramsA.put("TEMP_TYPE", 		tempParams1);
		paramsA.put("OPER_ELEC", 		tempParams2);
		paramsA.put("TEMP_LEVL_C0", 	tempParams3);
		paramsA.put("TEMP_LEVL_C1", 	tempParams4);
		paramsA.put("TEMP_LEVL_H0", 	tempParams5);
		paramsA.put("TEMP_LEVL_H1", 	tempParams6);
		paramsA.put("SIGN_DELY", 		signParams1);
		paramsA.put("SIGN_TYPE", 		signParams2);
		
		
		paramsA.put("SIGN_OPER", 		signParams3);
		paramsA.put("SIGN_STOW", 		signParams4);
		paramsA.put("SIGN_STOD", 		signParams5);
		paramsA.put("SIGN_STOT", 		signParams6);
		
		
		boolean rslt = remsConfigMgntSvc.saveRemsConfigMgnt(paramsA);		
		
		
		return rslt;
	}
	
	
	
	/**
	 * 매장 램스환경 정보 수정(저장) SEMS 2.0
	 * 
	 * @author JooYoung
	 * @param companyCd : 회사 코드
	 * @param companyNm : 회사 명
	 * @param strCd : 시스템 점포 코드
	 * @param strNm : 점포 명
	 * @param companyCd : 회사코드
	 * @param companyCd : 회사코드
	 * @param companyCd : 회사코드
	 * @param companyCd : 회사코드
	 * @param companyCd : 회사코드
	 * @param companyCd : 회사코드
	 * @param companyCd : 회사코드 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/saveRemsConfigDataMgnt2", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveRemsConfigDataMgnt2(
			@ModelAttribute("sessionUserVo") 						SessionUserVo sessionUserVo,
			@RequestParam(value = "companyCd", required = false) 	String companyCd,
			@RequestParam(value = "companyNm", required = false) 	String companyNm,
			@RequestParam(value = "strCd", required = false) 		String strCd,
			@RequestParam(value = "strNm", required = false) 		String strNm,						
			@RequestParam(value = "peakMode", required = false) 	String peakMode,
			@RequestParam(value = "peakVal", required = false) 		String peakVal,
			@RequestParam(value = "peakValOld", required = false) 	String peakValOld,
			
			@RequestParam(value = "tempMode", required = false) 	String tempMode,
			@RequestParam(value = "tempVal", required = false) 		String tempVal,
			@RequestParam(value = "tempValOld", required = false) 	String tempValOld,
			@RequestParam(value = "tempOper", required = false) 	String tempOper,
			@RequestParam(value = "tempOperOld", required = false) 	String tempOperOld,
			@RequestParam(value = "c0", required = false) 			String c0,
			@RequestParam(value = "c1", required = false) 			String c1,
			@RequestParam(value = "h0", required = false) 			String h0,
			@RequestParam(value = "h1", required = false) 			String h1,
			@RequestParam(value = "c0Old", required = false) 		String c0Old,
			@RequestParam(value = "c1Old", required = false) 		String c1Old,
			@RequestParam(value = "h0Old", required = false) 		String h0Old,
			@RequestParam(value = "h1Old", required = false) 		String h1Old,
			
			@RequestParam(value = "signMode", required = false) 	String signMode,
			@RequestParam(value = "signVal", required = false) 		String signVal,
			@RequestParam(value = "signValOld", required = false) 	String signValOld,
			@RequestParam(value = "signDelay", required = false) 	String signDelay,
			@RequestParam(value = "signDelayOld", required = false) String signDelayOld,
			
			
			@RequestParam(value = "signOper", required = false) 	String signOper,
			@RequestParam(value = "signOperOld", required = false) 	String signOperOld,
			@RequestParam(value = "signStow", required = false) 	String signStow,
			@RequestParam(value = "signStowOld", required = false) 	String signStowOld,
			@RequestParam(value = "signStod", required = false) 	String signStod,
			@RequestParam(value = "signStodOld", required = false) 	String signStodOld,
			@RequestParam(value = "signStot", required = false) 	String signStot,
			@RequestParam(value = "signStotOld", required = false) 	String signStotOld,
			
			
			
			BindingResult bindingResult,
			ModelMap model,
			HttpSession session) throws Exception {
		
		LOGGER.info("saveRemsConfigDataMgnt : "+sessionUserVo.getSessionUserId()+companyCd+companyNm );

		boolean rslt0, rslt1, rslt2, rslt3, rslt4, rslt5, rslt6, rslt7, rslt8, rslt9 = false;		
		
		// 피크데이터 데이터 지우기 ( th_str_conf 테이블 )
		//remsConfigMgntSvc.deleteRemsConfigPaticularData(params);		
		// 계약전력 업데이트 ( th_str_info_mst 테이블 )
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", 			strCd );
		params.put( "peakVal", 			peakVal );
		params.put( "userId", 			sessionUserVo.getSessionUserId() );	
		rslt0 = remsConfigMgntSvc.updateStoreContractPower( params );		
		
		HashMap<String,Object> paramsA = new HashMap<String,Object>();
		
		// 계약전력 업데이트 ( th_str_conf 테이블 )		
		HashMap<String,Object> peakParams = new HashMap<String,Object>();
		peakParams.put( "mode",				"A" );
		peakParams.put( "strCd", 			strCd );
		peakParams.put( "confSp", 			"PEAK_TYPE" );
		peakParams.put( "confVal", 			peakMode );
		peakParams.put( "strConfVal", 		Math.ceil( Integer.valueOf(peakVal) / 12) );
		peakParams.put( "strConfValOld", 	Math.ceil( Integer.valueOf(peakValOld) / 12) );
		peakParams.put( "userId", 			sessionUserVo.getSessionUserId() );	
		
		//rslt1 = remsConfigMgntSvc.saveRemsConfigMgnt( peakParams );
		
		// 냉난방 데이터 지우기 ( th_str_conf 테이블 )
		//remsConfigMgntSvc.deleteRemsConfigPaticularData(params);

		// TEMP TYPE 정보 업데이트
		HashMap<String,Object> tempParams1 = new HashMap<String,Object>();
		tempParams1.put( "mode",			"A" );
		tempParams1.put( "strCd", 			strCd );
		tempParams1.put( "confSp", 			"TEMP_TYPE" );
		tempParams1.put( "confVal", 		tempMode );
		tempParams1.put( "strConfVal", 		tempVal );
		tempParams1.put( "strConfValOld", 	tempValOld );
		tempParams1.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt2 = remsConfigMgntSvc.saveRemsConfigMgnt( tempParams1 );
		
		
	
		
		// OPER ELEC 정보 업데이트
		HashMap<String,Object> tempParams2 = new HashMap<String,Object>();
		tempParams2.put( "mode",			"B" );
		tempParams2.put( "strCd", 			strCd );
		tempParams2.put( "confSp", 			"OPER_ELEC" );
		tempParams2.put( "confVal", 		"TM" );
		tempParams2.put( "strConfVal", 		tempOper );
		tempParams2.put( "strConfValOld", 	tempOperOld );
		tempParams2.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt3 = remsConfigMgntSvc.saveRemsConfigMgnt( tempParams2 );
		
		// TEMP LEVL 냉방 OFF 정보 업데이트
		HashMap<String,Object> tempParams3 = new HashMap<String,Object>();
		tempParams3.put( "mode",			"B" );
		tempParams3.put( "strCd", 			strCd );
		tempParams3.put( "confSp", 			"TEMP_LEVL" );
		tempParams3.put( "confVal", 		"C0" );
		tempParams3.put( "strConfVal", 		c0 );
		tempParams3.put( "strConfValOld", 	c0Old );
		tempParams3.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt4 = remsConfigMgntSvc.saveRemsConfigMgnt( tempParams3 );
		
		
		// TEMP LEVL 냉방 ON 정보 업데이트
		HashMap<String,Object> tempParams4 = new HashMap<String,Object>();
		tempParams4.put( "mode",			"B" );
		tempParams4.put( "strCd", 			strCd );
		tempParams4.put( "confSp", 			"TEMP_LEVL" );
		tempParams4.put( "confVal", 		"C1" );
		tempParams4.put( "strConfVal", 		c1 );
		tempParams4.put( "strConfValOld", 	c1Old );
		tempParams4.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt5 = remsConfigMgntSvc.saveRemsConfigMgnt( tempParams4 );
		
		
		// TEMP LEVL 난방 OFF 정보 업데이트
		HashMap<String,Object> tempParams5 = new HashMap<String,Object>();
		tempParams5.put( "mode",			"B" );
		tempParams5.put( "strCd", 			strCd );
		tempParams5.put( "confSp", 			"TEMP_LEVL" );
		tempParams5.put( "confVal", 		"H0" );
		tempParams5.put( "strConfVal", 		h0 );
		tempParams5.put( "strConfValOld", 	h0Old );
		tempParams5.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt6 = remsConfigMgntSvc.saveRemsConfigMgnt( tempParams5 );
																
		// TEMP LEVL 난방 ON 정보 업데이트
		HashMap<String,Object> tempParams6 = new HashMap<String,Object>();
		tempParams6.put( "mode",			"B" );
		tempParams6.put( "strCd", 			strCd );
		tempParams6.put( "confSp", 			"TEMP_LEVL" );
		tempParams6.put( "confVal", 		"H1" );
		tempParams6.put( "strConfVal", 		h1 );
		tempParams6.put( "strConfValOld", 	h1Old );
		tempParams6.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt7 = remsConfigMgntSvc.saveRemsConfigMgnt( tempParams6 );
		
		// SIGN DELAY 정보 업데이트
		HashMap<String,Object> signParams1 = new HashMap<String,Object>();
		signParams1.put( "mode",			"B" );
		signParams1.put( "strCd", 			strCd );
		signParams1.put( "confSp", 			"SIGN_DELY" );
		signParams1.put( "confVal", 		"SD" );
		signParams1.put( "strConfVal", 		signDelay );
		signParams1.put( "strConfValOld", 	signDelayOld );
		signParams1.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt8 = remsConfigMgntSvc.saveRemsConfigMgnt( signParams1 );
		
		// SIGN TYPE 정보 업데이트
		HashMap<String,Object> signParams2 = new HashMap<String,Object>();
		signParams2.put( "mode",			"A" );
		signParams2.put( "strCd", 			strCd );
		signParams2.put( "confSp", 			"SIGN_TYPE" );
		signParams2.put( "confVal", 		signMode );
		signParams2.put( "strConfVal", 		signVal );
		signParams2.put( "strConfValOld", 	signValOld );
		signParams2.put( "userId", 			sessionUserVo.getSessionUserId() );
		//rslt9 = remsConfigMgntSvc.saveRemsConfigMgnt( signParams2 );
		
		
		
		// SIGN OPER
		HashMap<String,Object> signParams3 = new HashMap<String,Object>();
		signParams3.put( "mode",			"A" );
		signParams3.put( "strCd", 			strCd );
		signParams3.put( "confSp", 			"SIGN_OPER" );
		signParams3.put( "confVal", 		"L1" );
		signParams3.put( "strConfVal", 		signOper );
		signParams3.put( "strConfValOld", 	signOperOld );
		signParams3.put( "userId", 			sessionUserVo.getSessionUserId() );
		
		// SIGN STOW 정보 업데이트
		HashMap<String,Object> signParams4 = new HashMap<String,Object>();
		signParams4.put( "mode",			"A" );
		signParams4.put( "strCd", 			strCd );
		signParams4.put( "confSp", 			"SIGN_STOW" );
		signParams4.put( "confVal", 		"SW" );
		signParams4.put( "strConfVal", 		signStow);
		signParams4.put( "strConfValOld", 	signStowOld);
		signParams4.put( "userId", 			sessionUserVo.getSessionUserId() );
		
		// SIGN STOD 정보 업데이트
		HashMap<String,Object> signParams5 = new HashMap<String,Object>();
		signParams5.put( "mode",			"A" );
		signParams5.put( "strCd", 			strCd );
		signParams5.put( "confSp", 			"SIGN_STOD" );
		signParams5.put( "confVal", 		"SD" );
		signParams5.put( "strConfVal", 		signStod );
		signParams5.put( "strConfValOld", 	signStodOld );
		signParams5.put( "userId", 			sessionUserVo.getSessionUserId() );
		
		// SIGN STOT
		HashMap<String,Object> signParams6 = new HashMap<String,Object>();
		signParams6.put( "mode",			"A" );
		signParams6.put( "strCd", 			strCd );
		signParams6.put( "confSp", 			"SIGN_STOT" );
		signParams6.put( "confVal", 		"ST" );
		signParams6.put( "strConfVal", 		signStot );
		signParams6.put( "strConfValOld", 	signStotOld );
		signParams6.put( "userId", 			sessionUserVo.getSessionUserId() );
		
		paramsA.put("DEMAND_POWER", 	params);
		paramsA.put("PEAK_TYPE", 		peakParams);
		paramsA.put("TEMP_TYPE", 		tempParams1);
		paramsA.put("OPER_ELEC", 		tempParams2);
		paramsA.put("TEMP_LEVL_C0", 	tempParams3);
		paramsA.put("TEMP_LEVL_C1", 	tempParams4);
		paramsA.put("TEMP_LEVL_H0", 	tempParams5);
		paramsA.put("TEMP_LEVL_H1", 	tempParams6);
		paramsA.put("SIGN_DELY", 		signParams1);
		paramsA.put("SIGN_TYPE", 		signParams2);
		
		paramsA.put("SIGN_OPER", 		signParams3);
		paramsA.put("SIGN_STOW", 		signParams4);
		paramsA.put("SIGN_STOD", 		signParams5);
		paramsA.put("SIGN_STOT", 		signParams6);
		
		
		
		
		boolean rslt = remsConfigMgntSvc.saveRemsConfigMgnt(paramsA);		
		
		
		return rslt;
	}
	
	//엑셀다운로드
	@RequestMapping(value = "/downloadRemsConfigDataListExcel", method = {RequestMethod.GET, RequestMethod.POST})
	public void downloadRemsConfigDataListExcel (
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrOrgNm", required = false) String scrOrgNm,
			HttpServletResponse response) {
		
			HashMap<String,Object> params = new HashMap<String,Object>();
			params.put( "companyCd", scrCompanyCd );			// 회사 코드
			params.put( "strCd", scrStrCd );					// 매장명/코드
			params.put( "StrNm", scrStrNm );					// 조직명(코드)
			params.put( "OrgCd", scrOrgCd );				// 업체 코드
			params.put( "OrgNm", scrOrgNm );					// 엔지니어명/ID
			
		
		//셀렉트한 리스트는 HashMap 타입
		List rslt = remsConfigMgntSvc.downloadRemsConfigDataListExcel( params );
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "렘스환경_"+ dTime +".xls";				//파일명
		String sheetNm = "렘스환경현황";				//엑셀 시트명

		String arrColNm[] = new String[5]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "조직명";
		arrColNm[1] = "매장명";
		arrColNm[2] = "피크";
		arrColNm[3] = "냉난방";
		arrColNm[4] = "간판";

		String arrDbColNm[] = new String[5]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0] = "orgFullNm";
		arrDbColNm[1] = "strNm";
		arrDbColNm[2] = "peakType";
		arrDbColNm[3] = "tempType";
		arrDbColNm[4] = "signType";
		
		String alignType[] = new String[5]; //엑셀데이터 각컬럼별 정렬방향
		alignType[0] = "center";
		alignType[1] = "center";
		alignType[2] = "center";
		alignType[3] = "center";
		alignType[4] = "center";
	
		ExcelWriter.makeExeclData(wb, sheetNm, arrColNm, arrDbColNm, alignType, rslt);
		
		FileOutputStream fileOut = null;
		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;
	
		long time = Calendar.getInstance().getTimeInMillis();
		String realPath = excelRealPath;
		File filePath = new File(realPath);
		if(!filePath.exists()){
			filePath.mkdirs();
		}
		
		String file_name = FileNm;
		OutputStream out = null;
		File fullFilePath = new File(realPath +"/"+ file_name);
		FileInputStream fis = null;
		try{
		
			out = response.getOutputStream();
			
			fileOut = new FileOutputStream(fullFilePath);
			wb.write(fileOut);
			fileOut.close();
			
			response.setHeader("Content-Disposition", "attachment; filename=\""+URLEncoder.encode(FileNm,"UTF-8")+"\";");
			response.setHeader("Content-Transger-Encoding", "binary");
		
			fis = new FileInputStream(fullFilePath);
			FileCopyUtils.copy(fis, out);
			out.flush();
			
			fullFilePath.delete();
		}catch(Exception e){
			LOGGER.error(e.toString());
		}finally{
			if(fis != null){
				try{
					fis.close();
				}catch(Exception e){}
			}
		}
	}
}