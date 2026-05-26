package egovframework.wzwg.cmm.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Component;

/**
 * 압축 관련 유틸 클래스
 * @author 조원권
 * @since WIZ-BUILDER 3.5.1 (2018.10.24)
 *
 */
@Component
public class ZipUtil {
	
	/**
	 * 
	 * @param fileName 압축파일 이름
	 * @param FileList 압축할 파일목록
	 * @param zipPath 압축파일 저장경로
	 * @param srcDirPath FileList에 들어있는 파일경로중 삭제해야되는 앞부분 경로
	 * @return
	 */
	public File zipCompress(String fileName, List<File> FileList, String zipPath, String srcDirPath){
		File zipFile = null;
		//String currYear = DateUtils.getCurrentDate("yyyy");
		//String currMonth = DateUtils.getCurrentDate("MM");
		//String currDay = DateUtils.getCurrentDate("dd");
		//String currHour = DateUtils.getCurrentDate("HH");
		//String currMinute = DateUtils.getCurrentDate("mm");
		//String currSec = DateUtils.getCurrentDate("ss");
		//String addDateStr = currYear + currMonth + currDay + "_" + currHour + currMinute + currSec;
		
		//String backupPath = realPath + templatePath + "backup/zip/";
		//String zipFileName = fileName + "_" + addDateStr + ".zip";
		File zipDir = new File(zipPath);
		
		if(zipDir.exists() == false) zipDir.mkdirs();
		
		ZipOutputStream out = null;
		
		try {
			/* 압축파일 준비 */
			zipFile = new File(zipPath + fileName);
			
			out = new ZipOutputStream(new FileOutputStream(zipFile));
			out.setLevel(6);
			String pathPrefix = FilenameUtils.separatorsToSystem(srcDirPath);
			for (File file : FileList) {
				String fileFullName = FilenameUtils.separatorsToSystem(file.getAbsolutePath()) ;

				out.putNextEntry(new ZipEntry(fileFullName.replace(pathPrefix, ""))); // Zip 파일에 경로를 정하여 저장할수 있다.
				
				FileInputStream in = new FileInputStream(file);
				byte[] buf = new byte[1024];
				
				int len;
				while ((len = in.read(buf)) > 0) {
					out.write(buf, 0, len);
				}
				
				in.close();
				in = null;
				
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				out.closeEntry();
				out.close();	
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return zipFile;
	}
	
	
	
	/**
     * 압축풀기 메소드
     * @param zipFileName 압축파일
     * @param directory 압축 풀 폴더
     * 출처: http://nowonbun.tistory.com/321 [명월 일지]
     */
    public void decompress(String zipFileName, String directory) throws Throwable {
    	decompress(new File(zipFileName), directory);
    }
	
	
	/**
     * 압축풀기 메소드
     * @param zipFileName 압축파일
     * @param directory 압축 풀 폴더
     * 출처: http://nowonbun.tistory.com/321 [명월 일지]
     */
    public void decompress(File zipFile, String directory) throws Throwable {
        //File zipFile = new File(zipFileName);
        FileInputStream fis = null;
        ZipInputStream zis = null;
        ZipEntry zipentry = null;
        try {
            //파일 스트림
            fis = new FileInputStream(zipFile);
            //Zip 파일 스트림
            zis = new ZipInputStream(fis);
            //entry가 없을때까지 뽑기
            while ((zipentry = zis.getNextEntry()) != null) {
                String filename = zipentry.getName();
                File file = new File(directory, filename);
                //entiry가 폴더면 폴더 생성
                if (zipentry.isDirectory()) {
                    file.mkdirs();
                } else {
                    //파일이면 파일 만들기
                    createFile(file, zis);
                }
            }
        } catch (Throwable e) {
            throw e;
        } finally {
            if (zis != null)
                zis.close();
            if (fis != null)
                fis.close();
        }
    }
    /**
     * 파일 만들기 메소드
     * @param file 파일
     * @param zis Zip스트림
     */
    private void createFile(File file, ZipInputStream zis) throws Throwable {
        //디렉토리 확인
        File parentDir = new File(file.getParent());
        //디렉토리가 없으면 생성하자
        if (!parentDir.exists()) {
            parentDir.mkdirs();
        }
        //파일 스트림 선언
        try (FileOutputStream fos = new FileOutputStream(file)) {
            byte[] buffer = new byte[256];
            int size = 0;
            //Zip스트림으로부터 byte뽑아내기
            while ((size = zis.read(buffer)) > 0) {
                //byte로 파일 만들기
                fos.write(buffer, 0, size);
            }
        } catch (Throwable e) {
            throw e;
        }
    }


}
