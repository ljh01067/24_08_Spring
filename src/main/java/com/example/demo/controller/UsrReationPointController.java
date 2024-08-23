package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.service.ArticleService;
import com.example.demo.service.BoardService;
import com.example.demo.service.ReactionPointService;
import com.example.demo.vo.Article;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

public class UsrReationPointController {

	@Autowired
	private Rq rq;

	@Autowired
	private ReactionPointService reactionPointService;
	
	@RequestMapping("/usr/reactionPoint/doGoodReation")
	public String doGoodReation(HttpServletRequest req, String relTypeCode, int relId) {

	
		int userCanReaction = reactionPointService.userCanReaction(rq.getLoginedMemberId(),relTypeCode,relId);
	

		return "usr/article/detail";
	}

}
