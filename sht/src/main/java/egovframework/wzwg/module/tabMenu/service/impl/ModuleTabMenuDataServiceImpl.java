package egovframework.wzwg.module.tabMenu.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.tabMenu.service.ModuleTabMenuDataService;
import egovframework.wzwg.module.tabMenu.service.ModuleTabMenuDataVO;

@Service("ModuleTabMenuDataService")
public class ModuleTabMenuDataServiceImpl extends EgovAbstractServiceImpl implements ModuleTabMenuDataService{

	@Resource(name="ModuleTabMenuDataDAO")
	ModuleTabMenuDataDAO tabMenuDataDAO;
	
	/**
	 * ㅁ 탭 메뉴 데이터 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleTabMenuDataVO> selectTabMenuDataList(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		return tabMenuDataDAO.selectTabMenuDataList(tabMenuDataVO);
	}
	
	/**
	 * ㅁ 탭 메뉴 데이터 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectTabMenuDataTotCnt(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		return tabMenuDataDAO.selectTabMenuDataListTotCnt(tabMenuDataVO);
	}
    
    /**
     * ㅁ 탭 메뉴 데이터 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleTabMenuDataVO> selectTabMenuScrinCntnts(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
    	return tabMenuDataDAO.selectTabMenuScrinCntnts(tabMenuDataVO);
    }
	
	/**
	 * ㅁ 탭 메뉴 데이터 순서 변경
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer modifyTabMenuDataListOrdr(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		return tabMenuDataDAO.modifyTabMenuListOrdr(tabMenuDataVO);
	}
	
	
	
	
	
	
	
	
	
	
	/**
	 * ㅁ 탭 메뉴 데이터 SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextTabMenuDataSeq(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		return tabMenuDataDAO.selectNextTabMenuDataSeq(tabMenuDataVO);
	}
	
	/**
	 * ㅁ 탭 메뉴 데이터 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registTabMenuData(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		return tabMenuDataDAO.registTabMenuData(tabMenuDataVO);
	}
	
	/**
	 * ㅁ 탭 메뉴 데이터 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer modifyTabMenuData(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		return tabMenuDataDAO.modifyTabMenuData(tabMenuDataVO);
	}
	
	/**
	 * ㅁ 탭 메뉴 데이터 상세조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleTabMenuDataVO selectTabMenuDataDetail(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		return tabMenuDataDAO.selectTabMenuDataDetail(tabMenuDataVO);
	}
	
	/**
	 * ㅁ 탭 메뉴 데이터 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer deleteTabMenuData(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		return tabMenuDataDAO.deleteTabMenuData(tabMenuDataVO);
	}
	
	/**
	 * ㅁ 탭 메뉴 데이터 순서변경
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer modifyTabDataListOrdr(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		return tabMenuDataDAO.modifyTabDataListOrdr(tabMenuDataVO);
	}
}
