package egovframework.wzwg.sysMngr.screen.widget.service.impl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.screen.service.SiteLayoutVO;

@Repository("SysWidgetDAO")
public class SysWidgetDAO extends EgovAbstractMapper{

	/**
	 * 위젯 총 개수 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectWidgetTotalCount(SiteLayoutVO paramVO) throws Exception{
		String result = (String) selectOne("SysWidgetDAO_selectWidgetTotalCount", paramVO);
		
		return Integer.parseInt(result);
	}
	
	/**
	 * 위젯 목록 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	
	public List<SiteLayoutVO> selectWidgetList(SiteLayoutVO paramVO) throws Exception{
		return selectList("SysWidgetDAO_selectWidgetList", paramVO);
	}
	
	/**
	 * 작업중 위젯 목록 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	
	public List<SiteLayoutVO> selectWorkWidgetList(SiteLayoutVO paramVO) throws Exception{
		return selectList("SysWidgetDAO_selectWorkWidgetList", paramVO);
	}
	
	/**
	 * 위젯 정보 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public SiteLayoutVO selectWidgetData(SiteLayoutVO paramVO) throws Exception{
		return (SiteLayoutVO) selectOne("SysWidgetDAO_selectWidgetData", paramVO);
	}
	
	/**
	 * 위젯 백업 시퀀스 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public String selectWidgetWorkSeq(SiteLayoutVO paramVO) throws Exception{
		return (String) selectOne("SysWidgetDAO_selectWidgetWorkSeq", paramVO);
	}
	
	/**
	 * 위젯 백업 정보 저장
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registWidgetWorkInfo(SiteLayoutVO paramVO) throws Exception{
		return (int) update("SysWidgetDAO_registWidgetWorkInfo", paramVO);
	}
	
	/**
	 * 위젯 백업 정보 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public SiteLayoutVO selectWidgetWorkData(SiteLayoutVO paramVO) throws Exception{
		return (SiteLayoutVO) selectOne("SysWidgetDAO_selectWidgetWorkData", paramVO);
	}
	
	/**
	 * 위젯 정보 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyWidgetInfoAjax(SiteLayoutVO paramVO) throws Exception{
		return (int) update("SysWidgetDAO_modifyWidgetInfoAjax", paramVO);
	}
	
	/**
	 * 위젯 이름 중복여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectWidgetNmSearch(SiteLayoutVO paramVO) throws Exception{
		return (int) selectOne("SysWidgetDAO_selectWidgetNmSearch", paramVO);
	}
	
	/**
	 * 위젯 html 파일경로 중복여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectWidgetHtmlFileCoursSearch(SiteLayoutVO paramVO) throws Exception{
		return (int) selectOne("SysWidgetDAO_selectWidgetHtmlFileCoursSearch", paramVO);
	}
	
	/**
	 * 위젯 파일경로 중복여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectWidgetFileCoursSearch(SiteLayoutVO paramVO) throws Exception{
		return (int) selectOne("SysWidgetDAO_selectWidgetFileCoursSearch", paramVO);
	}
	
	/**
	 * 위젯 썸네일 정보 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int updateWidgetImageinfo(Map<String, String> paramVO) throws Exception{
		return (int)  update("SysWidgetDAO_updateWidgetImageinfo", paramVO);
	}
	
	/**
	 * 위젯 썸네일 정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteWidgetImageinfo(Map<String, String> paramVO) throws Exception{
		return (int)  update("SysWidgetDAO_deleteWidgetImageinfo", paramVO);
	}
	
	/**
	 * 위젯 정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteWidgetInfo(SiteLayoutVO paramVO) throws Exception{
		return (int)  update("SysWidgetDAO_deleteWidgetInfo", paramVO);
	}
	
	/**
	 * 위젯 정보 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registWidgetInfo(SiteLayoutVO paramVO) throws Exception{
		return (int)  update("SysWidgetDAO_registWidgetInfo", paramVO);
	}
	
	/**
	 * 위젯 카테고리별 개수조회
	 * @return
	 * @throws Exception
	 */
	public List<SiteLayoutVO> selectWidgetInfoCategoryCnt() throws Exception{
		return selectList("SysWidgetDAO_selectWidgetInfoCategoryCnt");
	}
}
