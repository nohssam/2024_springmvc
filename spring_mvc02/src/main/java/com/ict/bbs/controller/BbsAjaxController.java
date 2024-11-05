package com.ict.bbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ict.bbs.service.BbsService;
import com.ict.bbs.vo.BbsVO;
import com.ict.common.Paging;

@RestController
public class BbsAjaxController {
	@Autowired
	private BbsService bbsService;
	
	@Autowired
	private Paging paging;
	
	@RequestMapping("/bbs_ajax")
	@ResponseBody
	public Map<String, Object> getBbsListAjax(@RequestParam(defaultValue = "1") int cPage) {
	    Map<String, Object> map = new HashMap<>();

	    // 1. 전체 게시물 수 가져오기 및 페이징 설정
	    int count = bbsService.getTotalCount();
	    paging.setTotalRecord(count);

	    if (paging.getTotalRecord() <= paging.getNumPerPage()) {
	        paging.setTotalPage(1);
	    } else {
	        paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage() + 
	                            (paging.getTotalRecord() % paging.getNumPerPage() > 0 ? 1 : 0));
	    }

	    paging.setNowPage(cPage);
	    paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() - 1));

	    // 블록 계산
	    paging.setBeginBlock(
	        (int) (((paging.getNowPage() - 1) / paging.getPagePerBlock()) * paging.getPagePerBlock() + 1));
	    paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() - 1);
	    if (paging.getEndBlock() > paging.getTotalPage()) {
	        paging.setEndBlock(paging.getTotalPage());
	    }

	    // DB에서 데이터 가져오기
	    List<BbsVO> list = bbsService.getBbsList(paging.getOffset(), paging.getNumPerPage());

	    map.put("list", list);
	    map.put("paging", paging);
	    return map;
	}

	
}
