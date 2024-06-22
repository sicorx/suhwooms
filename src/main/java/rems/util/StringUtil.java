package rems.util;

import org.apache.commons.lang.StringUtils;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.util
 * @Class Name : StringUtil.java
 * @Description : String 관련 Util
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 3. 9.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 3. 9. 오후 1:04:24
 * @version 2.0
 * 
 */
public class StringUtil {

	/**
	 * String Null 처리
	 * 
	 * @author 유승만
	 * @param str : 원문
	 * @return String
	 * @exception Exception
	 */
	public static String ConvertNull(String str) {
		String retVal = "";
		
		if (StringUtils.isEmpty(str) == true) {
			retVal = "";
		} else {
			if (("".equals(str.trim())) || ("null".equals(str.trim()))) {
				retVal = "";
			} else {
				retVal = str;
			}	
		}
		
		return retVal;
	}

}
