package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.impl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;

/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Repository("SysMngrSiteInfoDAO")
public class SysMngrSiteInfoDAO extends EgovAbstractMapper {

    /**
	 * ㅁ 시스템 - 사이트 정보 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    
	public List<SysMngrSiteInfoVO> selectSiteInfoList(SysMngrSiteInfoVO paramVO) throws Exception {
    	return selectList("SysMngrSiteInfoDAO_selectSiteInfoList", paramVO);
    }

    
    public List<SysMngrSiteInfoVO> selectSiteInfoSignList(SysMngrSiteInfoVO paramVO) throws Exception {
    	return selectList("SysMngrSiteInfoDAO_selectSiteInfoSignList", paramVO);
    }
    
    /**
	 * ㅁ 시스템 - 사이트 정보 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectSiteInfoListCnt(SysMngrSiteInfoVO paramVO) throws Exception {
    	return (Integer)selectOne("SysMngrSiteInfoDAO_selectSiteInfoListCnt", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 정보 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public SysMngrSiteInfoVO selectSiteInfoDetail(SysMngrSiteInfoVO paramVO) throws Exception {
    	return (SysMngrSiteInfoVO)selectOne("SysMngrSiteInfoDAO_selectSiteInfoDetail", paramVO);
    }
	
	/**
	 * ㅁ 시스템 - 사이트 시퀀스 획득
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextSiteSeq() throws Exception {
    	return (String)selectOne("SysMngrSiteInfoDAO_selectNextSiteSeq");
    }
	

    /**
	 * ㅁ 시스템 - 사이트 정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registSiteInfo(SysMngrSiteInfoVO paramVO) throws Exception {
    	insert("SysMngrSiteInfoDAO_registSiteInfo", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifySiteInfo(SysMngrSiteInfoVO paramVO) throws Exception {
    	update("SysMngrSiteInfoDAO_modifySiteInfo", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 상태 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifySiteSttus(SysMngrSiteInfoVO paramVO) throws Exception {
    	update("SysMngrSiteInfoDAO_modifySiteSttus", paramVO);
    }

    /**
     * ㅁ 시스템 - 조합번호 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectAsscNoCnt(SysMngrSiteInfoVO paramVO) throws Exception {
        return (Integer)selectOne("SysMngrSiteInfoDAO_selectAsscNoCnt", paramVO);
    }
    
    /**
     * ㅁ 시스템 - 사이트정보 엑셀 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer registSiteInfoExcel(Map<String, String> paramMap) throws Exception {
        return update("SysMngrSiteInfoDAO_registSiteInfoExcel", paramMap);
    }
    
    /**
     * ㅁ 시스템 - 시스템 관리자 사이트 체크
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int selectSiteInfoSysCheck(SysMngrSiteInfoVO paramVO) throws Exception {
        return ((Integer)selectOne("SysMngrSiteInfoDAO_selectSiteInfoSysCheck", paramVO)).intValue();
    }
    

	/**
	 * 사이트 키 중복체크
	 * @param paramVO
	 * @return
	 */
	public String selectSiteInfoDplctCheck(SysMngrSiteInfoVO paramVO) {
		return (String) selectOne("SysMngrSiteInfoDAO_selectSiteInfoDplctCheck", paramVO);
	}
 
}
