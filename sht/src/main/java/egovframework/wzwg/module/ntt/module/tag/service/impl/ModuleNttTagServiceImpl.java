package egovframework.wzwg.module.ntt.module.tag.service.impl;

import java.util.Iterator;
import java.util.List;
import java.util.TreeSet;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.module.tag.service.ModuleNttTagService;
import egovframework.wzwg.module.ntt.module.tag.service.ModuleNttTagVO;



@Service("ModuleNttTagService")
@SuppressWarnings({ "unchecked", "rawtypes" })
public class ModuleNttTagServiceImpl extends EgovAbstractServiceImpl implements ModuleNttTagService {

	@Resource(name="ModuleNttTagDAO")
    protected ModuleNttTagDAO nttTagDAO;
	
	/**
	 * ㅁ 태그SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttTagSeq() throws Exception {
		return nttTagDAO.selectNextNttTagSeq();
	}
	
	/**
	 * ㅁ 태그등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttTag(ModuleNttTagVO tagVO) throws Exception {

		int result = 0;
		
		// 태그등록
		TreeSet ts = new TreeSet();

		if(tagVO != null && tagVO.getTagArr() != null) {
			for(int i = 0; i < tagVO.getTagArr().length; i++){
				ts.add(tagVO.getTagArr()[i]);
			}
		}else{
			throw new NullPointerException("tagVO tagArr null point");
		}
		
		Iterator ite = ts.iterator();
		
		String dplctTagSeq = null;
		
		while(ite.hasNext()) {
			
			tagVO.setTagNm(ite.next().toString());
			
			dplctTagSeq = nttTagDAO.getDplctTeg(tagVO);
			
			if(dplctTagSeq == null){
				tagVO.setTagSeq(nttTagDAO.selectNextNttTagSeq());
				nttTagDAO.registUsrTag(tagVO);
			}else{
				tagVO.setTagSeq(dplctTagSeq);
			}
			
			result = nttTagDAO.registNttTag(tagVO);
			
			result++;
		}
		
		return result;
	}
	
	/**
	 * ㅁ 태그수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttTag(ModuleNttTagVO tagVO) throws Exception {

		int result = 0;
		
		// 태그등록
		TreeSet ts = new TreeSet();
		TreeSet ts2 = new TreeSet();

		if(tagVO != null && tagVO.getTagArr() != null) {
			for(int i = 0; i < tagVO.getTagArr().length; i++){
				ts.add(tagVO.getTagArr()[i]);
			}
		}else{
			throw new NullPointerException("tagVO tagArr null point");
		}
		
		if(tagVO != null && tagVO.getTmpTagArr() != null) {
			for(int i = 0; i < tagVO.getTmpTagArr().length; i++){
				ts2.add(tagVO.getTmpTagArr()[i]);
			}
		}else{
			throw new NullPointerException("tagVO getTmpTagArr null point");
		}
		
		
		
		
		
		Iterator ite = ts.iterator();
		
		String dplctTagSeq = null;
		
		while(ite.hasNext()) {
			
			tagVO.setTagNm(ite.next().toString());
			
			// 게시물에 태그 사용여부
			int dplctCnt = 0;
			
			dplctCnt = nttTagDAO.selectNttTagDplct(tagVO);
			
			if(dplctCnt == 0){	// 사용하는 곳 없음
				dplctTagSeq = nttTagDAO.getDplctTeg(tagVO);
				
				if(dplctTagSeq == null){
					tagVO.setTagSeq(nttTagDAO.selectNextNttTagSeq());
					nttTagDAO.registUsrTag(tagVO);
				}else{
					tagVO.setTagSeq(dplctTagSeq);
					result = nttTagDAO.updateUsrTag(tagVO);
				}
				
			}else{ // 사용함
				
			}
			
			result++;
		}
		
		return result;
	}
	
	/**
	 * ㅁ 게시물 태그 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttTagVO> selectNttTagList(ModuleNttTagVO tagVO) throws Exception {
		return nttTagDAO.selectNttTagList(tagVO);
	}	
	
	/**
	 * ㅁ 게시물 나의 태그 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttTagVO> selectNttUsrTagList(ModuleNttTagVO tagVO) throws Exception {
		return nttTagDAO.selectNttUsrTagList(tagVO);
	}
	
}
