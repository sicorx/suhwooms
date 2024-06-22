package rems.common.ctrl;


import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import rems.common.model.AreaVo;
import rems.common.model.GridVo;
import rems.common.service.CommonSvc;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.common.ctrl
 * @Class Name : AreaSrchCtrl.java
 * @Description : 공통 > 기상지역 조회 팝업
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 14.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 14. 오전 11:34:26
 * @version 2.0
 * 
 */
@Controller
public class AreaSrchCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(AreaSrchCtrl.class);

	@Autowired
	private CommonSvc commonSvc;
	
	/**
	 * 기상지역 조회 카운트
	 * 
	 * @author 유승만
	 * @param companyCd : 회사 코드
	 * @param localAreaNm : 기상지역 명
	 * @return rslt
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveAreaCdCnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<AreaVo> retrieveAreaCdCnt(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "localAreaNm", required = false) String localAreaNm
			) {
		
		LOGGER.error("retrieveAreaCdCnt : " + companyCd + ", " + localAreaNm);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", companyCd );		// 회사 코드
		params.put( "localAreaNm", localAreaNm );	// 기상지역 명
		
		// 기상지역 조회 카운트
		AreaVo rslt = commonSvc.retrieveAreaCdCnt( params );
		
		return rslt;
	}
	
	/**
	 * 기상지역 조회 팝업 페이지
	 * 
	 * @author JooYoung
	 * @param companyCd : 회사코드
	 * @param localAreaNm : 기상지역명
	 * @return view : areaSrch
	 * @exception Exception
	 */
	@RequestMapping(value = "/showAreaSrch", method = {RequestMethod.GET, RequestMethod.POST})
	public String showAreaSrch(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "localAreaNm", required = false) String localAreaNm,			
			ModelMap model
			) {

		LOGGER.error("showAreaSrch : " + companyCd + ", " + localAreaNm );
		
		model.addAttribute("companyCd", companyCd);			// 회사코드
		model.addAttribute("localAreaNm", localAreaNm);		// 기상지역명
		
		return "common/areaSrch";
	}
	
	/**
	 * 기상지역 조회 목록(팝업)
	 * 
	 * @author JooYoung
	 * @param comapnyCd : 회사코드
	 * @param localAreaNm : 기상지역명
	 * @param page : 요청한 페이지
	 * @param rows : 페이지 당 보여줄 행의 개수
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveAreaSrch", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<AreaVo> retrieveAreaSrch(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "localAreaNm", required = false) String localAreaNm,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("retrieveAreaSrch : " + page + ", " + rows + ", " + sidx + ", " + sord + " / "+ companyCd + ", " + localAreaNm);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", companyCd );				// 회사 코드
		params.put( "localAreaNm", localAreaNm );			// 기상지역 명
		
		// 기상지역 조회 목록
		List<AreaVo> rslt = commonSvc.retrieveAreaCd( params );		
		int records = rslt.size();
		
		GridVo<AreaVo> gridVo = new GridVo<AreaVo>();
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		return gridVo;
		
	}
	
	// TODO 기상지역 시도 조회	
	@RequestMapping(value = "/retrieveAreaNmSrch", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<AreaVo> remsAreaNmSrch(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "areaCd", required = false) String areaCd,
			@RequestParam(value = "areaNm", required = false) String areaNm
		) {
		
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", companyCd );
		params.put( "areaCd", areaCd );
		params.put( "areaNm", areaNm );
		
		List<AreaVo> rslt = commonSvc.retrieveAreaNm(params);
		
		
		GridVo<AreaVo> gridVo = new GridVo<AreaVo>();
		gridVo.setRows( rslt );                         // 결과값
		
		return gridVo;
	}
	
	// TODO 기상지역 시구군 조회	
	@RequestMapping(value = "/retrieveCityNmSrch", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<AreaVo> remsCityNmSrch(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "areaCd", required = false) String areaCd,
			@RequestParam(value = "areaNm", required = false) String areaNm
			) {
		
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", companyCd );
		params.put( "areaCd", areaCd );
		params.put( "areaNm", areaNm );
		
		List<AreaVo> rslt = commonSvc.retrieveCityNm(params);
		
		
		GridVo<AreaVo> gridVo = new GridVo<AreaVo>();
		gridVo.setRows( rslt );                         // 결과값
		
		return gridVo;
	}
	
	// TODO 기상지역 동 조회	
	@RequestMapping(value = "/retrieveDongNmSrch", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<AreaVo> remsDongNmSrch(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "cityCd", required = false) String cityCd,
			@RequestParam(value = "cityNm", required = false) String cityNm
			) {
		
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", companyCd );
		params.put( "cityCd", cityCd );
		params.put( "cityNm", cityNm );
		
		List<AreaVo> rslt = commonSvc.retrieveDongNm(params);
		
		
		GridVo<AreaVo> gridVo = new GridVo<AreaVo>();
		gridVo.setRows( rslt );                         // 결과값
		
		return gridVo;
	}
}
