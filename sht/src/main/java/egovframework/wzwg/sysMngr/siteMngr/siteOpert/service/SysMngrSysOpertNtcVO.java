package egovframework.wzwg.sysMngr.siteMngr.siteOpert.service;

import java.util.Arrays;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SysMngrSysOpertNtcVO extends ComDefaultVO{
	
	/** 작업알림 SEQ */
	private String sysopertSeq				=	"";
	
	/** 작업분류구분 */
	private String opertClSe				=	"";
	
	/** 사이트 대분류 그룹 */
	private String siteLclasGroup			=	"";
	
	/** 사이트 대분류 그룹명 */
	private String siteLclasGroupNm			=	"";
	
	/** 사이트 중분류 그룹 */
	private String siteMlsfcGroup			=	"";
	
	/** 사이트 중분류 그룹명 */
	private String siteMlsfcGroupNm			=	"";
	
	/** 작업명 */
	private String opertNm					=	"";
	
	/** 작업내용 */
	private String opertCn					=	"";
	
	/** 시작일 */
	private String opertBgnde				=	"";
	
	/** 시작시간 */
	private String beginTime				=	"";
	
	/** 종료일 */
	private String opertEndde				=	"";
	
	/** 종료시간 */
	private String endTime					=	"";
	
	/** 적용여부 */
	private String opertApplcAt				=	"";
	
	/** 사용여부 */
	private String useAt					=	"";
	
	/** 사용자 ID */
	private String userId					=	"";
	
	/** 최초등록일 */
	private String frstRegistPnttm			=	"";
	
	/** 작업알림 SEQ arr */
	private String[] sysopertSeqArr;

	public String[] getSysopertSeqArr() {
		if(sysopertSeqArr != null) {
			return Arrays.copyOf(sysopertSeqArr,sysopertSeqArr.length);
		}else {
			return null;
		}
	}

	public void setSysopertSeqArr(String[] sysopertSeqArr) {
		if (sysopertSeqArr != null) {
			this.sysopertSeqArr = Arrays.copyOf(sysopertSeqArr, sysopertSeqArr.length);
		} else {
			this.sysopertSeqArr = null;
		}
	}

	
	
}
