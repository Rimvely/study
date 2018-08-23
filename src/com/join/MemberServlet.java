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
	
	// forward 호출하면서 경로(url)만 정해주면 된다
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
		
		//created.do // created_ok.do 회원가입
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
			
		//로그인
		}else if(uri.indexOf("login.do") != -1){
			
			url = "/member/login.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("login_ok.do") != -1){
			
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");
			
			//한명의 데이터 넣기
			MemberDTO dto = dao.getReadData(userId);
			
			
			//이상이 있을때
			if(dto==null||(!dto.getUserPwd().equals(userPwd))){
				
				req.setAttribute("message", "아이디 또는 패스워드를 정확히 입력하세요!");
				
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;//뭐를 실행시키지마라?
			
			}
			
			//이상이 없으면
			//(true)를 넣으면 기본 외에 1개더 생성하는것
			HttpSession session = req.getSession(true);
			
			//CustomInfo 객체생성
			CustomInfo info = new CustomInfo();
			
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());
			
			session.setAttribute("customInfo", info);
			
			url = cp;
			resp.sendRedirect(url);
			
		//로그아웃
		}else if(uri.indexOf("logout.do") != -1){
			
			//사용하고 있는 session을 사용하는것이기때문에 (true)라고 안적어도된다
			HttpSession session = req.getSession();
			
			session.removeAttribute("customInfo");
			session.removeAttribute("message");
			session.invalidate();
			
			url = cp;
			resp.sendRedirect(url);
			//session의 값이 바뀌니까 redirect
			
		//비밀번호 찾기
		}else if(uri.indexOf("searchpw.do") != -1){
			
			url = "/member/searchpw.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("searchpw_ok.do") != -1){
			
			String userId = req.getParameter("userId");
			String userTel = req.getParameter("userTel");
			
			//한명의 데이터 넣기
			MemberDTO dto = dao.getReadData(userId);
			
			//이상이 있을때
			if(dto==null||(!dto.getUserTel().equals(userTel))){
				
				req.setAttribute("message", "회원정보가 존재하지 않습니다!");
				
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;//if절을 실행시키지마라
			
			}
			
			//이상이없으면
			req.setAttribute("message", "비밀번호는 {"+ dto.getUserPwd() +"} 입니다");
			
			HttpSession session = req.getSession(true);
			
			CustomInfo info = new CustomInfo();
			
			info.setUserId(dto.getUserId());
			info.setUserTel(dto.getUserTel());
			
			session.setAttribute("customInfo", info);
			
			url = "/member/login.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("update.do") != -1){
			
			//정보 수정을 누를시 userid dao.getReadData를 통해 불러와서 dto에 담아야 session에 올린다
			HttpSession session = req.getSession();
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			MemberDTO dto = dao.getReadData(info.getUserId());
			
			//이걸 session에 올린것을 update.jsp 에서 뿌려준다
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
			
			//한명의 데이터 넣기
			MemberDTO dto = dao.getReadData(userId);
			
			//이상이 있을때
			if(dto==null||(!dto.getUserPwd().equals(userPwd))){
				
				req.setAttribute("message", "아이디 또는 비밀번호가 틀렸습니다!");
				
				url = "/member/delete.jsp";
				forward(req, resp, url);
				return;//if절을 실행시키지마라
			
			}
			
			//이상이없으면
			dao.deleteData(userId);
			
			HttpSession session = req.getSession();
			
			session.removeAttribute("customInfo");
			session.removeAttribute("message");
			session.invalidate();
			
			url = cp;
			resp.sendRedirect(url);
			//session의 값이 바뀌니까 redirect
		
		}
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}
