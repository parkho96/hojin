package egovframework.wzwg.module.upload.image.service.impl;

import java.util.Iterator;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.upload.image.service.ModuleUploadImageVO;

/**
 * @Class Name : EgovFileMngDAO_java
 * @Description : 파일정보 관리를 위한 데이터 처리 클래스
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
@Repository("ModuleUploadImageDAO")
@SuppressWarnings("rawtypes")
public class ModuleUploadImageDAO extends EgovAbstractMapper {

	
	/** 폴더가 생성된 사이트 목록 */
    public List<ModuleUploadImageVO> selectSearchSiteList(ModuleUploadImageVO vo) throws Exception {
    	return selectList("ModuleUploadImageDAO_selectSearchSiteList_S" , vo);
    }
    
	/** 업로드된 이미지 목록 조회 */
	public List<ModuleUploadImageVO> selectImageList(ModuleUploadImageVO vo) throws Exception {
    	return selectList("ModuleUploadImageDAO_selectImageList_S", vo);
    }
    
    /** 이미지 폴더 목록을 조회한다. */
    public List<ModuleUploadImageVO> selectFolderList(ModuleUploadImageVO vo) throws Exception {
    	return selectList("ModuleUploadImageDAO_selectFolderList_S", vo);
    }
    
    /** 이미지 하위 폴더 목록을 조회한다. */
    public List<ModuleUploadImageVO> selectSubFolderList(ModuleUploadImageVO vo) throws Exception {
    	return selectList("ModuleUploadImageDAO_selectSubFolderList_S", vo);
    }
    
    /** 폴더 생성 */
    public void registFolder(ModuleUploadImageVO vo) throws Exception {
    	insert("ModuleUploadImageDAO_registFolder_I", vo);
    }
    
    /** 폴더 수정 */
    public void modifyFolder(ModuleUploadImageVO vo) throws Exception {
    	update("ModuleUploadImageDAO_modifyFolder_U", vo);
    }
    
    /** 폴더 삭제 */
    public void deleteFolder(ModuleUploadImageVO vo) throws Exception {
    	update("ModuleUploadImageDAO_updateFolderImage_U", vo);
    	update("ModuleUploadImageDAO_deleteFolder_D", vo);
    }
    
    /** usrimgId 추출 */
    public String getNextUsrimgId() throws Exception {
    	return (String) selectOne("ModuleUploadImageDAO_getNextUsrimgId_S");
    }
    
    /** 단일 이미지 업로드 */
    public void uploadImage(ModuleUploadImageVO vo) throws Exception {
    	insert("ModuleUploadImageDAO_uploadImage_I", vo);
    }
    
    /** 다중 이미지 업로드 */
    public String uploadImage(List<ModuleUploadImageVO> list) throws Exception {
    	ModuleUploadImageVO vo = (ModuleUploadImageVO)list.get(0);
    	String usrimgId = vo.getUsrimgId();

		Iterator iter = list.iterator();
		
		while (iter.hasNext()) {
		    vo = (ModuleUploadImageVO)iter.next();
		    
		    insert("ModuleUploadImageDAO_uploadImage_I", vo);
		}
		
		return usrimgId;
    }

    /** 이미지 상세정보 */
    public ModuleUploadImageVO selectImageDetail(ModuleUploadImageVO vo) throws Exception {
    	return (ModuleUploadImageVO) selectOne("ModuleUploadImageDAO_selectImageDetail_S", vo);
    }
    
    /** 이미지 삭제 */
    public int deleteImage(ModuleUploadImageVO vo) throws Exception {
    	return delete("ModuleUploadImageDAO_deleteImage_D", vo);
    }

    /** 폴더 체크 */
    public int selectFolderImageCheck(ModuleUploadImageVO vo) throws Exception{
    	String result = (String) selectOne("ModuleUploadImageDAO_selectFolderImageCheck_S", vo);
    	return Integer.parseInt(result);
    }
}
