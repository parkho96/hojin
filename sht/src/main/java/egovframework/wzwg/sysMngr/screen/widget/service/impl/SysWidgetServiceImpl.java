package egovframework.wzwg.sysMngr.screen.widget.service.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.screen.service.SiteLayoutVO;
import egovframework.wzwg.sysMngr.screen.widget.service.SysWidgetService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("SysWidgetService")
public class SysWidgetServiceImpl extends EgovAbstractServiceImpl implements SysWidgetService{

	@Resource(name="SysWidgetDAO")
	 private SysWidgetDAO sysWidgetDAO;
	
	/**
	 * 위젯 총 개수 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectWidgetTotalCount(SiteLayoutVO paramVO) throws Exception{
		return sysWidgetDAO.selectWidgetTotalCount(paramVO);
	}
	
	/**
	 * 위젯 목록 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<SiteLayoutVO> selectWidgetList(SiteLayoutVO paramVO) throws Exception{
		return sysWidgetDAO.selectWidgetList(paramVO);
	}
	
	/**
	 * 작업중 위젯 목록 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<SiteLayoutVO> selectWorkWidgetList(SiteLayoutVO paramVO) throws Exception {
		return sysWidgetDAO.selectWorkWidgetList(paramVO);
	}
	
	/**
	 * 위젯 정보 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public SiteLayoutVO selectWidgetData(SiteLayoutVO paramVO) throws Exception{
		return sysWidgetDAO.selectWidgetData(paramVO);
	}
	

	/**
	 * 위젯 백업 정보 저장
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registWidgetWorkInfo(SiteLayoutVO paramVO) throws Exception {
		// TODO Auto-generated method stub
		String layoutcntntsworkSeq = sysWidgetDAO.selectWidgetWorkSeq(paramVO);
		paramVO.setLayoutcntntsworkSeq(layoutcntntsworkSeq);
		
		return sysWidgetDAO.registWidgetWorkInfo(paramVO);
			
	}
	
	/**
	 * 위젯 백업 정보 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public SiteLayoutVO selectWidgetWorkData(SiteLayoutVO paramVO) throws Exception {
		return sysWidgetDAO.selectWidgetWorkData(paramVO);
	}
	
	/**
	 * 위젯 정보 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyWidgetInfoAjax(SiteLayoutVO paramVO) throws Exception{
		return sysWidgetDAO.modifyWidgetInfoAjax(paramVO);
	}

	
	/**
	 * 위젯 디렉토리 파일명 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public void updateWidgetRename(File widgetDir, SiteLayoutVO targetWidget, SiteLayoutVO widget) throws Exception {
		
		File[] fileList = widgetDir.listFiles();
		
		String targetWidegetNm = targetWidget.getSampleFileNm().replace(".html", "");
		String targetWidegetCssNm = targetWidget.getSampleCssNm().replace("css/", "");
		String widegetNm = widget.getSampleFileNm().replace(".html", "");
		String widegetCssNm = widget.getSampleCssNm().replace("css/", "");
		
		if (fileList == null) {
			return;
		}
		
		for(int i = 0; i < fileList.length; i++) {
			if(fileList[i].isFile()) {
				if("css".equals(FilenameUtils.getExtension(fileList[i].getName()))) {
					if(fileList[i].getName().indexOf(targetWidegetCssNm) > -1) {
						Path widgetfile = Paths.get(widgetDir+"/"+fileList[i].getName());
						Path newWidgetfile = Paths.get(widgetDir+"/"+fileList[i].getName().replace(targetWidegetCssNm, widegetCssNm));
						
						Files.move(widgetfile, newWidgetfile);
					}
				}else {
					if(fileList[i].getName().indexOf(targetWidegetNm) > -1) {
						Path widgetfile = Paths.get(widgetDir+"/"+fileList[i].getName());
						Path newWidgetfile = Paths.get(widgetDir+"/"+fileList[i].getName().replace(targetWidegetNm, widegetNm));
						
						Files.move(widgetfile, newWidgetfile);
					}
				}

			}else if(fileList[i].isDirectory()) {
				if(fileList[i].getName().indexOf("images") > -1) {
					Path imgPath = Paths.get(widgetDir+"/"+fileList[i].getName());
					Path newImgPath = Paths.get(widgetDir+"/img");
					Files.move(imgPath, newImgPath);
				}else {
					updateWidgetRename(fileList[i], targetWidget, widget);
				}
			}
		}
	}
	
	/**
	 * 위젯 디렉토리 이미지 파일 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public void deleteWidgetThumbnail(File widgetDir) throws Exception {
		
		File[] fileList = widgetDir.listFiles();
		
		if (fileList == null) {
			return;
		}
		
		for(int i = 0; i < fileList.length; i++) {
			if(fileList[i].isFile()) {
				String ext = FilenameUtils.getExtension(fileList[i].getName());
				if(ext != null) {
					ext = ext.toLowerCase();
				}
				if("jpg".equals(ext) || "png".equals(ext) || "gif".equals(ext) || "svg".equals(ext)) {
					fileList[i].delete();
				}
			}
		}
	}
	
	/**
	 * 위젯 디렉토리 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public void deleteWidgetFile(File widgetDir) throws Exception {
		//위젯 디렉토리 삭제
		try {
			if(widgetDir != null) {
				FileUtils.deleteDirectory(widgetDir);
			}
		} catch (IOException e) {
			log.error("IOException",e);
		}
	}

	/**
	 * 위젯 이름 중복여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectWidgetNmSearch(SiteLayoutVO paramVO) throws Exception {
		return sysWidgetDAO.selectWidgetNmSearch(paramVO);
	}

	/**
	 * 위젯 파일경로 중복여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectWidgetFileCoursSearch(SiteLayoutVO paramVO) throws Exception {
		return sysWidgetDAO.selectWidgetFileCoursSearch(paramVO);
	}
	
	/**
	 * 위젯 html 파일경로 중복여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectWidgetHtmlFileCoursSearch(SiteLayoutVO paramVO) throws Exception {
		return sysWidgetDAO.selectWidgetHtmlFileCoursSearch(paramVO);
	}

	/**
	 * 위젯 썸네일 정보 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int updateWidgetImageinfo(Map<String, String> paramVO) throws Exception {
		return sysWidgetDAO.updateWidgetImageinfo(paramVO);
	}

	/**
	 * 위젯 썸네일 정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteWidgetImageinfo(Map<String, String> paramVO) throws Exception {
		return sysWidgetDAO.deleteWidgetImageinfo(paramVO);
	}

	/**
	 * 위젯 정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteWidgetInfo(SiteLayoutVO paramVO) throws Exception {
		return sysWidgetDAO.deleteWidgetInfo(paramVO);
	}

	/**
	 * 위젯 정보 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registWidgetInfo(SiteLayoutVO paramVO) throws Exception {
		return sysWidgetDAO.registWidgetInfo(paramVO);
	}

	/**
	 * 위젯 카테고리별 개수조회
	 * @return
	 * @throws Exception
	 */
	public List<SiteLayoutVO> selectWidgetInfoCategoryCnt() throws Exception{
		return sysWidgetDAO.selectWidgetInfoCategoryCnt();
	}
}
