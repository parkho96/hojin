package egovframework.wzwg.module.orgnzt.service;

import java.util.List;

public interface OrgnztInfoService {
	/** 관리자 - 조직도 데이터 리스트 */
	public List<OrgnztInfoVO> selectOrgnztInfoList(OrgnztInfoVO paramVO);
	public OrgnztInfoVO selectOrgnztInfo(OrgnztInfoVO paramVO);

	/** 관리자 - 조직도 등록 */
	public int registOrgnztInfoAjax(OrgnztInfoVO paramVO);

	/** 관리자 - 조직도 수정 */
	public int modifyOrgnztInfoAjax(OrgnztInfoVO paramVO);
	
	/** 관리자 - 조직도 삭제 */
	public int deleteOrgnztInfoAjax(OrgnztInfoVO paramVO);
	
	/** 관리자 - 조직도 순서변경 */
	public OrgnztInfoVO selectOrgnztInfoOrdrInfo(OrgnztInfoVO paramVO);
	public int modifyOrgnztInfoOrdrAjax(OrgnztInfoVO paramVO, String command);

	
	/** 관리자 - 조직도 그룹 구성원 리스트 */
	public List<OrgnztInfoVO> selectOrgnztInfoMemList(OrgnztInfoVO paramVO);
	public OrgnztInfoVO selectOrgnztInfoMem(OrgnztInfoVO paramVO);
	
	/** 관리자 - 조직도 그룹 구성원 등록 */
	public int registOrgnztInfoMemAjax(OrgnztInfoVO paramVO);
	
	/** 관리자 - 조직도 그룹 구성원 순서변경 */
	public OrgnztInfoVO selectOrgnztMemOrdrInfo(OrgnztInfoVO paramVO);
	public int modifyOrgnztMemOrdrAjax(OrgnztInfoVO paramVO, String command);
	
	/** 관리자 - 조직도 그룹 구성원 수정 */
	public int modifyOrgnztInfoMemAjax(OrgnztInfoVO paramVO);
	
	/** 관리자 - 조직도 그룹 구성원 부서 이동 */
	public int modifyOrgnztInfoMemDeptAjax(OrgnztInfoVO paramVO);
	
	/** 관리자 - 조직도 그룹 구성원 삭제 */
	public int deleteOrgnztInfoMem(OrgnztInfoVO paramVO);
	
	/** 관리자 - 조직도 그룹 구성원 체크 */
	public int selectOrgnztInfoMemCnt(OrgnztInfoVO paramVO);
	
	/** 관리자 - 조직도 하위 그룹 체크 */
	public int selectOrgnztInfoLowGrpCnt(OrgnztInfoVO paramVO);
	
	/** 관리자 - 조직도 디자인 조회*/
	public OrgnztInfoVO selectOrgnztEstbs(OrgnztInfoVO paramVO);
	
	/** 관리자 - 조직도 디자인 저장 */
	public int registOrgnztEstbs(OrgnztInfoVO paramVO);
	
	/** 관리자 - 조직도 디자인 수정*/
	public int modifyOrgnztEstbs(OrgnztInfoVO paramVO);
	
}
