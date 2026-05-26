package egovframework.wzwg.cmm.pageCallCtrl.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.cmm.pageCallCtrl.service.PageCallCtrlVO;

@Repository("PageCallCtrlDAO")
public class PageCallCtrlDAO extends EgovAbstractMapper {

    /**
     * 메뉴SEQ로 메뉴에 매핑된 사이트컨텐츠SEQ를 가져온다
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public String selectMenuSeqByMenuNm(PageCallCtrlVO paramVO) {
        return (String)selectOne("PageCallCtrlDAO_selectMenuSeqByMenuNm", paramVO);
    }
	
    public String selectMenuSeqByMenuDc(PageCallCtrlVO paramVO) {
        return (String)selectOne("PageCallCtrlDAO_selectMenuSeqByMenuDc", paramVO);
    }
	
    public String selectMenuSeqByMenuPath(PageCallCtrlVO paramVO) {
    	return (String)selectOne("PageCallCtrlDAO_selectMenuSeqByMenuPath", paramVO);
    }
    
    public String selectMenuSeqByMenuPathSeq(PageCallCtrlVO paramVO) {
    	return (String)selectOne("PageCallCtrlDAO_selectMenuSeqByMenuPathSeq", paramVO);
	}
	
	  
	public String selectMenuSeqByMenuLinkUrl(PageCallCtrlVO paramVO) {
		return (String)selectOne("PageCallCtrlDAO_selectMenuSeqByMenuLinkUrl", paramVO);
	}
}
