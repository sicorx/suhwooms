package rems.common.ctrl;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import rems.common.persistence.CommonMapper;
import rems.common.service.CommonSvc;

//@Controller
public class RetrieveSysdateCtrl {

	// 서비스 이용
	//@Autowired
	private CommonSvc commonSvc;
	
	// 퍼시스턴스 이용
	//@Autowired
	private CommonMapper commonMapper;

	// sqlSession 직접 이용
	//@Autowired
	private SqlSession sqlSession;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(RetrieveSysdateCtrl.class);
	
	//@RequestMapping(value = "/nowBySvc", method = RequestMethod.GET)
	public void retrieveSysdateBySvc() {

		String rslt = commonSvc.retrieveSysdate();

		LOGGER.info( "retrieveSysdateBySvc : " + rslt );
	}

	//@RequestMapping(value = "/nowByPersistence", method = RequestMethod.GET)
	public void retrieveSysdateByPersistence() {
		
		String rslt = commonMapper.retrieveSysdate();

		LOGGER.info( "retrieveSysdateByPersistence : " + rslt );
	}

	//@RequestMapping(value = "/nowBySqlSession", method = RequestMethod.GET)
	public void retrieveSysdateBySqlSession() {
		
		CommonMapper mapper = sqlSession.getMapper( CommonMapper.class );
		
		String rslt = mapper.retrieveSysdate();
		
		LOGGER.info( "retrieveSysdateBySqlSession : " + rslt );
	}
}
