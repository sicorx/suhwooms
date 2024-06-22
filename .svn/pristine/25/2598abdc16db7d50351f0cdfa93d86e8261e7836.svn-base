package rems.eqmt.ctrl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
import rems.eqmt.model.ControlInverterVo;
import rems.eqmt.model.GridInverterStatusVo;
import rems.eqmt.service.EqmtInverterControlSvc;
import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;

@Controller
@SessionAttributes("sessionUserVo")
public class EqmtInverterControlCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(EqmtInverterControlCtrl.class);

	@Autowired
	private EqmtInverterControlSvc svc;
	
	@Autowired
	private CommonSvc commonSvc;
	
	@RequestMapping(value = "/4206", method = {RequestMethod.GET, RequestMethod.POST})
	public String showInvSttsInqty(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute UserVo userVo,
			ModelMap model) {

		LOGGER.info("retrieveStoreRemsMgnt" );
		HashMap<String,Object> params = new HashMap<String,Object>();
		
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		
		//회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);		
		int selectVoListCnt = rslt.size();
		
		model.addAttribute("selectVoListCnt", selectVoListCnt);
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params );
		
		return "eqmt/inverter/eqmtInverterControlList";
	}	
		
	@RequestMapping(value = "/retrieveInverterControlList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridInverterStatusVo> retrieveInverterControlList(
			@RequestParam(value = "scrCompanyCd", required = false) String companyCd,
			@RequestParam(value = "scrStrCd", required = false) String strCd,
			@RequestParam(value = "scrOrgCd", required = false) String orgCd,
			@RequestParam(value = "scrAlarmYn", required = false) String alarmYn,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveInverterControlList : " + page + ", " + rows + ", " + sidx + ", " + sord + ", " + alarmYn);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", companyCd );
		params.put( "strCd", strCd );
		params.put( "orgCd", orgCd );
		params.put( "alarmYn", alarmYn );
		
		List<GridInverterStatusVo> rslt = svc.retrieveInverterControlList( params );
		
		int records = rslt.size();
		
		GridVo<GridInverterStatusVo> gridVo = new GridVo<GridInverterStatusVo>();
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		
		return gridVo;
	}
	
	@RequestMapping(value = "/eqmtInverterControl", method = {RequestMethod.GET, RequestMethod.POST})
	public String eqmtInverterControl(
			@RequestParam(value = "strCd", required = false) String strCd,
			@RequestParam(value = "hubId", required = false) String hubId,
			@RequestParam(value = "portNo", required = false) String portNo,
			ModelMap model) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		params.put( "hubId", hubId );
		params.put( "portNo", portNo );
		LOGGER.info("strCd : "+ strCd +", portNo : "+ portNo);
		
		GridInverterStatusVo rslt = svc.retrieveInverterControlDtl( params );
		rslt.splitMaskInfo();
		
		model.addAttribute("gisVo", rslt);

		return "eqmt/inverter/eqmtInverterControl";
	}
	
	@RequestMapping(value = "/controlInverterSignleMachine", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean controlInverterSignleMachine(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute ControlInverterVo controlInverterVo,
			BindingResult bindingResult,
			ModelMap model,
			HttpSession session) throws Exception {

		LOGGER.info("controlInverterSignleMachine : " + controlInverterVo.getStrCd() +"," + controlInverterVo.getHubId() +"," + controlInverterVo.getPortNo());
		boolean rslt = false;
		
		int gwId = svc.retrieveGwId( controlInverterVo.getStrCd() );
		controlInverterVo.setGwId(gwId);
		
		//제어 실행

		//응답 실행
		return rslt;
	}
	
}