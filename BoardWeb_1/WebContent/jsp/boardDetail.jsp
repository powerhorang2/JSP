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
	
	Connection con = null; // 자바와 데이터베이스 연결 담당
	PreparedStatement ps = null; // 쿼리문 완성 + 쿼리문 실행
	ResultSet rs = null; // SELECT문의 결과를 담는다.
	
	String sql = " SELECT title, ctnt, i_student FROM t_board WHERE i_board = " + strI_board;
	BoardVO vo = new BoardVO();
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery(); // executeQuery(); : (ResultSet 타입임);
		
		rs.next();
		String title = rs.getNString("title");
		String ctnt = rs.getNString("ctnt");
		int i_student = rs.getInt("i_student");
			
		vo.setTitle(title);
		vo.setCtnt(ctnt);
		vo.setI_student(i_student);
		
			
		
	} catch(Exception e) {
		e.printStackTrace();
	} finally {  // 열었으면 반드시 닫아줘야하는데 생성한 반대 순서로 닫아준다. 3개를 따로 닫아줘야지 하나 오류가 떠도 나머지를 닫을 수 있음.
		if(rs != null) { try { rs.close(); } catch (Exception e) {} }
		if(ps != null) { try { ps.close(); } catch (Exception e) {} }
		if(con != null) { try { con.close(); } catch (Exception e) {} }
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
<style>
	table { border: 1px solid black; }
	th { border: 1px solid black; }
</style>
</head>
<body>
	<div>상세 페이지 : <%=strI_board %></div>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>글</th>
			<th>작성자</th>
		</tr>
		<tr>
			<th><%=strI_board %></th>
			<th><%=vo.getTitle() %></th>
			<th><%=vo.getCtnt() %></th>
			<th><%=vo.getI_student() %></th>
		</tr>
	</table>
</body>
</html>