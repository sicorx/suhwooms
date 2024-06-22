package rems.system.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;
import rems.system.persistence.SystemMapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SystemSvcImpl implements SystemSvc {

    @Autowired
    private SystemMapper systemMapper;

    private static final Logger LOGGER = LoggerFactory.getLogger(SystemSvcImpl.class);

    @Override
    public SessionUserVo retrieveLoginUser(UserVo params) {
        LOGGER.info("retrieveLoginUser : " + params);

        return systemMapper.retrieveLoginUser(params);
    }

    @Override
    public int saveEulaYn(HashMap<String, Object> params) {
        LOGGER.info("saveEulaYn : " + params);

        return systemMapper.saveEulaYn(params);
    }

    @Override
    public Map<String, Object> retrieveTopAreaInfo(Map<String, String> params) {
        LOGGER.info("retrieveMenu : " + params);

        return systemMapper.retrieveTopAreaInfo(params);
    }

    @Override
    public List<Map<String, Object>> retrieveMenu(Map<String, String> params) {
        LOGGER.info("retrieveMenu : " + params);

        return systemMapper.retrieveMenu(params);
    }
}
