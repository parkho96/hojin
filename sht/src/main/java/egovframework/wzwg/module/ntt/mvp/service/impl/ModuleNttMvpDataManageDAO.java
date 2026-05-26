package egovframework.wzwg.module.ntt.mvp.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.mvp.service.ModuleNttMvpVO;


@Repository("ModuleNttMvpDataManageDAO")

public class ModuleNttMvpDataManageDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 동영상게시물SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextMvpnttSeq(ModuleNttMvpVO vo) throws Exception {
		return (String) selectOne("ModuleNttMvpDataManageDAO_selectNextMvpnttSeq_S", vo);
	}
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttMvpVO> selectNttMvpList(ModuleNttMvpVO vo) throws Exception {
		return selectList("ModuleNttMvpDataManageDAO_selectNttMvpList_S", vo);
	}
	
	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttMvpListTotCnt(ModuleNttMvpVO vo) throws Exception {
		return (Integer) selectOne("ModuleNttMvpDataManageDAO_selectNttMvpListTotCnt_S", vo);
	}
	
	/**
	 * ㅁ 게시물 목록 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttMvpVO> selectNttMvpScrinCntnts(ModuleNttMvpVO vo) throws Exception {
		return selectList("ModuleNttMvpDataManageDAO_selectNttMvpScrinCntnts_S", vo);
	}
	
	/**
	 * ㅁ 조회수 증가
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void modifyNttMvpInqireCnt(ModuleNttMvpVO nttVO) throws Exception {
		update("ModuleNttMvpDataManageDAO_modifyNttMvpInqireCnt_U", nttVO);
	}
	
	/**
	 * ㅁ 게시물 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttMvpVO selectNttMvpDetail(ModuleNttMvpVO vo) throws Exception {
		return (ModuleNttMvpVO) selectOne("ModuleNttMvpDataManageDAO_selectNttMvpDetail_S", vo);
	}
	
	/**
	 * ㅁ 게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttMvpInfo(ModuleNttMvpVO vo) throws Exception {
		return (Integer) update("ModuleNttMvpDataManageDAO_registNttMvpInfo_I", vo);
	}
	
	/**
	 * ㅁ 게시물 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttMvpInfo(ModuleNttMvpVO vo) throws Exception {
		return (Integer) update("ModuleNttMvpDataManageDAO_modifyNttMvpInfo_U", vo); 
	}
	
	/**
	 * ㅁ 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttMvpInfo(ModuleNttMvpVO vo) throws Exception {
		return (Integer) delete("ModuleNttMvpDataManageDAO_deleteNttMvpInfo_D", vo);
	}
	
	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttMvpVO> selectNttMvpRecycleList(ModuleNttMvpVO vo) throws Exception {
		return selectList("ModuleNttMvpDataManageDAO_selectNttMvpRecycleList_S", vo);
	}	
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttMvpRecycleListTotCnt(ModuleNttMvpVO vo) throws Exception {
		return (Integer) selectOne("ModuleNttMvpDataManageDAO_selectNttMvpRecycleListTotCnt_S", vo);
	}	
	
	/**
	 * ㅁ 휴지통 복원
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttMvpRecycle(ModuleNttMvpVO vo) throws Exception {
		
		update("ModuleNttMvpDataManageDAO_updateRecycleFile_D", vo);
		
		return (Integer) update("ModuleNttMvpDataManageDAO_modifyNttMvpRecycle_U", vo);
	}
	
	/**
	 * 휴지통 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer deleteSiteNttMvp(ModuleNttMvpVO vo) throws Exception {
		return (Integer) delete("ModuleNttMvpDataManageDAO_deleteSiteNttMvp_D", vo);
	}
	
	/**
	 * 휴지통 - 파일상세정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteFileDetail(ModuleNttMvpVO vo) throws Exception {
		return update("ModuleNttMvpDataManageDAO_deleteSiteFileDetail_D", vo);
	}
	
	/**
	 * 휴지통 - 파일정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteFile(ModuleNttMvpVO vo) throws Exception {
		return update("ModuleNttMvpDataManageDAO_deleteSiteFile_D", vo);
	}	
	
}
