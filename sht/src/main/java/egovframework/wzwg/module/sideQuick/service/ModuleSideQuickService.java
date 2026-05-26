package egovframework.wzwg.module.sideQuick.service;

import java.util.List;

public interface ModuleSideQuickService {
	
	/**
	 * 퀵메뉴 설정 정보 조회
	 * @param siteSeq
	 * @return
	 * @throws Exception
	 */
	public ModuleSideQuickVO selectSideQuickStbs(String siteSeq) throws Exception;

	/**
	 * 퀵메뉴 설정 정보 입력
	 * @param quickVO
	 * @return
	 * @throws Exception
	 */
	public int registSideQuickStbs(ModuleSideQuickVO quickVO) throws Exception;
	
	/**
	 * 퀵메뉴 설정 정보 수정
	 * @param quickVO
	 * @return
	 * @throws Exception
	 */
	public int modifySideQuickStbs(ModuleSideQuickVO quickVO) throws Exception;
	
	
	/**
	 * 퀵메뉴 링크 목록 조회
	 * @param quickVO
	 * @return
	 */
	public List<ModuleSideQuickVO> selectSideQuickLinkList(String siteSeq) throws Exception;
	
	/**
	 * 퀵메뉴 링크 추가
	 * @param quickVO
	 * @return
	 */
	public int registQuickLinkInfo(ModuleSideQuickVO quickVO) throws Exception;
	
	/**
	 * 퀵메뉴 링크 데이터 조회
	 * @param quickVO
	 * @return
	 */
	public ModuleSideQuickVO selectSideQuickLinkInfo(ModuleSideQuickVO quickVO) throws Exception;
	
	/**
	 * 퀵메뉴 링크 데이터 수정
	 * @param quickVO
	 * @return
	 */
	public int modifySideQuickLinkInfo(ModuleSideQuickVO quickVO) throws Exception;
	
	/**
	 * 퀵메뉴 링크 데이터 삭제
	 * @param quickVO
	 * @return
	 */
	public int deleteSideQuickLinkInfo(ModuleSideQuickVO quickVO) throws Exception;
	
	/**
	 * 퀵메뉴 링크 데이터 순서변경
	 * @param quickVO
	 * @param command (prev:이전, next:다음)
	 * @return
	 */
	public int modifySideQuickLinkInfoOrdr(ModuleSideQuickVO quickVO, String command) throws Exception;
}
