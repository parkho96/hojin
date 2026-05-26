package egovframework.wzwg.module.beffatPlbc.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.beffatPlbc.service.ModuleBeffatPlbcService;
import egovframework.wzwg.module.beffatPlbc.service.ModuleBeffatPlbcVO;

@Service("ModuleBeffatPlbcService")
public class ModuleBeffatPlbcServiceImpl extends EgovAbstractServiceImpl implements ModuleBeffatPlbcService{
	@Resource(name="ModuleBeffatPlbcDAO")
	ModuleBeffatPlbcDAO moduleBeffatPlbcDAO;
	
	/**
	 * 사전정보공표 카테고리 초기화
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public void initCtgryList(ModuleBeffatPlbcVO paramVO) throws Exception{
		moduleBeffatPlbcDAO.initCtgryList(paramVO);
	}
	
	/**
	 * 사전정보공표 카테고리 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<ModuleBeffatPlbcVO> selectCtgryList(ModuleBeffatPlbcVO paramVO) throws Exception {
		return moduleBeffatPlbcDAO.selectCtgryList(paramVO);
	}
	
	/**
	 * 사전정보공표 카테고리 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registCtgryList(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.registCtgryList(paramVO);
	}
	
	/**
	 * 사전정보공표 카테고리 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public ModuleBeffatPlbcVO selectCtgryData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.selectCtgryData(paramVO);
	}
	
	/**
	 * 사전정보공표 카테고리 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyCtgryList(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.modifyCtgryList(paramVO);
	}
	
	/**
	 * 사전정보공표 카테고리 정보 낮은 순번과 변경 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyCtgrySortDown(ModuleBeffatPlbcVO paramVO) throws Exception{
		int result = 0;
		ModuleBeffatPlbcVO targetVO = moduleBeffatPlbcDAO.selectCtgrySortDownData(paramVO);
		
		if(targetVO == null) {
			return -1;
		}
		
		ModuleBeffatPlbcVO originVO = moduleBeffatPlbcDAO.selectCtgryData(paramVO);
		
		String targetSn = originVO.getSortSn(); // 원본과 대상과 교차저장
		String originSn = targetVO.getSortSn(); // 원본과 대상과 교차저장
		
		targetVO.setSortSn(targetSn);
		originVO.setSortSn(originSn);
		
		targetVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		originVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		
		targetVO.setSiteSeq(paramVO.getSiteSeq());
		originVO.setSiteSeq(paramVO.getSiteSeq());
		
		result += moduleBeffatPlbcDAO.modifyCtgrSortSn(targetVO);
		result += moduleBeffatPlbcDAO.modifyCtgrSortSn(originVO);
		
		return result;
	}
	
	/**
	 * 사전정보공표 카테고리 정보 높은 순번과 변경 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyCtgrySortUp(ModuleBeffatPlbcVO paramVO) throws Exception{
		int result = 0;
		ModuleBeffatPlbcVO targetVO = moduleBeffatPlbcDAO.selectCtgrySortUpData(paramVO);
		
		if(targetVO == null) {
			return -1;
		}
		
		ModuleBeffatPlbcVO originVO = moduleBeffatPlbcDAO.selectCtgryData(paramVO);
		
		String targetSn = originVO.getSortSn(); // 원본과 대상과 교차저장
		String originSn = targetVO.getSortSn(); // 원본과 대상과 교차저장
		
		targetVO.setSortSn(targetSn);
		originVO.setSortSn(originSn);
		
		targetVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		originVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		
		targetVO.setSiteSeq(paramVO.getSiteSeq());
		originVO.setSiteSeq(paramVO.getSiteSeq());
		
		result += moduleBeffatPlbcDAO.modifyCtgrSortSn(targetVO);
		result += moduleBeffatPlbcDAO.modifyCtgrSortSn(originVO);
		
		return result;
	}
	
	/**
	 * 사전정보공표 카테고리 정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteCtgryData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.deleteCtgryData(paramVO);
		//int result = kModuleBeffatPlbcDAO.deleteCtgryData(paramVO);
		//if(result > -1) {
		//	kModuleBeffatPlbcDAO.deleteBeffatPlbcMainCtgry(paramVO);
		//}
		//return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 사전정보공표 데이터 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registBeffatPlbcData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.registBeffatPlbcData(paramVO);
	}
	
	/**
	 * 사전정보공표 메인데이터 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<ModuleBeffatPlbcVO> selectBeffatPlbcMainList(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.selectBeffatPlbcMainList(paramVO);
	}
	
	/**
	 * 사전정보공표 메인데이터 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public ModuleBeffatPlbcVO selectBeffatPlbcMainData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.selectBeffatPlbcMainData(paramVO);
	}
	
	/**
	 * 사전정보공표 메인데이터 정보 낮은 순번과 변경 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyBeffatPlbcMainSortDown(ModuleBeffatPlbcVO paramVO) throws Exception{
		int result = 0;
		ModuleBeffatPlbcVO originVO = moduleBeffatPlbcDAO.selectBeffatPlbcMainData(paramVO);
		originVO.setSiteSeq(paramVO.getSiteSeq());
		
		ModuleBeffatPlbcVO targetVO = moduleBeffatPlbcDAO.selectBeffatPlbcMainSortDownData(originVO);
		
		if(targetVO == null) {
			return -1;
		}
		
		
		String targetSn = originVO.getSortSn(); // 원본과 대상과 교차저장
		String originSn = targetVO.getSortSn(); // 원본과 대상과 교차저장
		
		targetVO.setSortSn(targetSn);
		originVO.setSortSn(originSn);
		
		targetVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		originVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		
		targetVO.setSiteSeq(paramVO.getSiteSeq());
		originVO.setSiteSeq(paramVO.getSiteSeq());
		
		result += moduleBeffatPlbcDAO.modifyBeffatPlbcMainSortSn(targetVO);
		result += moduleBeffatPlbcDAO.modifyBeffatPlbcMainSortSn(originVO);
		
		return result;
	}
	
	/**
	 * 사전정보공표 메인데이터 정보 높은 순번과 변경 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyBeffatPlbcMainSortUp(ModuleBeffatPlbcVO paramVO) throws Exception{
		int result = 0;
		ModuleBeffatPlbcVO originVO = moduleBeffatPlbcDAO.selectBeffatPlbcMainData(paramVO);
		originVO.setSiteSeq(paramVO.getSiteSeq());

		ModuleBeffatPlbcVO targetVO = moduleBeffatPlbcDAO.selectBeffatPlbcMainSortUpData(originVO);
		
		if(targetVO == null) {
			return -1;
		}
		
		
		String targetSn = originVO.getSortSn(); // 원본과 대상과 교차저장
		String originSn = targetVO.getSortSn(); // 원본과 대상과 교차저장
		
		targetVO.setSortSn(targetSn);
		originVO.setSortSn(originSn);
		
		targetVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		originVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		
		targetVO.setSiteSeq(paramVO.getSiteSeq());
		originVO.setSiteSeq(paramVO.getSiteSeq());
		
		result += moduleBeffatPlbcDAO.modifyBeffatPlbcMainSortSn(targetVO);
		result += moduleBeffatPlbcDAO.modifyBeffatPlbcMainSortSn(originVO);
		
		return result;
	}
	
	/**
	 * 사전정보공표 데이터 퀵메뉴 등록/해제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyBeffatPlbcMainQkMenu(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.modifyBeffatPlbcMainQkMenu(paramVO);
	}
	
	/**
	 * 사전정보공표 메인데이터 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyBeffatPlbcMainData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.modifyBeffatPlbcMainData(paramVO);
	}
	
	/**
	 * 사전정보공표 메인데이터 삭제(업데이트)
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteBeffatPlbcMainData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.deleteBeffatPlbcMainData(paramVO);
	}
	
	
	
	
	
	
	/**
	 * 사전정보공표 서브 데이터 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registBeffatPlbcSubData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.registBeffatPlbcSubData(paramVO);
	}
	
	/**
	 * 사전정보공표 서브 데이터 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<ModuleBeffatPlbcVO> selectBeffatPlbcSubList(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.selectBeffatPlbcSubList(paramVO);
	}
	
	/**
	 * 사전정보공표 서브 데이터 목록 개수
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public String selectBeffatPlbcSubTotalCount(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.selectBeffatPlbcSubTotalCount(paramVO);
	}
	
	/**
	 * 사전정보공표 서브 데이터 상세 데이터 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public ModuleBeffatPlbcVO selectBeffatPlbcSubData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.selectBeffatPlbcSubData(paramVO);
	}
	
	/**
	 * 사전정보공표 서브 데이터 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyBeffatPlbcSubData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.modifyBeffatPlbcSubData(paramVO);
	}
	
	/**
	 * 사전정보공표 서브 데이터 삭제(업데이트)
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteBeffatPlbcSubData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return moduleBeffatPlbcDAO.deleteBeffatPlbcSubData(paramVO);
	}
}
