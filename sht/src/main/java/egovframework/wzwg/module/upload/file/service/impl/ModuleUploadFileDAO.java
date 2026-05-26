package egovframework.wzwg.module.upload.file.service.impl;

import java.util.Iterator;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;

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
@Repository("ModuleUploadFileDAO")
public class ModuleUploadFileDAO extends EgovAbstractMapper {

    //private static final Logger LOG = Logger.getLogger(this.getClass());

	/**
     * 파일 ID를 추출
     * 
     * @param fvo
     * @throws Exception
     */
    public String getNextAtchFileId() throws Exception {
    	return (String) selectOne("ModuleUploadFileDAO_getNextAtchFileId", new String());
    }
    
    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param fileList
     * @return
     * @throws Exception
     */
    
    public String insertFileInfs(List fileList) throws Exception {
	ModuleUploadFileVO vo = (ModuleUploadFileVO)fileList.get(0);
	String atchFileId = vo.getAtchFileId();
	
	insert("ModuleUploadFileDAO_insertFileMaster", vo);

	Iterator iter = fileList.iterator();
	while (iter.hasNext()) {
	    vo = (ModuleUploadFileVO)iter.next();
	    
	    insert("ModuleUploadFileDAO_insertFileDetail", vo);
	}
	
	return atchFileId;
    }

    /**
     * 하나의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param vo
     * @throws Exception
     */
    public void insertFileInf(ModuleUploadFileVO vo) throws Exception {
	insert("ModuleUploadFileDAO_insertFileMaster", vo);
	insert("ModuleUploadFileDAO_insertFileDetail", vo);
    }

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 수정한다.
     * 
     * @param fileList
     * @throws Exception
     */
    
    public void updateFileInfs(List fileList) throws Exception {
	ModuleUploadFileVO vo;
	Iterator iter = fileList.iterator();
	while (iter.hasNext()) {
	    vo = (ModuleUploadFileVO)iter.next();
	    
	    insert("ModuleUploadFileDAO_insertFileDetail", vo);
	}
    }

    /**
     * 여러 개의 파일을 삭제한다.
     * 
     * @param fileList
     * @throws Exception
     */
    
    public void deleteFileInfs(List fileList) throws Exception {
	Iterator iter = fileList.iterator();
	ModuleUploadFileVO vo;
	while (iter.hasNext()) {
	    vo = (ModuleUploadFileVO)iter.next();
	    
	    delete("ModuleUploadFileDAO_deleteFileDetail", vo);
	}
    }

    /**
     * 하나의 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public int deleteFileInf(ModuleUploadFileVO fvo) throws Exception {
    	return delete("ModuleUploadFileDAO_deleteFileDetail", fvo);
    }

    /**
     * 파일에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    
    public List<ModuleUploadFileVO> selectFileInfs(ModuleUploadFileVO vo) throws Exception {
	return selectList("ModuleUploadFileDAO_selectFileList", vo);
    }

    /**
     * 파일 구분자에 대한 최대값을 구한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int getMaxFileSN(ModuleUploadFileVO fvo) throws Exception {
	return (Integer)selectOne("ModuleUploadFileDAO_getMaxFileSN", fvo);
    }

    /**
     * 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public ModuleUploadFileVO selectFileInf(ModuleUploadFileVO fvo) throws Exception {
	return (ModuleUploadFileVO)selectOne("ModuleUploadFileDAO_selectFileInf", fvo);
    }

    /**
     * 전체 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public void deleteAllFileInf(ModuleUploadFileVO fvo) throws Exception {
	update("ModuleUploadFileDAO_deleteCOMTNFILE", fvo);
    }

    /**
     * 파일명 검색에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    
    public List<ModuleUploadFileVO> selectFileListByFileNm(ModuleUploadFileVO fvo) throws Exception {
	return selectList("ModuleUploadFileDAO_selectFileListByFileNm", fvo);
    }

    /**
     * 파일명 검색에 대한 목록 전체 건수를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int selectFileListCntByFileNm(ModuleUploadFileVO fvo) throws Exception {
	return (Integer)selectOne("ModuleUploadFileDAO_selectFileListCntByFileNm", fvo);
    }

    /**
     * 이미지 파일에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    
    public List<ModuleUploadFileVO> selectImageFileList(ModuleUploadFileVO vo) throws Exception {
	return selectList("ModuleUploadFileDAO_selectImageFileList", vo);
    }
    
    /**
     * 이미지 파일에 대한 전체 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    
    public List<ModuleUploadFileVO> selectImageFileAllList(ModuleUploadFileVO vo) throws Exception {
        return selectList("ModuleUploadFileDAO_selectImageFileAllList_S", vo);
    }
    
    /**
     * 폴더 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    
    public List<ModuleUploadFileVO> selectDirList(ModuleUploadFileVO vo) throws Exception {
        return selectList("ModuleUploadFileDAO_selectDirList_S", vo);
    }
    
    /**
     * 첨부파일의 설명을 수정한다
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public int updateFileDc(ModuleUploadFileVO vo) throws Exception{
    	return update("ModuleUploadFileDAO_updateDetailFileDc", vo);
    }
}
