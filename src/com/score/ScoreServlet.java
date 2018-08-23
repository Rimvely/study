package com.score;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;





import util.DBCPConn;
import util.MyUtil;

public class ScoreServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		doPost(req, resp);
	}
	
	protected void forward(HttpServletRequest req, HttpServletResponse resp,
			String url) throws ServletException, IOException {

		RequestDispatcher rd = req.getRequestDispatcher(url);

		rd.forward(req, resp);
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String cp = req.getContextPath();
		
		Connection conn = DBCPConn.getConnection();
		
		ScoreDAO dao = new ScoreDAO(conn);
		
		MyUtil myUtil = new MyUtil();
		
		String url;//for using forward
		
		String uri = req.getRequestURI(); // /sung/list.jsp
		
		//cp :/study
		//uri :/study/serlvet/test9.jsp
		
		if(uri.indexOf("list.do") != -1){
			
			String pageNum = req.getParameter("pageNum");
			//--페이징
			int currentPage = 1;
			
			if(pageNum != null) 
				currentPage = Integer.parseInt(pageNum);
			
			//전체 데이터 갯수
			int numPerPage = 5;
			int dataCount = dao.getDataCount();
			
			int totalPage = myUtil.getPageCount(numPerPage, dataCount);
			
			//삭제후 전체페이지수보다 표시할 페이지가 큰 경우
			if(currentPage>totalPage)
				currentPage=totalPage;
			
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;
			
			List<ScoreDTO> lists = dao.getList(start, end);
			
	
			String listUrl = cp + "/sscore/list.do";
			
			
			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
			
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("lists", lists);
			req.setAttribute("pageNum", pageNum);
			
			
			url = "/sung/list.jsp";
			forward(req, resp, url);
			
			
		}else if(uri.indexOf("write.do") != -1) {
			
			String pageNum = req.getParameter("pageNum");
			req.setAttribute("pageNum", pageNum);
			
			url = "/sung/write.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("write_ok.do") != -1){
		
			ScoreDTO dto = new ScoreDTO();
			
			dto.setHak(req.getParameter("hak"));
			dto.setName(req.getParameter("name"));
			dto.setKor(Integer.parseInt(req.getParameter("kor")));
			dto.setEng(Integer.parseInt(req.getParameter("eng")));
			dto.setMat(Integer.parseInt(req.getParameter("mat")));
			
			dao.insertData(dto);
			
			url = cp + "/sscore/list.do";
			resp.sendRedirect(url);
			
		}else if(uri.indexOf("update.do") != -1){
			
			String pageNum = req.getParameter("pageNum");
			String hak = req.getParameter("hak");
			
			ScoreDTO dto = dao.getReadData(hak);
			
			if(dto == null) {
				url = cp + "/sscore/list.do";
				resp.sendRedirect(url);
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("pageNum", pageNum);
			
			url = "/sung/update.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("update_ok.do") != -1){
			
			String pageNum = req.getParameter("pageNum");
			ScoreDTO dto = new ScoreDTO();
			
			dto.setHak(req.getParameter("hak"));
			dto.setName(req.getParameter("name"));
			dto.setKor(Integer.parseInt(req.getParameter("kor")));
			dto.setEng(Integer.parseInt(req.getParameter("eng")));
			dto.setMat(Integer.parseInt(req.getParameter("mat")));
			
			dao.updateData(dto);
			
			
			
			url = cp + "/sscore/list.do?pageNum="+pageNum;
			resp.sendRedirect(url);

		}else if(uri.indexOf("delete.do") != -1){
			
			String pageNum = req.getParameter("pageNum");
			String hak = req.getParameter("hak");
			
			dao.deleteData(hak);
			
			req.setAttribute("pageNum", pageNum);
			
			url = cp + "/sscore/list.do?pageNum="+pageNum;
			resp.sendRedirect(url);

		}
	}
}
