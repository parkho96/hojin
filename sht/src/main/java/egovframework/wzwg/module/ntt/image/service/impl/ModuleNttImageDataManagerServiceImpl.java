package egovframework.wzwg.module.ntt.image.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.image.service.ModuleNttImageDataManageService;
import egovframework.wzwg.module.ntt.unity.service.impl.ModuleNttUnityDataManageDAO;

@Service("ModuleNttImageDataManageService")
public class ModuleNttImageDataManagerServiceImpl extends EgovAbstractServiceImpl implements ModuleNttImageDataManageService{
	@Resource(name="ModuleNttUnityDataManageDAO")
    protected ModuleNttUnityDataManageDAO nttCmmnDAO;
	
	@Resource(name="ModuleNttImageDataManageDAO")
    protected ModuleNttImageDataManageDAO nttImageDataManageDAO;
	
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttList(ModuleNttVO nttVO) throws Exception {
		return nttImageDataManageDAO.selectNttList(nttVO);
	}
	
	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttListTotCnt(ModuleNttVO nttVO) throws Exception {
		return nttImageDataManageDAO.selectNttListTotCnt(nttVO);
	}
    
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleNttVO> selectNttScrinCntnts(ModuleNttVO nttVO) throws Exception {
        return nttImageDataManageDAO.selectNttScrinCntnts(nttVO);
    }

	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttRecycleList(ModuleNttVO nttVO) throws Exception {
		return nttImageDataManageDAO.selectNttRecycleList(nttVO);
	}	
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttRecycleListTotCnt(ModuleNttVO nttVO) throws Exception {
		return nttImageDataManageDAO.selectNttRecycleListTotCnt(nttVO);
	}
}
