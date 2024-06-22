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
import rems.system.model.GridMaintainEngineerMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.model.VandorStrMapVo;
import rems.system.service.VandorStrMapSvc;
import rems.util.ExcelWriter;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.ctrl
 * @Class Name : VandorStrMapCtrl.java
 * @Description : 유지보수 > 업체매장할당
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 15.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 15. 오전 11:47:05
 * @version 2.0
 * 
 */
@Controller
@SessionAttributes("sessionUserVo")
public class VandorStrMapCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(VandorStrMapCtrl.class);
	
	@Autowired
	private VandorStrMapSvc vsmSvc;
	
	@Autowired
	private CommonSvc commonSvc;
	
	@ModelAttribute("sessionUserVo")
	public SessionUserVo sessionUserVo() {
		return new SessionUserVo();
	}
	
	/**
	 * 유지보수 > 업체매장할당 페이지
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @return vendorStrMapList : view
	 * @exception Exception
	 */
	@RequestMapping(value = "/4602", method = {RequestMethod.GET, RequestMethod.POST})
	public String showVendorStrListView(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
		
		LOGGER.error("showVendorStrListView" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );			// 세션 사용자 아이디
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		// 세션 회사 코드
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		// 세션 회사 명
		params.put( "vendorCd", sessionUserVo.getSessionVendorCd());		// 세션 업체 코드

		// 회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt.size();
		
		// 업체 select
		List<SelectVo> rslt2 = commonSvc.retrieveVendorList(params);

		// 시스템 현재일자
		String toDay = commonSvc.retrieveSysdate().substring(0, 10);
		
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("selectVoList2", rslt2);
		model.addAttribute("selectVoListCnt", selectVoListCnt );
		model.addAttribute("toDay", toDay);

		return "system/vendorStrMapList";
	}
	
	/**
	 * 할당된 매장목록 검색
	 * 
	 * @author 유승만
	 * @param scrCompanyCd : 회사 코드
	 * @param scrVendorCd : 업체 코드
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return rslt
	 * @exception Exception
	 */
	@RequestMapping(value = "/searchMapedStrList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<VandorStrMapVo> searchMapedStrList(
			@RequestParam(value = "scrCompanyCd", required = false) String companyCd,
			@RequestParam(value = "scrVendorCd", required = false) String vendorCd,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("searchMapedStrList : " + companyCd + ", " + vendorCd);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("sidx", sidx);                       // 정렬 기준 컬럼
		params.put("sord", sord);                       // 정렬 기준(오름차순, 내림차순)
		params.put("vendorCd", vendorCd);				// 업체 코드
		params.put("companyCd", companyCd);				// 회사 코드
		
		// 할당된 매장목록 검색
		List<VandorStrMapVo> rslt = vsmSvc.searchMapedStrList( params );
		
		return rslt;
	}
	
	/**
	 * 할당매장선택 목록
	 * 
	 * @author 유승만
	 * @param scrCompanyCd : 회사 코드
	 * @param scrStrNm : 매장명/코드
	 * @param scrMapYn : 검색종류('':전체/Y:할당/N:미할당)
	 * @param scrDateFrom : 검색 시작일자
	 * @param scrDateTo : 검색 종료일자
	 * @param page : 요청한 페이지
	 * @param rows : 페이지 당 보여줄 행의 개수
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/searchCompanyStrList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<VandorStrMapVo> searchCompanyStrList(
			@RequestParam(value = "scrCompanyCd", required = false) String companyCd,
			@RequestParam(value = "scrStrNm", required = false) String strNm,
			@RequestParam(value = "scrMapYn", required = false) String mapYn,
			@RequestParam(value = "scrDateFrom", required = false) String dateFrom,
			@RequestParam(value = "scrDateTo", required = false) String dateTo,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("searchCompanyStrList : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", companyCd );				// 회사 코드
		params.put( "strNm", strNm );						// 매장명/코드
		params.put( "mapYn", mapYn );						// 검색종류('':전체/Y:할당/N:미할당)
		params.put( "dateFrom", dateFrom );					// 검색 시작일자
		params.put( "dateTo", dateTo );						// 검색 종료일자
		
		// 할당매장선택 목록
		List<VandorStrMapVo> rslt = vsmSvc.searchCompanyStrList( params );		
		int records = rslt.size();
		
		GridVo<VandorStrMapVo> gridVo = new GridVo<VandorStrMapVo>();
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
	 * 할당된매장 저장
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param companyCd : 회사 코드
	 * @param vendorCd : 업체 코드
	 * @param insertStrCdList : 등록할 매장코드 배열(콤마를 구분자로) 
	 * @param deleteStrCdList : 삭제할 매장코드 배열(콤마를 구분자로)
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/strMappingVendor", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean strMappingVendor(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "companyCd", required = true) String companyCd,
			@RequestParam(value = "vendorCd", required = true) String vendorCd,
			@RequestParam(value = "insertStrCdList", required = true) String insertStrCdList,
			@RequestParam(value = "deleteStrCdList", required = true) String deleteStrCdList,
			BindingResult bindingResult, 
			ModelMap model,			
			HttpSession session) throws Exception {
		
		LOGGER.error("strMappingVendor : " + sessionUserVo.getSessionStrCd());
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("companyCd", companyCd);									// 회사 코드
		params.put("vendorCd", vendorCd);									// 업체 코드
		params.put("regiId", sessionUserVo.getSessionUserId());				// 등록 아이디
		params.put("finalModId", sessionUserVo.getSessionUserId());			// 최종 수정 아이디
		
		boolean rslt = false;
		// 할당된매장 삭제
		if (null != deleteStrCdList && !"".equals(deleteStrCdList)) {
			String[] deleteStrCd =  deleteStrCdList.split(",");
			params.put("strCd", deleteStrCd );								// 매장코드 배열
			
			rslt = vsmSvc.deleteStrMappingVendor( params );
			LOGGER.error("[rslt1      ] ============ "+rslt+" ================");
		}
				
		// 할당된매장 등록
		if (null != insertStrCdList && !"".equals(insertStrCdList)) {
			String[] insertStrCd =  insertStrCdList.split(",");
			params.put("strCd", insertStrCd );								// 매장코드 배열
			
			rslt = vsmSvc.insertStrMappingVendor( params );
			LOGGER.error("[rslt2      ] ============ "+rslt+" ================");
		}
				
		return rslt;
	}
	
	// 엑셀
	@RequestMapping(value = "/searchCompanyStrListExcel", method = {RequestMethod.GET, RequestMethod.POST})
	public void  searchCompanyStrListExcel(
			@RequestParam(value = "scrCompanyCd", required = false) String companyCd,
			@RequestParam(value = "scrStrNm", required = false) String strNm,
			@RequestParam(value = "scrMapYn", required = false) String mapYn,
			@RequestParam(value = "scrDateFrom", required = false) String dateFrom,
			@RequestParam(value = "scrDateTo", required = false) String dateTo,			
			HttpServletResponse response) {
		
		
		HashMap<String,Object> params = new HashMap<String,Object>();				
		params.put( "companyCd", companyCd );				// 회사 코드
		params.put( "strNm", strNm );						// 매장명/코드
		params.put( "mapYn", mapYn );						// 검색종류('':전체/Y:할당/N:미할당)
		params.put( "dateFrom", dateFrom );					// 검색 시작일자
		params.put( "dateTo", dateTo );						// 검색 종료일자
	
		
		// 할당매장선택 목록
		List rslt = vsmSvc.searchCompanyStrListExcel( params );		
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\SEMS_EXCEL\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "업체매장할당_"+ dTime +".xls";				//파일명
		String sheetNm = "SEMS매장목록";				//엑셀 시트명
		
		String arrColNm[] = new String[4]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "매장코드";
		arrColNm[1] = "매장명";
		arrColNm[2] = "주소";
		arrColNm[3] = "설치일자";
		
		String arrDbColNm[] = new String[4]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0] = "viewStrCd";
		arrDbColNm[1] = "strNm";
		arrDbColNm[2] = "addr";
		arrDbColNm[3] = "remsStartDt";
	
		
		String alignType[] = new String[4]; //엑셀데이터 각컬럼별 정렬방향
		alignType[0] = "center";
		alignType[1] = "center";
		alignType[2] = "center";
		alignType[3] = "center";
	
		
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
	
	/**
	 * 벤더 리스트 조회
	 * @param scrCompanyCd
	 * @return
	 */
	@RequestMapping(value = "/retrieveVendorList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<SelectVo> retrieveVendorList(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd) {
		LOGGER.info(scrCompanyCd);
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "scrCompanyCd", scrCompanyCd );
		List<SelectVo> rslt = vsmSvc.retrieveVendorList( params );
		return rslt;
	}
	
	/**
	 * 매장 벤더 매핑 해제
	 * @param vandorCd
	 * @param strCd
	 * @return
	 */
	@RequestMapping(value = "/strUnMappingVendor", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody String strUnMappingVendor(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "vendorCd[]", required = true) String[] arryVendorCd,
			@RequestParam(value = "strCd[]", required = true) String[] arryStrCd) {
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("vendorCd", arryVendorCd);
		params.put("strCd", arryStrCd);
		
		boolean rslt = vsmSvc.deleteStrMappingVendor( params );
		LOGGER.info("**************************"+rslt);
		if(rslt){
			return "SUCCESS";
		}else{
			return "FAIL";
		}
	}
	
	
	
	
	
	
	
	

	
	

	/**
	 * 매장별 push 알림 담당자 리스트 
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/4604", method = {RequestMethod.GET, RequestMethod.POST})
	public String showEngineerStrListView(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
		LOGGER.info("selectVoList" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "authSp", sessionUserVo.getSessionAuthSp() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		params.put( "vendorCd", sessionUserVo.getSessionVendorCd() );
		params.put( "vendorNm", sessionUserVo.getSessionVendorNm() );

		//회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt.size();
		
		//회사 select
//		List<SelectVo> rslt2 = memsvc.retrieveVendorList(params);
//		int selectVoListCnt2 = rslt2.size();
		
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoListCnt", selectVoListCnt );
//		model.addAttribute("selectVoList2", rslt2);
//		model.addAttribute("selectVoListCnt2", selectVoListCnt2 );

		return "system/engineerStrList";
	}
	
	/**
	 * 벤더소속 엔지니어 지정 매장 조회
	 * @param scrVendorCd
	 * @param scrOrgCd
	 * @param scrUserId
	 * @param scrUserNm
	 * @param scrUseYn
	 * @param page
	 * @param rows
	 * @param sidx
	 * @param sord
	 * @return
	 */
	@RequestMapping(value = "/searchVendorEngineerStrList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridMaintainEngineerMgntVo> searchVendorEngineerStrList(
			@RequestParam(value = "scrCompanyCd", required = false) String companyCd,
			@RequestParam(value = "scrVendorCd", required = false) String vendorCd,
			@RequestParam(value = "scrOrgCd", required = false) String orgCd,
			@RequestParam(value = "scrStrCd", required = false) String strCd,
			@RequestParam(value = "scrStrNm", required = false) String strNm,
			@RequestParam(value = "scrUserId", required = false) String userId,
			@RequestParam(value = "scrUserNm", required = false) String userNm,
						
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", companyCd );
		params.put( "vendorCd", vendorCd );
		params.put( "orgCd", orgCd );
		params.put( "strCd", strCd );
		params.put( "strNm", strNm );
		params.put( "userId", userId );
		params.put( "userNm", userNm );
		
		List<GridMaintainEngineerMgntVo> rslt = vsmSvc.searchVendorEngineerStrList( params );
		
		int records = rslt.size();
		
		GridVo<GridMaintainEngineerMgntVo> gridVo = new GridVo<GridMaintainEngineerMgntVo>();
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		
		return gridVo;
	}
}