package egovframework.wzwg.module.orgnzt.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.orgnzt.service.OrgnztInfoVO;

@Repository("OrgnztInfoDAO")
public class OrgnztInfoDAO extends EgovAbstractMapper{

	/** 관리자 - 조직도 데이터 리스트 */
	
	public List<OrgnztInfoVO> selectOrgnztInfoList(OrgnztInfoVO paramVO) {
		return selectList("OrgnztInfoDAO_selectOrgnztInfoList", paramVO);
	}
	public OrgnztInfoVO selectOrgnztInfo(OrgnztInfoVO paramVO) {
		return (OrgnztInfoVO) selectOne("OrgnztInfoDAO_selectOrgnztInfoList", paramVO);
	}
	
	/** 관리자 - 조직도 등록 */
	public int registOrgnztInfoAjax(OrgnztInfoVO paramVO) {
		return update("OrgnztInfoDAO_registOrgnztInfoAjax", paramVO);
	}
	
	/** 관리자 - 조직도 수정 */
	public int modifyOrgnztInfoAjax(OrgnztInfoVO paramVO) {
		return update("OrgnztInfoDAO_modifyOrgnztInfoAjax", paramVO);
	}
	
	/** 관리자 - 조직도 삭제 */
	public int deleteOrgnztInfoAjax(OrgnztInfoVO paramVO) {
		return update("OrgnztInfoDAO_deleteOrgnztInfoAjax", paramVO);
	}
	
	
	/** 관리자 - 조직도 순서변경 */
	public OrgnztInfoVO selectOrgnztInfoOrdrInfo(OrgnztInfoVO paramVO) {
		return (OrgnztInfoVO) selectOne("OrgnztInfoDAO_selectOrgnztInfoOrdrInfo", paramVO);
	}
	public int modifyOrgnztInfoOrdrAjax(OrgnztInfoVO paramVO){
		return update("OrgnztInfoDAO_modifyOrgnztInfoOrdrAjax", paramVO);
	}
	public OrgnztInfoVO selectOrgnztInfoOrdrPrev(OrgnztInfoVO paramVO) {
		return (OrgnztInfoVO) selectOne("OrgnztInfoDAO_selectOrgnztInfoOrdrPrev", paramVO);
	}
	public OrgnztInfoVO selectOrgnztInfoOrdrNext(OrgnztInfoVO paramVO) {
		return (OrgnztInfoVO) selectOne("OrgnztInfoDAO_selectOrgnztInfoOrdrNext", paramVO);
	}
	
	
	/** 관리자 - 조직도 그룹 구성원 리스트 */
	
	public List<OrgnztInfoVO> selectOrgnztInfoMemList(OrgnztInfoVO paramVO) {
		return selectList("OrgnztInfoDAO_selectOrgnztInfoMemList", paramVO);
	}
	public OrgnztInfoVO selectOrgnztInfoMem(OrgnztInfoVO paramVO) {
		return (OrgnztInfoVO) selectOne("OrgnztInfoDAO_selectOrgnztInfoMemList", paramVO);
	}
	
	/** 관리자 - 조직도 그룹 구성원 등록 */
	public int registOrgnztInfoMemAjax(OrgnztInfoVO paramVO) {
		return update("OrgnztInfoDAO_registOrgnztInfoMemAjax", paramVO);
	}
	

	/** 관리자 - 조직도 그룹 구성원 순서변경 */
	public OrgnztInfoVO selectOrgnztMemOrdrInfo(OrgnztInfoVO paramVO) {
		return (OrgnztInfoVO) selectOne("OrgnztInfoDAO_selectOrgnztMemOrdrInfo", paramVO);
	}
	public int modifyOrgnztMemOrdrAjax(OrgnztInfoVO paramVO){
		return update("OrgnztInfoDAO_modifyOrgnztMemOrdrAjax", paramVO);
	}
	public OrgnztInfoVO selectOrgnztMemOrdrPrev(OrgnztInfoVO paramVO) {
		return (OrgnztInfoVO) selectOne("OrgnztInfoDAO_selectOrgnztMemOrdrPrev", paramVO);
	}
	public OrgnztInfoVO selectOrgnztMemOrdrNext(OrgnztInfoVO paramVO) {
		return (OrgnztInfoVO) selectOne("OrgnztInfoDAO_selectOrgnztMemOrdrNext", paramVO);
	}

	
	/** 관리자 - 조직도 그룹 구성원 수정 */
	public int modifyOrgnztInfoMemAjax(OrgnztInfoVO paramVO) {
		return update("OrgnztInfoDAO_modifyOrgnztInfoMemAjax", paramVO);
	}
	
	/** 관리자 - 조직도 그룹 구성원 부서 이동 */
	public int modifyOrgnztInfoMemDeptAjax(OrgnztInfoVO paramVO) {
		return update("OrgnztInfoDAO_modifyOrgnztInfoMemDeptAjax", paramVO);
	}
	
	/** 관리자 - 조직도 그룹 구성원 삭제 */
	public int deleteOrgnztInfoMem(OrgnztInfoVO paramVO) {
		return update("OrgnztInfoDAO_deleteOrgnztInfoMem", paramVO);
	}
	
	/** 관리자 - 조직도 그룹 구성원 체크 */
	public int selectOrgnztInfoMemCnt(OrgnztInfoVO paramVO) {
		return Integer.parseInt((String) selectOne("OrgnztInfoDAO_selectOrgnztInfoMemCnt", paramVO));
	}
	
	/** 관리자 - 조직도 하위 그룹 체크 */
	public int selectOrgnztInfoLowGrpCnt(OrgnztInfoVO paramVO){
		return Integer.parseInt((String) selectOne("OrgnztInfoDAO_selectOrgnztInfoLowGrpCnt", paramVO));
	}
	
	/** 관리자 - 조직도 디자인 조회 */
	public OrgnztInfoVO selectOrgnztEstbs(OrgnztInfoVO paramVO) {
		return (OrgnztInfoVO) selectOne("OrgnztInfoDAO_selectOrgnztEstbs", paramVO);
	}
	
	/** 관리자 - 조직도 디자인 저장 */
	public int registOrgnztEstbs(OrgnztInfoVO paramVO){
		return update("OrgnztInfoDAO_registOrgnztEstbs", paramVO);
	}
	
	/** 관리자 - 조직도 디자인 수정 */
	public int modifyOrgnztEstbs(OrgnztInfoVO paramVO){
		return update("OrgnztInfoDAO_modifyOrgnztEstbs", paramVO);
	}
}
