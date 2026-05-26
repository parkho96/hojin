package egovframework.wzwg.module.onlineQustnr.service;

import java.util.Arrays;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleOnlineQustnrRespondVO extends ComDefaultVO {

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
	
	/** 사용자 ID */
	private String userId					=	"";
	
	/** 설문 상태(대기, 진행중, 종료) */
	private String qustnrSttus				=	"";
	
	/** 설문 참여했는지 카운트 */
	private String respondAt				=	"";
	
	/** 설문대상자 여부 */
	private String respondUsrtyAt			=	"";
	
	/** 답변 arr */
	private String[] responseValue;
	
	/** 사용자 SEQ */
	private String usrSeq					=	"";

	/** 답변 SEQ */
	private String respondSeq	=	"";
	
	/** IP */
	private String ip			=	"";
	
	/** 텍스트 답변 */
	private String dscrpAnswer	=	"";
	
	/** 항목 SEQ */
	private String qesitmSeq	=	"";
	
	/** 문항 SEQ */
	private String iemSeq		=	"";

	public String[] getResponseValue() {
		if(responseValue != null) {
			return Arrays.copyOf(responseValue,responseValue.length);
		}else {
			return null;
		}
	}

	public void setResponseValue(String[] responseValue) {
		if (responseValue != null) {
			this.responseValue = Arrays.copyOf(responseValue, responseValue.length);
		} else {
			this.responseValue = null;
		}
	}

}
