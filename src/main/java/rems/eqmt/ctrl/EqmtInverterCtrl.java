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
import rems.common.model.SelectVo;
import rems.common.service.CommonSvc;
import rems.eqmt.model.GridStoreInverterVo;
import rems.eqmt.service.EqmtInverterSvc;
import rems.system.model.SessionUserVo;

@Controller
@SessionAttributes("sessionUserVo")
public class EqmtInverterCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(EqmtInverterCtrl.class);

	@Autowired
	private EqmtInverterSvc svc;
	
	@Autowired
	private CommonSvc commonSvc;

	
	/**
	 * 인버터 상세 목록
	 * @param sessionUserVo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/2004", method = {RequestMethod.GET, RequestMethod.POST})
	public String showStoreInverter(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {

		LOGGER.info("showStore Inverter Status" );
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		
		//회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt.size();
		
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoListCnt", selectVoListCnt );
		
		return "eqmt/inverter/eqmtInverterList";
	}
		
	@RequestMapping(value = "/retrieveStoreInverterList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridStoreInverterVo> retrieveStoreInverterList(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "viewStrCd", required = false) String viewStrCd,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrAlarmYn", required = false) String scrAlarmYn,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveStoreInverterList : " + page + ", " + rows + ", " + sidx + ", " + sord +", "+scrAlarmYn);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );
		params.put( "strCd", scrStrCd );
		params.put( "orgCd", scrOrgCd );
		params.put( "alarmYn", scrAlarmYn );
		
		List<GridStoreInverterVo> rslt = svc.retrieveStoreInverter( params );
		
		int records = rslt.size();
		
		GridVo<GridStoreInverterVo> gridVo = new GridVo<GridStoreInverterVo>();
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