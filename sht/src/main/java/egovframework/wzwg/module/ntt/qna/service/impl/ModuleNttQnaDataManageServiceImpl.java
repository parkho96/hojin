package egovframework.wzwg.module.ntt.qna.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.qna.service.ModuleNttQnaDataManageService;



@Service("ModuleNttQnaDataManageService")
public class ModuleNttQnaDataManageServiceImpl extends EgovAbstractServiceImpl implements ModuleNttQnaDataManageService {

	
	@Resource(name="ModuleNttQnaDataManageDAO")
    protected ModuleNttQnaDataManageDAO nttQnaDataManageDAO;
	
	
	/**
	 * ㅁ 상단걸기 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttNoticeList(ModuleNttVO nttVO) throws Exception {
		return nttQnaDataManageDAO.selectNttNoticeList(nttVO);
	}
	
	/**
	 * ㅁ 상단걸기 등록 / 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttNotice(ModuleNttVO nttVO) throws Exception {
		
		String checkNttSeq = StringUtils.defaultString(nttVO.getCheckNttSeq());
		
		if(!"".equals(checkNttSeq)){
			checkNttSeq = nttVO.getCheckNttSeq().substring(0, nttVO.getCheckNttSeq().length()-1);
			nttVO.setDynamicArr(checkNttSeq.split(","));
		}
		
		return nttQnaDataManageDAO.modifyNttNotice(nttVO);
	}
	
	/**
	 * ㅁ 자주묻는질문 등록 / 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttFaq(ModuleNttVO nttVO) throws Exception {
		
		String checkNttSeq = StringUtils.defaultString(nttVO.getCheckNttSeq());
		
		if(!"".equals(checkNttSeq)){
			checkNttSeq = nttVO.getCheckNttSeq().substring(0, nttVO.getCheckNttSeq().length()-1);
			nttVO.setDynamicArr(checkNttSeq.split(","));
		}
		
		return nttQnaDataManageDAO.modifyNttFaq(nttVO);
	}
	
	/**
	 * ㅁ 게시판 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttList(ModuleNttVO nttVO) throws Exception {
		return nttQnaDataManageDAO.selectNttList(nttVO);
	}
	
	/**
	 * ㅁ 게시판 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttListTotCnt(ModuleNttVO nttVO) throws Exception {
		return nttQnaDataManageDAO.selectNttListTotCnt(nttVO);
	}
    
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleNttVO> selectNttScrinCntnts(ModuleNttVO nttVO) throws Exception {
        return nttQnaDataManageDAO.selectNttList(nttVO);
    }
	
	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttRecycleList(ModuleNttVO nttVO) throws Exception {
		return nttQnaDataManageDAO.selectNttRecycleList(nttVO);
	}
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttRecycleListTotCnt(ModuleNttVO nttVO) throws Exception {
		return (Integer) nttQnaDataManageDAO.selectNttRecycleListTotCnt(nttVO);
	}	
}
