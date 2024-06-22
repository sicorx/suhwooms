package rems.common.ctrl;

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
import rems.common.model.UserMngVo;
import rems.common.service.CommonSvc;
import rems.system.model.UserVo;

@Controller
@SessionAttributes("sessionUserVo")
public class UserSrchCtrl {
 
	private static final Logger LOGGER = LoggerFactory.getLogger(StoreSrchCtrl.class);

	@Autowired
	private CommonSvc commonSvc;
	
	// TODO 페이지 쇼 메소드 매핑 일괄 수정	
	@RequestMapping(value = "/userMngSrch", method = {RequestMethod.GET, RequestMethod.POST})
	public String showStoreMngSrch(
			@ModelAttribute UserVo userVo,
			@RequestParam(value = "companyCd", required = false) String companyCd,
			ModelMap model) {

		LOGGER.info("retrieveUserMngSrch" );
		
		model.addAttribute("companyCd", companyCd );
		
		return "common/userSrch";
	}	
	
	// TODO 사용자정보 조회	
	@RequestMapping(value = "/retrieveUserSrch", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<UserMngVo> retrieveUserSrch(
			@ModelAttribute UserVo vo,
			@RequestParam(value = "srchCompanyCd", required = false) String companyCd,
			@RequestParam(value = "srchUserId", required = false) String userId,
			@RequestParam(value = "srchUserNm", required = false) String userNm,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info(" " + page + ", " + rows + ", " + sidx + ", " + sord + ", " + userId + ", " + userNm);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", companyCd );
		params.put( "userId", userId );
		params.put( "userNm", userNm );
		
		List<UserMngVo> rslt = commonSvc.retrieveUserList( params );
		
		int records = rslt.size();
		
		GridVo<UserMngVo> gridVo = new GridVo<UserMngVo>();
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
