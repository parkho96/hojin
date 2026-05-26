package egovframework.wzwg.cmm.util;

import java.io.File;
import java.io.FilenameFilter;

import org.apache.commons.io.FilenameUtils;

public class ScreenUtilFileFilter implements FilenameFilter{

	String fileNameRule;
	String fileExtension;
	
	public ScreenUtilFileFilter(String fileNameRule, String fileExtension) {
		this.fileNameRule = fileNameRule;
		this.fileExtension = fileExtension;
	}
	
	@Override
	public boolean accept(File dir, String name) {
		
		if(isEmpty(fileNameRule)){
			if(name != null && fileExtension != null && FilenameUtils.getExtension(name) != null && FilenameUtils.getExtension(name).equals(fileExtension)){
				return true;
			}
		}else{
			if(name != null && name.indexOf(fileNameRule) > -1 && fileExtension != null && FilenameUtils.getExtension(name) != null && FilenameUtils.getExtension(name).equals(fileExtension)){
				return true;
			}
		}
		
		return false;
	}
	
	private boolean isEmpty(String src){
		if(src == null){
			return false;
		}
		
		if(src.equals("")){
			return false;
		}
		
		return true;
		
	}
	
	public String getFileNameRule() {
		return fileNameRule;
	}

	public void setFileNameRule(String fileNameRule) {
		this.fileNameRule = fileNameRule;
	}

	public String getFileExtension() {
		return fileExtension;
	}

	public void setFileExtension(String fileExtension) {
		this.fileExtension = fileExtension;
	}



	
}
