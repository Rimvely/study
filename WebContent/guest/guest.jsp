<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="util.MyUtil"%>
<%@page import="com.guest.GuestDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.guest.GuestDTO"%>
<%@page import="util.DBconn"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>


<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
%>

<%


	Connection conn = DBconn.getConnection();
	GuestDAO dao = new GuestDAO(conn);
	
	MyUtil myUtil = new MyUtil();
	
	//client한테 넘어온 페이지 번호 (두번째 실행부터 42,54,63번 코딩으로 pageNum이 넘어옴)
	String pageNum = request.getParameter("pageNum");
	int currentPage = 1; //현재 표시되는 페이지 기본값
	
	//처음 실행시 null
	if(pageNum != null)
		currentPage = Integer.parseInt(pageNum); //넘어온 pageNum(9)을 currentPage(9)에 넣음
	
		
	//전체 데이터 갯수 구하기
	int dataCount = dao.getDataCount();
	int numPerPage = 5;//한 페이지에 표시할 데이터 갯수
	//(3,34)값을 MyUtil 1번 메소드로 전송
	int totalPage = myUtil.getPageCount(numPerPage, dataCount);
	
	//삭제로 인해 전체 페이지수보다 표시할 페이지가 큰 경우 
		//표시할 페이지를 전체 페이지로
		
	if(currentPage > totalPage)  //데이터를 삭제해서 페이지가 줄었을 경우
		currentPage = totalPage; //12 = 12
		
	//데이터베이스에서 가져올 시작과 끝 위치
	int start = (currentPage-1) * numPerPage + 1;  //(9-1)*3+1 = 25
	int end = currentPage*numPerPage;           //(9*3) = 27
	
	//데이터베이스에서 해당페이지를 가져온다
	List<GuestDTO> lists = dao.getLists(start, end); //(25, 27)값을 BoardDAO로 넘겨줌
	
	
	/* //페이징 처리(MyUtil.java)
	String listUrl = "list.jsp" */
	
	String listUrl = "guest.jsp";
	String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
			  									//(9,12,list.jsp)를 MyUtil로 넘김

			  									
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>방 명 록(JDBC)</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<link rel="stylesheet" href="<%=cp%>/guest/data/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/guest/data/list.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/guest/data/created.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/guest/data/article.css" type="text/css"/>

<script type="text/javascript">
function isValidEmail(email) {
	var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
    if (email.search(format) != -1)
        return true; //올바른 포맷 형식
    return false;
}

String.prototype.trim = function() {
		var TRIM_PATTERN = /(^\s*)|(\s*$)/g;
		return this.replace(TRIM_PATTERN, "");
};

function sendIt() {
    f = document.myForm;
    str = f.name.value;
    str = str.trim();
    if(!str) {
        alert("이름을 입력하세요 !!!");
        f.name.focus();
        return;
    }
    f.name.value = str;

    str = f.email.value;
    str = str.trim();
    if(str) {
		if(!isValidEmail(str)) {
            alert("E-Mail을 정확히 입력하세요 !!!");
            f.email.focus();
            return;
		}
    }
    f.email.value = str;
    
    f.action="/study/guest/save.jsp?pageNum=<%=currentPage%>";
    f.submit();
}

function deleteBT(num) {
	
		f = document.myForm;
		
		var number = num;
		
		
	if (confirm("정말 삭제하시겠습니까?")==true){
		f.action = "<%=cp %>/guest/delete.jsp?num=" + number + "&pageNum=<%=currentPage%>";
		f.submit();
	}else{
		return;
	}

}

</script>
</head>

<body>

<div id= "bbs">
	<div id="bbs_title">
	방 명 록(JDBC/JSP)
	</div>
	
	<form name="myForm" method="post" action="">
	<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>작성자</dt>
				<dd>
				      <input type="text" name="name" size="35" maxlength="20"  class="boxTF" />
				</dd>
			</dl>
		</div>

		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>E-mail</dt>
				<dd>
				      <input type="text" name="email" size="35" maxlength="50" class="boxTF" />
				</dd>
			</dl>
		</div>

		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>홈페이지</dt>
				<dd>
				      <input type="text" name="homepage" value="http://" size="35" maxlength="50" class="boxTF" />
				</dd>
			</dl>
		</div>

		<div id="bbsCreated_content">
			<dl>
				<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
				<dd>
				      <textarea name="content" cols="63" rows="12" class="boxTA"></textarea>
				</dd>
			</dl>
		</div>
	</div>

	<div id="bbsCreated_footer">
		
        <input type="button" value=" 등록하기 " class="btn2" onclick="sendIt();"/>
        <input type="reset" value=" 다시입력 " class="btn2" onclick="document.myForm.name.focus();"/>
   				<input type="button" class="btn2" value="돌아가기" 
		onclick="javascript:location.href='<%=cp %>/index.jsp';"/>
	</div>
 </form>
 </div>
	

<!--방명록 글뜨게하기 -->
<table border="0" style="width:600px; border-top:3px solid #DBDBDB; border-bottom:3px solid #DBDBDB;  margin:3px auto;" cellpadding="3" cellspacing="0">
	<%for(GuestDTO dto : lists){ %>	
	<tr style="height:25px; background-color: #B1B1B1; padding: 2px;">
		<td align="left" style="margin:2px auto; width:300px; padding-left: 5px;">
		<b>No. <%=dto.getNum() %></b> <%=dto.getName() %>(<%=dto.getEmail() %>)
		</td>
		<td align="right" style="margin:2px auto; width:300px; padding-right: 5px" >
		홈페이지 : <%=dto.getHomepage() %>
		</td>
	</tr>
	<tr style="height:25px; background-color: #B1B1B1; padding: 2px;">
		<td align="left" style="margin:2px auto; padding-left: 5px;">
			작성일 : <%=dto.getCreated() %> (<%=dto.getIpAddr() %>)
		</td>
		<td align="right" style="margin:2px auto; padding-right: 5px; padding-bottom: 5px">
			<input type="button" value="삭제" onclick="deleteBT(<%=dto.getNum()%>);"
				style="background-color: #e74c3c;"/>
		</td>
	</tr>
	<tr>
		<td colspan="2" style="height: 20pt; padding: 3pt;">
			<%=dto.getContent().replaceAll("\n", "<br/>")%>
			
		</td>
	</tr>
	<%} %>
	<tr>
		<td height="20" colspan="2" align="center" valign="middle" style="border-bottom:3px solid #DBDBDB; border-top:3px solid #DBDBDB;">
		<%if(dataCount != 0){ %>
				<%=pageIndexList %>
				
			<%}else{%>
				<td height="20" colspan="2" align="center">
				등록된 게시물이 없습니다.
			<%} %>
		</td>
	</tr>
</table>




</body>
</html>