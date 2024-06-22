package rems.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

public class TimezoneUtils {

	/**
	 * 현재 시간 반환 함수
	 * WAS의 시간에 요청 점포 타임존을 적용하여 반환함
	 * @param timezone 타임존
	 * @return rslt 현재시간 
	 */
	public static String retrieveNowByTimezone(String timezone) {

		String rslt = "";
		
		long now = System.currentTimeMillis();
		
		TimeZone tz = TimeZone.getTimeZone( timezone );

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		dateFormat.setTimeZone( tz );
		
		rslt = dateFormat.format(new Date( now ) );
		
		
		return rslt;
	}
	
	
	/**
	 * 현재 시간 반환 함수
	 * WAS의 시간에서 요청 점포 시차를 더하거나 제하여 반환함
	 * @param timediff 시차
	 * @return rslt 현재시간 
	 */
	public static String retrieveNowByTimediff(String timediff) {

		String rslt = "";
		
		String diff = timediff;
		
		if( diff == null || "".equals( diff ) ) {
			diff = "0";
		}
		
		long time = System.currentTimeMillis();
		
		Date date = new Date( time );
		
		Calendar today = Calendar.getInstance();
		today.setTime( date );
		today.add( Calendar.HOUR_OF_DAY, Integer.parseInt( diff ) );
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		
		rslt = dateFormat.format( today.getTime() );
		
		return rslt;
	}

	/**
	 * 현재 시간 반환 함수
	 * WAS의 시간에서 요청 점포 시차를 더하거나 제하여 반환함
	 * @param timediff 시차
	 * @return rslt 현재시간 
	 */
	public static String retrieveNowByTimediffFormat(String timediff, String format) {

		String rslt = "";
		
		String diff = timediff;
		
		if( diff == null || "".equals( diff ) ) {
			diff = "0";
		}
		
		if( format == null || "".equals( format ) ) {
			format = "yyyyMMddHHmmss";
		}
		
		long time = System.currentTimeMillis();
		
		Date date = new Date( time );
		
		Calendar today = Calendar.getInstance();
		today.setTime( date );
		today.add( Calendar.HOUR_OF_DAY, Integer.parseInt( diff ) );
		
		SimpleDateFormat dateFormat = new SimpleDateFormat( format );
		
		rslt = dateFormat.format( today.getTime() );
		
		return rslt;
	}	
}
