package egovframework.com.utl.fcc.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.IllegalFormatException;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.egovframe.rte.fdl.excel.impl.EgovExcelServiceImpl;
import org.egovframe.rte.fdl.excel.util.EgovExcelUtil;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class ExcelParser {
	
	//원본 파일
	private MultipartFile file;
	
	//엑셀의 행
	private int rowSize = 0;
	
	//엑셀의 열
	private int columCount = 0;
	
	//에러코드 0:정상, 1:파일없음, 2:엑셀파일이 아님
	private int errorCode = 0;
	
	//중복체크값
	private int dupCount = 0;
	
	//실제 엑셀이 저장되는 arraylist
	private ArrayList<ArrayList<String>> excel = new ArrayList<ArrayList<String>>();
	
	public ExcelParser(MultipartFile file) throws Exception {
		this.file = file;
		parse();
	}
	
	ExcelParser(MultipartFile file, int startSheet, int startRow) throws Exception {
		this.file = file;
		parse();
	}
	
	private void parse() throws Exception {
		
		InputStream fis = null;
		String originalName = file.getOriginalFilename();
		 //파일이 있을때
        if (originalName != null && !"".equals(originalName)) {
        	//엑셀파일이 맞을때
            if (originalName.endsWith(".xls")
                    || originalName.endsWith(".xlsx")
                    || originalName.endsWith(".XLS")
                    || originalName.endsWith(".XLSX")) {
            	try {
            		fis = file.getInputStream();
            		
            		Workbook book = WorkbookFactory.create(fis);
            		
            		EgovExcelServiceImpl egovExcelServiceImpl = new EgovExcelServiceImpl();
            		
            		int start = 1;
                 	
                 	//1차 분기 XSS:HSS
                    if(book instanceof XSSFWorkbook){
                    	fis = file.getInputStream();
                    	
                    	XSSFWorkbook wb = null;
                    	wb = egovExcelServiceImpl.loadWorkbook(fis, wb);
                     	XSSFSheet sheet = wb.getSheetAt(0);
                     	
                     	long rowCnt = sheet.getPhysicalNumberOfRows();
                     	
                     	this.rowSize = (int)rowCnt;
                     	
                     	long cnt = rowCnt;
                     	
                     	for (int idx = start, i = start; idx < rowCnt; idx = i) {
                     		for (i = idx; i < rowCnt && i < (cnt + idx); i++) {
                     			XSSFRow row = sheet.getRow(i);
                             	ArrayList<String> columList = new ArrayList<String>();
                             	for(int j = row.getFirstCellNum(); j <= row.getLastCellNum(); j++){
                             		columList.add(EgovExcelUtil.getValue(row.getCell(j)));
                             	}
                             	excel.add(columList);
                     		}
                     	}
                    } else {
                    	fis = file.getInputStream();
                    	
                    	HSSFWorkbook wb = (HSSFWorkbook)egovExcelServiceImpl.loadWorkbook(fis);
                        HSSFSheet sheet = wb.getSheetAt(0);                                 

                        long rowCnt = sheet.getPhysicalNumberOfRows();
                        long cnt = rowCnt;
                    	
                        for (int idx = start, i = start; idx < rowCnt; idx = i) {
                            for (i = idx; i < rowCnt && i < (cnt + idx); i++) {
                            	
                                HSSFRow row = sheet.getRow(i);
                                ArrayList<String> columList = new ArrayList<String>();
                                for(int j=row.getFirstCellNum(); j <= row.getLastCellNum(); j++){
                             		columList.add(EgovExcelUtil.getValue(row.getCell(j)));
                             	}
                                excel.add(columList);
                            }
                        }
                    }
            	} catch(NullPointerException e){
            		log.error("NullPointerException",e);
        	   	}catch(NumberFormatException e){
        	   		log.error("NumberFormatException",e);
        	   	}catch(IllegalFormatException e){
        	   		log.error("IllegalFormatException",e);
        	   	}catch(ArrayIndexOutOfBoundsException e){
        	   		log.error("ArrayIndexOutOfBoundsException",e);
        	   	}catch(IOException e){
        	   		log.error("IOException",e);
        	   	} finally {
                    if (fis != null)    
                        fis.close();
                }
            	
            } else {
            //엑셀파일이 아닐때 에러
            	errorCode = 2;
            }
        } else {
        //파일이 없을때 에러
        	errorCode = 1;
        }
	}

	public int getRowSize() {
		return rowSize;
	}

	public int getColumCount() {
		return columCount;
	}
	
	/**
	 * 에러코드 0:정상, 1:파일없음, 2:엑셀파일이 아님 
	 */
	public int getErrorCode() {
		return errorCode;
	}

	public ArrayList<ArrayList<String>> getExcel() {
		return excel;
	}
	
	public int getDupCount() {
		return dupCount;
	}

	/**
	 *  파싱된 엑셀 정보로 해당 컬럼의 중복된 값을 arrayList로 반환한다.
	 */
	public ArrayList<String> dupCheck(int columNum){
		
		this.dupCount = 0;
		
		ArrayList<String> dupList = new ArrayList<String>();

		for (int i = 0; i < excel.size(); i++) {
			for (int j = 0; j < excel.size(); j++) {
				if(i != j) {
					
					System.out.println("excel : " + excel.get(j).get(columNum));
					
					if(excel.get(i).get(columNum).equals(excel.get(j).get(columNum))){
						dupList.add(excel.get(i).get(columNum));
						dupCount++;
					}
				}
			}
		}
		
		return dupList;
	}
}
