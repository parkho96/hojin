package egovframework.wzwg.module.tabMenu.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.tabMenu.service.ModuleTabMenuDataVO;

@Repository("ModuleTabMenuDataDAO")
public class ModuleTabMenuDataDAO extends EgovAbstractMapper {
	
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleTabMenuDataVO> selectTabMenuDataList(ModuleTabMenuDataVO tabMenuDataVO) throws Exception {
		return selectList("ModuleTabMenuDataDAO_selectTabMenuDataList_S", tabMenuDataVO);
	}
	
	
	/**
	 * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleTabMenuDataVO> selectTabMenuScrinCntnts(ModuleTabMenuDataVO tabMenuDataVO) throws Exception {
		return selectList("ModuleTabMenuDataDAO_selectTabMenuDataScrinCntnts", tabMenuDataVO);
	}
	
	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectTabMenuDataListTotCnt(ModuleTabMenuDataVO tabMenuDataVO) throws Exception {
		return (Integer) selectOne("ModuleNttClDataManageDAO_selectNttListTotCnt_S", tabMenuDataVO);
	}
	
	
	/**
	 * ㅁ 분류탭 순서변경
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer modifyTabMenuListOrdr(ModuleTabMenuDataVO tabMenuDataVO) throws Exception {
		return update("ModuleNttClDataManageDAO_modifyNttListOrdr", tabMenuDataVO);
	}
	
	
	
	
	/**
	 * ㅁ 탭 메뉴 데이터 SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextTabMenuDataSeq(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		return (String) selectOne("ModuleTabMenuDataDAO_selectNextTabMenuDataSeq_S", tabMenuDataVO.getSiteSeq());
	}
	
	/**
	 * ㅁ 탭 메뉴 데이터 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registTabMenuData(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		int result = 0;
		
		// 게시물 정보 등록
		result = update("ModuleTabMenuDataDAO_registTabMenuData_I", tabMenuDataVO);
		
		//if(result > 0){
		//	// 게시물 부가정보 등록
		//	update("ModuleNttCmmnDAO_registNttAdiInfo_I", nttVO);
		//}
		//
		//String tmprnttSeq = StringUtils.defaultString(nttVO.getTmprnttSeq());
		//
		//if(!"".equals(tmprnttSeq)){
		//	// 임시게시물 삭제
		//	deleteTmprnttInfo(nttVO);
		//}
		
		return result;
	}
	
	/**
	 * ㅁ 탭 메뉴 데이터 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer modifyTabMenuData(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		int result = 0;
		
		// 게시물 정보 수정
		result = update("ModuleTabMenuDataDAO_modifyTabMenuData_U", tabMenuDataVO);
		
		//if(result > 0){
		//	// 게시물 부가정보 수정
		//	update("ModuleNttCmmnDAO_modifyTmprnttAdiInfo_I", nttVO);
		//}
		
		return result;
	}
	
	/**
	 * ㅁ 탭 메뉴 데이터 상세조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleTabMenuDataVO selectTabMenuDataDetail(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		return (ModuleTabMenuDataVO)selectOne("ModuleTabMenuDataDAO_selectTabMenuDataDetail_S", tabMenuDataVO);
	}
	
	/**
	 * ㅁ 탭 메뉴 데이터 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer deleteTabMenuData(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		return update("ModuleTabMenuDataDAO_deleteTabMenuData_D", tabMenuDataVO);
	}
	
	/**
	 * ㅁ 탭 메뉴 데이터 순서변경
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer modifyTabDataListOrdr(ModuleTabMenuDataVO tabMenuDataVO) throws Exception{
		return update("ModuleTabMenuDataDAO_modifyTabDataListOrdr", tabMenuDataVO);
	}
	
}
