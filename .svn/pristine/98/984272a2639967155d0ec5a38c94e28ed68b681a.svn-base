package rems.eqmt.ctrl;

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
import rems.eqmt.model.SystemVo;
import rems.eqmt.service.EqmtStoreSemsSvc;
import rems.system.model.SessionUserVo;
import rems.util.ExcelWriter;

@Controller
@SessionAttributes("sessionUserVo")
public class EqmtStoreSemsCtrl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EqmtStoreSemsCtrl.class);
	
	@Autowired
	private EqmtStoreSemsSvc eqmtStoreSemsSvc;

	
	
	// SEMS 할당현황 excel 다운로드
	@RequestMapping(value = "/downloadEqmtStoreSemsExcel", method = {RequestMethod.GET, RequestMethod.POST})
	public void downloadEqmtStoreSemsExcel (
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,				
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,
			HttpServletResponse response) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", 	scrCompanyCd );		
		params.put( "scrStrNm", 	scrStrNm );
		params.put( "scrStrCd", 	scrStrCd );
		params.put( "scrOrgCd", 	scrOrgCd );			
		params.put( "scrDateFrom", scrDateFrom.replace("-", "") );
		params.put( "scrDateTo", scrDateTo.replace("-", "") );
				
		//List<SystemVo> rslt = eqmtStoreSemsSvc.retrieveStoreSemsList(params);
		List rslt = eqmtStoreSemsSvc.retrieveExcelStoreSemsList(params);		
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\SEMS_EXCEL\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "매장SEMS장비설치현황_"+ dTime +".xls";				//파일명
		String sheetNm = "매장SEMS장비설치현황";				//엑셀 시트명
		
		String arrColNm[] = new String[13]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "매장코드";
		arrColNm[1] = "매장명";
		arrColNm[2] = "조직명";
		arrColNm[3] = "설치일";
		arrColNm[4] = "게이트웨이";
		arrColNm[5] = "테몬";		
		arrColNm[6] = "온도줄센서";
		arrColNm[7] = "하콘";
		arrColNm[8] = "매장온도센서";
		arrColNm[9] = "미터";
		arrColNm[10] = "CT";
		arrColNm[11] = "EMS BOX";
		arrColNm[12] = "설치작업";
		
		String arrDbColNm[] = new String[13]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0] = "viewStrCd";
		arrDbColNm[1] = "strNm";
		arrDbColNm[2] = "orgNm";
		arrDbColNm[3] = "remsStartDt";
		arrDbColNm[4] = "gwCnt";
		arrDbColNm[5] = "temonCnt";
		arrDbColNm[6] = "lineSensorCnt";
		arrDbColNm[7] = "haconCnt";
		arrDbColNm[8] = "tSensorCnt";
		arrDbColNm[9] = "meterCnt";
		arrDbColNm[10] = "ctCnt";
		arrDbColNm[11] = "emsBox";
		arrDbColNm[12] = "remsDt";			
		
		
		String alignType[] = new String[13]; //엑셀데이터 각컬럼별 정렬방향
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
		alignType[11] = "center";
		alignType[12] = "center";
		
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
	
	
	
	
	@RequestMapping(value = "/retrieveStoreSemsList", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveStoreSemeList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {

		LOGGER.error("retrieveStoreSemsList" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("userId", sessionUserVo.getSessionUserId() );			// 세션 사용자 아이디
		params.put("companyCd", sessionUserVo.getSessionCompanyCd() );		// 세션 회사 코드
		params.put("companyNm", sessionUserVo.getSessionCompanyNm() );		// 세션 회사 명
		
		model.addAttribute("userVo", params);
		
		return "eqmt/eqmtStoreSems";
	}	
	
	
	@RequestMapping(value = "/retrieveStoreSems", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<SystemVo> retrieveStoreSems(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("retrieveStoreSems : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("start", ( ( rows * page ) - rows ) ); 	
		params.put("limit", rows );                       
		params.put("sidx", sidx );                       
		params.put("sord", sord );                        					
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());		
		
		params.put("scrStrNm", scrStrNm);	
		params.put("scrOrgCd", scrOrgCd);	
		params.put("scrDateFrom", scrDateFrom);	
		params.put("scrDateTo", scrDateTo);	


		List<SystemVo> rslt = eqmtStoreSemsSvc.retrieveStoreSemsList(params);
		int records = rslt.size();
		
		GridVo<SystemVo> gridVo = new GridVo<SystemVo>();
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
