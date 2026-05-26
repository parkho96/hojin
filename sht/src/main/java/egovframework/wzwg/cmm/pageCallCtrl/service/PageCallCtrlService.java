package egovframework.wzwg.cmm.pageCallCtrl.service;



public interface PageCallCtrlService {
    
    /**
     * 메뉴SEQ로 메뉴에 매핑된 사이트컨텐츠SEQ를 가져온다
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    //String selectMenuSeqBySiteCntntsSeq(PageCallCtrlVO paramVO);
	
	  public String selectMenuSeqByMenuNm(PageCallCtrlVO paramVO) ;
	  
	  public String selectMenuSeqByMenuDc(PageCallCtrlVO paramVO) ;
		
	  public String selectMenuSeqByMenuPath(PageCallCtrlVO paramVO) ;
	  
	  public String selectMenuSeqByMenuPathSeq(PageCallCtrlVO paramVO) ;
	  
	  public String selectMenuSeqByMenuLinkUrl(PageCallCtrlVO paramVO) ;
	  
}
