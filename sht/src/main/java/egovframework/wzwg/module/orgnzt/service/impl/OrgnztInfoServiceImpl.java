package egovframework.wzwg.module.orgnzt.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.orgnzt.service.OrgnztInfoService;
import egovframework.wzwg.module.orgnzt.service.OrgnztInfoVO;

@Service("OrgnztInfoService")
public class OrgnztInfoServiceImpl extends EgovAbstractServiceImpl implements OrgnztInfoService{

	@Resource(name="OrgnztInfoDAO")
	protected OrgnztInfoDAO orgnztInfoDAO;
	
	
	
	/** 관리자 - 조직도 데이터 리스트 */
	@Override
	public List<OrgnztInfoVO> selectOrgnztInfoList(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.selectOrgnztInfoList(paramVO);
	}
	
	@Override
	public OrgnztInfoVO selectOrgnztInfo(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.selectOrgnztInfo(paramVO);
	}
	
	/** 관리자 - 조직도 등록 */
	@Override
	public int registOrgnztInfoAjax(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.registOrgnztInfoAjax(paramVO);
	}
	
	/** 관리자 - 조직도 수정 */
	@Override
	public int modifyOrgnztInfoAjax(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.modifyOrgnztInfoAjax(paramVO);
	}
	
	/** 관리자 - 조직도 삭제 */
	@Override
	public int deleteOrgnztInfoAjax(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.deleteOrgnztInfoAjax(paramVO);
	}
	
	
	@Override
	public OrgnztInfoVO selectOrgnztInfoOrdrInfo(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.selectOrgnztInfoOrdrInfo(paramVO);
	}
	
	/**
	 * 조직도 데이터 순서변경
	 * @param command (prev:이전, next:다음)
	 * @return
	 */
	@Override
	public int modifyOrgnztInfoOrdrAjax(OrgnztInfoVO paramVO, String command) {
		OrgnztInfoVO thisVO = new OrgnztInfoVO();
		OrgnztInfoVO targetVO = new OrgnztInfoVO();
		
		
		if(command.equals("prev")){
			targetVO = orgnztInfoDAO.selectOrgnztInfoOrdrPrev(paramVO);
			
		}else if(command.equals("next")){
			
			targetVO = orgnztInfoDAO.selectOrgnztInfoOrdrNext(paramVO);
		}
		
		if(targetVO == null){
			return -1;//이전 또는 다음 대상이 없어서 진행 할 수 없음(양끝에서 더 올리거나 내렸을 경우)
		}
		
		/* 현재 선택된 VO 와 타겟 VO의 ordr 값을 교체후 업데이트 */
		thisVO.setOrgnztSeq(paramVO.getOrgnztSeq());
		thisVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		thisVO.setSiteSeq(paramVO.getSiteSeq());
		thisVO.setOrgnztOrdr(targetVO.getOrgnztOrdr()); // << 교환
		
		targetVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		targetVO.setOrgnztOrdr(paramVO.getOrgnztOrdr()); // << 교환
		
		int result = 0;
		result += orgnztInfoDAO.modifyOrgnztInfoOrdrAjax(thisVO);
		result += orgnztInfoDAO.modifyOrgnztInfoOrdrAjax(targetVO);
		
		
		System.out.print("\n\n===== target(seq : " + targetVO.getOrgnztSeq() + " ordr : " + targetVO.getOrgnztOrdr() + ")" );
		System.out.print("\n this(seq : " + thisVO.getOrgnztSeq() + " ordr : " + thisVO.getOrgnztOrdr() + ")" );
		System.out.print("\n DB UPDATE RESULT : " + result + "\n\n");
		System.out.println();
		
		return result;
	}
	
	
	/**
	 * 구성원 데이터 리스트
	 * 
	 */
	@Override
	public List<OrgnztInfoVO> selectOrgnztInfoMemList(OrgnztInfoVO paramVO){
		return orgnztInfoDAO.selectOrgnztInfoMemList(paramVO);
	}
	
	@Override
	public OrgnztInfoVO selectOrgnztInfoMem(OrgnztInfoVO paramVO){
		return orgnztInfoDAO.selectOrgnztInfoMem(paramVO);
	}
	
	/** 관리자 - 조직도 그룹 구성원 등록 */
	@Override
	public int registOrgnztInfoMemAjax(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.registOrgnztInfoMemAjax(paramVO);
	}
	
	
	
	@Override
	public OrgnztInfoVO selectOrgnztMemOrdrInfo(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.selectOrgnztMemOrdrInfo(paramVO);
	}
	
	/**
	 * 구성원 데이터 순서변경
	 * @param command (prev:이전, next:다음)
	 * @return
	 */
	@Override
	public int modifyOrgnztMemOrdrAjax(OrgnztInfoVO paramVO, String command) {
		OrgnztInfoVO thisVO = new OrgnztInfoVO();
		OrgnztInfoVO targetVO = new OrgnztInfoVO();
		
		
		if(command.equals("prev")){
			targetVO = orgnztInfoDAO.selectOrgnztMemOrdrPrev(paramVO);
			
		}else if(command.equals("next")){
			
			targetVO = orgnztInfoDAO.selectOrgnztMemOrdrNext(paramVO);
		}
		
		if(targetVO == null){
			return -1;//이전 또는 다음 대상이 없어서 진행 할 수 없음(양끝에서 더 올리거나 내렸을 경우)
		}
		
		/* 현재 선택된 VO 와 타겟 VO의 ordr 값을 교체후 업데이트 */
		thisVO.setOrgnztmberSeq(paramVO.getOrgnztmberSeq());
		thisVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		thisVO.setSiteSeq(paramVO.getSiteSeq());
		thisVO.setOrgnztmberOrdr(targetVO.getOrgnztmberOrdr()); // << 교환
		
		targetVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		targetVO.setOrgnztmberOrdr(paramVO.getOrgnztmberOrdr()); // << 교환
		
		int result = 0;
		result += orgnztInfoDAO.modifyOrgnztMemOrdrAjax(thisVO);
		result += orgnztInfoDAO.modifyOrgnztMemOrdrAjax(targetVO);
		
		
		System.out.print("\n\n===== target(seq : " + targetVO.getOrgnztmberSeq() + " ordr : " + targetVO.getOrgnztmberOrdr() + ")" );
		System.out.print("\n this(seq : " + thisVO.getOrgnztmberSeq() + " ordr : " + thisVO.getOrgnztmberOrdr() + ")" );
		System.out.print("\n DB UPDATE RESULT : " + result + "\n\n");
		System.out.println();
		
		return result;
	}
	
	/** 관리자 - 조직도 그룹 구성원 수정 */
	@Override
	public int modifyOrgnztInfoMemAjax(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.modifyOrgnztInfoMemAjax(paramVO);
	}
	
	/** 관리자 - 조직도 그룹 구성원 부서 이동 */
	@Override
	public int modifyOrgnztInfoMemDeptAjax(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.modifyOrgnztInfoMemDeptAjax(paramVO);
	}
	
	/** 관리자 - 조직도 그룹 구성원 삭제 */
	@Override
	public int deleteOrgnztInfoMem(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.deleteOrgnztInfoMem(paramVO);
	}
	
	/** 관리자 - 조직도 그룹 구성원 체크 */
	@Override
	public int selectOrgnztInfoMemCnt(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.selectOrgnztInfoMemCnt(paramVO);
	}
	
	/** 관리자 - 조직도 하위 그룹 체크 */
	@Override
	public int selectOrgnztInfoLowGrpCnt(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.selectOrgnztInfoLowGrpCnt(paramVO);
	}

	/** 관리자 - 조직도 디자인 조회*/
	@Override
	public OrgnztInfoVO selectOrgnztEstbs(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.selectOrgnztEstbs(paramVO);
	}

	/** 관리자 - 조직도 디자인 저장 */
	@Override
	public int registOrgnztEstbs(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.registOrgnztEstbs(paramVO);
	}

	/** 관리자 - 조직도 디자인 수정*/
	@Override
	public int modifyOrgnztEstbs(OrgnztInfoVO paramVO) {
		return orgnztInfoDAO.modifyOrgnztEstbs(paramVO);
	}

}
