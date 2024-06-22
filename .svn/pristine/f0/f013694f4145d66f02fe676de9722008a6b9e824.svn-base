package rems.energy.ctrl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
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
import rems.common.model.SelectVo;
import rems.common.service.CommonSvc;
import rems.energy.model.EpContDemandListVo;
import rems.energy.model.EpContExcessChrtVo;
import rems.energy.model.EpContOverStoreListVo;
import rems.energy.model.EpContOverStoreVo;
import rems.energy.service.EnergyContElecAllSvc;
import rems.system.model.ComCodeVo;
import rems.system.model.GridStoreMgntVo;
import rems.system.model.SessionUserVo;
import rems.util.ExcelWriter;
import rems.util.TimezoneUtils;

@Controller
@SessionAttributes("sessionUserVo")
public class EnergyContCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(EnergyContCtrl.class);
	
	@Autowired
	private EnergyContElecAllSvc EnergyContElecAllSvc;

	@Autowired
	private CommonSvc commonSvc;
	
	/**
	 * 계약전력 화면 매핑
	 * 계약전력 대비 초과사용 발생 매장현황 / 면적당 계약전력 분포 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/1401", method = {RequestMethod.GET, RequestMethod.POST})
	public String showContExcess(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
	
		LOGGER.info( "showContExcess : " + sessionUserVo.showData() );

		HashMap<String, Object> param1 = new HashMap<String, Object>();
		param1.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		param1.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		List <EpContOverStoreVo> epContOverStoreVo = EnergyContElecAllSvc.retrieveEpContList(param1);
		EpContExcessChrtVo  epContExcessChrtVo = EnergyContElecAllSvc.retrieveEpContChrt(param1);
		
		model.addAttribute("epContOverStore", epContOverStoreVo);
		model.addAttribute(epContExcessChrtVo);				
		
		return "energy/cont/energyContExcess";		
	}

	
	/**
	 * 통합관제현황 - 계약전력
	 * 
	 * @author JooYoung
	 * @param seesionUserVo : 세션변수
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveEnergyCont", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveEnergyCont(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
			
		LOGGER.info("retrieveEnergyCont");

		// 시스템 현재일자
		String toDayMonth = commonSvc.retrieveSysdate().substring(0, 7);
				
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		
		model.addAttribute("userVo", 			params);				
		model.addAttribute("toDayMonth", 		toDayMonth);
		
		
		return "energy/cont/energyContDemandList";
	}
	
	
	
	
	/**
	 * 계약전력
	 * 
	 * @author JooYoung
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param scrStrNm : 조회할 매장 코드
	 * @param scrOrgCd : 조회할 조직코드
	 * @param srcYyyymm : 조회할 년월
	 * @param mode : 조회 할 모드 ( ALL, OVER, EMPTY )
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveMonthDmndList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpContDemandListVo> retrieveMonthDmndList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrStrNm", required = false) String strNm,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,			
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,			
			@RequestParam(value = "scrOrgCd", required = false) String orgCd,							
			@RequestParam(value = "scrMode", required = false) String mode,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord,
			ModelMap model){
		
		LOGGER.info("retrieveMonthDmndList : " + strNm + " : " + scrDateTo + " session : " + sessionUserVo.showData());
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "strNm", strNm );
		params.put( "orgCd", orgCd );
		params.put( "DateFrom", scrDateFrom );
		params.put( "DateTo", scrDateTo );
		params.put( "mode", mode );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		
		
		
		
		List<EpContDemandListVo> rslt = EnergyContElecAllSvc.retrieveMonthDemandList( params );
		
		int records = rslt.size();
		
		GridVo<EpContDemandListVo> gridVo = new GridVo<EpContDemandListVo>();
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		//gridVo.setRecords( String.valueOf( records ) ); // 총 행의 개수
		//gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( records / rows ) : 0 ) ); // 총 페이지의 개수
		
		return gridVo;
	}
	
	@RequestMapping(value = "/downloadMonthDmndExcel", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public void downloadMonthDmndExcel(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrStrNm", required = false) String strNm,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,			
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,			
			@RequestParam(value = "scrOrgCd", required = false) String orgCd,							
			@RequestParam(value = "scrMode", required = false) String mode,
			HttpServletResponse response){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put( "strNm", strNm );
		params.put( "orgCd", orgCd );
		params.put( "DateFrom", scrDateFrom );
		params.put( "DateTo", scrDateTo );
		params.put( "mode", mode );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		
		
		
		List rslt = EnergyContElecAllSvc.retrieveExcelMonthDemandList( params );
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "계약전력_"+ dTime +".xls";//파일명
		String sheetNm = "계약전력";				//엑셀 시트명

		String arrColNm[] = new String[10]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "매장명";
		arrColNm[1] = "매장코드";
		arrColNm[2] = "조직명";
		arrColNm[3] = "오버이력";
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
	 * 월별 계약전력 그래프
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveMonthDemandChart", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object[] retrieveMonthDemandChart(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "strCd", required = false) String strCd,
			@RequestParam(value = "yyyymm", required = false) String yyyymm,			
			ModelMap model) {

		LOGGER.info( "retrieveMonthDemandChart ");
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put( "strCd", strCd );
		params.put( "yyyymm", yyyymm );
		
		List<EpContDemandListVo> result = EnergyContElecAllSvc.retrieveMonthDemandChart(params);
		
		List<String> yyyymmdd    = 	new ArrayList<String>();
		List<String> hh  = 			new ArrayList<String>();
		List<String> qrt = 			new ArrayList<String>();
		List<String> contPower  = 	new ArrayList<String>();		
		List<String> total  = 		new ArrayList<String>();
		
		for(EpContDemandListVo rtu : result ) {
			yyyymmdd.add( rtu.getYyyymmdd() );
			hh.add( rtu.getHh() );
			qrt.add( rtu.getQrt() );
			contPower.add( rtu.getContPower() );
			total.add( rtu.getTotal() );
		}
				
		Object rslt[] = new Object[5];
		rslt[0] = yyyymmdd.toArray();
		rslt[1] = hh.toArray();
		rslt[2] = qrt.toArray();
		rslt[3] = contPower.toArray();
		rslt[4] = total.toArray();
		
		return rslt;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 수집기준 년월 콤보조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrieveUseMonthCont", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object[] retrieveUseMonth(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
		
		LOGGER.info( "retrieveUseMonthCont : " + sessionUserVo.showData() );

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		List<EpContOverStoreVo> rsltOverStore = EnergyContElecAllSvc.retrieveEpContList( params );
		
		List<String> ticks = new ArrayList<String>();
		
		for( EpContOverStoreVo rtu : rsltOverStore ) {
			ticks.add( rtu.getYyyymm() );
		}
		
		Object rslt2[] = new Object[1];
		rslt2[0] = ticks.toArray();
		
		return rslt2;
	}	
		
		
	/**
	 * 면적당 계약전력 목록 팝업
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param orgYyyymm : 이전 화면에서 넘어온 조회 년월(최대 수요 전력 초과)
	 * @param sVal : 이전 화면에서 넘어온 조회 구간 시작(면적당 계약전력)
	 * @param eVal : 이전 화면에서 넘어온 조회 구간 끝(면적당 계약전력)
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/energyContExcessList", method = {RequestMethod.GET, RequestMethod.POST})
	public String showContExcessList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			@RequestParam(value = "orgSval", required = false) String sVal,
			@RequestParam(value = "orgEval", required = false) String eVal,			
			ModelMap model) {
	
		LOGGER.info( "showContExcessList : " + sessionUserVo.showData() + ", sVal : " + sVal + ", eVal : " + eVal);

		HashMap<String, Object> param1 = new HashMap<String, Object>();
		param1.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		param1.put( "yyyymm", yyyymm );
		param1.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		EpContOverStoreVo epContOverStoreVo = EnergyContElecAllSvc.retrieveEpContOverStore(param1);

		model.addAttribute(epContOverStoreVo);
		model.addAttribute("orgYyyymm", yyyymm);
		model.addAttribute("orgSval", sVal);
		model.addAttribute("orgEval", eVal);
		
		return "energy/cont/energyContExcessList";
	}
	

	/**
	 * 면적당 계약전력 목록 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param orgYyyymm : 이전 화면에서 넘어온 조회 년월
	 * @param sVal : 이전 화면에서 넘어온 조회 구간 시작
	 * @param eVal : 이전 화면에서 넘어온 조회 구간 끝
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrieveContExcessList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpContOverStoreListVo> retrieveUseAreaList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			@RequestParam(value = "sVal", required = false) String sVal,
			@RequestParam(value = "eVal", required = false) String eVal,
			ModelMap model){
		
		LOGGER.info("retrieveUseAreaList : " + sessionUserVo.showData() + ", sVal : " + sVal + ", eVal : " + eVal);

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "yyyymm", yyyymm );
		params.put( "sVal", sVal );
		params.put( "eVal", eVal );
		params.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		List<EpContOverStoreListVo> rslt = EnergyContElecAllSvc.retrieveEpContOverStoreList( params );
		
		GridVo<EpContOverStoreListVo> gridVo = new GridVo<EpContOverStoreListVo>();
		gridVo.setRows( rslt );                         // 결과값
		
		return gridVo;
	}


	/**
	 * 최대수요전력 상세 매핑
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param yyyymm : 이전 화면에서 넘어온 조회 년월 
	 * @param sVal : 이전 화면에서 넘어온 조회 구간 시작
	 * @param eVal : 이전 화면에서 넘어온 조회 구간 끝
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/3104", method = {RequestMethod.GET, RequestMethod.POST})
	public String showUsedList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgStrCd", required = false) String strCd,
			@RequestParam(value = "orgViewStrCd", required = false) String viewStrCd,
			@RequestParam(value = "orgStrNm", required = false) String strNm,						
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			@RequestParam(value = "orgStartVal", required = false) String sVal,
			@RequestParam(value = "orgEndVal", required = false) String eVal,
			ModelMap model) {
			
		LOGGER.info("showUsedList : " + strCd + ", " + yyyymm + ", " + sVal + ", " + eVal);

		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		List<HashMap<String, Object>> rslt1 = commonSvc.retrieveYearMonth(param);

		model.addAttribute("yearMonth", rslt1);
		model.addAttribute("orgStrCd", strCd);
		model.addAttribute("orgViewStrCd", viewStrCd);
		model.addAttribute("orgStrNm", strNm);
		model.addAttribute("orgYyyymm", yyyymm);
		model.addAttribute("orgStartVal", sVal);
		model.addAttribute("orgEndVal", eVal);

		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		//회사 select
		List<SelectVo> rslt2 = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt2.size();
		
		model.addAttribute("selectVoList", rslt2);
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoListCnt", selectVoListCnt );		
		
		return "energy/cont/energyContDemandList";
	}

	

	
	/**
	 * 일자별 최대수요전력 조회(그리드)
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param strCd : 조회할 매장 코드
	 * @param yyyymm :조회할 년월
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrieveDailyDmndList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpContDemandListVo> retrieveDailyDmndList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = true) String strCd,
			@RequestParam(value = "srchYyyymm", required = true) String yyyymm,			
			ModelMap model){
		
		LOGGER.info("retrieveDailyDmndList : " + strCd + " : " + yyyymm + " session : " + sessionUserVo.showData());
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put( "strCd", strCd );
		params.put( "yyyymm", yyyymm );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		List<EpContDemandListVo> rslt = EnergyContElecAllSvc.retrieveDailyDemandList( params );
		
		GridVo<EpContDemandListVo> gridVo = new GridVo<EpContDemandListVo>();
		gridVo.setRows( rslt );                         // 결과값
		
		return gridVo;
	}
	
	
	
	
	/**
	 * 공통코드 조회
	 * @param model
	 * @param commGrpCd
	 * @param commCd
	 * @return
	 */
	@RequestMapping(value = "/retrieveComCodeCont", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object remsComCodeContList(
			@RequestParam(value="commGrpCd",required=false) String commGrpCd,
			@RequestParam(value="commCd",required=false) String commCd ) {
		
		LOGGER.info("retrieveComCodeList : " + commGrpCd + ", " + commCd );

		ComCodeVo cond = new ComCodeVo();
    	if (commGrpCd == null || "".equals(commGrpCd)){
        	cond.setCommGrpCd("");
    	} else {
        	cond.setCommGrpCd(commGrpCd);
    	}
    	if (commCd == null || "".equals(commCd)){
        	cond.setCommCd("");
    	} else {
        	cond.setCommCd(commCd);
    	}
    	
    	List<ComCodeVo> list = EnergyContElecAllSvc.retrieveComCodeList(cond);

		Object rslt = new Object();
		rslt = list.toArray();
		
		return rslt;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
