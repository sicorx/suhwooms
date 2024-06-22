package rems.system.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import rems.system.persistence.MenuAuthMgntMapper;
import rems.system.persistence.MenuMgntMapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuMgntSvcImpl implements MenuMgntSvc {

    @Autowired
    private MenuMgntMapper menuMgntMapper;

    @Autowired
    private MenuAuthMgntMapper menuAuthMgntMapper;

    private static final Logger LOGGER = LoggerFactory.getLogger(MenuMgntSvcImpl.class);

    public List<Map<String, Object>> retrieveMenuList(HashMap<String, String> params) {
        LOGGER.info("retrieveMenuList : " + params);

        return menuMgntMapper.retrieveMenuList(params);
    }

    public void saveMenuBatch(HashMap<String, Object> insertMap, HashMap<String, Object> updateMap, HashMap<String, Object> deleteMap) {
        LOGGER.info("saveMenuBatch\ninsertMap\n{}\nupdateMap\n{}\ndeleteMap\n{}", new Object[]{insertMap, updateMap, deleteMap});

        List<HashMap<String, String>> insertList = (List<HashMap<String, String>>) insertMap.get("list");
        List<HashMap<String, String>> updateList = (List<HashMap<String, String>>) updateMap.get("list");
        List<String> deleteList = (List<String>) deleteMap.get("list");

        if (deleteList != null && deleteList.size() > 0) {
            menuAuthMgntMapper.deleteMenuAuthBatchByMenuId(deleteMap);
            menuMgntMapper.deleteMenuBatch(deleteMap);
        }
        if (updateList != null && updateList.size() > 0) {
            menuMgntMapper.updateMenuBatch(updateMap);
        }
        if (insertList != null && insertList.size() > 0) {
            menuMgntMapper.insertMenuBatch(insertMap);
        }
    }
}
