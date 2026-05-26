package egovframework.wzwg.module.beffatPlbc.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.wzwg.module.beffatPlbc.service.ModuleBeffatPlbcVO;


@Repository("ModuleBeffatPlbcDAO")
public class ModuleBeffatPlbcDAO extends EgovAbstractMapper{
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	/**
	 * 사전정보공표 카테고리 초기화
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public void initCtgryList(ModuleBeffatPlbcVO paramVO) throws Exception{
		ModuleBeffatPlbcVO checkParam = new ModuleBeffatPlbcVO();
		checkParam.setSiteSeq(paramVO.getSiteSeq());
		checkParam.setCtgryCd("ALL");
		ModuleBeffatPlbcVO resultVO = selectCtgryData(checkParam);
		
		if(resultVO == null || resultVO.getCtgryCd() == null || resultVO.getCtgryCd().equals("")) {
			checkParam.setCtgryDcCn(egovMessageSource.getMessage("wzwg.cmm.msg.MSG498"));
			checkParam.setFrstRegisterId("SYSTEM");
			checkParam.setLastUpdusrId("SYSTEM");
			registCtgryList(checkParam);
		}
	}
	
	/**
	 * 사전정보공표 카테고리 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<ModuleBeffatPlbcVO> selectCtgryList(ModuleBeffatPlbcVO paramVO) throws Exception{
		return selectList("ModuleBeffatPlbcDAO_selectCtgryList", paramVO);
	}
	
	/**
	 * 사전정보공표 카테고리 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registCtgryList(ModuleBeffatPlbcVO paramVO) throws Exception{
		return update("ModuleBeffatPlbcDAO_registCtgryList", paramVO);
	}
	
	/**
	 * 사전정보공표 카테고리 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public ModuleBeffatPlbcVO selectCtgryData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return (ModuleBeffatPlbcVO) selectOne("ModuleBeffatPlbcDAO_selectCtgryData", paramVO); 
	}
	
	/**
	 * 사전정보공표 카테고리 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyCtgryList(ModuleBeffatPlbcVO paramVO) throws Exception{
		return update("ModuleBeffatPlbcDAO_modifyCtgryList", paramVO);
	}
	
	/**
	 * 사전정보공표 카테고리 조회(낮은순번)
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public ModuleBeffatPlbcVO selectCtgrySortDownData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return (ModuleBeffatPlbcVO) selectOne("ModuleBeffatPlbcDAO_selectCtgrySortDownData", paramVO); 
	}
	
	/**
	 * 사전정보공표 카테고리 조회(높은순번)
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public ModuleBeffatPlbcVO selectCtgrySortUpData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return (ModuleBeffatPlbcVO) selectOne("ModuleBeffatPlbcDAO_selectCtgrySortUpData", paramVO); 
	}
	
	/**
	 * 사전정보공표 카테고리 순번저장
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyCtgrSortSn(ModuleBeffatPlbcVO paramVO) throws Exception{
		return update("ModuleBeffatPlbcDAO_modifyCtgrSortSn", paramVO);
	}
	
	/**
	 * 사전정보공표 카테고리 정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteCtgryData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return update("ModuleBeffatPlbcDAO_deleteCtgryData_U", paramVO);
	}
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 사전정보공표 데이터 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registBeffatPlbcData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return update("ModuleBeffatPlbcDAO_registBeffatPlbcData", paramVO);
	}
	
	/**
	 * 사전정보공표 메인데이터 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<ModuleBeffatPlbcVO> selectBeffatPlbcMainList(ModuleBeffatPlbcVO paramVO) throws Exception{
		return selectList("ModuleBeffatPlbcDAO_selectBeffatPlbcMainList", paramVO);
	}
	
	/**
	 * 사전정보공표 메인데이터 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public ModuleBeffatPlbcVO selectBeffatPlbcMainData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return (ModuleBeffatPlbcVO) selectOne("ModuleBeffatPlbcDAO_selectBeffatPlbcMainData", paramVO);
	}
	
	/**
	 * 사전정보공표 데이터 퀵메뉴 등록/해제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyBeffatPlbcMainQkMenu(ModuleBeffatPlbcVO paramVO) throws Exception{
		return update("ModuleBeffatPlbcDAO_modifyBeffatPlbcMainQkMenu", paramVO);
	}
	
	/**
	 * 사전정보공표 데이터 조회(낮은순번)
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public ModuleBeffatPlbcVO selectBeffatPlbcMainSortDownData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return (ModuleBeffatPlbcVO) selectOne("ModuleBeffatPlbcDAO_selectBeffatPlbcMainSortDownData", paramVO); 
	}
	
	/**
	 * 사전정보공표 데이터 조회(높은순번)
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public ModuleBeffatPlbcVO selectBeffatPlbcMainSortUpData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return (ModuleBeffatPlbcVO) selectOne("ModuleBeffatPlbcDAO_selectBeffatPlbcMainSortUpData", paramVO); 
	}
	
	/**
	 * 사전정보공표 데이터 순번저장
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyBeffatPlbcMainSortSn(ModuleBeffatPlbcVO paramVO) throws Exception{
		return update("ModuleBeffatPlbcDAO_modifyBeffatPlbcMainSortSn", paramVO);
	}
	
	/**
	 * 사전정보공표 메인데이터 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyBeffatPlbcMainData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return update("ModuleBeffatPlbcDAO_modifyBeffatPlbcMainData", paramVO);
	}
	
	/**
	 * 사전정보공표 메인데이터 삭제(업데이트)
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteBeffatPlbcMainData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return update("ModuleBeffatPlbcDAO_deleteBeffatPlbcMainData_U", paramVO);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 사전정보공표 서브 데이터 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registBeffatPlbcSubData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return update("ModuleBeffatPlbcDAO_registBeffatPlbcSubData", paramVO);
	}
	
	/**
	 * 사전정보공표 서브 데이터 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<ModuleBeffatPlbcVO> selectBeffatPlbcSubList(ModuleBeffatPlbcVO paramVO) throws Exception{
		return selectList("ModuleBeffatPlbcDAO_selectBeffatPlbcSubList", paramVO);
	}
	
	/**
	 * 사전정보공표 서브 데이터 목록 개수
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public String selectBeffatPlbcSubTotalCount(ModuleBeffatPlbcVO paramVO) throws Exception{
		return (String) selectOne("ModuleBeffatPlbcDAO_selectBeffatPlbcSubTotalCount", paramVO);
	}
	
	/**
	 * 사전정보공표 서브 데이터 상세 데이터 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public ModuleBeffatPlbcVO selectBeffatPlbcSubData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return (ModuleBeffatPlbcVO) selectOne("ModuleBeffatPlbcDAO_selectBeffatPlbcSubData", paramVO);
	}
	
	/**
	 * 사전정보공표 서브 데이터 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyBeffatPlbcSubData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return update("ModuleBeffatPlbcDAO_modifyBeffatPlbcSubData", paramVO);
	}
	
	/**
	 * 사전정보공표 서브 데이터 삭제(업데이트)
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteBeffatPlbcSubData(ModuleBeffatPlbcVO paramVO) throws Exception{
		return update("ModuleBeffatPlbcDAO_deleteBeffatPlbcSubData_U", paramVO);
	}
}
