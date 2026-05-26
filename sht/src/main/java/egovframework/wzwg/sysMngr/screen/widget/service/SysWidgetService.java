package egovframework.wzwg.sysMngr.screen.widget.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import egovframework.wzwg.site.mngr.screen.service.SiteLayoutVO;

public interface SysWidgetService {

	/**
	 * 위젯 총 개수 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectWidgetTotalCount(SiteLayoutVO paramVO) throws Exception;
	
	/**
	 * 위젯 목록 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<SiteLayoutVO> selectWidgetList(SiteLayoutVO paramVO) throws Exception;
	
	/**
	 * 작업중 위젯 목록 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<SiteLayoutVO> selectWorkWidgetList(SiteLayoutVO paramVO) throws Exception;
	
	/**
	 * 위젯 정보 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public SiteLayoutVO selectWidgetData(SiteLayoutVO paramVO) throws Exception;
	
	
	/**
	 * 위젯 백업 정보 저장
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registWidgetWorkInfo(SiteLayoutVO paramVO) throws Exception;
	
	/**
	 * 위젯 백업 정보 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public SiteLayoutVO selectWidgetWorkData(SiteLayoutVO paramVO) throws Exception;
	
	/**
	 * 위젯 정보 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyWidgetInfoAjax(SiteLayoutVO paramVO) throws Exception;
	
	/**
	 * 위젯 디렉토리 파일명 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public void updateWidgetRename(File widgetDir, SiteLayoutVO targetWidget, SiteLayoutVO widget) throws Exception;
	
	/**
	 * 위젯 디렉토리 이미지 파일 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public void deleteWidgetThumbnail(File widgetDir) throws Exception;
	
	/**
	 * 위젯 디렉토리 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public void deleteWidgetFile(File widgetDir) throws Exception;
	
	/**
	 * 위젯 이름 중복여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectWidgetNmSearch(SiteLayoutVO paramVO) throws Exception;
	
	/**
	 * 위젯 파일경로 중복여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectWidgetFileCoursSearch(SiteLayoutVO paramVO) throws Exception;
	
	/**
	 * 위젯 html 파일경로 중복여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectWidgetHtmlFileCoursSearch(SiteLayoutVO paramVO) throws Exception;
	
	/**
	 * 위젯 썸네일 정보 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int updateWidgetImageinfo(Map<String, String> paramVO) throws Exception;
	
	/**
	 * 위젯 썸네일 정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteWidgetImageinfo(Map<String, String> paramVO) throws Exception;
	
	/**
	 * 위젯 정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteWidgetInfo(SiteLayoutVO paramVO) throws Exception;
	
	/**
	 * 위젯 정보 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registWidgetInfo(SiteLayoutVO paramVO) throws Exception;
	
	/**
	 * 위젯 카테고리별 개수조회
	 * @return
	 * @throws Exception
	 */
	public List<SiteLayoutVO> selectWidgetInfoCategoryCnt() throws Exception;
	
}
