package egovframework.wzwg.module.ntt.module.sttemnt.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.module.sttemnt.service.ModuleNttSttemntVO;


@Repository("ModuleNttSttemntDAO")
public class ModuleNttSttemntDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 게시물 신고SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttSttemntSeq() throws Exception {
		return (String) selectOne("ModuleNttSttemntDAO_selectNextNttSttemntSeq_S", new String());
	}
	
	/**
	 * ㅁ 게시물 신고
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttSttemnt(ModuleNttSttemntVO nttSttemntVO) throws Exception {
		return update("ModuleNttSttemntDAO_registNttSttemnt_I", nttSttemntVO);
	}
	
}
