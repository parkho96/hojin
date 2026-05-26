package egovframework.wzwg.cmm.util.excel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

public class ExcelRead {

    public static List<Map<String, String>> read(ExcelReadOption excelReadOption) {
        
        Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath(), excelReadOption.getFileExtsn());
        
        Sheet sheet = wb.getSheetAt(0);
        
        int numOfRows = sheet.getPhysicalNumberOfRows();
        
        int numOfCells = 0;
        
        Row row = null;
        Cell cell = null;
        
        String cellName = "";
        
        Map<String, String> map = null;
        
        List<Map<String, String>> result = new ArrayList<Map<String, String>>(); 
        
        for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
            
            row = sheet.getRow(rowIndex);
            
            if(row != null) {
                
                numOfCells = row.getLastCellNum();
                
                map = new HashMap<String, String>();
                
                for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
                    
                    cell = row.getCell(cellIndex);
                    
                    cellName = ExcelCellRef.getName(cell, cellIndex);
                    
                    map.put(cellName, ExcelCellRef.getValue(cell));
                }
                
                result.add(map);
            }
        }
        
        return result;
    }

}
