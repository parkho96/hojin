package egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteEssntlStplatVO;

/**
 * ㅁ 시스템 - 사이트필수약관설정
 * ㅁ DC   
 * - 가입/개인정보처리방침/사이트사용약관 등 필수 적으로 동의를 받아야되는 약관을 설정한다
 * @author HyoJuNiRaNe
 *
 */
@Repository("SiteEssntlStplatDAO")
public class SiteEssntlStplatDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;

    /**
     * ㅁ 사이트 - 사이트필수약관 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    
    public List<SiteEssntlStplatVO> selectSiteEssntlStplatInfoList(SiteEssntlStplatVO paramVO) throws Exception {
    	
    	String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	paramVO.setLangCode(langcode);
    	
        return selectList("SiteEssntlStplatDAO_selectSiteEssntlStplatInfoList", paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트약관목록 코드화 조회 
     * @param paramVO
     * @return
     * @throws Exception
     */
    
    public List<SiteEssntlStplatVO> selectSiteEssntlStplatCode(SiteEssntlStplatVO paramVO) throws Exception {
        return selectList("SiteEssntlStplatDAO_selectSiteEssntlStplatCode", paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트필수약관등록 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectSiteEssntlStplatInfoCheck(SiteEssntlStplatVO paramVO) throws Exception {
        return (Integer)selectOne("SiteEssntlStplatDAO_selectSiteEssntlStplatInfoCheck", paramVO);
    }
    
    /**
     * ㅁ 시스템 - 사이트 필수약관 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer registEssntlStplat(SiteEssntlStplatVO paramVO) throws Exception {
        return (int)update("SiteEssntlStplatDAO_registEssntlStplat", paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 필수약관 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer modifyEssntlStplat(SiteEssntlStplatVO paramVO) throws Exception {
        return (int)update("SiteEssntlStplatDAO_modifyEssntlStplat", paramVO);
    }
    
    
    public  SiteEssntlStplatVO  selectSiteEssntlStplatSign(SiteEssntlStplatVO paramVO) throws Exception {
        return (SiteEssntlStplatVO)selectOne("SiteEssntlStplatDAO_selectSiteEssntlStplatSign", paramVO);
    }
    
}
