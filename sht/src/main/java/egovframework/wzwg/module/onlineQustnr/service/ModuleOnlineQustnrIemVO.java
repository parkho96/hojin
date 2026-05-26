package egovframework.wzwg.module.onlineQustnr.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleOnlineQustnrIemVO {
	
	/** 설문옵션 시퀀스 */
	private String iemSeq				=	"";
	
	/** 설문옵션명 */
	private String iemNm				=	"";
	
	/** 설문문항 시퀀스 */
	private String qesitmSeq			=	"";
	
	/** 설문옵션 타입 코드 */
	private String iemTyCode			=	"";
	
	/** 순서 */
	private String ordr					=	"";
	
	/** 사용여부 */
	private String useAt				=	"";
	
	/** 사용자ID */
	private String userId				=	"";
	
	/** 이전 설문문항 시퀀스 */
	private String prevQesitmSeq		=	"";
	
	/** 답변 count */
	private String respondCount			=	"";
	
	/** 답변 sum*/
	private String respondSum			=	"";
	
	/** 답변 percent */
	private String respondPercent		=	"";
	
	/** 답변 text */
	private String dscrpAnswer			=	"";
	
	/** 문항명 */
	private String qesitmNm				=	"";
	
	/** 문항타입 */
	private String qesitmTyCode			=	"";
	
	/** 최초등록자 */
	private String frstRegisterId		=	"";
	
	/** 최종수정자 */
	private String lastUpdusrId			=	"";

}
