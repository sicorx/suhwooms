package rems.system.ctrl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartFile;

import rems.common.model.GridVo;
import rems.system.model.DemandPowerExcelDataVo;
import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;
import rems.system.service.DemandPowerExcelUtilSvc;
import rems.util.EMSController;
import rems.util.ExcelWriter;
import rems.util.excel.ExcelRead;
import rems.util.excel.ReadOption;


@Controller
@SessionAttributes("sessionUserVo")
public class DemandPowerExcelUtilCtrl {

private static final Logger LOGGER = LoggerFactory.getLogger(DemandPowerExcelUtilCtrl.class);

	
	@Autowired
	private DemandPowerExcelUtilSvc demandPowerExcelUtilSvc;
	

	
	// 계약전력 산출 화면 이동
	@RequestMapping(value = "/4208", method = {RequestMethod.GET, RequestMethod.POST})
	public String showStoreMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute UserVo userVo,
			ModelMap model) {

		LOGGER.info("demandPowerExcel" );
		
		model.addAttribute( userVo );
		
		return "system/demandPowerExcel";
	}	
	

	@RequestMapping(value = "/demandPowerExcelPop", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveUserMgntDtl(
			@RequestParam(value = "strCd", required = false) String strCd,
			@RequestParam(value = "strNm", required = false) String strNm,
			@RequestParam(value = "calculateYn", required = false) String calculateYn,
			@RequestParam(value = "storeArea", required = false) String storeArea,			
			ModelMap model) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		params.put( "strNm", strNm );
		
		LOGGER.info("demandPowerExcelPop : "+ strCd + " / " + strNm);
		
		System.out.println( "demandPower : " + strNm );
				
		model.addAttribute("strCd", strCd);
		model.addAttribute("strNm", strNm);
		model.addAttribute("calculateYn", calculateYn);
		model.addAttribute("storeArea", storeArea);
		
		return "system/demandPowerExcelPop";
	}
	
	
	

	// 전기업체 부하산정표를 통한 추천계약전력 산출
	@RequestMapping(value = "/demandPowerExcelRead", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody List<DemandPowerExcelDataVo> readExcel(
			@RequestParam(value = "excelFile", required = false) MultipartFile excelFile,
			@RequestParam(value = "strCd", required = false) String strCd,		
			@RequestParam(value = "strNm", required = false) String strNm,			
			@RequestParam(value = "storeArea", required = false) String storeArea,
			@RequestParam(value = "tempNum", required = false) String tempNum,			
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute UserVo userVo
			) {

		LOGGER.info("demandPowerExcelRead" );
		//MultipartFile excelFile = request.getFile("excelFile");
		
		LOGGER.info("strCd : " + strCd);
		
		if(excelFile == null || excelFile.isEmpty())
		{
			throw new RuntimeException("엑셀파일 선택해주세요");
		}
		
		File destFile;
		if( excelFile.getOriginalFilename().toUpperCase().endsWith(".XLS") )
		{
			destFile = new File("C:\\TNM\\DEMAND_POWER\\" +  strCd +"_"+ strNm +  ".XLS" );
		}
		else if( excelFile.getOriginalFilename().toUpperCase().endsWith(".XLSX")) 
		{
			destFile = new File("C:\\TNM\\DEMAND_POWER\\" +  strCd +"_"+ strNm +  ".XLSX" );
		}
		else
		{
			throw new RuntimeException("잘못된 파일 형식입니다.");
		}
		
		
		//File destFile = new File("C:\\TNM\\" + excelFile.getOriginalFilename() );
		
				
		try {
			excelFile.transferTo(destFile);				// 파일 저장
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		// 파일 내용 읽기
		List<DemandPowerExcelDataVo> excelDataList = demandPowerExcelUtilSvc.insertArticleInBoard(destFile);
		
		
		
		
		
		
		
		String recommendDemandPower;		// TnM 추천계약전력
		
		int demandPower = (int)Float.valueOf( excelDataList.get(excelDataList.size()-1).getDemandPower() ).intValue() ;
		
		
		System.out.println("demandPower : " + demandPower);
		
		float storeAreaVal = Float.valueOf(storeArea);
		LOGGER.info( "int demandPower : " + demandPower );
		
		
		EMSController emsController = new EMSController("20160606");		
		recommendDemandPower = emsController.calculateDemandPower( 1, demandPower,  storeAreaVal );
		
		System.out.println("recommendDemandPower : " + recommendDemandPower);
		
		excelDataList.get(excelDataList.size()-1).setRecommendDemandPower(recommendDemandPower);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
				
		
		
		
		if( strCd.toUpperCase().startsWith("TESTDP") )
		{
			params.put( "userId" ,  sessionUserVo.getSessionUserId() );
			params.put( "strCd",  				strCd);
			params.put( "storeArea", 			storeArea );
			params.put( "calculateYn", 			"N" );
			params.put( "demandPower", 			excelDataList.get(excelDataList.size()-1).getDemandPower() );
			params.put( "recommendDemandPower", recommendDemandPower );
			
			int recommendDemandPowerK = Integer.valueOf( recommendDemandPower ) * 1000;
			params.put( "recommendDemandPowerK", recommendDemandPowerK );
			params.put( "recommendDemandPowerDiv", Math.floor( recommendDemandPowerK / 12)  );
			
			demandPowerExcelUtilSvc.insertRecommendDemandPower(params);
			demandPowerExcelUtilSvc.insertStoreArea(params);		// 매장면적 update
			demandPowerExcelUtilSvc.insertStorePeak(params);		// str_conf
		}
		else
		{
			params.put( "userId" ,  sessionUserVo.getSessionUserId() );
			params.put( "strCd",  				strCd);
			params.put( "storeArea", 			storeArea );
			params.put( "calculateYn", 			"Y" );
			params.put( "demandPower", 			excelDataList.get(excelDataList.size()-1).getDemandPower() );
			params.put( "recommendDemandPower", recommendDemandPower );
			
			int recommendDemandPowerK = Integer.valueOf( recommendDemandPower ) * 1000;
			params.put( "recommendDemandPowerK", recommendDemandPowerK );
			params.put( "recommendDemandPowerDiv", Math.floor( recommendDemandPowerK / 12)  );

			demandPowerExcelUtilSvc.insertRecommendDemandPower(params);
			demandPowerExcelUtilSvc.insertStoreArea(params);		// 매장면적 update
			demandPowerExcelUtilSvc.insertStorePeak(params);		// str_conf
		}
		
		
		// 계약전력산출값 쓰기
		ReadOption readOption = new ReadOption();
		LOGGER.info("READ: " + destFile.getAbsolutePath());
		
		readOption.setFilePath(destFile.getAbsolutePath());
		readOption.setOutputColumns("A","B","C","D","E",
				"F","G","H"
				);
		readOption.setStartRow(6);		// 시작 row 번호		
		ExcelRead.setDemandPower( readOption, excelDataList.size()+5, recommendDemandPower );		// 엑셀에 산출계약전력 쓰기
		///////////////////////////////
		
		
		
		return excelDataList;
		
	}
	
	@RequestMapping(value = "/demandPowerStoreList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<DemandPowerExcelDataVo> demandPowerStoreList(
			@RequestParam(value = "fileName", required = false) String fileName,
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute UserVo userVo,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord,
			@RequestParam(value = "strNm", required = false) String strNm,
			@RequestParam(value = "calculateYn", required = false) String calculateYn
			) {

		LOGGER.info("demandPowerStoreList : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
			
		params.put( "userId",  sessionUserVo.getSessionUserId() );
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "strNm", strNm );                      // 매장
		params.put( "calculateYn", calculateYn );          // 산출유무
		params.put( "authId",  sessionUserVo.getSessionAuthId());
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd());
		params.put( "vendorCd", sessionUserVo.getSessionVendorCd());
		params.put( "electricentCd", sessionUserVo.getSessionElectricentCd());
		
		List<DemandPowerExcelDataVo> rslt = demandPowerExcelUtilSvc.getDemandPowerStoreList(params);
		
		int records = rslt.size();
		
		GridVo<DemandPowerExcelDataVo> gridVo = new GridVo<DemandPowerExcelDataVo>();
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		
		return gridVo;
	}
	
	@RequestMapping(value = "/saveExcel", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")	
	public void saveExcel(HttpServletRequest request, 
				String strCd,
				String strNm,				 
				HttpServletResponse response) throws Exception 
	{
		
		try {	
		  request.setCharacterEncoding("UTF-8");
		  // 파일 업로드된 경로
		  
		  //String outputFileName = strNm + "(추천계약전력)";
		  String outputFileName = strCd + "_" + strNm ;
		  String outputFileName2 = strCd + "_" + strNm ;
		  String putFileName = strNm + "(추천계약전력)";
		  int fileType = 0;
		  
		  FileInputStream fis = null;
		  boolean skip = false;
	  
		  InputStream in = null;
		  OutputStream os = null;
		  File file = null;
	
		  // 파일을 읽어 스트림에 담기
		  
		  if( fileType == 0 )
		  {
			  try {				  
				  outputFileName = outputFileName + ".XLS";
				  putFileName = strNm + "(추천계약전력)" + ".XLS";
				  file = new File("C:\\TNM\\DEMAND_POWER\\", outputFileName);				 
				  in = new FileInputStream(file);
				  skip = false;
			  }catch (FileNotFoundException fe) {
				  fileType = 1;
				  skip = true;
			  }
		  }
			  
	
		  if( fileType == 1 )
		  {
			  try {				  
				  outputFileName = outputFileName2 + ".XLSX";
				  putFileName = strNm + "(추천계약전력)" + ".XLSX";
				  file = new File("C:\\TNM\\DEMAND_POWER\\", outputFileName);
				  in = new FileInputStream(file);
				  skip = false;
			  } catch (FileNotFoundException fe) {
				  skip = true;
			  }
		  }
	
		  LOGGER.info(" outputFileName : " + outputFileName );
		  System.out.println(" outputFileName : " + outputFileName);
		  
		  String client = "";
	    
		  client = request.getHeader("User-Agent");
	
		  // 파일 다운로드 헤더 지정
		  response.reset();
		  response.setContentType("application/octet-stream");
		  response.setHeader("Content-Description", "JSP Generated Data");
	
		  if (!skip) 
		  {
			  // IE
			  if (client.indexOf("MSIE") != -1) {
				  response.setHeader(
						  "Content-Disposition",
						  "attachment; filename=\""
								  + java.net.URLEncoder.encode(putFileName,
										  "UTF-8").replaceAll("\\+", "\\ ")
								  + "\"");
				  // IE 11 이상.
			  }else if (client.indexOf("Trident") != -1) {
				  response.setHeader(
						  "Content-Disposition",
						  "attachment; filename=\""
								  + java.net.URLEncoder.encode(putFileName,
										  "UTF-8").replaceAll("\\+", "\\ ")
								  + "\"");
			  } else {
				  // 한글 파일명 처리
				  response.setHeader(
						  "Content-Disposition",
						  "attachment; filename=\""
								  + new String(putFileName.getBytes("UTF-8"),
										  "ISO8859_1") + "\"");
				  response.setHeader("Content-Type",
						  "application/octet-stream; charset=utf-8");
			  }
	
			  response.setHeader("Content-Length", "" + file.length());			  
			
	
			  os = response.getOutputStream();
			  byte b[] = new byte[(int) file.length()];
			  int leng = 0;
	
			  while ((leng = in.read(b)) > 0) 
			  {
				  os.write(b, 0, leng);
			  }
			  
		  }
		  else
		  {
			  response.setContentType("text/html;charset=UTF-8");			
			  System.out.println("<script language='javascript'>alert('error');</script>");
			  throw new RuntimeException("파일이 존재하지 않습니다.");
		  }
	
		  in.close();
		  os.close();
	  
	  
		} catch (Exception e) {
			System.out.println(" ERROR : " + e.getMessage());
		}
	}
	
	//계약전력산출 엑셀다운로드
	@RequestMapping(value = "/downloadDemandPowerExcel", method = {RequestMethod.GET, RequestMethod.POST})
	public void downloadStoreExcel (
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "srcCalculateYn", required = false) String srcCalculateYn,
			HttpServletResponse response) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strNm", scrStrNm );
		params.put( "calculateYn", srcCalculateYn );
		params.put( "authId",  sessionUserVo.getSessionAuthId());
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd());
		params.put( "electricentCd", sessionUserVo.getSessionElectricentCd());
		
		//셀렉트한 리스트는 HashMap 타입
		List rslt = demandPowerExcelUtilSvc.retrieveExcelDemandPowerStoreList( params );
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\SEMS_EXCEL\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "계약전력산출_"+ dTime +".xls";				//파일명
		String sheetNm = "계약전력산출";				//엑셀 시트명

		String arrColNm[] = new String[7]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "매장코드";
		arrColNm[1] = "매장코드";
		arrColNm[2] = "매장명";
		arrColNm[3] = "산출여부";
		arrColNm[4] = "매장면적";
		arrColNm[5] = "계약전력(kW)";
		arrColNm[6] = "TnM추천계약전력(kW)";
		
		String arrDbColNm[] = new String[7]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0] = "strCd";
		arrDbColNm[1] = "viewStrCd";
		arrDbColNm[2] = "strNm";
		arrDbColNm[3] = "calculateYn";
		arrDbColNm[4] = "storeArea";
		arrDbColNm[5] = "demandPower";
		arrDbColNm[6] = "recommendDemandPower";
		
		String alignType[] = new String[7]; //엑셀데이터 각컬럼별 정렬방향
		alignType[0] = "center";
		alignType[1] = "center";
		alignType[2] = "center";
		alignType[3] = "center";
		alignType[4] = "center";
		alignType[5] = "center";
		alignType[6] = "center";
	
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