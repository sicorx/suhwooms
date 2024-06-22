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
import rems.eqmt.service.EqmtStoreSvc;
import rems.system.model.SessionUserVo;
import rems.util.ExcelWriter;

@Controller
@SessionAttributes("sessionUserVo")
public class EqmtStoreCtrl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EqmtStoreCtrl.class);
	
	@Autowired
	private EqmtStoreSvc eqmtStoreSvc;
	
	
	// 엑셀
	@RequestMapping(value = "/retrieveStoreExcel", method = {RequestMethod.GET, RequestMethod.POST})
	public void  retrieveStoreExcel(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,	
			@RequestParam(value = "scrDayChk", required = false) String scrDayChk,			
			HttpServletResponse response) {
		
		
		HashMap<String,Object> params = new HashMap<String,Object>();				
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());
		params.put("scrStrNm", scrStrNm);
		params.put("scrOrgCd", scrOrgCd);
		params.put("scrDateFrom", scrDateFrom.replace("-", ""));
		params.put("scrDateTo", scrDateTo.replace("-", ""));	
		params.put("scrDayChk", scrDayChk);	
	
		
		//List<SystemVo> rslt = eqmtStoreSvc.retrieveStore(params);
		
		List rslt = eqmtStoreSvc.retrieveStoreExcel(params);		
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\SEMS_EXCEL\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "비정상매장_"+ dTime +".xls";				//파일명
		String sheetNm = "비정상매장";				//엑셀 시트명
		
		String arrColNm[] = new String[8]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "매장코드";
		arrColNm[1] = "매장명";
		arrColNm[2] = "조직명";
		arrColNm[3] = "설치일";
		arrColNm[4] = "유지보수업체";
		arrColNm[5] = "전기업체";		
		arrColNm[6] = "최종통신일시";
		arrColNm[7] = "통신불량경과일";		
		
		String arrDbColNm[] = new String[8]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0] = "viewStrCd";
		arrDbColNm[1] = "strNm";
		arrDbColNm[2] = "orgFullName";
		arrDbColNm[3] = "remsStartDt";
		arrDbColNm[4] = "vendorNm";
		arrDbColNm[5] = "electricentNm";
		arrDbColNm[6] = "lastYmdh";
		arrDbColNm[7] = "lapseDay";
	
		
		String alignType[] = new String[8]; //엑셀데이터 각컬럼별 정렬방향
		alignType[0] = "center";
		alignType[1] = "center";
		alignType[2] = "center";
		alignType[3] = "center";
		alignType[4] = "center";
		alignType[5] = "center";
		alignType[6] = "center";
		alignType[7] = "center";
	
		
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
	
	
	
	
	@RequestMapping(value = "/retrieveStoreList", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveStoreList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,
			ModelMap model) {
		

		HashMap<String,Object> scr_params = new HashMap<String,Object>();
		scr_params.put("companyCd", sessionUserVo.getSessionCompanyCd());	
		
		scr_params.put("scrStrNm", scrStrNm);	
		scr_params.put("scrOrgCd", scrOrgCd);				
		scr_params.put("scrDateFrom", scrDateFrom);	
		scr_params.put("scrDateTo", scrDateTo);
		
		List<SystemVo> rslt = eqmtStoreSvc.retrieveAuthList(scr_params);
		
		model.addAttribute("companyCd", sessionUserVo.getSessionCompanyCd());
		model.addAttribute("scrValue", scr_params);
		model.addAttribute("selectVoList", rslt);

		return "eqmt/eqmtStore";	
	}   
	
	
	@RequestMapping(value = "/retrieveStore", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<SystemVo> retrieveStore(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,	
			@RequestParam(value = "scrDayChk", required = false) String scrDayChk,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveStore : " + page + ", " + rows + ", " + sidx + ", " + sord);

		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put("limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put("sidx", sidx );                        // 정렬 기준 컬럼
		params.put("sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());
		params.put("scrStrNm", scrStrNm);
		params.put("scrOrgCd", scrOrgCd);
		params.put("scrDateFrom", scrDateFrom.replace("-", ""));
		params.put("scrDateTo", scrDateTo.replace("-", ""));	
		params.put("scrDayChk", scrDayChk);	
	
		List<SystemVo> rslt = eqmtStoreSvc.retrieveStore(params);
		
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
