package egovframework.wzwg.module.upload.image.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.upload.image.service.ModuleUploadImageService;
import egovframework.wzwg.module.upload.image.service.ModuleUploadImageVO;

/**
 * @Class Name : EgovFileMngServiceImpl.java
 * @Description : 파일정보의 관리를 위한 구현 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 25.     이삼섭    최초생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 25.
 * @version
 * @see
 *
 */
@Service("ModuleUploadImageService")
public class ModuleUploadImageServiceImpl extends EgovAbstractServiceImpl implements ModuleUploadImageService {

    @Resource(name = "ModuleUploadImageDAO")
    private ModuleUploadImageDAO moduleImageUploadDAO;

    /** 폴더가 생성된 사이트 목록 */
    public List<ModuleUploadImageVO> selectSearchSiteList(ModuleUploadImageVO vo) throws Exception {
    	return moduleImageUploadDAO.selectSearchSiteList(vo);
    }
    
    /** 업로드된 이미지 목록 조회 */
    public List<ModuleUploadImageVO> selectImageList(ModuleUploadImageVO vo) throws Exception {
    	
    	vo.setStartScrollPageIdx(vo.getScrollPageIdx());
    	vo.setEndScrollPageIdx(vo.getScrollPageIdx() + 20);
    	return moduleImageUploadDAO.selectImageList(vo);
    }
    
    /** 이미지 폴더 목록을 조회한다. */
    public List<ModuleUploadImageVO> selectFolderList(ModuleUploadImageVO vo) throws Exception {
    	return moduleImageUploadDAO.selectFolderList(vo);
    }
    
    /** 이미지 하위 폴더 목록을 조회한다. */
    public List<ModuleUploadImageVO> selectSubFolderList(ModuleUploadImageVO vo) throws Exception {
    	return moduleImageUploadDAO.selectSubFolderList(vo);
    }
    
    /** 폴더 생성 */
    public void registFolder(ModuleUploadImageVO vo) throws Exception {
    	moduleImageUploadDAO.registFolder(vo);
    }
    
    /** 폴더 수정 */
    public void modifyFolder(ModuleUploadImageVO vo) throws Exception {
    	moduleImageUploadDAO.modifyFolder(vo);
    }
    
    /** 폴더 삭제 */
    public void deleteFolder(ModuleUploadImageVO vo) throws Exception {
    	moduleImageUploadDAO.deleteFolder(vo);
    }
    
    /** usrimgId 추출 */
    public String getNextUsrimgId() throws Exception {
    	return moduleImageUploadDAO.getNextUsrimgId();
    }
    
    /** 단일 이미지 업로드 */
    public String uploadImage(ModuleUploadImageVO vo) throws Exception {
    	String usrimgId = vo.getUsrimgId();
    	
    	moduleImageUploadDAO.uploadImage(vo);
    	
    	return usrimgId;
    }
    
    /** 다중 이미지 업로드 */
    public String uploadImage(List<ModuleUploadImageVO> list) throws Exception {
		String usrimgId = "";
		
		if (list.size() != 0) {
			usrimgId = moduleImageUploadDAO.uploadImage(list);
		}
		
		if(usrimgId == ""){
			usrimgId = null;
		}
		
		return usrimgId;
    }
    
    
    /** 이미지 상세정보 */
    public ModuleUploadImageVO selectImageDetail(ModuleUploadImageVO vo) throws Exception {
    	return moduleImageUploadDAO.selectImageDetail(vo);
    }
    
    /** 이미지 삭제 */
    public int deleteImage(ModuleUploadImageVO vo) throws Exception {
    	return moduleImageUploadDAO.deleteImage(vo);
    }
    
    /** 폴더 체크 */
    public int selectFolderImageCheck(ModuleUploadImageVO vo) throws Exception{
    	return moduleImageUploadDAO.selectFolderImageCheck(vo);
    }
}
