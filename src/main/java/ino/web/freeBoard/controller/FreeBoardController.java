package ino.web.freeBoard.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.freeBoard.common.util.Pagination;
import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;


@Controller
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;
	//span단에서 함수로 검색 ajax를 호출시켜서 리스트를 재 반환시키면 되지않을까? 값은 어차피 폼 값 자체를 넘기는거니까, 거기에 temp값을 주는거야.
	//javascript:caseselect(i);
	@RequestMapping("/freeBoardselect.ino")
	@ResponseBody
	public Map<String, Object> main(HttpServletRequest request ,@RequestParam HashMap<String, Object> map,@RequestParam(value="temp", required=false)Integer temp) {
		// 게시글갯수구하기
		int listcnt = freeBoardService.freeBoardcnt(map);	

		// 게시글갯수
		System.out.println(listcnt);

		// 페이지설정?
		int curpage = 1;

		// 페이징 객체 생성자
		Pagination pagination = new Pagination(curpage, listcnt);
		
		if(temp==null || temp==1 || temp==0){
			map.put("start",pagination.getStart());
			map.put("end",pagination.getEnd());
		}else if(temp>1){
			map.put("end", pagination.getEnd()*temp);
			map.put("start",pagination.getEnd()*temp-9);
		}
		List<FreeBoardDto> list1 = freeBoardService.freeBoardList(map);
		map.put("list", list1);
		map.put("page", pagination.getPagination());
		return map;
	}

	@RequestMapping("/main.ino")
	@ResponseBody
	public ModelAndView main(HttpServletRequest request,@RequestParam(value="page", required=false)Integer temp) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> map = new HashMap<String, Object>();
	
		//공통코드 찾기
		List<Map<String, Object>> commonlist=freeBoardService.freeBoardcommon();

		// 게시글갯수구하기
		int listcnt = freeBoardService.freeBoardcnt(map);

		// 게시글갯수
		System.out.println(listcnt);

		// 페이지설정?
		int curpage = 1;
		
		// 페이징 객체 생성자
		Pagination pagination = new Pagination(curpage, listcnt);

		if(temp==null || temp==1||temp==0){
			map.put("start",pagination.getStart());
			map.put("end",pagination.getEnd());
		}else if(temp>1){
			map.put("end", pagination.getEnd()*temp);
			map.put("start",pagination.getEnd()*temp-9);
		}
		List<FreeBoardDto> list = freeBoardService.freeBoardList(map);
		mav.setViewName("boardMain");
		mav.addObject("freeBoardCommonList",commonlist);
		mav.addObject("freeBoardList", list);
		mav.addObject("pagination", pagination.getPagination());
		return mav;
	}

	@RequestMapping("/freeBoardInsert.ino")
	public ModelAndView freeBoardInsert() {
		ModelAndView mav = new ModelAndView();
		List<Map<String, Object>> commonlist=freeBoardService.freeBoardcommon();

		mav.setViewName("freeBoardInsert");
		mav.addObject("freeBoardCommonList",commonlist);
		return mav;
	}

	@RequestMapping("/freeBoardInsertPro.ino")
	@ResponseBody
	public Map<String, Object> freeBoardInsertPro(HttpServletRequest request, FreeBoardDto dto) {
		Map<String, Object> map = new HashMap<>();
		try {
			freeBoardService.freeBoardInsertPro(dto);
			map.put("check", true);

			map.put("num", freeBoardService.getNewNum());
		} catch (Exception e) {
			map.put("check", false);
			map.put("message", e);
		}

		// "redirect:freeBoardDetail.ino?num="+

		return map;
	}

	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request, int num) {
		// System.out.println(num);
		FreeBoardDto one = freeBoardService.freeBoardfindDto(num);
		// System.out.println(one.getCodeType());
		return new ModelAndView("freeBoardDetail", "freeBoardDto", one);
	}

	@RequestMapping("/freeBoardModify.ino")
	@ResponseBody
	public Map<String, Object> freeBoardModify(HttpServletRequest request, FreeBoardDto dto) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			freeBoardService.freeBoardModify(dto);
			map.put("num", 1);

		} catch (Exception e) {
			map.put("num", 0);
			map.put("error", e);
		}

		// "redirect:/main.ino"

		return map;
	}

	@RequestMapping("/freeBoardDelete.ino")
	@ResponseBody
	public Map<String, Object> freeBoardDelete(String n) {
		int num = Integer.parseInt(n);
		Map<String, Object> map = new HashMap<>();
		try {
			freeBoardService.freeBoardDelete(num);
			map.put("num", 1);

		} catch (Exception e) {
			map.put("num", 0);
			map.put("error", e);
		}
		return map;
	}

	@RequestMapping("/freeBoardDelCheck.ino")
	@ResponseBody
	public Map<String, Object> freeBoardDelCheck(HttpServletRequest request, String[] ArrayCheckbox) {
		ArrayList<Integer> check = new ArrayList<>();

		// 3
		/*
		 * for(String data:ArrayCheckbox){ System.out.println(data); }
		 */

		// 2
		// @RequestParam(value="ArrayCheckbox[]",required=false) List<String> b
		// @RequestParam 으로 배열을 넘기고 받는 주의할거는 객체명은 ArrayCheckbox로 넘겨도 받을때 가져올
		// 변수명에는 []배열 표시를 해야함
		/*
		 * int count=b.size(); for(int i=0;i<count;i++){
		 * check.add(Integer.parseInt(b.get(i))); }
		 */

		// 1
		String[] str = request.getParameterValues("ArrayCheckbox");
		Map<String, Object> map = new HashMap<String, Object>();
		for (String data : str) {
			check.add(Integer.parseInt(data));
		}
		try {
			freeBoardService.freeBoardDelete(check);
			map.put("num", 1);
		} catch (Exception e) {
			map.put("num", 0);
			map.put("error", e);
		}
		return map;

	}

}