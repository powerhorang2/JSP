<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String msg = "";
	String err = request.getParameter("err");
	if(err != null) {
		switch(err) {
			case "10":
				msg = "등록 할 수 없습니다.";
				break;
			case "20":
				msg = "DB 에러 발생";
				break;
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<style>
	#msg {
		color: red;
	}
</style>
</head>
<body>
	<div id="msg"><%=msg %></div>
	<div>
		<form id="frm" action="/jsp/boardWriteProc.jsp" method="post" onsubmit="return chk()">
			<div><label>제목 : <input type="text" name= "title"></label></div> <!-- name 속성 : 서버한테 값을 날리기위한 키값 , id 속성 : 유일성을 주기위해 사용, class 속성 : 집단성을 주기위해 사용. -->
			<div><label>내용 : <textarea name= "ctnt"></textarea></label></div>
			<div><label>작성자 : <input type="text" name= "i_student"></label></div>
			<div><input type="submit" value= "글 등록"></div>
		</form>
	</div>
	<script>
		function chk() {
			console.log(`title : \${frm.title.value}`)
			if(frm.title.value == "") {
				alert('제목을 입력해 주세요.')
				frm.title.focus();
			} else if(frm.ctnt.value == "") {
				
			}
			return false;
			
		}
	</script>
</body>
</html>