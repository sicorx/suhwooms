package rems.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class TreeUtil {
    private TreeUtil() {
    }

    /**
     * Tree에 적용할 JSON 문자열을 만든다.
     * @param data Tree JSON을 만들기 위한 데이터를 저장한 TreeData 객체
     * @return Tree에 적용할 JSON 문자열
     */
    public static String makeJson(TreeData data) {
        StringBuilder buff = data.getBuffer();

        buff.append('[');

        List<Map<String, Object>> mapList = data.getMapList();

        if (mapList == null || mapList.isEmpty()) {
            if (data.getDefaultName() != null) {
                buff.append('{').append(data.getNameText()).append(": '").append(data.getDefaultName()).append("_1'");
                if (data instanceof FancytreeData) {
                    buff.append(", folder: true");
                }
                buff.append(", ").append(data.getCodeText()).append(": 'N1', children: []}");
            }
        } else {
            List<Map<String, Object>> subList = new ArrayList<>();
            subList.add(mapList.get(0));
            String path = String.valueOf(mapList.get(0).get(data.getPathAttr()));

            for (int i = 1, size = mapList.size(); i < size; i++) {
                Map<String, Object> map = mapList.get(i);
                String mapPath = String.valueOf(map.get(data.getPathAttr()));

                if (mapPath.startsWith(path)) {
                    subList.add(map);
                } else {
                    makeJson(subList, path, data);
                    buff.append(",");
                    subList.clear();

                    subList.add(map);
                    path = mapPath;
                }
            }

            makeJson(subList, path, data);
        }

        buff.append(']');

        return buff.toString();
    }

    /**
     * groupPath 아래에 속하는 아이템을 subList로
     * Tree에 적용할 JSON 문자열을 만들어서 buffer에 추가한다.
     * @param subList 아이템의 리스트
     * @param groupPath 그룹의 path
     * @param data Tree JSON을 만들기 위한 데이터를 저장한 TreeData 객체
     * @return 하위로 적용한 개수
     */
    private static int makeJson(List<Map<String, Object>> subList, String groupPath, TreeData data) {
        StringBuilder buff = data.getBuffer();
        Map<String, String> optionAttrMap = data.getOptionAttrMap();

        int index = 0;

        if (subList != null && !subList.isEmpty()) {
            for (int size = subList.size(); index < size; index++) {
                Map<String, Object> map = subList.get(index);
                String path = String.valueOf(map.get(data.getPathAttr()));

                // 자기 부모가 아니면 나온다
                if (!path.startsWith(groupPath)) {
                    break;
                }

                if (index != 0) buff.append(",");
                buff.append('{').append(data.getNameText()).append(": '").append(map.get(data.getNameAttr()))
                    .append("', ").append(data.getCodeText()).append(": '").append(map.get(data.getCodeAttr())).append('\'');

                if (optionAttrMap != null) {
                    for (Map.Entry<String, String> entry : optionAttrMap.entrySet()) {
                        String value = String.valueOf(map.get(entry.getValue()));
                        if ((value != null) && (value.equalsIgnoreCase("true") || value.equalsIgnoreCase("false"))) {
                            if (value.equalsIgnoreCase("true")) {
                                buff.append(", ").append(entry.getKey()).append(": ").append(map.get(entry.getValue()));
                            }
                        } else {
                            buff.append(", ").append(entry.getKey()).append(": '").append(map.get(entry.getValue())).append('\'');
                        }
                    }
                }

                // 폴더라면
                if (data.isFolder(map)) {
                    if (data instanceof FancytreeData) {
                        buff.append(", folder: true");
                    }
                    buff.append(", children: [");
                    index += makeJson(subList.subList(index + 1, size), path, data);
                    buff.append("]");
                }

                buff.append('}');
            }
        }
        return index;
    }

}
