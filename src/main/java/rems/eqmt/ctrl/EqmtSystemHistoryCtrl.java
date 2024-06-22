package rems.eqmt.ctrl;

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
import rems.eqmt.model.SystemVo;
import rems.eqmt.service.EqmtSystemHistorySvc;
import rems.system.model.SessionUserVo;

@Controller
@SessionAttributes("sessionUserVo")
public class EqmtSystemHistoryCtrl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EqmtSystemHistoryCtrl.class);
	
	@Autowired
	private EqmtSystemHistorySvc eqmtSystemHistorySvc;
	
	@RequestMapping(value = "/retrieveSystemList", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveSystemList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrUserId", required = false) String scrUserId,
			@RequestParam(value = "scrAuthId", required = false) String scrAuthId,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,
			ModelMap model) {
		

		HashMap<String,Object> scr_params = new HashMap<String,Object>();
		scr_params.put("companyCd", sessionUserVo.getSessionCompanyCd());	
		
		scr_params.put("scrUserId", scrUserId);	
		scr_params.put("scrAuthId", scrAuthId);				
		scr_params.put("scrDateFrom", scrDateFrom);	
		scr_params.put("scrDateTo", scrDateTo);
		
		List<SystemVo> rslt = eqmtSystemHistorySvc.retrieveAuthIdList(scr_params);
		
		
		model.addAttribute("companyCd", sessionUserVo.getSessionCompanyCd());
		model.addAttribute("scrValue", scr_params);
		model.addAttribute("selectVoList", rslt);

		return "eqmt/eqmtSysHistory";	
	}   
	
	
	@RequestMapping(value = "/retrieveSysHistory", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<SystemVo> retrieveSysHistory(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "userId", required = false) String userId,
			@RequestParam(value = "authId", required = false) String authId,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,			
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveSysHistory : " + page + ", " + rows + ", " + sidx + ", " + sord);

		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put("limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put("sidx", sidx );                        // 정렬 기준 컬럼
		params.put("sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());
		params.put("userId", userId);
		params.put("authId", authId);
		params.put("scrDateFrom", scrDateFrom.replace("-", "") );
		params.put("scrDateTo", scrDateTo.replace("-", "") );	
	
		List<SystemVo> rslt = eqmtSystemHistorySvc.retrieveSysHistory(params);
		
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
	
	
	@RequestMapping(value = "/retrieveSysHistory2", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<SystemVo> retrieveSysHistory2(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "userId", required = false) String userId,
			@RequestParam(value = "authId", required = false) String authId,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,			
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveSysHistory2 : " + page + ", " + rows + ", " + sidx + ", " + sord);

		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put("limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put("sidx", sidx );                        // 정렬 기준 컬럼
		params.put("sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());
		params.put("userId", userId);
		params.put("authId", authId);
		params.put("scrDateFrom", scrDateFrom.replace("-", "") );
		params.put("scrDateTo", scrDateTo.replace("-", "") );	
	
		List<SystemVo> rslt = eqmtSystemHistorySvc.retrieveSysHistory2(params);
		
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
