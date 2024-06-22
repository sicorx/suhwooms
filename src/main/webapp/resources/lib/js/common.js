/**
 * 스크립트 공용 함수
 * global function => 함수명앞에 gfc를 붙인다
 * ex)gfnDateAdd()...
 */

/**
 * 함수명 : gfcReplaceAll
 * 설명 : 특정문자 전체변경
 * 
 * @author 유승만
 * @param str : 원문
 * @param searchStr : 찾을 문자
 * @param replaceStr : 변경할 문자
 * @return 변경할 문자가 모두 변경되서 리턴
 */
function gfcReplaceAll(str, searchStr, replaceStr) {
	while (str.indexOf(searchStr) != -1) {
		str = str.replace(searchStr, replaceStr);
	}
	return str;
}

/**
 *  함수명 : gfnDateAdd
 *  설명 : 날짜 연산
 *       : ex) 2017-01-02에 3달을 더한다
 *       :     gfnDateAdd('2017-01-02', 'M', 3, '-')
 *       :     결과 2017-04-02
 *  
 * @author 유승만
 * @param str : 날짜
 * @param dateType : 년, 월, 일(Y, M, D)
 * @param add : 연산할 년, 월, 일
 * @param sep : 날짜구분자 (-, /, 없으면 빈값)
 * @return : 연산된 날짜 
 */
function gfnDateAdd(str, dateType, add, sep) {
	str = gfcReplaceAll(str, sep, "");
	
	var year = Number(str.substr(0, 4));
    var month = Number(str.substr(4, 2)) - 1;		// 월은 1빼줌
    var day = Number(str.substr(6, 2));
    
    switch (dateType) {
	    case "Y":
	    	year = year + Number(add);
	        break;
	    case "M":
	    	month = month + Number(add);
	        break;
	    case "D":
	    	day = day + Number(add);
	        break;
	    default:
    }
    
    var retDate = new Date(year, month, day);
	var yy = retDate.getFullYear();
	var mm = retDate.getMonth() + 1;				// 다시 1더함
	if (mm < 10) mm = "0" + mm;
	var dd = retDate.getDate();
	if (dd < 10) dd = "0" + dd;
	
	return yy + sep + mm + sep + dd;
}


//현재 시간
/**
 *  함수명 : gfnTodayDate
 *  설명 : 오늘 날짜를 구해온다
 *  
 * @author gfnTodayDate
* @param sep : 날짜구분자 (-, /, 없으면 빈값)
 * @return : 오늘 날짜 
 */
function gfnTodayDate(sep)
{
    var YYYY, MM, DD;	    
    var d = new Date();	
    
    YYYY = d.getFullYear();	        
    //한자릿수 월 앞에 0을 붙이기    
    MM = (d.getMonth()+1)>9 ? ''+(d.getMonth()+1) : '0'+(d.getMonth()+1);
   	DD = d.getDate()>9 ? ''+d.getDate() : '0'+d.getDate();   	
    
    return YYYY + sep + MM + sep + DD;    
}


/**
 *  함수명 : gfnGetWeekDay
 *  설명 : 요일을 구해온다
 *  
 * @author gfnGetWeekDay
 * @param idx : getDay() 값
 * @return : 오늘 요일 
 */
function gfnGetWeekDay(idx) 
{
	var date = "";
	switch (idx) 
	{
		case 0:
			date = "일요일";			
			break;
		case 1: 
			date = "월요일";
			break;
		case 2: 
			date = "화요일";
			break;
		case 3:
			date = "수요일";
			break;
		case 4: 
			date = "목요일";
			break;
		case 5: 
			date = "금요일";
			break;
		case 6: 
			date = "토요일";
			break;
	}	
	return date;
}


/**
 *  함수명 : numberWithCommas
 *  설명 : 천의자리마다 콤마 찍기
 *  
 * @author numberWithCommas
 * @param x : 숫자( 콤마 미포함 )
 * @return : 숫자( 콤마포함 )
 */
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

/**
 *  함수명 : numberWithZero
 *  설명 : 두자리수로 만들기
 *  
 * @author numberWithZero
 * @param x : 숫자
 * @return : 숫자( 두자리수 )
 */
function numberWithZero(x) {
	if( x < 10 )
		return '0'+x;
	else
		return x;
}

