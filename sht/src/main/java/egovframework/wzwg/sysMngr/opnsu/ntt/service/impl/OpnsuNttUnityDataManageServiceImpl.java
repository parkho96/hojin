package egovframework.wzwg.sysMngr.opnsu.ntt.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttUnityDataManageService;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttVO;



@Service("OpnsuNttUnityDataManageService")
public class OpnsuNttUnityDataManageServiceImpl extends EgovAbstractServiceImpl implements OpnsuNttUnityDataManageService {

	
	@Resource(name="OpnsuNttCmmnDAO")
    protected OpnsuNttCmmnDAO nttCmmnDAO;
	
	@Resource(name="OpnsuNttUnityDataManageDAO")
    protected OpnsuNttUnityDataManageDAO nttUnityDataManageDAO;
	
	
	/**
	 * ㅁ 공지 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttNoticeList(OpnsuNttVO nttVO) throws Exception {
		return nttUnityDataManageDAO.selectNttNoticeList(nttVO);
	}
	
	/**
	 * ㅁ 공지 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttNotice(OpnsuNttVO nttVO) throws Exception {
		return nttUnityDataManageDAO.modifyNttNotice(nttVO);
	}
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttList(OpnsuNttVO nttVO) throws Exception {
		return nttUnityDataManageDAO.selectNttList(nttVO);
	}
	
	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttListTotCnt(OpnsuNttVO nttVO) throws Exception {
		return nttUnityDataManageDAO.selectNttListTotCnt(nttVO);
	}
    
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<OpnsuNttVO> selectNttScrinCntnts(OpnsuNttVO nttVO) throws Exception {
        return nttUnityDataManageDAO.selectNttScrinCntnts(nttVO);
    }

}
