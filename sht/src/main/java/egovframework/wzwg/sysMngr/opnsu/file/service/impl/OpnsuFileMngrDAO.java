package egovframework.wzwg.sysMngr.opnsu.file.service.impl;

import java.util.Iterator;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.opnsu.file.service.OpnsuFileVO;
import lombok.extern.slf4j.Slf4j;

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
@Slf4j
@Repository("OpnsuFileMngrDAO")
public class OpnsuFileMngrDAO extends EgovAbstractMapper {

	/**
     * 파일 ID를 추출
     * 
     * @param fvo
     * @throws Exception
     */
    public String getNextAtchFileId() throws Exception {
    	return (String) selectOne("OpnsuFileMngrDAO_getNextAtchFileId", new String());
    }
    
    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param fileList
     * @return
     * @throws Exception
     */
    
    public String insertFileInfs(List fileList) throws Exception {
	OpnsuFileVO vo = (OpnsuFileVO)fileList.get(0);
	String atchFileId = vo.getAtchFileId();
	
	insert("OpnsuFileMngrDAO_insertFileMaster", vo);

	Iterator iter = fileList.iterator();
	while (iter.hasNext()) {
	    vo = (OpnsuFileVO)iter.next();
	    
	    insert("OpnsuFileMngrDAO_insertFileDetail", vo);
	}
	
	return atchFileId;
    }

    /**
     * 하나의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param vo
     * @throws Exception
     */
    public void insertFileInf(OpnsuFileVO vo) throws Exception {
	insert("OpnsuFileMngrDAO_insertFileMaster", vo);
	insert("OpnsuFileMngrDAO_insertFileDetail", vo);
    }

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 수정한다.
     * 
     * @param fileList
     * @throws Exception
     */
    
    public void updateFileInfs(List fileList) throws Exception {
	OpnsuFileVO vo;
	Iterator iter = fileList.iterator();
	while (iter.hasNext()) {
	    vo = (OpnsuFileVO)iter.next();
	    
	    insert("OpnsuFileMngrDAO_insertFileDetail", vo);
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
	OpnsuFileVO vo;
	while (iter.hasNext()) {
	    vo = (OpnsuFileVO)iter.next();
	    
	    delete("OpnsuFileMngrDAO_deleteFileDetail", vo);
	}
    }

    /**
     * 하나의 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public int deleteFileInf(OpnsuFileVO fvo) throws Exception {
    	return delete("OpnsuFileMngrDAO_deleteFileDetail", fvo);
    }

    /**
     * 파일에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    
    public List<OpnsuFileVO> selectFileInfs(OpnsuFileVO vo) throws Exception {
	return selectList("OpnsuFileMngrDAO_selectFileList", vo);
    }

    /**
     * 파일 구분자에 대한 최대값을 구한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int getMaxFileSN(OpnsuFileVO fvo) throws Exception {
	return (Integer)selectOne("OpnsuFileMngrDAO_getMaxFileSN", fvo);
    }

    /**
     * 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public OpnsuFileVO selectFileInf(OpnsuFileVO fvo) throws Exception {
	return (OpnsuFileVO)selectOne("OpnsuFileMngrDAO_selectFileInf", fvo);
    }

    /**
     * 전체 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public void deleteAllFileInf(OpnsuFileVO fvo) throws Exception {
	update("OpnsuFileMngrDAO_deleteCOMTNFILE", fvo);
    }

    /**
     * 파일명 검색에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    
    public List<OpnsuFileVO> selectFileListByFileNm(OpnsuFileVO fvo) throws Exception {
	return selectList("OpnsuFileMngrDAO_selectFileListByFileNm", fvo);
    }

    /**
     * 파일명 검색에 대한 목록 전체 건수를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int selectFileListCntByFileNm(OpnsuFileVO fvo) throws Exception {
	return (Integer)selectOne("OpnsuFileMngrDAO_selectFileListCntByFileNm", fvo);
    }

    /**
     * 이미지 파일에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    
    public List<OpnsuFileVO> selectImageFileList(OpnsuFileVO vo) throws Exception {
	return selectList("OpnsuFileMngrDAO_selectImageFileList", vo);
    }
    
    /**
     * 이미지 파일에 대한 전체 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    
    public List<OpnsuFileVO> selectImageFileAllList(OpnsuFileVO vo) throws Exception {
        return selectList("OpnsuFileMngrDAO_selectImageFileAllList_S", vo);
    }
    
    /**
     * 폴더 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    
    public List<OpnsuFileVO> selectDirList(OpnsuFileVO vo) throws Exception {
        return selectList("OpnsuFileMngrDAO_selectDirList_S", vo);
    }
}
