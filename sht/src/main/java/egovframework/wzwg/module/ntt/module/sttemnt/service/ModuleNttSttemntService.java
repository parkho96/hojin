package egovframework.wzwg.module.ntt.module.sttemnt.service;


public interface ModuleNttSttemntService {

	
	/**
	 * ㅁ 게시물 신고SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttSttemntSeq() throws Exception;
	
	/**
	 * ㅁ 게시물 신고
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttSttemnt(ModuleNttSttemntVO nttSttemntVO) throws Exception;
	
	
}
