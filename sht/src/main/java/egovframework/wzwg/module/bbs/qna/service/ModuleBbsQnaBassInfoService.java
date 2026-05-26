package egovframework.wzwg.module.bbs.qna.service;

import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;

public interface ModuleBbsQnaBassInfoService {


	/**
	 * ㅁ 게시판 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleBbsVO selectBbsBassInfoDetail(ModuleBbsVO moduleBbsVO) throws Exception;
	
	/**
	 * ㅁ 글양식 저장
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsBassInfo(ModuleBbsVO moduleBbsVO) throws Exception;
    
    /**
     * ㅁ 게시판 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registBbsBassInfo(ModuleBbsVO moduleBbsVO) throws Exception;
    
    public String registBbsBassInfoInit(ModuleBbsVO moduleBbsVO) throws Exception;

}
