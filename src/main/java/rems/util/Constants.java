package rems.util;

/**
 * 상수 선언
 * 
 * @author 임황균
 * @since 2012. 9. 24.
 */
public interface Constants
{
	/**
	 * 페이지 번호
	 */
	public static final String PARAM_PAGE_OFFSET = "pagerOffset";

	/**
	 * HttpServeltReqeust에서 attribute를 사용할 경우 반드시 추가
	 */
	public static final String REQUEST_ATTRIBUTE_PREFIX = "@@@custom@@@";

	/**
	 * 페이지당 표시 개수
	 */
	public static final String PARAM_PAGE_PER_NUMBER = "pagePerNumber";

	/**
	 * 결과 화면으로 전달되는 메세지 명
	 */
	public static final String RESULT_MESSAGE = "resultMessage";

	/**
	 * 결과 화면으로 전달되는 파라미터 명
	 */
	public static final String RESULT_PARAM_NAME = "parameters";

	/**
	 * 결과 화면으로 전달되는 전체 조회 결과 수
	 */
	public static final String RESULT_TOTAL_COUNT = "totalCount";
	
	/**
	 * 조회수 by lsh
	 */
	public static final String HITS_COUNT = "count";
	
	public static final String ENCRYPT_KEY = "REMS_ADM";
}