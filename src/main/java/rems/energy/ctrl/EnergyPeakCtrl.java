
package rems.energy.ctrl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import rems.energy.model.EpPeakStatusVo;
import rems.energy.service.EnergyElecAllSvc;
import rems.system.model.SessionUserVo;
import rems.util.ExcelWriter;
import rems.util.TimezoneUtils;

@Controller
@SessionAttributes("sessionUserVo")
public class EnergyPeakCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(EnergyPeakCtrl.class);
	
	@Autowired
	private EnergyElecAllSvc svc;

	@Autowired
	private CommonSvc commonSvc;
	
	@ModelAttribute("sessionUserVo")
	public SessionUserVo sessionUserVo() {
		return new SessionUserVo();
	}

			
	/**
	 * 통제관제현황 - 피크제어매장
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrievePeakControlStore", method = {RequestMethod.GET, RequestMethod.POST})
	public String showTotal(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrDateFrom", required = false) 			String scrDateFrom,
			ModelMap model) {
		
		LOGGER.info("showTotal : " + sessionUserVo.showData() );
		
		sessionUserVo.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );			// 세션 사용자 아이디
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		// 세션 회사 코드
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		// 세션 회사 명
		params.put( "vendorCd", sessionUserVo.getSessionVendorCd());		// 세션 업체 코드
		
		// 시스템 현재일자
		String toDayMonth = commonSvc.retrieveSysdate().substring(0, 7);
		String foucusMonth ="";
		if(scrDateFrom != null){
			foucusMonth = scrDateFrom;
		}
		//// 전체매장수, 전체일평균총사용량, 일평균 매장별 사용량	
		//EpStatusVo totalVal = svc.retrieveEpTotalStatus(params);
	
		model.addAttribute("userVo", 			params);		
		model.addAttribute("toDayMonth", 		toDayMonth);
		model.addAttribute("foucusMonth", 		foucusMonth);
				
		
		return "energy/peak/energyPeakStatus";		
	}
	
	
	
	
	
	@RequestMapping(value = "/retrievePeakMonthStatus", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpPeakStatusVo> retrievePeakMonthStatus(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrDate", required = false) 			String yyyymm,			
			@RequestParam(value = "page", required = false) 			int page,
			@RequestParam(value = "rows", required = false) 			int rows,
			@RequestParam(value = "sidx", required = false) 			String sidx,
			@RequestParam(value = "sord", required = false) 			String sord,
			ModelMap model) {
		
		LOGGER.info("retrievePeakMonthStatus : ");
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", 		rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", 		sidx );                        // 정렬 기준 컬럼
		params.put( "sord", 		sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "yyyymm", 		yyyymm );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		
		
		
		
		
		List<EpPeakStatusVo> rslt = svc.retrievePeakMonthStatus( params );

		int records = rslt.size();
		
		GridVo<EpPeakStatusVo> gridVo = new GridVo<EpPeakStatusVo>();
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		
		
		return gridVo;
	}
	
	@RequestMapping(value = "/downloadPeakMonthStatusExcel", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public void downloadPeakMonthStatusExcel(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrDate", required = false) 			String yyyymm,			
			HttpServletResponse response) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put( "yyyymm", 		yyyymm );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		
		
		List rslt = svc.retrieveExcelPeakMonthStatusList( params );
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "피크제어매장_"+ dTime +".xls";//파일명
		String sheetNm = "피크제어매장";				//엑셀 시트명

		String arrColNm[] = new String[10]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "매장명";
		arrColNm[1] = "매장코드";
		arrColNm[2] = "조직명";
		arrColNm[3] = "제어횟수";
		arrColNm[4] = "계약전력(kW)";
		arrColNm[5] = "최대수요전력(kW)";
		arrColNm[6] = "여유전력(kW)";
		arrColNm[7] = "최대냉난방전력(kW)";
		arrColNm[8] = "주소";
		arrColNm[9] = "전화번호";
		
		String arrDbColNm[] = new String[10]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0] = "strNm";
		arrDbColNm[1] = "viewStrCd";
		arrDbColNm[2] = "orgFullName";
		arrDbColNm[3] = "peakCnt";
		arrDbColNm[4] = "contPower";
		arrDbColNm[5] = "mainTotal";
		arrDbColNm[6] = "freePower";
		arrDbColNm[7] = "temp";
		arrDbColNm[8] = "addr";
		arrDbColNm[9] = "telNo";
		
		String alignType[] = new String[10]; //엑셀데이터 각컬럼별 정렬방향
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
	 * 피크제어매장현황
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrievePeakMonth", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object[] retrievePeakMonth(
			@ModelAttribute("sessionUserVo") 					SessionUserVo sessionUserVo,
			@RequestParam(value = "scrDate", required = false) 	String yyyymm,	
			
			ModelMap model) {
		
		LOGGER.info( "retrievePeakMonth : " + sessionUserVo.showData() );

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "yyyymm", yyyymm );
		
		
		List<EpPeakStatusVo> rslt = svc.retrievePeakMonth( params );
		
		List<String> yyymm = new ArrayList<String>();
		List<String> peakCnt = new ArrayList<String>();
		
		for( EpPeakStatusVo rtu : rslt ) {
			yyymm.add( rtu.getYymm() );
			peakCnt.add( rtu.getPeakCnt() );
		}
		
		Object rslt2[] = new Object[2];
		rslt2[0] = yyymm.toArray();
		rslt2[1] = peakCnt.toArray();
		
		return rslt2;
	}	
	
	
	
	
	
	
	
	
}
