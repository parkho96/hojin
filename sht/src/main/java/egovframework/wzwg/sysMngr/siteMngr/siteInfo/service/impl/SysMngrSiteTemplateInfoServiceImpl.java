package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteTemplateInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteTemplateInfoVO;


/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Service("SysMngrSiteTemplateInfoService")
public class SysMngrSiteTemplateInfoServiceImpl extends EgovAbstractServiceImpl implements SysMngrSiteTemplateInfoService {

	@Resource(name="SysMngrSiteTemplateInfoDAO")
	private SysMngrSiteTemplateInfoDAO siteTemplateInfoDAO; 
	
	/**
	 * ㅁ 템플릿 목록
     * @param vo
     * @return
     * @throws Exception
     */
	public List<SysMngrSiteTemplateInfoVO> selectTemplateList(SysMngrSiteTemplateInfoVO vo) throws Exception {
		return siteTemplateInfoDAO.selectTemplateList(vo);
	}
	
	/**
	 * ㅁ 사이트별 템플릿 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<SysMngrSiteTemplateInfoVO> selectSiteTemplateInfoList(SysMngrSiteTemplateInfoVO vo) throws Exception {
		return siteTemplateInfoDAO.selectSiteTemplateInfoList(vo);
	}

	/**
	 * ㅁ 사이트별 템플릿 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void registSiteTemplateInfo(SysMngrSiteTemplateInfoVO vo) throws Exception {
		
		if(vo.getCode() != null && !"".equals(vo.getCode())){	// 카테고리 전체가 아닌 경우
				
			String[] chkTemplateSeqArr = vo.getChkTemplateSeqArr().substring(0, vo.getChkTemplateSeqArr().length()-1).split(",");
			String[] chkTemplateChkArr = vo.getChkTemplateChkArr().substring(0, vo.getChkTemplateChkArr().length()-1).split(",");
			
			for(int i = 0; i < chkTemplateSeqArr.length; i++) {
				
				vo.setTemplateSeq(chkTemplateSeqArr[i]);
				
				siteTemplateInfoDAO.deleteSiteTemplateChkInfo(vo);
				
				if("Y".equals(chkTemplateChkArr[i])){
					siteTemplateInfoDAO.registSiteTemplateInfo(vo);
				}
			}
			
		}else{	// 카테고리 전체인 경우
			if(vo.getTemplateSeqArr() != null && vo.getTemplateSeqArr().length > 0) {
				deleteSiteTemplateInfo(vo);
				
				for(int i = 0; i < vo.getTemplateSeqArr().length; i++) {
					vo.setTemplateSeq(vo.getTemplateSeqArr()[i]);
					siteTemplateInfoDAO.registSiteTemplateInfo(vo);
				}
			}else{
				deleteSiteTemplateInfo(vo);
			}
		}
	}

	/**
	 * ㅁ 사이트별 템플릿 전체 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void registAllSiteTemplateInfo(SysMngrSiteTemplateInfoVO vo) throws Exception {

		List<SysMngrSiteTemplateInfoVO> list = selectTemplateList(vo);

		if(list.size() > 0) { 
			for(int i = 0; i < list.size(); i++) {
				SysMngrSiteTemplateInfoVO siteTemplateInfoVO = list.get(i);
				vo.setTemplateSeq(siteTemplateInfoVO.getTemplateSeq());
				siteTemplateInfoDAO.registSiteTemplateInfo(vo);
			}
		}
	}
	 
	/**
	 * ㅁ 사이트별 템플릿 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public void deleteSiteTemplateInfo(SysMngrSiteTemplateInfoVO vo) throws Exception {
		siteTemplateInfoDAO.deleteSiteTemplateInfo(vo);
	}

}
