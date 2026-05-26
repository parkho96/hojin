package egovframework.wzwg.module.onlineQustnr.service;

import java.util.Arrays;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class ModuleOnlineQustnrInfoVO extends ComDefaultVO{

	/** 설문 시퀀스 */
	private String qustnrSeq				=	"";
	
	/** 사이트 시퀀스 */	
	private String siteSeq					=	"";
	
	/** 설문 제목 */
	private String qustnrNm					=	"";
	
	/** 설문 시작일 */
	private String bgnde					=	"";
	
	/** 설문 시작시간 */
	private String beginTime				=	"";
	
	/** 설문 종료일 */
	private String endde					=	"";
	
	/** 설문 종료시간 */
	private String endTime					=	"";
	
	/** 설문 사용여부 */
	private String othbcAt					=	"";
			
	/** 설문 설명 */
	private String rm						=	"";
	
	/** 사용여부 */
	private String useAt					=	"";
	
	/** 사용자 ID */
	private String userId					=	"";
	
	/** 최초등록자 */
	private String frstRegisterId			=	"";
	
	/** 최종수정자 */
	private String lastUpdusrId				=	"";
	
	/** 설문 상태(대기, 진행중, 종료) */
	private String qustnrSttus				=	"";
	
	/** 공지여부 */
	private String searchOthbcAt			=	""; 
	
	/** 선택삭제 */
	private String[] qustnrSeqArr;
	
	/** 설문대상자 */
	private String usrtySeq					=	"";
	
	/** 설문대상자 arr */
	private String[] usrtySeqArr;
	
	/** 사용자 타입명 */
	private String tyNm						=	"";
	
	/** 텍스트 답변 */
	private String dscrpAnswer				=	"";

	/** 설문 내용(엑셀) */
	private String rmExcel					=	"";
	
	/** 설문 대상자 적용 확인 */
	private String usrtyApplcChk			=	"";
	
	/** 사용자 SEQ */
	private String usrSeq					=	"";
	
	/** 검색 문항 항목 코드 */
	private String searchQesitmTyCode		= 	"";

	/** 문항 시퀀스 */
	private String qesitmSeq				=	"";
	
	/** 문항 시퀀스 arr */
	private String[] qesitmSeqArr;
	
	/** 문항 타입 명 */
	private String qesitmTyCodeNm			=	"";
	
	/** 문항 명 */
	private String qesitmNm					=	"";

	public String[] getQustnrSeqArr() {
		if(qustnrSeqArr != null) {
			return Arrays.copyOf(qustnrSeqArr,qustnrSeqArr.length);
		}else {
			return null;
		}
	}

	public void setQustnrSeqArr(String[] qustnrSeqArr) {
		if (qustnrSeqArr != null) {
			this.qustnrSeqArr = Arrays.copyOf(qustnrSeqArr, qustnrSeqArr.length);
		} else {
			this.qustnrSeqArr = null;
		}
	}

	public String[] getUsrtySeqArr() {
		if(usrtySeqArr != null) {
			return Arrays.copyOf(usrtySeqArr,usrtySeqArr.length);
		}else {
			return null;
		}
	}

	public void setUsrtySeqArr(String[] usrtySeqArr) {
		if (usrtySeqArr != null) {
			this.usrtySeqArr = Arrays.copyOf(usrtySeqArr, usrtySeqArr.length);
		} else {
			this.usrtySeqArr = null;
		}
	}

	public String[] getQesitmSeqArr() {
		if(qesitmSeqArr != null) {
			return Arrays.copyOf(qesitmSeqArr,qesitmSeqArr.length);
		}else {
			return null;
		}
	}

	public void setQesitmSeqArr(String[] qesitmSeqArr) {
		if (qesitmSeqArr != null) {
			this.qesitmSeqArr = Arrays.copyOf(qesitmSeqArr, qesitmSeqArr.length);
		} else {
			this.qesitmSeqArr = null;
		}
	}

}
