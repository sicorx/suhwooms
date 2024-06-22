package rems.util;

import java.util.List;
import java.util.Map;

public abstract class TreeData {
    public StringBuilder buffer = new StringBuilder(1024 * 10);

    protected List<Map<String, Object>> mapList;

    protected String codeAttr;
    protected String nameAttr;
    protected String pathAttr;
    protected String defaultName;

    protected Map<String, String> optionAttrMap;


    //Constructor
    public TreeData(List<Map<String, Object>> mapList, String codeAttr, String nameAttr, String pathAttr, String defaultName, Map<String, String> optionAttrMap) {
        this.mapList = mapList;
        this.codeAttr = codeAttr;
        this.nameAttr = nameAttr;
        this.pathAttr = pathAttr;
        this.optionAttrMap = optionAttrMap;
        this.defaultName = defaultName;
    }


    //Accessor Method
    public StringBuilder getBuffer() {
        return buffer;
    }

    public List<Map<String, Object>> getMapList() {
        return mapList;
    }

    public String getCodeAttr() {
        return codeAttr;
    }

    public String getNameAttr() {
        return nameAttr;
    }

    public String getPathAttr() {
        return pathAttr;
    }

    public String getDefaultName() {
        return defaultName;
    }

    public Map<String, String> getOptionAttrMap() {
        return optionAttrMap;
    }


    //Abstract Method
    public abstract String getCodeText();

    public abstract String getNameText();

    public abstract boolean isFolder(Map<String, Object> map);
}
