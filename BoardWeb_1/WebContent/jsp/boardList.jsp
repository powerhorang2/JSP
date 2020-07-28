<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
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
<% //boardList파일안의 메소드
	// 스코프 때문에 변수 선언을 try문 밖에서 했다.
	List<BoardVO> boardList = new ArrayList();
	
	Connection con = null; // 자바와 데이터베이스 연결 담당
	PreparedStatement ps = null; // 쿼리문 완성 + 쿼리문 실행
	ResultSet rs = null; // SELECT문의 결과를 담는다.
	
	String sql = " SELECT i_board, title FROM t_board ";
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery(); // executeQuery(); : (ResultSet 타입임);
		while(rs.next()) {
			int i_board = rs.getInt("i_board");
			String title = rs.getNString("title");
			BoardVO vo = new BoardVO();
			vo.setI_board(i_board);
			vo.setTitle(title);
			
			boardList.add(vo);
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if(rs != null) { try { rs.close(); } catch (Exception e) {} }
		if(ps != null) { try { ps.close(); } catch (Exception e) {} }
		if(con != null) { try { con.close(); } catch (Exception e) {} }
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>

</head>
<body>
	<div>게시판 리스트</div>
	<table>
		<tr>
			<th>No</th>
			<th>제목</th>
		</tr>
		<% for(BoardVO vo : boardList) { %>
		<tr>
			<th><%=vo.getI_board() %></th>
			<th><%=vo.getTitle() %></th>
		</tr>
		<% } %>
	</table>
	
</body>
</html>