package rems.closing.ctrl;

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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONTokener;
import rems.closing.service.ClosingSvc;
import rems.common.model.GridVo;
import rems.common.model.SelectVo;
import rems.system.model.GridClosingVo;
import rems.system.model.SessionUserVo;
import rems.util.ExcelWriter;


@Controller
@SessionAttributes("sessionUserVo")
public class ClosingCtrl {

	@Autowired
	private ClosingSvc closingSvc;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ClosingCtrl.class);
	
	@RequestMapping(value = "/closingMngt", method = {RequestMethod.GET, RequestMethod.POST})
	public String temp17(ModelMap model) {
		
		//조회용 마감년월 select 조회
		List<SelectVo> searchComboList = closingSvc.retrieveSearchComboList();
		//Grid용 마감년월 select 조회
		List<SelectVo> gridComboList = closingSvc.retrieveGridComboList();
		
		model.addAttribute("searchComboList", searchComboList);
		model.addAttribute("gridComboList", gridComboList);
		
		return "closing/closingMngt";
	}
	
	@RequestMapping(value = "/retrieveClosingList", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody GridVo<GridClosingVo> retrieveTemp17(@RequestParam(required = false) String  searchVal,
														@RequestParam(required = false) String  searchFromDate,
														@RequestParam(required = false) String  searchToDate,
														@RequestParam(required = false) String  vendorCd,
														@RequestParam(required = false) String  vendorClosingYn,
														@RequestParam(required = false) String  closingYn,
														@RequestParam(required = false) String  closingDate,
														@RequestParam(required = false) String  prtYn,
														@RequestParam(required = false) int page,
														@RequestParam(required = false) int rows,
														@RequestParam(required = false) String sidx,
														@RequestParam(required = false) String sord) {
		
		System.out.println("searchVal:" + searchVal + " // searchFromDate:" + searchFromDate + " // searchToDate:" + searchToDate 
				+ " // vendorCd:" + vendorCd + " // vendorClosingYn:" + vendorClosingYn + " // vendorCd:" + vendorCd + 
				" // vendorClosingYn:" + vendorClosingYn + " // closingYn:" + closingYn + " // closingDate:" + closingDate + " // prtYn:" + prtYn);
		System.out.println("rows:" + rows + " // sidx:" + sidx + " // sord:" + sord);
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", ((rows * page) - rows)); // 요청한 페이지 시작 행 번호
		params.put("limit", rows);                       // 페이지 당 보여줄 행의 개수
		params.put("sidx", sidx);                        // 정렬 기준 컬럼
		params.put("sord", sord);                        // 정렬 기준(오름차순, 내림차순)
		params.put("searchVal", searchVal);
		params.put("searchFromDate", searchFromDate);
		params.put("searchToDate", searchToDate);
		params.put("vendorCd", vendorCd);
		params.put("vendorClosingYn", vendorClosingYn);
		params.put("closingYn", closingYn);
		params.put("closingDate", closingDate);
		params.put("prtYn", prtYn);
		
		List<GridClosingVo> rslt = closingSvc.retrieveClosingList(params); 
		int records = rslt.size();
		
		GridVo<GridClosingVo> gridVo = new GridVo<GridClosingVo>();
		
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		return gridVo;
	}
	
	@Transactional
	@RequestMapping(value = "/saveModifyNumber", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveModifyNumber(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam String paramList) throws Exception {
		
		LOGGER.error("saveModifyNumber : "+sessionUserVo.getSessionUserId() );
		
		
		try {
			JSONArray arr = (JSONArray) new JSONTokener(paramList).nextValue();
			
			//수량변경 - 정보변경
			for(int i = 0; i < arr.size(); i++) {
				HashMap<String, Object> params = new HashMap<String, Object>();
				
				JSONObject obj = new JSONObject();
				obj = arr.getJSONObject(i);

				params.put("userId", sessionUserVo.getSessionUserId());
				params.put("strCd", obj.getString("strCd"));
				params.put("closingYm", obj.getString("closingYm"));
				
				closingSvc.saveModifyNumber(params);
				
				//수량변경 - 아이템 상세 변경
				@SuppressWarnings("unchecked")
				List<String> itemInfo = (List<String>) obj.get("itemInfo");
				String strItemInfo = "";
				String itemType = "";
				String cnt = "";
				for(int j = 0; j < itemInfo.size(); j++) {
					HashMap<String, Object> params2 = new HashMap<String, Object>();
					strItemInfo = itemInfo.get(j);
					itemType = strItemInfo.split("_")[0];
					cnt = strItemInfo.split("_")[1];
					
					params2.put("userId", sessionUserVo.getSessionUserId());
					params2.put("strCd", obj.getString("strCd"));
					params2.put("itemType", itemType);
					params2.put("cnt", cnt);
					
					closingSvc.saveModifyNumberDetail(params2);
				}
			}
			
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	@Transactional
	@RequestMapping(value = "/updateFixVendor", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean updateFixVendor(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam String paramList) throws Exception {
		
		LOGGER.error("saveModifyNumber : "+sessionUserVo.getSessionUserId() );
		
		try {
			JSONArray arr = (JSONArray) new JSONTokener(paramList).nextValue();
			
			for(int i = 0; i < arr.size(); i++) {
				HashMap<String, Object> params = new HashMap<String, Object>();
				
				JSONObject obj = new JSONObject();
				obj = arr.getJSONObject(i);

				params.put("userId", sessionUserVo.getSessionUserId());
				params.put("strCd", obj.getString("strCd"));
				params.put("closingYm", obj.getString("closingYm"));
				
				closingSvc.updateFixVendor(params);
				
			}
			
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@Transactional
	@RequestMapping(value = "/updateFixClosing", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean updateFixClosing(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam String paramList) throws Exception {
		
		LOGGER.error("saveModifyNumber : "+sessionUserVo.getSessionUserId() );
		
		try {
			JSONArray arr = (JSONArray) new JSONTokener(paramList).nextValue();
			
			for(int i = 0; i < arr.size(); i++) {
				HashMap<String, Object> params = new HashMap<String, Object>();
				
				JSONObject obj = new JSONObject();
				obj = arr.getJSONObject(i);

				params.put("userId", sessionUserVo.getSessionUserId());
				params.put("strCd", obj.getString("strCd"));
				params.put("closingYm", obj.getString("closingYm"));
				
				closingSvc.updateFixClosing(params);
			}
			
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@Transactional
	@RequestMapping(value = "/updateModifyClosingMon", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean updateModifyClosingMon(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam String paramList) throws Exception {
		
		LOGGER.error("saveModifyNumber : "+sessionUserVo.getSessionUserId() );
		
		
		try {
			JSONArray arr = (JSONArray) new JSONTokener(paramList).nextValue();
			
			//수량변경 - 정보변경
			for(int i = 0; i < arr.size(); i++) {
				HashMap<String, Object> params = new HashMap<String, Object>();
				
				JSONObject obj = new JSONObject();
				obj = arr.getJSONObject(i);

				params.put("userId", sessionUserVo.getSessionUserId());
				params.put("strCd", obj.getString("strCd"));
				params.put("closingYm_new", obj.getString("closingYm_new"));
				
				closingSvc.updateModifyClosingMon(params);
			}
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@RequestMapping(value = "/downloadClosingMngtExcel", method = {RequestMethod.GET, RequestMethod.POST})
	public void downloadClosingMngtExcel (
			@RequestParam(required = false) String  searchVal,
			@RequestParam(required = false) String  searchFromDate,
			@RequestParam(required = false) String  searchToDate,
			@RequestParam(required = false) String  vendorCd,
			@RequestParam(required = false) String  vendorClosingYn,
			@RequestParam(required = false) String  closingYn,
			@RequestParam(required = false) String  closingDate,
			@RequestParam(required = false) String  prtYn,						
			HttpServletResponse response) {
		
			HashMap<String,Object> params = new HashMap<String,Object>();
			params.put("searchVal", searchVal);
			params.put("searchFromDate", searchFromDate);
			params.put("searchToDate", searchToDate);
			params.put("vendorCd", vendorCd);
			params.put("vendorClosingYn", vendorClosingYn);
			params.put("closingYn", closingYn);
			params.put("closingDate", closingDate);
			params.put("prtYn", prtYn);
			
		
		//셀렉트한 리스트는 HashMap 타입
		List rslt = closingSvc.downloadClosingMngtExcel( params );
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "마감_"+ dTime +".xls";				//파일명
		String sheetNm = "마감현황";				//엑셀 시트명
	    
		String arrColNm[] = new String[21]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "점포코드";
		arrColNm[1] = "점포명";
		arrColNm[2] = "설치일자";
		arrColNm[3] = "마감월";
		arrColNm[4] = "벤더구분";
		arrColNm[5] = "게이트웨이";
		arrColNm[6] = "TEMON";
		arrColNm[7] = "HACON";
		arrColNm[8]  = "T-SENSOR";
		arrColNm[9]  = "온도센서";
		arrColNm[10] = "미터기";
		arrColNm[11] = "CT";
		arrColNm[12] = "EMS BOX";
		arrColNm[13] = "설치작업";
		arrColNm[14] = "벤더마감여부";
		arrColNm[15] = "벤더마감자";
		arrColNm[16] = "벤더마감일자";
		arrColNm[17] = "마감여부";
		arrColNm[18] = "마감확정자";
		arrColNm[19] = "마감확정일자";
		arrColNm[20] = "견적서 발행여부";

		String arrDbColNm[] = new String[21]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0]  = "strCd";               
		arrDbColNm[1]  = "strNm";              
		arrDbColNm[2]  = "remsStartDt";         
		arrDbColNm[3]  = "closingYm";           
		arrDbColNm[4]  = "remsDeivceVendor";    
		arrDbColNm[5]  = "cntGw";               
		arrDbColNm[6]  = "cntTemon";            
		arrDbColNm[7]  = "cntHacon";            
		arrDbColNm[8]  = "cntTsensor";          
		arrDbColNm[9]  = "cntLine";             
		arrDbColNm[10] = "cntMeter";            
		arrDbColNm[11] = "cntCt";               
		arrDbColNm[12] = "cntBox";              
		arrDbColNm[13] = "cntFe_before";        
		arrDbColNm[14] = "vendorClosingYn";     
		arrDbColNm[15] = "vendorClosingUserId"; 
		arrDbColNm[16] = "vendorClosingDttm";   
		arrDbColNm[17] = "managerClosingYn";    
		arrDbColNm[18] = "managerClosingUserId";
		arrDbColNm[19] = "managerClosingDttm";  
		arrDbColNm[20] = "prtYn";               
		
		String alignType[] = new String[21]; //엑셀데이터 각컬럼별 정렬방향
		alignType[0]  = "center";
		alignType[1]  = "center";
		alignType[2]  = "center";
		alignType[3]  = "center";
		alignType[4]  = "center";
		alignType[5]  = "center";
		alignType[6]  = "center";
		alignType[7]  = "center";
		alignType[8]  = "center";
		alignType[9]  = "center";
		alignType[10] = "center";
		alignType[11] = "center";
		alignType[12] = "center";
		alignType[13] = "center";
		alignType[14] = "center";
		alignType[15] = "center";
		alignType[16] = "center";
		alignType[17] = "center";
		alignType[18] = "center";
		alignType[19] = "center";
		alignType[20] = "center";

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
