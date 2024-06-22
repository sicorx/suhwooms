package rems.management.ctrl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import net.sf.json.JSONArray;
import rems.common.model.GridVo;
import rems.management.model.CloseDataVo;
import rems.management.model.GridBleVo;
import rems.management.service.BleMgntSvc;
import rems.system.model.GridStoreMgntVo;


@Controller
@SessionAttributes("sessionUserVo")
public class BleMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(BleMgntCtrl.class);

	@Autowired
	private BleMgntSvc svc;
		

	@RequestMapping(value = "/BleMgnt", method = {RequestMethod.GET, RequestMethod.POST})
	public String showAuthMgnt(			
			ModelMap model) {

		LOGGER.info("retrieveBleMgnt : " );
		
		/*
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
				
		*/
		
		return "management/bleMgntMst";
	}
	
	
	
	
	
	@RequestMapping(value = "/retrieveBleMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridBleVo> retrieveBleMgnt(			
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord,
			
			@RequestParam(value = "scrStrNm", 			required = false) String strNm,				
			@RequestParam(value = "scrStrCd", 			required = false) String strCd,
			@RequestParam(value = "scrReadyDt", 		required = false) String readyDt,
			@RequestParam(value = "scrStartDt", 		required = false) String startDt,
			
			@RequestParam(value = "scrElecCheck", 		required = false) String elecCheck,
			@RequestParam(value = "scrSensorCheck", 	required = false) String sensorCheck,
			@RequestParam(value = "scrNetworkCheck", 	required = false) String networkCheck,
			@RequestParam(value = "scrSignCheck", 		required = false) String signCheck,				
			@RequestParam(value = "checkSuccess", 		required = false) String checkSuccess,
			
			@RequestParam(value = "elecVendorNm", 		required = false) String elecVendorNm,
			@RequestParam(value = "sensorVendorNm", 	required = false) String sensorVendorNm,
			@RequestParam(value = "networkVendorNm", 	required = false) String networkVendorNm,
			@RequestParam(value = "signVendorNm", 		required = false) String signVendorNm			
			) {
		
		LOGGER.info("retrieveBleMgnt : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		
		/*
		params.put( "strCd" , 			strCd );			// 매장명
		params.put( "readyDt", 			readyDt );			// 준공일
		params.put( "startDt", 			startDt );			// 착공일
		params.put( "elecCheck", 		elecCheck);			// 전기업체 확인
		params.put( "sensorCheck", 		sensorCheck);		// 냉장비업체 확인
		params.put( "networkCheck", 	networkCheck);		// 시스네트업체 확인
		params.put( "errorCheck", 		errorCheck);		// 에러유무
		params.put( "tnmCheck", 		tnmCheck);			// tnm체크 유무
		params.put( "vendorCd", 		vendorCd);			// 업체코드
		*/
		
		if( strNm == null)	strNm = "";
		if( strCd == null)	strCd = "";
		if( readyDt == null)	readyDt = "";
		if( startDt == null)	startDt = "";
		if( elecCheck == null)	elecCheck = "";
		if( sensorCheck == null)	sensorCheck = "";
		if( networkCheck == null)	networkCheck = "";
		if( signCheck == null)	signCheck = "";
		if( checkSuccess == null)	checkSuccess = "";
		if( elecVendorNm == null)	elecVendorNm = "";
		if( sensorVendorNm == null)	sensorVendorNm = "";
		if( networkVendorNm == null)	networkVendorNm = "";
		if( signVendorNm == null)	signVendorNm = "";
		
		params.put( "strNm", 			"%"+strNm+"%");					// 
		params.put( "strCd" , 			"%"+strCd+"%");					//
		params.put( "readyDt", 			"%"+readyDt+"%" );				// 
		params.put( "startDt", 			"%"+startDt+"%" );				// 
		
		params.put( "elecCheck", 		"%"+elecCheck+"%");				// 
		params.put( "sensorCheck", 		"%"+sensorCheck+"%");			// 
		params.put( "networkCheck", 	"%"+networkCheck+"%");			// 
		params.put( "signCheck", 		"%"+signCheck+"%");				// 
		params.put( "checkSuccess", 	"%"+checkSuccess+"%");			// 
				
		params.put( "elecVendorNm",		"%"+elecVendorNm+"%");			// 
		params.put( "sensorVendorNm",	"%"+sensorVendorNm+"%");		// 
		params.put( "networkVendorNm",	"%"+networkVendorNm+"%");		// 
		params.put( "signVendorNm",		"%"+signVendorNm+"%");			// 
		
		
		
		List<GridBleVo> rslt = svc.retrieveBleMgnt( params );
		
		
		
		
		
		int records = rslt.size();
		
		
		
		GridVo<GridBleVo> gridVo = new GridVo<GridBleVo>();
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		return gridVo;
	}
	
	
	
	
	
	@RequestMapping(value = "/bleMgntMstPop", method = {RequestMethod.GET, RequestMethod.POST})
	public String storemgntMstNew(			
			@RequestParam(value = "strCd", required = false) 			String strCd,			
			@RequestParam(value = "strNm", required = false) 			String strNm,
			
			@RequestParam(value = "elecNotiDate", required = false) 	String elecNotiDate,
			@RequestParam(value = "sensorNotiDate", required = false) 	String sensorNotiDate,
			@RequestParam(value = "networkNotiDate", required = false) 	String networkNotiDate,
			@RequestParam(value = "signNotiDate", required = false) 	String signNotiDate,
			
			
			ModelMap model) {

		LOGGER.info("bleMgntMstPop" );
		
		System.out.println( " pop : pop : " +  strCd);
		System.out.println( " pop : pop : " +  elecNotiDate);
		System.out.println( " pop : pop : " +  sensorNotiDate);
		System.out.println( " pop : pop : " +  networkNotiDate);
		System.out.println( " pop : pop : " +  signNotiDate);
		
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", 				strCd ); 
		params.put( "elecNotiDate", 		elecNotiDate );
		params.put( "sensorNotiDate", 		sensorNotiDate );
		params.put( "networkNotiDate", 		networkNotiDate );
		params.put( "signNotiDate", 		signNotiDate );
		
		List<GridBleVo> elec_rslt = 		svc.retrieveBleMgntElecInfo(params);
		List<GridBleVo> sensor_rslt = 		svc.retrieveBleMgntSensorInfo(params);
		List<GridBleVo> network_rslt = 		svc.retrieveBleMgntNetworkInfo(params);
		List<GridBleVo> sign_rslt = 		svc.retrieveBleMgntSignInfo(params);
		List<GridBleVo> network_ip = 		svc.retrieveBleMgntNetworkIp(params);
		
		
		
		
		//model.addAttribute("elecInfo", 	elec_rslt);

		JSONArray jsonArray = new JSONArray();
		model.addAttribute("elecInfo", 		jsonArray.fromObject(elec_rslt));
		model.addAttribute("sensorInfo", 	jsonArray.fromObject(sensor_rslt));
		model.addAttribute("networkInfo", 	jsonArray.fromObject(network_rslt));
		model.addAttribute("signInfo", 		jsonArray.fromObject(sign_rslt));
		model.addAttribute("networkip", 	jsonArray.fromObject(network_ip));

		
		
		List<GridBleVo> real_data_rslt = 	svc.retrieveRealData(params);
		
		model.addAttribute("realDataInfo", 	jsonArray.fromObject(real_data_rslt));
		
		
		
		
		
		
		
		
		//return "system/storeMgntMstNew";
		return "management/bleMgntMstPop";
	}
	
	
	@RequestMapping(value = "/saveBleCheck", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody int saveBleCheck(
			@RequestParam(value = "strCd", 				required = false) String strCd,
			@RequestParam(value = "strConfVal", 		required = false) String strConfVal,
			@RequestParam(value = "oneContents", 		required = false) String oneContents,	
			@RequestParam(value = "twoContents", 		required = false) String twoContents,
			@RequestParam(value = "threeContents", 		required = false) String threeContents,
			@RequestParam(value = "fourContents", 		required = false) String fourContents,
			@RequestParam(value = "etcContents", 		required = false) String etcContents,
			@RequestParam(value = "checkSuccess", 		required = false) String checkSuccess ) {
		
		LOGGER.info("saveBleCheck : ");
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		
		params.put( "strCd" , 					strCd );				// 매장코드
		params.put( "strConfVal" , 				strConfVal );			// 영업시간
		params.put( "oneContents" , 			oneContents );			// 착공점검
		params.put( "twoContents" , 			twoContents );			// 중간점검
		params.put( "threeContents" , 			threeContents );		// 준공점검
		params.put( "fourContents" , 			fourContents );			// 오픈점검
		params.put( "etcContents" , 			etcContents );			// 비고
		params.put( "checkSuccess" , 			checkSuccess );			// TnM 확인 유무
		
		int rslt = svc.saveBleCheck( params );
		
		//int operRslt = svc.saveSignOper( params );  //에러 주석처리
		
		if( "Y".equalsIgnoreCase( checkSuccess ) )
		{	
				
			GridBleVo get_rslt = svc.retrieveCloseCntMst( params ); 
			
			params.put("mac", get_rslt.getMac());
			
			// th_str_conf insert 정보
			List<CloseDataVo> closeDataVoList = new ArrayList<CloseDataVo>();
			for(int k=0; k<10; k++)
			{
				CloseDataVo closeDataVo = new CloseDataVo();
				closeDataVo.setStrCd(			get_rslt.getStrCd());
				closeDataVo.setMac(				get_rslt.getMac());
				
				
				
				switch( k )
				{
					case 0:		// CT 개수						
						closeDataVo.setItemType(		"GW");
						closeDataVo.setCnt(				get_rslt.getGwCnt());					
						
						break;
					case 1:		// BX 개수						
						closeDataVo.setItemType(		"BX");
						closeDataVo.setCnt(				get_rslt.getBoxCnt());
						break;	
					case 2:		// CT 개수						
						closeDataVo.setItemType(		"CT");
						closeDataVo.setCnt(				get_rslt.getCtCnt());
						break;
					case 3:		// 미터 개수						
						closeDataVo.setItemType(		"DM");
						closeDataVo.setCnt(				get_rslt.getMeterCnt());
						break;
					case 4:		// 시스네트 설치비(시스네트)						
						closeDataVo.setItemType(		"FE");
						closeDataVo.setCnt(				get_rslt.getSisnetCnt());
						break;
					case 5:		// 하콘 개수						
						closeDataVo.setItemType(		"HA");
						closeDataVo.setCnt(				get_rslt.getHaconCnt());
						break;
					case 6:		// 티센서 개수						
						closeDataVo.setItemType(		"TS");
						closeDataVo.setCnt(				get_rslt.gettSensorCnt());
						break;
					case 7:		// 테몬 개수						
						closeDataVo.setItemType(		"TM");
						closeDataVo.setCnt(				get_rslt.getTemonCnt());
						break;
					case 8:		// 온도줄 센서		
						closeDataVo.setItemType(		"LS");
						closeDataVo.setCnt(				get_rslt.getTempSensorCnt());
						break;
					case 9:		// SW 라이센스
						closeDataVo.setItemType(		"SW");
						closeDataVo.setCnt(				get_rslt.getSwCnt());
						break;
				}
				closeDataVo.setREGI_ID(			"SEMS2.0");
				closeDataVo.setFINAL_MOD_ID(	"SEMS2.0");
				closeDataVoList.add(k, closeDataVo);			
				
				
			}

			
			
			long time = System.currentTimeMillis();
			SimpleDateFormat ctime = new SimpleDateFormat("yyyyMM");
			String yyyymm = ctime.format(new Date(time));
			
			HashMap<String, Object> cntParams = new HashMap<String, Object>();
			cntParams.put( "strCd", strCd );			
			cntParams.put( "closingYm", yyyymm );
			cntParams.put( "closeDataVo", closeDataVoList );	
			
			svc.saveCloseDataDetail( cntParams );			
			svc.saveCloseData( cntParams );
			
			
			svc.saveCloseBase( params );
			svc.saveCloseBaseDetail( cntParams );			
			
			
		}

			
		
		
		
		
		

		return rslt;
	}
	
	
}
