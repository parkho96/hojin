package egovframework.wzwg.module.map.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.IllegalFormatException;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmJsonAjaxResponser;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.map.service.ModuleMapService;
import egovframework.wzwg.module.map.service.ModuleMapVO;
import egovframework.wzwg.module.scrin.service.ScrinCntntsService;
import egovframework.wzwg.module.scrin.service.ScrinCntntsVO;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatService;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONObject;
import okhttp3.Call;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

@Controller
@Slf4j
public class ModuleMapController {
	@Resource(name = "ModuleMapService")
	ModuleMapService moduleMapService;

	@Resource(name = "CntntsTmplatService")
	CntntsTmplatService cntntsTmplatService;

	/** 화면 컨텐츠 **/
	@Resource(name = "ScrinCntntsService")
	private ScrinCntntsService scrinCntntsService;

	/**
	 * 지도 데이터 리스트
	 */
	@RequestMapping(value = "/**/module/map/selectMapDetailAjax.do")
	public String selectCntntsCnListAjax(
			@ModelAttribute("paramVO") ModuleMapVO paramVO, HttpServletRequest request, ModelMap model)
			throws Exception {

		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);

		model.addAttribute("result", moduleMapService.selectModuleMapDetail(paramVO));
		model.addAttribute("resultVO", paramVO);
		return "wzwg/module/map/mapDetail";
	}

	/**
	 * 지도 데이터 등록 폼
	 */
	@RequestMapping(value = "/**/module/map/registModuleMapFormAjax.do")
	public String registModuleMapFormAjax(
			@ModelAttribute("paramVO") ModuleMapVO paramVO, HttpServletRequest request, ModelMap model)
			throws Exception {

		/** 수정일때는 등록되어있는 데이터 조회 // 등록일 경우에는 적용되어있는 템플릿 조회 */
		if (!("").equals(paramVO.getMapSeq())) {

			/** 사이트 시퀀스 입력 */
			String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
			paramVO.setSiteSeq(siteSeq);

			ModuleMapVO resultVO = moduleMapService.selectModuleMapDetail(paramVO);
			model.addAttribute("resultVO", resultVO);

		} else {
			model.addAttribute("resultVO", paramVO);
		}

		return "wzwg/module/map/mapForm";
	}

	/**
	 * 템플릿 컨텐츠 불러오기
	 */
	@RequestMapping(value = "/**/module/map/selectTmplatCnAjax.do")
	public String selectTmplatCnAjax(
			@ModelAttribute("paramVO") ModuleMapVO paramVO, HttpServletRequest request, Model model) throws Exception {

		CntntsTmplatVO cntntsTmplatVO = new CntntsTmplatVO();
		cntntsTmplatVO.setTmplatSeq(paramVO.getTmplatSeq());
		cntntsTmplatVO = cntntsTmplatService.selectCntntsTmplatDetail(cntntsTmplatVO);

		Map<String, String> ajaxResponse = new HashMap<String, String>();
		ajaxResponse.put("result", "success");
		ajaxResponse.put("tmplatCn", cntntsTmplatVO.getTmplatCn());
		model.addAttribute("ajaxResponse", ajaxResponse);
		return "wzwg/webModule/json";
	}

	/**
	 * 지도 데이터 등록
	 */
	@RequestMapping(value = "/**/module/map/registModuleMapAjax.do")
	public ModelAndView registModuleCntntsCnAjax(
			@ModelAttribute("paramVO") ModuleMapVO paramVO, HttpServletRequest request, ModelMap model)
			throws Exception {

		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());

		moduleMapService.registModuleMapAjax(paramVO);

		return CmmAjaxUtil.getAjaxReturn("success");
	}

	/**
	 * 지도 데이터 수정
	 */
	@RequestMapping(value = "/**/module/map/modifyModuleMapAjax.do")
	public ModelAndView modifyModuleMapAjax(
			@ModelAttribute("paramVO") ModuleMapVO paramVO, HttpServletRequest request, ModelMap model)
			throws Exception {

		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());

		int resultCnt = moduleMapService.modifyModuleMapAjax(paramVO);
		if (resultCnt > 0) {
			return CmmAjaxUtil.getAjaxReturn("success");
		} else {
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}

	/**
	 * 지도 데이터 삭제
	 */
	@RequestMapping(value = "/**/module/cntnts/deleteModuleMapAjax.do")
	public ModelAndView deleteModuleCntntsCnAjax(
			@ModelAttribute("paramVO") ModuleMapVO paramVO, HttpServletRequest request, ModelMap model)
			throws Exception {

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());

		int deleteResult = moduleMapService.deleteModuleMapAjax(paramVO);

		if (deleteResult > 0) {
			return CmmAjaxUtil.getAjaxReturn("success");
		} else {
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}

	/**
	 * 지도 데이터 생성
	 */
	@RequestMapping(value = "/**/module/map/getGeoCodeAjax.do")
	public ModelAndView getGeoCodeAjax(@ModelAttribute("paramVO") ModuleMapVO paramVO, String width, String height,
			HttpServletRequest request, ModelMap model) throws Exception {

		String clientId = "qzjnbwqkc5";
		String clientSecret = "peCAsJnSLzZumxIJG9wV2WCb1YE7ZL7S4AJvhpfJ";
		String kakaoClientId = "f18c996b28f24d55c2d0695bedd53009";

		Map<String, Object> result = new HashMap<>();
		String x = "";
		String y = "";
		CmmJsonAjaxResponser responser = CmmJsonAjaxResponser.getInstance();
		HttpURLConnection con = null;

		try {
			String addr = URLEncoder.encode(paramVO.getMapAddr(), "UTF-8");
			String apiURL = "https://dapi.kakao.com/v2/local/search/address?query=" + addr;

			URL url = new URL(apiURL);
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", "KakaoAK " + kakaoClientId);

			int responseCode = con.getResponseCode();

			// [수정 포인트] Try-with-resources 사용하여 자원 누수 원천 차단
			try (InputStream is = (responseCode == 200) ? con.getInputStream() : con.getErrorStream();
					InputStreamReader isr = new InputStreamReader(is, "UTF-8");
					BufferedReader br = new BufferedReader(isr)) {

				String inputLine;
				StringBuilder responseBuffer = new StringBuilder();
				while ((inputLine = br.readLine()) != null) {
					responseBuffer.append(inputLine);
				}

				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> map = mapper.readValue(responseBuffer.toString(), Map.class);
				List<Map<String, Object>> m1 = (List<Map<String, Object>>) map.get("documents");

				if (m1 != null) {
					for (Object o : m1) {
						try {
							if (o instanceof Map) {
								Map t = (Map) o;
								x = String.valueOf(t.get("x"));
								y = String.valueOf(t.get("y"));
							}
						} catch (IllegalStateException e) {
							log.error("IllegalStateException : " + e);
						}
					}
				}
			}

			String imgPath = null;
			String resultCode = "fail";

			if (StringUtils.hasText(x) && StringUtils.hasText(y)) {
				// 좌표값이 있을 때만 이미지 생성 및 DB 등록
				// resultCode에 success 를 넣어준다
				imgPath = getBase64ImageToNaverImageMap(clientId, clientSecret, width, height, x, y, request);
				paramVO.setImgPath(imgPath);
				moduleMapService.registModuleMapImg(paramVO);
				resultCode = "success";
			}

			List<ModuleMapVO> mapImgList = new ArrayList<>();
			mapImgList.add(paramVO);
			model.addAttribute("mapImgList", mapImgList);

			responser.setResultCode(resultCode);
			responser.setBodyData("x", x);
			responser.setBodyData("y", y);
			responser.setResultJsp("imgList", "wzwg/module/map/mapImgList");

		} catch (NullPointerException e) {
			log.error("NullPointerException", e);
		} catch (NumberFormatException e) {
			log.error("NumberFormatException", e);
		} catch (IllegalFormatException e) {
			log.error("IllegalFormatException", e);
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("ArrayIndexOutOfBoundsException", e);
		} catch (IOException e) {
			log.error("IOException", e);
		} finally {
			if (con != null) {
				con.disconnect();
			}
		}

		return responser.returnModelAndView();
	}

	public String getBase64ImageToNaverImageMap(String clientId, String clientSecret, String width, String height,
			String x, String y, HttpServletRequest req) {
		String result = "";
		OkHttpClient client = new OkHttpClient.Builder()
				.connectTimeout(100L, TimeUnit.SECONDS)
				.build();
		// request 생성
		// Request okrequest;// = builder.build();
		// System.out.println("req.getLocalPort() :"+req.getLocalPort());
		Request okrequest = new Request.Builder()
				.url("https://naveropenapi.apigw.ntruss.com/map-static/v2/raster?center="
						+ x + ","
						+ y + "&w="
						+ width + "&h="
						+ height + "&level=16&scale=2&format=png&markers=type:d|size:mid|color:blue|pos:" + x + " " + y)
				.addHeader("X-NCP-APIGW-API-KEY-ID", clientId)
				.addHeader("X-NCP-APIGW-API-KEY", clientSecret)
				.build();

		Response okresponse;

		Call call = null;
		OutputStream os = null;
		InputStream is = null;
		try {
			call = client.newCall(okrequest);
			okresponse = call.execute();

			/*
			 * InputStream inputStream = okresponse.body().byteStream();
			 * ByteArrayOutputStream byteOutStream = new ByteArrayOutputStream();
			 * 
			 * int len = 0;
			 * byte[] buf = new byte[1024];
			 * while( (len = inputStream.read( buf )) != -1 ) {
			 * byteOutStream.write(buf, 0, len);
			 * }
			 * 
			 * 
			 * byte[] fileArray = byteOutStream.toByteArray();
			 * String imageString = new String( Base64.encodeBase64( fileArray ) );
			 * 
			 * result = "data:image/png;base64, "+ imageString;
			 */

			String siteSeq = CmmSessionUtil.getSessionSiteSeq(req);
			String mudulePath = "upload/" + siteSeq + "/module/map/";
			String dftFilePath = req.getSession().getServletContext().getRealPath("/");
			// 파일 기본경로 _ 상세경로
			// String filePath = dftFilePath + "smartEditor2.8.2.1" + File.separator +
			// "multiupload" + File.separator;
			String filePath = dftFilePath + mudulePath;

			File file = new File(filePath);
			if (!file.exists()) {
				if (!file.mkdirs()) {
					log.info(file + " : directory make fail ");
				}
			}
			String realFileNm = "";
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
			String today = formatter.format(new java.util.Date());
			// realFileNm = today + UUID.randomUUID().toString() +
			// filename.substring(filename.lastIndexOf("."));
			realFileNm = today + UUID.randomUUID().toString() + ".jpg";
			String rlFileNm = filePath + realFileNm;
			///////////////// 서버에 파일쓰기 /////////////////
			is = okresponse.body().byteStream();
			os = new FileOutputStream(rlFileNm);
			int numRead;
			byte b[] = new byte[1024];
			while ((numRead = is.read(b, 0, b.length)) != -1) {
				os.write(b, 0, numRead);
			}
			if (is != null) {
				is.close();
			}
			os.flush();
			os.close();

			result = mudulePath + realFileNm;
			// System.out.println(resultJson);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			log.error("IOException", e);
		} finally {
			if (call != null) {
				call.cancel();
				client = null;
			}
			if (os != null)
				try {
					os.close();
				} catch (IOException e) {
					log.error("IOException", e);
				}
			if (is != null)
				try {
					is.close();
				} catch (IOException e) {
					log.error("IOException", e);
				}
		}

		return result;
	}

	/**
	 * 지도 이미지 정보 조회
	 */
	@RequestMapping(value = "/**/module/map/selectMapImgListAjax.do")
	public String selectMapImgListAjax(
			@ModelAttribute("paramVO") ModuleMapVO paramVO, HttpServletRequest request, ModelMap model)
			throws Exception {

		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);

		List<ModuleMapVO> mapImgList = moduleMapService.selectModuleMapImgListAjax(paramVO);
		model.addAttribute("mapImgList", mapImgList);
		return CmmJsonAjaxResponser.getInstance().setResultCode("success")
				.setResultJsp("imgList", "wzwg/module/map/mapImgList").returnJsp(model);
		// return "wzwg/module/map/mapImgList";
	}

	/**
	 * 지도 이미지 정보 입력
	 */
	// @RequestMapping(value="/**/module/map/registMapImgAjax.do")
	// public String registMapImgAjax(
	// @ModelAttribute("paramVO") ModuleMapVO paramVO
	// , HttpServletRequest request
	// , ModelMap model
	// ) throws Exception{
	//
	// /** 사이트 시퀀스 입력 */
	// String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
	//
	// Map<String, String> ajaxResponse = new HashMap<String, String>();
	// ajaxResponse.put("result", "success");
	// model.addAttribute("ajaxResponse", ajaxResponse);
	// return "wzwg/webModule/json";
	// }

	/**
	 * 지도 이미지 정보 변경(삭제/기본값 변경)
	 */
	@RequestMapping(value = "/**/module/map/modifyMapImgAjax.do")
	public String modifyMapImgAjax(
			@ModelAttribute("paramVO") ModuleMapVO paramVO, HttpServletRequest request, ModelMap model)
			throws Exception {

		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);

		if (StringUtils.isEmpty(paramVO.getDefaultYn()) == false) {
			moduleMapService.modifyModuleMapImgDefaultClear(paramVO);
		}

		int result = moduleMapService.modifyModuleMapImgAjax(paramVO);
		String resultCode = "";
		if (result > 0) {
			resultCode = "success";
		} else {
			resultCode = "fail";
		}

		// Map<String, String> ajaxResponse = new HashMap<String, String>();
		// if(result > 0){
		// ajaxResponse.put("result", "success");
		// }else{
		// ajaxResponse.put("result", "fail");
		// }
		// model.addAttribute("ajaxResponse", ajaxResponse);
		// return "wzwg/webModule/json";
		return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).returnJsp(model);
	}

	@RequestMapping(value = "/**/module/map/jsonTestAjax.do")
	public String jsonTestAjax(
			@ModelAttribute("paramVO") ModuleMapVO paramVO, HttpServletRequest request, ModelMap model)
			throws Exception {
		System.out.println("jsonTestAjax");
		CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
		// return "wzwg/webModule/json";
		return "wzwg/webModule/jsonResponser";
		// return "wzwg/webModule/NewFile";
	}

	/**
	 * 유저페이지
	 * 
	 * @param args
	 */

	/**
	 * 지도 데이터 리스트
	 */
	@RequestMapping(value = "/**/module/map/selectUsrMapDetailAjax.do")
	public String selectUsrMapDetailAjax(
			@ModelAttribute("paramVO") ModuleMapVO paramVO, HttpServletRequest request, ModelMap model)
			throws Exception {
		try {
			paramVO.setMapinfoSeq(paramVO.getCntntsSeq());

		} catch (NullPointerException e) {
			log.error("NullPointerException", e);
		} catch (NumberFormatException e) {
			log.error("NumberFormatException", e);
		} catch (IllegalFormatException e) {
			log.error("IllegalFormatException", e);
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("ArrayIndexOutOfBoundsException", e);
		}
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);

		model.addAttribute("result", moduleMapService.selectModuleMapDetail(paramVO));
		model.addAttribute("resultVO", paramVO);
		return "wzwg/module/map/mapUsrDetail";
	}

	@RequestMapping(value = "/**/module/map/scrinCntntsJson.do")
	public ModelAndView selectScrinCntntsJson(
			@ModelAttribute("paramVO") ModuleMapVO paramVO, HttpServletRequest request) throws Exception {

		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);

		paramVO.setSiteSeq(siteSeq);

		ScrinCntntsVO scrinCntntsVO = new ScrinCntntsVO();
		scrinCntntsVO.setMenuSeq(paramVO.getMenuSeq());
		scrinCntntsVO.setSiteSeq(siteSeq);
		// 컨텐츠 정보를 가져옴
		ScrinCntntsVO cntntsInfo = scrinCntntsService.selectSitecntntsSeqByModuleInfo(scrinCntntsVO);

		paramVO.setMapSeq(cntntsInfo.getCntntsSeq());
		paramVO.setSiteSeq(siteSeq);

		// 컨텐츠 데이터를 가져옴
		paramVO.setMapinfoSeq(cntntsInfo.getCntntsSeq());
		List<ModuleMapVO> cntntsData = moduleMapService.selectMapScrinMainCntnts(paramVO);

		ModelAndView model = new ModelAndView();

		model.setViewName("jsonView");

		// 컨텐츠 데이터를 JSON 변환하여 넘김
		model.addObject("cntntsData", cntntsData);
		model.addObject("cntntsInfo", JSONObject.fromObject(cntntsInfo));

		return model;
	}
}
