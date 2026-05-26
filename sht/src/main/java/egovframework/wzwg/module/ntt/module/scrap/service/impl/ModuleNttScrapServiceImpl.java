package egovframework.wzwg.module.ntt.module.scrap.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.module.scrap.service.ModuleNttScrapService;
import egovframework.wzwg.module.ntt.module.scrap.service.ModuleNttScrapVO;



@Service("ModuleNttScrapService")
public class ModuleNttScrapServiceImpl extends EgovAbstractServiceImpl implements ModuleNttScrapService {

	@Resource(name="ModuleNttScrapDAO")
    protected ModuleNttScrapDAO nttScrapDAO;
	
	
	/**
	 * ㅁ 게시물  스크랩 그룹 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttScrapVO> selectNttScrapgroupList(ModuleNttScrapVO vo) throws Exception {
		return nttScrapDAO.selectNttScrapgroupList(vo);
	}
	
	/**
	 * ㅁ 게시물  스크랩 그룹명 중복체크
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttScrapgroupDplctChk(ModuleNttScrapVO vo) throws Exception {
		return nttScrapDAO.selectNttScrapgroupDplctChk(vo);
	}
	
	/**
	 * ㅁ 게시물  스크랩 그룹 SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttScrapgroupSeq() throws Exception {
		return nttScrapDAO.selectNextNttScrapgroupSeq();
	}
	
	/**
	 * ㅁ 게시물  스크랩 그룹 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttScrapgroup(ModuleNttScrapVO vo) throws Exception {
		return nttScrapDAO.registNttScrapgroup(vo);
	}
	
	/**
	 * ㅁ 게시물  스크랩 그룹 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttScrapgroup(ModuleNttScrapVO vo) throws Exception {
		return nttScrapDAO.deleteNttScrapgroup(vo);
	}
	
	/**
	 * ㅁ 게시물  스크랩  중복체크
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttScrapDplctChk(ModuleNttScrapVO vo) throws Exception {
		return nttScrapDAO.selectNttScrapDplctChk(vo);
	}
	
	/**
	 * ㅁ 게시물 스크랩SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttScrapSeq() throws Exception {
		return nttScrapDAO.selectNextNttScrapSeq();
	}
	
	/**
	 * ㅁ 게시물  스크랩
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttScrap(ModuleNttScrapVO vo) throws Exception {
		return nttScrapDAO.registNttScrap(vo);
	}
	
	/**
	 * ㅁ 게시물  스크랩 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttScrap(ModuleNttScrapVO vo) throws Exception {
		return nttScrapDAO.deleteNttScrap(vo);
	}

	/**
	 * ㅁ 게시물 스크랩 선택 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteCheckNttScrap(ModuleNttScrapVO vo) throws Exception {
		
		String checkNttSeq = StringUtils.defaultString(vo.getCheckNttSeq());
		
		if(!"".equals(checkNttSeq)) {
			checkNttSeq = vo.getCheckNttSeq().substring(0, vo.getCheckNttSeq().length()-1);
			vo.setDynamicArr(checkNttSeq.split(","));
		}
		
		return nttScrapDAO.deleteNttScrap(vo);
	}

	/**
	 * ㅁ 게시물 스크랩 삭제 SEQ
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttScrapSeq(ModuleNttVO vo) throws Exception {
		return (nttScrapDAO.selectNttScrapSeq(vo));
	}
	
	
}
