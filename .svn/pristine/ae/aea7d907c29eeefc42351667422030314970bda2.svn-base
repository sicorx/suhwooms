package rems.system.ctrl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import rems.system.model.SessionUserVo;
import rems.system.service.MenuAuthMgntSvc;
import rems.util.TimezoneUtils;
import rems.util.FancytreeData;
import rems.util.TreeUtil;

import java.util.*;


@Controller
@SessionAttributes("sessionUserVo")
public class MenuAuthMgntCtrl {

    private static final Logger LOGGER = LoggerFactory.getLogger(MenuAuthMgntCtrl.class);

    @Autowired
    private MenuAuthMgntSvc svc;

    @RequestMapping(value = "/4405", method = {RequestMethod.GET, RequestMethod.POST})
    public String showMenuAuthMgnt(
            @ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
            ModelMap model) {

        LOGGER.info("showMenuAuthMgnt : ");

        HashMap<String, String> params = new HashMap<>();
        params.put("companyCd", sessionUserVo.getSessionCompanyCd());

        List<Map<String, Object>> authList = svc.retrieveAuthList(params);
        String authJson = TreeUtil.makeJson(new FancytreeData(authList, "authId", "authNm", "seq") {
            @Override
            public boolean isFolder(Map<String, Object> map) {
                return "CODE".equals(map.get("type"));
            }
        });

        model.addAttribute("authList", authList);
        model.addAttribute("authJson", authJson);

        return "system/menuAuthMgnt";
    }

    @RequestMapping(value = "/retrieveMenuAuthList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
    public @ResponseBody Map<String , Object> retrieveMenuAuthList(
            @ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
            @RequestParam(value = "authId", required = false) String authId) {

        LOGGER.info("retrieveMenuAuthList::authId:{}", authId);

        HashMap<String, String> params = new HashMap<>();
        params.put("companyCd", sessionUserVo.getSessionCompanyCd());
        params.put("locale", LocaleContextHolder.getLocale().getLanguage());
        params.put("authId", authId);

        List<Map<String, Object>> menuAuthList = svc.retrieveMenuAuthList(params);

        Map<String, String> optionAttrMap = new LinkedHashMap<>();
        optionAttrMap.put("selected", "selected");

        String json = TreeUtil.makeJson(new FancytreeData(menuAuthList, "menuId", "menuNm", "indexHier", optionAttrMap) {
            @Override
            public boolean isFolder(Map<String, Object> map) {
                return "P".equals(map.get("menuType"));
            }
        });

        Map<String, Object> jsonObject = new HashMap<>();
        jsonObject.put("success", true);
        jsonObject.put("json", json);

        return jsonObject;
    }

    @RequestMapping(value = "/saveAuthList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
    public @ResponseBody Map<String , Object> saveAuthList(
            @ModelAttribute("sessionUserVo")    SessionUserVo   sessionUserVo,
            @RequestParam(value = "authId",         required = false)   List<String>    authIdList,
            @RequestParam(value = "authSp",         required = false)   List<String>    authSpList,
            @RequestParam(value = "authNm",         required = false)   List<String>    authNmList,
            @RequestParam(value = "authDesc",       required = false)   List<String>    authDescList,
            @RequestParam(value = "orderSeq",       required = false)   List<String>    orderSeqList,
            @RequestParam(value = "useYn",          required = false)   List<String>    useYnList,
            @RequestParam(value = "deleteAuthCds",  required = false)   String          deleteAuthCds
    ) {
        LOGGER.info("saveAuthList\nauthIdList:{}\nauthSpList:{}\nauthNmList:{}\nauthDescList:{}\norderSeqList:{}\nuseYnList:{}\ndeleteAuthCds:{}",
                new Object[]{authIdList, authSpList, authNmList, authDescList, orderSeqList, useYnList, deleteAuthCds});

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

            if (authIdList != null) {
                for (int i = 0, size = authIdList.size(); i < size; i++) {
                    String authId = authIdList.get(i);

                    Map<String, String> map = new HashMap<>();
                    map.put("authSp",       authSpList.get(i));
                    map.put("authNm",       authNmList.get(i));
                    map.put("authDesc",     authDescList.get(i));
                    map.put("orderSeq",     orderSeqList.get(i));
                    map.put("useYn",        useYnList.get(i));

                    if (authId.startsWith("N")) {
                        insertList.add(map);
                    } else {
                        map.put("authId",   authId);
                        updateList.add(map);
                    }
                }
            }

            LOGGER.debug("insertMap\n{}\nupdateMap\n{}", new Object[] {insertMap, updateMap});

            HashMap<String, Object> deleteMap = new HashMap<>();
            List<String> deleteList = new ArrayList<>();
            deleteMap.put("companyCd",  companyCd);
            deleteMap.put("list",       deleteList);

            if (deleteAuthCds != null && deleteAuthCds.trim().length() > 0) {
                deleteList = Arrays.asList(deleteAuthCds.split(","));
                deleteMap.put("list",   deleteList);
            }

            svc.saveAuthBatch(insertMap, updateMap, deleteMap);

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

    @RequestMapping(value = "/saveMenuAuthList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
    public @ResponseBody Map<String , Object> saveMenuAuthList(
            @ModelAttribute("sessionUserVo")    SessionUserVo   sessionUserVo,
            @RequestParam(value = "menuId",     required = false)   List<String>    menuIdList,
            @RequestParam(value = "selected",   required = false)   List<String>    selectedList,
            @RequestParam(value = "authId",     required = false)   String          authId
    ) {
        LOGGER.info("saveAuthList\nmenuIdList:{}\nselectedList:{}\nauthId:{}", new Object[]{menuIdList, selectedList, authId});

        try {
            String now = TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff());
            String companyCd = sessionUserVo.getSessionCompanyCd();
            String userId = sessionUserVo.getSessionUserId();

            HashMap<String, Object> insertMap = new HashMap<>();
            List<String> insertList = new ArrayList<>();
            insertMap.put("companyCd",  companyCd);
            insertMap.put("authId",     authId);
            insertMap.put("regiId",     userId);
            insertMap.put("now",        now);
            insertMap.put("list",       insertList);

            HashMap<String, Object> deleteMap = new HashMap<>();
            List<String> deleteList = new ArrayList<>();
            deleteMap.put("companyCd",  companyCd);
            deleteMap.put("authId",     authId);
            deleteMap.put("list",       deleteList);

            if (menuIdList != null) {
                for (int i = 0, size = menuIdList.size(); i < size; i++) {
                    String menuId = menuIdList.get(i);

                    if ("true".equals(selectedList.get(i))) {
                        insertList.add(menuId);
                    } else {
                        deleteList.add(menuId);
                    }
                }

                LOGGER.debug("\ninsertMap\n{}\ndeleteMap\n{}", new Object[] {insertMap, deleteMap});

                svc.saveMenuAuthBatch(insertMap, deleteMap);
            }

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
