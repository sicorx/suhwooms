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
import rems.common.service.CommonSvc;
import rems.eqmt.model.SystemVo;
import rems.eqmt.service.EqmtPushSvc;
import rems.system.model.ComCodeVo;
import rems.system.model.SessionUserVo;
import rems.util.ExcelWriter;

@Controller
@SessionAttributes("sessionUserVo")
public class EqmtPushCtrl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EqmtPushCtrl.class);
	
	@Autowired
	private CommonSvc commonSvc;

	@Autowired
	private EqmtPushSvc eqmtPushSvc;
	
	
	
	
	
	
	// SEMS 할당현황 excel 다운로드
	@RequestMapping(value = "/downloadEqmtPushListExcel", method = {RequestMethod.GET, RequestMethod.POST})
	public void downloadEqmtPushListExcel (
			@RequestParam(value = "scrCompanyCd", required = false) 		String scrCompanyCd,
			@RequestParam(value = "scrStrNm", required = false) 			String scrStrNm,
			@RequestParam(value = "scrStrCd", required = false) 			String scrStrCd,
			@RequestParam(value = "scrOrgCd", required = false) 			String scrOrgCd,				
			@RequestParam(value = "scrAsResult", required = false) 			String scrAsResult,
			@RequestParam(value = "scrDeviceType", required = false) 		String scrDeviceType,
			@RequestParam(value = "scrDateFrom", required = false) 			String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) 			String scrDateTo,
			HttpServletResponse response) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", 		scrCompanyCd );		
		params.put( "strNm", 			scrStrNm );
		params.put( "scrStrCd", 		scrStrCd );
		params.put( "scrOrgCd", 		scrOrgCd );			
		params.put( "asResult", 		scrAsResult );
		params.put( "deviceType", 	scrDeviceType );
		params.put( "scrDateFrom", 		scrDateFrom.replace("-", "") );
		params.put( "scrDateTo", 		scrDateTo.replace("-", "") );			
		                        					
		
		//List<SystemVo> rslt = eqmtPushSvc.retrievePushList(params);
		
	
		//List<SystemVo> rslt = eqmtStoreSemsSvc.retrieveStoreSemsList(params);
		List rslt = eqmtPushSvc.retrieveExcelPushList(params);		
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\SEMS_EXCEL\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "푸시처리현황_"+ dTime +".xls";				//파일명
		String sheetNm = "푸시처리현황";				//엑셀 시트명
		
		String arrColNm[] = new String[11]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "접수일시";
		arrColNm[1] = "매장명";
		arrColNm[2] = "접수내용";
		arrColNm[3] = "장애유형(중)";
		arrColNm[4] = "처리부서(부)";
		arrColNm[5] = "완료일시";		
		arrColNm[6] = "경과시간";
		arrColNm[7] = "조치방법";
		arrColNm[8] = "조치내용";
		arrColNm[9] = "점포코드";
		arrColNm[10] = "동일장비 PUSH알람 발생횟수";		
		
		String arrDbColNm[] = new String[11]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0] = "alarmDateS";
		arrDbColNm[1] = "strNm";
		arrDbColNm[2] = "alarmMessage";
		arrDbColNm[3] = "deviceLoc";
		arrDbColNm[4] = "asVendorNm";
		arrDbColNm[5] = "alarmDateE";
		arrDbColNm[6] = "lapseHour";
		arrDbColNm[7] = "asContents";
		arrDbColNm[8] = "asNote";
		arrDbColNm[9] = "viewStrCd";
		arrDbColNm[10] = "alarmCnt";					
		
		
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/retrievePushList", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrievePushList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {

		LOGGER.error("retrievePushList" );
		
		ComCodeVo cond = new ComCodeVo();
		cond.setCommGrpCd("VIEW13");
		List<ComCodeVo> deviceTypeList = commonSvc.retrieveComCodeList(cond);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("userId", sessionUserVo.getSessionUserId() );			// 세션 사용자 아이디
		params.put("companyCd", sessionUserVo.getSessionCompanyCd() );		// 세션 회사 코드
		params.put("companyNm", sessionUserVo.getSessionCompanyNm() );		// 세션 회사 명
		
		model.addAttribute("deviceTypeList", deviceTypeList);
		model.addAttribute("userVo", params);
		
		return "eqmt/eqmtPush";
	}	
	
	
	@RequestMapping(value = "/retrievePush", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<SystemVo> retrievePush(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrAsResult", required = false) String scrAsResult,
			@RequestParam(value = "scrDeviceType", required = false) String scrDeviceType,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord,
			ModelMap model) {
		
		LOGGER.error("retrievePush : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> history = new HashMap<String,Object>();
		history.put("scrStrNm", scrStrNm);
		history.put("scrAsResult", scrAsResult);
		history.put("scrDeviceType", scrDeviceType);
		history.put("scrDateFrom", scrDateFrom);
		history.put("scrDateTo", scrDateTo);
		model.addAttribute("history", history);
		
		
		
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("start", ( ( rows * page ) - rows ) ); 	
		params.put("limit", rows );                       
		params.put("sidx", sidx );                       
		params.put("sord", sord );                        					
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());	
		
		params.put("scrDateFrom", scrDateFrom);	
		params.put("scrDateTo", scrDateTo);	
		
		params.put("strNm", scrStrNm);	
		params.put("asResult", scrAsResult);	
		params.put("deviceType", scrDeviceType);


		List<SystemVo> rslt = eqmtPushSvc.retrievePushList(params);
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
