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
import rems.system.model.GridRemsDeviceMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.service.RemsDeviceMgntSvc;
import rems.util.ExcelWriter;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.ctrl
 * @Class Name : RemsDeviceMgntCtrl.java
 * @Description : 시스템관리 > 솔루션관리 > 렘스장비
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 9.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 9. 오전 10:23:09
 * @version 2.0
 * 
 */
@Controller
@SessionAttributes("sessionUserVo")
public class RemsDeviceMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(RemsDeviceMgntCtrl.class);

	@Autowired
	private RemsDeviceMgntSvc svc;
	
	@Autowired
	private CommonSvc commonSvc;

	/**
	 * 시스템관리 > 솔루션관리 > 렘스장비 페이지
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @return remsDeviceMgnt : view
	 * @exception Exception
	 */
	@RequestMapping(value = "/4203", method = {RequestMethod.GET, RequestMethod.POST})
	public String showStoreRemsMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {

		LOGGER.error("showStoreRemsMgnt" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );			// 세션 사용자 아이디
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		// 세션 회사 코드
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		// 세션 회사 명
		
		// 회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);		
		int selectVoListCnt = rslt.size();
		
		model.addAttribute("selectVoListCnt", selectVoListCnt);
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params );

		return "system/remsDeviceMgnt";
	}
		
	/**
	 * 렘스장비 목록
	 * 
	 * @author 유승만
	 * @param scrCompanyCd : 회사 코드
	 * @param scrStrCd : 매장명/코드
	 * @param scrOrgCd : 조직명(코드)
	 * @param scrMeterCollector : 미터수집 사용여부(1:사용/0:미사용)
	 * @param page : 요청한 페이지
	 * @param rows : 페이지 당 보여줄 행의 개수
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순) 
	 * @return gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/storeRemsMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridRemsDeviceMgntVo> storeRemsMgnt(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrMeterCollector", required = false) String scrMeterCollector,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("storeRemsMgnt : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );			// 회사 코드
		params.put( "strCd", scrStrCd );					// 매장명/코드
		params.put( "orgCd", scrOrgCd );					// 조직명(코드)
		params.put( "meterCollector", scrMeterCollector );	// 미터수집 사용여부(1:사용/0:미사용)
		
		// 렘스장비 목록
		List<GridRemsDeviceMgntVo> rslt = svc.retrieveStoreRemsMgnt( params );
		
		int records = rslt.size();
		
		GridVo<GridRemsDeviceMgntVo> gridVo = new GridVo<GridRemsDeviceMgntVo>();
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
	 * 렘스장비 저장
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param GridRemsDeviceMgntVo : 게이트웨이Vo
	 * @return rslt
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveStoreRemsMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveStoreRemsMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute GridRemsDeviceMgntVo gsmVo,
			BindingResult bindingResult, 
			ModelMap model,			
			HttpSession session) throws Exception {
		
		LOGGER.error("saveStoreRemsMgnt : "+sessionUserVo.getSessionUserId() );

		gsmVo.setRegiId(sessionUserVo.getSessionUserId());			// 등록 아이디
		gsmVo.setFinalModId(sessionUserVo.getSessionUserId());		// 최종 수정 아이디

		// 렘스장비 저장
		boolean rslt = svc.saveStoreRemsMgnt( gsmVo );
		LOGGER.error("[rslt      ] ============ "+rslt+" ================");
		
		return rslt;
	}
	
	@RequestMapping(value = "/downloadstoreRemsMgntExcel", method = {RequestMethod.GET, RequestMethod.POST})
	public void downloadstoreRemsMgntExcel (
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			HttpServletResponse response) {
		
			HashMap<String,Object> params = new HashMap<String,Object>();
			params.put( "companyCd", scrCompanyCd );			// 회사 코드
			params.put( "strCd", scrStrCd );					// 매장명/코드
			params.put( "orgCd", scrOrgCd );					// 조직명(코드)
			
		
		//셀렉트한 리스트는 HashMap 타입
		List rslt = svc.downloadstoreRemsMgntExcel( params );
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "렘스장비_"+ dTime +".xls";				//파일명
		String sheetNm = "렘스장비현황";				//엑셀 시트명

		String arrColNm[] = new String[11]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "조직명";
		arrColNm[1] = "매장명";
		arrColNm[2] = "메인미터";
		arrColNm[3] = "냉난방미터";
		arrColNm[4] = "하콘";
		arrColNm[5] = "T_센서";
		arrColNm[6] = "테몬";
		arrColNm[7] = "지그비";
		arrColNm[8] = "Almon";
		arrColNm[9] = "INV";
		arrColNm[10] = "간판";

		String arrDbColNm[] = new String[11]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0] = "orgFullNm";
		arrDbColNm[1] = "strNm";
		arrDbColNm[2] = "mainMeter";
		arrDbColNm[3] = "subMeterTemp";
		arrDbColNm[4] = "hacon";
		arrDbColNm[5] = "tSensor";
		arrDbColNm[6] = "temon";
		arrDbColNm[7] = "zigbee";
		arrDbColNm[8] = "almon";
		arrDbColNm[9] = "inv";
		arrDbColNm[10] = "sign";
		
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
}