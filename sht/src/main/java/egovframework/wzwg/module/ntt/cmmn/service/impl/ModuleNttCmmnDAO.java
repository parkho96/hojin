package egovframework.wzwg.module.ntt.cmmn.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.mvp.service.ModuleNttMvpVO;


@Repository("ModuleNttCmmnDAO")

public class ModuleNttCmmnDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 조회수 증가
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void modifyNttInqireCnt(ModuleNttVO nttVO) throws Exception {
		update("ModuleNttCmmnDAO_modifyNttInqireCnt_U", nttVO);
	}
	
	/**
	 * ㅁ 게시물 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttVO selectNttDetail(ModuleNttVO nttVO) throws Exception {
		return (ModuleNttVO) selectOne("ModuleNttCmmnDAO_selectNttDetail_S", nttVO);
	}
	
	/**
	 * ㅁ 게시물 작성자
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttNtcrId(ModuleNttVO nttVO) throws Exception {
		return (String) selectOne("ModuleNttCmmnDAO_selectNttNtcrId_S", nttVO);
	}
	
	/**
	 * ㅁ 동영상 게시판 게시물 작성자
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public String selectNttMvpNtcrId(ModuleNttMvpVO nttVO) throws Exception {
		return (String) selectOne("ModuleNttCmmnDAO_selectNttMvpNtcrId_S", nttVO);
	}	

	/**
	 * ㅁ 글양식 내용 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttFormCn(String bbsSeq) throws Exception {
		return (String) selectOne("ModuleNttCmmnDAO_selectNttFormCn_S", bbsSeq);
	}
	
	/**
	 * ㅁ 게시물SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttSeq(ModuleNttVO nttVO) throws Exception {
		return (String) selectOne("ModuleNttCmmnDAO_selectNextNttSeq_S", nttVO.getSiteSeq());
	}
	
	/**
	 * ㅁ 게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttInfo(ModuleNttVO nttVO) throws Exception {
		
		int result = 0;
		
		// 게시물 정보 등록
		result = update("ModuleNttCmmnDAO_registNttInfo_I", nttVO);
		
		if(result > 0){
			// 게시물 부가정보 등록
			update("ModuleNttCmmnDAO_registNttAdiInfo_I", nttVO);
		}
		
		String tmprnttSeq = StringUtils.defaultString(nttVO.getTmprnttSeq());
		
		if(!"".equals(tmprnttSeq)){
			// 임시게시물 삭제
			deleteTmprnttInfo(nttVO);
		}
		
		return result;
	}
	
	/**
	 * ㅁ 임시 게시물SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextTmprnttSeq() throws Exception {
		return (String) selectOne("ModuleNttCmmnDAO_selectNextTmprnttSeq_S", new String()); 
	}
	
	/**
	 * ㅁ 게시물 임시저장
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registTmprnttInfo(ModuleNttVO nttVO) throws Exception {
		
		int result = 0;
		
		// 임시게시물 정보 등록
		result = update("ModuleNttCmmnDAO_registTmprnttInfo_I", nttVO);
		
		if(result > 0){
			// 임시게시물 부가정보 등록
			update("ModuleNttCmmnDAO_registTmprnttAdiInfo_I", nttVO);
		}
		
		return result;
	}
	
	/**
	 * ㅁ 게시물 임시저장 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyTmprnttInfo(ModuleNttVO nttVO) throws Exception {
		int result = 0;
		
		// 임시게시물 정보 수정
		result = update("ModuleNttCmmnDAO_modifyTmprnttInfo_I", nttVO);
		
		if(result > 0){
			// 임시게시물 부가정보 수정
			update("ModuleNttCmmnDAO_modifyTmprnttAdiInfo_I", nttVO);
		}
		
		return result;
	}
	
	/**
	 * ㅁ 임시게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteTmprnttInfo(ModuleNttVO nttVO) throws Exception {
		int result = 0;
		
		// 임시게시물 부가정보 삭제
		result = delete("ModuleNttCmmnDAO_deleteTmprnttAdiInfo_D", nttVO);
		
		if(result > 0){
			// 임시게시물 정보 삭제
			result = delete("ModuleNttCmmnDAO_deleteTmprnttInfo_D", nttVO);
		}
		
		return result;
	}
	
	/**
	 * ㅁ 임시게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectTmprnttList(ModuleNttVO nttVO) throws Exception {
		return selectList("ModuleNttCmmnDAO_selectTmprnttList_S", nttVO);
	}
	
	/**
	 * ㅁ 임시게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectTmprnttListTotCnt(ModuleNttVO nttVO) throws Exception {
		return (Integer) selectOne("ModuleNttCmmnDAO_selectTmprnttListTotCnt_S", nttVO);
	}
	
	/**
	 * ㅁ 임시게시물 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttVO selectTmprnttDetail(String searchTmprnttSeq) throws Exception {
		return (ModuleNttVO) selectOne("ModuleNttCmmnDAO_selectTmprnttDetail_S", searchTmprnttSeq);
	}
	
	/**
	 * ㅁ 게시물 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttInfo(ModuleNttVO nttVO) throws Exception {
		int result = 0;
		
		// 게시물 정보 수정
		result = update("ModuleNttCmmnDAO_modifyNttInfo_U", nttVO);
		
		if(result > 0){
			// 게시물 부가정보 수정
			update("ModuleNttCmmnDAO_modifyNttAdiInfo_U", nttVO);
		}
		
		String tmprnttSeq = StringUtils.defaultString(nttVO.getTmprnttSeq());
		
		if(!"".equals(tmprnttSeq)){
			// 임시게시물 삭제
			deleteTmprnttInfo(nttVO);
		}
		
		return result;
	}
	
	/**
	 * ㅁ 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttInfo(ModuleNttVO nttVO) throws Exception {
		
		delete("ModuleNttCmmnDAO_deleteFile_D", nttVO);	// 첨부파일 삭제 처리
		
		return delete("ModuleNttCmmnDAO_deleteNttInfo_D", nttVO);
	}
	
	/**
	 * ㅁ 게시물 말머리 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyCheckNttSubospec(ModuleNttVO nttVO) throws Exception {
		return update("ModuleNttCmmnDAO_modifyCheckNttSubospec_U", nttVO);
	}
	
	/**
	 * ㅁ 게시물 이동 - 게시판 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttMvmnBbsList(ModuleNttVO nttVO) throws Exception {
		
		nttVO.setModuleMethodNcnm((String) selectOne("ModuleNttCmmnDAO_selectNttMvmnBbsMethod_S", nttVO));
		
		return selectList("ModuleNttCmmnDAO_selectNttMvmnBbsList_S", nttVO);
	}
	
	/**
	 * ㅁ 게시물 이동
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer mvmnNtt(ModuleNttVO nttVO) throws Exception {
		return update("ModuleNttCmmnDAO_mvmnNtt_U", nttVO);
	}
	
	/**
	 * ㅁ 게시물 좋아요 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttLike(ModuleNttVO nttVO) throws Exception {
		return selectList("ModuleNttCmmnDAO_selectNttLike_S", nttVO);
	}
	
	/**
	 * ㅁ 게시물 좋아요 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttLikeCnt(ModuleNttVO nttVO) throws Exception {
		return (Integer) selectOne("ModuleNttCmmnDAO_selectNttLikeCnt_S", nttVO);
	}
	
	/**
	 * ㅁ 게시물 좋아요
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttLike(ModuleNttVO nttVO) throws Exception {
		
		insert("ModuleNttCmmnDAO_registNttLike_I", nttVO);
		
		return selectNttLikeCnt(nttVO);
	}
	
	/**
	 * ㅁ 게시물 좋아요 취소
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttLikeCancl(ModuleNttVO nttVO) throws Exception {
		
		delete("ModuleNttCmmnDAO_deleteNttLikeCancl_D", nttVO);
		
		return selectNttLikeCnt(nttVO);
	}
	
	/**
	 * ㅁ 게시물 신고
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttSttemnt(ModuleNttVO nttVO) throws Exception {
		return update("ModuleNttCmmnDAO_registNttSttemnt_I", nttVO);
	}
	
	/**
	 * ㅁ 휴지통 복원
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttRecycle(ModuleNttVO nttVO) throws Exception {
		
		update("ModuleNttCmmnDAO_updateRecycleFile_D", nttVO);
		
		return update("ModuleNttCmmnDAO_modifyNttRecycle_U", nttVO);
	}


	/**
	 * 휴지통 - 파일상세정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteFileDetail(ModuleNttVO nttVO) throws Exception {
		
		return update("ModuleNttCmmnDAO_deleteSiteFileDetail", nttVO);
	}
	
	/**
	 * 휴지통 - 파일정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteFile(ModuleNttVO nttVO) throws Exception {
		
		return update("ModuleNttCmmnDAO_deleteSiteFile", nttVO);
	}	
	
	/**
	 * 휴지통 - 게시물 종아요 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteNttLike(ModuleNttVO nttVO) throws Exception {
		
		return update("ModuleNttCmmnDAO_deleteSiteNttLike", nttVO);
	}
	
	/**
	 * 휴지통 - 게시물 댓글 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteNttAnswer(ModuleNttVO nttVO) throws Exception {
		
		return update("ModuleNttCmmnDAO_deleteSiteNttAnswer", nttVO);
	}
 
	/**
	 * 휴지통 - 게시물 부가정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteNttAdiInfo(ModuleNttVO nttVO) throws Exception {
		
		return update("ModuleNttCmmnDAO_deleteSiteNttAdiInfo", nttVO);
	}
	    
	/**
	 * 휴지통 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteNtt(ModuleNttVO nttVO) throws Exception {
		
		return update("ModuleNttCmmnDAO_deleteSiteNtt", nttVO);
	}	
	
	/**
	 * ㅁ 공지 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttNoticeList(ModuleNttVO nttVO) throws Exception {
		return selectList("ModuleNttCmmnDAO_selectNttNoticeList_S", nttVO);
	}
	
	/**
	 * ㅁ 공지 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttNotice(ModuleNttVO nttVO) throws Exception {
		
		// 공지게시물 부가정보 수정
		update("ModuleNttCmmnDAO_modifyNttNoticeAdi_U", nttVO);
		
		// 공지게시물 기본정보 수정
		return update("ModuleNttCmmnDAO_modifyNttNotice_U", nttVO);
	}
	
	/**
	 * 첨부파일 아이디로 게시물상세 조회
	 * @param nttVO
	 * @return
	 * @throws Exception
	 */
	public ModuleNttVO selectNttDetailByAtchFileId(ModuleNttVO nttVO) throws Exception {
		return (ModuleNttVO) selectOne("ModuleNttCmmnDAO_selectNttDetail_atchFileId", nttVO);
	}
	
	/**
	 * 첨부파일 아이디로 게시물 비밀글 상태 조회
	 * @param nttVO
	 * @return
	 * @throws Exception
	 */
	public ModuleNttVO selectNttSecretAtByAtchFileId(ModuleNttVO nttVO) throws Exception {
		return (ModuleNttVO) selectOne("ModuleNttCmmnDAO_selectNttSecretAt_atchFileId", nttVO);
	}
}
