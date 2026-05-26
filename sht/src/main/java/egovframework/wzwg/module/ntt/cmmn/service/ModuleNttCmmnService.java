package egovframework.wzwg.module.ntt.cmmn.service;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

import egovframework.wzwg.module.ntt.mvp.service.ModuleNttMvpVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;


public interface ModuleNttCmmnService {


	/**
	 * ㅁ 조회수 증가
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void modifyNttInqireCnt(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttVO selectNttDetail(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 작성자
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttNtcrId(ModuleNttVO nttVO) throws Exception;	
	
	
	/**
	 * ㅁ 동영상 게시판 게시물 작성자
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttMvpNtcrId(ModuleNttMvpVO nttVO) throws Exception;
	
	/**
	 * ㅁ 글양식 내용 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttFormCn(String bbsSeq) throws Exception;
	
	/**
	 * ㅁ 게시물SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttSeq(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttInfo(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 임시 게시물SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextTmprnttSeq() throws Exception;
	
	/**
	 * ㅁ 게시물 임시저장 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registTmprnttInfo(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 임시저장 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyTmprnttInfo(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 임시게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteTmprnttInfo(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 임시게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectTmprnttList(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 임시게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectTmprnttListTotCnt(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 임시게시물 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttVO selectTmprnttDetail(String searchTmprnttSeq) throws Exception;
	
	/**
	 * ㅁ 게시물 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttInfo(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttInfo(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 삭제 (체크박스 선택 목록 삭제)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteCheckNttInfo(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 말머리 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyCheckNttSubospec(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 이동 - 게시판 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttMvmnBbsList(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 이동
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer mvmnNtt(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 좋아요 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttLike(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 좋아요
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttLike(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 좋아요 취소
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttLikeCancl(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 신고
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttSttemnt(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 휴지통 복원
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttRecycle(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ  휴지통 복원 (체크박스 선택 목록 삭제)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyCheckNttRecycle(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * 휴지통 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteNtt(ModuleNttVO nttVO) throws Exception;
	
	public CntntsAuthVO selectCntntsAuthForNtt(HttpServletRequest request, String menuSeq) throws Exception;
	
	public boolean sessionMngrAuthForNtt(HttpServletRequest request) throws Exception;
	
	/**
	 * ㅁ 공지게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttNoticeList(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 공지 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttNotice(ModuleNttVO nttVO) throws Exception;
	
	
	/**
	 * 일반 게시글 본인소유 확인
	 * @param request
	 * @param nttVO
	 * @return
	 * @throws Exception
	 */
	public boolean checkOwnerPost(HttpServletRequest request, ModuleNttVO nttVO) throws Exception;
	
	/**
	 * 동영상게시판 게시글 본인소유 확인
	 * @param request
	 * @param nttMvpVO
	 * @return
	 * @throws Exception
	 */
	public boolean checkOwnerMvpPost(HttpServletRequest request, ModuleNttMvpVO nttMvpVO) throws Exception;
	
	
	/**
	 * 첨부파일 아이디로 게시물상세 조회
	 * @param nttVO
	 * @return
	 * @throws Exception
	 */
	public ModuleNttVO selectNttDetailByAtchFileId(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * 첨부파일 아이디로 게시물 비밀글 상태 조회
	 * @param nttVO
	 * @return
	 * @throws Exception
	 */
	public ModuleNttVO selectNttSecretAtByAtchFileId(ModuleNttVO nttVO) throws Exception;
}
