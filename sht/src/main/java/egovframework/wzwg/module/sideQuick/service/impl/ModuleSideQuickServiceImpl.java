package egovframework.wzwg.module.sideQuick.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.sideQuick.service.ModuleSideQuickService;
import egovframework.wzwg.module.sideQuick.service.ModuleSideQuickVO;

@Service("ModuleSideQuickService")
public class ModuleSideQuickServiceImpl extends EgovAbstractServiceImpl implements ModuleSideQuickService {

	@Resource(name="ModuleSideQuickDAO")
	protected ModuleSideQuickDAO sideQuickDAO;
	
	/**
	 * 퀵메뉴 설정 정보 조회
	 * @param siteSeq
	 * @return
	 * @throws Exception
	 */
	@Override
	public ModuleSideQuickVO selectSideQuickStbs(String siteSeq) throws Exception {
		return sideQuickDAO.selectSideQuickStbs(siteSeq);
	}
	
	/**
	 * 퀵메뉴 설정 정보 입력
	 * @param quickVO
	 * @return
	 * @throws Exception
	 */
	@Override
	public int registSideQuickStbs(ModuleSideQuickVO quickVO) throws Exception {
		return sideQuickDAO.registSideQuickStbs(quickVO);
	}
	
	/**
	 * 퀵메뉴 설정 정보 수정
	 * @param quickVO
	 * @return
	 * @throws Exception
	 */
	@Override
	public int modifySideQuickStbs(ModuleSideQuickVO quickVO) throws Exception {
		return sideQuickDAO.modifySideQuickStbs(quickVO);
	}
	
	/**
	 * 퀵메뉴 링크 목록 조회
	 * @param quickVO
	 * @return
	 */
	@Override
	public List<ModuleSideQuickVO> selectSideQuickLinkList(String siteSeq) throws Exception {
		return sideQuickDAO.selectSideQuickLinkList(siteSeq);
	}

	/**
	 * 퀵메뉴 링크 추가
	 * @param quickVO
	 * @return
	 */
	@Override
	public int registQuickLinkInfo(ModuleSideQuickVO quickVO) throws Exception {
		return sideQuickDAO.registQuickLinkInfo(quickVO);
	}
	
	/**
	 * 퀵메뉴 링크 데이터 조회
	 * @param quickVO
	 * @return
	 */
	@Override
	public ModuleSideQuickVO selectSideQuickLinkInfo(ModuleSideQuickVO quickVO) throws Exception {
		return sideQuickDAO.selectSideQuickLinkInfo(quickVO);
	}
	
	/**
	 * 퀵메뉴 링크 데이터 수정
	 * @param quickVO
	 * @return
	 */
	@Override
	public int modifySideQuickLinkInfo(ModuleSideQuickVO quickVO) throws Exception {
		return sideQuickDAO.modifySideQuickLinkInfo(quickVO);
	}
	
	/**
	 * 퀵메뉴 링크 데이터 삭제
	 * @param quickVO
	 * @return
	 */
	public int deleteSideQuickLinkInfo(ModuleSideQuickVO quickVO) throws Exception{
		return sideQuickDAO.deleteSideQuickLinkInfo(quickVO);
	}
	
	/**
	 * 퀵메뉴 링크 데이터 순서변경
	 * @param quickVO
	 * @param command (prev:이전, next:다음)
	 * @return
	 */
	public int modifySideQuickLinkInfoOrdr(ModuleSideQuickVO quickVO, String command) throws Exception{
		ModuleSideQuickVO thisVO = new ModuleSideQuickVO();
		ModuleSideQuickVO targetVO = new ModuleSideQuickVO();
		
		if(command.equals("prev")){
			targetVO = sideQuickDAO.selectSideQuickLinkInfoOrdrPrev(quickVO);
		}else if(command.equals("next")){
			targetVO = sideQuickDAO.selectSideQuickLinkInfoOrdrNext(quickVO);
		}
		
		if(targetVO == null){
			return -1;//이전 또는 다음 대상이 없어서 진행 할 수 없음(양끝에서 더 올리거나 내렸을 경우)
		}
		
		/* 현재 선택된 VO 와 타겟 VO의 ordr 값을 교체후 업데이트 */
		thisVO.setQmenuSeq(quickVO.getQmenuSeq());
		thisVO.setLastUpdusrId(quickVO.getLastUpdusrId());
		thisVO.setQmenuOrdr(targetVO.getQmenuOrdr()); // << 교환
		
		//targetVO.setQmenuSeq(quickVO.getQmenuSeq());
		targetVO.setLastUpdusrId(quickVO.getLastUpdusrId());
		targetVO.setQmenuOrdr(quickVO.getQmenuOrdr()); // << 교환
		
		int result = 0;
		result += sideQuickDAO.modifySideQuickLinkInfoOrdr(thisVO);
		result += sideQuickDAO.modifySideQuickLinkInfoOrdr(targetVO);
		System.out.print("================== target(seq : " + targetVO.getQmenuSeq() + " ordr : " + targetVO.getQmenuOrdr() + ")" );
		System.out.print(" this(seq : " + thisVO.getQmenuSeq() + " ordr : " + thisVO.getQmenuOrdr() + ")" );
		System.out.print(" DB UPDATE RESULT : " + result);
		System.out.println();
		
		return result;
	}
}
