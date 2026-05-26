package egovframework.wzwg.module.bbs.bbsForm.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.bbs.bbsForm.service.ModuleBbsFormService;
import egovframework.wzwg.module.bbs.bbsForm.service.ModuleBbsFormVO;

@Service("ModuleBbsFormService")
public class ModuleBbsFormServiceImpl extends EgovAbstractServiceImpl implements ModuleBbsFormService {
	@Resource(name="ModuleBbsFormDAO")
	ModuleBbsFormDAO moduleBbsFormDAO;

	/**
	 * 게시판 양식 관리 리스트조회 
	 */
	public List<ModuleBbsFormVO> selectModuleBbsFormList(
			ModuleBbsFormVO moduleBbsFormVO) {
		return moduleBbsFormDAO.selectModuleBbsFormList(moduleBbsFormVO);
	}

	/**
	 * 게시판 양식 관리 상세조회
	 */
	public ModuleBbsFormVO selectModuleBbsFormDetail(
			ModuleBbsFormVO moduleBbsFormVO) {
		return moduleBbsFormDAO.selectModuleBbsFormDetail(moduleBbsFormVO);
	}

	/**
	 * 게시판 양식 관리 등록
	 */
	public int registModuleBbsFormAjax(ModuleBbsFormVO moduleBbsFormVO) {
		String bbsFormSeq = moduleBbsFormDAO.selectModuleBbsFormSeq();
		moduleBbsFormVO.setFormSeq(bbsFormSeq);
		
		int result = moduleBbsFormDAO.registModuleBbsFormAjax(moduleBbsFormVO);
		
		if(result<1){
		}else{
			if(!("").equals(moduleBbsFormVO.getBbsSeq())){
				String[] bbsSeqList = moduleBbsFormVO.getBbsSeq().split(",");
				
				for(int i=0; i<bbsSeqList.length; i++){
					moduleBbsFormVO.setBbsSeq(bbsSeqList[i]);
					
					moduleBbsFormDAO.registNttBbsForm(moduleBbsFormVO);
				}
			}
		}
		return result;
	}

	/**
	 * 게시판 양식 관리 수정
	 */
	public int modifyModuleBbsFormAjax(ModuleBbsFormVO moduleBbsFormVO) {
		int result =moduleBbsFormDAO.modifyModuleBbsFormAjax(moduleBbsFormVO); 
		
		if(result < 1){
		}else{
			
			result += nttBbsFormDstnctn(moduleBbsFormVO);
			
		}
		return result;
	}

	/**
	 * 게시판 양식 매핑 테이블에 CRUD를 판별하기 위한 method
	 * @param moduleBbsFormVO
	 */
	@SuppressWarnings("unchecked")
	public int nttBbsFormDstnctn(ModuleBbsFormVO moduleBbsFormVO){
		int result = 0;
		
		String[] beforeBbsSeqArray = {};
		String[] bbsSeqArray = {};
		
		if(!("").equals(moduleBbsFormVO.getBeforeBbsSeq())){
			beforeBbsSeqArray = moduleBbsFormVO.getBeforeBbsSeq().split(",");
		}
		
		if(!("").equals(moduleBbsFormVO.getBbsSeq())){
			bbsSeqArray = moduleBbsFormVO.getBbsSeq().split(",");
		}
		
		ArrayList<String> beforeBbsSeqArrayList = new ArrayList<String>();
		Collections.addAll(beforeBbsSeqArrayList, beforeBbsSeqArray);
		
		ArrayList<String> bbsSeqArrayList = new ArrayList<String>();
		Collections.addAll(bbsSeqArrayList, bbsSeqArray);
		
		ArrayList<String> modifyBbsSeqList = new ArrayList<String>();
		modifyBbsSeqList = (ArrayList<String>) beforeBbsSeqArrayList.clone();
		
		modifyBbsSeqList.retainAll(bbsSeqArrayList);
		
		beforeBbsSeqArrayList.removeAll(modifyBbsSeqList);
		bbsSeqArrayList.removeAll(modifyBbsSeqList);
		
		for(int i=0; i<modifyBbsSeqList.size(); i++){
			moduleBbsFormVO.setBbsSeq(modifyBbsSeqList.get(i));
			
			result += moduleBbsFormDAO.modifyNttBbsForm(moduleBbsFormVO);
		}
		
		for(int i=0; i<bbsSeqArrayList.size(); i++){
			moduleBbsFormVO.setBbsSeq(bbsSeqArrayList.get(i));
			
			result += moduleBbsFormDAO.registNttBbsForm(moduleBbsFormVO);
		}
		
		for(int i=0; i<beforeBbsSeqArrayList.size(); i++){
			moduleBbsFormVO.setBbsSeq(beforeBbsSeqArrayList.get(i));
			
			result += moduleBbsFormDAO.deleteNttBbsForm(moduleBbsFormVO);
		}
		
		/** 이전, 이후에도 적용된 게시판이 없는데 수정버튼을 누를경우 사용함.  */
		if(("").equals(moduleBbsFormVO.getBbsSeq()) && ("").equals(moduleBbsFormVO.getBeforeBbsSeq())){
			result = 1;
		}
		
		return result;
	}

	/**
	 * 게시판 양식 관리 삭제
	 */
	public int deleteModuleBbsFormAjax(ModuleBbsFormVO moduleBbsFormVO) {
		int result = moduleBbsFormDAO.deleteModuleBbsFormAjax(moduleBbsFormVO);
		
		if(result < 1){
		}else{
			result += moduleBbsFormDAO.deleteNttBbsForm(moduleBbsFormVO);
		}
		
		return result; 
	}

	/**
	 * 게시판 양식 총 카운트 조회
	 */
	public int selectModuleBbsFormTotCnt(ModuleBbsFormVO moduleBbsFormVO) {
		return moduleBbsFormDAO.selectModuleBbsFormTotCnt(moduleBbsFormVO);
	}

	/**
	 * 게시판 리스트 조회
	 */
	public List<ModuleBbsFormVO> selectBbsApplcListPopup(ModuleBbsFormVO moduleBbsFormVO) {
		return moduleBbsFormDAO.selectBbsApplcListPopup(moduleBbsFormVO);
	}

	/**
	 * 게시판 매핑 리스트 조회
	 */
	public ModuleBbsFormVO selectNttBbsMappingDetail(ModuleBbsFormVO moduleBbsFormVO) {
		return moduleBbsFormDAO.selectNttBbsMappingDetail(moduleBbsFormVO);
	}

	/**
	 * 게시판 매핑 테이블 입력
	 */
	public void registNttBbsForm(ModuleBbsFormVO moduleBbsFormVO) {
		moduleBbsFormDAO.registNttBbsForm(moduleBbsFormVO);
	}

}
