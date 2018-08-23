package com.board;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.join.CustomInfo;

import util.DBCPConn;
import util.MyUtil;

public class BoardServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		doPost(req, resp);
	}

	// forward 호출하면서 경로(url)만 정해주면 된다
	protected void forward(HttpServletRequest req, HttpServletResponse resp,
			String url) throws ServletException, IOException {

		RequestDispatcher rd = req.getRequestDispatcher(url);

		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
	
		//req.setCharacterEncoding("UTF-8");
		String cp = req.getContextPath();
		
		Connection conn = DBCPConn.getConnection();
		BoardDAO dao = new BoardDAO(conn);
		
		MyUtil myUtil = new MyUtil();//게시판에서만 쓰는것
			
		String url;//forward 때문에 변수하나 지정
		
		//주소 읽어오는 코딩 || study이후 주소를 읽어오는 코딩/bbs/list.jsp 
		String uri = req.getRequestURI();
		
		//cp :/study
		//uri :/study/serlvet/test9.jsp
		
		
		//study/bbs/list.jsp     | 진짜 주소
		//study/sboard/list.do | 가상 주소 - 사용자들은 이걸 이용
		
		if(uri.indexOf("created.do")!=-1){
			
			HttpSession session = req.getSession();
			
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			
			if(info==null){
				
				url = "/member/login.jsp";
				forward(req, resp, url);
				return; //return은 if안에꺼 실행시키지마라
			}
			
			
			url = "/bbs/created.jsp";
			forward(req, resp, url);
		
		}else if(uri.indexOf("created_ok.do")!=-1){
			
			BoardDTO dto = new BoardDTO();
			
			int maxNum = dao.getMaxNum();
			
			dto.setNum(maxNum+1);
			dto.setName(req.getParameter("name"));
			dto.setSubject(req.getParameter("subject"));
			dto.setEmail(req.getParameter("email"));
			dto.setContent(req.getParameter("content"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setIpAddr(req.getRemoteAddr());
			
			dao.inserData(dto);
			
			//가상의 주소를 써야한다(client가 보는 주소이기때문)
			url = cp + "/sboard/list.do";
			resp.sendRedirect(url);
			
		
		}else if(uri.indexOf("list.do")!=-1){
			
			String pageNum = req.getParameter("pageNum");
			int currentPage = 1;
			
			if(pageNum != null) 
				currentPage = Integer.parseInt(pageNum);
			
			//검색
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchKey==null){
				searchKey = "subject";
				searchValue = "";
			}else{
				if(req.getMethod().equalsIgnoreCase("GET")){
					searchValue=URLDecoder.decode(searchValue, "UTF-8");
				}
			}
			
			//전체 데이터 갯수
			int numPerPage = 5;
			int dataCount = dao.getDataCount(searchKey, searchValue);
			
			int totalPage = myUtil.getPageCount(numPerPage, dataCount);
			
			//삭제후 전체페이지수보다 표시할 페이지가 큰 경우
			if(currentPage>totalPage)
				currentPage=totalPage;
			
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;
			
			List<BoardDTO> lists = dao.getLists(start, end, searchKey, searchValue);
			
			//페이징 처리
			String param = "";
			if(!searchValue.equals("")){
				param = "searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}
			
			String listUrl = cp + "/sboard/list.do";//가상의 주소 설정
			
			//검색을 했으면
			if(!param.equals("")){
				listUrl = listUrl + "?" + param;
			}
			
			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
														//(9,12,list.jsp)를 MyUtil로 넘김
			
			//글보기 주소(나올때 page 넘을 받아와야지 나와도 그 페이지에 있다
			String articleUrl = cp + "/sboard/article.do?pageNum=" + currentPage;
			
			if(!param.equals("")){
				articleUrl = articleUrl + "&" + param;
			}
			
			//foward 페이지에 데이터를 넘김
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("articleUrl", articleUrl);
			
			url = "/bbs/list.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("article.do")!=-1){
			
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchKey != null) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
				
			}
			
			//조회수 증가
			dao.updateHitCount(num);
			
			//데이터 읽기
			BoardDTO dto = dao.getReadData(num);
			
			if(dto == null) {
				url = cp + "/sboard/list.do";
				resp.sendRedirect(url);
			}
			
			int lineSu = dto.getContent().split("\n").length;
			
			dto.setContent(dto.getContent().replaceAll("\n", "<br/>"));
			
			String param = "pageNum=" + pageNum;
			if(searchKey != null) {
				param += "&searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}
			
			req.setAttribute("dto", dto);
			//param이 예약어 이기때문에 다른것으로 바꿔줘야한다
			req.setAttribute("params", param);
			req.setAttribute("lineSu", lineSu);
			req.setAttribute("pageNum", pageNum);
			
			url = "/bbs/article.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("updated.do")!=-1){
			
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchKey != null) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
				
			}
			
			if(searchKey!=null){//검색하면!
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}else{//검색 안하면
					searchKey = "subject";//기본값 넣어줌
					searchValue = "";
			}
			
			BoardDTO dto = dao.getReadData(num);
			
			if(dto == null){
				url = cp + "/sboard/list.do";
				resp.sendRedirect(url);
			}
			
			String param = "pageNum="+pageNum;
			
			if(searchKey != null){
				param = "searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("params", param);
			req.setAttribute("searchKey", searchKey);
			req.setAttribute("searchValue", searchValue);
		
			url = "/bbs/updated.jsp";
			forward(req, resp, url);
		
		}else if(uri.indexOf("updated_ok.do")!=-1){
		
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			BoardDTO dto = new BoardDTO();
			
			dto.setNum(Integer.parseInt(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setName(req.getParameter("name"));
			dto.setEmail(req.getParameter("email"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setContent(req.getParameter("content"));
			
			dao.updateData(dto);
			
			String params = "pageNum="+pageNum;
			
			if(searchKey != null){
				params = "searchKey=" + searchKey;
				params += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}
			
			url = cp + "/sboard/list.do?" + params;
			resp.sendRedirect(url);
			
		}else if(uri.indexOf("deleted.do")!=-1){
			
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			dao.deleteData(num);
			
			String params = "pageNum="+pageNum;
			
			if(searchKey != null){
				params = "searchKey=" + searchKey;
				params += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}
			
			url = cp + "/sboard/list.do?" + params;
			resp.sendRedirect(url);
			
		}
	
	
	
	
	
	
	
	
	
	}
}
