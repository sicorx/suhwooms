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
import rems.system.model.GridUserMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.service.MaintainEngineerMngtSvc;
import rems.util.ExcelWriter;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.ctrl
 * @Class Name : MaintainEngineerMngtCtrl.java
 * @Description : 유지보수 > 엔지니어관리
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 3. 8.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 3. 8. 오후 3:58:08
 * @version 2.0
 * 
 */
@Controller
@SessionAttributes("sessionUserVo")
public class MaintainEngineerMngtCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(MaintainEngineerMngtCtrl.class);
	
	@Autowired
	private MaintainEngineerMngtSvc memsvc;			// 서비스 변수
	
	@Autowired
	private CommonSvc commonSvc;
	
	@ModelAttribute("sessionUserVo")
	public SessionUserVo sessionUserVo() {
		return new SessionUserVo();
	}
	
	/**
	 * 시스템관리 > 유지보수 > 엔지니어관리 페이지
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @return engineerList : view
	 * @exception Exception
	 */
	@RequestMapping(value = "/4601", method = {RequestMethod.GET, RequestMethod.POST})
	public String showMaintainEngineerListView(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
		
		LOGGER.error("showMaintainEngineerListView" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );			// 세션 사용자 아이디
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		// 세션 회사 코드
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		// 세션 회사 명
		params.put( "vendorCd", sessionUserVo.getSessionVendorCd() );		// 세션 업체 코드
		// 회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);		
		int selectVoListCnt = rslt.size();
		
		// 업체 select
		List<SelectVo> rslt2 = commonSvc.retrieveVendorList(params);

		model.addAttribute("selectVoListCnt", selectVoListCnt );
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("selectVoList2", rslt2);
		model.addAttribute("userVo", params );
		
		return "system/engineerList";
	}
	
	/**
	 * 엔지니어 목록
	 * 
	 * @author 유승만
	 * @param scrCompanyCd : 회사 코드
	 * @param scrVendorCd : 업체 코드
	 * @param scrUserId : 사용자명/ID
	 * @param scrUseYn : 사용여부
	 * @param page : 요청한 페이지
	 * @param rows : 페이지 당 보여줄 행의 개수
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순) 
	 * @return gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/searchMaintainEngineerList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridMaintainEngineerMgntVo> searchMaintainEngineerList(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrVendorCd", required = false) String scrVendorCd,
			@RequestParam(value = "scrUserId", required = false) String scrUserId,
			@RequestParam(value = "scrUseYn", required = false) String scrUseYn,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("searchMaintainEngineerList : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );			// 회사 코드
		params.put( "vendorCd", scrVendorCd );				// 업체 코드
		params.put( "userId", scrUserId );					// 사용자명/ID
		params.put( "useYn", scrUseYn );					// 사용여부
		
		// 엔지니어 목록
		List<GridMaintainEngineerMgntVo> rslt = memsvc.searchMaintainEngineerList( params );
		
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
	
	/**
	 * 엔지니어 저장
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param GridUserMgntVo : 사용자Vo
	 * @return rslt
	 * @exception Exception
	 */
	@RequestMapping(value = "/saveEngineerMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridUserMgntVo saveEngineerMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute GridUserMgntVo gumVo,
			BindingResult bindingResult,
			ModelMap model,
			HttpSession session) throws Exception {
		
		LOGGER.info("saveEngineerMgnt : "+sessionUserVo.getSessionUserId() );
		
		gumVo.setRegiId(sessionUserVo.getSessionUserId());			// 등록 아이디
		gumVo.setFinalModId(sessionUserVo.getSessionUserId());		// 최종 수정 아이디
		
		// 엔지니어 저장
		boolean rslt = memsvc.saveEngineerMgnt( gumVo );
		LOGGER.info("[rslt      ] ============ "+rslt+" ================");
		
		return gumVo;
	}
	
	//매장리스트 엑셀다운로드
			@RequestMapping(value = "/downloadMaintainEngineerListrExcel", method = {RequestMethod.GET, RequestMethod.POST})
			public void downloadMaintainEngineerListrExcel (
					@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
					@RequestParam(value = "scrVendorCd", required = false) String scrVendorCd,
					@RequestParam(value = "scrUserId", required = false) String scrUserId,
					@RequestParam(value = "scrUseYn", required = false) String scrUseYn,
					HttpServletResponse response) {
				
				HashMap<String,Object> params = new HashMap<String,Object>();
				params.put( "companyCd", scrCompanyCd );
				params.put( "vendorCd", scrVendorCd );
				params.put( "userId", scrUserId );
				params.put( "useYn", scrUseYn );
				
				
				LOGGER.info("scrCompanyCd=="+scrCompanyCd);
				//셀렉트한 리스트는 HashMap 타입
				List rslt = memsvc.downloadMaintainEngineerListrExcel( params );
				
				HSSFWorkbook wb = new HSSFWorkbook();
				
				SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
				Date currentTime = new Date ( ); 
				String dTime = formatter.format ( currentTime ); 
				
				String excelRealPath = new String("c:\\SEMS_EXCEL\\");//엑셀파일 저장경로(서버측 저장경로)
				String FileNm= "엔지니어관리_"+ dTime +".xls";				//파일명
				String sheetNm = "엔지니어관리현황";				//엑셀 시트명

				String arrColNm[] = new String[5]; //엑셀파일 컬럼명 (가운데정렬)
				arrColNm[0] = "업체명";
				arrColNm[1] = "ID";
				arrColNm[2] = "사용자";
				arrColNm[3] = "사용여부";
				arrColNm[4] = "사용자동의";

				String arrDbColNm[] = new String[5]; //db에서 셀렉트한 컬럼명
				arrDbColNm[0] = "vendorNm";
				arrDbColNm[1] = "userId";
				arrDbColNm[2] = "userNm";
				arrDbColNm[3] = "useYnNm";
				arrDbColNm[4] = "eulaYnNm";
				
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
		
	/*@RequestMapping(value = "/downloadEngineerExcel", method = {RequestMethod.GET, RequestMethod.POST})
	public void downloadEngineerExcel (
		@RequestParam(value = "scrVendorCd", required = false) String scrVendorCd,
		@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
		@RequestParam(value = "scrUserId", required = false) String scrUserId,
		@RequestParam(value = "scrUserNm", required = false) String scrUserNm,
		@RequestParam(value = "scrUseYn", required = false) String scrUseYn, HttpServletResponse response) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "vendorCd", scrVendorCd );
		params.put( "orgCd", scrOrgCd );
		params.put( "userId", scrUserId );
		params.put( "userNm", scrUserNm );
		params.put( "useYn", scrUseYn );
		
		//셀렉트한 리스트는 HashMap 타입
		List rslt = memsvc.searchMaintainEngineerExcelList( params );
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		String excelRealPath = new String("c:\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "엑셀파일.xls";				//파일명
		String sheetNm = "엑셀파일";				//엑셀 시트명
		
		String arrColNm[] = new String[6]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "사용자ID";
		arrColNm[1] = "사용자명";
		arrColNm[2] = "사용여부";
		arrColNm[3] = "작업자ID";
		arrColNm[4] = "작업자명";
		arrColNm[5] = "최종작업일자";
		
		String arrDbColNm[] = new String[6]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0] = "userId";
		arrDbColNm[1] = "userNm";
		arrDbColNm[2] = "useYn";
		arrDbColNm[3] = "finalModId";
		arrDbColNm[4] = "finalModUserNm";
		arrDbColNm[5] = "finalModDttm";
		
		String alignType[] = new String[6]; //엑셀데이터 각컬럼별 정렬방향
		alignType[0] = "center";
		alignType[1] = "center";
		alignType[2] = "center";
		alignType[3] = "center";
		alignType[4] = "center";
		alignType[5] = "center";
	
		ExcelWriter.makeExeclData(wb, sheetNm, arrColNm, arrDbColNm, alignType, rslt);
		
		FileOutputStream fileOut = null;
		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;
	
		long time = Calendar.getInstance().getTimeInMillis();
		String realPath = excelRealPath+time;
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
	}*/
	
}
