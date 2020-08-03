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
	int i_board = Integer.parseInt(strI_board);	

	

	Connection con = null; // 자바와 데이터베이스 연결 담당
	PreparedStatement ps = null; // 쿼리문 완성 + 쿼리문 실행
	ResultSet rs = null; // SELECT문의 결과를 담는다.
	
	String sql = " DELETE FROM t_board WHERE i_board = ?";   // + strI_board;

	int result = -1;
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setInt(1, i_board); // 쿼리문의 첫번째 ?에 i_board를 집어넣는다. 
		
		result = ps.executeUpdate();
		
	} catch(Exception e) {
		e.printStackTrace();
	} finally {  // 열었으면 반드시 닫아줘야하는데 생성한 반대 순서로 닫아준다. 3개를 따로 닫아줘야지 하나 오류가 떠도 나머지를 닫을 수 있음.
		if(rs != null) { try { rs.close(); } catch (Exception e) {} }
		if(ps != null) { try { ps.close(); } catch (Exception e) {} }
		if(con != null) { try { con.close(); } catch (Exception e) {} }
	}
	System.out.println("result : " + result );
	switch(result) {
	case -1 : 
		response.sendRedirect("/jsp/boardDetail.jsp?err=-1");
		break;
	case 0 :
		response.sendRedirect("/jsp/boardDetail.jsp?err=0");
		break;
	case 1 :
		response.sendRedirect("/jsp/boardList.jsp");
		break;
	}
%>
