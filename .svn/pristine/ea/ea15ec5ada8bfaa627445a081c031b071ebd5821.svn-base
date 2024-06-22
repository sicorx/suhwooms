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
import rems.eqmt.service.EqmtEnergySvc;
import rems.system.model.SessionUserVo;
import rems.util.ExcelWriter;

@Controller
@SessionAttributes("sessionUserVo")
public class EqmtEnergyCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(EqmtEnergyCtrl.class);
	
	@Autowired
	private EqmtEnergySvc eqmtEnergySvc;
	
	@Autowired
	private CommonSvc commonSvc;
	
	@RequestMapping(value = "/retrieveEnergyList", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveEnergyList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {

		LOGGER.error("retrieveEnergyList" );
		
		// 시스템 현재일자
		String toDayMonth = commonSvc.retrieveSysdate().substring(0, 7);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("userId", sessionUserVo.getSessionUserId() );			// 세션 사용자 아이디
		params.put("companyCd", sessionUserVo.getSessionCompanyCd() );		// 세션 회사 코드
		params.put("companyNm", sessionUserVo.getSessionCompanyNm() );		// 세션 회사 명
		
		model.addAttribute("userVo", params);
		model.addAttribute("toDayMonth", toDayMonth);
		
		return "eqmt/eqmtEnergy";
	}	
	
	
	@RequestMapping(value = "/retrieveEnergy", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<SystemVo> retrieveEnergy(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrDate", required = false) String scrDate,
			@RequestParam(value = "scrJudge", required = false) String scrJudge,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("retrieveEnergy : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("start", ( ( rows * page ) - rows ) ); 	
		params.put("limit", rows );                       
		params.put("sidx", sidx );                       
		params.put("sord", sord );                        					
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());		
		
		params.put("scrStrNm", scrStrNm);	
		params.put("scrOrgCd", scrOrgCd);	
		params.put("scrDate", scrDate.replace("-", ""));	
		params.put("scrJudge", scrJudge);	

		List<SystemVo> rslt = eqmtEnergySvc.retrieveEnergyList(params);
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
	
	@RequestMapping(value = "/downloadEqmtExcel", method = {RequestMethod.GET, RequestMethod.POST})
	public void downloadStoreExcel (
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrDate", required = false) String scrDate,
			@RequestParam(value = "scrJudge", required = false) String scrJudge,
			HttpServletResponse response) {
		
			HashMap<String,Object> params = new HashMap<String,Object>();
			params.put( "scrStrNm", scrStrNm );			// 회사 코드
			params.put( "scrOrgCd", scrOrgCd );					// 조직명(코드)
			params.put( "scrDate", scrDate.replace("-", "") );					// 매장명/코드
			params.put("scrJudge", scrJudge);
			params.put("companyCd", sessionUserVo.getSessionCompanyCd());
			params.put("scrNoDate", scrDate);
		//셀렉트한 리스트는 HashMap 타입
		List rslt = eqmtEnergySvc.retrieveExcelEnergyList( params );
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "에너지효과분석_"+ dTime +".xls";				//파일명
		String sheetNm = "에너지효과현황";				//엑셀 시트명

		String arrColNm[] = new String[14]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "매장코드";
		arrColNm[1] = "매장명";
		arrColNm[2] = "조직";
		arrColNm[3] = "매장면적";
		arrColNm[4] = "최초계약전력";
		arrColNm[5] = "수정계약전력";
		arrColNm[6] = "MAX년월";
		arrColNm[7] = "MAX사용전력";
		arrColNm[8] = "적정여부";
		arrColNm[9] = "해당월최대전력";
		arrColNm[10] = "차이전력";
		arrColNm[11] = "총사용량";
		arrColNm[12] = "평균사용량";
		arrColNm[13] = "영업일수";

		String arrDbColNm[] = new String[14]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0] = "viewStrCd";
		arrDbColNm[1] = "strNm";
		arrDbColNm[2] = "orgNm";
		arrDbColNm[3] = "strAreaSpec";
		arrDbColNm[4] = "demandPower";
		arrDbColNm[5] = "recommDemandPower";
		arrDbColNm[6] = "yearMon";
		arrDbColNm[7] = "maxWatage";
		arrDbColNm[8] = "judge";
		arrDbColNm[9] = "maxUseWatage";
		arrDbColNm[10] = "useWatageDiff";
		arrDbColNm[11] = "totalWatage";
		arrDbColNm[12] = "avgWatage";
		arrDbColNm[13] = "operDayCnt";
		
		String alignType[] = new String[14]; //엑셀데이터 각컬럼별 정렬방향
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
		alignType[13] = "center";
	
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
