package egovframework.wzwg.module.onlineQustnr.service.impl;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrIemVO;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrInfoVO;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrItmCstdyService;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrQesitmVO;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("ModuleOnlineQustnrItmCstdyService")
public class ModuleOnlineQustnrItmCstdyServiceImpl extends EgovAbstractServiceImpl implements ModuleOnlineQustnrItmCstdyService {

	@Resource(name="ModuleOnlineQustnrItmCstdyDAO")
	ModuleOnlineQustnrItmCstdyDAO onlineQustnrItmCstdyDAO;

	@Resource(name="ModuleOnlineQustnrQesitmDAO")
	ModuleOnlineQustnrQesitmDAO onlineQustnrQesitmDAO;
	
	@Resource(name="ModuleOnlineQustnrIemDAO")
	ModuleOnlineQustnrIemDAO onlineQustnrIemDAO;
	
	/**
	 * @Method Name : selectOnlineQustnrItmCstdyTotCnt
	 * @Method 설명 : 내 문항 총 카운트 조회
	 * @작성일 : 2019. 7. 8.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public Integer selectOnlineQustnrItmCstdyTotCnt(ModuleOnlineQustnrInfoVO paramVO) {
		return onlineQustnrItmCstdyDAO.selectOnlineQustnrItmCstdyTotCnt(paramVO);
	}

	/**
	 * @Method Name : selectOnlineQustnrItmCstdyList
	 * @Method 설명 : 내 문항 리스트 조회
	 * @작성일 : 2019. 7. 8.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public List<ModuleOnlineQustnrInfoVO> selectOnlineQustnrItmCstdyList(ModuleOnlineQustnrInfoVO paramVO) {
		return onlineQustnrItmCstdyDAO.selectOnlineQustnrItmCstdyList(paramVO);
	}

	/**
	 * @Method Name : registOnlineQustnrItmCstdy
	 * @Method 설명 : 내 문항에 등록
	 * @작성일 : 2019. 7. 8.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int registOnlineQustnrItmCstdy(ModuleOnlineQustnrInfoVO paramVO) {
		
		int result = 0;
		String[] qesitmArr = paramVO.getQesitmSeqArr();
		try {
			if(qesitmArr != null) {
				for(int i=0; i<qesitmArr.length; i++){
					paramVO.setQesitmSeq(qesitmArr[i]);
					
					int chk = onlineQustnrItmCstdyDAO.selectOnlineQustnrItmCstdyDplctChk(paramVO);
					
					if(chk == 0){
						result += onlineQustnrItmCstdyDAO.registOnlineQustnrItmCstdy(paramVO);
					}
				}
				
			}
			
		} catch (NullPointerException e) {
			log.error("NullPointerException", e);
		} catch (RuntimeException e) {
			log.error("RuntimeException", e);
		}
		return result;
	}

	/**
	 * @Method Name : deleteOnlineQustnrItmCstdy
	 * @Method 설명 : 내 문항 삭제
	 * @작성일 : 2019. 7. 8.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int deleteOnlineQustnrItmCstdyArr(ModuleOnlineQustnrInfoVO paramVO) {
		
		int result = 0;
		
		String[] qesitmArr = paramVO.getQesitmSeqArr();
		try {
			if(qesitmArr != null) {
				for(int i=0; i<qesitmArr.length; i++){
					paramVO.setQesitmSeq(qesitmArr[i]);
					result += onlineQustnrItmCstdyDAO.deleteOnlineQustnrItmCstdy(paramVO);
				}
				
			}
			
		} catch (NullPointerException e) {
			log.error("NullPointerException", e);
		} catch (RuntimeException e) {
			log.error("RuntimeException", e);
		}
		
		return result;
	}

	/**
	 * @Method Name : registOnlineQustnrItmCstdyNowQustnr
	 * @Method 설명 : 내 문항 -> 현재 설문에 저장
	 * @작성일 : 2019. 7. 9.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int registOnlineQustnrItmCstdyNowQustnr(ModuleOnlineQustnrInfoVO paramVO) {

		int result = 0;
		String[] qesitmSeqArr = paramVO.getQesitmSeqArr();
		try {
			if(qesitmSeqArr != null) {
				for(int i=0; i<qesitmSeqArr.length; i++){
					
					ModuleOnlineQustnrQesitmVO qesitmVO = new ModuleOnlineQustnrQesitmVO();
					qesitmVO.setQesitmSeq(qesitmSeqArr[i]);
					qesitmVO = onlineQustnrQesitmDAO.selectOnlineQustnrQesitmDetail(qesitmVO);
					
					qesitmVO.setQustnrSeq(paramVO.getQustnrSeq());
					qesitmVO.setFrstRegisterId(paramVO.getFrstRegisterId());
					
					String qesitmSeq = onlineQustnrQesitmDAO.selectOnlineQustnrQesitmSeq();
					qesitmVO.setQesitmSeq(qesitmSeq);
					
					String ordr = onlineQustnrQesitmDAO.selectOnlineQustnrQesitmOrdr(qesitmVO);
					qesitmVO.setOrdr(ordr);
					
					result = onlineQustnrQesitmDAO.registOnlineQustnrQesitm(qesitmVO);
					
					if(result > 0){
						
						ModuleOnlineQustnrIemVO iemVO = new ModuleOnlineQustnrIemVO();
						iemVO.setQesitmSeq(qesitmSeqArr[i]);
						
						List<ModuleOnlineQustnrIemVO> iemList = onlineQustnrIemDAO.selectOnlineQustnrIemList(iemVO);
						
						iemVO.setQesitmSeq(qesitmSeq);
						
						for(int j=0; j<iemList.size(); j++){
							
							String iemSeq = onlineQustnrIemDAO.selectOnlineQustnrIemSeq();
							iemVO.setIemSeq(iemSeq);
							
							String iemOrdr = onlineQustnrIemDAO.selectOnlineQustnrIemOrdr(iemVO);
							iemVO.setOrdr(iemOrdr);
							
							iemVO.setIemNm(iemList.get(j).getIemNm());
							iemVO.setIemTyCode(iemList.get(j).getIemTyCode());
							
							onlineQustnrIemDAO.registOnlineQustnrIem(iemVO);
						}
					}
				}
				
			}
		} catch (NullPointerException e) {
			log.error("NullPointerException", e);
		} catch (RuntimeException e) {
			log.error("RuntimeException", e);
		}
		
		
		return result;
	}

}
