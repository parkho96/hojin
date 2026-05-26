package egovframework.wzwg.sysMngr.opnsu.ntt.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttQnaDataManageService;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttVO;




@Service("OpnsuNttQnaDataManageService")
public class OpnsuNttQnaDataManageServiceImpl extends EgovAbstractServiceImpl implements OpnsuNttQnaDataManageService {

	
	@Resource(name="OpnsuNttQnaDataManageDAO")
    protected OpnsuNttQnaDataManageDAO nttQnaDataManageDAO;
	
	
	/**
	 * ㅁ 상단걸기 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttNoticeList(OpnsuNttVO nttVO) throws Exception {
		return nttQnaDataManageDAO.selectNttNoticeList(nttVO);
	}
	
	/**
	 * ㅁ 상단걸기 등록 / 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttNotice(OpnsuNttVO nttVO) throws Exception {
		
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
	public int modifyNttFaq(OpnsuNttVO nttVO) throws Exception {
		
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
	public List<OpnsuNttVO> selectNttList(OpnsuNttVO nttVO) throws Exception {
		return nttQnaDataManageDAO.selectNttList(nttVO);
	}
	
	/**
	 * ㅁ 게시판 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttListTotCnt(OpnsuNttVO nttVO) throws Exception {
		return nttQnaDataManageDAO.selectNttListTotCnt(nttVO);
	}
    
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<OpnsuNttVO> selectNttScrinCntnts(OpnsuNttVO nttVO) throws Exception {
        return nttQnaDataManageDAO.selectNttScrinCntnts(nttVO);
    }

}
