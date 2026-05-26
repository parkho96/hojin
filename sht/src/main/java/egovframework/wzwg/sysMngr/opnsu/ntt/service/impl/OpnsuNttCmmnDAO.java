package egovframework.wzwg.sysMngr.opnsu.ntt.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttVO;



@Repository("OpnsuNttCmmnDAO")

public class OpnsuNttCmmnDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 조회수 증가
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void modifyNttInqireCnt(OpnsuNttVO nttVO) throws Exception {
		update("OpnsuNttCmmnDAO_modifyNttInqireCnt_U", nttVO);
	}
	
	/**
	 * ㅁ 게시물 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public OpnsuNttVO selectNttDetail(OpnsuNttVO nttVO) throws Exception {
		return (OpnsuNttVO) selectOne("OpnsuNttCmmnDAO_selectNttDetail_S", nttVO);
	}
	
	/**
	 * ㅁ 게시물 작성자
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttNtcrId(OpnsuNttVO nttVO) throws Exception {
		return (String) selectOne("OpnsuNttCmmnDAO_selectNttNtcrId_S", nttVO);
	}	

	/**
	 * ㅁ 글양식 내용 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttFormCn(String bbsSeq) throws Exception {
		return (String) selectOne("OpnsuNttCmmnDAO_selectNttFormCn_S", bbsSeq);
	}
	
	/**
	 * ㅁ 게시물SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttSeq(OpnsuNttVO nttVO) throws Exception {
		return (String) selectOne("OpnsuNttCmmnDAO_selectNextNttSeq_S", nttVO.getSiteSeq());
	}
	
	/**
	 * ㅁ 게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttInfo(OpnsuNttVO nttVO) throws Exception {
		
		int result = 0;
		
		// 게시물 정보 등록
		result = update("OpnsuNttCmmnDAO_registNttInfo_I", nttVO);
		
		if(result > 0){
			// 게시물 부가정보 등록
			update("OpnsuNttCmmnDAO_registNttAdiInfo_I", nttVO);
		}
		
		return result;
	}

	
	/**
	 * ㅁ 게시물 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttInfo(OpnsuNttVO nttVO) throws Exception {
		int result = 0;
		
		// 게시물 정보 수정
		result = update("OpnsuNttCmmnDAO_modifyNttInfo_U", nttVO);
		
		if(result > 0){
			// 게시물 부가정보 수정
			update("OpnsuNttCmmnDAO_modifyNttAdiInfo_U", nttVO);
		}
		
		return result;
	}
	
	/**
	 * ㅁ 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttInfo(OpnsuNttVO nttVO) throws Exception {
		return delete("OpnsuNttCmmnDAO_deleteNttInfo_D", nttVO);
	}
	
	/**
	 * ㅁ 게시물 말머리 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyCheckNttSubospec(OpnsuNttVO nttVO) throws Exception {
		return update("OpnsuNttCmmnDAO_modifyCheckNttSubospec_U", nttVO);
	}
	
	/**
	 * ㅁ 게시물 이동 - 게시판 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttMvmnBbsList(OpnsuNttVO nttVO) throws Exception {
		return selectList("OpnsuNttCmmnDAO_selectNttMvmnBbsList_S", nttVO);
	}
	
	/**
	 * ㅁ 게시물 이동
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer mvmnNtt(OpnsuNttVO nttVO) throws Exception {
		return update("OpnsuNttCmmnDAO_mvmnNtt_U", nttVO);
	}
	
}
