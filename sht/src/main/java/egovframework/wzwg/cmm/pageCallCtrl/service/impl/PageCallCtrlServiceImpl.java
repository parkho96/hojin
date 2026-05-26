package egovframework.wzwg.cmm.pageCallCtrl.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.cmm.pageCallCtrl.service.PageCallCtrlService;
import egovframework.wzwg.cmm.pageCallCtrl.service.PageCallCtrlVO;

@Service("PageCallCtrlService")
public class PageCallCtrlServiceImpl extends EgovAbstractServiceImpl implements PageCallCtrlService {


    @Resource(name="PageCallCtrlDAO")
    private PageCallCtrlDAO pageCallCtrlDAO;
    
    /**
     * 메뉴SEQ로 메뉴에 매핑된 사이트컨텐츠SEQ를 가져온다
     * 
     * @param vo
     * @return
     * @throws Exception
     */
//    public String selectMenuSeqBySiteCntntsSeq(PageCallCtrlVO paramVO) {
//        
//        return pageCallCtrlDAO.selectMenuSeqBySiteCntntsSeq(paramVO);
//    }
    
    public String selectMenuSeqByMenuNm(PageCallCtrlVO paramVO) {
        return pageCallCtrlDAO.selectMenuSeqByMenuNm(paramVO);
    }
    
    public String selectMenuSeqByMenuDc(PageCallCtrlVO paramVO) {
        return pageCallCtrlDAO.selectMenuSeqByMenuDc(paramVO);
    }
	
    public String selectMenuSeqByMenuPath(PageCallCtrlVO paramVO) {
	  return  pageCallCtrlDAO.selectMenuSeqByMenuPath(paramVO);
	}
    
    public String selectMenuSeqByMenuPathSeq(PageCallCtrlVO paramVO) {
	  return  pageCallCtrlDAO.selectMenuSeqByMenuPathSeq(paramVO);
    }
  
    public String selectMenuSeqByMenuLinkUrl(PageCallCtrlVO paramVO) {
	  return  pageCallCtrlDAO.selectMenuSeqByMenuLinkUrl(paramVO);
	}
}
