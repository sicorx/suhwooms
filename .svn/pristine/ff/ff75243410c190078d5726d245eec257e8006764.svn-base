package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.common.model.SelectVo;
import rems.system.model.GridCompanyMgntVo;
import rems.system.persistence.CompanyMgntMapper;

@Service
public class CompanyMgntSvcImpl implements CompanyMgntSvc {

	@Autowired
	private CompanyMgntMapper companyMgntMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( CompanyMgntSvcImpl.class );
	
	
	@Override
	public List<GridCompanyMgntVo> retrieveRemsCompanyList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveRemsCompanyList : " + params );
		
		return companyMgntMapper.retrieveRemsCompanyList(params);
	}
	
	@Override
	public GridCompanyMgntVo retrieveRemsCompanyMgntDtl(HashMap<String, Object> params) {
		LOGGER.info( "retrieveRemsCompanyMgntDtl : " + params );
		
		return companyMgntMapper.retrieveRemsCompanyMgntDtl(params);
	}
	
	@Override
	public boolean checkCompanyCd(String params) {
		LOGGER.info( "checkCompanyCd : " + params );
		
		boolean rslt   = false;
		int countRslt = 0;
		
		countRslt = companyMgntMapper.checkCompanyCd(params);

		if(countRslt == 0){
			rslt = true;
		}
		else{
			rslt = false;
		}		
		
		return rslt;
	}
	
	@Override
	public boolean checkCompanyStrCd(String params) {
		LOGGER.info( "checkCompanyStrCd : " + params );
		
		boolean rslt   = false;
		int countRslt = 0;
		
		countRslt = companyMgntMapper.checkCompanyStrCd(params);

		if(countRslt == 0){
			rslt = true;
		}
		else{
			rslt = false;
		}		
		
		return rslt;
	}
	
	@Override
	public boolean saveRemsCompanyMgnt(GridCompanyMgntVo params) {

		LOGGER.info( "saveRemsCompanyMgnt : " + params );
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		updateRslt = companyMgntMapper.saveRemsCompanyMgnt(params);
		
		if(updateRslt == 0){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}
	
	@Override
	public boolean deleteRemsCompanyMgnt(GridCompanyMgntVo params) {

		LOGGER.info( "deleteRemsCompanyMgnt : " + params );
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		updateRslt = companyMgntMapper.deleteRemsCompanyMgnt(params);
		
		if(updateRslt == 0){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}

	@Override
	public List<SelectVo> retrieveCountryList() {
		LOGGER.info( "retrieveCountryList : " );
		
		return companyMgntMapper.retrieveCountryList();
	}
	
}
