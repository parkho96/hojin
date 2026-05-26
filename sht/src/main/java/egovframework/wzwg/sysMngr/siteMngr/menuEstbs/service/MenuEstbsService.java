package egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service;

import java.util.List;

/**
 * ㅁ 시스템 - 메뉴설정관리
 * ㅁ DC   
 * - 시스템관리자가 메뉴설정를 관리
 * - 생선된 메뉴설정는 메뉴설정 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
public interface MenuEstbsService {

    /**
	 * ㅁ 시스템 - 메뉴설정 그룹 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<MenuEstbsVO> selectMenuEstbsList(MenuEstbsVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 메뉴설정 그룹 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectMenuEstbsListCnt(MenuEstbsVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 메뉴설정 그룹 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
    public MenuEstbsVO selectMenuEstbsDetail(MenuEstbsVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 메뉴설정 그룹 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registMenuEstbs(MenuEstbsVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 메뉴설정 그룹 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifyMenuEstbs(MenuEstbsVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 메뉴설정 2차 그룹 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<MenuEstbsVO> selectMenuEstbsMlsfcList(MenuEstbsVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 메뉴설정 그룹 셀렉트 박스
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<MenuEstbsVO> selectMenuEstbsAjax(MenuEstbsVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 메뉴설정 그룹 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<MenuEstbsVO> selectMenuEstbsCodeList(MenuEstbsVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 메뉴설정 사이트 셋팅
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registMenuEstbsSiteSetAjax(MenuEstbsVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 사이트메뉴설정여부 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyMenuEstbsAt(MenuEstbsVO paramVO) throws Exception;
    
}
