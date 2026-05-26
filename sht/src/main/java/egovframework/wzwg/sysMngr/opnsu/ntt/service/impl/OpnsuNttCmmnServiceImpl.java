package egovframework.wzwg.sysMngr.opnsu.ntt.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.opnsu.bbs.service.impl.OpnsuBbsCmmnDAO;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttCmmnService;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttVO;



@Service("OpnsuNttCmmnService")
public class OpnsuNttCmmnServiceImpl extends EgovAbstractServiceImpl implements OpnsuNttCmmnService {

	
	@Resource(name="OpnsuNttCmmnDAO")
    protected OpnsuNttCmmnDAO nttCmmnDAO;
	
	@Resource(name="OpnsuBbsCmmnDAO")
    protected OpnsuBbsCmmnDAO bbsCmmnDAO;

	
	
	
	/**
	 * ㅁ 조회수 증가
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void modifyNttInqireCnt(OpnsuNttVO nttVO) throws Exception {
		nttCmmnDAO.modifyNttInqireCnt(nttVO);
	}
	
	/**
	 * ㅁ 게시물 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public OpnsuNttVO selectNttDetail(OpnsuNttVO nttVO) throws Exception {
		return nttCmmnDAO.selectNttDetail(nttVO);
	}
	
	/**
	 * ㅁ 게시물 작성자
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttNtcrId(OpnsuNttVO nttVO) throws Exception {
		return nttCmmnDAO.selectNttNtcrId(nttVO);
	}	
	
	/**
	 * ㅁ 글양식 내용 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttFormCn(String bbsSeq) throws Exception {
		return nttCmmnDAO.selectNttFormCn(bbsSeq);
	}
	
	/**
	 * ㅁ 게시물SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttSeq(OpnsuNttVO nttVO) throws Exception {
		return nttCmmnDAO.selectNextNttSeq(nttVO);
	}
	
	/**
	 * ㅁ 게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttInfo(OpnsuNttVO nttVO) throws Exception {
		
		int result = 0;
		
		result = nttCmmnDAO.registNttInfo(nttVO);
		
		/*
		String tagArr = StringUtils.defaultString(nttVO.getTagArr());
		
		if(!"".equals(tagArr)){
			ModuleNttTagVO tagVO = new ModuleNttTagVO();
			tagVO.setTagArr(tagArr.split(","));
			tagVO.setSiteSeq(nttVO.getSiteSeq());
			tagVO.setUsrSeq(nttVO.getUsrSeq());
			tagVO.setNttSeq(nttVO.getNttSeq());
			tagVO.setFrstRegisterId(nttVO.getNtcrId());
			
			nttTagService.registNttTag(tagVO);
		}
		 */
		
		return result;
	}

	/**
	 * ㅁ 게시물 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttInfo(OpnsuNttVO nttVO) throws Exception {
		
		/*
		String tagArr = StringUtils.defaultString(nttVO.getTagArr());
		
		if(!"".equals(tagArr)){
			ModuleNttTagVO tagVO = new ModuleNttTagVO();
			tagVO.setTagArr(tagArr.split(","));
			tagVO.setSiteSeq(nttVO.getSiteSeq());
			tagVO.setUsrSeq(nttVO.getUsrSeq());
			tagVO.setNttSeq(nttVO.getNttSeq());
			tagVO.setFrstRegisterId(nttVO.getNtcrId());
			
			nttTagService.registNttTag(tagVO);
		}
		*/
		
		return nttCmmnDAO.modifyNttInfo(nttVO);
	}
	
	/**
	 * ㅁ 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttInfo(OpnsuNttVO nttVO) throws Exception {
		return nttCmmnDAO.deleteNttInfo(nttVO);
	}
	
	/**
	 * ㅁ 게시물 삭제 (체크박스 선택 목록 삭제)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteCheckNttInfo(OpnsuNttVO nttVO) throws Exception {
		
		String checkNttSeq = StringUtils.defaultString(nttVO.getCheckNttSeq());
		
		if(!"".equals(checkNttSeq)){
			checkNttSeq = nttVO.getCheckNttSeq().substring(0, nttVO.getCheckNttSeq().length()-1);
			nttVO.setDynamicArr(checkNttSeq.split(","));
		}
		
		return nttCmmnDAO.deleteNttInfo(nttVO);
	}
	
	/**
	 * ㅁ 게시물 말머리 수정(체크박스 수정)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyCheckNttSubospec(OpnsuNttVO nttVO) throws Exception {
		
		String checkNttSeq = StringUtils.defaultString(nttVO.getCheckNttSeq());
		
		if(!"".equals(checkNttSeq)){
			checkNttSeq = nttVO.getCheckNttSeq().substring(0, nttVO.getCheckNttSeq().length()-1);
			nttVO.setDynamicArr(checkNttSeq.split(","));
		}
		
		return nttCmmnDAO.modifyCheckNttSubospec(nttVO);
	}
	
	/**
	 * ㅁ 게시물 이동 - 게시판 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttMvmnBbsList(OpnsuNttVO nttVO) throws Exception {
		return nttCmmnDAO.selectNttMvmnBbsList(nttVO);
	}
	
	/**
	 * ㅁ 게시물 이동
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer mvmnNtt(OpnsuNttVO nttVO) throws Exception {
		String checkNttSeq = StringUtils.defaultString(nttVO.getCheckNttSeq());
		
		if(!"".equals(checkNttSeq)){
			checkNttSeq = nttVO.getCheckNttSeq().substring(0, nttVO.getCheckNttSeq().length()-1);
			nttVO.setDynamicArr(checkNttSeq.split(","));
		}
		
		return nttCmmnDAO.mvmnNtt(nttVO);
	}

}
