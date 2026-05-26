package egovframework.wzwg.module.cntnts.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.cntnts.service.ModuleCntntsCnService;
import egovframework.wzwg.module.cntnts.service.ModuleCntntsVO;

@Service("ModuleCntntsCnService")
public class ModuleCntntsCnServiceImpl extends EgovAbstractServiceImpl implements ModuleCntntsCnService {
	@Resource(name="ModuleCntntsCnDAO")
	ModuleCntntsCnDAO moduleCntntsCnDAO;

	/**
	 * 컨텐츠 내용 리스트
	 */
	public List<ModuleCntntsVO> selectModuleCntntsCnList(ModuleCntntsVO moduleCntntsVO) {
		return moduleCntntsCnDAO.selectModuleCntntsCnList(moduleCntntsVO);
	}

	/**
	 * 컨텐츠 내용 상세조회 
	 */
	public ModuleCntntsVO selectModuleCntntsCnDetail(ModuleCntntsVO moduleCntntsVO) {
		return moduleCntntsCnDAO.selectModuleCntntsCnDetail(moduleCntntsVO);
	}

	/**
	 * 컨텐츠 내용 등록
	 */
	public int registModuleCntntsCnAjax(ModuleCntntsVO moduleCntntsVO) {
		/** 컨텐츠 내용 시퀀스 */
		String cntntsCnSeq = moduleCntntsCnDAO.selectModuleCntntsCnSeq();
		moduleCntntsVO.setCntntsCnSeq(cntntsCnSeq);
		
		return moduleCntntsCnDAO.registModuleCntntsCnAjax(moduleCntntsVO);
	}

	/**
	 * 컨텐츠 내용 삭제
	 */
	public int deleteModuleCntntsCnAjax(ModuleCntntsVO moduleCntntsVO) {
		return moduleCntntsCnDAO.deleteModuleCntntsCnAjax(moduleCntntsVO);
	}
	
	public int modifyModuleCntntsCnAjax(ModuleCntntsVO moduleCntntsVO) {
		return moduleCntntsCnDAO.modifyModuleCntntsCnAjax(moduleCntntsVO);
	}

	/**
	 * 총 카운트 조회
	 */
	public int selectCntntsCnTotCnt(ModuleCntntsVO moduleCntntsVO) {
		return moduleCntntsCnDAO.selectCntntsCnTotCnt(moduleCntntsVO);
	}

	/**
	 * 적용된 템플릿 조회
	 */
	public ModuleCntntsVO selectModuleCntntsCnTmplatDetail(
			ModuleCntntsVO moduleCntntsVO) {
		return moduleCntntsCnDAO.selectModuleCntntsCnTmplatDetail(moduleCntntsVO);
	}

    /**
     * 컨텐츠 상세 - 서비스 화면
     */
    public ModuleCntntsVO selectCntntscnScrinCntnts(ModuleCntntsVO moduleCntntsVO) {
        return moduleCntntsCnDAO.selectCntntscnScrinCntnts(moduleCntntsVO);
    }
    
    /**
     * 컨텐츠 내용 적용된 템플릿으로 초기화 
     */
    public int registModuleCntntsCnTemplatInitAjax(ModuleCntntsVO moduleCntntsVO) {

        ModuleCntntsVO resultVO = moduleCntntsCnDAO.selectModuleCntntsCnTmplatDetail(moduleCntntsVO);
        
        System.out.println(resultVO == null);
        
        if(resultVO != null){
            moduleCntntsVO.setCntntsCn(resultVO.getCntntsCn());
            
            /** 컨텐츠 내용 시퀀스 */
            String cntntsCnSeq = moduleCntntsCnDAO.selectModuleCntntsCnSeq();
            moduleCntntsVO.setCntntsCnSeq(cntntsCnSeq);
            
            return moduleCntntsCnDAO.registModuleCntntsCnAjax(moduleCntntsVO);
        	
        }else{
        	return 0;
        }
    }
}
