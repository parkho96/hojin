package egovframework.wzwg.site.mngr.cntnts.cntPagadiEstbs.web;

import java.util.HashMap;
import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.utl.fcc.service.ExcelCreater;
import egovframework.wzwg.cmm.util.CmmJsonAjaxResponser;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.cntnts.cntPagadiEstbs.service.CntPageadiEstbsService;
import egovframework.wzwg.site.mngr.cntnts.cntPagadiEstbs.service.CntPageadiEstbsVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoService;

@Controller
public class CntPagadiEstbsContoller {

	@Resource(name="CntPageadiEstbsService")
    protected CntPageadiEstbsService cntPageadiEstbsService;
	
	@Resource(name="CntntsInfoService")
	private CntntsInfoService cntntsInfoService;
	
	/**
	 * ㅁ 컨텐츠페이지 추가설정 - 추가설정 화면
	 * @param CntPageadiEstbsVO
	 * @return
	 */
	@RequestMapping(value={"/**/cntnts/cntPagadiEstbs/selectCntPagadiEstbsAjax.do","/{siteKey}/**/cntnts/cntPagadiEstbs/selectCntPagadiEstbsAjax.do"})
	public String cntPagadiEstbs (
		@ModelAttribute("paramVO") CntPageadiEstbsVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		/* 게시판용 bbsSeq 를 contentsSeq 로 변환 */
    	String bbsSeq = paramVO.getBbsSeq();
    	if(bbsSeq != null && bbsSeq.equals("") == false) {
    		paramVO.setCntntsSeq(bbsSeq);
    	}
    	
    	/* 페이지 추가설정 정보 조회 */
    	CntPageadiEstbsVO pageadiEstbsVO = cntPageadiEstbsService.selectCntPageadiEstbs(paramVO);
    	
    	/* resultVO가 null 일경우 기본값 세팅해줌 */
    	if(pageadiEstbsVO == null) {
    		paramVO.setPagadiestbsSeq(cntPageadiEstbsService.selectCntPageadiEstbsSeq());
    		paramVO.setFrstRegisterId(CmmSessionUtil.getLoginVO().getUserId());
    		cntPageadiEstbsService.registCntPageadiEstbs(paramVO);
    		
    		pageadiEstbsVO = cntPageadiEstbsService.selectCntPageadiEstbs(paramVO);
    	}
    	
    	model.addAttribute("pageadiEstbsVO", pageadiEstbsVO);
    	
    	paramVO.setPagadiestbsSeq(pageadiEstbsVO.getPagadiestbsSeq());
    	
    	
    	
    	/* 담당관 목록 조회 */
    	List<CntPageadiEstbsVO> oclhgList = cntPageadiEstbsService.selectOclhgList(paramVO);
    	
    	model.addAttribute("oclhgList", oclhgList);
		
    	
    	/* 저작권 정보 조회 */
    	CntPageadiEstbsVO cpyrhtVO = cntPageadiEstbsService.selectPagecpyrht(paramVO);
    	
    	model.addAttribute("cpyrhtVO", cpyrhtVO);
    	
    	/* 평가하기 설정 조회 */
    	CntPageadiEstbsVO evlEstbs = cntPageadiEstbsService.selectEvlEstbs(paramVO);
    	
    	model.addAttribute("evlEstbsVO", evlEstbs);
    	
    	/* 평가하기 요약정보 */
    	CntPageadiEstbsVO evlEstbsSummary = cntPageadiEstbsService.selectEvlScoreSummary(paramVO);
    	
    	model.addAttribute("evlEstbsSummary", evlEstbsSummary);
    	
    	
    	/* 스킨 설정 조회 */
    	CntPageadiEstbsVO skinEstbs = cntPageadiEstbsService.selectSkinEstbs(paramVO);
    	
    	model.addAttribute("skinEstbsVO", skinEstbs);
    	
    	
		return "wzwg/site/mngr/cntnts/cntPagadiEstbs/cntPagadiEstbs";
	}
	
	/**
	 * ㅁ 컨텐츠페이지 추가설정 - 담당관 추가
	 * @param CntPageadiEstbsVO
	 * @return
	 */
	@RequestMapping(value={"/**/cntnts/cntPagadiEstbs/registOclghAjax.do","/{siteKey}/**/cntnts/cntPagadiEstbs/registOclghAjax.do"})
	public String registOclghAjax (
		@ModelAttribute("paramVO") CntPageadiEstbsVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		paramVO.setFrstRegisterId(CmmSessionUtil.getLoginVO().getUserId());
		
		paramVO.setPagoclhgSeq(cntPageadiEstbsService.selectOclhgSeq());
		
		int result = cntPageadiEstbsService.registOclhg(paramVO);
		
		if(result > 0 ) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("success").setBodyData("pagoclhgSeq", paramVO.getPagoclhgSeq()).returnJsp(model);
		}else {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
		
	}
	
	/**
	 * ㅁ 컨텐츠페이지 추가설정 - 담당관 정보변경
	 * @param CntPageadiEstbsVO
	 * @return
	 */
	@RequestMapping(value={"/**/cntnts/cntPagadiEstbs/modifyOclghAjax.do","/{siteKey}/**/cntnts/cntPagadiEstbs/modifyOclghAjax.do"})
	public String modifyOclghAjax (
		@ModelAttribute("paramVO") CntPageadiEstbsVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getLoginVO().getUserId());
		
		
		int result = cntPageadiEstbsService.modifyOclhg(paramVO);
		
		if(result > 0 ) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
		}else {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
		
	}
	
	/**
	 * ㅁ 컨텐츠페이지 추가설정 - 담당관 정보삭제
	 * @param CntPageadiEstbsVO
	 * @return
	 */
	@RequestMapping(value={"/**/cntnts/cntPagadiEstbs/deleteOclghAjax.do","/{siteKey}/**/cntnts/cntPagadiEstbs/deleteOclghAjax.do"})
	public String deleteOclghAjax (
		@ModelAttribute("paramVO") CntPageadiEstbsVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getLoginVO().getUserId());
		
		
		int result = cntPageadiEstbsService.deleteOclhg(paramVO);
		
		if(result > 0 ) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
		}else {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
		
	}
	
	/**
	 * ㅁ 컨텐츠페이지 추가설정 - 담당관 순서변경
	 * @param CntPageadiEstbsVO
	 * @return
	 */
	@RequestMapping(value={"/**/cntnts/cntPagadiEstbs/OclhgOrdrChangeAjax.do","/{siteKey}/**/cntnts/cntPagadiEstbs/OclhgOrdrChangeAjax.do"})
	public String OclhgOrdrChangeAjax (
		@ModelAttribute("paramVO") CntPageadiEstbsVO paramVO
		, HttpServletRequest request
		, String ordrSe
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getLoginVO().getUserId());
		
		int result = 0;
		
		if(ordrSe != null) {
			result = cntPageadiEstbsService.oclhgOrdrChange(paramVO, ordrSe);
		}
		
		if(result > 0 ) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
		}else {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
		
	}
	
	
	
	
	/**
	 * ㅁ 컨텐츠페이지 추가설정 - 저작권 추가
	 * @param CntPageadiEstbsVO
	 * @return
	 */
	@RequestMapping(value={"/**/cntnts/cntPagadiEstbs/registPagecpyrhtAjax.do","/{siteKey}/**/cntnts/cntPagadiEstbs/registPagecpyrhtAjax.do"})
	public String registPagecpyrhtAjax (
		@ModelAttribute("paramVO") CntPageadiEstbsVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getLoginVO().getUserId());
		
		
		int result = cntPageadiEstbsService.registPagecpyrht(paramVO);
		
		if(result > 0 ) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
		}else {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
		
	}
	
	
	/**
	 * ㅁ 컨텐츠페이지 추가설정 - 평가하기 설정 추가
	 * @param CntPageadiEstbsVO
	 * @return
	 */
	@RequestMapping(value={"/**/cntnts/cntPagadiEstbs/registEvlEstbsAjax.do","/{siteKey}/**/cntnts/cntPagadiEstbs/registEvlEstbsAjax.do"})
	public String registEvlEstbsAjax (
		@ModelAttribute("paramVO") CntPageadiEstbsVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getLoginVO().getUserId());
		
		int result = cntPageadiEstbsService.registEvlEstbs(paramVO);
		
		if(result > 0 ) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
		}else {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
	}
	
	
	/**
	 * ㅁ 컨텐츠페이지 추가설정 - 평가 상세보기
	 * @param CntPageadiEstbsVO
	 * @return
	 */
	@RequestMapping(value={"/**/cntnts/cntPagadiEstbs/evlScoreDetailViewAjax.do","/{siteKey}/**/cntnts/cntPagadiEstbs/evlScoreDetailViewAjax.do"})
	public String evlScoreDetailViewAjax (
		@ModelAttribute("paramVO") CntPageadiEstbsVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CntPageadiEstbsVO evlEstbsSummary = cntPageadiEstbsService.selectEvlScoreSummary(paramVO);
		
		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(5);
        paginationInfo.setPageSize(5);
        paginationInfo.setTotalRecordCount(Integer.parseInt(evlEstbsSummary.getEvlCount()));
        
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        /** =================== paging 끝 =============================== */
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getLoginVO().getUserId());
		
		List<CntPageadiEstbsVO> evlScoreList = cntPageadiEstbsService.selectEvlScoreList(paramVO);
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("evlEstbsSummary", evlEstbsSummary);
		model.addAttribute("evlScoreList", evlScoreList);
		
		return "wzwg/site/mngr/cntnts/cntPagadiEstbs/cntPagadiEvlDetailView";
	}
	
	
	/**
	 * ㅁ 컨텐츠페이지 추가설정 - 평가 상세보기 엑셀다운로드
	 * @param CntPageadiEstbsVO
	 * @return
	 */
	@RequestMapping(value={"/**/cntnts/cntPagadiEstbs/evlScoreExcelAjax.do","/{siteKey}/**/cntnts/cntPagadiEstbs/evlScoreExcelAjax.do"})
	public strictfp void evlScoreExcelAjax (
		@ModelAttribute("paramVO") CntPageadiEstbsVO paramVO
		, HttpServletResponse response
		, HttpServletRequest request
		, Model model) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		paramVO.setLastUpdusrId(CmmSessionUtil.getLoginVO().getUserId());
		
		/* 게시판용 bbsSeq 를 contentsSeq 로 변환 */
    	String bbsSeq = paramVO.getBbsSeq();
    	if(bbsSeq != null && bbsSeq.equals("") == false) {
    		paramVO.setCntntsSeq(bbsSeq);
    	}
		
    	CntPageadiEstbsVO cntntsNm = cntPageadiEstbsService.selectCntntsNm(paramVO);
    	
		String fileName= cntntsNm.getCntntsNm()+"_평가상세보기목록"; 
		
		HashMap<String, Object> beans = new HashMap<String, Object>();
		paramVO.setUseAt("Y");
		
		CntPageadiEstbsVO evlEstbsSummary = cntPageadiEstbsService.selectEvlScoreSummary(paramVO);
		
		double avg = Math.round(Double.parseDouble(evlEstbsSummary.getEvlAverage())*100)/100.0;

		evlEstbsSummary.setEvlAverage(Double.toString(avg));
		
		beans.put("evlScoreList", cntPageadiEstbsService.selectEvlScoreList(paramVO));
		beans.put("cntntname", cntntsNm.getCntntsNm());
		beans.put("evlEstbsSummary", evlEstbsSummary);
		
		ExcelCreater.excelCreate(request, response, beans, "Globals.evlScoreExcelForm", fileName);
	}
	
	
	
	/**
	 * ㅁ 컨텐츠페이지 추가설정 - 스킨 설정 추가
	 * @param CntPageadiEstbsVO
	 * @return
	 */
	@RequestMapping(value={"/**/cntnts/cntPagadiEstbs/registSkinEstbsAjax.do","/{siteKey}/**/cntnts/cntPagadiEstbs/registSkinEstbsAjax.do"})
	public String registSkinEstbsAjax (
		@ModelAttribute("paramVO") CntPageadiEstbsVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getLoginVO().getUserId());
		
		int result = cntPageadiEstbsService.registSkinEstbs(paramVO);
		
		if(result > 0 ) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
		}else {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
	}
	
	
	
	
	
	
	
	
	
	
	/**
	 * ㅁ 컨텐츠페이지 추가설정 - 사용자화면 (콤포넌트 형태- JSP include)
	 * @param CntPageadiEstbsVO
	 * @return
	 */
	@RequestMapping(value={"/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do","/{siteKey}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do"})
	public String selectCntPagadiEstbsUsrAjax (
		@ModelAttribute("paramVO") CntPageadiEstbsVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		/* 게시판용 bbsSeq 를 contentsSeq 로 변환 */
    	String bbsSeq = paramVO.getBbsSeq();
    	if(bbsSeq != null && bbsSeq.equals("") == false) {
    		paramVO.setCntntsSeq(bbsSeq);
    	}
    	
    	/* nttSeqAt 를 이용해서 nttSeq 값의 사용여부를 결정한다 */
    	if(paramVO.getNttSeqAt() != null && paramVO.getNttSeqAt().equals("N")) {
    		paramVO.setNttSeq(null);
    	}
    	
    	/* 페이지 추가설정 정보 조회 */
    	CntPageadiEstbsVO pageadiEstbsVO = cntPageadiEstbsService.selectCntPageadiEstbs(paramVO);
    	
    	/* resultVO가 null 일경우 기본값 세팅해줌 */
    	if(pageadiEstbsVO == null) {
    		paramVO.setPagadiestbsSeq(cntPageadiEstbsService.selectCntPageadiEstbsSeq());
    		paramVO.setFrstRegisterId("SYSTEM");
    		cntPageadiEstbsService.registCntPageadiEstbs(paramVO);
    		
    		pageadiEstbsVO = cntPageadiEstbsService.selectCntPageadiEstbs(paramVO);
    	}
    	
    	model.addAttribute("pageadiEstbsVO", pageadiEstbsVO);
    	
    	paramVO.setPagadiestbsSeq(pageadiEstbsVO.getPagadiestbsSeq());
    	
    	
    	
    	/* 담당관 목록 조회 */
    	List<CntPageadiEstbsVO> oclhgList = cntPageadiEstbsService.selectOclhgList(paramVO);
    	
    	model.addAttribute("oclhgList", oclhgList);
		
    	
    	/* 저작권 정보 조회 */
    	CntPageadiEstbsVO cpyrhtVO = cntPageadiEstbsService.selectPagecpyrht(paramVO);
    	
    	model.addAttribute("cpyrhtVO", cpyrhtVO);
    	
    	/* 평가하기 설정 조회 */
    	CntPageadiEstbsVO evlEstbs = cntPageadiEstbsService.selectEvlEstbs(paramVO);
    	
    	model.addAttribute("evlEstbsVO", evlEstbs);
    	
    	/* 스킨 설정 조회 */
    	CntPageadiEstbsVO skinEstbs = cntPageadiEstbsService.selectSkinEstbs(paramVO);
    	
    	model.addAttribute("skinEstbsVO", skinEstbs);
    	
		return "wzwg/site/mngr/cntnts/cntPagadiEstbs/cntPagadiEstbsUsr";
	}
	
	/**
	 * ㅁ 컨텐츠페이지 추가설정 - 평가하기 사용자 점수 입력
	 * @param CntPageadiEstbsVO
	 * @return
	 */
	@RequestMapping(value={"/usr/cntnts/cntPagadiEstbs/registEvlScoreAjax.do","/{siteKey}/usr/cntnts/cntPagadiEstbs/registEvlScoreAjax.do"})
	public String registEvlScoreAjax (
		@ModelAttribute("paramVO") CntPageadiEstbsVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);

		String userId = ""; 
		
		if(CmmSessionUtil.getLoginVO() == null) {
			userId = "비회원";
		}else {
			userId = CmmSessionUtil.getLoginVO().getUserId();
		}

		paramVO.setFrstRegisterId(userId);
		
		int result = cntPageadiEstbsService.registEvlScore(paramVO);
		
		if(result > 0 ) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
		}else {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
		
	}
}
