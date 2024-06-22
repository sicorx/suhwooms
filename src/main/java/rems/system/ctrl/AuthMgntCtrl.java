package rems.system.ctrl;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import rems.common.model.GridVo;
import rems.common.model.SelectVo;
import rems.common.service.CommonSvc;
import rems.system.model.AuthVo;
import rems.system.model.BleAuthVo;
import rems.system.model.GridStoreMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.service.AuthMgntSvc;
import rems.system.service.StoreMgntSvc;
import rems.util.TimezoneUtils;


@Controller
@SessionAttributes("sessionUserVo")
public class AuthMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(AuthMgntCtrl.class);

	@Autowired
	private AuthMgntSvc svc;
	
	@Autowired
	private CommonSvc commonSvc;
	
	@Autowired
	private StoreMgntSvc storeMgntSvc;							// th_str_info_mst
	
	
	public String de_reqdata2;
	
	@RequestMapping(value = "/4303", method = {RequestMethod.GET, RequestMethod.POST})
	public String showAuthMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {

		LOGGER.info("retrieveAuthMgnt : " + sessionUserVo.showData() );
		
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
				
		return "system/authMgnt";
	}
	
	@RequestMapping(value = "/retrieveAuthMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<HashMap<String, Object>> retrieveRemsAuthMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrCompanyCd", required = false) String companyCd,
			@RequestParam(value = "scrAuthSp", required = false) String authSp,
			@RequestParam(value = "scrUseYn", required = false) String useYn,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveRemsAuthMgnt : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd" , companyCd );
		params.put( "authSp", authSp );
		params.put( "useYn", useYn );
		
		List<HashMap<String, Object>> rslt = svc.retrieveRemsAuthMgnt( params );
		
		int records = rslt.size();
		
		GridVo<HashMap<String, Object>> gridVo = new GridVo<HashMap<String, Object>>();
		gridVo.setRows( rslt );                         										 // 결과값
		gridVo.setPage( String.valueOf( page ) );       										 // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? records : 0 ) ); 						 // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( records / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		
		return gridVo;
	}
	
	@RequestMapping(value = "/authMgntNew", method = {RequestMethod.GET, RequestMethod.POST})
	public String authMgntNew(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "companyNm", required = false) String companyNm,
			ModelMap model) {
		
		LOGGER.info("authMgntNew" );
		
		List<SelectVo> rslt = svc.retrieveAuthSpList();
		
		HashMap<String,String> params = new HashMap<String,String>();
		
		params.put( "companyCd", companyCd );
		params.put( "companyNm", companyNm );
		
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("newYn", "Y" );
		
		return "system/authMgntPop";
	}
	
	@RequestMapping(value = "/getAuthCd", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean getAuthCd(
			@RequestParam(value = "authCd", required = false) String authCd
			) {
		
		LOGGER.info("getAuthCd" );
		
		boolean checkRslt = svc.getAuthCd( authCd );
		
		return checkRslt;
	}

	@RequestMapping(value = "/authMgntDtl", method = {RequestMethod.GET, RequestMethod.POST})
	public String authMgntDtl(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "companyNm", required = false) String companyNm,
			@RequestParam(value = "authCd", required = false) String authCd,
			ModelMap model) {
		
		LOGGER.info("authMgntDtl" );
		
		List<SelectVo> rslt = svc.retrieveAuthSpList();
		
		HashMap<String,String> params = new HashMap<String,String>();
		
		params.put( "companyCd", companyCd );
		params.put( "companyNm", companyNm );
		params.put( "authCd", authCd );
		
		AuthVo authVo = svc.retrieveAuthDtl(params);
		
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("authVo", authVo);
		model.addAttribute("newYn", "N" );
		
		return "system/authMgntPop";
	}
	
	@RequestMapping(value = "/saveAuthMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveAuthMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute AuthVo authVo,
			BindingResult bindingResult
			) {

		LOGGER.info("saveAuthMgnt : ");

		authVo.setRegiId(sessionUserVo.getSessionUserId());
		authVo.setFinalModId(sessionUserVo.getSessionUserId());
		authVo.setNow(TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff()));

		boolean rslt = svc.saveRemsAuthMgnt( authVo );
		LOGGER.info("[rslt      ] ============ "+rslt+" ================");
		
		return rslt;
	}
	
	@RequestMapping(value = "/delAuthMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<HashMap<String, Object>> delAuthMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestBody List<HashMap<String, Object>> params) {

		LOGGER.info("delAuthMgnt : " + params );

		String now = TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() );
		
		svc.delRemsAuthMgnt( params, sessionUserVo.getSessionCompanyCd(), sessionUserVo.getSessionUserId(), now );
		
		GridVo<HashMap<String, Object>> gridVo = new GridVo<HashMap<String, Object>>();
		gridVo.setSuccess( "success" );
		
		return gridVo;
	}	
	
	
	
	/////// 주영 SEMS BLE 매니저 통신 /////////////////
	
	// 매장리스트 보내기
	@RequestMapping(value = "/bleStoreListMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "text/plain;charset=UTF-8")
	public @ResponseBody List<GridStoreMgntVo> bleStoreListMgnt(			
			) {
		
		LOGGER.info("bleStoreList" );
		
		List<GridStoreMgntVo> rslt = svc.retrieveBleStoreList();
		
		LOGGER.info( rslt.get(0).getStrNm() );
		LOGGER.info( rslt.get(0).getStrCd() );
		
		return rslt;
	}
	
	
	// BLE 통신 - 업데이트 확인
	@RequestMapping(value = "/REQ_CHECK_UPDATE", method = {RequestMethod.GET, RequestMethod.POST}, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String REQ_CHECK_UPDATE(			
			@RequestParam(value = "cmd", required = false) String cmd,
			@RequestParam(value = "reqdata", required = false) String reqdata
			) {
		
		LOGGER.info("REQ_CHECK_UPDATE" );
				
		
		System.out.println( cmd );
		System.out.println( reqdata );
		
		
		byte[] de_reqdata_byte;
		String de_reqdata = "";			
		try {			
			de_reqdata_byte = Base64.decodeBase64( reqdata );
			de_reqdata = URLDecoder.decode( new String( de_reqdata_byte), "UTF-8");
			
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		System.out.println( "decode : " + de_reqdata );
		
		
		JSONObject jo = JSONObject.fromObject(de_reqdata);	
		//JSONArray Version = jo.getJSONArray("Version");
		
		String Name = jo.getString("Name");
		String OSType = jo.getString("OSType");
		String Version = jo.getString("Version");
		
		System.out.println( Name );
		System.out.println( OSType );
		System.out.println( Version );
		
		if( "A".equals( OSType.toUpperCase() ) )			
		{
			OSType = "AND";
		}
		else if( "I".equals( OSType.toUpperCase() ))
		{
			OSType = "IOS";
		}
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		
		params.put( "OSType", OSType );
				
		BleAuthVo rslt = svc.retrieveREQ_CHECK_UPDATE( params );
			
		JSONObject REQ_CHECK_UPDATE = new JSONObject();
		
		JSONObject Result = new JSONObject();
		JSONObject UpdateInfo = new JSONObject();
		
		String FinalVersion = rslt.getVersion();
		String DlUrl = "http://remsbiz.com/blemanager";
		
		if( rslt == null )		// 실패
		{
			Result.put( "Status", 				"F" );
			Result.put( "ErrorCode", 			"005" );
			Result.put( "ErrorMsg", 			"DB Error" );
			
			UpdateInfo.put( "FinalVersion", 	" " );
			UpdateInfo.put( "DownloadURL", 		" " );
		}
		else						// 성공
		{			
			Result.put( "Status", 				"T" );
			Result.put( "ErrorCode", 			"000" );
			Result.put( "ErrorMsg", 			"Success" );
						
			//DlUrl = rslt.getDlUrl();
			
			FinalVersion = rslt.getVersion().trim();
			
			if( Version.trim().equals( OSType.toUpperCase() ) )		// Android
			{				
				
				System.out.println("[AND] SAME Version");								
			}
			else
			{
				System.out.println("[AND] Different Version");				
			}			
			
				
			UpdateInfo.put( "FinalVersion", 	FinalVersion );
			UpdateInfo.put( "DownloadURL", 		DlUrl );				
		}
		
		
		
		Result.put( "Status", 				"T" );
		Result.put( "ErrorCode", 			"000" );
		Result.put( "ErrorMsg", 			"Success" );
		
		UpdateInfo.put( "FinalVersion", 	FinalVersion );
		UpdateInfo.put( "DownloadURL", 		DlUrl );	
		////////////////////////////////////////////////////
		
		REQ_CHECK_UPDATE.put("Name", 		"RES_CHECK_UPDATE");
		REQ_CHECK_UPDATE.put("Result", 		Result );
		REQ_CHECK_UPDATE.put("UpdateInfo", 	UpdateInfo );
		
		String base64_REQ_CHECK_UPDATE = "";
		
		try {
			base64_REQ_CHECK_UPDATE = URLEncoder.encode(REQ_CHECK_UPDATE.toString(), "UTF-8");
			base64_REQ_CHECK_UPDATE = Base64.encodeBase64String(base64_REQ_CHECK_UPDATE.getBytes());		
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		System.out.println( REQ_CHECK_UPDATE.toString() );
		System.out.println( "encode : " + Base64.encodeBase64String( ( REQ_CHECK_UPDATE.toString() ).getBytes() ) );
		
		
		return base64_REQ_CHECK_UPDATE;
		//return REQ_CHECK_UPDATE.toString();
	}
	
	
	
	// BLE 통신 - 사용자 인증
	@RequestMapping(value = "/REQ_AUTH_USER", method = {RequestMethod.GET, RequestMethod.POST}, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String REQ_AUTH_USER(			
			@RequestParam(value = "cmd", required = false) String cmd,
			@RequestParam(value = "reqdata", required = false) String reqdata
			) {
		
		LOGGER.info("REQ_AUTH_USER" );
		
		System.out.println( cmd );
		System.out.println( reqdata );
			
		byte[] de_reqdata_byte;
		String de_reqdata = "";			
		try {			
			de_reqdata_byte = Base64.decodeBase64( reqdata );
			de_reqdata = URLDecoder.decode( new String( de_reqdata_byte), "UTF-8");
			
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		System.out.println( "decode : " + de_reqdata );
				
		// 파싱
		JSONObject jo = JSONObject.fromObject(de_reqdata);	
		
		String Name = jo.getString("Name");
		String ID = jo.getString("ID");
		String Pass = jo.getString("Pass");
		
		System.out.println( Name );
		System.out.println( ID );
		System.out.println( Pass );
		
				
		HashMap<String,Object> params = new HashMap<String,Object>();
		
		params.put( "ID", ID.toLowerCase() );
		params.put( "Pass", Pass.toLowerCase() );		
		
		BleAuthVo rslt = svc.retrieveREQ_AUTH_USER( params );
		
		JSONObject REQ_AUTH_USER = new JSONObject();
		
		JSONObject Result = new JSONObject();
		
		String UserType = "0";
		
		
		System.out.println("ddd : " + rslt);		
		
		
		if( rslt == null )
		{
			Result.put( "Status", 			"F" );
			Result.put( "ErrorCode", 		"006" );
			Result.put( "ErrorMsg", 		"DB Error" );
			
			REQ_AUTH_USER.put("Name", 		"RES_AUTH_USER");
			REQ_AUTH_USER.put("Result", 	Result );		
			REQ_AUTH_USER.put("UserType",	"");
			REQ_AUTH_USER.put("ID",			ID);
			REQ_AUTH_USER.put("Pass",		Pass);
		}
		else
		{
			
			if( "0".equals( rslt.getCnt() ) )
			{
				
				
				Result.put( "Status", 				"F" );
				Result.put( "ErrorCode", 			"005" );
				Result.put( "ErrorMsg", 			"Login Error" );
				
				REQ_AUTH_USER.put("Name", 		"RES_AUTH_USER");
				REQ_AUTH_USER.put("Result", 	Result );		
				REQ_AUTH_USER.put("UserType",	"");
				REQ_AUTH_USER.put("ID",			ID);
				REQ_AUTH_USER.put("Pass",		Pass);
			}
			else
			{
				if( Integer.valueOf( rslt.getType1() ) >= 1)		// 전기업체
				{
					UserType = "1";
				}
				else if( Integer.valueOf( rslt.getType2() ) >= 1)		// 유지보수업체
				{
					UserType = "2";
				}
				else if( Integer.valueOf( rslt.getType3() ) >= 1)		// 시스네트
				{
					UserType = "3";
				}
				else if( Integer.valueOf( rslt.getType4() ) >= 1)		// 간판업체
				{
					UserType = "4";
				}
				else
				{
					UserType = "5";			// 나머지 사람들
				}
					
				
				Result.put( "Status", 				"T" );
				Result.put( "ErrorCode", 			"000" );
				Result.put( "ErrorMsg", 			"Success" );										
								
				REQ_AUTH_USER.put("Name", 		"RES_AUTH_USER");
				REQ_AUTH_USER.put("Result", 	Result );		
				REQ_AUTH_USER.put("UserType",	UserType);
				//REQ_AUTH_USER.put("UserType",	"1");
				REQ_AUTH_USER.put("ID",			rslt.getUserId());
				REQ_AUTH_USER.put("Pass",		Pass);
			}
				
			
		}
		
		String base64_REQ_AUTH_USER = "";
		
		try {
			base64_REQ_AUTH_USER = URLEncoder.encode(REQ_AUTH_USER.toString(), "UTF-8");
			base64_REQ_AUTH_USER = Base64.encodeBase64String(base64_REQ_AUTH_USER.getBytes());		
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		System.out.println( REQ_AUTH_USER.toString() );
		System.out.println( Base64.encodeBase64String( ( REQ_AUTH_USER.toString() ).getBytes() ) );
			
		return base64_REQ_AUTH_USER;
		//return REQ_AUTH_USER.toString();
	}
			
	// BLE 인증번호 확인
	@RequestMapping(value = "/REQ_VERIFY_BLE", method = {RequestMethod.GET, RequestMethod.POST}, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String REQ_VERIFY_BLE(			
			@RequestParam(value = "cmd", required = false) String cmd,
			@RequestParam(value = "reqdata", required = false) String reqdata
			) {
		
		LOGGER.info("REQ_AUTH_USER" );
		
		System.out.println( cmd );
		System.out.println( reqdata );
		
			
		JSONObject REQ_VERIFY_BLE = new JSONObject();
		
		
		byte[] de_reqdata_byte;
		String de_reqdata = "";			
		try {			
			de_reqdata_byte = Base64.decodeBase64( reqdata );
			de_reqdata = URLDecoder.decode( new String( de_reqdata_byte), "UTF-8");
			
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		System.out.println( "decode : " + de_reqdata );
				
		// 파싱
		JSONObject jo = JSONObject.fromObject(de_reqdata);	
		
		String Name = jo.getString("Name");
		String ID = jo.getString("ID");
		String Pass = jo.getString("Pass");
		
		
		
		JSONArray MACAddrList = jo.getJSONArray("MACAddrList");
		
		String[] MAC = new String[MACAddrList.size()];
		
		for(int i=0; i<MACAddrList.size(); i++)
		{
			JSONObject data = (JSONObject) MACAddrList.get(i);
			MAC[i] = 	data.getString("MAC");			
			
			
		}
		
		System.out.println( Name );
		System.out.println( ID );
		System.out.println( Pass );
		System.out.println( MACAddrList );
		
		ArrayList PutMACAddrList = new ArrayList();		
		
		for(int i=0; i< MAC.length; i++ )
		{			
			
			HashMap<String,Object> params = new HashMap<String,Object>();
			
			params.put("MAC", MAC[i].replace(":", "") );
			
			BleAuthVo rslt = svc.retrieveREQ_VERIFY_BLE( params );
			
			JSONObject putMACAddr = new JSONObject();		
			
			if( rslt == null )
			{				
				putMACAddr.put( "MAC", 			MAC[i] );
				putMACAddr.put( "StoreName", 	" " );
				putMACAddr.put( "AuthPass", 	" "  );
			}
			else
			{				
				putMACAddr.put( "MAC", 			MAC[i] );
				putMACAddr.put( "StoreName", 	rslt.getStrNm() );
				putMACAddr.put( "AuthPass", 	rslt.getGwBlePwd()  );
			}				
			
			PutMACAddrList.add( putMACAddr );			
		}
		

		JSONObject Result = new JSONObject();		
		List<JSONObject> BLEInfoList = new ArrayList<JSONObject>();
					
		Result.put( "Status", 				"T" );
		Result.put( "ErrorCode", 			"000" );
		Result.put( "ErrorMsg", 			"NoError" );
		
		REQ_VERIFY_BLE.put("Name", 			"RES_VERIFY_BLE");
		REQ_VERIFY_BLE.put("Result", 		Result );
		REQ_VERIFY_BLE.put("BLEInfoList", 	PutMACAddrList );
		
		String base64_REQ_VERIFY_BLE = "";
		
		
		try {
			base64_REQ_VERIFY_BLE = URLEncoder.encode(REQ_VERIFY_BLE.toString(), "UTF-8");
			base64_REQ_VERIFY_BLE = Base64.encodeBase64String(base64_REQ_VERIFY_BLE.getBytes());		
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		System.out.println( REQ_VERIFY_BLE.toString() );
		System.out.println( Base64.encodeBase64String( ( REQ_VERIFY_BLE.toString() ).getBytes() ) );
				
		return base64_REQ_VERIFY_BLE;
	}
	
	
	
	// 매장확인
	@RequestMapping(value = "/REQ_CHECK_STORE", method = {RequestMethod.GET, RequestMethod.POST}, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String REQ_CHECK_STORE(	
			@RequestParam(value = "cmd", required = false) String cmd,
			@RequestParam(value = "reqdata", required = false) String reqdata
			) {
		
		LOGGER.info("REQ_CHECK_STORE" );
		
		System.out.println( cmd );
		System.out.println( reqdata );
		
		byte[] de_reqdata_byte;
		String de_reqdata = "";			
		try {			
			de_reqdata_byte = Base64.decodeBase64( reqdata );
			de_reqdata = URLDecoder.decode( new String( de_reqdata_byte), "UTF-8");
			
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		System.out.println( "decode : " + de_reqdata );
		
				
		// 파싱
		JSONObject jo = JSONObject.fromObject(de_reqdata);		
		
		String Name = jo.getString("Name");
		String ID = jo.getString("ID");
		String Pass = jo.getString("Pass");
		String MAC = jo.getString("MAC");
		
		System.out.println( Name );
		System.out.println( ID );
		System.out.println( Pass );
		System.out.println( MAC );		
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		
		params.put( "ID", ID.toLowerCase() );
		params.put( "Pass", Pass.toLowerCase() );
		params.put( "MAC", MAC.replace(":", "") );
		
		BleAuthVo rslt = svc.retrieveREQ_CHECK_STORE( params );
		
		
		JSONObject REQ_CHECK_STORE = new JSONObject();
		
		JSONObject Result = new JSONObject();
		
		String UserType = "0";
		
		System.out.println("ddd : " + rslt);
		
		ArrayList PutMACAddrList = new ArrayList();		
		
		
		
		if( rslt == null )
		{
			
			// 매장이 찾아지지 않으면 등록안된 매장 전체 리스트를 가져와야 한다.
			
			List<BleAuthVo> rslt2 = svc.retrieveREQ_CHECK_STORE_ALL( params );
			
			
			int cnt = rslt2.size();
			
			if( cnt <= 0 )
			{
				Result.put( "Status", 			"F" );
				Result.put( "ErrorCode", 		"005" );
				Result.put( "ErrorMsg", 		"DB Error" );
				
				JSONObject putMACAddr = new JSONObject();	
				putMACAddr.put( "MAC", 			" " );
				putMACAddr.put( "StoreName", 	" " );
				putMACAddr.put( "AuthPass", 	" "  );
				
				PutMACAddrList.add( putMACAddr );
			}
			else
			{			
				Result.put( "Status", 			"T" );
				Result.put( "ErrorCode", 		"000" );
				Result.put( "ErrorMsg", 		"Success" );
				
				for(int i=0; i<cnt; i++)
				{				
					
					JSONObject putMACAddr = new JSONObject();		
					
					putMACAddr.put( "MAC", 		" " );
					putMACAddr.put( "StoreName", 	rslt2.get(i).getStrNm() );
					putMACAddr.put( "AuthPass", 	" " );
					
					//putMACAddr.put( "MACA", 		rslt2.get(i).getMacAddr() );
					//putMACAddr.put( "StoreName", 	rslt2.get(i).getStrNm() );
					//putMACAddr.put( "AuthPass", 	rslt2.get(i).getGwBlePwd()  );
					
					PutMACAddrList.add( putMACAddr );
					
				}
			
			}
		}
		else
		{		
			JSONObject putMACAddr = new JSONObject();		
			
			Result.put( "Status", 			"T" );
			Result.put( "ErrorCode", 		"000" );
			Result.put( "ErrorMsg", 		"Success" );
				
			putMACAddr.put( "MAC", 			MAC );
			putMACAddr.put( "StoreName", 	rslt.getStrNm() );
			putMACAddr.put( "AuthPass", 	rslt.getGwBlePwd()  );
			
			PutMACAddrList.add( putMACAddr );
		}
		
		
		REQ_CHECK_STORE.put("Name", 	"RES_CHECK_STORE");
		REQ_CHECK_STORE.put("Result", 	Result );		
		REQ_CHECK_STORE.put("StoreInfoList",	PutMACAddrList);
		
		String base64_REQ_CHECK_STORE = "";
		
		try {
			base64_REQ_CHECK_STORE = URLEncoder.encode(REQ_CHECK_STORE.toString(), "UTF-8");
			base64_REQ_CHECK_STORE = Base64.encodeBase64String(base64_REQ_CHECK_STORE.getBytes());		
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return base64_REQ_CHECK_STORE;
		
	}

	
	// 매장등록
	@RequestMapping(value = "/REQ_REG_STORE", method = {RequestMethod.GET, RequestMethod.POST}, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String REQ_REG_STORE(			
			@RequestParam(value = "cmd", required = false) String cmd,
			@RequestParam(value = "reqdata", required = false) String reqdata
			) {
		
		LOGGER.info("REQ_REG_STORE" );
		
		System.out.println( cmd );
		System.out.println( reqdata );
		
		
		byte[] de_reqdata_byte;
		String de_reqdata = "";			
		try {			
			de_reqdata_byte = Base64.decodeBase64( reqdata );
			de_reqdata = URLDecoder.decode( new String( de_reqdata_byte), "UTF-8");
			
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		System.out.println( "decode : " + de_reqdata );
		
		// 파싱
		JSONObject jo = JSONObject.fromObject(de_reqdata);	
		
		String Name = jo.getString("Name");
		String ID = jo.getString("ID");
		String Pass = jo.getString("Pass");
		String MAC = jo.getString("MAC");
		String StoreName = jo.getString("StoreName");
			
		System.out.println( Name );
		System.out.println( ID );
		System.out.println( Pass );
		System.out.println( MAC );
		System.out.println( StoreName );
				
		HashMap<String,Object> params = new HashMap<String,Object>();
		
		params.put( "ID", 			ID.toLowerCase() );
		params.put( "Pass", 		Pass.toLowerCase() );
		
		params.put( "MAC", 			MAC.replace(":", "") );
		params.put( "StoreName", 	StoreName );
		params.put( "BlePwd", 		"48197" );
		
				
				
		// 매장 등록 - update 필요
		int rslt_in = svc.retrieveREQ_REG_STORE( params );		
			
		JSONObject REQ_REG_STORE = new JSONObject();		
		JSONObject Result = new JSONObject();	
		
		BleAuthVo rslt = svc.retrieveREQ_CHECK_STORE( params );
		
		if( rslt_in == 0 )		// 실패
		{
			Result.put( "Status", 				"F" );
			Result.put( "ErrorCode", 			"005" );
			Result.put( "ErrorMsg", 			"Error" );		
			
			REQ_REG_STORE.put("MAC", 		" " );
			REQ_REG_STORE.put("StoreName", 	" " );
			REQ_REG_STORE.put("AuthPass", 	" " );
		}
		else						// 성공
		{	
			
			
			if( rslt == null )
			{
				Result.put( "Status", 				"F" );
				Result.put( "ErrorCode", 			"005" );
				Result.put( "ErrorMsg", 			"Error" );			
				
				REQ_REG_STORE.put("MAC", 		" " );
				REQ_REG_STORE.put("StoreName", 	" " );
				REQ_REG_STORE.put("AuthPass", 	" " );
			}
			else
			{
				
				Result.put( "Status", 				"T" );
				Result.put( "ErrorCode", 			"000" );
				Result.put( "ErrorMsg", 			"NoError" );
				if( rslt.getGwAddr() == null )
					REQ_REG_STORE.put("MAC", 		"" );
				else	
					REQ_REG_STORE.put("MAC", 		MAC );
	
				if( rslt.getStrNm() == null )
					REQ_REG_STORE.put("StoreName", 	rslt.getStrNm() );
				else
					REQ_REG_STORE.put("StoreName", 	rslt.getStrNm() );
				
				if( rslt.getGwBlePwd() == null )
					REQ_REG_STORE.put("AuthPass", 	rslt.getGwBlePwd() );
				else
					REQ_REG_STORE.put("AuthPass", 	rslt.getGwBlePwd() );
			}
		}
				
		REQ_REG_STORE.put("Name", 			"RES_REG_STORE");	
		REQ_REG_STORE.put("Result",			Result);	
		
		String base64_REQ_REG_STORE = "";
		

		try {
			base64_REQ_REG_STORE = URLEncoder.encode(REQ_REG_STORE.toString(), "UTF-8");
			base64_REQ_REG_STORE = Base64.encodeBase64String(base64_REQ_REG_STORE.getBytes());		
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		System.out.println( REQ_REG_STORE.toString() );
		System.out.println( Base64.encodeBase64String( ( REQ_REG_STORE.toString() ).getBytes() ) );
		
		
		return base64_REQ_REG_STORE;
	}
	
	
	

	// 매장등록
	@RequestMapping(value = "/REQ_NOTI_GW_INFO", method = {RequestMethod.GET, RequestMethod.POST}, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String REQ_NOTI_GW_INFO(		
			@RequestParam(value = "cmd", required = false) String cmd,
			@RequestParam(value = "reqdata", required = false) String reqdata
			) {
		
		LOGGER.info("REQ_NOTI_GW_INFO" );
		
		System.out.println( cmd );
		System.out.println( reqdata );
		
		
		

		
		byte[] de_reqdata_byte;
		String de_reqdata = "";			
		try {			
			de_reqdata_byte = Base64.decodeBase64( reqdata );
			de_reqdata = URLDecoder.decode( new String( de_reqdata_byte), "UTF-8");
			
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		de_reqdata2 = de_reqdata;
		System.out.println( "decode : " + de_reqdata );
		
		
		
		
		
		

		System.out.println( "zzz : " + de_reqdata2 );
		
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		
		// 파싱
		JSONObject jo = JSONObject.fromObject(de_reqdata2);	
		
		String Name = 				jo.getString("Name");
		String ID = 				jo.getString("ID");
		String Pass = 				jo.getString("Pass");
		String UserName = 			jo.getString("UserName");				
		String UserType = 			jo.getString("UserType");
		
		String gwIp =				jo.getString("IP");
		String gwNetmask =			jo.getString("NETMASK");
		String gwGateway =			jo.getString("GATEWAY");
		
		String ifIp =				jo.getString("IFIP");
		String ifPort =				jo.getString("IFPORT");
		
		String MAC = 				jo.getString("MAC");
		String StoreCode = 			jo.getString("StoreCode");
		String StoreName = 			jo.getString("StoreName");		
		String NotiDateTime = 		jo.getString("NotiDateTime");		
					
		String ElecUseChannel = 	jo.getString("ElecUseChannel");				// 사용 ct 개수
		String RST = 				jo.getString("RSTBreaker");
		
		JSONArray ElecInfoList = 	jo.getJSONArray("ElecInfoList");		
		JSONArray TemonInfoList = 	jo.getJSONArray("TemonInfoList");
		JSONArray ZigbeeInfoList = 	jo.getJSONArray("ZigbeeInfoList");
				
		params.put("ID", 		ID);
		params.put("Pass", 		Pass);
		params.put("MAC", 		MAC.replace(":", ""));
		
		params.put("gwIp", 			gwIp);
		params.put("gwNetmask", 	gwNetmask);
		params.put("gwGateway", 	gwGateway);
		params.put("ifIp", 			ifIp);
		params.put("ifPort", 		ifPort);
		
		
		BleAuthVo rslt1 = svc.retrieveREQ_AUTH_USER( params );
		BleAuthVo rslt2 = svc.retrieveREQ_VERIFY_BLE( params );
		
		
		String[] ElecChannelNo = new String[12];
		String[] ElecChannelStatus = new String[12];
		String[] ElecAcc = new String[12];
		String[] ElecInst = new String[12];	
		
		for(int i=0; i<ElecInfoList.size(); i++)
		{
			JSONObject data = (JSONObject) ElecInfoList.get(i);			
			
			ElecChannelNo[i] = 		data.getString("ChannelNo");
			ElecChannelStatus[ Integer.valueOf( ElecChannelNo[i] ) - 1 ] = 	data.getString("Status");
			ElecAcc[i] = 			data.getString("Acc");
			ElecInst[i] = 			data.getString("Inst");			
		}
				
				
		///////////////////////////////////////////////// TEMON ///////////////////////////////////////////////////
		
		
		String[] deviceNm = new String[25];
		
		deviceNm[0] = 	"없음";
		deviceNm[1] = 	"WIC1";
		deviceNm[2] = 	"WIC2";
		deviceNm[3] = 	"OSC1";
		deviceNm[4] = 	"OSC2";
		deviceNm[5] = 	"OSC3";
		deviceNm[6] = 	"OSC4";
		deviceNm[7] = 	"RIC1";
		deviceNm[8] = 	"RIC2";
		deviceNm[9] = 	"RIF1";
		deviceNm[10] =	"RIF2";
		deviceNm[11] = "RIF3";
		deviceNm[12] = "ICC1";
		deviceNm[13] = "ICC2";
		deviceNm[14] = "ICC3";
		deviceNm[15] = "냉동평대1";
		deviceNm[16] = "냉동평대2";
		deviceNm[17] = "냉동평대3";
		deviceNm[18] = "냉동콤비1(상)";
		deviceNm[19] = "냉동콤비1(하)";
		deviceNm[20] = "냉동콤비2(상)";
		deviceNm[21] = "냉동콤비2(하)";
		deviceNm[22] = "냉동콤비3(상)";
		deviceNm[23] = "냉동콤비3(하)";
		deviceNm[24] = "기타";
		
		for(int i=0; i<TemonInfoList.size(); i++)
		{
			JSONObject data = (JSONObject)TemonInfoList.get(i);
			
			String Exist = 		data.getString("Exist");
			String No = 		data.getString("TemonNo");
			JSONArray Temp = 	data.getJSONArray("TemonPortList");			
			
			if( "1".equals( Exist ))			// TEMON 이 존재하면
			{		
				for(int j=0; j<16; j++ )
				{				
					
					HashMap<String,Object> temonParams = new HashMap<String,Object>();
					
					JSONObject data2 = 		(JSONObject) Temp.get(j);			
					
					
					temonParams.put("strCd", 			rslt2.getStrCd());					
					temonParams.put("userType", 		UserType);						
					temonParams.put("notiDateTime",		NotiDateTime );
					
					temonParams.put("id", 				No);
					temonParams.put("type", 			"T");
					temonParams.put("portNo", 			data2.getString("PortNo"));
									
					
					int deviceType = Integer.valueOf( data2.getString("DeviceType")); 
					String deviceLoc = deviceNm[ deviceType ];					
					temonParams.put("deviceLoc", 		deviceLoc );
					
					if( "-128".equals( data2.getString("Temp") ) && "2".equals( data2.getString("Status")) )
						temonParams.put("temp", 		null);
					else
						temonParams.put("temp", 		data2.getString("Temp"));
					
					
					
					if( deviceType == 1 || deviceType == 2 )		// WIC
					{
						temonParams.put("deviceType", 		"W");	
						temonParams.put("maxTemp", 			"15");
						temonParams.put("minTemp", 			"2");
						temonParams.put("delayTime", 		"180");
						
					}else if( deviceType == 3 || deviceType == 4 || deviceType == 5 || deviceType == 6 )		// OSC
					{
						temonParams.put("deviceType", 		"O");
						temonParams.put("maxTemp", 			"15");
						temonParams.put("minTemp", 			"2");
						temonParams.put("delayTime", 		"35");
					
					}else if( deviceType == 7 || deviceType == 8 )		// RIC
					{
						temonParams.put("deviceType", 		"R");
						temonParams.put("maxTemp", 			"10");
						temonParams.put("minTemp", 			"-10");
						temonParams.put("delayTime", 		"40");
					
					}else if( deviceType == 9 || deviceType == 10 || deviceType == 11 )		// RIF
					{
						temonParams.put("deviceType", 		"R");
						temonParams.put("maxTemp", 			"-10");
						temonParams.put("minTemp", 			"-50");
						temonParams.put("delayTime", 		"20");
						
					}else if( deviceType == 12 || deviceType == 13 || deviceType == 14 )		// ICC
					{
						temonParams.put("deviceType", 		"I");
						temonParams.put("maxTemp", 			"-10");
						temonParams.put("minTemp", 			"-50");
						temonParams.put("delayTime", 		"20");
					
					}else if( deviceType == 15 || deviceType == 16 || deviceType == 17 )		// 냉동평대
					{
						temonParams.put("deviceType", 		"I");
						temonParams.put("maxTemp", 			"-10");
						temonParams.put("minTemp", 			"-50");
						temonParams.put("delayTime", 		"20");
										
					}else if( deviceType == 18 || deviceType == 19 || deviceType == 20 || deviceType == 21 || deviceType == 22 || deviceType == 23 )		// 냉동콤비
					{
						temonParams.put("deviceType", 		"I");
						temonParams.put("maxTemp", 			"-10");
						temonParams.put("minTemp", 			"-50");
						temonParams.put("delayTime", 		"20");
					}
					else
					{
						temonParams.put("deviceType", 		"R");
						temonParams.put("maxTemp", 			"50");
						temonParams.put("minTemp", 			"-50");
						temonParams.put("delayTime", 		"180");
						
					}
					
					/*
					if( "1".equals( data2.getString("Status")))
						temonParams.put("useYn", 			"Y");
					else
						temonParams.put("useYn", 			"N");
					*/
					temonParams.put("useYn", 			"Y");
					
					temonParams.put("pushTerm", 		"180");
					
					temonParams.put("battery", 			null);
					temonParams.put("rssi", 			null);
					temonParams.put("status", 		data2.getString("Status"));
					
					
					
					svc.retrieveREQ_NOTI_GW_INFO_DEVICE_MST( temonParams );					
										
					// 테몬 마스터에 정보 업데이트
					svc.saveGwInfoDeviceMst( temonParams );
					
				}
				
				
				
			}
			else
			{
				continue;
			}		
		}
		
				
				
		///////////////////////////////////////////////// ZIGBEE ///////////////////////////////////////////////////
		for(int i=0; i<ZigbeeInfoList.size(); i++)
		{
			JSONObject data = (JSONObject)ZigbeeInfoList.get(i);
			
			String Exist = 		data.getString("Exist");
			String No = 		data.getString("ZigbeeNo");
			JSONArray Temp = 	data.getJSONArray("ZigbeePortList");			
			
			if( "1".equals( Exist ))			// Zigbee 이 존재하면
			{		
				for(int j=0; j<16; j++ )
				{				
			
					HashMap<String,Object> zigbeeParams = new HashMap<String,Object>();
					
					JSONObject data2 = 		(JSONObject) Temp.get(j);
					
					zigbeeParams.put("strCd", 			rslt2.getStrCd());					
					zigbeeParams.put("userType", 		UserType);						
					zigbeeParams.put("notiDateTime",	NotiDateTime );
					
					zigbeeParams.put("id", 				No);
					zigbeeParams.put("type", 			"Z");
					zigbeeParams.put("portNo", 			data2.getString("PortNo"));
					
					
					int deviceType = Integer.valueOf( data2.getString("DeviceType")); 
					String deviceLoc = deviceNm[ deviceType ];					
					zigbeeParams.put("deviceLoc", 		deviceLoc );
					
					
					if( deviceType == 1 || deviceType == 2 )		// WIC
					{
						zigbeeParams.put("deviceType", 		"W");	
						zigbeeParams.put("maxTemp", 		"15");
						zigbeeParams.put("minTemp", 		"2");
						zigbeeParams.put("delayTime", 		"180");
						
					}else if( deviceType == 3 || deviceType == 4 || deviceType == 5 || deviceType == 6 )		// OSC
					{
						zigbeeParams.put("deviceType", 		"O");
						zigbeeParams.put("maxTemp", 		"15");
						zigbeeParams.put("minTemp", 		"2");
						zigbeeParams.put("delayTime", 		"35");
					
					}else if( deviceType == 7 || deviceType == 8 )		// RIC
					{
						zigbeeParams.put("deviceType", 		"R");
						zigbeeParams.put("maxTemp", 		"10");
						zigbeeParams.put("minTemp", 		"-10");
						zigbeeParams.put("delayTime", 		"40");
					
					}else if( deviceType == 9 || deviceType == 10 || deviceType == 11 )		// RIF
					{
						zigbeeParams.put("deviceType", 		"R");
						zigbeeParams.put("maxTemp", 		"-10");
						zigbeeParams.put("minTemp", 		"-50");
						zigbeeParams.put("delayTime", 		"20");
						
					}else if( deviceType == 12 || deviceType == 13 || deviceType == 14 )		// ICC
					{
						zigbeeParams.put("deviceType", 		"I");
						zigbeeParams.put("maxTemp", 		"-10");
						zigbeeParams.put("minTemp", 		"-50");
						zigbeeParams.put("delayTime", 		"20");
					
					}else if( deviceType == 15 || deviceType == 16 || deviceType == 17 )		// 냉동평대
					{
						zigbeeParams.put("deviceType", 		"I");
						zigbeeParams.put("maxTemp", 		"-10");
						zigbeeParams.put("minTemp", 		"-50");
						zigbeeParams.put("delayTime", 		"20");
										
					}else if( deviceType == 18 || deviceType == 19 || deviceType == 20 || deviceType == 21 || deviceType == 22 || deviceType == 23 )		// 냉동콤비
					{
						zigbeeParams.put("deviceType", 		"I");
						zigbeeParams.put("maxTemp", 		"-10");
						zigbeeParams.put("minTemp", 		"-50");
						zigbeeParams.put("delayTime", 		"20");
					}
					else
					{
						zigbeeParams.put("deviceType", 		"R");
						zigbeeParams.put("maxTemp", 		"50");
						zigbeeParams.put("minTemp", 		"-50");
						zigbeeParams.put("delayTime", 		"180");						
					}
					
					zigbeeParams.put("temp", 			data2.getString("Temp"));
					
					/*
					if( "1".equals( data2.getString("Status")))
						zigbeeParams.put("useYn", 		"Y");
					else
						zigbeeParams.put("useYn", 		"N");	
					*/
					
					zigbeeParams.put("useYn", 		"Y");
					
					zigbeeParams.put("pushTerm", 		"180");
					zigbeeParams.put("battery", 		data2.getString("Battery"));
					zigbeeParams.put("rssi", 			data2.getString("Rssi"));
					zigbeeParams.put("status", 			data2.getString("Status"));					
					
					svc.retrieveREQ_NOTI_GW_INFO_DEVICE_MST( zigbeeParams );
					
					// 테몬 마스터에 정보 업데이트
					svc.saveGwInfoDeviceMst( zigbeeParams );
				}
				
			}
			else
			{
			continue;
			}		
		}
		
		params.put("strCd", 		rslt2.getStrCd());
		params.put("strNm", 		rslt2.getStrNm());
		params.put("gwId", 			rslt2.getGwId());		
		params.put("userName", 		UserName);
		params.put("userType", 		UserType);				
		params.put("storeCode", 	StoreCode);
		params.put("storeName", 	StoreName);
		
		
		if( "1".equals( UserType ) )			// 전기업체
		{
			params.put("elecCheck", 	"1");
			params.put("sensorCheck", 	"0");
			params.put("networkCheck",  "0");
			params.put("signCheck", 	"0");
			params.put("vendorCd", 		rslt1.getVendorCd());
			params.put("vendorNm", 		rslt1.getType1Nm());
		}else if( "2".equals( UserType ) )		// 냉장비 업체
		{
			params.put("elecCheck", 	"0");
			params.put("sensorCheck", 	"1");
			params.put("networkCheck",  "0");
			params.put("signCheck", 	"0");
			params.put("vendorCd", 		rslt1.getVendorCd());			
			params.put("vendorNm", 		rslt1.getType2Nm());
		}else if( "3".equals( UserType ) )		// 시스네트
		{
			params.put("elecCheck", 	"0");
			params.put("sensorCheck", 	"0");
			params.put("networkCheck", 	"1");
			params.put("signCheck", 	"0");
			params.put("vendorCd", 		rslt1.getVendorCd());			
			params.put("vendorNm", 		rslt1.getType3Nm());
			
			
			// 사용자 계정 생성
			svc.saveUserMst(params);			
			svc.saveUserAuth(params);
			svc.saveUserStrMap(params);
			
			
		}else if( "4".equals( UserType ) )		// 간판업체
		{
			params.put("elecCheck", 	"0");
			params.put("sensorCheck", 	"0");
			params.put("networkCheck", 	"0");
			params.put("signCheck", 	"1");
			params.put("vendorCd", 		rslt1.getVendorCd());			
			params.put("vendorNm", 		rslt1.getType4Nm());
			
			
		}
		
		params.put("notiDateTime", NotiDateTime );	
		
		params.put("RST", 			RST);
		params.put("EpCnt",			ElecUseChannel);
		
		int chcnt = Integer.valueOf( ElecUseChannel );
		
		String ch1cnt 	= "1";
		String ch2cnt 	= "1";
		String ch3cnt 	= "1";
		String ch4cnt 	= "1";
		String ch5cnt 	= "1";
		String ch6cnt 	= "1";
		String ch7Rcnt 	= "1";
		String ch7Scnt 	= "1";
		String ch7Tcnt	= "1";
		String ch8Rcnt 	= "1";
		String ch8Scnt 	= "1";
		String ch8Tcnt 	= "1";
		
		switch( chcnt )
		{
			case 0:
				ch1cnt 	= "0";
				ch2cnt 	= "0";
				ch3cnt 	= "0";
				ch4cnt 	= "0";
				ch5cnt 	= "0";
				ch6cnt 	= "0";
				ch7Rcnt = "0";
				ch7Scnt = "0";
				ch7Tcnt = "0";
				ch8Rcnt = "0";
				ch8Scnt = "0";
				ch8Tcnt = "0";				
				break;
			case 1:	case 2:	case 3:				
				ch2cnt 	= "0";
				ch3cnt 	= "0";
				ch4cnt 	= "0";
				ch5cnt 	= "0";
				ch6cnt 	= "0";
				ch7Rcnt = "0";
				ch7Scnt = "0";
				ch7Tcnt = "0";
				ch8Rcnt = "0";
				ch8Scnt = "0";
				ch8Tcnt = "0";	
				break;
			case 4:	case 5:	case 6:
				ch3cnt 	= "0";
				ch4cnt 	= "0";
				ch5cnt 	= "0";
				ch6cnt 	= "0";
				ch7Rcnt = "0";
				ch7Scnt = "0";
				ch7Tcnt = "0";
				ch8Rcnt = "0";
				ch8Scnt = "0";
				ch8Tcnt = "0";	
				break;
			case 7:	case 8:	case 9:			
				ch4cnt 	= "0";
				ch5cnt 	= "0";
				ch6cnt 	= "0";
				ch7Rcnt = "0";
				ch7Scnt = "0";
				ch7Tcnt = "0";
				ch8Rcnt = "0";
				ch8Scnt = "0";
				ch8Tcnt = "0";	
				break;
			case 10:	case 11:	case 12:			
				ch5cnt 	= "0";
				ch6cnt 	= "0";
				ch7Rcnt = "0";
				ch7Scnt = "0";
				ch7Tcnt = "0";
				ch8Rcnt = "0";
				ch8Scnt = "0";
				ch8Tcnt = "0";	
				break;
			case 13:	case 14:	case 15:				
				ch6cnt 	= "0";
				ch7Rcnt = "0";
				ch7Scnt = "0";
				ch7Tcnt = "0";
				ch8Rcnt = "0";
				ch8Scnt = "0";
				ch8Tcnt = "0";	
				break;
			case 16:	case 17:	case 18:				
				ch7Rcnt = "0";
				ch7Scnt = "0";
				ch7Tcnt = "0";
				ch8Rcnt = "0";
				ch8Scnt = "0";
				ch8Tcnt = "0";	
				break;
			case 19:	case 20:	case 21:				
				ch7Scnt = "0";
				ch7Tcnt = "0";
				ch8Rcnt = "0";
				ch8Scnt = "0";
				ch8Tcnt = "0";	
				break;
			case 22:	case 23:	case 24:
				ch7Tcnt = "0";
				ch8Rcnt = "0";
				ch8Scnt = "0";
				ch8Tcnt = "0";	
				break;
			case 25:	case 26:	case 27:
				ch8Rcnt = "0";
				ch8Scnt = "0";
				ch8Tcnt = "0";	
				break;
			case 28:	case 29:	case 30:				
				ch8Scnt = "0";
				ch8Tcnt = "0";	
				break;
			case 31:	case 32:	case 33:				
				ch8Tcnt = "0";	
				break;
			case 34:				
				break;
			default:
				break;
		}
		
		params.put("ch1cnt", 	ch1cnt);
		params.put("ch2cnt", 	ch2cnt);
		params.put("ch3cnt", 	ch3cnt);
		params.put("ch4cnt", 	ch4cnt);
		params.put("ch5cnt", 	ch5cnt);
		params.put("ch6cnt", 	ch6cnt);
		params.put("ch7Rcnt", 	ch7Rcnt);
		params.put("ch7Scnt", 	ch7Scnt);
		params.put("ch7Tcnt", 	ch7Tcnt);
		params.put("ch8Rcnt", 	ch8Rcnt);
		params.put("ch8Scnt", 	ch8Scnt);
		params.put("ch8Tcnt", 	ch8Tcnt);
		
		svc.saveElecChannelCnt( params );
		
		params.put("EC1S", 			ElecChannelStatus[0]);
		params.put("EC2S", 			ElecChannelStatus[1]);
		params.put("EC3S", 			ElecChannelStatus[2]);
		params.put("EC4S", 			ElecChannelStatus[3]);
		params.put("EC5S", 			ElecChannelStatus[4]);
		params.put("EC6S", 			ElecChannelStatus[5]);
		params.put("EC7RS",			ElecChannelStatus[6]);
		params.put("EC7SS", 		ElecChannelStatus[7]);
		params.put("EC7TS", 		ElecChannelStatus[8]);
		params.put("EC8RS", 		ElecChannelStatus[9]);
		params.put("EC8SS", 		ElecChannelStatus[10]);
		params.put("EC8TS", 		ElecChannelStatus[11]);
		
		params.put("EC1Acc", 		ElecAcc[0]);
		params.put("EC2Acc", 		ElecAcc[1]);
		params.put("EC3Acc", 		ElecAcc[2]);
		params.put("EC4Acc", 		ElecAcc[3]);
		params.put("EC5Acc", 		ElecAcc[4]);
		params.put("EC6Acc", 		ElecAcc[5]);
		params.put("EC7RAcc",		ElecAcc[6]);
		params.put("EC7SAcc", 		ElecAcc[7]);
		params.put("EC7TAcc", 		ElecAcc[8]);
		params.put("EC8RAcc", 		ElecAcc[9]);
		params.put("EC8SAcc", 		ElecAcc[10]);
		params.put("EC8TAcc", 		ElecAcc[11]);
		
		params.put("EC1Inst", 		ElecInst[0]);
		params.put("EC2Inst", 		ElecInst[1]);
		params.put("EC3Inst", 		ElecInst[2]);
		params.put("EC4Inst", 		ElecInst[3]);
		params.put("EC5Inst", 		ElecInst[4]);
		params.put("EC6Inst", 		ElecInst[5]);
		params.put("EC7RInst",		ElecInst[6]);
		params.put("EC7SInst", 		ElecInst[7]);
		params.put("EC7TInst", 		ElecInst[8]);
		params.put("EC8RInst", 		ElecInst[9]);
		params.put("EC8SInst", 		ElecInst[10]);
		params.put("EC8TInst", 		ElecInst[11]);
		
		
		
		// HACON
		JSONArray HaconInfoList = 	jo.getJSONArray("HaconInfoList");
		
		String[] HaconStatus = 	new String[]{"0","0","0","0","0"};
		String[] HaconExist = 	new String[]{"0","0","0","0","0"};
		String[] HaconTempS = 	new String[]{"0","0","0","0","0"};
		
		String[] HaconTemp = 	new String[]{"0","0","0","0","0"};
		String[] HaconOnOff =	new String[]{"0","0","0","0","0"};
		
		DecimalFormat d1 = new DecimalFormat("0.00");
		
		for(int i=0; i<HaconInfoList.size(); i++)
		{
			JSONObject data = (JSONObject) HaconInfoList.get(i);			
			
			HaconStatus[i] = 		data.getString("Status");
			HaconExist[i] = 		data.getString("Exist");
			HaconTempS[i] = 		data.getString("Temp");
			HaconTemp[i] = 			d1.format( Double.valueOf( HaconTempS[i] ) * 0.01 );
			HaconOnOff[i] = 		data.getString("OnOff");
			
		}
		
		params.put("Hacon1Temp", 		HaconTemp[0]);
		params.put("Hacon2Temp", 		HaconTemp[1]);
		params.put("Hacon3Temp", 		HaconTemp[2]);
		params.put("Hacon4Temp", 		HaconTemp[3]);
		params.put("Hacon5Temp", 		HaconTemp[4]);
		
		params.put("Hacon1Exist", 		HaconExist[0]);
		params.put("Hacon2Exist", 		HaconExist[1]);
		params.put("Hacon3Exist", 		HaconExist[2]);
		params.put("Hacon4Exist", 		HaconExist[3]);
		params.put("Hacon5Exist", 		HaconExist[4]);
		
		params.put("Hacon1Status", 		HaconStatus[0]);
		params.put("Hacon2Status", 		HaconStatus[1]);
		params.put("Hacon3Status", 		HaconStatus[2]);
		params.put("Hacon4Status", 		HaconStatus[3]);
		params.put("Hacon5Status", 		HaconStatus[4]);
		
		params.put("Hacon1OnOff", 		HaconOnOff[0]);
		params.put("Hacon2OnOff", 		HaconOnOff[1]);
		params.put("Hacon3OnOff", 		HaconOnOff[2]);
		params.put("Hacon4OnOff", 		HaconOnOff[3]);
		params.put("Hacon5OnOff", 		HaconOnOff[4]);
		
		
		
		// T-SENSOR
		JSONArray TsensorInfoList = 	jo.getJSONArray("TSensorInfoList");
		
		String[] TsensorStatus = 	new String[]{"0","0","0","0","0"};
		String[] TsensorExist = 	new String[]{"0","0","0","0","0"};
		String[] TsensorTempS = 	new String[]{"0","0","0","0","0"};
		String[] TsensorTemp = 		new String[]{"0","0","0","0","0"};		
		
		DecimalFormat d2 = new DecimalFormat("0.00");
		
		for(int i=0; i<TsensorInfoList.size(); i++)
		{
			JSONObject data = (JSONObject) TsensorInfoList.get(i);			
			
			TsensorStatus[i] = 		data.getString("Status");
			TsensorExist[i] = 		data.getString("Exist");
			TsensorTempS[i] = 		data.getString("Temp");
			TsensorTemp[i] = 		d2.format(  Double.valueOf( TsensorTempS[i] ) * 0.01 );				
			
		}
		
		params.put("Tsensor1Temp", 		TsensorTemp[0]);
		params.put("Tsensor2Temp", 		TsensorTemp[1]);
		params.put("Tsensor3Temp", 		TsensorTemp[2]);
		params.put("Tsensor4Temp", 		TsensorTemp[3]);
		params.put("Tsensor5Temp", 		TsensorTemp[4]);
		
		params.put("Tsensor1Exist", 	TsensorExist[0]);
		params.put("Tsensor2Exist", 	TsensorExist[1]);
		params.put("Tsensor3Exist", 	TsensorExist[2]);
		params.put("Tsensor4Exist", 	TsensorExist[3]);
		params.put("Tsensor5Exist", 	TsensorExist[4]);
		
		params.put("Tsensor1Status", 	TsensorStatus[0]);
		params.put("Tsensor2Status", 	TsensorStatus[1]);
		params.put("Tsensor3Status", 	TsensorStatus[2]);
		params.put("Tsensor4Status", 	TsensorStatus[3]);
		params.put("Tsensor5Status", 	TsensorStatus[4]);		
	
		// SIGN
		JSONArray SignInfoList = 	jo.getJSONArray("SignInfoList");
		
		String SignNo = 	new String();
		String SignStatus = new String();
		String SignOnOff = 	new String();
		for(int i=0; i<SignInfoList.size(); i++)
		{
			JSONObject data = (JSONObject) SignInfoList.get(i);			
			
			SignNo = 		data.getString("SignNo");
			SignStatus = 	data.getString("Status");
			SignOnOff = 	data.getString("OnOff");
		}
	
		params.put("SignOnOff", 		SignOnOff );
		params.put("SignStatus", 		SignStatus );
			
		System.out.println( "params : " + params );
		
		int ble_check_mst_rslt = 		svc.retrieveREQ_NOTI_GW_INFO_BLE_CHECK_MST( params );			
		int ble_mst_rslt = 				svc.retrieveREQ_NOTI_GW_INFO_BLE_MST( params );		
		int ble_elec_rslt = 			svc.retrieveREQ_NOTI_GW_INFO_ELEC_MST( params );		
		int ble_sensor_rslt = 			svc.retrieveREQ_NOTI_GW_INFO_SENSOR_MST( params );
		
			
		svc.saveStoreCode( params );
		 


		JSONObject REQ_NOTI_GW_INFO = new JSONObject();
		
		JSONObject Result = new JSONObject();	
		
		if( ble_check_mst_rslt != 0 && ble_mst_rslt != 0 && ble_elec_rslt !=0 && ble_sensor_rslt != 0 )
		{
			Result.put( "Status", 				"T" );
			Result.put( "ErrorCode", 			"000" );
			Result.put( "ErrorMsg", 			"NoError" );	
		}
		else
		{
			Result.put( "Status", 				"F" );
			Result.put( "ErrorCode", 			"005" );
			Result.put( "ErrorMsg", 			"Error" );	
		}
		
		
		
		
		REQ_NOTI_GW_INFO.put("Name", 			"RES_REG_STORE");	
		REQ_NOTI_GW_INFO.put("Result",			Result);	
		
		String base64_REQ_NOTI_GW_INFO= "";
		
		
		try {
			base64_REQ_NOTI_GW_INFO = URLEncoder.encode(REQ_NOTI_GW_INFO.toString(), "UTF-8");
			base64_REQ_NOTI_GW_INFO = Base64.encodeBase64String(base64_REQ_NOTI_GW_INFO.getBytes());		
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		System.out.println( REQ_NOTI_GW_INFO.toString() );
		System.out.println( Base64.encodeBase64String( ( REQ_NOTI_GW_INFO.toString() ).getBytes() ) );		
		
		/*
		Thread t1 = new Thread(new ThreadEx()); 
		t1.start();
		*/
		
		
		
		return base64_REQ_NOTI_GW_INFO;
		
	}
	
	
		
	
	// G/W 및 매장 정보
	@RequestMapping(value = "/REQ_STORE_INFO", method = {RequestMethod.GET, RequestMethod.POST}, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String REQ_STORE_INFO(	
			@RequestParam(value = "cmd", required = false) String cmd,
			@RequestParam(value = "reqdata", required = false) String reqdata
			) {
		
		LOGGER.info("REQ_STORE_INFO" );
		
		System.out.println( cmd );
		System.out.println( reqdata );
		
		byte[] de_reqdata_byte;
		String de_reqdata = "";			
		try {			
			de_reqdata_byte = Base64.decodeBase64( reqdata );
			de_reqdata = URLDecoder.decode( new String( de_reqdata_byte), "UTF-8");
			
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		System.out.println( "decode : " + de_reqdata );
				
		// 파싱
		JSONObject jo = JSONObject.fromObject(de_reqdata);		
		
		String Name = jo.getString("Name");
		String ID = jo.getString("ID");
		String Pass = jo.getString("Pass");
		String MAC = jo.getString("MAC");
		
		MAC = MAC.replace(":", "");
		
		System.out.println( Name );
		System.out.println( ID );
		System.out.println( Pass );
		System.out.println( MAC );
		
		
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		
		params.put( "ID", ID.toLowerCase() );
		params.put( "Pass", Pass.toLowerCase() );
		params.put( "MAC", MAC );
		
		
		boolean flag1 = false;
		boolean flag2 = false;
		boolean flag3 = false;
		
		String StoreCode = " ";
		
		JSONObject ELECInfoList = new JSONObject();
		BleAuthVo elec_rslt = svc.retrieveREQ_STORE_INFO_ELEC( params );			// 채널 개수
		
		if( elec_rslt == null )
		{
			ELECInfoList.put("ChannelCnt", "0" );				// 메인전력 수집 개수
			StoreCode = " ";
			flag1 = true;
		}
		else
		{
			ELECInfoList.put("ChannelCnt", elec_rslt.getChannelCnt() );				// 전력 수집 채널 개수
			StoreCode = elec_rslt.getViewStrCd();
			flag1 = true;
		}
		
		List<BleAuthVo> temon_rslt = svc.retrieveREQ_STORE_INFO_TEMON( params );
		
		ArrayList PutTemonInfoList = new ArrayList();		
		JSONObject TemonInfo = new JSONObject();
		
		
		if( temon_rslt.size() == 0 )
		{			
			
			for(int i=0; i<5; i++ )
			{								
				ArrayList PutTemonInfo = new ArrayList();
				
				for(int j=0; j<16; j++)
				{
					
					JSONObject TemonInfoList = new JSONObject();
			
					TemonInfoList.put("PortNo", 	j+1 );
					TemonInfoList.put("DeviceType", "0" );								
					
					PutTemonInfo.add( TemonInfoList );
				}				
				
				TemonInfo.put("TemonInfo", PutTemonInfo);
				PutTemonInfoList.add( TemonInfo );
			}
			
			flag2 = true;
		}
		else
		{
			
			
			ArrayList PutTemonInfo1 = new ArrayList();
			ArrayList PutTemonInfo2 = new ArrayList();
			ArrayList PutTemonInfo3 = new ArrayList();
			ArrayList PutTemonInfo4 = new ArrayList();
			ArrayList PutTemonInfo5 = new ArrayList();
			
			
			
			
			for(int i=0; i<5; i++)
			{	
				for(int j=0; j<16; j++)
				{
					
					JSONObject TemonInfoList1 = new JSONObject();
					JSONObject TemonInfoList2 = new JSONObject();
					JSONObject TemonInfoList3 = new JSONObject();
					JSONObject TemonInfoList4 = new JSONObject();
					JSONObject TemonInfoList5 = new JSONObject();
					
					int ff = 0;
					switch( i )
					{
					case 0:
						
						
						for(int k=0; k<temon_rslt.size(); k++)
						{
							
							if( String.valueOf( i + 1 ).equals( temon_rslt.get(k).getTemonId()  ) )
							{
								if( String.valueOf( j + 1 ).equals( temon_rslt.get(k).getPortNo() ) )
								{
									System.out.println( " --- : " + temon_rslt.get(k).getDeviceType() );
									
									TemonInfoList1.put("PortNo", 	temon_rslt.get(k).getPortNo() );
									TemonInfoList1.put("DeviceType", temon_rslt.get(k).getDeviceType() );
									
									System.out.println( " !!! : " + temon_rslt.get(k).getDeviceType() );
									
									ff = 1;
									break;
								}
								
								
								
								
								
							}
						}
						if( ff == 0 )
						{
							System.out.println( " !! " );
							TemonInfoList1.put("PortNo", 	j+1 );
							TemonInfoList1.put("DeviceType", "1" );
							ff = 0;
						}								
						
						PutTemonInfo1.add( TemonInfoList1 );
					
					
						
						break;
					case 1:
						for(int k=0; k<temon_rslt.size(); k++)
						{
							
							if( String.valueOf( i + 1 ).equals( temon_rslt.get(k).getTemonId()  ) )
							{
								if( String.valueOf( j + 1 ).equals( temon_rslt.get(k).getPortNo() ) )
								{
									System.out.println( " --- : " + temon_rslt.get(k).getDeviceType() );
									
									TemonInfoList2.put("PortNo", 	temon_rslt.get(k).getPortNo() );
									TemonInfoList2.put("DeviceType", temon_rslt.get(k).getDeviceType() );
									
									System.out.println( " !!! : " + temon_rslt.get(k).getDeviceType() );
									
									ff = 1;
									break;
								}
								
							}
						}
						if( ff == 0 )
						{
							System.out.println( " !! " );
							TemonInfoList2.put("PortNo", 	j+1 );
							TemonInfoList2.put("DeviceType", "1" );
							ff = 0;
						}								
						
						PutTemonInfo2.add( TemonInfoList2 );
						break;
					case 2:
						for(int k=0; k<temon_rslt.size(); k++)
						{
							
							if( String.valueOf( i + 1 ).equals( temon_rslt.get(k).getTemonId()  ) )
							{
								if( String.valueOf( j + 1 ).equals( temon_rslt.get(k).getPortNo() ) )
								{
									System.out.println( " --- : " + temon_rslt.get(k).getDeviceType() );
									
									TemonInfoList3.put("PortNo", 	temon_rslt.get(k).getPortNo() );
									TemonInfoList3.put("DeviceType", temon_rslt.get(k).getDeviceType() );
									
									System.out.println( " !!! : " + temon_rslt.get(k).getDeviceType() );
									
									ff = 1;
									break;
								}
								
							}
						}
						if( ff == 0 )
						{
							System.out.println( " !! " );
							TemonInfoList3.put("PortNo", 	j+1 );
							TemonInfoList3.put("DeviceType", "1" );
							ff = 0;
						}								
						
						PutTemonInfo3.add( TemonInfoList3 );
						break;
					case 3:
						for(int k=0; k<temon_rslt.size(); k++)
						{
							
							if( String.valueOf( i + 1 ).equals( temon_rslt.get(k).getTemonId()  ) )
							{
								if( String.valueOf( j + 1 ).equals( temon_rslt.get(k).getPortNo() ) )
								{
									System.out.println( " --- : " + temon_rslt.get(k).getDeviceType() );
									
									TemonInfoList4.put("PortNo", 	temon_rslt.get(k).getPortNo() );
									TemonInfoList4.put("DeviceType", temon_rslt.get(k).getDeviceType() );
									
									System.out.println( " !!! : " + temon_rslt.get(k).getDeviceType() );
									
									ff = 1;
									break;
								}
								
							}
						}
						if( ff == 0 )
						{
							System.out.println( " !! " );
							TemonInfoList4.put("PortNo", 	j+1 );
							TemonInfoList4.put("DeviceType", "1" );
							ff = 0;
						}								
						
						PutTemonInfo4.add( TemonInfoList4 );
						break;
					case 4:
						for(int k=0; k<temon_rslt.size(); k++)
						{
							
							if( String.valueOf( i + 1 ).equals( temon_rslt.get(k).getTemonId()  ) )
							{
								if( String.valueOf( j + 1 ).equals( temon_rslt.get(k).getPortNo() ) )
								{
									System.out.println( " --- : " + temon_rslt.get(k).getDeviceType() );
									
									TemonInfoList5.put("PortNo", 	temon_rslt.get(k).getPortNo() );
									TemonInfoList5.put("DeviceType", temon_rslt.get(k).getDeviceType() );
									
									System.out.println( " !!! : " + temon_rslt.get(k).getDeviceType() );
									
									ff = 1;
									break;
								}
								
							}
						}
						if( ff == 0 )
						{
							System.out.println( " !! " );
							TemonInfoList5.put("PortNo", 	j+1 );
							TemonInfoList5.put("DeviceType", "1" );
							ff = 0;
						}								
						
						PutTemonInfo5.add( TemonInfoList5 );
						break;					
					default:
						
						break;						
					}				
				
					
					
				}
			}
			
			JSONObject TemonInfo1 = new JSONObject();
			JSONObject TemonInfo2 = new JSONObject();
			JSONObject TemonInfo3 = new JSONObject();
			JSONObject TemonInfo4 = new JSONObject();
			JSONObject TemonInfo5 = new JSONObject();
			
			TemonInfo1.put("TemonInfo", PutTemonInfo1);			
			TemonInfo2.put("TemonInfo", PutTemonInfo2);			
			TemonInfo3.put("TemonInfo", PutTemonInfo3);						
			TemonInfo4.put("TemonInfo", PutTemonInfo4);			
			TemonInfo5.put("TemonInfo", PutTemonInfo5);
			
			PutTemonInfoList.add( TemonInfo1 );
			PutTemonInfoList.add( TemonInfo2 );
			PutTemonInfoList.add( TemonInfo3 );
			PutTemonInfoList.add( TemonInfo4 );
			PutTemonInfoList.add( TemonInfo5 );
			
			
			flag2 = true;
		}
		
			
		List<BleAuthVo> zigbee_rslt = svc.retrieveREQ_STORE_INFO_ZIGBEE( params );
		
		ArrayList PutZigbeeInfoList = new ArrayList();		
		JSONObject ZigbeeInfo = new JSONObject();
		
		System.out.println("ccc : " + zigbee_rslt.size());
		if( zigbee_rslt.size() == 0 )
		{			
			for(int i=0; i<5; i++ )
			{				
				
				ArrayList PutZigbeeInfo = new ArrayList();
				
				for(int j=0; j<16; j++)
				{
					
					JSONObject ZigbeeInfoList = new JSONObject();
					
				
					ZigbeeInfoList.put("PortNo", 	j+1 );
					ZigbeeInfoList.put("DeviceType", "0" );
									
					PutZigbeeInfo.add( ZigbeeInfoList );		
						
					
				}				
				ZigbeeInfo.put("ZigbeeInfo", PutZigbeeInfo);
				PutZigbeeInfoList.add( ZigbeeInfo );				
			}
			
			flag3 = true;
		}
		else
		{
			ArrayList PutZigbeeInfo1 = new ArrayList();
			ArrayList PutZigbeeInfo2 = new ArrayList();
			ArrayList PutZigbeeInfo3 = new ArrayList();
			ArrayList PutZigbeeInfo4 = new ArrayList();
			ArrayList PutZigbeeInfo5 = new ArrayList();
			
			
			
			
			for(int i=0; i<5; i++)
			{	
				for(int j=0; j<16; j++)
				{
					
					JSONObject ZigbeeInfoList1 = new JSONObject();
					JSONObject ZigbeeInfoList2 = new JSONObject();
					JSONObject ZigbeeInfoList3 = new JSONObject();
					JSONObject ZigbeeInfoList4 = new JSONObject();
					JSONObject ZigbeeInfoList5 = new JSONObject();
					
					int ff = 0;
					switch( i )
					{
					case 0:
						
						
						for(int k=0; k<zigbee_rslt.size(); k++)
						{
							
							if( String.valueOf( i + 1 ).equals( zigbee_rslt.get(k).getTemonId()  ) )
							{
								if( String.valueOf( j + 1 ).equals( zigbee_rslt.get(k).getPortNo() ) )
								{
									System.out.println( " --- : " + zigbee_rslt.get(k).getDeviceType() );
									
									ZigbeeInfoList1.put("PortNo", 	zigbee_rslt.get(k).getPortNo() );
									ZigbeeInfoList1.put("DeviceType", zigbee_rslt.get(k).getDeviceType() );
									
									System.out.println( " !!! : " + zigbee_rslt.get(k).getDeviceType() );
									
									ff = 1;
									break;
								}
								
							}
						}
						if( ff == 0 )
						{
							System.out.println( " !! " );
							ZigbeeInfoList1.put("PortNo", 	j+1 );
							ZigbeeInfoList1.put("DeviceType", "1" );
							ff = 0;
						}								
						
						PutZigbeeInfo1.add( ZigbeeInfoList1 );
					
					
						
						break;
					case 1:
						for(int k=0; k<zigbee_rslt.size(); k++)
						{
							
							if( String.valueOf( i + 1 ).equals( zigbee_rslt.get(k).getTemonId()  ) )
							{
								if( String.valueOf( j + 1 ).equals( zigbee_rslt.get(k).getPortNo() ) )
								{
									System.out.println( " --- : " + zigbee_rslt.get(k).getDeviceType() );
									
									ZigbeeInfoList2.put("PortNo", 	zigbee_rslt.get(k).getPortNo() );
									ZigbeeInfoList2.put("DeviceType", zigbee_rslt.get(k).getDeviceType() );
									
									System.out.println( " !!! : " + zigbee_rslt.get(k).getDeviceType() );
									
									ff = 1;
									break;
								}
								
							}
						}
						if( ff == 0 )
						{
							System.out.println( " !! " );
							ZigbeeInfoList2.put("PortNo", 	j+1 );
							ZigbeeInfoList2.put("DeviceType", "1" );
							ff = 0;
						}								
						
						PutZigbeeInfo2.add( ZigbeeInfoList2 );
						break;
					case 2:
						for(int k=0; k<zigbee_rslt.size(); k++)
						{
							
							if( String.valueOf( i + 1 ).equals( zigbee_rslt.get(k).getTemonId()  ) )
							{
								if( String.valueOf( j + 1 ).equals( zigbee_rslt.get(k).getPortNo() ) )
								{
									System.out.println( " --- : " + zigbee_rslt.get(k).getDeviceType() );
									
									ZigbeeInfoList3.put("PortNo", 	zigbee_rslt.get(k).getPortNo() );
									ZigbeeInfoList3.put("DeviceType", zigbee_rslt.get(k).getDeviceType() );
									
									System.out.println( " !!! : " + zigbee_rslt.get(k).getDeviceType() );
									
									ff = 1;
									break;
								}
								
							}
						}
						if( ff == 0 )
						{
							System.out.println( " !! " );
							ZigbeeInfoList3.put("PortNo", 	j+1 );
							ZigbeeInfoList3.put("DeviceType", "1" );
							ff = 0;
						}								
						
						PutZigbeeInfo3.add( ZigbeeInfoList3 );
						break;
					case 3:
						for(int k=0; k<zigbee_rslt.size(); k++)
						{
							
							if( String.valueOf( i + 1 ).equals( zigbee_rslt.get(k).getTemonId()  ) )
							{
								if( String.valueOf( j + 1 ).equals( zigbee_rslt.get(k).getPortNo() ) )
								{
									System.out.println( " --- : " + zigbee_rslt.get(k).getDeviceType() );
									
									ZigbeeInfoList4.put("PortNo", 	zigbee_rslt.get(k).getPortNo() );
									ZigbeeInfoList4.put("DeviceType", zigbee_rslt.get(k).getDeviceType() );
									
									System.out.println( " !!! : " + zigbee_rslt.get(k).getDeviceType() );
									
									ff = 1;
									break;
								}
								
							}
						}
						if( ff == 0 )
						{
							System.out.println( " !! " );
							ZigbeeInfoList4.put("PortNo", 	j+1 );
							ZigbeeInfoList4.put("DeviceType", "1" );
							ff = 0;
						}								
						
						PutZigbeeInfo4.add( ZigbeeInfoList4 );
						break;
					case 4:
						for(int k=0; k<zigbee_rslt.size(); k++)
						{
							
							if( String.valueOf( i + 1 ).equals( zigbee_rslt.get(k).getTemonId()  ) )
							{
								if( String.valueOf( j + 1 ).equals( zigbee_rslt.get(k).getPortNo() ) )
								{
									System.out.println( " --- : " + zigbee_rslt.get(k).getDeviceType() );
									
									ZigbeeInfoList5.put("PortNo", 	zigbee_rslt.get(k).getPortNo() );
									ZigbeeInfoList5.put("DeviceType", zigbee_rslt.get(k).getDeviceType() );
									
									System.out.println( " !!! : " + zigbee_rslt.get(k).getDeviceType() );
									
									ff = 1;
									break;
								}
								
							}
						}
						if( ff == 0 )
						{
							System.out.println( " !! " );
							ZigbeeInfoList5.put("PortNo", 	j+1 );
							ZigbeeInfoList5.put("DeviceType", "1" );
							ff = 0;
						}								
						
						PutZigbeeInfo5.add( ZigbeeInfoList5 );
						break;					
					default:
						
						break;						
					}				
				
					
					
				}
			}
			
			JSONObject ZigbeeInfo1 = new JSONObject();
			JSONObject ZigbeeInfo2 = new JSONObject();
			JSONObject ZigbeeInfo3 = new JSONObject();
			JSONObject ZigbeeInfo4 = new JSONObject();
			JSONObject ZigbeeInfo5 = new JSONObject();
			
			ZigbeeInfo1.put("ZigbeeInfo", PutZigbeeInfo1);			
			ZigbeeInfo2.put("ZigbeeInfo", PutZigbeeInfo2);			
			ZigbeeInfo3.put("ZigbeeInfo", PutZigbeeInfo3);						
			ZigbeeInfo4.put("ZigbeeInfo", PutZigbeeInfo4);			
			ZigbeeInfo5.put("ZigbeeInfo", PutZigbeeInfo5);
			
			PutZigbeeInfoList.add( ZigbeeInfo1 );
			PutZigbeeInfoList.add( ZigbeeInfo2 );
			PutZigbeeInfoList.add( ZigbeeInfo3 );
			PutZigbeeInfoList.add( ZigbeeInfo4 );
			PutZigbeeInfoList.add( ZigbeeInfo5 );
			
			//System.out.println( "!! : " + PutZigbeeInfoList );
			
			flag3 = true;
		}
		
		JSONObject REQ_STORE_INFO = new JSONObject();		
		JSONObject Result = new JSONObject();
								
		if( flag1 && flag2 && flag3 )					// 전력수집개수, 테몬정보, 지그비 정보 모두 성공
		{
			Result.put( "Status", 			"T" );
			Result.put( "ErrorCode", 		"000" );
			Result.put( "ErrorMsg", 		"Success" );
		}
		else											// 하나라도 실패
		{
			Result.put( "Status", 			"F" );
			Result.put( "ErrorCode", 		"001" );
			Result.put( "ErrorMsg", 		"Error" );
			
		}
		
		REQ_STORE_INFO.put("Name", 				"RES_STORE_INFO");
		REQ_STORE_INFO.put("Result", 			Result );
		REQ_STORE_INFO.put("StoreCode",			StoreCode);					// 점포코드
		REQ_STORE_INFO.put("ELECInfoList",		ELECInfoList);				// 전력 수집 개수( 채널 )
		REQ_STORE_INFO.put("TemonInfoList",		PutTemonInfoList );			// 테몬 정보( 5개 )
		REQ_STORE_INFO.put("ZigbeeInfoList",	PutZigbeeInfoList );		// 지그비 정보( 5개 )		
		
		String base64_REQ_STORE_INFO = Base64.encodeBase64String( ( REQ_STORE_INFO.toString() ).getBytes() );
		
		try {
			base64_REQ_STORE_INFO = URLEncoder.encode(REQ_STORE_INFO.toString(), "UTF-8");
			base64_REQ_STORE_INFO = Base64.encodeBase64String(base64_REQ_STORE_INFO.getBytes());		
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		
		
		System.out.println( REQ_STORE_INFO.toString() );
		System.out.println( Base64.encodeBase64String( ( REQ_STORE_INFO.toString() ).getBytes() ) );
		
		
		return base64_REQ_STORE_INFO;
		
		
	}
	
	

	
	class ThreadEx implements Runnable
	{ 
		public void run()
		{ 
			
			System.out.println( "zzz : " + de_reqdata2 );
			
			
			HashMap<String,Object> params = new HashMap<String,Object>();
			
			// 파싱
			JSONObject jo = JSONObject.fromObject(de_reqdata2);	
			
			String Name = 				jo.getString("Name");
			String ID = 				jo.getString("ID");
			String Pass = 				jo.getString("Pass");
			String UserName = 			jo.getString("UserName");				
			String UserType = 			jo.getString("UserType");
			
			String gwIp =				jo.getString("IP");
			String gwNetmask =			jo.getString("NETMASK");
			String gwGateway =			jo.getString("GATEWAY");
			
			String ifIp =				jo.getString("IFIP");
			String ifPort =				jo.getString("IFPORT");
			
			String MAC = 				jo.getString("MAC");
			String StoreCode = 			jo.getString("StoreCode");
			String StoreName = 			jo.getString("StoreName");		
			String NotiDateTime = 		jo.getString("NotiDateTime");		
						
			String ElecUseChannel = 	jo.getString("ElecUseChannel");
			String RST = 				jo.getString("RSTBreaker");
			
			JSONArray ElecInfoList = 	jo.getJSONArray("ElecInfoList");		
			JSONArray TemonInfoList = 	jo.getJSONArray("TemonInfoList");
			JSONArray ZigbeeInfoList = 	jo.getJSONArray("ZigbeeInfoList");
					
			params.put("ID", 		ID);
			params.put("Pass", 		Pass);
			params.put("MAC", 		MAC.replace(":", ""));
			
			params.put("gwIp", 			gwIp);
			params.put("gwNetmask", 	gwNetmask);
			params.put("gwGateway", 	gwGateway);
			params.put("ifIp", 			ifIp);
			params.put("ifPort", 		ifPort);
			
			
			BleAuthVo rslt1 = svc.retrieveREQ_AUTH_USER( params );
			BleAuthVo rslt2 = svc.retrieveREQ_VERIFY_BLE( params );
			
			
			String[] ElecChannelNo = new String[12];
			String[] ElecChannelStatus = new String[12];
			String[] ElecAcc = new String[12];
			String[] ElecInst = new String[12];	
			
			for(int i=0; i<ElecInfoList.size(); i++)
			{
				JSONObject data = (JSONObject) ElecInfoList.get(i);			
				
				ElecChannelNo[i] = 		data.getString("ChannelNo");
				ElecChannelStatus[ Integer.valueOf( ElecChannelNo[i] ) - 1 ] = 	data.getString("Status");
				ElecAcc[i] = 			data.getString("Acc");
				ElecInst[i] = 			data.getString("Inst");			
			}
					
					
			///////////////////////////////////////////////// TEMON ///////////////////////////////////////////////////
			
			
			String[] deviceNm = new String[25];
			
			deviceNm[0] = 	"없음";
			deviceNm[1] = 	"WIC1";
			deviceNm[2] = 	"WIC2";
			deviceNm[3] = 	"OSC1";
			deviceNm[4] = 	"OSC2";
			deviceNm[5] = 	"OSC3";
			deviceNm[6] = 	"OSC4";
			deviceNm[7] = 	"RIC1";
			deviceNm[8] = 	"RIC2";
			deviceNm[9] = 	"RIF1";
			deviceNm[10] =	"RIF2";
			deviceNm[11] = "RIF3";
			deviceNm[12] = "ICC1";
			deviceNm[13] = "ICC2";
			deviceNm[14] = "ICC3";
			deviceNm[15] = "냉동평대1";
			deviceNm[16] = "냉동평대2";
			deviceNm[17] = "냉동평대3";
			deviceNm[18] = "냉동콤비1(상)";
			deviceNm[19] = "냉동콤비1(하)";
			deviceNm[20] = "냉동콤비2(상)";
			deviceNm[21] = "냉동콤비2(하)";
			deviceNm[22] = "냉동콤비3(상)";
			deviceNm[23] = "냉동콤비3(하)";
			deviceNm[24] = "기타";
			
			for(int i=0; i<TemonInfoList.size(); i++)
			{
				JSONObject data = (JSONObject)TemonInfoList.get(i);
				
				String Exist = 		data.getString("Exist");
				String No = 		data.getString("TemonNo");
				JSONArray Temp = 	data.getJSONArray("TemonPortList");			
				
				if( "1".equals( Exist ))			// TEMON 이 존재하면
				{		
					for(int j=0; j<16; j++ )
					{				
						
						HashMap<String,Object> temonParams = new HashMap<String,Object>();
						
						JSONObject data2 = 		(JSONObject) Temp.get(j);			
						
						
						temonParams.put("strCd", 			rslt2.getStrCd());					
						temonParams.put("userType", 		UserType);						
						temonParams.put("notiDateTime",		NotiDateTime );
						
						temonParams.put("id", 				No);
						temonParams.put("type", 			"T");
						temonParams.put("portNo", 			data2.getString("PortNo"));
										
						
						int deviceType = Integer.valueOf( data2.getString("DeviceType")); 
						String deviceLoc = deviceNm[ deviceType ];					
						temonParams.put("deviceLoc", 		deviceLoc );
						
						if( "-128".equals( data2.getString("Temp") ) && "2".equals( data2.getString("Status")) )
							temonParams.put("temp", 		null);
						else
							temonParams.put("temp", 		data2.getString("Temp"));
						
						
						
						if( deviceType == 1 || deviceType == 2 )		// WIC
						{
							temonParams.put("deviceType", 		"W");	
							temonParams.put("maxTemp", 			"15");
							temonParams.put("minTemp", 			"2");
							temonParams.put("delayTime", 		"180");
							
						}else if( deviceType == 3 || deviceType == 4 || deviceType == 5 || deviceType == 6 )		// OSC
						{
							temonParams.put("deviceType", 		"O");
							temonParams.put("maxTemp", 			"15");
							temonParams.put("minTemp", 			"2");
							temonParams.put("delayTime", 		"35");
						
						}else if( deviceType == 7 || deviceType == 8 )		// RIC
						{
							temonParams.put("deviceType", 		"R");
							temonParams.put("maxTemp", 			"10");
							temonParams.put("minTemp", 			"-10");
							temonParams.put("delayTime", 		"40");
						
						}else if( deviceType == 9 || deviceType == 10 || deviceType == 11 )		// RIF
						{
							temonParams.put("deviceType", 		"R");
							temonParams.put("maxTemp", 			"-10");
							temonParams.put("minTemp", 			"-50");
							temonParams.put("delayTime", 		"20");
							
						}else if( deviceType == 12 || deviceType == 13 || deviceType == 14 )		// ICC
						{
							temonParams.put("deviceType", 		"I");
							temonParams.put("maxTemp", 			"-10");
							temonParams.put("minTemp", 			"-50");
							temonParams.put("delayTime", 		"20");
						
						}else if( deviceType == 15 || deviceType == 16 || deviceType == 17 )		// 냉동평대
						{
							temonParams.put("deviceType", 		"I");
							temonParams.put("maxTemp", 			"-10");
							temonParams.put("minTemp", 			"-50");
							temonParams.put("delayTime", 		"20");
											
						}else if( deviceType == 18 || deviceType == 19 || deviceType == 20 || deviceType == 21 || deviceType == 22 || deviceType == 23 )		// 냉동콤비
						{
							temonParams.put("deviceType", 		"I");
							temonParams.put("maxTemp", 			"-10");
							temonParams.put("minTemp", 			"-50");
							temonParams.put("delayTime", 		"20");
						}
						else
						{
							temonParams.put("deviceType", 		"R");
							temonParams.put("maxTemp", 			"50");
							temonParams.put("minTemp", 			"-50");
							temonParams.put("delayTime", 		"180");
							
						}
						
						/*
						if( "1".equals( data2.getString("Status")))
							temonParams.put("useYn", 			"Y");
						else
							temonParams.put("useYn", 			"N");
						*/
						temonParams.put("useYn", 			"Y");
						
						temonParams.put("pushTerm", 		"180");
						
						temonParams.put("battery", 			null);
						temonParams.put("rssi", 			null);
						temonParams.put("status", 		data2.getString("Status"));
						
						
						
						svc.retrieveREQ_NOTI_GW_INFO_DEVICE_MST( temonParams );					
											
						// 테몬 마스터에 정보 업데이트
						svc.saveGwInfoDeviceMst( temonParams );
						
					}
					
					
					
				}
				else
				{
					continue;
				}		
			}
			
					
					
			///////////////////////////////////////////////// ZIGBEE ///////////////////////////////////////////////////
			for(int i=0; i<ZigbeeInfoList.size(); i++)
			{
				JSONObject data = (JSONObject)ZigbeeInfoList.get(i);
				
				String Exist = 		data.getString("Exist");
				String No = 		data.getString("ZigbeeNo");
				JSONArray Temp = 	data.getJSONArray("ZigbeePortList");			
				
				if( "1".equals( Exist ))			// Zigbee 이 존재하면
				{		
					for(int j=0; j<16; j++ )
					{				
				
						HashMap<String,Object> zigbeeParams = new HashMap<String,Object>();
						
						JSONObject data2 = 		(JSONObject) Temp.get(j);
						
						zigbeeParams.put("strCd", 			rslt2.getStrCd());					
						zigbeeParams.put("userType", 		UserType);						
						zigbeeParams.put("notiDateTime",	NotiDateTime );
						
						zigbeeParams.put("id", 				No);
						zigbeeParams.put("type", 			"Z");
						zigbeeParams.put("portNo", 			data2.getString("PortNo"));
						
						
						int deviceType = Integer.valueOf( data2.getString("DeviceType")); 
						String deviceLoc = deviceNm[ deviceType ];					
						zigbeeParams.put("deviceLoc", 		deviceLoc );
						
						
						if( deviceType == 1 || deviceType == 2 )		// WIC
						{
							zigbeeParams.put("deviceType", 		"W");	
							zigbeeParams.put("maxTemp", 		"15");
							zigbeeParams.put("minTemp", 		"2");
							zigbeeParams.put("delayTime", 		"180");
							
						}else if( deviceType == 3 || deviceType == 4 || deviceType == 5 || deviceType == 6 )		// OSC
						{
							zigbeeParams.put("deviceType", 		"O");
							zigbeeParams.put("maxTemp", 		"15");
							zigbeeParams.put("minTemp", 		"2");
							zigbeeParams.put("delayTime", 		"35");
						
						}else if( deviceType == 7 || deviceType == 8 )		// RIC
						{
							zigbeeParams.put("deviceType", 		"R");
							zigbeeParams.put("maxTemp", 		"10");
							zigbeeParams.put("minTemp", 		"-10");
							zigbeeParams.put("delayTime", 		"40");
						
						}else if( deviceType == 9 || deviceType == 10 || deviceType == 11 )		// RIF
						{
							zigbeeParams.put("deviceType", 		"R");
							zigbeeParams.put("maxTemp", 		"-10");
							zigbeeParams.put("minTemp", 		"-50");
							zigbeeParams.put("delayTime", 		"20");
							
						}else if( deviceType == 12 || deviceType == 13 || deviceType == 14 )		// ICC
						{
							zigbeeParams.put("deviceType", 		"I");
							zigbeeParams.put("maxTemp", 		"-10");
							zigbeeParams.put("minTemp", 		"-50");
							zigbeeParams.put("delayTime", 		"20");
						
						}else if( deviceType == 15 || deviceType == 16 || deviceType == 17 )		// 냉동평대
						{
							zigbeeParams.put("deviceType", 		"I");
							zigbeeParams.put("maxTemp", 		"-10");
							zigbeeParams.put("minTemp", 		"-50");
							zigbeeParams.put("delayTime", 		"20");
											
						}else if( deviceType == 18 || deviceType == 19 || deviceType == 20 || deviceType == 21 || deviceType == 22 || deviceType == 23 )		// 냉동콤비
						{
							zigbeeParams.put("deviceType", 		"I");
							zigbeeParams.put("maxTemp", 		"-10");
							zigbeeParams.put("minTemp", 		"-50");
							zigbeeParams.put("delayTime", 		"20");
						}
						else
						{
							zigbeeParams.put("deviceType", 		"R");
							zigbeeParams.put("maxTemp", 		"50");
							zigbeeParams.put("minTemp", 		"-50");
							zigbeeParams.put("delayTime", 		"180");						
						}
						
						zigbeeParams.put("temp", 			data2.getString("Temp"));
						
						/*
						if( "1".equals( data2.getString("Status")))
							zigbeeParams.put("useYn", 		"Y");
						else
							zigbeeParams.put("useYn", 		"N");	
						*/
						
						zigbeeParams.put("useYn", 		"Y");
						
						zigbeeParams.put("pushTerm", 		"180");
						zigbeeParams.put("battery", 		data2.getString("Battery"));
						zigbeeParams.put("rssi", 			data2.getString("Rssi"));
						zigbeeParams.put("status", 			data2.getString("Status"));					
						
						svc.retrieveREQ_NOTI_GW_INFO_DEVICE_MST( zigbeeParams );
						
						// 테몬 마스터에 정보 업데이트
						svc.saveGwInfoDeviceMst( zigbeeParams );
					}
					
				}
				else
				{
				continue;
				}		
			}
			
			params.put("strCd", 		rslt2.getStrCd());
			params.put("strNm", 		rslt2.getStrNm());
			params.put("gwId", 			rslt2.getGwId());		
			params.put("userName", 		UserName);
			params.put("userType", 		UserType);				
			params.put("storeCode", 	StoreCode);
			params.put("storeName", 	StoreName);
			
			
			if( "1".equals( UserType ) )			// 전기업체
			{
				params.put("elecCheck", 	"1");
				params.put("sensorCheck", 	"0");
				params.put("networkCheck",  "0");
				params.put("signCheck", 	"0");
				params.put("vendorCd", 		rslt1.getVendorCd());
				params.put("vendorNm", 		rslt1.getType1Nm());
			}else if( "2".equals( UserType ) )		// 냉장비 업체
			{
				params.put("elecCheck", 	"0");
				params.put("sensorCheck", 	"1");
				params.put("networkCheck",  "0");
				params.put("signCheck", 	"0");
				params.put("vendorCd", 		rslt1.getVendorCd());			
				params.put("vendorNm", 		rslt1.getType2Nm());
			}else if( "3".equals( UserType ) )		// 시스네트
			{
				params.put("elecCheck", 	"0");
				params.put("sensorCheck", 	"0");
				params.put("networkCheck", 	"1");
				params.put("signCheck", 	"0");
				params.put("vendorCd", 		rslt1.getVendorCd());			
				params.put("vendorNm", 		rslt1.getType3Nm());
				
				
				// 사용자 계정 생성
				svc.saveUserMst(params);			
				svc.saveUserAuth(params);
				svc.saveUserStrMap(params);
				
				
			}else if( "4".equals( UserType ) )		// 간판업체
			{
				params.put("elecCheck", 	"0");
				params.put("sensorCheck", 	"0");
				params.put("networkCheck", 	"0");
				params.put("signCheck", 	"1");
				params.put("vendorCd", 		rslt1.getVendorCd());			
				params.put("vendorNm", 		rslt1.getType4Nm());
				
				
			}
			
			params.put("notiDateTime", NotiDateTime );	
			
			params.put("RST", 			RST);
			params.put("EpCnt",			ElecUseChannel);
			
			int chcnt = Integer.valueOf( ElecUseChannel );
			
			String ch1cnt 	= "1";
			String ch2cnt 	= "1";
			String ch3cnt 	= "1";
			String ch4cnt 	= "1";
			String ch5cnt 	= "1";
			String ch6cnt 	= "1";
			String ch7Rcnt 	= "1";
			String ch7Scnt 	= "1";
			String ch7Tcnt	= "1";
			String ch8Rcnt 	= "1";
			String ch8Scnt 	= "1";
			String ch8Tcnt 	= "1";
			
			switch( chcnt )
			{
				case 0:
					ch1cnt 	= "0";
					ch2cnt 	= "0";
					ch3cnt 	= "0";
					ch4cnt 	= "0";
					ch5cnt 	= "0";
					ch6cnt 	= "0";
					ch7Rcnt = "0";
					ch7Scnt = "0";
					ch7Tcnt = "0";
					ch8Rcnt = "0";
					ch8Scnt = "0";
					ch8Tcnt = "0";				
					break;
				case 1:				
					ch2cnt 	= "0";
					ch3cnt 	= "0";
					ch4cnt 	= "0";
					ch5cnt 	= "0";
					ch6cnt 	= "0";
					ch7Rcnt = "0";
					ch7Scnt = "0";
					ch7Tcnt = "0";
					ch8Rcnt = "0";
					ch8Scnt = "0";
					ch8Tcnt = "0";	
					break;
				case 2:				
					ch3cnt 	= "0";
					ch4cnt 	= "0";
					ch5cnt 	= "0";
					ch6cnt 	= "0";
					ch7Rcnt = "0";
					ch7Scnt = "0";
					ch7Tcnt = "0";
					ch8Rcnt = "0";
					ch8Scnt = "0";
					ch8Tcnt = "0";	
					break;
				case 3:				
					ch4cnt 	= "0";
					ch5cnt 	= "0";
					ch6cnt 	= "0";
					ch7Rcnt = "0";
					ch7Scnt = "0";
					ch7Tcnt = "0";
					ch8Rcnt = "0";
					ch8Scnt = "0";
					ch8Tcnt = "0";	
					break;
				case 4:			
					ch5cnt 	= "0";
					ch6cnt 	= "0";
					ch7Rcnt = "0";
					ch7Scnt = "0";
					ch7Tcnt = "0";
					ch8Rcnt = "0";
					ch8Scnt = "0";
					ch8Tcnt = "0";	
					break;
				case 5:				
					ch6cnt 	= "0";
					ch7Rcnt = "0";
					ch7Scnt = "0";
					ch7Tcnt = "0";
					ch8Rcnt = "0";
					ch8Scnt = "0";
					ch8Tcnt = "0";	
					break;
				case 6:				
					ch7Rcnt = "0";
					ch7Scnt = "0";
					ch7Tcnt = "0";
					ch8Rcnt = "0";
					ch8Scnt = "0";
					ch8Tcnt = "0";	
					break;
				case 7:				
					ch7Scnt = "0";
					ch7Tcnt = "0";
					ch8Rcnt = "0";
					ch8Scnt = "0";
					ch8Tcnt = "0";	
					break;
				case 8:				
					ch7Tcnt = "0";
					ch8Rcnt = "0";
					ch8Scnt = "0";
					ch8Tcnt = "0";	
					break;
				case 9:
					ch8Rcnt = "0";
					ch8Scnt = "0";
					ch8Tcnt = "0";	
					break;
				case 10:				
					ch8Scnt = "0";
					ch8Tcnt = "0";	
					break;
				case 11:				
					ch8Tcnt = "0";	
					break;
				case 12:				
					break;
				default:
					break;
			}
			
			params.put("ch1cnt", 	ch1cnt);
			params.put("ch2cnt", 	ch2cnt);
			params.put("ch3cnt", 	ch3cnt);
			params.put("ch4cnt", 	ch4cnt);
			params.put("ch5cnt", 	ch5cnt);
			params.put("ch6cnt", 	ch6cnt);
			params.put("ch7Rcnt", 	ch7Rcnt);
			params.put("ch7Scnt", 	ch7Scnt);
			params.put("ch7Tcnt", 	ch7Tcnt);
			params.put("ch8Rcnt", 	ch8Rcnt);
			params.put("ch8Scnt", 	ch8Scnt);
			params.put("ch8Tcnt", 	ch8Tcnt);
			
			svc.saveElecChannelCnt( params );
			
			params.put("EC1S", 			ElecChannelStatus[0]);
			params.put("EC2S", 			ElecChannelStatus[1]);
			params.put("EC3S", 			ElecChannelStatus[2]);
			params.put("EC4S", 			ElecChannelStatus[3]);
			params.put("EC5S", 			ElecChannelStatus[4]);
			params.put("EC6S", 			ElecChannelStatus[5]);
			params.put("EC7RS",			ElecChannelStatus[6]);
			params.put("EC7SS", 		ElecChannelStatus[7]);
			params.put("EC7TS", 		ElecChannelStatus[8]);
			params.put("EC8RS", 		ElecChannelStatus[9]);
			params.put("EC8SS", 		ElecChannelStatus[10]);
			params.put("EC8TS", 		ElecChannelStatus[11]);
			
			params.put("EC1Acc", 		ElecAcc[0]);
			params.put("EC2Acc", 		ElecAcc[1]);
			params.put("EC3Acc", 		ElecAcc[2]);
			params.put("EC4Acc", 		ElecAcc[3]);
			params.put("EC5Acc", 		ElecAcc[4]);
			params.put("EC6Acc", 		ElecAcc[5]);
			params.put("EC7RAcc",		ElecAcc[6]);
			params.put("EC7SAcc", 		ElecAcc[7]);
			params.put("EC7TAcc", 		ElecAcc[8]);
			params.put("EC8RAcc", 		ElecAcc[9]);
			params.put("EC8SAcc", 		ElecAcc[10]);
			params.put("EC8TAcc", 		ElecAcc[11]);
			
			params.put("EC1Inst", 		ElecInst[0]);
			params.put("EC2Inst", 		ElecInst[1]);
			params.put("EC3Inst", 		ElecInst[2]);
			params.put("EC4Inst", 		ElecInst[3]);
			params.put("EC5Inst", 		ElecInst[4]);
			params.put("EC6Inst", 		ElecInst[5]);
			params.put("EC7RInst",		ElecInst[6]);
			params.put("EC7SInst", 		ElecInst[7]);
			params.put("EC7TInst", 		ElecInst[8]);
			params.put("EC8RInst", 		ElecInst[9]);
			params.put("EC8SInst", 		ElecInst[10]);
			params.put("EC8TInst", 		ElecInst[11]);
			
			
			
			// HACON
			JSONArray HaconInfoList = 	jo.getJSONArray("HaconInfoList");
			
			String[] HaconStatus = 	new String[]{"0","0","0","0","0"};
			String[] HaconExist = 	new String[]{"0","0","0","0","0"};
			String[] HaconTempS = 	new String[]{"0","0","0","0","0"};
			
			String[] HaconTemp = 	new String[]{"0","0","0","0","0"};
			String[] HaconOnOff =	new String[]{"0","0","0","0","0"};
			
			DecimalFormat d1 = new DecimalFormat("0.00");
			
			for(int i=0; i<HaconInfoList.size(); i++)
			{
				JSONObject data = (JSONObject) HaconInfoList.get(i);			
				
				HaconStatus[i] = 		data.getString("Status");
				HaconExist[i] = 		data.getString("Exist");
				HaconTempS[i] = 		data.getString("Temp");
				HaconTemp[i] = 			d1.format( Double.valueOf( HaconTempS[i] ) * 0.01 );
				HaconOnOff[i] = 		data.getString("OnOff");
				
			}
			
			params.put("Hacon1Temp", 		HaconTemp[0]);
			params.put("Hacon2Temp", 		HaconTemp[1]);
			params.put("Hacon3Temp", 		HaconTemp[2]);
			params.put("Hacon4Temp", 		HaconTemp[3]);
			params.put("Hacon5Temp", 		HaconTemp[4]);
			
			params.put("Hacon1Exist", 		HaconExist[0]);
			params.put("Hacon2Exist", 		HaconExist[1]);
			params.put("Hacon3Exist", 		HaconExist[2]);
			params.put("Hacon4Exist", 		HaconExist[3]);
			params.put("Hacon5Exist", 		HaconExist[4]);
			
			params.put("Hacon1Status", 		HaconStatus[0]);
			params.put("Hacon2Status", 		HaconStatus[1]);
			params.put("Hacon3Status", 		HaconStatus[2]);
			params.put("Hacon4Status", 		HaconStatus[3]);
			params.put("Hacon5Status", 		HaconStatus[4]);
			
			params.put("Hacon1OnOff", 		HaconOnOff[0]);
			params.put("Hacon2OnOff", 		HaconOnOff[1]);
			params.put("Hacon3OnOff", 		HaconOnOff[2]);
			params.put("Hacon4OnOff", 		HaconOnOff[3]);
			params.put("Hacon5OnOff", 		HaconOnOff[4]);
			
			
			
			// T-SENSOR
			JSONArray TsensorInfoList = 	jo.getJSONArray("TSensorInfoList");
			
			String[] TsensorStatus = 	new String[]{"0","0","0","0","0"};
			String[] TsensorExist = 	new String[]{"0","0","0","0","0"};
			String[] TsensorTempS = 	new String[]{"0","0","0","0","0"};
			String[] TsensorTemp = 		new String[]{"0","0","0","0","0"};		
			
			DecimalFormat d2 = new DecimalFormat("0.00");
			
			for(int i=0; i<TsensorInfoList.size(); i++)
			{
				JSONObject data = (JSONObject) TsensorInfoList.get(i);			
				
				TsensorStatus[i] = 		data.getString("Status");
				TsensorExist[i] = 		data.getString("Exist");
				TsensorTempS[i] = 		data.getString("Temp");
				TsensorTemp[i] = 		d2.format(  Double.valueOf( TsensorTempS[i] ) * 0.01 );				
				
			}
			
			params.put("Tsensor1Temp", 		TsensorTemp[0]);
			params.put("Tsensor2Temp", 		TsensorTemp[1]);
			params.put("Tsensor3Temp", 		TsensorTemp[2]);
			params.put("Tsensor4Temp", 		TsensorTemp[3]);
			params.put("Tsensor5Temp", 		TsensorTemp[4]);
			
			params.put("Tsensor1Exist", 	TsensorExist[0]);
			params.put("Tsensor2Exist", 	TsensorExist[1]);
			params.put("Tsensor3Exist", 	TsensorExist[2]);
			params.put("Tsensor4Exist", 	TsensorExist[3]);
			params.put("Tsensor5Exist", 	TsensorExist[4]);
			
			params.put("Tsensor1Status", 	TsensorStatus[0]);
			params.put("Tsensor2Status", 	TsensorStatus[1]);
			params.put("Tsensor3Status", 	TsensorStatus[2]);
			params.put("Tsensor4Status", 	TsensorStatus[3]);
			params.put("Tsensor5Status", 	TsensorStatus[4]);		
		
			// SIGN
			JSONArray SignInfoList = 	jo.getJSONArray("SignInfoList");
			
			String SignNo = 	new String();
			String SignStatus = new String();
			String SignOnOff = 	new String();
			for(int i=0; i<SignInfoList.size(); i++)
			{
				JSONObject data = (JSONObject) SignInfoList.get(i);			
				
				SignNo = 		data.getString("SignNo");
				SignStatus = 	data.getString("Status");
				SignOnOff = 	data.getString("OnOff");
			}
		
			params.put("SignOnOff", 		SignOnOff );
			params.put("SignStatus", 		SignStatus );
				
			System.out.println( "params : " + params );
			
			int ble_check_mst_rslt = svc.retrieveREQ_NOTI_GW_INFO_BLE_CHECK_MST( params );			
			int ble_mst_rslt = svc.retrieveREQ_NOTI_GW_INFO_BLE_MST( params );		
			int ble_elec_rslt = svc.retrieveREQ_NOTI_GW_INFO_ELEC_MST( params );		
			int ble_sensor_rslt = svc.retrieveREQ_NOTI_GW_INFO_SENSOR_MST( params );
			
				
			svc.saveStoreCode( params );
			 
		}
	}
	
	
	
	
	
	
	
	
	
	
}
