package rems.util;

import java.util.HashMap;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ExcelWriter{
    public final static int CELL_TYPE_NUMERIC = 0;

    public final static int CELL_TYPE_STRING = 1;

    public final static int CELL_TYPE_FORMULA = 2;

    public final static int CELL_TYPE_BLANK = 3;

    public final static int CELL_TYPE_BOOLEAN = 4;

    public final static int CELL_TYPE_ERROR = 5;
    
    private static final Logger LOGGER = LoggerFactory.getLogger(ExcelWriter.class);
	
	public static HSSFWorkbook makeExeclData(HSSFWorkbook wb, String sheetNm, String arrColNm[], String arrDbColNm[],String alignType[], List<HashMap> dataList) {
		HSSFRow row = null;
		HSSFCell cell = null;
		//엑셀 스타일
		//타이틀 회색 배경
		HSSFCellStyle styleLabel = wb.createCellStyle();
		
		styleLabel.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		styleLabel.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		styleLabel.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		styleLabel.setBottomBorderColor(HSSFColor.BLACK.index);
		styleLabel.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		styleLabel.setLeftBorderColor(HSSFColor.BLACK.index);
		styleLabel.setBorderRight(HSSFCellStyle.BORDER_THIN);
		styleLabel.setRightBorderColor(HSSFColor.BLACK.index);
		styleLabel.setBorderTop(HSSFCellStyle.BORDER_THIN);
		styleLabel.setTopBorderColor(HSSFColor.BLACK.index);
		styleLabel.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	
		//데이터 (중앙정렬)흰색배경
		HSSFCellStyle styleconts1 = wb.createCellStyle();
		styleconts1.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		styleconts1.setBottomBorderColor(HSSFColor.BLACK.index);
		styleconts1.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		styleconts1.setLeftBorderColor(HSSFColor.BLACK.index);
		styleconts1.setBorderRight(HSSFCellStyle.BORDER_THIN);
		styleconts1.setRightBorderColor(HSSFColor.BLACK.index);
		styleconts1.setBorderTop(HSSFCellStyle.BORDER_THIN);
		styleconts1.setTopBorderColor(HSSFColor.BLACK.index);
		styleconts1.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		
		//데이터 (오른쪽 정렬)흰색배경
		HSSFCellStyle styleconts2 = wb.createCellStyle();
		styleconts2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		styleconts2.setBottomBorderColor(HSSFColor.BLACK.index);
		styleconts2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		styleconts2.setLeftBorderColor(HSSFColor.BLACK.index);
		styleconts2.setBorderRight(HSSFCellStyle.BORDER_THIN);
		styleconts2.setRightBorderColor(HSSFColor.BLACK.index);
		styleconts2.setBorderTop(HSSFCellStyle.BORDER_THIN);
		styleconts2.setTopBorderColor(HSSFColor.BLACK.index);
		styleconts2.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		
		HSSFSheet sheet = wb.createSheet();											//시트생성
		int sheetNum = wb.getNumberOfSheets();										//시트 갯수 세기
		wb.setSheetName(sheetNum-1, sheetNm);										//시트명 세팅
		
		//컬럼 width 조절		
		for( int i = 0 ;i < arrColNm.length; i++){
			sheet.setColumnWidth( (int) i, (int) ( 256*20 ) );
		}
		row  = sheet.createRow((short) 0 );
		//컬럼 타이틀 작성		
		for( int i = 0 ;i < arrColNm.length; i++){
			
			cell = row.createCell(i, CELL_TYPE_STRING);
			cell.setCellValue(arrColNm[i]);	
			cell.setCellStyle(styleLabel);
		}
		
		try{
			for(int i = 0; i < dataList.size(); i++){
				row  = sheet.createRow((short) (i+1) );	//0번째 row는 컬럼타이틀이기 때문에 +1	
				
				for( int j = 0 ;j < arrDbColNm.length; j++){
					
					//j번째 컬럼 
					cell = row.createCell(j, CELL_TYPE_STRING);
					
					//System.out.println("1234 :" + (String)((HashMap) dataList.get(i)).get(arrDbColNm[j]));
					 
					String value = String.valueOf(dataList.get(i).get(arrDbColNm[j]));
					
					if("null".equalsIgnoreCase(value)){
						value = "";
					}

					cell.setCellValue( value );
					
					if(alignType[j].equals("center")){
						cell.setCellStyle(styleconts1);
					}else{
						cell.setCellStyle(styleconts2);
					}
				}
			}
		}catch(Exception e){
			LOGGER.error(e.toString());
		}
		return wb;
	}	
	
}