package egovframework.wzwg.module.ntt.faq.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.faq.service.ModuleNttFaqDataManageService;



@Service("ModuleNttFaqDataManageService")
public class ModuleNttFaqDataManageServiceImpl extends EgovAbstractServiceImpl implements ModuleNttFaqDataManageService {

	
	@Resource(name="ModuleNttFaqDataManageDAO")
    protected ModuleNttFaqDataManageDAO nttCmmnDAO;
	
	@Resource(name="ModuleNttFaqDataManageDAO")
    protected ModuleNttFaqDataManageDAO nttFaqDataManageDAO;
	
	
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttList(ModuleNttVO nttVO) throws Exception {
		return nttFaqDataManageDAO.selectNttList(nttVO);
	}
	
	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttListTotCnt(ModuleNttVO nttVO) throws Exception {
		return nttFaqDataManageDAO.selectNttListTotCnt(nttVO);
	}
    
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleNttVO> selectNttFaqScrinCntnts(ModuleNttVO nttVO) throws Exception {
        return nttFaqDataManageDAO.selectNttFaqScrinCntnts(nttVO);
    }

	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttRecycleList(ModuleNttVO nttVO) throws Exception {
		return nttFaqDataManageDAO.selectNttRecycleList(nttVO);
	}	
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttRecycleListTotCnt(ModuleNttVO nttVO) throws Exception {
		return nttFaqDataManageDAO.selectNttRecycleListTotCnt(nttVO);
	}
	
}
