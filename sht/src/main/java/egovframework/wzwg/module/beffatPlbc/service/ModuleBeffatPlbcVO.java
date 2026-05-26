package egovframework.wzwg.module.beffatPlbc.service;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleBeffatPlbcVO extends ComDefaultVO{
private static final long serialVersionUID = 1L;

	private String siteSeq;					// 사이트시퀀스
	
	private String ctgryCd;                // 카테고리코드
	private String ctgryDcCn;              // 카테고리설명
	private String storFileId;             // 첨부파일 아이디
	private String sortSn;                 // 정렬순서
	private String useYn;                  // 사용여부
	private String frstRegistPnttm;        // 등록일
	private String frstRegisterId;         // 등록자 아이디
	private String lastUpdtPnttm;          // 수정일
	private String lastUpdusrId;           // 수정자 아이디
                                           
	private String pblcSn;                 // 정보공개 순번(SEQ)
	private String beffatPblcCycleVal;     // 공표주기
	private String beffatPblcEraVal;       // 공표시기
	private String pblcMthCd;              // 공표방법
	private String deptVal;                // 부서이름값 - 단순표기용
	private String linkUrl;                // 링크
	private String qkMenuYn;               // 퀵메뉴여부
	private String expsrYn;                // 공개여부
	private String beffatPblcSj;		   // 정보공개 제목
	private String beffatPblcSubSj;     // 정보공개 서브 제목
                                           
	private String listSn;                 // 세부목록 순번
	
	/* DB 필드 이외의 조작용 변수들 */
	private String ordr;//순번 조작용
	private String frmTy;//입력폼 타입
	private String qkMenuYnArrStr;//퀵메뉴 등록 삭제용
	private String srchCtgryCd;//검색용 카테고리코드
	private String srchPblcSn;//검색용 정보공개순번(퀵메뉴서치)
	private String srchExpsrYn;//검색용 노출여부
	private String ctgryYn;//카테고리 사용여부(삭제여부)
	
}
