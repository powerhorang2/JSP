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

	String title = request.getParameter("title"); // 외부로부터 값을 풀고 받기위해
	String ctnt = request.getParameter("ctnt");
	String strI_student = request.getParameter("i_student"); 
	
	if("".equals(title) || "".equals(ctnt) || "".equals(strI_student)) {
		response.sendRedirect("/jsp/boardWrite.jsp?err=10");
		return;
	}
	
	int i_student = Integer.parseInt(strI_student);	// strI_student에 숫자만 있으면 에러가 안터지는데 문자가 하나라도 섞여있으면 에러가 터짐
	
	
	
	Connection con = null; // 자바와 데이터베이스 연결 담당
	PreparedStatement ps = null; // 쿼리문 완성 + 쿼리문 실행
	
	
	String sql = " INSERT INTO t_board (i_board,title,ctnt,i_student) "
				+ " SELECT nvl(max(i_board),0) + 1,?,?,? "
				+ " FROM t_board ";
	int result = -1;
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setString(1, title);
		ps.setString(2, ctnt);
		ps.setInt(3, i_student);
		result = ps.executeUpdate();
		
		// ps.setString(1, strI_board); // 자동으로 ""를 붙여준다.
				
		
	} catch(Exception e) {
		e.printStackTrace();
	} finally {  // 열었으면 반드시 닫아줘야하는데 생성한 반대 순서로 닫아준다. 3개를 따로 닫아줘야지 하나 오류가 떠도 나머지를 닫을 수 있음.
		if(ps != null) { try { ps.close(); } catch (Exception e) {} }
		if(con != null) { try { con.close(); } catch (Exception e) {} }
	}
	int err = 0;
	switch(result) {
	case 1:
		response.sendRedirect("/jsp/boardList.jsp"); // 2번 실행되게 되면 에러터짐으로 꼭 한번만 실행되게 할 것
		return;
	case 0:
		err = 10;
		break;
	case -1:
		err = 20;
		break;
	}
	response.sendRedirect("/jsp/boardWrite.jsp?err=" + err);
	
%>

