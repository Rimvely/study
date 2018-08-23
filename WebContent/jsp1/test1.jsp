<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- D:\Java\work\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\study  -->
<script type="text/javascript">
	
	function sentIt(){
		
		var f = document.myForm;
		
		if(!f.su1.value){
			alert("[su1] 을 입력하세요.");
			f.su1.focus();
			return;
		}
		
		if(!f.su2.value){
			alert("[su2] 을 입력하세요.");
			f.su2.focus();
			return;
		}
		
		if(!f.name.value){
			alert("[name] 을 입력하세요.");
			f.name.focus();
			return;
		}
		/* 결과버튼 눌렀을때 test1_ok.jsp로 넘어가게 */
		f.action = "test1_ok.jsp";
		f.submit();
		
	}


</script>






</head>
<body>

<!-- Form 양식의 데이터를 받아낼때
getParameter로 받아낸다.  -->
<!--  -->


<form name="myForm" method="post">

수1:<input type="text" name="su1"/><br/>
수2:<input type="text" name="su2"/><br/>
이름:<input type="text" name="name"/><br/>

<!-- type = "submit" 일때는 바로 action을 찾아간다.
     type = "button" 일때는 onclick=""; 실행하고 
     f.submit();이 action을 찾아간다.  -->
<input type="button" value="결과" onclick="sentIt();"/><br/>


</form>




</body>
</html>
