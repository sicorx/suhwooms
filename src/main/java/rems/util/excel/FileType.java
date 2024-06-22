package rems.util.excel;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import rems.system.service.ExcelUtilImpl;

public class FileType{
    
	private static final Logger LOGGER = LoggerFactory.getLogger( FileType.class );
	
	public static Workbook getWorkbook(String filePath )
	{
		FileInputStream fis = null;
		
		try{
			
			fis = new FileInputStream( filePath );
		}catch( FileNotFoundException e){
			throw new RuntimeException(e.getMessage() + e);
		}
				
		
		Workbook wb = null;
		
		if( filePath.toUpperCase().endsWith(".XLS")) 
		{
			try{
				wb = new HSSFWorkbook(fis);
				//wb = new XSSFWorkbook(fis);
			}catch(IOException e){
				throw new RuntimeException(e.getMessage() + e);
			}			
			
			LOGGER.info( wb.getNumberOfSheets() + "-" + wb.getNumberOfNames() + "" );
		}
		else if( filePath.toUpperCase().endsWith(".XLSX"))
		{
			try{
				wb = new XSSFWorkbook(fis);
			}catch(IOException e){
				throw new RuntimeException(e.getMessage() + e);
			}
			
			LOGGER.info( wb.getNumberOfSheets() + "/" + wb.getNumberOfNames() + "" );
			
		}
		
		return wb;
		
	}
	

}