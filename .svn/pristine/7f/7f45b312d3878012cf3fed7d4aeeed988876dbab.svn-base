package rems.eqmt.ctrl;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import rems.common.model.GridVo;
import rems.common.model.SelectVo;
import rems.common.service.CommonSvc;
import rems.eqmt.model.GridTemonStatusVo;
import rems.eqmt.service.EqmtTemonStatusSvc;
import rems.system.model.SessionUserVo;

@Controller
@SessionAttributes("sessionUserVo")
public class EqmtTemonStatusCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(EqmtTemonStatusCtrl.class);

	@Autowired
	private EqmtTemonStatusSvc svc;
	
	@Autowired
	private CommonSvc commonSvc;
	
	@RequestMapping(value = "/3204", method = {RequestMethod.GET, RequestMethod.POST})
	public String showTemonStatus(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "strCd", required = false) String strCd,
			@RequestParam(value = "strNm", required = false) String strNm,
			@RequestParam(value = "viewStrCd", required = false) String viewStrCd,
			ModelMap model) {

		LOGGER.info("showTemonStatus : "+strCd);
		
		HashMap<String,Object> params = new HashMap<String,Object>();

		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		params.put( "yyyyMmDd", sessionUserVo.getSessionYyyyMmDd() );
		
		if(sessionUserVo.getSessionScrStrCd() != "" && sessionUserVo.getSessionScrStrCd() != null ){

			String cd = sessionUserVo.getSessionScrStrCd();
			String nm = sessionUserVo.getSessionScrStrNm();
			String vc = sessionUserVo.getSessionScrViewStrCd();
			
			params.put( "strCd", cd );
			params.put( "strNm", nm );
			params.put( "viewStrCd", vc );
			
		}
		
		if( strCd != null ){
			sessionUserVo.setSessionScrStrCd(strCd);
			sessionUserVo.setSessionScrStrNm(strNm);
			sessionUserVo.setSessionScrViewStrCd(viewStrCd);

		}else{
			sessionUserVo.setSessionScrStrCd(null);
			sessionUserVo.setSessionScrStrNm(null);
			sessionUserVo.setSessionScrViewStrCd(null);
		}
		
		//회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt.size();
		
		List<SelectVo> rslt2 = svc.retrieveTemonList(params);
		
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("selectVoListCnt", selectVoListCnt );
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoList2", rslt2);
		
		return "eqmt/eqmtTemonStatus";
	}
	
	@RequestMapping(value = "/retrieveTemonStatusList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridTemonStatusVo> retrieveTemonStatusList(
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrYyyyMmDd", required = false) String scrYyyyMmDd,
			@RequestParam(value = "scrAlarmYn", required = false) String scrAlarmYn,
			
			@RequestParam(value = "scrTemonId", required = false) String scrTemonId,
			@RequestParam(value = "scrTemonType", required = false) String scrTemonType,
			@RequestParam(value = "scrPortNo", required = false) String scrPortNo,
			
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveTemonStatusList : " + page + ", " + rows + ", " + sidx + ", " + sord + ", " + scrAlarmYn);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "strCd", scrStrCd );
		params.put( "temonId", scrTemonId );
		params.put( "temonType", scrTemonType );
		params.put( "portNo", scrPortNo );
		params.put( "yyyyMmDd", scrYyyyMmDd );
		params.put( "alarmYn", scrAlarmYn ); 
		
		List<GridTemonStatusVo> rslt = svc.retrieveTemonStatusList( params );
		
		int records = rslt.size();
		
		GridVo<GridTemonStatusVo> gridVo = new GridVo<GridTemonStatusVo>();
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		
		return gridVo;
	}
	
	@RequestMapping(value = "/retrieveTemonList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<SelectVo> retrieveTemonList(
			@RequestParam(value = "scrStrCd", required = false) String strCd) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );

		List<SelectVo> rslt = svc.retrieveTemonList(params);
		
		return rslt;
	}
	
	@RequestMapping(value = "/retrieveTemonTempChart", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveTemonTempChart(
			@RequestParam(value = "strCd", required = false) String strCd,
			@RequestParam(value = "yyyyMmDd", required = false) String yyyyMmDd,
			@RequestParam(value = "portNo", required = false) String portNo,
			ModelMap model) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		params.put( "yyyyMmDd", yyyyMmDd );	
		params.put( "portNo", portNo );
		
		List<SelectVo> rslt = svc.retrieveTemonList(params);
		
		model.addAttribute("eqmtVo", params);
		model.addAttribute("eqmtList", rslt);
		
		return "eqmt/eqmtTemonTempSrchPop";
	}
	
	@RequestMapping(value = "/retrieveTemonTempChartData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object retrieveTemonTempChartData(
			@RequestParam(value = "strCd", required = false) String strCd,
			@RequestParam(value = "yyyyMmDd", required = false) String yyyyMmDd,
			@RequestParam(value = "temonId", required = false) String temonId,
			@RequestParam(value = "temonType", required = false) String temonType,
			@RequestParam(value = "portNo", required = false) String portNo,
			ModelMap model) throws UnsupportedEncodingException {
		
		LOGGER.info( "retrieveTemonTempChartData " );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		params.put( "yyyyMmDd", yyyyMmDd );	
		params.put( "temonId", temonId );
		params.put( "temonType", temonType );
		params.put( "portNo", portNo );
		
		return svc.retrieveTemonTempChartData( params );
	}
}