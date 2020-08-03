<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String msg = "";
	String err = request.getParameter("err");
	if(err != null) {
		switch(err) {
			case "10":
				msg = "수정 할 수 없습니다.";
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
		<form id="frm" action="/jsp/boardModProc.jsp" method="post" onsubmit="return chk()">
			<div><label>제목 : <input type="text" name= "title"></label></div> <!-- name 속성 : 서버한테 값을 날리기위한 키값 , id 속성 : 유일성을 주기위해 사용, class 속성 : 집단성을 주기위해 사용. -->
			<div><label>내용 : <textarea name= "ctnt"></textarea></label></div>
			<div><label>작성자 : <input type="text" name= "i_student"></label></div>
			<div><input type="submit" value= "글 등록"></div>
		</form>
	</div>
	<script>
	/* 	function eleValid(ele, nm){
		if(ele.value.length==0){
			alert(nm+'을(를) 입력해주세요.')
			ele.focus()
			return true;
		}
	}

	function chk(){
		if (eleValid(frm.title,'제목')){
			return false;
		}else if (eleValid(frm.ctnt,'내용')){
			return false;
		}else if (eleValid(frm.i_studuent,'작성자')){
			return false;	
	    }
	}
	*/

function chk(){ //문제가 생겼을 때만 안날아 가게
	//console.log(`title:\${frm.title.value}`) // \! 가독성이 좋음 
	if(frm.title.value==""){
		alert('제목을 입력해주세요.')
		frm.title.focus()
		return false
	}else if(frm.ctnt.value.length==0){
		alert('내용을 입력해주세요.')
		frm.ctnt.focus()
		return false
	}else if(frm.i_student.value==""){
		alert('작성자를 입력해주세요.')
		frm.i_student.focus()
		return false
	}
	
} 
	</script>
</body>
</html>