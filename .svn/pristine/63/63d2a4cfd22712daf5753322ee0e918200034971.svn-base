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

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
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
import rems.system.service.EngineerMapSvc;
import rems.util.ExcelWriter;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.ctrl
 * @Class Name : EngineerMapCtrl.java
 * @Description : 유지보수 > 매장할당현황조회
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 3. 6.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 3. 6. 오후 4:00:12
 * @version 2.0
 * 
 */
@Controller
@SessionAttributes("sessionUserVo")
public class EngineerMapCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(EngineerMapCtrl.class);
	
	@Autowired
	private EngineerMapSvc emSvc;
	
	@Autowired
	private CommonSvc commonSvc;
	
	@ModelAttribute("sessionUserVo")
	public SessionUserVo sessionUserVo() {
		return new SessionUserVo();
	}
	
	/**
	 * 유지보수 > 매장할당현황조회 페이지
	 * 
	 * @author 유승만
	 * @param @param sessionUserVo : 세션 사용자 정보
	 * @return engineerStrMapList : view
	 * @exception Exception
	 */
	@RequestMapping(value = "/4699", method = {RequestMethod.GET, RequestMethod.POST})
	public String showEngineerMapedStrListView(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
		LOGGER.error("showEngineerMapedStrListView");
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("userId", sessionUserVo.getSessionUserId());				// 세션 사용자 아이디
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());		// 세션 회사 코드
		params.put("companyNm", sessionUserVo.getSessionCompanyNm());		// 세션 회사 명
		params.put("vendorCd", sessionUserVo.getSessionVendorCd());		// 세션 회사 명
		
		System.out.println("4699:"+params );
		// 회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt.size();
		
		// 업체 select
		List<SelectVo> rslt2 = commonSvc.retrieveVendorList(params);
		
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("selectVoList2", rslt2);
		model.addAttribute("selectVoListCnt", selectVoListCnt );
		
		return "system/engineerMapedStrList";
	}
	
	/**
	 * 매장할당현황조회 목록
	 * 
	 * @author 유승만
	 * @param scrCompanyCd : 회사 코드
	 * @param scrOrgCd : 조직명(코드)
	 * @param scrStrCd : 매장명/코드
	 * @param scrVendorCd : 업체 코드
	 * @param scrUserNm : 엔지니어명/ID 
	 * @param page : 요청한 페이지
	 * @param rows : 페이지 당 보여줄 행의 개수
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveEngineerStrList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridMaintainEngineerMgntVo> retrieveEngineerStrList(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrVendorCd", required = false) String scrVendorCd,
			@RequestParam(value = "scrUserNm", required = false) String scrUserNm,						
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("retrieveEngineerStrList : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );			// 회사 코드
		params.put( "orgCd", scrOrgCd );					// 조직명(코드)
		params.put( "strCd", scrStrCd );					// 매장명/코드
		params.put( "vendorCd", scrVendorCd );				// 업체 코드
		params.put( "userNm", scrUserNm );					// 엔지니어명/ID
		
		// 매장할당현황조회 목록
		List<GridMaintainEngineerMgntVo> rslt = emSvc.retrieveEngineerStrList( params );		
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
	
	@RequestMapping(value = "/downloadEngineerExcel", method = {RequestMethod.GET, RequestMethod.POST})
	public void downloadStoreExcel (
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrVendorCd", required = false) String scrVendorCd,
			@RequestParam(value = "scrUserNm", required = false) String scrUserNm,						
			HttpServletResponse response) {
		
			HashMap<String,Object> params = new HashMap<String,Object>();
			params.put( "companyCd", scrCompanyCd );			// 회사 코드
			params.put( "orgCd", scrOrgCd );					// 조직명(코드)
			params.put( "strCd", scrStrCd );					// 매장명/코드
			params.put( "vendorCd", scrVendorCd );				// 업체 코드
			params.put( "userNm", scrUserNm );					// 엔지니어명/ID
			
		
		//셀렉트한 리스트는 HashMap 타입
		List rslt = emSvc.retrieveExcelEngineerStrList( params );
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "매장할당현황조회_"+ dTime +".xls";				//파일명
		String sheetNm = "매장할당현황";				//엑셀 시트명

		String arrColNm[] = new String[9]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "조직";
		arrColNm[1] = "매장코드";
		arrColNm[2] = "매장명";
		arrColNm[3] = "유지보수업체";
		arrColNm[4] = "ID";
		arrColNm[5] = "엔지니어";
		arrColNm[6] = "주소";
		arrColNm[7] = "전화번호";
		arrColNm[8] = "할당일시";
		
		String arrDbColNm[] = new String[9]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0] = "orgNm";
		arrDbColNm[1] = "viewStrCd";
		arrDbColNm[2] = "strNm";
		arrDbColNm[3] = "vendorNm";
		arrDbColNm[4] = "userId";
		arrDbColNm[5] = "userNm";
		arrDbColNm[6] = "addr";
		arrDbColNm[7] = "telNo";
		arrDbColNm[8] = "finalModDttm";
		//arrDbColNm[9] = "records";
		//arrDbColNm[10] = "total";
		
		String alignType[] = new String[9]; //엑셀데이터 각컬럼별 정렬방향
		alignType[0] = "center";
		alignType[1] = "center";
		alignType[2] = "center";
		alignType[3] = "center";
		alignType[4] = "center";
		alignType[5] = "center";
		alignType[6] = "center";
		alignType[7] = "center";
		alignType[8] = "center";
	
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