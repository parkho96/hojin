package egovframework.wzwg.module.tabMenu.service;

import java.util.List;

public interface ModuleTabMenuDataService {
	/**
	 * ㅁ 공지게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	//public List<ModuleTabMenuDataVO> selectNttNoticeList(ModuleTabMenuDataVO tabMenuDataVO) throws Exception;
	
	/**
	 * ㅁ 공지 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	//public int modifyNttNotice(ModuleTabMenuDataVO tabMenuDataVO) throws Exception;
	
	/**
	 * ㅁ 탭 메뉴 데이터 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleTabMenuDataVO> selectTabMenuDataList(ModuleTabMenuDataVO tabMenuDataVO) throws Exception;
	
	/**
	 * ㅁ 탭 메뉴 데이터 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectTabMenuDataTotCnt(ModuleTabMenuDataVO tabMenuDataVO) throws Exception;
    
    /**
     * ㅁ 탭 메뉴 데이터 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleTabMenuDataVO> selectTabMenuScrinCntnts(ModuleTabMenuDataVO tabMenuDataVO) throws Exception;
	
	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	//public List<ModuleTabMenuDataVO> selectNttRecycleList(ModuleTabMenuDataVO tabMenuDataVO) throws Exception;
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	//public Integer selectNttRecycleListTotCnt(ModuleTabMenuDataVO tabMenuDataVO) throws Exception;
	
	/**
	 * ㅁ 탭 메뉴 데이터 순서 변경
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer modifyTabMenuDataListOrdr(ModuleTabMenuDataVO tabMenuDataVO) throws Exception;
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * ㅁ 탭 메뉴 데이터 SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextTabMenuDataSeq(ModuleTabMenuDataVO tabMenuDataVO) throws Exception;
	
	/**
	 * ㅁ 탭 메뉴 데이터 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registTabMenuData(ModuleTabMenuDataVO tabMenuDataVO) throws Exception;
	
	/**
	 * ㅁ 탭 메뉴 데이터 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer modifyTabMenuData(ModuleTabMenuDataVO tabMenuDataVO) throws Exception;
	
	/**
	 * ㅁ 탭 메뉴 데이터 상세조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleTabMenuDataVO selectTabMenuDataDetail(ModuleTabMenuDataVO tabMenuDataVO) throws Exception;
	
	/**
	 * ㅁ 탭 메뉴 데이터 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer deleteTabMenuData(ModuleTabMenuDataVO tabMenuDataVO) throws Exception;
	
	/**
	 * ㅁ 탭 메뉴 데이터 순서변경
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer modifyTabDataListOrdr(ModuleTabMenuDataVO tabMenuDataVO) throws Exception;
	
	
	
}
