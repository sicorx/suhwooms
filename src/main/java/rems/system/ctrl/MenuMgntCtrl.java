package rems.system.ctrl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import rems.system.model.SessionUserVo;
import rems.system.service.MenuMgntSvc;
import rems.util.TimezoneUtils;
import rems.util.FancytreeData;
import rems.util.TreeUtil;

import java.util.*;


@Controller
@SessionAttributes("sessionUserVo")
public class MenuMgntCtrl {

    private static final Logger LOGGER = LoggerFactory.getLogger(MenuMgntCtrl.class);

    @Autowired
    private MenuMgntSvc svc;

    @RequestMapping(value = "/4401", method = {RequestMethod.GET, RequestMethod.POST})
    public String showMenuMgnt(
            @ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
            ModelMap model) {

        LOGGER.info("retrieveMenuMgnt : ");

        HashMap<String, String> params = new HashMap<>();
        params.put("companyCd", sessionUserVo.getSessionCompanyCd());

        List<Map<String, Object>> menuList = svc.retrieveMenuList(params);
        String menuJson = TreeUtil.makeJson(new FancytreeData(menuList, "menuId", "menuNm", "indexHier", "새메뉴") {
            @Override
            public boolean isFolder(Map<String, Object> map) {
                return "P".equals(map.get("menuType"));
            }
        });

        model.addAttribute("menuList", menuList);
        model.addAttribute("menuJson", menuJson);

        return "system/menuMgnt";
    }

    @RequestMapping(value = "/saveMenuList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
    public @ResponseBody Map<String , Object> saveMenuList(
            @ModelAttribute("sessionUserVo")    SessionUserVo   sessionUserVo,
            @RequestParam(value = "menuId",         required = false)   List<String>    menuIdList,
            @RequestParam(value = "menuNm",         required = false)   List<String>    menuNmList,
            @RequestParam(value = "menuEngNm",      required = false)   List<String>    menuEngNmList,
            @RequestParam(value = "menuType",       required = false)   List<String>    menuTypeList,
            @RequestParam(value = "url",            required = false)   List<String>    urlList,
            @RequestParam(value = "indexHier",      required = false)   List<String>    indexHierList,
            @RequestParam(value = "useYn",          required = false)   List<String>    useYnList,
            @RequestParam(value = "deleteMenuIds",  required = false)   String          deleteMenuIds
    ) {
        LOGGER.info("saveMenuList\nmenuIdList:{}\nmenuNmList:{}\nmenuEngNmList:{}\nmenuTypeList:{}\nurlList:{}\nindexHierList:{}\nuseYnList:{}\ndeleteMenuIds:{}",
                new Object[]{menuIdList, menuNmList, menuEngNmList, menuTypeList, urlList, indexHierList, useYnList, deleteMenuIds});

        try {
            String now = TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff());
            String companyCd = sessionUserVo.getSessionCompanyCd();
            String userId = sessionUserVo.getSessionUserId();

            HashMap<String, Object> insertMap = new HashMap<>();
            List<Map<String, String>> insertList = new ArrayList<>();
            insertMap.put("companyCd",  companyCd);
            insertMap.put("regiId",     userId);
            insertMap.put("finalModId", userId);
            insertMap.put("now",        now);
            insertMap.put("list",       insertList);

            HashMap<String, Object> updateMap = new HashMap<>();
            List<Map<String, String>> updateList = new ArrayList<>();
            updateMap.put("companyCd",  companyCd);
            updateMap.put("finalModId", userId);
            updateMap.put("now",        now);
            updateMap.put("list",       updateList);

            if (menuIdList != null) {
                for (int i = 0, size = menuIdList.size(); i < size; i++) {
                    String menuId = menuIdList.get(i);

                    Map<String, String> map = new HashMap<>();
                    map.put("menuNm",       menuNmList.get(i));
                    map.put("menuEngNm",    menuEngNmList.get(i));
                    map.put("menuType",     menuTypeList.get(i));
                    map.put("url",          urlList.get(i));
                    map.put("indexHier",    indexHierList.get(i));
                    map.put("useYn",        useYnList.get(i));

                    if (menuId.startsWith("N")) {
                        insertList.add(map);
                    } else {
                        map.put("menuId",   menuId);
                        updateList.add(map);
                    }
                }
            }

            LOGGER.debug("insertMap\n{}\nupdateMap\n{}", insertMap, updateMap);

            HashMap<String, Object> deleteMap = new HashMap<>();
            deleteMap.put("companyCd",  companyCd);
            deleteMap.put("list",       (deleteMenuIds != null && deleteMenuIds.trim().length() > 0) ? Arrays.asList(deleteMenuIds.split(",")) : null);

            svc.saveMenuBatch(insertMap, updateMap, deleteMap);

            Map<String, Object> jsonObject = new HashMap<>();
            jsonObject.put("success", true);

            return jsonObject;
        } catch(Exception e) {
            LOGGER.error(e.getMessage());
            e.printStackTrace();

            Map<String, Object> jsonObject = new HashMap<>();
            jsonObject.put("success", false);
            jsonObject.put("errMsg", e.getMessage());

            return jsonObject;
        }
    }
}
