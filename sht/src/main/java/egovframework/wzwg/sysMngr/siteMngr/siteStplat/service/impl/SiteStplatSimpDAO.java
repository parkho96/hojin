package egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;

@Repository("SiteStplatSimpDAO")
public class SiteStplatSimpDAO extends EgovAbstractMapper {

	/************************* 2019.02.28 start **************************/
	
    
    /** 세부약관 리스트 조회 */
	public List<SiteStplatInfoVO> selectSiteStplatSimpList(SiteStplatInfoVO paramVO) throws Exception {
    	return selectList("SiteStplatSimpDAO_selectSiteStplatSimpList", paramVO);
    }

    /** 세부약관 등록 */
    public Integer registSiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception {
    	return update("SiteStplatSimpDAO_registSiteStplatSimp", paramVO);
    }

    /** 세부약관 상세조회 */
    public SiteStplatInfoVO selectSiteStplatSimpDetail(SiteStplatInfoVO paramVO) throws Exception {
    	return (SiteStplatInfoVO)selectOne("SiteStplatSimpDAO_selectSiteStplatSimpDetail", paramVO);
    }
    
    /** 세부약관 수정 */
    public Integer modifySiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception {
    	return update("SiteStplatSimpDAO_modifySiteStplatSimp", paramVO);
    }
    
    /** 세부약관 삭제 */
    public Integer deleteSiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception {
        return update("SiteStplatSimpDAO_deleteSiteStplatSimp", paramVO);
    }

    /** 마지막으로 등록된 seq 조회 (종료일을 update를 위해 사용) */
	public String selectBeforeStplatSimpSeqChk(SiteStplatInfoVO paramVO) {
		return (String) selectOne("SiteStplatSimpDAO_selectBeforeStplatSimpSeqChk", paramVO);
	}

	/** 종료일 update */
	public void updateStplatSimpEndDe(SiteStplatInfoVO paramVO) {
		update("SiteStplatSimpDAO_updateStplatSimpEndDe", paramVO);
	}
	
	/** 전체사이트 적용시 사이트마다 세부약관 존재여부 확인 */
	public String selectSysSiteStplatSimpChk(SiteStplatInfoVO paramVO) {
		return (String) selectOne("SiteStplatSimpDAO_selectSysSiteStplatSimpChk", paramVO);
	}

	/************************* 2019.02.28 end **************************/
    
	public Integer selectSiteStplatSimpListCnt(SiteStplatInfoVO paramVO) throws Exception {
    	return (Integer)selectOne("SiteStplatSimpDAO_selectSiteStplatSimpListCnt", paramVO);
    }
	
	public SiteStplatInfoVO selectSysSiteStplatSimpDetail() throws Exception {
    	return (SiteStplatInfoVO)selectOne("SiteStplatSimpDAO_selectSysSiteStplatSimpDetail");
    }
	
    public SiteStplatInfoVO selectStplatSimpBySeq(SiteStplatInfoVO paramVO) throws Exception {
        return (SiteStplatInfoVO)selectOne("SiteStplatSimpDAO_selectStplatSimpBySeq", paramVO);
    }

    public SiteStplatInfoVO selectStplatSimpByJoin(SiteStplatInfoVO paramVO) throws Exception {
        return (SiteStplatInfoVO)selectOne("SiteStplatSimpDAO_selectStplatSimpByJoin", paramVO);
    }
    
    public Integer defaultAllNonSysSiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception {
        return update("SiteStplatSimpDAO_defaultAllNonSysSiteStplatSimp", paramVO);
    }
    
    public Integer defaultSysSiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception {
        return update("SiteStplatSimpDAO_defaultSysSiteStplatSimp", paramVO);
    }


}