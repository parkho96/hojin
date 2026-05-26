package egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service.MenuEstbsVO;

/**
 * ㅁ 시스템 - 사이트 부가정보관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Repository("MenuEstbsDAO")
public class MenuEstbsDAO extends EgovAbstractMapper {


    /**
     * ㅁ 시스템 - 사이트 그룹 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    
    public List<MenuEstbsVO> selectMenuEstbsList(MenuEstbsVO paramVO) throws Exception {
        
        return selectList("MenuEstbsDAO_selectMenuEstbsList", paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 그룹 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectMenuEstbsListCnt(MenuEstbsVO paramVO) throws Exception {

        return (Integer)selectOne("MenuEstbsDAO_selectMenuEstbsListCnt" ,paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 그룹 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
    public MenuEstbsVO selectMenuEstbsDetail(MenuEstbsVO paramVO) throws Exception {

        return (MenuEstbsVO)selectOne("MenuEstbsDAO_selectMenuEstbsDetail", paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 그룹 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registMenuEstbs(MenuEstbsVO paramVO) throws Exception {

        insert("MenuEstbsDAO_registMenuEstbs", paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 그룹 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifyMenuEstbs(MenuEstbsVO paramVO) throws Exception {

        update("MenuEstbsDAO_modifyMenuEstbs", paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 2차 그룹 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    
    public List<MenuEstbsVO> selectMenuEstbsMlsfcList(MenuEstbsVO paramVO) throws Exception {
        
        return selectList("MenuEstbsDAO_selectMenuEstbsMlsfcList", paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 그룹 셀렉트 박스
     * @param paramVO
     * @return
     * @throws Exception
     */
    
    public List<MenuEstbsVO> selectMenuEstbsAjax(MenuEstbsVO paramVO) throws Exception {
        
        return selectList("MenuEstbsDAO_selectMenuEstbsAjax", paramVO);
    }
    
    /**
     * ㅁ 시스템 - 사이트 그룹 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    
    public List<MenuEstbsVO> selectMenuEstbsCodeList(MenuEstbsVO paramVO) throws Exception {
        
        return selectList("MenuEstbsDAO_selectMenuEstbsCodeList", paramVO);
    }

    /**
     * ㅁ 시스템 - 메뉴설정여부 초기화
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifyMenuEstbsAtInitl(MenuEstbsVO paramVO) throws Exception {

        update("MenuEstbsDAO_modifyMenuEstbsAtInitl", paramVO);
    }

    /**
     * ㅁ 시스템 - 메뉴설정여부 변경
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyMenuEstbsAt(MenuEstbsVO paramVO) throws Exception {

        return update("MenuEstbsDAO_modifyMenuEstbsAt", paramVO);
    }

    /**
     * ㅁ 시스템 - 초기 메뉴로 설정 메뉴설정SEQ 가져온다
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String selectMenuEstbsSeq() throws Exception {

        return (String)selectOne("MenuEstbsDAO_selectMenuEstbsSeq");
    }

    /**
     * ㅁ 시스템 - 메뉴 연결 컨텐츠 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int deleteMenuEstbsConnCntntsAll(MenuEstbsVO paramVO) throws Exception {

        return update("MenuEstbsDAO_deleteMenuEstbsConnCntntsAll", paramVO);
    }
    
}
