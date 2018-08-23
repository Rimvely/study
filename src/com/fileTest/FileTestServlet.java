package com.fileTest;

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

public class FileTestServlet extends HttpServlet {

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
		FileTestDAO dao = new FileTestDAO(conn);
		
		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		String url;
		
		MyUtil myUtil = new MyUtil();//�Խ��ǿ����� ���°�
		
		//���� ���ε� �ʿ� �ڵ� ����-------------------------------------------
		
		//���� ������ ���
		//���� ���� String root = pageContext.getServletContext().getRealPath("/");
		String root = getServletContext().getRealPath("/");
		String path = root + File.separator + "pds" + File.separator + "saveFile";
		
		File f = new File(path);
		if(!f.exists()){
			f.mkdirs();
		}
		
		//���� ���ε� �ʿ� �ڵ� ��--------------------------------------------
		
		if(uri.indexOf("write.do") != -1){
			
			url = "/fileTest/write.jsp";
			forward(req, resp, url);
		}else if(uri.indexOf("write_ok.do") != -1){
			
			//����¡���� �ڵ�
			
			
			
			//���� ���ε� ���� �ڵ� ����--------------------------------------
			//���� ���ε�
			String encType ="UTF-8";
			int maxSize = 10*1024*1024;
			
			MultipartRequest mr = 
					new MultipartRequest(req, path, maxSize, encType, new DefaultFileRenamePolicy());

			//DB�� ���� ���� ���� 
			if(mr.getFile("upload") != null){
				
				FileTestDTO dto = new FileTestDTO();
				
				int maxNum = dao.getMaxNum();
	
				dto.setNum(maxNum + 1);
				dto.setSubject(mr.getParameter("subject"));
				dto.setSaveFileName(mr.getFilesystemName("upload"));
				dto.setOriginalFileName(mr.getOriginalFileName("upload"));
				
				dao.insertData(dto);
				
			}
			//���� ���ε� ���� �ڵ� ��---------------------------------------
			
			url = cp + "/file/list.do";
			resp.sendRedirect(url);;
			
		}else if(uri.indexOf("list.do") != -1){
			
			String pageNum = req.getParameter("pageNum");
			int currentPage = 1;
			
			if(pageNum != null) 
				currentPage = Integer.parseInt(pageNum);
			
			//��ü ������ ����
			int numPerPage = 3;
			int dataCount = dao.getDataCount();
			
			int totalPage = myUtil.getPageCount(numPerPage, dataCount);
			
			//������ ��ü������������ ǥ���� �������� ū ���
			if(currentPage>totalPage)
				currentPage=totalPage;
			
			String listUrl = cp + "/file/list.do";//������ �ּ� ����
			
			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
			
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;
			
			List<FileTestDTO> lists = dao.getlist(start, end);
			
			//�ٿ�ε� Path ����--------------------------------------------
			String downloadPath = cp + "/file/download.do";
			String deletePath = cp + "/file/delete.do";
	
			req.setAttribute("downloadPath", downloadPath);
			req.setAttribute("deletePath", deletePath);	
			//�ٿ�ε� Path ��---------------------------------------------	
		
			//�̹���path
			String imagePath = cp + "/pds/saveFile";
			req.setAttribute("imagePath", imagePath);
			
		
			

			//forward �������� �����͸� �ѱ�
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("pageNum", currentPage);
			
			url = "/fileTest/list.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("download.do") != -1){
			
			//�ٿ�ε�� boolean���� �ϱ⶧���� true/false��ȯ�����ִ�
			
			//�ٿ�ε� Ŭ���Ҷ��� num�� �Ѿ���ϱ� num�� �޾ƾ��Ѵ�
			int num = Integer.parseInt(req.getParameter("num"));
			
			FileTestDTO dto = dao.getReadData(num);
			
			if(dto==null){
				return;
			}
			
			//��ȯ��(true : �ٿ�ε� �Ϸ�)
			boolean flag = 
					FileManager.doFileDownload(resp, dto.getSaveFileName(), dto.getOriginalFileName(), path);
			
			//error message ������ ��� (1.error.jsp ����� ��� 2. ���� ��ũ��Ʈ �ۼ�)
			//2�����
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
			
			FileTestDTO dto = dao.getReadData(num);
			
			//������ ���� ����(DB�� SaveFileName, path�� �� ���� �ڵ�)
			FileManager.doFileDelete(dto.getSaveFileName(), path);
			
			//DB�� ���̺����
			dao.deleteData(num);
			
			String params = "pageNum=" + pageNum;
			
			url = cp + "/file/list.do?" + params;
			resp.sendRedirect(url);
			
		}
		

	}
	
	
}
