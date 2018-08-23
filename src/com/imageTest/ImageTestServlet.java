package com.imageTest;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;


import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import util.DBCPConn;
import util.FileManager;
import util.MyUtil;


public class ImageTestServlet extends HttpServlet{

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
		
		Connection conn = DBCPConn.getConnection();
		ImageTestDAO dao = new ImageTestDAO(conn);
		
		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		String url;
		
		MyUtil myUtil = new MyUtil(); //게시판에서만 쓰는것
		
		//파일 업로드 코딩 시작
		//파일 저장할 경로
		String root = getServletContext().getRealPath("/");
		String path = root + File.separator + "pds" + File.separator + "imageFile";
		
		File f = new File(path);
		if(!f.exists()){
			f.mkdirs();
		}
		//파일 업로드 코딩 끝
		
		//jsp이동
		if(uri.indexOf("write.do") != -1){
			
			url = "/imageTest/write.jsp";
			forward(req, resp, url);
		}else if(uri.indexOf("write_ok.do") != -1){
			
			//파일 업로드 코딩 시작
			//파일 업로드
			String encType ="UTF-8";
			int maxSize = 10*1024*1024;
			
			MultipartRequest mr = 
					new MultipartRequest(req, path, maxSize, encType, new DefaultFileRenamePolicy());

			//DB에 파일 정보 저장 
			if(mr.getFile("upload") != null){
				
				ImageTestDTO dto = new ImageTestDTO();
				
				int maxNum = dao.getMaxNum();
	
				dto.setNum(maxNum + 1);
				dto.setSubject(mr.getParameter("subject"));
				dto.setSaveFileName(mr.getFilesystemName("upload"));
				dto.setOriginalFileName(mr.getOriginalFileName("upload"));
				
				
				dao.insertData(dto);
				
			}
			//파일 업로드 관련 코딩 끝---------------------------------------
			
			url = cp + "/image/list.do";
			resp.sendRedirect(url);;

		}else if(uri.indexOf("list.do") != -1){
			
			String pageNum = req.getParameter("pageNum");
			int currentPage = 1;
			
			if(pageNum != null) 
				currentPage = Integer.parseInt(pageNum);
			
			//전체 데이터 갯수
			int numPerPage = 9;
			int dataCount = dao.getDataCount();
			
			int totalPage = myUtil.getPageCount(numPerPage, dataCount);
			
			//삭제후 전체페이지수보다 표시할 페이지가 큰 경우
			if(currentPage>totalPage)
				currentPage=totalPage;
			
			String listUrl = cp + "/image/list.do";//가상의 주소 설정
			
			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
			
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;
			
			List<ImageTestDTO> lists = dao.getlist(start, end);
			
			
			//다운로드 Path 시작--- 및 데이터 넘김
			String downloadPath = cp + "/image/download.do";
			String deletePath = cp + "/image/delete.do";
	
			req.setAttribute("downloadPath", downloadPath);
			req.setAttribute("deletePath", deletePath);	
			//다운로드 Path 끝---
		
			//이미지path 시작--- 및 데이터 넘김
			String imagePath = cp + "/pds/imageFile";
			req.setAttribute("imagePath", imagePath);
			//이미지 path 끝---

			//forward & 데이터 넘김
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("pageNum", currentPage);
			req.setAttribute("totalPage", totalPage);
			
			url = "/imageTest/list.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("download.do") != -1){
			
			//다운로드는 boolean으로 하기때문에 true/false반환값이있다
			
			//다운로드 클릭할때도 num이 넘어오니까 num을 받아야한다
			int num = Integer.parseInt(req.getParameter("num"));
			
			ImageTestDTO dto = dao.getReadData(num);
			
			if(dto==null){
				return;
			}

			//반환값(true : 다운로드 완료)
			boolean flag = 
					FileManager.doFileDownload(resp, dto.getSaveFileName(), dto.getOriginalFileName(), path);
			
			//error message 보내는 방법 (1.error.jsp 만드는 방법 2. 직접 스크립트 작성)
			//2번방식
			if(flag==false){
				
				resp.setContentType("text/html;charset=UTF-8");
				
				PrintWriter out = resp.getWriter();
				
				out.print("<script type='text/javascript'>");
				out.print("alert('download error');");
				out.print("history.back();");
				out.print("</script>");
			}
			

		}else if(uri.indexOf("delete.do") != -1){
			
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			
			ImageTestDTO dto = dao.getReadData(num);
			
			//물리적 파일 삭제(DB의 SaveFileName, path는 저 위에 코딩)
			FileManager.doFileDelete(dto.getSaveFileName(), path);
			
			//DB의 테이블삭제
			dao.deleteData(num);
			
			String params = "pageNum=" + pageNum;
			
			url = cp + "/image/list.do?" + params;
			resp.sendRedirect(url);
			
		}
	
	}
	
	
}
