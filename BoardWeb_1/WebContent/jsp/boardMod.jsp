<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.web.BoardVO" %>
<%! // !(스크립트릿)를 붙여주면 메소드 바깥에 내용들을 적어줌 : 전역변수, 메소드 같은 것들은 여기다가 만들어줘야함. 
	// @를 붙여주면 세팅
	// jsp목적 : 화면 응답!!!
		Connection getCon() throws Exception {
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String username = "hr";
		String password = "koreait2020";
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		Connection con = DriverManager.getConnection(url,username,password); //getConnection static메소드 : 들어오는 파라미터 값만으로 가공이 가능하다 static메소드 사용가능, DB랑 연결하는 선 역할!
		System.out.println("접속 성공!");
		return con;
	}
 %>
<%
	String strI_board = request.getParameter("i_board");
	if(strI_board == null) {
%>
	<script>
		alert('잘 못 된 접근입니다.')
		location.href='/jsp/boardList.jsp'
	</script>  
<%
	return; // 밑에 코드들을 실행 시키지 않기 위해;
	}
	int i_board = Integer.parseInt(strI_board);	

	BoardVO vo = new BoardVO();

	Connection con = null; // 자바와 데이터베이스 연결 담당
	PreparedStatement ps = null; // 쿼리문 완성 + 쿼리문 실행
	ResultSet rs = null; // SELECT문의 결과를 담는다.
	
	String sql = " SELECT title, ctnt, i_student FROM t_board WHERE i_board = ? ";   // + strI_board;
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setInt(1, i_board); // 쿼리문의 첫번째 ?에 i_board를 집어넣는다. 
		// ps.setString(1, strI_board); // 자동으로 ""를 붙여준다.
		rs = ps.executeQuery(); // executeQuery(); : (ResultSet 타입임);
		if(rs.next()){
			String title = rs.getNString("title");
			String ctnt = rs.getNString("ctnt");
			int i_student = rs.getInt("i_student");
				
			vo.setTitle(title);
			vo.setCtnt(ctnt);
			vo.setI_student(i_student);	
		}
		
		
	} catch(Exception e) {
		e.printStackTrace();
	} finally {  // 열었으면 반드시 닫아줘야하는데 생성한 반대 순서로 닫아준다. 3개를 따로 닫아줘야지 하나 오류가 떠도 나머지를 닫을 수 있음.
		if(rs != null) { try { rs.close(); } catch (Exception e) {} }
		if(ps != null) { try { ps.close(); } catch (Exception e) {} }
		if(con != null) { try { con.close(); } catch (Exception e) {} }
	}


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
<title>글수정</title>
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
			<input type="hidden" name="i_board" value="<%=i_board %>"> <!-- 1번째 방법 : form태그의 action속성의 주소값을 : ?i_board=< %= i_board % > 2번째 방법 : input hidden에다가 넣어주는 방법-->
			<div><label>수정 제목 : <input type="text" name= "title" value="<%=vo.getTitle()%>"></label></div> <!-- name 속성 : 서버한테 값을 날리기위한 키값 , id 속성 : 유일성을 주기위해 사용, class 속성 : 집단성을 주기위해 사용. -->
			<div><label>수정 내용 : <textarea name= "ctnt"><%=vo.getCtnt()%></textarea></label></div>
			<div><label>수정 작성자 : <input type="text" name= "i_student" value="<%=vo.getI_student()%>"></label></div>
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
		alert('수정할 제목을 입력해주세요.')
		frm.title.focus()
		return false
	}else if(frm.ctnt.value.length==0){
		alert('수정할 내용을 입력해주세요.')
		frm.ctnt.focus()
		return false
	}else if(frm.i_student.value==""){
		alert('수정할 작성자를 입력해주세요.')
		frm.i_student.focus()
		return false
	}
	
} 
	</script>
</body>
</html>