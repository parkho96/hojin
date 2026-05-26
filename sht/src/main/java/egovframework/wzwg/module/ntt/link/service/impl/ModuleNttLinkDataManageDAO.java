package egovframework.wzwg.module.ntt.link.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.link.service.ModuleNttLinkVO;


@Repository("ModuleNttLinkDataManageDAO")

public class ModuleNttLinkDataManageDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 링크게시물SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextLinknttSeq(ModuleNttLinkVO vo) throws Exception {
		return (String) selectOne("ModuleNttLinkDataManageDAO_selectNextLinknttSeq_S", vo);
	}
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttLinkVO> selectNttLinkList(ModuleNttLinkVO vo) throws Exception {
		return selectList("ModuleNttLinkDataManageDAO_selectNttLinkList_S", vo);
	}
	
	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttLinkListTotCnt(ModuleNttLinkVO vo) throws Exception {
		return (Integer) selectOne("ModuleNttLinkDataManageDAO_selectNttLinkListTotCnt_S", vo);
	}
	
	/**
	 * ㅁ 게시물 목록 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttLinkVO> selectNttLinkScrinCntnts(ModuleNttLinkVO vo) throws Exception {
		return selectList("ModuleNttLinkDataManageDAO_selectNttLinkScrinCntnts_S", vo);
	}
	
	/**
	 * ㅁ 게시물 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttLinkVO selectNttLinkDetail(ModuleNttLinkVO vo) throws Exception {
		return (ModuleNttLinkVO) selectOne("ModuleNttLinkDataManageDAO_selectNttLinkDetail_S", vo);
	}
	
	/**
	 * ㅁ 게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttLinkInfo(ModuleNttLinkVO vo) throws Exception {
		return (Integer) update("ModuleNttLinkDataManageDAO_registNttLinkInfo_I", vo);
	}
	
	/**
	 * ㅁ 게시물 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttLinkInfo(ModuleNttLinkVO vo) throws Exception {
		return (Integer) update("ModuleNttLinkDataManageDAO_modifyNttLinkInfo_U", vo); 
	}
	
	/**
	 * ㅁ 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttLinkInfo(ModuleNttLinkVO vo) throws Exception {
		return (Integer) delete("ModuleNttLinkDataManageDAO_deleteNttLinkInfo_D", vo);
	}
	
	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttLinkVO> selectNttLinkRecycleList(ModuleNttLinkVO vo) throws Exception {
		return selectList("ModuleNttLinkDataManageDAO_selectNttLinkRecycleList_S", vo);
	}	
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttLinkRecycleListTotCnt(ModuleNttLinkVO vo) throws Exception {
		return (Integer) selectOne("ModuleNttLinkDataManageDAO_selectNttLinkRecycleListTotCnt_S", vo);
	}	
	
	/**
	 * ㅁ 휴지통 복원
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttLinkRecycle(ModuleNttLinkVO vo) throws Exception {
		
		update("ModuleNttLinkDataManageDAO_updateRecycleFile_D", vo);
		
		return (Integer) update("ModuleNttLinkDataManageDAO_modifyNttLinkRecycle_U", vo);
	}
	
	/**
	 * 휴지통 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer deleteSiteNttLink(ModuleNttLinkVO vo) throws Exception {
		return (Integer) delete("ModuleNttLinkDataManageDAO_deleteSiteNttLink_D", vo);
	}
	
	/**
	 * 휴지통 - 파일상세정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteFileDetail(ModuleNttLinkVO vo) throws Exception {
		return update("ModuleNttLinkDataManageDAO_deleteSiteFileDetail_D", vo);
	}
	
	/**
	 * 휴지통 - 파일정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteFile(ModuleNttLinkVO vo) throws Exception {
		return update("ModuleNttLinkDataManageDAO_deleteSiteFile_D", vo);
	}	
	
}
