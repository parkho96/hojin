package egovframework.wzwg.module.ntt.custom.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.custom.service.ModuleNttCustomDataManageService;



@Service("ModuleNttCustomDataManageService")
public class ModuleNttCustomDataManageServiceImpl extends EgovAbstractServiceImpl implements ModuleNttCustomDataManageService {

	
	@Resource(name="ModuleNttCustomDataManageDAO")
    protected ModuleNttCustomDataManageDAO nttCmmnDAO;
	
	@Resource(name="ModuleNttCustomDataManageDAO")
    protected ModuleNttCustomDataManageDAO nttUnityDataManageDAO;
	
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttList(ModuleNttVO nttVO) throws Exception {
		return nttUnityDataManageDAO.selectNttList(nttVO);
	}
	
	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttListTotCnt(ModuleNttVO nttVO) throws Exception {
		return nttUnityDataManageDAO.selectNttListTotCnt(nttVO);
	}
    
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleNttVO> selectNttCustomScrinCntnts(ModuleNttVO nttVO) throws Exception {
        return nttUnityDataManageDAO.selectNttScrinCntnts(nttVO);
    }

	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttRecycleList(ModuleNttVO nttVO) throws Exception {
		return nttUnityDataManageDAO.selectNttRecycleList(nttVO);
	}	
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttRecycleListTotCnt(ModuleNttVO nttVO) throws Exception {
		return nttUnityDataManageDAO.selectNttRecycleListTotCnt(nttVO);
	}
	
}
