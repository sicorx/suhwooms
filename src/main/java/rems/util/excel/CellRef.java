package rems.util.excel;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.util.CellReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CellRef{
	
	private static final Logger LOGGER = LoggerFactory.getLogger( CellRef.class );
    
	public static String getName(Cell cell, int cellIndex){
		int cellNum = 0;
		if(cell != null )
		{
			cellNum = cell.getColumnIndex();
		}
		else
		{
			cellNum = cellIndex;
		}
		
		return CellReference.convertNumToColString(cellNum);
	}
	
	
	public static String getValue(Cell cell)
	{
		//Workbook wb = null;
		
				
		String value = "";
		
		if(cell == null )
		{
			value = "";
		}
		else
		{
			
			
			if( cell.getCellType() == Cell.CELL_TYPE_FORMULA )		// 수식
			{	
				value = cell.getCellFormula();				
				
			}
			else
			{
				if( cell.getCellType() == Cell.CELL_TYPE_NUMERIC )
				{
					
					
					if( DateUtil.isCellDateFormatted(cell)) 
					{

						Date date = cell.getDateCellValue();
						value = new SimpleDateFormat("yyyyMMdd").format(date);
					}
					else
					{					
						value = String.valueOf((int)cell.getNumericCellValue());
					}
					
				}
				else if( cell.getCellType() == Cell.CELL_TYPE_STRING )
				{
					value = cell.getStringCellValue();					
				}
				else if( cell.getCellType() == Cell.CELL_TYPE_BOOLEAN )
				{
					value = cell.getBooleanCellValue() + "";
				}
				else if( cell.getCellType() == Cell.CELL_TYPE_ERROR )
				{
					value = cell.getErrorCellValue() + "";
				}
				else if( cell.getCellType() == Cell.CELL_TYPE_BLANK )
				{
					value = "";
				}
				else
				{
					value = cell.getStringCellValue();
				}
			}
			
			
		}
		return value;
		
		
		
	}
	
	
	public static String getValue2(CellValue cell)
	{
		//Workbook wb = null;
		
				
		String value = "";
		
		if(cell == null )
		{
			value = "";
		}
		else
		{
			
			//value = cell.formatAsString();
			//value = cell.getStringValue();
			
			if( cell.getCellType() == Cell.CELL_TYPE_STRING )
			{
				value = cell.getStringValue();					
			}
			else if( cell.getCellType() == Cell.CELL_TYPE_NUMERIC )
			{
				value = cell.getNumberValue()+"";
			}
			else
			{
				value = cell.formatAsString();
			}
			
		}
		return value;
		
		
		
	}
	


}