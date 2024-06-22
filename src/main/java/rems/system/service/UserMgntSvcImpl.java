package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.model.SelectVo;
import rems.common.persistence.CommonMapper;
import rems.system.model.GridStoreMgntVo;
import rems.system.model.GridUserMgntVo;
import rems.system.persistence.UserMgntMapper;

@Service
public class UserMgntSvcImpl implements UserMgntSvc {

	@Autowired
	private UserMgntMapper userMgntMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( UserMgntSvcImpl.class );
	
	@Transactional
	@Override
	public List<GridUserMgntVo> retrieveRemsUserList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveRemsUserList : " + params );
		
		List<GridUserMgntVo> list = userMgntMapper.retrieveRemsUserList(params);
		
		int cnt = commonMapper.selectTotalCnt();
		if( cnt != 0 )		
			list.get(0).setTotal(String.valueOf(cnt));				
		
		return list;
		
		
	}
	
	@Override
	public GridUserMgntVo retrieveRemsUserMgntDtl(HashMap<String, Object> params) {
		LOGGER.info( "retrieveRemsStoreMgntDtl : " + params );
		
		return userMgntMapper.retrieveRemsUserMgntDtl(params);
	}
	
	@Override
	public boolean checkUserId(String params) {
		LOGGER.info( "checkUserId : " + params );
		
		boolean rslt   = false;
		int countRslt = 0;
		
		countRslt = userMgntMapper.checkUserId(params);

		if(countRslt == 0){
			rslt = true;
		}
		else{
			rslt = false;
		}		
		
		return rslt;
	}
	
	@Override
	public boolean saveRemsUserMgnt(GridUserMgntVo params) {

		LOGGER.info( "saveRemsUserMgnt : " + params );
		
		boolean rslt   = false;
		int updateUser = 0;
		int updateAuthId = 0;
		int updateStrMap = 0;
		
		String authId = params.getAuthId();
		String vendorCd = params.getVendorCd();
		
		// 유지보수업체 ? 전기업체 ? 나눠서 DB 인설트		
		
		
		// 공통 DB Insert
		updateUser = userMgntMapper.saveRemsUserMgnt( params );		// th_user 테이블 저장		
		updateAuthId = userMgntMapper.saveRemsUserAuth(params);		// th_user_auth 테이블 저장
		
		
		
		
		if( authId.equalsIgnoreCase("1") )			// 본부관리자 H
		{			
		}
		if( authId.equalsIgnoreCase("2") )			// 본부사용자 H
		{
			
		}		
		if( authId.equalsIgnoreCase("3") )			// 유지보수업체 M
		{
		}	
		if( authId.equalsIgnoreCase("4") )			// 매장사용자 S
		{
			// 매장사용자 일경우
			// th_str_user_map 테이블 저장
			updateStrMap = userMgntMapper.saveRemsUserStrMap( params );
		}
		if( authId.equalsIgnoreCase("5") )			// 전기업체 T
		{
		}
		
		if(updateUser == 0 && updateAuthId == 0){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}
	
	@Override
	public boolean deleteRemsUserMgnt(HashMap<String, Object> params) {

		LOGGER.info( "deleteRemsUserMgnt : " + params );		
		boolean rslt   = false;
		int updateRslt = 0;		
		updateRslt = userMgntMapper.deleteRemsUserMgnt(params);		
		if(updateRslt == 0){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}	
	
	@Override
	public boolean deleteRemsUserAuthMgnt(HashMap<String, Object> params) {

		LOGGER.info( "deleteRemsUserAuthMgnt : " + params );
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		updateRslt = userMgntMapper.deleteRemsUserAuthMgnt(params);
		
		if(updateRslt == 0){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}	
	

	@Override
	public List<SelectVo> retrieveAuthHList(String params) {
		LOGGER.info( "retrieveAuthHList : " + params );
		
		return userMgntMapper.retrieveAuthHList(params);
	}
	
	@Override
	public List<SelectVo> retrieveAuthMList(String params) {
		LOGGER.info( "retrieveAuthMList : " + params );
		
		return userMgntMapper.retrieveAuthMList(params);
	}
	
	@Override
	public List<SelectVo> retrieveAuthSList(String params) {
		LOGGER.info( "retrieveAuthSList : " + params );
		
		return userMgntMapper.retrieveAuthSList(params);
	}
	
	@Override
	public List<SelectVo> retrieveAuthTList(String params) {
		LOGGER.info( "retrieveAuthTList : " + params );
		
		return userMgntMapper.retrieveAuthTList(params);
	}
	
	@Override
	public List<SelectVo> retrieveVendorList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveVendorList : " );
		
		return userMgntMapper.retrieveVendorList(params);
	}
	
	
	@Override
	public List<SelectVo> retrieveElectricEntList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveElectricEntList : " );
		
		return userMgntMapper.retrieveElectricEntList(params);
	}

}
