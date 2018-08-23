package com.join;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.board.BoardDTO;

import util.DBCPConn;

public class MemberServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		doPost(req, resp);
		
	}
	
	// forward ȣ���ϸ鼭 ���(url)�� �����ָ� �ȴ�
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
		MemberDAO dao = new MemberDAO(conn);
		
		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		
		String url;
		
		//created.do // created_ok.do ȸ������
		if(uri.indexOf("created.do") != -1){
			
			url = "/member/created.jsp";
			forward(req, resp, url);
		
		}else if(uri.indexOf("created_ok.do") != -1){
			
			MemberDTO dto = new MemberDTO();
			
			dto.setUserId(req.getParameter("userId"));
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserName(req.getParameter("userName"));
			dto.setUserBirth(req.getParameter("userBirth"));
			dto.setUserTel(req.getParameter("userTel"));
			
			dao.insertData(dto);
			
			
			
			url = cp + "/index.jsp";
			resp.sendRedirect(url);
			
		//�α���
		}else if(uri.indexOf("login.do") != -1){
			
			url = "/member/login.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("login_ok.do") != -1){
			
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");
			
			//�Ѹ��� ������ �ֱ�
			MemberDTO dto = dao.getReadData(userId);
			
			
			//�̻��� ������
			if(dto==null||(!dto.getUserPwd().equals(userPwd))){
				
				req.setAttribute("message", "���̵� �Ǵ� �н����带 ��Ȯ�� �Է��ϼ���!");
				
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;//���� �����Ű������?
			
			}
			
			//�̻��� ������
			//(true)�� ������ �⺻ �ܿ� 1���� �����ϴ°�
			HttpSession session = req.getSession(true);
			
			//CustomInfo ��ü����
			CustomInfo info = new CustomInfo();
			
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());
			
			session.setAttribute("customInfo", info);
			
			url = cp;
			resp.sendRedirect(url);
			
		//�α׾ƿ�
		}else if(uri.indexOf("logout.do") != -1){
			
			//����ϰ� �ִ� session�� ����ϴ°��̱⶧���� (true)��� ������ȴ�
			HttpSession session = req.getSession();
			
			session.removeAttribute("customInfo");
			session.removeAttribute("message");
			session.invalidate();
			
			url = cp;
			resp.sendRedirect(url);
			//session�� ���� �ٲ�ϱ� redirect
			
		//��й�ȣ ã��
		}else if(uri.indexOf("searchpw.do") != -1){
			
			url = "/member/searchpw.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("searchpw_ok.do") != -1){
			
			String userId = req.getParameter("userId");
			String userTel = req.getParameter("userTel");
			
			//�Ѹ��� ������ �ֱ�
			MemberDTO dto = dao.getReadData(userId);
			
			//�̻��� ������
			if(dto==null||(!dto.getUserTel().equals(userTel))){
				
				req.setAttribute("message", "ȸ�������� �������� �ʽ��ϴ�!");
				
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;//if���� �����Ű������
			
			}
			
			//�̻��̾�����
			req.setAttribute("message", "��й�ȣ�� {"+ dto.getUserPwd() +"} �Դϴ�");
			
			HttpSession session = req.getSession(true);
			
			CustomInfo info = new CustomInfo();
			
			info.setUserId(dto.getUserId());
			info.setUserTel(dto.getUserTel());
			
			session.setAttribute("customInfo", info);
			
			url = "/member/login.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("update.do") != -1){
			
			//���� ������ ������ userid dao.getReadData�� ���� �ҷ��ͼ� dto�� ��ƾ� session�� �ø���
			HttpSession session = req.getSession();
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			MemberDTO dto = dao.getReadData(info.getUserId());
			
			//�̰� session�� �ø����� update.jsp ���� �ѷ��ش�
			req.setAttribute("dto", dto);
			
			url = "/member/update.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("update_ok.do") != -1){
		
			MemberDTO dto = new MemberDTO();
			
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserBirth(req.getParameter("userBirth"));
			dto.setUserTel(req.getParameter("userTel"));
			dto.setUserId(req.getParameter("userId"));
			
			dao.updateData(dto);
			
			url = cp + "/index.jsp";
			resp.sendRedirect(url);
				
		}else if(uri.indexOf("delete.do") != -1){
		
			url = "/member/delete.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("delete_ok.do") != -1){
			
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");
			
			//�Ѹ��� ������ �ֱ�
			MemberDTO dto = dao.getReadData(userId);
			
			//�̻��� ������
			if(dto==null||(!dto.getUserPwd().equals(userPwd))){
				
				req.setAttribute("message", "���̵� �Ǵ� ��й�ȣ�� Ʋ�Ƚ��ϴ�!");
				
				url = "/member/delete.jsp";
				forward(req, resp, url);
				return;//if���� �����Ű������
			
			}
			
			//�̻��̾�����
			dao.deleteData(userId);
			
			HttpSession session = req.getSession();
			
			session.removeAttribute("customInfo");
			session.removeAttribute("message");
			session.invalidate();
			
			url = cp;
			resp.sendRedirect(url);
			//session�� ���� �ٲ�ϱ� redirect
		
		}
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}
