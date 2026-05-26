package egovframework.wzwg.module.onlineQustnr.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.IllegalFormatException;
import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrIemVO;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrQesitmService;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrQesitmVO;

@Service("ModuleOnlineQustnrQesitmService")
public class ModuleOnlineQustnrQesitmServiceImpl extends EgovAbstractServiceImpl implements ModuleOnlineQustnrQesitmService {
	
	@Resource(name="ModuleOnlineQustnrQesitmDAO")
	ModuleOnlineQustnrQesitmDAO onlineQustnrQesitmDAO;
	
	@Resource(name="ModuleOnlineQustnrIemDAO")
	ModuleOnlineQustnrIemDAO onlineQustnrIemDAO;
	
	protected static final Log LOG = LogFactory.getLog(ModuleOnlineQustnrQesitmServiceImpl.class);
	
	/**
	 * @Method Name : selectOnlineQustnrQesitmList
	 * @Method 설명 : 설문 문항 리스트 조회
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public List<ModuleOnlineQustnrQesitmVO> selectOnlineQustnrQesitmList(ModuleOnlineQustnrQesitmVO paramVO) {
		return onlineQustnrQesitmDAO.selectOnlineQustnrQesitmList(paramVO);
	}

	/**
	 * @Method Name : selectOnlineQustnrQesitmDetail
	 * @Method 설명 : 설문 문항 상세 조회
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public ModuleOnlineQustnrQesitmVO selectOnlineQustnrQesitmDetail(ModuleOnlineQustnrQesitmVO paramVO) {
		return onlineQustnrQesitmDAO.selectOnlineQustnrQesitmDetail(paramVO);
	}

	/**
	 * @Method Name : registOnlineQustnrQesitm
	 * @Method 설명 : 설문 문항 등록
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int registOnlineQustnrQesitm(ModuleOnlineQustnrQesitmVO paramVO) {
		
		String qesitmSeq = onlineQustnrQesitmDAO.selectOnlineQustnrQesitmSeq();
		paramVO.setQesitmSeq(qesitmSeq);
		
		String ordr = onlineQustnrQesitmDAO.selectOnlineQustnrQesitmOrdr(paramVO);
		paramVO.setOrdr(ordr);
		
		int result = onlineQustnrQesitmDAO.registOnlineQustnrQesitm(paramVO);
		
		if(result > 0){
			registOnlineQustnrIem(paramVO);
		}
		
		return result;
	}

	/**
	 * @Method Name : modifyOnlineQustnrQesitm
	 * @Method 설명 : 설문 문항 수정
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@SuppressWarnings("unchecked")
	public int modifyOnlineQustnrQesitm(ModuleOnlineQustnrQesitmVO paramVO) {
		int result = onlineQustnrQesitmDAO.modifyOnlineQustnrQesitm(paramVO);
		
		if(result > 0){
			if(("SC00000324").equals(paramVO.getQesitmTyCode()) || ("SC00000325").equals(paramVO.getQesitmTyCode())){
				
				ModuleOnlineQustnrIemVO iemVO = new ModuleOnlineQustnrIemVO();
				iemVO.setLastUpdusrId(paramVO.getLastUpdusrId());
				
				/** 기존 항목 SEQ */
				ArrayList<String> prevIemSeqList = new ArrayList<String>();
				Collections.addAll(prevIemSeqList, paramVO.getPrevIemSeqArr());
				
				/** 수정할 항목 SEQ */
				ArrayList<String> iemSeqList = new ArrayList<String>();
				Collections.addAll(iemSeqList, paramVO.getIemSeqArr());
				
				/** 수정할 항목 명 */
				ArrayList<String> iemNmList = new ArrayList<String>();
				Collections.addAll(iemNmList, paramVO.getIemNmArr());
				
				/** 비교할 List */
				ArrayList<String> modifyIemSeqList = new ArrayList<String>();
				modifyIemSeqList = (ArrayList<String>) prevIemSeqList.clone();
				
				/** 공통부분 찾기 */
				modifyIemSeqList.retainAll(iemSeqList);
				
				/** 기존 리스트에 공통부분 제거 */
				prevIemSeqList.removeAll(modifyIemSeqList);
				
				/** 기존 항목 삭제 */
				for(int i=0; i<prevIemSeqList.size(); i++){
					iemVO.setIemSeq(prevIemSeqList.get(i));
					onlineQustnrIemDAO.deleteOnlineQustnrIem(iemVO);
				}
				
				/** 수정항목 수정 */
				for(int i=0; i<iemSeqList.size(); i++){
					iemVO.setIemSeq(iemSeqList.get(i));
					iemVO.setIemNm(iemNmList.get(i));
					onlineQustnrIemDAO.modifyOnlineQustnrIem(iemVO);
				}
				
				/** 새로운 항목이 있으면 등록 */
				if(!("").equals(paramVO.getIemNm()) && null != paramVO.getIemNm()){
					registOnlineQustnrIem(paramVO);
				}
			}else if(("SC00000326").equals(paramVO.getQesitmTyCode())){

				ModuleOnlineQustnrIemVO iemVO = new ModuleOnlineQustnrIemVO();
				iemVO.setIemSeq(paramVO.getIemSeq());
				iemVO.setIemTyCode(paramVO.getIemTyCode());
				
				onlineQustnrIemDAO.modifyOnlineQustnrIem(iemVO);
			}else {}
		}
		
		return result;
	}

	/**
	 * @Method Name : deleteOnlineQustnrQesitm
	 * @Method 설명 : 설문 문항 삭제
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int deleteOnlineQustnrQesitm(ModuleOnlineQustnrQesitmVO paramVO) {
		return onlineQustnrQesitmDAO.deleteOnlineQustnrQesitm(paramVO);
	}

	/**
	 * @Method Name : deleteOnlineQustnrQesitmArr
	 * @Method 설명 : 설문 문항 체크박스 삭제
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int deleteOnlineQustnrQesitmArr(ModuleOnlineQustnrQesitmVO paramVO) {
		
		int result = 0;
		
		try {
			if(paramVO.getQesitmSeqArr() != null && paramVO.getQesitmSeqArr().length > 0){
				for(int i=0; i<paramVO.getQesitmSeqArr().length; i++){
					paramVO.setQesitmSeq(paramVO.getQesitmSeqArr()[i]);
					result += deleteOnlineQustnrQesitm(paramVO);
				}
			}
		}catch(NullPointerException e){
			LOG.error("NullPointerException",e);
  	   	}catch(NumberFormatException e){
  	   		LOG.error("NumberFormatException",e);
  	   	}catch(IllegalFormatException e){
  	   		LOG.error("IllegalFormatException",e);
  	   	}catch(ArrayIndexOutOfBoundsException e){
  	   		LOG.error("ArrayIndexOutOfBoundsException",e);
  	   	} 
		
		return result;
	}

	/**
	 * @Method Name : modifyOnlineQustnrQesitmOrdr
	 * @Method 설명 : 설문 문항 순서 변경 
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int modifyOnlineQustnrQesitmOrdr(ModuleOnlineQustnrQesitmVO paramVO) {
		int result = 0;
		
		String ordr = paramVO.getOrdr();
		String changeQesitmSeq = paramVO.getChangeQesitmSeq();
		
		paramVO.setOrdr(paramVO.getChangeOrdr());
		result = onlineQustnrQesitmDAO.modifyOnlineQustnrQesitmOrdr(paramVO);

		if(result > 0){
			paramVO.setQesitmSeq(changeQesitmSeq);
			paramVO.setOrdr(ordr);
			result = onlineQustnrQesitmDAO.modifyOnlineQustnrQesitmOrdr(paramVO);
		}
		
		return result;
	}

	
	/**
	 * @Method Name : registOnlineQustnrIem
	 * @Method 설명 : 설문 항목 등록
	 * @작성일 : 2019. 7. 2.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public void registOnlineQustnrIem(ModuleOnlineQustnrQesitmVO paramVO) {

		
		String[] iemArr = paramVO.getIemNm().split(",");
		
		ModuleOnlineQustnrIemVO iemVO = new ModuleOnlineQustnrIemVO();
		
		iemVO.setQesitmSeq(paramVO.getQesitmSeq());
		iemVO.setIemTyCode(paramVO.getIemTyCode());

		for(int i=0; i<iemArr.length; i++){
			/** 설문옵션 시퀀스 조회 */
			String iemSeq = onlineQustnrIemDAO.selectOnlineQustnrIemSeq();
			iemVO.setIemSeq(iemSeq);
			
			/** 설문옵션 순서조회 */
			String ordr = onlineQustnrIemDAO.selectOnlineQustnrIemOrdr(iemVO);
			iemVO.setOrdr(ordr);
			
			/** 설문옵션명 등록 */
			iemVO.setIemNm(iemArr[i]);
			
			onlineQustnrIemDAO.registOnlineQustnrIem(iemVO);
		}
	}

	/**
	 * @Method Name : selectOnlineQustnrResultIemInit
	 * @Method 설명 : 설문 항목 리스트 분기
	 * @작성일 : 2019. 7. 10.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public List<ModuleOnlineQustnrIemVO> selectOnlineQustnrResultIemInit(ModuleOnlineQustnrIemVO paramVO) {
		if(("SC00000326").equals(StringUtils.defaultString(paramVO.getQesitmTyCode()))){
			return selectOnlineQustnrIemTextList(paramVO);
		}else{
			return selectOnlineQustnrIemList(paramVO);
		}
		
	}
	
	/**
	 * @Method Name : selectOnlineQustnrIemList
	 * @Method 설명 : 설문 항목 리스트 조회
	 * @작성일 : 2019. 7. 10.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public List<ModuleOnlineQustnrIemVO> selectOnlineQustnrIemList(ModuleOnlineQustnrIemVO paramVO) {
		return onlineQustnrIemDAO.selectOnlineQustnrIemList(paramVO);
	}


	/**
	 * @Method Name : selectOnlineQustnrIemTextList
	 * @Method 설명 : 설문 항목 텍스트 리스트 조회
	 * @작성일 : 2019. 7. 10.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public List<ModuleOnlineQustnrIemVO> selectOnlineQustnrIemTextList(ModuleOnlineQustnrIemVO paramVO) {
		return onlineQustnrIemDAO.selectOnlineQustnrIemTextList(paramVO);
	}



}
