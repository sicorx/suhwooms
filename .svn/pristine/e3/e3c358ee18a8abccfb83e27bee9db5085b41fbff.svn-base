package rems.util.excel;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ExcelRead{
    
	
	private static final Logger LOGGER = LoggerFactory.getLogger( ExcelRead.class );
	
	public static List<Map<String, String>> read( ReadOption readOption){
		
		Workbook wb = FileType.getWorkbook(readOption.getFilePath());
				
		
		LOGGER.info( "SheetName : " + readOption.getFilePath());
		
		Sheet sheet = null;
		
		sheet = wb.getSheetAt(0);
		for(int i=0; i<wb.getNumberOfSheets(); i++)
		{
			LOGGER.info( i + " SheetName : " + wb.getSheetName(i));
			
			if( readOption.getFilePath().toUpperCase().startsWith("C:\\TNM\\TNM") )
			{
				if( wb.getSheetName(i).toLowerCase().startsWith("tnm") )
					sheet = wb.getSheetAt(i);				
			}
			else
			{
				sheet = wb.getSheetAt(0);
			}
		}
		
		
		
		sheet = wb.getSheetAt(0);
		
		int numOfRows = sheet.getPhysicalNumberOfRows();
		int numOfCells = 0;
		
		
		
		LOGGER.info( "numOfRows : " + numOfRows );
		
		Row row = null;
		Cell cell = null;
		
		String cellName = "";
		
		Map<String, String> map = null;
		
		List<Map<String, String>> result = new ArrayList<Map<String, String>>();
		
		
		FormulaEvaluator formulaEval = wb.getCreationHelper().createFormulaEvaluator();
		
		
		
		
		for(int rowIndex = readOption.getStartRow() -1; rowIndex < numOfRows; rowIndex++)
		{
			row = sheet.getRow(rowIndex);
			
			if( row != null )
			{
				numOfCells = row.getPhysicalNumberOfCells();
				map = new HashMap<String, String>();
				
				for(int cellIndex = 0;cellIndex < numOfCells; cellIndex++)
				{
					cell = row.getCell(cellIndex);
					cellName = CellRef.getName(cell,  cellIndex);
					
					if( !readOption.getOutputColumns().contains(cellName) )
					{
						continue;
					}
					
					
					CellValue evaluate = formulaEval.evaluate( cell );
					map.put(cellName, CellRef.getValue2(evaluate));
					
					//map.put(cellName, CellRef.getValue(cell));
					//LOGGER.info("셀내용 : [" + cellName + "] " + CellRef.getValue(cell));
					
					//LOGGER.info("셀내용 : [" + cellName + "] " + CellRef.getValue2(evaluate));
					
					
					
					
				}
				
				result.add(map);
			
			}
		}
				
		
		
		
		return result;
				
		
	}
	
	
	
	// 추천계약전력 excel 파일 읽기
	public static List<Map<String, String>> demandPowerExcelRead( ReadOption readOption){
		
		Workbook wb = FileType.getWorkbook(readOption.getFilePath());
		
		LOGGER.info( "SheetName : " + readOption.getFilePath());
		
		Sheet sheet = null;		
		
		for(int i=0; i<wb.getNumberOfSheets(); i++)
		{
			LOGGER.info( i + " SheetName : " + wb.getSheetName(i));
			
			if( wb.getSheetName(i).toLowerCase().startsWith("tnm") )
			{
				sheet = wb.getSheetAt(i);
				break;
			}
			else
			{
				sheet = wb.getSheetAt(0);
			}
		}
		
		int numOfRows = sheet.getPhysicalNumberOfRows();
		int numOfCells = 0;
		
		
		
		LOGGER.info( "numOfRows : " + numOfRows );
		
		Row row = null;
		Cell cell = null;
		
		String cellName = "";
		
		Map<String, String> map = null;
		
		List<Map<String, String>> result = new ArrayList<Map<String, String>>();
		
		
		FormulaEvaluator formulaEval = wb.getCreationHelper().createFormulaEvaluator();
		
		
		
		
		for(int rowIndex = readOption.getStartRow() -1; rowIndex < numOfRows; rowIndex++)
		{
			row = sheet.getRow(rowIndex);
			
			if( row != null )
			{
				numOfCells = row.getPhysicalNumberOfCells();
				map = new HashMap<String, String>();
				
				for(int cellIndex = 0;cellIndex < numOfCells; cellIndex++)
				{
					cell = row.getCell(cellIndex);
					cellName = CellRef.getName(cell,  cellIndex);
					
					if( !readOption.getOutputColumns().contains(cellName) )
					{
						continue;
					}
					
					
					CellValue evaluate = formulaEval.evaluate( cell );
					map.put(cellName, CellRef.getValue2(evaluate));
					
					//map.put(cellName, CellRef.getValue(cell));
					//LOGGER.info("셀내용 : [" + cellName + "] " + CellRef.getValue(cell));
					
					//LOGGER.info("셀내용 : [" + cellName + "] " + CellRef.getValue2(evaluate));
					
					
					
					
				}
				
				result.add(map);
			
			}
		}
				
		
		
		
		return result;
				
		
	}
	
	
	
	
	
	
	
	
	
	public static void setDemandPower( ReadOption readOption, int setRowNum, String recommendDemandPower){
		
		Workbook wb = FileType.getWorkbook(readOption.getFilePath());
		
		LOGGER.info( "SheetName : " + readOption.getFilePath());
		LOGGER.info( "setRowNum : " + setRowNum);
		
		Sheet sheet = null;
		
		
		for(int i=0; i<wb.getNumberOfSheets(); i++)
		{
			LOGGER.info( i + " SheetName : " + wb.getSheetName(i));
			
			if( wb.getSheetName(i).toLowerCase().startsWith("tnm") )
			{
				sheet = wb.getSheetAt(i);
				break;
			}
			else
			{
				sheet = wb.getSheetAt(0);
			}
		}		
		
		int numOfRows = sheet.getPhysicalNumberOfRows();
		int numOfCells = 0;
			
		
		
		LOGGER.info( "numOfRows : " + numOfRows );
		
		Row row = null;
		Cell cell = null;
		
		row = sheet.createRow( setRowNum );		
		
		cell = row.createCell(5);
		cell.setCellValue("TnM 추천");		
		cell = row.createCell(6);
		cell.setCellValue( recommendDemandPower );
		
		
		
        try {
        	File xlsFile = new File( readOption.getFilePath() );
            FileOutputStream fileOut = new FileOutputStream(xlsFile);
			wb.write(fileOut);
			fileOut.close();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
				
		
	}



	
	

}