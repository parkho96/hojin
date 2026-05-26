package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.impl;

import java.util.Map;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;

/**
 * ㅁ 시스템 - 사이트 부가정보관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Repository("SysMngrSiteAdiInfoDAO")
public class SysMngrSiteAdiInfoDAO extends EgovAbstractMapper {

    /**
	 * ㅁ 시스템 - 사이트 부가정보 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public SysMngrSiteAdiInfoVO selectSiteAdiInfoDetail(SysMngrSiteAdiInfoVO paramVO) throws Exception {
    	return (SysMngrSiteAdiInfoVO)selectOne("SysMngrSiteAdiInfoDAO_selectSiteAdiInfoDetail", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 부가정보 존재여부
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectSiteAdiInfoCnt(SysMngrSiteAdiInfoVO paramVO) throws Exception {
    	return (Integer)selectOne("SysMngrSiteAdiInfoDAO_selectSiteAdiInfoCnt", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 부가정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registSiteAdiInfo(SysMngrSiteAdiInfoVO paramVO) throws Exception {
    	insert("SysMngrSiteAdiInfoDAO_registSiteAdiInfo", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 부가정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifySiteAdiInfo(SysMngrSiteAdiInfoVO paramVO) throws Exception {
    	update("SysMngrSiteAdiInfoDAO_modifySiteAdiInfo", paramVO);
    }
    
    /**
 	 * ㅁ 시스템 - 사이트 부가하단 정보 상세
      * @param paramVO
      * @return
      * @throws Exception
      */
 	public SysMngrSiteAdiInfoVO selectSiteFtrInfoDetail(SysMngrSiteAdiInfoVO paramVO) throws Exception {
     	return (SysMngrSiteAdiInfoVO)selectOne("SysMngrSiteAdiInfoDAO_selectSiteFtrInfoDetail", paramVO);
     }

    /**
     * ㅁ 시스템 - 사이트 부가정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifySiteMenuEstbsAt(SysMngrSiteAdiInfoVO paramVO) throws Exception {
        update("SysMngrSiteAdiInfoDAO_modifySiteMenuEstbsAt", paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 부가정보 - 메뉴설정여부 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String selectSiteMenuEstbsAt(SysMngrSiteAdiInfoVO paramVO) throws Exception {
        return (String)selectOne("SysMngrSiteAdiInfoDAO_selectSiteMenuEstbsAt", paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 부가정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registSiteAdiInfoExcel(Map<String, String> paramMap) throws Exception {
        insert("SysMngrSiteAdiInfoDAO_registSiteAdiInfoExcel", paramMap);
    }

    /**
     * ㅁ 시스템 - 엑셀로 등록한 사이트정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void deleteSiteAdiInfoExcel(String siteSeq) throws Exception {
        delete("SysMngrSiteAdiInfoDAO_deleteSiteAdiInfoExcel", siteSeq);
    }
    

    /**
     * ㅁ 시스템 - 사이트 부가정보 - 관리자 접속 IP
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String selectSiteAdiInfoConnIp(String siteSeq) throws Exception {
        return (String)selectOne("SysMngrSiteAdiInfoDAO_selectSiteAdiInfoConnIp", siteSeq);
    }
    
}
