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
import rems.eqmt.model.GridStoreFcltyAlrmHisVo;
import rems.eqmt.service.EqmtAlarmHistorySvc;
import rems.system.model.UserVo;

@Controller
@SessionAttributes("sessionUserVo")
public class EqmtAlarmHistoryCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(EqmtAlarmHistoryCtrl.class);

	@Autowired
	private EqmtAlarmHistorySvc svc;

	/**
	 * 매장장비알람이력
	 * @param userVo
	 * @param strCd
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/storeFcltyAlrmHis", method = {RequestMethod.GET, RequestMethod.POST})
	public String showStoreFcltyAlrmHis(
			@ModelAttribute UserVo userVo,
			@RequestParam(value = "strCd", required = false) String strCd,
			ModelMap model) {

		HashMap<String,Object> params = new HashMap<String,Object>();
		if(strCd != null && !strCd.equals("")){
			params.put( "strCd", strCd );			
		}else{
			params.put( "strCd", "RG0000000" );		//임의의 매장코드	
		}
		//장치 select
		List<SelectVo> rslt = svc.retrieveStrFcltyAlrmPortNo(params);		
		
		model.addAttribute("selectVoList", rslt);
		model.addAttribute( userVo );
		
		return "eqmt/eqmtAlarmHistory";
	}	
	
		
	/**
	 * 매장 장비 알람 이력 조회 
	 * @param vo
	 * @param scrStrCd
	 * @param scrPortNo
	 * @param scrYyyymmdd
	 * @param scrAlarmYn
	 * @param page
	 * @param rows
	 * @param sidx
	 * @param sord
	 * @return
	 */
	@RequestMapping(value = "/retrieveStoreFcltyAlrmHis", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridStoreFcltyAlrmHisVo> retrieveInvSttsInqty(
			@ModelAttribute UserVo vo,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrPortNo", required = false) String scrPortNo,
			@RequestParam(value = "scrYyyymmdd", required = false) String scrYyyymmdd,
			@RequestParam(value = "scrAlarmYn", required = false) String scrAlarmYn,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveInvSttsInqty : " + page + ", " + rows + ", " + sidx + ", " + sord + ", " + scrAlarmYn);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "strCd", scrStrCd );
		params.put( "portNo", scrPortNo );
		params.put( "yyyymmdd", scrYyyymmdd );
		params.put( "alarmYn", scrAlarmYn );
		
		List<GridStoreFcltyAlrmHisVo> rslt = svc.retrieveStoreFcltyAlrmHis( params );
		
		int records = rslt.size();
		
		GridVo<GridStoreFcltyAlrmHisVo> gridVo = new GridVo<GridStoreFcltyAlrmHisVo>();
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
