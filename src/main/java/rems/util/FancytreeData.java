package rems.util;

import java.util.List;
import java.util.Map;

public abstract class FancytreeData extends TreeData {
    //Constructor
    public FancytreeData(List<Map<String, Object>> mapList, String codeAttr, String nameAttr, String pathAttr) {
        this(mapList, codeAttr, nameAttr, pathAttr, null, null);
    }

    public FancytreeData(List<Map<String, Object>> mapList, String codeAttr, String nameAttr, String pathAttr, String defaultName) {
        this(mapList, codeAttr, nameAttr, pathAttr, defaultName, null);
    }

    public FancytreeData(List<Map<String, Object>> mapList, String codeAttr, String nameAttr, String pathAttr, Map<String, String> optionAttrMap) {
        this(mapList, codeAttr, nameAttr, pathAttr, null, optionAttrMap);
    }

    public FancytreeData(List<Map<String, Object>> mapList, String codeAttr, String nameAttr, String pathAttr, String defaultName, Map<String, String> optionAttrMap) {
        super(mapList, codeAttr, nameAttr, pathAttr, defaultName, optionAttrMap);
    }

    //Abstract Implementing Method
    public String getCodeText() {
        return "key";
    }

    public String getNameText() {
        return "title";
    }
}
