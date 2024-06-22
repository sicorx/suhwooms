package rems.system.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import rems.system.persistence.MenuAuthMgntMapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuAuthMgntSvcImpl implements MenuAuthMgntSvc {

    @Autowired
    private MenuAuthMgntMapper mapper;

    private static final Logger LOGGER = LoggerFactory.getLogger(MenuAuthMgntSvcImpl.class);

    @Override
    public List<Map<String, Object>> retrieveAuthList(Map<String, String> params) {
        LOGGER.info("retrieveAuthList : " + params);

        return mapper.retrieveAuthList(params);
    }

    @Override
    public List<Map<String, Object>> retrieveMenuAuthList(Map<String, String> params) {
        LOGGER.info("retrieveMenuAuthList : " + params);

        return mapper.retrieveMenuAuthList(params);
    }

    @Override
    public void saveAuthBatch(HashMap<String, Object> insertMap, HashMap<String, Object> updateMap, HashMap<String, Object> deleteMap) {
        List<HashMap<String, String>> insertList = (List<HashMap<String, String>>) insertMap.get("list");
        List<HashMap<String, String>> updateList = (List<HashMap<String, String>>) updateMap.get("list");
        List<String> deleteList = (List<String>) deleteMap.get("list");

        if (deleteList != null && deleteList.size() > 0) {
            mapper.deleteMenuAuthBatchByAuthId(deleteMap);
            mapper.deleteAuthBatch(deleteMap);
        }
        if (updateList != null && updateList.size() > 0) {
            mapper.updateAuthBatch(updateMap);
        }
        if (insertList != null && insertList.size() > 0) {
            mapper.insertAuthBatch(insertMap);
        }
    }

    @Override
    public void saveMenuAuthBatch(HashMap<String, Object> insertMap, HashMap<String, Object> deleteMap) {
        List<String> insertList = (List<String>) insertMap.get("list");
        List<String> deleteList = (List<String>) deleteMap.get("list");

        if (deleteList != null && deleteList.size() > 0) {
            mapper.deleteMenuAuthBatch(deleteMap);
        }
        if (insertList != null && insertList.size() > 0) {
            mapper.insertMenuAuthBatch(insertMap);
        }
    }
}
