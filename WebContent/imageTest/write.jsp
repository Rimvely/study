<%@ page contentType="text/html; charset=UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>게 시 판(Servlet)</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<link rel="stylesheet" href="<%=cp%>/imageTest/data/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/imageTest/data/created.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/imageTest/data/list.css" type="text/css"/>

<script type="text/javascript" src="<%=cp%>/imageTest/data/util.js"></script>
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
}

function sendIt() {
    f = document.myForm;
    
    str = f.subject.value;
    str = str.trim();
    if(!str) {
        alert("제목을 입력하세요 !!!");
        f.subject.focus();
        return;
    }
    f.subject.value = str;

    str = f.upload.value;
    if(!str) {
        alert("이미지 파일을 선택 하세요 !!!");
        f.upload.focus();
        return;
    }
    
    f.action="/study/image/write_ok.do";
    f.submit();
}


</script>

</head>

<body>

<div id="bbs">
	<div id="bbs_title">
	게 시 판(Servlet)
	</div>

	<form name="myForm" method="post" action=""
	enctype="multipart/form-data">
	
	<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>제&nbsp;&nbsp;&nbsp;&nbsp;목</dt>
				<dd>
				      <input type="text" name="subject" size="74" maxlength="100"  class="boxTF" />
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>파&nbsp;&nbsp;&nbsp;&nbsp;일</dt>
				<dd>
				      <input type="file" name="upload" size="74" maxlength="100" class="boxTF" align="right" />
				</dd>
			</dl>
		</div>
	</div>


	<div id="bbsCreated_footer">
        <input type="button" value=" 등록하기 " class="btn2" 
        onclick="sendIt();"/>
        <input type="reset" value=" 다시입력 " class="btn2" 
        onclick="document.myForm.subject.focus();"/>
        <input type="button" value=" 작성취소 " class="btn2" 
        onclick="javascript:location.href='<%=cp%>/image/list.do';"/>
	</div>

    </form>
</div>

</body>

</html>