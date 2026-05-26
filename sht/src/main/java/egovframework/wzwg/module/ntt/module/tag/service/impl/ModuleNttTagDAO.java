package egovframework.wzwg.module.ntt.module.tag.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.module.tag.service.ModuleNttTagVO;


@Repository("ModuleNttTagDAO")

public class ModuleNttTagDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 사용자 태그 중복여부
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String getDplctTeg(ModuleNttTagVO tagVO) throws Exception {
		return (String) selectOne("ModuleNttTagDAO_getDplctTeg_S", tagVO);
	}
	
	/**
	 * ㅁ 태그SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttTagSeq() throws Exception {
		return (String) selectOne("ModuleNttTagDAO_selectNextNttTagSeq_S", new String());
	}
	
	/**
	 * ㅁ 사용자태그등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void registUsrTag(ModuleNttTagVO tagVO) throws Exception {
		insert("ModuleNttTagDAO_registUsrTag_I", tagVO);
	}
	
	/**
	 * ㅁ 게시물 태그등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttTag(ModuleNttTagVO tagVO) throws Exception {
		return update("ModuleNttTagDAO_registNttTag_I", tagVO);
	}
	
	/**
	 * ㅁ 게시물 태그 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttTagVO> selectNttTagList(ModuleNttTagVO tagVO) throws Exception {
		return selectList("ModuleNttTagDAO_selectNttTagList_S", tagVO);
	}
	
	/**
	 * ㅁ 게시물 나의 태그 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttTagVO> selectNttUsrTagList(ModuleNttTagVO tagVO) throws Exception {
		return selectList("ModuleNttTagDAO_selectNttUsrTagList_S", tagVO);
	}
	
	/**
	 * ㅁ 태그 수정 시 사용여부 체크
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttTagDplct(ModuleNttTagVO tagVO) throws Exception {
		return (Integer) selectOne("ModuleNttTagDAO_selectNttTagDplct_S", tagVO);
	}
	
	/**
	 * ㅁ 사용자 태그 수정(삭제)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int updateUsrTag(ModuleNttTagVO tagVO) throws Exception {
		return update("ModuleNttTagDAO_updateUsrTag_U", tagVO);
	}
	
	/**
	 * ㅁ 게시물 태그 수정(삭제)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int updateNttTag(ModuleNttTagVO tagVO) throws Exception {
		return delete("ModuleNttTagDAO_updateNttTag_U", tagVO);
	}
	
}
