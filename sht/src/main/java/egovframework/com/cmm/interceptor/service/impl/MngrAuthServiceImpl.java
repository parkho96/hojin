package egovframework.com.cmm.interceptor.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.interceptor.service.MngrAuthService;
import egovframework.com.cmm.interceptor.service.MngrAuthVO;

@Service("MngrAuthService")
public class MngrAuthServiceImpl extends EgovAbstractServiceImpl implements MngrAuthService {

    @Resource(name = "MngrAuthDAO")
    private MngrAuthDAO mngrAuthDAO;

    @Cacheable(value = "selectMngrConCodeMapList")
    public HashMap<String, List<String[]>> selectMngrConCodeList(EgovMap paramMap) throws Exception {

        List<EgovMap> codeGrpList = mngrAuthDAO.selectMngrConCodeGrpList(paramMap);

        List<EgovMap> codeList = mngrAuthDAO.selectMngrConCodeList(paramMap);

        HashMap<String, List<String[]>> retMap = new HashMap<String, List<String[]>>();

        for (int i = 0; i < codeGrpList.size(); i++) {

            EgovMap getMap = (EgovMap) codeGrpList.get(i);
            String codeGrp = (String) getMap.get("authgrpId");

            List<String[]> putList = new ArrayList<String[]>();

            for (int j = 0; j < codeList.size(); j++) {

                EgovMap getCodeMap = (EgovMap) codeList.get(j);

                String getCodeId = (String) getCodeMap.get("authgrpId");

                if (codeGrp.equals(getCodeId)) {
                    String[] listStrPut = { (String) getCodeMap.get("conUrl"), (String) getCodeMap.get("conPrefix") };
                    System.out.println(i + "," + j);
                    putList.add(listStrPut);
                }
            }

            retMap.put(codeGrp, putList);
        }

        return retMap;
    }

    public List<EgovMap> selectMngrConAuthList(MngrAuthVO paramVO) throws Exception {
        return mngrAuthDAO.selectMngrConAuthList(paramVO);
    }

    public void registMngrConAuth(MngrAuthVO paramVO) throws Exception {

        mngrAuthDAO.deleteMngrConAuth(paramVO);

        String[] codegrpSeqArr = paramVO.getCodegrpSeqArr();

        if (codegrpSeqArr != null) {

            for (int i = 0; i < codegrpSeqArr.length; i++) {

                String codegrpSeq = StringUtils.defaultString(codegrpSeqArr[i]);

                if (!"".equals(codegrpSeq)) {

                    paramVO.setCodegrpSeq(codegrpSeq);

                    mngrAuthDAO.registMngrConAuth(paramVO);
                }
            }
        }
    }

    public List<MngrAuthVO> selectMngrConAuthUsr(MngrAuthVO paramVO) throws Exception {
        return mngrAuthDAO.selectMngrConAuthUsr(paramVO);
    }
}
