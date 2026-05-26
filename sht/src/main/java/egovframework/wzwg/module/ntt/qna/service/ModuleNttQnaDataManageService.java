package egovframework.wzwg.module.ntt.qna.service;

import java.util.List;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;

public interface ModuleNttQnaDataManageService {


	/**
	 * ㅁ 상단걸기 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttNoticeList(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 상단걸기 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttNotice(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 자주묻는질문 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttFaq(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시판 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttList(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시판 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttListTotCnt(ModuleNttVO nttVO) throws Exception;
    
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleNttVO> selectNttScrinCntnts(ModuleNttVO nttVO) throws Exception;
    
	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttRecycleList(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttRecycleListTotCnt(ModuleNttVO nttVO) throws Exception;
}
