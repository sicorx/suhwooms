package rems.energy.ctrl;

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
import rems.energy.model.SemsVo;
import rems.energy.service.EnergySemsSvc;
import rems.system.model.SessionUserVo;
import rems.util.ExcelWriter;


@Controller
@SessionAttributes("sessionUserVo")
public class EnergySemsCtrl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EnergySemsCtrl.class);
	
	@Autowired
	private EnergySemsSvc energySems;
	
	
	// SEMS 할당현황 excel 다운로드
	@RequestMapping(value = "/downloadSemsStoreExcel", method = {RequestMethod.GET, RequestMethod.POST})
	public void downloadSemsStoreExcel (
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "vendorCd", required = false) String vendorCd,
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			HttpServletResponse response) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", 	scrCompanyCd );		
		params.put( "scrStrNm", 		scrStrNm );
		params.put( "scrOrgCd", 		scrOrgCd );
		params.put( "vendorCd", 	vendorCd );		
		
		//셀렉트한 리스트는 HashMap 타입
		//List rslt = storeMgntSvc.retrieveExcelRemsStoreList( params );
		
		List rslt = energySems.retrieveExcelSems(params);		
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\SEMS_EXCEL\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "SEMS할당현황_"+ dTime +".xls";				//파일명
		String sheetNm = "SEMS할당현황";				//엑셀 시트명
		
		String arrColNm[] = new String[6]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "매장코드";
		arrColNm[1] = "매장명";
		arrColNm[2] = "조직명";
		arrColNm[3] = "오픈일";
		arrColNm[4] = "유지보수업체";
		arrColNm[5] = "푸시설정인원";		
		
		String arrDbColNm[] = new String[6]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0] = "viewStrCd";
		arrDbColNm[1] = "strNm";
		arrDbColNm[2] = "orgFullNm";
		arrDbColNm[3] = "remsStartDt";
		arrDbColNm[4] = "vendorNm";
		arrDbColNm[5] = "vendorCnt";
		
		
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
	
	
	
	
	@RequestMapping(value = "/retrieveSemsList", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveSemsList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "orgNm", required = false) String orgNm,
			@RequestParam(value = "vendorCd", required = false) String vendorCd,
			ModelMap model) {
		

		HashMap<String,Object> scr_params = new HashMap<String,Object>();
		scr_params.put("companyCd", sessionUserVo.getSessionCompanyCd());	
		scr_params.put("scrStrNm", 	scrStrNm );			// 매장명/코드 		
		scr_params.put("orgNm", orgNm);	
		scr_params.put("vendorCd", vendorCd);
		
		List<SelectVo> rslt = energySems.retrieveVendorList(scr_params);
		
		
		model.addAttribute("companyCd", sessionUserVo.getSessionCompanyCd());
		model.addAttribute("scrValue", scr_params);
		model.addAttribute("selectVoList", rslt);

		return "energy/main/energySems";	
	}
	
	@RequestMapping(value = "/retrieveSems", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<SemsVo> retrieveSems(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "vendorCd", required = false) String vendorCd,
			@RequestParam(value = "allocationYn", required = false) String allocationYn,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveSems : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put("limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put("sidx", sidx );                        // 정렬 기준 컬럼
		params.put("sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());
		params.put("scrStrNm", scrStrNm );
		params.put("scrOrgCd", scrOrgCd);
		params.put("vendorCd", vendorCd);
		params.put("allocationYn", allocationYn);
	
		List<SemsVo> rslt = energySems.retrieveSems(params);
		

		int records = rslt.size();
		
		GridVo<SemsVo> gridVo = new GridVo<SemsVo>();
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
