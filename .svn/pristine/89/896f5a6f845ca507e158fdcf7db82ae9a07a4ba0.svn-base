package rems.system.ctrl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import rems.system.model.GridStoreMgntVo;
import rems.system.model.GwVo;
import rems.system.model.InfoInvDataVo;
import rems.system.model.InfoStrConfDataVo;
import rems.system.model.InfoTemonDataVo;
import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;
import rems.system.service.DemandPowerExcelUtilSvc;
import rems.system.service.GwMgntSvc;
import rems.system.service.RemsConfigMgntSvc;
import rems.system.service.RemsDeviceMgntSvc;
import rems.system.service.StoreFcltyMgntSvc;
import rems.system.service.StoreInverterMgntSvc;
import rems.system.service.StoreMgntSvc;
import rems.system.service.UserMgntSvc;
import rems.util.ExcelWriter;

@Controller
@SessionAttributes("sessionUserVo")
public class StoreMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(StoreMgntCtrl.class);

	@Autowired
	private CommonSvc commonSvc;				// 공통
	
	@Autowired
	private UserMgntSvc userMgntSvc;			
		
	@Autowired
	private StoreMgntSvc storeMgntSvc;							// th_str_info_mst
	
	@Autowired
	private GwMgntSvc gwMgntSvc;								// th_gw_mst
		
	@Autowired
	private RemsDeviceMgntSvc remsDevicesvc;					// th_str_rems_parts_cnt
	
	@Autowired
	private DemandPowerExcelUtilSvc demandPowerExcelUtilSvc;	// th_electricent_str_map 
	
	@Autowired
	private StoreFcltyMgntSvc StoreFcltyMgntSvc;				// th_str_temp_module
	
	@Autowired
	private StoreInverterMgntSvc storeInverterMgntSvc;			// th_str_inv_hub
	
	@Autowired
	private RemsConfigMgntSvc remsConfigMgntSvc;				// th_str_conf

	/**
	 * 시스템관리 - 마스터관리 - 매장
	 * 
	 * @author JooYoung
	 * @param seesionuserVo : 세션 변수
	 * @param userVo 		: 유저 변수 
	 * @param scrStrNm 		: 조회조건 - 매장명/코드
	 * @param scrUserYn 	: 조회조건 - 사용유무 
	 * @param scrDateFrom 	: 조회조건 - 일시 From
	 * @param scrDateTo 	: 조회조건 - 일시 To
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/4201", method = {RequestMethod.GET, RequestMethod.POST})
	public String showStoreMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute UserVo userVo,			
			@RequestParam(value = "scrStrNm", required = false) 	String scrStrNm,			
			@RequestParam(value = "scrUseYn", required = false) 	String scrUseYn,
			@RequestParam(value = "scrDateFrom", required = false) 	String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) 	String scrDateTo,
			@RequestParam(value = "scrOrgCd", required = false) 	String scrOrgCd,
			@RequestParam(value = "scrOrgNm", required = false) 	String scrOrgNm,
			ModelMap model) {			

		
		LOGGER.info("4201 : " + sessionUserVo.showData() );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		
		
		//회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);		
		int selectVoListCnt = rslt.size();

		model.addAttribute("selectVoListCnt", selectVoListCnt );
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params );
				
		HashMap<String,Object> scr_params = new HashMap<String,Object>();
		scr_params.put( "scrStrNm", 	scrStrNm );			// 매장명/코드 
		scr_params.put( "scrUseYn", 	scrUseYn );			// 사용유무
		scr_params.put( "scrDateFrom", 	scrDateFrom );		// 설치일자 From
		scr_params.put( "scrDateTo", 	scrDateTo );		// 설치일자 To
		scr_params.put( "scrOrgCd", 	scrOrgCd );			// 조직코드
		scr_params.put( "scrOrgNm", 	scrOrgNm );			// 조직명
		
		model.addAttribute("scrValue", scr_params );
		
		return "system/storeMgntMst";		
	}	
	
	/**
	 * 시스템관리 - 마스터관리 - 매장 : 매장 정보 조회
	 * 
	 * @author JooYoung
	 * @param scrCompanyCd 	: 조회조건 - 회사코드
	 * @param scrStrCd 		: 조회조건 - 시스템매장코드
	 * @param scrStrNm 		: 조회조건 - 매장명/코드
	 * @param scrOrgCd 		: 조회조건 - 조직코드
	 * @param scrUseYn 		: 조회조건 - 사용유무
	 * @param scrDateFrom 	: 조회조건 - 일시 From
	 * @param scrDateTo 	: 조회조건 - 일시 To
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveStoreMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridStoreMgntVo> retrieveStoreMgnt(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,			
			@RequestParam(value = "scrUseYn", required = false) String scrUseYn,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrOrgNm", required = false) String scrOrgNm,			
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveStoreMgnt : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );
		params.put( "strCd", scrStrCd );
		params.put( "strNm", scrStrNm );
		params.put( "orgCd", scrOrgCd );
		params.put( "orgNm", scrOrgNm );
		params.put( "useYn", scrUseYn );		
		params.put( "dateFrom", scrDateFrom.replace("-", "") );
		params.put( "dateTo", scrDateTo.replace("-", "") );
				
		List<GridStoreMgntVo> rslt = storeMgntSvc.retrieveRemsStoreMgnt( params );
		
		int records = rslt.size();
		
		GridVo<GridStoreMgntVo> gridVo = new GridVo<GridStoreMgntVo>();
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
	 * 시스템관리 - 마스터관리 - 매장 : 매장코드(viewStrCd) 중복조회
	 * 
	 * @author JooYoung
	 * @param viewStrCd	: 매장코드
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/getViewStrCd", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean getViewStrCd(
			@RequestParam(value = "viewStrCd", required = false) String viewStrCd
			) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "viewStrCd", viewStrCd );
		
		boolean rslt = storeMgntSvc.getViewStrCd(params);		
		return rslt;
	}
	

	/**
	 * 시스템관리 - 마스터관리 - 매장 : 신규매장 등록/수정 페이지
	 * 
	 * @author JooYoung
	 * @param mode 			: 등록/수정 ( NEW : 등록 , MODIFY : 수정 )
	 * @param getStrCd 		: 조회조건 선택매장 시스템코드
	 * @param getViewStrCd 	: 조회조건 선택매장 점포코드
	 * @param scrStrNm 		: 조회조건 매장명/코드
	 * @param scrUseYn 		: 조회조건 사용유무
	 * @param scrDateFrom 	: 조회조건 검색 일자 from
	 * @param scrDateTo 	: 조회조건검색 일자 to
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/storeMgntPop", method = {RequestMethod.GET, RequestMethod.POST})
	public String storemgntMstNew(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute UserVo userVo,
			@RequestParam(value = "mode", required = false) String mode,
			@RequestParam(value = "getStrCd", required = false) String getStrCd,
			@RequestParam(value = "getViewStrCd", required = false) String getViewStrCd,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrUseYn", required = false) String scrUseYn,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrOrgNm", required = false) String scrOrgNm,
			ModelMap model) {

		LOGGER.info("storemgntMstNew" );
		
		// 서치 history 및 수정매장 정보 전송 - 추후 사용
		LOGGER.info("mode : " + mode);
		LOGGER.info("getStrCd : " + getStrCd);
		LOGGER.info("getViewStrCd : " + getViewStrCd);
		LOGGER.info("scrStrNm : " + scrStrNm);
		LOGGER.info("scrUseYn : " + scrUseYn);
		LOGGER.info("scrDateFrom : " + scrDateFrom);
		LOGGER.info("scrDateTo : " + scrDateTo);	
		LOGGER.info("scrOrgCd : " + scrOrgCd);
		LOGGER.info("scrOrgNm : " + scrOrgNm);
		
		// 뒤로가기 History 변수
		HashMap<String,Object> history = new HashMap<String,Object>();
		history.put( "scrStrNm", 			scrStrNm );
		history.put( "scrUseYn", 			scrUseYn );
		history.put( "scrDateFrom", 		scrDateFrom );
		history.put( "scrDateTo", 			scrDateTo );
		history.put( "scrOrgCd", 			scrOrgCd );
		history.put( "scrOrgNm", 			scrOrgNm );
		
		model.addAttribute("history", 	history);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", 			sessionUserVo.getSessionUserId() );			// 사용자 아이디
		params.put( "companyCd", 		sessionUserVo.getSessionCompanyCd() );		// 회사코드
		params.put( "companyNm", 		sessionUserVo.getSessionCompanyNm() );		// 회사명
		params.put( "strCd", 			getStrCd );
		params.put( "viewStrCd", 		getViewStrCd);
		
		
		if( "NEW".equals( mode ) )		// 신규 매장 등록
		{							
			// Get Max strCd
			String strCd = storeMgntSvc.getMaxStrCd(params);
			params.put( "strCd",	strCd );
			
	    	// Get Max gwId - 회사에 국한되지 않음
	    	int gwId = gwMgntSvc.getGwId();
			params.put("gwId", gwId);		
			
			// get electricCd ( select option )
			List<SelectVo> electricEntCd = userMgntSvc.retrieveElectricEntList( params );		
			
			model.addAttribute("mode", mode );			
			model.addAttribute("gwId", gwId);
			model.addAttribute("electricEntCd", electricEntCd);				
			model.addAttribute("storeMgntDtl", params);
			
		}
		if( "MODIFY".equals( mode ) )	// 매장 수정
		{
			// th_str_info_mst 정보 가지고 오기
			GridStoreMgntVo strInfo_rslt = storeMgntSvc.retrieveRemsStoreMgntDtl( params );
			
			// Get Max gwId - 회사에 국한되지 않음
	    	int gwId = gwMgntSvc.getGwId();
			params.put("gwId", gwId);		
			
			// get electricCd ( select option )
			List<SelectVo> electricEntCd = userMgntSvc.retrieveElectricEntList( params );
			
			model.addAttribute("mode", mode );
			model.addAttribute("gwId", gwId);
			model.addAttribute("electricEntCd", electricEntCd);		
			model.addAttribute("storeMgntDtl", strInfo_rslt);			// 매장 정보
			
		}				
		
		//return "system/storeMgntMstNew";
		return "system/storeMgntPop";
	}
	
	/**
	 * 시스템관리 - 마스터관리 - 매장 : 신규매장 등록(저장)
	 * 
	 * @author JooYoung
	 * @param mode 				: 등록/수정 ( NEW : 등록 , MODIFY : 수정 )
	 * @param companyCd 		: 회사코드 
	 * @param strCd 			: 시스템 매장코드
	 * @param viewStrCd 		: 매장코드
	 * @param strNm 			: 매장명
	 * @param addr 				: 주소
	 * @param telNo1 			: 매장번호 1
	 * @param telNo2 			: 매장번호 2
	 * @param telNo3 			: 매장번호 3
	 * @param contDemandPower	: 계약전력
	 * @param strAreaSpec		: 매장면적
	 * @param localAreaCd		: 지역코드
	 * @param localAreaNm		: 지역명
	 * @param useYn_radio		: 매장 사용유무
	 * @param remsStartDt		: 램스 시작일시
	 * @param remsEndDt			: 램스 종료일시
	 * @param gwId				: G/W ID
	 * @param gwAddr			: G/W MAC Address
	 * @param authYn_radio		: 인증여부
	 * @param gwUseYn_radio		: G/W 사용여부
	 * @param meterYn_radio		: 미터수집 사용 유무
	 * @param mainMeterNum		: 메인미터 개수
	 * @param tempMeterNum		: 냉난방미터 개수
	 * @param excldMeterNum		: 예외미터개수 개수
	 * @param haconNum			: 하콘 개수
	 * @param tSensorNum		: 티센서 개수
	 * @param temonNum			: 테몬 개수
	 * @param zigbeeNum			: 지그비 개수
	 * @param almonNum			: 알몬 개수
	 * @param invNum			: 인버터 개수
	 * @param signNum			: 간판 개수
	 * @param electricEntCd		: 전기업체 코드
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/saveStoreNewMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveStoreNewMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute UserVo userVo,
			@RequestParam(value = "mode", required = false) 				String mode,
			@RequestParam(value = "companyCd", required = false) 			String companyCd,
			@RequestParam(value = "strCd", required = false) 				String strCd,
			@RequestParam(value = "viewStrCd", required = false) 			String viewStrCd,
			@RequestParam(value = "strNm", required = false) 				String strNm,
			@RequestParam(value = "addr", required = false) 				String addr,
			@RequestParam(value = "telNo1", required = false) 				String telNo1,
			@RequestParam(value = "telNo2", required = false) 				String telNo2,
			@RequestParam(value = "telNo3", required = false) 				String telNo3,
			@RequestParam(value = "oldContDemandPower", required = false) 	String oldContDemandPower,
			@RequestParam(value = "contDemandPower", required = false) 		String contDemandPower,
			@RequestParam(value = "strAreaSpec", required = false) 			String strAreaSpec,
			@RequestParam(value = "localAreaCd", required = false) 			String localAreaCd,
			@RequestParam(value = "localAreaNm", required = false) 			String localAreaNm,
			@RequestParam(value = "useYn_radio", required = false) 			String strInfouseYn,
			@RequestParam(value = "remsStartDt", required = false) 			String remsStartDt,
			@RequestParam(value = "remsEndDt", required = false) 			String remsEndDt,
			@RequestParam(value = "gwId", required = false) 				int gwId,
			@RequestParam(value = "gwAddr", required = false) 				String gwAddr,
			@RequestParam(value = "authYn_radio", required = false) 		String authYn,
			@RequestParam(value = "gwUseYn_radio", required = false) 		String gwUseYn,
			@RequestParam(value = "meterYn_radio", required = false) 		String meterYn,			
			@RequestParam(value = "mainMeterNum", required = false) 		String mainMeterNum,			
			@RequestParam(value = "tempMeterNum", required = false) 		String tempMeterNum,
			@RequestParam(value = "excldMeterNum", required = false) 		String excldMeterNum,
			@RequestParam(value = "haconNum", required = false) 			String haconNum,
			@RequestParam(value = "tSensorNum", required = false) 			String tSensorNum,
			@RequestParam(value = "temonNum", required = false) 			String temonNum,
			@RequestParam(value = "zigbeeNum", required = false) 			String zigbeeNum,
			@RequestParam(value = "almonNum", required = false) 			String almonNum,
			@RequestParam(value = "invNum", required = false) 				String invNum,
			@RequestParam(value = "signNum", required = false) 				String signNum,
			@RequestParam(value = "electricEntCd", required = false) 		String electricEntCd,			
			BindingResult bindingResult, 
			ModelMap model,			
			HttpSession session) throws Exception {
		
		LOGGER.info("saveStoreNewMgnt : "+sessionUserVo.getSessionStrCd() );
		
		
		// 수정
		if( "MODIFY".equals( mode ) )
		{
			contDemandPower = contDemandPower.replace(",", "");
			remsStartDt = remsStartDt.replace("-", "");
			remsEndDt = remsEndDt.replace("-", "");
			
			if(remsEndDt.equals("")) {
				remsEndDt = null;
			}
			
			String telNo = telNo1 + "-"+ telNo2 +"-"+ telNo3;
			//String telNo = telNo1;
			
			// th_str_info_mst insert 정보 셋팅
			GridStoreMgntVo strInfo_params = new GridStoreMgntVo();
			strInfo_params.setCompanyCd(				companyCd);
			strInfo_params.setStrCd(					strCd);
			strInfo_params.setViewStrCd(				viewStrCd);
			strInfo_params.setStrNm(					strNm);
			strInfo_params.setAddr(						addr);
			strInfo_params.setTelNo(					telNo);
			strInfo_params.setOrgCd(					"");							// 미구현
			strInfo_params.setOldContDemandPower(		oldContDemandPower);
			strInfo_params.setContDemandPower(			contDemandPower);
			strInfo_params.setStrAreaSpec(				strAreaSpec);
			strInfo_params.setLocalAreaCd(				localAreaCd);
			strInfo_params.setLocalAreaNm(				localAreaNm);
			strInfo_params.setUseYn(					strInfouseYn);		
			strInfo_params.setRemsStartDt(				remsStartDt);
			strInfo_params.setRemsEndDt(				remsEndDt);
			strInfo_params.setRegiId( 					sessionUserVo.getSessionUserId() );		
			strInfo_params.setFinalModId( 				sessionUserVo.getSessionUserId() );
			
			
			LOGGER.info( "companyCd : " + companyCd );
			LOGGER.info( "strCd : " + strCd );
			LOGGER.info( "viewStrCd : " + viewStrCd );
			LOGGER.info( "strNm : " + strNm );
			LOGGER.info( "addr : " + addr );
			LOGGER.info( "telNo : " + telNo );
			LOGGER.info( "oldContDemandPower : " + oldContDemandPower );
			LOGGER.info( "contDemandPower : " + contDemandPower );
			LOGGER.info( "strAreaSpec : " + strAreaSpec );
			LOGGER.info( "localAreaCd : " + localAreaCd );
			LOGGER.info( "localAreaNm : " + localAreaNm );
			LOGGER.info( "strInfouseYn : " + strInfouseYn );
			LOGGER.info( "remsStartDt : " + remsStartDt );
			LOGGER.info( "remsEndDt : " + remsEndDt );
			
			
			// th_str_info_mst update 수행
			storeMgntSvc.saveRemsStoreMgnt( strInfo_params );
			
			// th_electricent_str_map 정보 셋팅
			/*HashMap<String,Object> electricInfo_params = new HashMap<String,Object>();		
			electricInfo_params.put( "strCd", strCd);
			int cdp = Integer.valueOf( contDemandPower ) / 1000;	// 소수점 첫째자리 ( kW 표현 )
			electricInfo_params.put( "recommendDemandPower", cdp );
			electricInfo_params.put( "regiId", sessionUserVo.getSessionUserId() );		
			electricInfo_params.put( "finalModId", sessionUserVo.getSessionUserId() );
			
			// th_electricent_str_map Update 수행
			demandPowerExcelUtilSvc.updateElectricEnt(electricInfo_params);*/
			
			// th_str_env_conf_mst 정보 셋팅
			HashMap<String,Object> strenvconfmst_params = new HashMap<String,Object>();		
			strenvconfmst_params.put( "strCd", strCd);
			strenvconfmst_params.put( "confSp", "PEAK_TYPE");
			strenvconfmst_params.put( "confVal", Math.ceil( Integer.valueOf(contDemandPower) / 12));
			strenvconfmst_params.put( "finalModId", sessionUserVo.getSessionUserId() );
			
			// th_str_env_conf_mst Update 수행
			storeMgntSvc.updateEnvConfMst(strenvconfmst_params);
		}
		
		if( "NEW".equals( mode ) )
		{
			
			/*
			 * 매장정보 가공
			 *  
			 * th_str_info_mst					매장정보
			 * th_str_gw_mst					게이트웨이 정보
			 * th_str_rems_device_cnt_mnt		REMS 장비 개수
			 * th_str_rems_device_mst			테몬
			 * th_str_inv_hub_mst				인버터
			 * th_electricent_str_map			계약전력 
			 * th_str_env_conf_mst				REMS 환경
			 */			
			contDemandPower = contDemandPower.replace(",", "");
			remsStartDt = remsStartDt.replace("-", "");
			remsEndDt = remsEndDt.replace("-", "");
			
			//String telNo = telNo1 +""+ telNo2 +""+ telNo3;
			String telNo = telNo1;
			
			// th_str_info_mst insert 정보 셋팅
			GridStoreMgntVo strInfo_params = new GridStoreMgntVo();
			strInfo_params.setCompanyCd(				companyCd);
			strInfo_params.setStrCd(					strCd);
			strInfo_params.setViewStrCd(				viewStrCd);
			strInfo_params.setStrNm(					strNm);
			strInfo_params.setAddr(						addr);
			strInfo_params.setTelNo(					telNo);
			strInfo_params.setOrgCd(					"");							// 미구현
			strInfo_params.setOldContDemandPower(		contDemandPower);
			strInfo_params.setContDemandPower(			contDemandPower);
			strInfo_params.setStrAreaSpec(				strAreaSpec);
			strInfo_params.setLocalAreaCd(				localAreaCd);
			strInfo_params.setLocalAreaNm(				localAreaNm);
			strInfo_params.setUseYn(					strInfouseYn);		
			strInfo_params.setRemsStartDt(				remsStartDt);
			strInfo_params.setRemsEndDt(				remsEndDt);
			strInfo_params.setRegiId( 					sessionUserVo.getSessionUserId() );		
			strInfo_params.setFinalModId( 				sessionUserVo.getSessionUserId() );
			
			// th_gw_mst insert 정보 셋팅
			GwVo gwInfo_params = new GwVo();
			gwInfo_params.setStrCd(						strCd);
			gwInfo_params.setGwId(						gwId);
			gwInfo_params.setGwAddr(					gwAddr);
			gwInfo_params.setAuthYn(					authYn);
			gwInfo_params.setUseYn(						gwUseYn);
			gwInfo_params.setRegiId( 					sessionUserVo.getSessionUserId() );		
			gwInfo_params.setFinalModId( 				sessionUserVo.getSessionUserId() );
			
			// th_str_rems_parts_cnt 정보 셋팅
			GridRemsDeviceMgntVo remsParts_params = new GridRemsDeviceMgntVo();
			
			remsParts_params.setStrCd(strCd);
			if( "Y".equals( meterYn ) )		// 미터 수집 Yes
			{
				remsParts_params.setMeterCollector(		"1");
				remsParts_params.setMainMeter(			mainMeterNum);
				remsParts_params.setSubMeterTemp(		tempMeterNum);
				remsParts_params.setSubMeterLight(		"0");				// default 
				remsParts_params.setExcldMeter(			excldMeterNum);
			}
			else							// 미터 수집 No
			{
				remsParts_params.setMeterCollector(		"0");
				remsParts_params.setMainMeter(			"0");
				remsParts_params.setSubMeterTemp(		"0");
				remsParts_params.setSubMeterLight(		"0");				// default 
				remsParts_params.setExcldMeter(			"0");
			}
			remsParts_params.setHacon(					haconNum);
			remsParts_params.settSensor(				tSensorNum);
			remsParts_params.setTemon(					temonNum);
			remsParts_params.setAlmon(					almonNum);
			remsParts_params.setZigbee(					zigbeeNum);
			remsParts_params.setSign(					signNum);
			remsParts_params.setInv(					invNum);			
			remsParts_params.setRegiId( 				sessionUserVo.getSessionUserId() );		
			remsParts_params.setFinalModId( 			sessionUserVo.getSessionUserId() );
			
			// th_electricent_str_map 정보 셋팅
			HashMap<String,Object> electricInfo_params = new HashMap<String,Object>();		
			electricInfo_params.put( "userId" ,  				sessionUserVo.getSessionUserId() );
			electricInfo_params.put( "strCd",  					strCd);
			electricInfo_params.put( "strAreaSpec", 			strAreaSpec );
			electricInfo_params.put( "electricEnt" ,  			electricEntCd );
			electricInfo_params.put( "calculateYn", 			"N" );		
			int cdp = Integer.valueOf( contDemandPower ) / 1000;	// 소수점 첫째자리 ( kW 표현 )
			electricInfo_params.put( "demandPower",				cdp );
			electricInfo_params.put( "recommendDemandPower", 	"" );		
			electricInfo_params.put( "regiId",					sessionUserVo.getSessionUserId() );		
			electricInfo_params.put( "finalModId",				sessionUserVo.getSessionUserId() );
			
			
			// th_str_temp_module insert 정보		
			List<InfoTemonDataVo> InfoTemonDataListVo = new ArrayList<InfoTemonDataVo>();		
			for(int i=1; i <= Integer.valueOf( temonNum ); i++)
			{
				for(int k=1; k<=16; k++)
				{
					InfoTemonDataVo infolTemonDataVo = new InfoTemonDataVo();
					
					infolTemonDataVo.setTemonStrCd( 					strCd );
					infolTemonDataVo.setTemonId( 						String.valueOf(i) );
					infolTemonDataVo.setTemonType( 						"T" );
					infolTemonDataVo.setTemonPortNo( 					String.valueOf(k) );
					infolTemonDataVo.setTemonDeviceType( 				"R" );									// default
					infolTemonDataVo.setTemonDeviceLoc( 				"미지정"+ String.valueOf(k) );			// default
					infolTemonDataVo.setTemonContents( 					"" );
					infolTemonDataVo.setTemonMaxTemp( 					"50" );
					infolTemonDataVo.setTemonMinTemp( 					"-50" );
					infolTemonDataVo.setTemonDelayTime( 				"90" );
					infolTemonDataVo.setTemonTempConf( 					"0" );
					infolTemonDataVo.setTemonPushTerm( 					"180" );
					if( k <= 8)
						infolTemonDataVo.setTemonPortUseYn( 				"Y" );
					else
						infolTemonDataVo.setTemonPortUseYn( 				"N" );
					infolTemonDataVo.setTemonRegiId( sessionUserVo.getSessionUserId() );
					infolTemonDataVo.setTemonFinalModId( sessionUserVo.getSessionUserId() );
					InfoTemonDataListVo.add(i-1, infolTemonDataVo);
				}
			}
			
			// th_str_inv_module insert 정보
			List<InfoInvDataVo> InfoInvDataListVo = new ArrayList<InfoInvDataVo>();		
			for(int k=1; k<=8; k++)
			{
				InfoInvDataVo infoInvDataVo = new InfoInvDataVo();
				infoInvDataVo.setInvStrCd( strCd );
				infoInvDataVo.setInvId( "1" );				
				infoInvDataVo.setInvPortNo( String.valueOf(k) );			
				switch(k)
				{
					case 1:	 infoInvDataVo.setInvDeviceType( "W" ); infoInvDataVo.setInvDeviceLoc( "INV_WIC1" ); infoInvDataVo.setInvPortUseYn( "Y" );		break;
					case 2:	 infoInvDataVo.setInvDeviceType( "O" ); infoInvDataVo.setInvDeviceLoc( "INV_OSC1" ); infoInvDataVo.setInvPortUseYn( "Y" );		break;
					case 3:	 infoInvDataVo.setInvDeviceType( "O" ); infoInvDataVo.setInvDeviceLoc( "INV_OSC2" ); infoInvDataVo.setInvPortUseYn( "Y" );		break;
					case 4:	 infoInvDataVo.setInvDeviceType( "O" ); infoInvDataVo.setInvDeviceLoc( "INV_OSC3" ); infoInvDataVo.setInvPortUseYn( "Y" );		break;
					default: infoInvDataVo.setInvDeviceType( "O" ); infoInvDataVo.setInvDeviceLoc( "미지정"+ String.valueOf(k) ); infoInvDataVo.setInvPortUseYn( "N" );		break;
				}			
					
				infoInvDataVo.setInvDeviceContents( "" );				
				infoInvDataVo.setInvPushTerm( "180" );
				
				infoInvDataVo.setInvRegiId( sessionUserVo.getSessionUserId() );
				infoInvDataVo.setInvFinalModId( sessionUserVo.getSessionUserId() );			
				InfoInvDataListVo.add(k-1, infoInvDataVo);
			}		
			
			// th_str_conf insert 정보
			List<InfoStrConfDataVo> InfoStrConfDataListVo = new ArrayList<InfoStrConfDataVo>();
			for(int k=0; k<11; k++)
			{
				InfoStrConfDataVo InfoStrConfDataVo = new InfoStrConfDataVo();	
				switch( k )
				{
					case 0:		// METER_TYPE
						InfoStrConfDataVo.setStrCd( 			strCd );
						InfoStrConfDataVo.setConfSp( 			"METR_TYPE" );
						InfoStrConfDataVo.setConfVal( 			"DT" );
						InfoStrConfDataVo.setStrConfVal( 		"" );
						InfoStrConfDataVo.setStrConfValOld( 	"" );
						InfoStrConfDataVo.setAppdtDt( 			"" );		// now로 대신하여야 함
						InfoStrConfDataVo.setRegiId( 			sessionUserVo.getSessionUserId() );
						InfoStrConfDataVo.setFinalModId( 		sessionUserVo.getSessionUserId() );
						break;
					case 1:		// OPER_ELEC
						InfoStrConfDataVo.setStrCd( 			strCd );
						InfoStrConfDataVo.setConfSp( 			"OPER_ELEC" );
						InfoStrConfDataVo.setConfVal( 			"TM" );
						InfoStrConfDataVo.setStrConfVal( 		"50" );
						InfoStrConfDataVo.setStrConfValOld( 	"50" );
						InfoStrConfDataVo.setAppdtDt( 			"" );
						InfoStrConfDataVo.setRegiId( 			sessionUserVo.getSessionUserId() );
						InfoStrConfDataVo.setFinalModId( 		sessionUserVo.getSessionUserId() );
						break;
					case 2:		// PEAK_TYPE
						InfoStrConfDataVo.setStrCd( 			strCd );
						InfoStrConfDataVo.setConfSp( 			"PEAK_TYPE" );
						InfoStrConfDataVo.setConfVal( 			"P0" );
						InfoStrConfDataVo.setStrConfVal( 		String.valueOf( (int)(Integer.valueOf( contDemandPower ) /12 )) );
						InfoStrConfDataVo.setStrConfValOld( 	String.valueOf( (int)(Integer.valueOf( contDemandPower ) /12 )) );
						InfoStrConfDataVo.setAppdtDt( 			"" );
						InfoStrConfDataVo.setRegiId( 			sessionUserVo.getSessionUserId() );
						InfoStrConfDataVo.setFinalModId( 		sessionUserVo.getSessionUserId() );
						break;
					case 3:		// SIGN_DELY
						InfoStrConfDataVo.setStrCd( 			strCd );
						InfoStrConfDataVo.setConfSp( 			"SIGN_DELY" );
						InfoStrConfDataVo.setConfVal( 			"SD" );
						InfoStrConfDataVo.setStrConfVal( 		"30,-60" );
						InfoStrConfDataVo.setStrConfValOld( 	"30,-60" );
						InfoStrConfDataVo.setAppdtDt( 			"" );
						InfoStrConfDataVo.setRegiId( 			sessionUserVo.getSessionUserId() );
						InfoStrConfDataVo.setFinalModId( 		sessionUserVo.getSessionUserId() );
						break;
					case 4:
						InfoStrConfDataVo.setStrCd( 			strCd );
						InfoStrConfDataVo.setConfSp( 			"SIGN_TYPE" );
						InfoStrConfDataVo.setConfVal( 			"S1" );
						InfoStrConfDataVo.setStrConfVal( 		"18:00,08:00" );
						InfoStrConfDataVo.setStrConfValOld( 	"18:00,08:00" );
						InfoStrConfDataVo.setAppdtDt( 			"" );
						InfoStrConfDataVo.setRegiId( 			sessionUserVo.getSessionUserId() );
						InfoStrConfDataVo.setFinalModId( 		sessionUserVo.getSessionUserId() );
						break;
					case 5:		// TEMP_LEVL C0
						InfoStrConfDataVo.setStrCd( 			strCd );
						InfoStrConfDataVo.setConfSp( 			"TEMP_LEVL" );
						InfoStrConfDataVo.setConfVal( 			"C0" );
						InfoStrConfDataVo.setStrConfVal( 		"-3" );
						InfoStrConfDataVo.setStrConfValOld( 	"-3" );
						InfoStrConfDataVo.setAppdtDt( 			"" );
						InfoStrConfDataVo.setRegiId( 			sessionUserVo.getSessionUserId() );
						InfoStrConfDataVo.setFinalModId( 		sessionUserVo.getSessionUserId() );
						break;
					case 6:		// TEMP_LEVL C1					
						InfoStrConfDataVo.setStrCd( 			strCd );
						InfoStrConfDataVo.setConfSp( 			"TEMP_LEVL" );
						InfoStrConfDataVo.setConfVal( 			"C1" );
						InfoStrConfDataVo.setStrConfVal( 		"3" );
						InfoStrConfDataVo.setStrConfValOld( 	"3" );
						InfoStrConfDataVo.setAppdtDt( 			"" );
						InfoStrConfDataVo.setRegiId( 			sessionUserVo.getSessionUserId() );
						InfoStrConfDataVo.setFinalModId( 		sessionUserVo.getSessionUserId() );
						break;
					case 7:		// TEMP_LEVL H0
						InfoStrConfDataVo.setStrCd( 			strCd );
						InfoStrConfDataVo.setConfSp( 			"TEMP_LEVL" );
						InfoStrConfDataVo.setConfVal( 			"H0" );
						InfoStrConfDataVo.setStrConfVal( 		"3" );
						InfoStrConfDataVo.setStrConfValOld( 	"3" );
						InfoStrConfDataVo.setAppdtDt( 			"" );
						InfoStrConfDataVo.setRegiId( 			sessionUserVo.getSessionUserId() );
						InfoStrConfDataVo.setFinalModId( 		sessionUserVo.getSessionUserId() );
						break;
					case 8:		// TEMP_LEVL H1
						InfoStrConfDataVo.setStrCd( 			strCd );
						InfoStrConfDataVo.setConfSp( 			"TEMP_LEVL" );
						InfoStrConfDataVo.setConfVal( 			"H1" );
						InfoStrConfDataVo.setStrConfVal( 		"-3" );
						InfoStrConfDataVo.setStrConfValOld( 	"-3" );
						InfoStrConfDataVo.setAppdtDt( 			"" );
						InfoStrConfDataVo.setRegiId( 			sessionUserVo.getSessionUserId() );
						InfoStrConfDataVo.setFinalModId( 		sessionUserVo.getSessionUserId() );
						break;
					case 9:		// TEMP_TYPE
						InfoStrConfDataVo.setStrCd( 			strCd );
						InfoStrConfDataVo.setConfSp( 			"TEMP_TYPE" );
						InfoStrConfDataVo.setConfVal( 			"T0" );
						InfoStrConfDataVo.setStrConfVal( 		"24" );			// 12개월 권고 온도로 셋팅
						InfoStrConfDataVo.setStrConfValOld( 	"24" );			// 12개월 권고 온도로 셋팅
						InfoStrConfDataVo.setAppdtDt( 			"" );
						InfoStrConfDataVo.setRegiId( 			sessionUserVo.getSessionUserId() );
						InfoStrConfDataVo.setFinalModId( 		sessionUserVo.getSessionUserId() );
						break;
					case 10:	// TEMP_WIND
						InfoStrConfDataVo.setStrCd( 			strCd );
						InfoStrConfDataVo.setConfSp( 			"TEMP_WIND" );
						InfoStrConfDataVo.setConfVal( 			"L1" );
						InfoStrConfDataVo.setStrConfVal( 		"" );
						InfoStrConfDataVo.setStrConfValOld( 	"" );
						InfoStrConfDataVo.setAppdtDt( 			"" );
						InfoStrConfDataVo.setRegiId( 			sessionUserVo.getSessionUserId() );
						InfoStrConfDataVo.setFinalModId( 		sessionUserVo.getSessionUserId() );
						break;							
				}
				InfoStrConfDataListVo.add(k, InfoStrConfDataVo);			
			}
			
			
			
			/*
			 * 매장입력 Database Insert 수행
			 *  
			 * th_str_info_mst					매장정보
			 * th_str_gw_mst					게이트웨이 정보
			 * th_str_rems_device_cnt_mnt		REMS 장비 개수
			 * th_str_rems_device_mst			테몬
			 * th_str_inv_hub_mst				인버터
			 * th_electricent_str_map			계약전력 
			 * th_str_env_conf_mst				REMS 환경
			 */			
			
			
			try{
				// th_str_info_mst Insert 수행
				boolean strInfo_rslt = storeMgntSvc.saveRemsStoreMgnt_init( strInfo_params );		
				
				// th_gw_mst Insert 수행
				boolean gwInfo_rslt = gwMgntSvc.saveGWMgnt( gwInfo_params );		
				
				// th_str_rems_parts_cnt Insert 수행
				boolean remsParts_rslt = remsDevicesvc.saveStoreRemsMgnt( remsParts_params );
				
				// th_electricent_str_map Insert 수행
				int electricent_rslt = demandPowerExcelUtilSvc.saveElectricEnt_init(electricInfo_params);		
				
				// th_str_temp_module Insert 수행		
				HashMap<String, Object> temonParam = new HashMap<String, Object>();
				temonParam.put( "InfoTemonDataListVo", InfoTemonDataListVo );	
				int temonInfo_rslt = StoreFcltyMgntSvc.saveStoreFcltyMgnt_init( temonParam );
				
				// th_str_inv_hub Insert 수행
				HashMap<String, Object> invParam = new HashMap<String, Object>();
				invParam.put( "InfoInvDataListVo", InfoInvDataListVo );	
				int invInfo_rslt = storeInverterMgntSvc.saveStoreInverterMgnt_init( invParam );
				
				// th_str_conf Insert 수행
				HashMap<String, Object> strConfParam = new HashMap<String, Object>();
				strConfParam.put( "InfoStrConfDataListVo", InfoStrConfDataListVo );	
				int strConfInfo_rslt = remsConfigMgntSvc.saveConfigMgnt_init(strConfParam );
				
				//간판 수동제어 로직 적용
				int strSignManualInfo_rslt = storeMgntSvc.saveSignManualCtrlInfo_init( strInfo_params );
				//간판 수동제어 로직 적용
				
				
				System.out.println( "strInfo_rslt : " + 	strInfo_rslt );
				System.out.println( "gwInfo_rslt : " + 		gwInfo_rslt );
				System.out.println( "remsParts_rslt : " + 	remsParts_rslt );
				System.out.println( "electricent_rslt : " + electricent_rslt );
				System.out.println( "temonInfo_rslt : " +	temonInfo_rslt );
				System.out.println( "invInfo_rslt : " + 	invInfo_rslt );
				System.out.println( "strConfInfo_rslt : " + strConfInfo_rslt );
				System.out.println( "strSignManualInfo_rslt : " + strSignManualInfo_rslt );
			
			}catch(Exception e)
			{
				HashMap<String,Object> params = new HashMap<String,Object>();
				params.put( "strCd", strCd );
				storeMgntSvc.delRemsStoreMgnt( params );
				storeMgntSvc.delSignManualCtrlInfo( params );
				gwMgntSvc.delGWMgnt( params );
				remsDevicesvc.delStoreRemsMgnt( params );
				demandPowerExcelUtilSvc.delElectricEnt( params );
				StoreFcltyMgntSvc.delStoreFcltyMgnt( params );
				storeInverterMgntSvc.delStoreInverterMgnt( params );
				remsConfigMgntSvc.delConfigMgnt(params );
				
				return false;
			}
			
		}
		return true;
	}

	@RequestMapping(value = "/downloadStoreExcel", method = {RequestMethod.GET, RequestMethod.POST})
	public void downloadStoreExcel (
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,			
			@RequestParam(value = "scrUseYn", required = false) String scrUseYn,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrOrgNm", required = false) String scrOrgNm,
			HttpServletResponse response) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", scrCompanyCd );
		params.put( "strCd", scrStrCd );
		params.put( "strNm", scrStrNm );
		params.put( "orgCd", scrOrgCd );
		params.put( "orgNm", scrOrgNm );
		params.put( "useYn", scrUseYn );		
		params.put( "dateFrom", scrDateFrom.replace("-", "") );
		params.put( "dateTo", scrDateTo.replace("-", "") );
		
		//셀렉트한 리스트는 HashMap 타입
		List rslt = storeMgntSvc.retrieveExcelRemsStoreList( params );
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\SEMS_EXCEL\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "매장정보_"+ dTime +".xls";				//파일명
		String sheetNm = "매장정보";				//엑셀 시트명
		
		String arrColNm[] = new String[11]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "매장코드";
		arrColNm[1] = "매장명";
		arrColNm[2] = "조직명";
		arrColNm[3] = "계약전력";
		arrColNm[4] = "사용여부";
		arrColNm[5] = "셈스시작일자";
		arrColNm[6] = "유지보수업체";
		arrColNm[7] = "전기업체";
		arrColNm[8] = "주소";
		arrColNm[9] = "전화번호";
		arrColNm[10] = "매장크기";
		
		String arrDbColNm[] = new String[11]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0] = "viewStrCd";
		arrDbColNm[1] = "strNm";
		arrDbColNm[2] = "orgNm";
		arrDbColNm[3] = "contDemandPower";
		arrDbColNm[4] = "useYn";
		arrDbColNm[5] = "remsStartDt";
		arrDbColNm[6] = "vendorNm";
		arrDbColNm[7] = "electricNm";
		arrDbColNm[8] = "addr";
		arrDbColNm[9] = "telNo";
		arrDbColNm[10] = "strAreaSpec";
		
		String alignType[] = new String[11]; //엑셀데이터 각컬럼별 정렬방향
		alignType[0] = "center";
		alignType[1] = "center";
		alignType[2] = "center";
		alignType[3] = "center";
		alignType[4] = "center";
		alignType[5] = "center";
		alignType[6] = "center";
		alignType[7] = "center";
		alignType[8] = "center";
		alignType[9] = "center";
		alignType[10] = "center";
	
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
