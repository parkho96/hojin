package egovframework.wzwg.module.onlineQustnr.service;

import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleOnlineQustnrQesitmVO {

	/** 설문 문항 SEQ */
	private String qesitmSeq			=	"";
	
	/** 설문 SEQ */
	private String qustnrSeq			=	"";

	/** 문항 명 */	
	private String qesitmNm				=	"";
	
	/** 문항 타입 코드 */
	private String qesitmTyCode			=	"";
	
	/** 문항 타입 코드명 */
	private String qesitmTyCodeNm		=	"";
	
	/** 순서 */
	private String ordr					=	"";
	
	/** 사용여부 */
	private String useAt				=	"";

	/** 최초등록자 ID */
	private String frstRegisterId		=	"";

	/** 최종수정자 ID */
	private String lastUpdusrId			=	"";
	
	/** 사용자 ID */
	private String userId				=	"";
	
	/** 사이트시퀀스 */
	private String siteSeq				=	"";
	
	/** 항목 시퀀스  */
	private String iemSeq				=	"";
	
	/** 항목 명 */
	private String iemNm				=	"";
	
	/** 항목 타입 코드 */
	private String iemTyCode			=	"";
	
	/** 이전 문항 SEQ */
	private String prevQesitmSeq		=	"";
	
	/** 다음 문항 SEQ */
	private String nextQesitmSeq		=	"";
	
	/** 이전 ordr */
	private String prevOrdr				=	"";
	
	/** 다음 ordr */
	private String nextOrdr				=	"";
	
	/** 변경하고자하는 문항 SEQ */
	private String changeQesitmSeq		=	"";
	
	/** 변경하고자하는 ORDR */
	private String changeOrdr			=	"";

	/** 기존 iemSeq Arr */
	private String[] prevIemSeqArr;
	
	/** 수정시킬 iemSeq Arr */
	private String[] iemSeqArr;
	
	/** 기존 iemNm Arr */
	private String[] iemNmArr;
	
	/** 문항 시퀀스 arr */
	private String[] qesitmSeqArr;
	
	private String langCode				=	"";

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

	public String[] getPrevIemSeqArr() {
		if(prevIemSeqArr != null) {
			return Arrays.copyOf(prevIemSeqArr,prevIemSeqArr.length);
		}else {
			return null;
		}
	}

	public void setPrevIemSeqArr(String[] prevIemSeqArr) {
		if (prevIemSeqArr != null) {
			this.prevIemSeqArr = Arrays.copyOf(prevIemSeqArr, prevIemSeqArr.length);
		} else {
			this.prevIemSeqArr = null;
		}
	}

	public String[] getIemSeqArr() {
		if(iemSeqArr != null) {
			return Arrays.copyOf(iemSeqArr,iemSeqArr.length);
		}else {
			return null;
		}
	}

	public void setIemSeqArr(String[] iemSeqArr) {
		if (iemSeqArr != null) {
			this.iemSeqArr = Arrays.copyOf(iemSeqArr, iemSeqArr.length);
		} else {
			this.iemSeqArr = null;
		}
	}

	public String[] getIemNmArr() {
		if(iemNmArr != null) {
			return Arrays.copyOf(iemNmArr,iemNmArr.length);
		}else {
			return null;
		}
	}

	public void setIemNmArr(String[] iemNmArr) {
		if (iemNmArr != null) {
			this.iemNmArr = Arrays.copyOf(iemNmArr, iemNmArr.length);
		} else {
			this.iemNmArr = null;
		}
	}
	
}
