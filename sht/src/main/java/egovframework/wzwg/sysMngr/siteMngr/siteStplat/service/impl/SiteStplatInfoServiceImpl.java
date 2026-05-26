package egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatSimpService;


/**
 * ㅁ 시스템 - 사이트약관정보관리
 * ㅁ DC   
 * - 시스템관리자가 각 사이트 약관정보을 관리
 * - 전체 시스템에서 사용할 약관정보 관리
 * @author HyoJuNiRaNe
 *
 */
@Service("SiteStplatInfoService")
public class SiteStplatInfoServiceImpl extends EgovAbstractServiceImpl implements SiteStplatInfoService {

    @Resource(name="SiteStplatInfoDAO")
    private SiteStplatInfoDAO siteStplatInfoDAO;
    
    /** 사이트 정보 service */
	@Resource(name="SysMngrSiteInfoService")
	private SysMngrSiteInfoService siteInfoService;

	/** 상세 약관 service */
	@Resource(name="SiteStplatSimpService")
	private SiteStplatSimpService stplatSimpService;
	

    /********************************* 2019.02.28 start ****************************************/

	/**
	 * ㅁ 시스템 - 사이트 약관정보 시퀀스 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectSiteStplatInfoNextSeq() throws Exception {
		return siteStplatInfoDAO.selectSiteStplatInfoNextSeq();
	}

	/**
	 * ㅁ 시스템 - 사이트 약관정보 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SiteStplatInfoVO> selectSiteStplatInfoList(SiteStplatInfoVO paramVO) throws Exception {
    	return siteStplatInfoDAO.selectSiteStplatInfoList(paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 약관정보 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectSiteStplatInfoListCnt(SiteStplatInfoVO paramVO) throws Exception {
    	return siteStplatInfoDAO.selectSiteStplatInfoListCnt(paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 약관정보 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
    public SiteStplatInfoVO selectSiteStplatInfoDetail(SiteStplatInfoVO paramVO) throws Exception {
    	return siteStplatInfoDAO.selectSiteStplatInfoDetail(paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 약관정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registSiteStplatInfo(SiteStplatInfoVO paramVO) throws Exception {
    	if(("").equals(StringUtils.defaultString(paramVO.getStplatSeq()))){
    		String stplatSeq = siteStplatInfoDAO.selectSiteStplatInfoNextSeq();
    		paramVO.setStplatSeq(stplatSeq);
    	}
    	
		return siteStplatInfoDAO.registSiteStplatInfo(paramVO);
    }
    
    /**
	 * ㅁ 시스템 - 사이트 약관정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySiteStplatInfo(SiteStplatInfoVO paramVO) throws Exception {
    	return siteStplatInfoDAO.modifySiteStplatInfo(paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 약관정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteSiteStplatInfo(SiteStplatInfoVO paramVO) {
		return siteStplatInfoDAO.deleteSiteStplatInfo(paramVO);
	}

	/**
	 * ㅁ 약관 리스트 조회(사용자)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<SiteStplatInfoVO> selectStplatInfoUsrList(SiteStplatInfoVO searchVO) {
		return siteStplatInfoDAO.selectStplatInfoUsrList(searchVO);
	}

	/**
	 * ㅁ 시스템 - 기본 설정 여부 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifySysStplatInfoDefault(SiteStplatInfoVO paramVO) throws Exception {
		return siteStplatInfoDAO.modifySysStplatInfoDefault(paramVO);
	}

	/**
	 * ㅁ 시스템 - 전체 사이트에 약관 적용
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registSysStplatInfoAllSiteApply(SiteStplatInfoVO paramVO) throws Exception {
		
		int result = 1;
		
		// 사이트 정보 목록
		SysMngrSiteInfoVO siteVO = new SysMngrSiteInfoVO();
		siteVO.setFirstIndex(0);
		siteVO.setRecordCountPerPage(10000);
		siteVO.setAblEnncAt("N");
		
		List<SysMngrSiteInfoVO> siteList = siteInfoService.selectSiteInfoList(siteVO);
		
		if(siteList.size() > 0 && siteList != null && !siteList.isEmpty()){
			for(int i=0; i<siteList.size(); i++){
				String siteSeq = siteList.get(i).getSiteSeq();
				
				/** sysStplatVO는 시스템관리자의 약관정보임 */
				SiteStplatInfoVO sysStplatVO = siteStplatInfoDAO.selectSiteStplatInfoDetail(paramVO);
				
				SiteStplatInfoVO tempStplatVO = new SiteStplatInfoVO();
				tempStplatVO.setSiteSeq(siteSeq);
				tempStplatVO.setSysStplatSeq(sysStplatVO.getStplatSeq());
				
				String legacyStplatSeq = siteStplatInfoDAO.selectSysSiteStplatInfoChk(tempStplatVO);
				
				if(!("").equals(StringUtils.defaultString(legacyStplatSeq))){
					tempStplatVO.setStplatSeq(legacyStplatSeq);
				}else{
					tempStplatVO.setStplatSeq(siteStplatInfoDAO.selectSiteStplatInfoNextSeq());
					tempStplatVO.setStplatTyCode(sysStplatVO.getStplatTyCode());
					tempStplatVO.setStplatNm(sysStplatVO.getStplatNm());
					tempStplatVO.setStplatDc(sysStplatVO.getStplatDc());
					tempStplatVO.setFrstRegisterId(paramVO.getFrstRegisterId());
					tempStplatVO.setLastUpdusrId(paramVO.getLastUpdusrId());
					tempStplatVO.setEssntlAt(sysStplatVO.getEssntlAt());
					
					siteStplatInfoDAO.registSiteStplatInfo(tempStplatVO);
				}

				List<SiteStplatInfoVO> sysStplatSimpList = stplatSimpService.selectSiteStplatSimpList(sysStplatVO);
		        if(sysStplatSimpList.size() > 0 && sysStplatSimpList != null && !sysStplatSimpList.isEmpty()){
		        	for(int j=1; j<=sysStplatSimpList.size(); j++){
		        		tempStplatVO.setSysStplatsimpSeq(sysStplatSimpList.get(sysStplatSimpList.size()-j).getStplatsimpSeq());
		        		
		        		String legacyStplatSimpSeq = stplatSimpService.selectSysSiteStplatSimpChk(tempStplatVO);
		        		
		        		if(!("").equals(StringUtils.defaultString(legacyStplatSimpSeq))){
		        		}else{
		        			SiteStplatInfoVO simpVO = new SiteStplatInfoVO();
		        			
		        			simpVO.setStplatSeq(tempStplatVO.getStplatSeq()); 
		        			simpVO.setOpertnDe(sysStplatSimpList.get(sysStplatSimpList.size()-j).getOpertnDe().replaceAll("-", ""));
		        			simpVO.setStplatSj(sysStplatSimpList.get(sysStplatSimpList.size()-j).getStplatSj());
		        			simpVO.setStplatCn(sysStplatSimpList.get(sysStplatSimpList.size()-j).getStplatCn());
		        			simpVO.setFrstRegisterId(paramVO.getFrstRegisterId());
		        			simpVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		        			simpVO.setSysStplatsimpSeq(sysStplatSimpList.get(sysStplatSimpList.size()-j).getStplatsimpSeq());
		        			
		        			stplatSimpService.registSiteStplatSimp(simpVO);
		        			
		        		}
		        	}
		        }
			}
		}
		
		return result;
	}
	/********************************* 2019.02.28 end ****************************************/
	
	
    public String registSiteStplatInfoInit(SiteStplatInfoVO paramVO) throws Exception {
   	 
    	return siteStplatInfoDAO.registSiteStplatInfoInit(paramVO);
    }
    
    public SiteStplatInfoVO selectSiteStplatInfoSign(SiteStplatInfoVO paramVO) throws Exception { 
    	return  siteStplatInfoDAO.selectSiteStplatInfoSign(paramVO);
    }
	
	public SiteStplatInfoVO selectSysSiteStplatInfoSign(SiteStplatInfoVO paramVO) throws Exception { 
    	return siteStplatInfoDAO.selectSysSiteStplatInfoSign(paramVO);
    }

}
