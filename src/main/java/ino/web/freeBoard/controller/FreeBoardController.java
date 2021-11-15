package ino.web.freeBoard.controller;

import ino.web.commonCode.service.CommCodeService;
import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;

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

@Controller
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;
	
	@Autowired
	private CommCodeService commCodeService;

	@RequestMapping("/main.ino")
	public ModelAndView main(HttpServletRequest request,Map<String, Object> data){
		ModelAndView mav = new ModelAndView();
		int page = 1;
		
		
		int totalCount = freeBoardService.totalCount(data);
		//한 페이지에서 게시물 갯수
		int limit = 5;
		
		
		//총페이지 갯수
		int maxPage = (totalCount+limit -1)/ limit; // (34 + 4) / 5  = 7.6  % 7
		//시작 페이지 수
		int startPage =((page-1)/ 10)*10+1;
		//마지막 페이지수
		int endPage = startPage + 10 - 1;
		
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		
		System.out.println("page : "+ page);
		System.out.println("startPage : " +startPage);
		System.out.println("endPage : "+endPage);
		System.out.println("maxpage : " +maxPage);
		System.out.println("totalCount : " +totalCount);
		
		data.put("page", page);
		data.put("startPage", startPage);
		data.put("endPage", endPage);
		data.put("maxPage", maxPage);
		data.put("totalCount", totalCount);
		data.put("limit", limit);
		

		

		mav.addObject("startPage",startPage);
		mav.addObject("endPage",endPage);
		mav.addObject("page",page);
		mav.addObject("totalCount", totalCount);
		mav.addObject("maxPage",maxPage);
		
		
		mav.setViewName("boardMain");
	
		
		List<FreeBoardDto> list = freeBoardService.freeBoardList(data);
		
		mav.addObject("freeBoardList",list);
		
		List<HashMap<String,Object>> code_list = commCodeService.selectCommonCodeList();
		System.out.println("코드리스트 : "+code_list);
		mav.addObject("code_list", code_list);
		return mav;
	}
	
	@RequestMapping("/freeBoardInsert.ino")
	public String freeBoardInsert(){
		return "freeBoardInsert";
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardInsertPro.ino")
	public Map<String, Object> freeBoardInsertPro(HttpServletRequest request, FreeBoardDto dto){
		Map<String, Object> map = new HashMap<>();
		System.out.println(dto);
		
		try {
			
			freeBoardService.freeBoardInsertPro(dto);
			int num = freeBoardService.getNewNum();
			System.out.println("새로운 게시물 번호 : "+num);
			map.put("num", num);
			map.put("result", true);
			
			
		}catch (Exception e) {
			map.put("result", false);
			map.put("error", e);
		}
		
		
		return map;
	}
	@ResponseBody
	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request,FreeBoardDto dto){
		System.out.println("게시판 번호 : "+dto.getNum());
		
		ModelAndView mav = new ModelAndView();
		
		FreeBoardDto result = freeBoardService.getDetailByNum(dto.getNum());
		System.out.println("게시물 종류 : "+result.getCodeType());
		mav.setViewName("freeBoardDetail");
		mav.addObject("freeBoardDto", result);
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardModify.ino")
	public Map<String, Object> freeBoardModify(HttpServletRequest request, FreeBoardDto dto){
		Map<String, Object> map = new HashMap<>();
		try {

			FreeBoardDto num = freeBoardService.getDetailByNum(dto.getNum());
//			System.out.println("게시판 번호 : "+num);
			freeBoardService.freeBoardModify(dto);
			map.put("num", num);
			map.put("result", true);
			
		} catch (Exception e) {
			map.put("result", false);
			map.put("error", e);
		}
		
		return map;
	}

	@ResponseBody
	@RequestMapping("/freeBoardDelete.ino")
	public  Map<String, Object> FreeBoardDelete(HttpServletRequest request,FreeBoardDto dto){
		Map<String, Object> map = new HashMap<>();
		try {
			FreeBoardDto num = freeBoardService.getDetailByNum(dto.getNum());
			
			freeBoardService.FreeBoardDelete(num);
			map.put("num", num);
			map.put("result", true);
			
			
		} catch (Exception e) {
			map.put("result", false);
			map.put("error", e);
		}
		return map;
	}
	@ResponseBody
	@RequestMapping("/freeBoardCheckDelete.ino")
	public Map<String, Object> FreeBoardCheckDelete(@RequestParam(value="checkArr") List<Integer> checkArr){
		
		Map<String, Object> map = new HashMap<>();
			for(int i : checkArr) {
				System.out.println(i);
			}
		try {
						
				freeBoardService.FreeBoardCheckDelete(checkArr);
					
			
			map.put("result", true);
			
		} catch (Exception e) {
			map.put("result", false);
			map.put("error", e);
		}
		
		return map;
	}
		
	@ResponseBody
	@RequestMapping("/freeBoardSearch.ino")
	public Map<String,Object> FreeBoardTypeList(
						@RequestParam Map<String, Object> data,
						@RequestParam int page
						){
		Map<String, Object> map = new HashMap<>();
		
		
		
		/*페이지 처리*/
		
		//전체 갯수
		int totalCount = freeBoardService.totalCount(data);
		//한 페이지에서 게시물 갯수
		int limit = 5;
		
		
		//총페이지 갯수
		int maxPage = (totalCount+limit -1)/ limit; // (34 + 4) / 5  = 7.6  % 7
		
		//시작 페이지 수
		int startPage =((page-1)/ 10)*10+1;
		
		//마지막 페이지수
		int endPage = startPage + 10 - 1;
		
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		System.out.println("page : "+ page);
		System.out.println("startPage : " +startPage);
		System.out.println("endPage : "+endPage);
		System.out.println("maxpage : " +maxPage);
		System.out.println("totalCount : " +totalCount);
	
		data.put("page", page);
		data.put("startPage", startPage);
		data.put("endPage", endPage);
		data.put("maxPage", maxPage);
		data.put("totalCount", totalCount);
		data.put("limit", limit);
		
		
		map.put("page", page);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("maxPage", maxPage);

		List<FreeBoardDto> list=freeBoardService.freeBoardList(data);
		map.put("list", list);
		
		
		
		System.out.println("map 내용 : " +map.get("page"));
		
		
		return map;
		
	}

	
	
	
	
}