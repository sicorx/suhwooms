package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.system.model.GridStoreFcltyMgntVo;
import rems.system.persistence.StoreFcltyMgntMapper;

@Service
public class StoreFcltyMgntSvcImpl implements StoreFcltyMgntSvc {

	@Autowired
	private StoreFcltyMgntMapper StoreFcltyMgntMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( StoreFcltyMgntSvcImpl.class );
	
	@Transactional
	@Override
	public List<GridStoreFcltyMgntVo> retrieveStoreFcltyMgnt(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreFcltyMgnt : " + params );
		
		List<GridStoreFcltyMgntVo> list = StoreFcltyMgntMapper.retrieveStoreFcltyMgnt(params);
		
		int cnt = commonMapper.selectTotalCnt();
		if( cnt != 0 )		
			list.get(0).setTotal(String.valueOf(cnt));				
		
		return list;
	}
	 
	@Override
	public GridStoreFcltyMgntVo retrieveStoreFcltyMgntDtl(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreFcltyMgntDtl : " + params );
		
		return StoreFcltyMgntMapper.retrieveStoreFcltyMgntDtl(params);
	}
	
	@Override
	public List<GridStoreFcltyMgntVo> retrieveStoreFcltyMgntDtlList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreFcltyMgntDtlList : " + params );
		
		return StoreFcltyMgntMapper.retrieveStoreFcltyMgntDtlList(params);
	}
	
	
	@Override
	public boolean saveStoreFcltyMgnt(GridStoreFcltyMgntVo params) {
		LOGGER.info( "saveStoreFcltyMgnt : " + params );
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		updateRslt = StoreFcltyMgntMapper.saveStoreFcltyMgnt(params);
		
		if(updateRslt == 0){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}
	
	@Override
	public boolean saveStoreFcltyMgntList(GridStoreFcltyMgntVo params) {
		LOGGER.info( "saveStoreFcltyMgntList ");
		
		boolean rslt   = false;
		int updateRslt = 0;
		
		GridStoreFcltyMgntVo param;
		LOGGER.info( "params.getTemonIds().length "+params.getTemonIds().length);
		LOGGER.info( "params.getUseYns().length "+params.getUseYns().length);
		
		if(params != null && params.getTemonIds() != null && params.getTemonIds().length > 0){			
			
			for(int i=0;i<params.getTemonIds().length;i++){
				
				param = new GridStoreFcltyMgntVo();
				param.setStrCd(params.getStrCd());
				param.setTemonId(params.getTemonIds()[i]);
				param.setTemonType(params.getTemonTypes()[i]);
				param.setPortNo(params.getPortNos()[i]);		
				param.setDeviceType(params.getDeviceTypes()[i]);
				param.setDeviceLoc(params.getDeviceLocs()[i]);
				param.setContent(params.getContents()[i]);
				param.setMaxTemp(params.getMaxTemps()[i]);
				param.setMinTemp(params.getMinTemps()[i]);
				param.setDelayTime(params.getDelayTimes()[i]);
				param.setTempConf(params.getTempConfs()[i]);
				param.setPushTerm(params.getPushTerms()[i]);
				param.setUseYn(params.getUseYns()[i]);
				param.setRegiId(params.getRegiId());
				param.setFinalModId(params.getFinalModId());
				param.setNow(params.getNow());
				
				updateRslt = StoreFcltyMgntMapper.saveStoreFcltyMgntList(param);
			}
		}
		
		
		if(updateRslt == 0){
			rslt = false;
		}
		else{
			rslt = true;
		}
		
		return rslt;
	}
	
	@Override
	public int saveStoreFcltyMgnt_init(HashMap<String, Object> params )
	{
		LOGGER.info( "saveStoreFcltyMgnt_init : " + params );		
		return StoreFcltyMgntMapper.saveStoreFcltyMgnt_init(params);
	}
	
	@Override
	public int delStoreFcltyMgnt(HashMap<String, Object> params )
	{
		LOGGER.info( "delStoreFcltyMgnt : " + params );		
		return StoreFcltyMgntMapper.delStoreFcltyMgnt(params);
	}
}
