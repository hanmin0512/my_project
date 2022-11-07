<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "java.time.LocalDate, java.time.LocalTime, java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<%@ page import = "db.db_seat" %>


<%
	String m=":00";
	LinkedList<String> date_base = new LinkedList();
	String id = request.getParameter("username");
	String sc_number = request.getParameter("sc_num");
	if(id == null && sc_number == null){
		out.print(join_tag());
	}else{
		
		for(int i=9; i<=24; i++){
			String time = Integer.toString(i)+m;
			date_base.add(time);
		}
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy/MM/dd");
		String format_now = now.format(formatter);
		
		/*
		for(String s : date_base){
			out.print(s);
		}
		*/
		
		
		
%>

<%!
	public String startBar(){
		return "<div class='text-bg-dark p-3'style='margin-top:1%;'>";
	}
	
	public String tr(){
		return "<tr>";
	}
	public String td(){
		return "<td>";
	}
	
	public String join_tag(){
		String s = "<center><a href = 'index.jsp'>login</a></center>";
		return s;
	}

	public LinkedList<String> search_list(int num) throws SQLException {
		db_seat db = new db_seat();
		db.db_connection();
		LinkedList<String> date_list = db.db_confirm_list(num);
		db.db_close();
		
		return date_list;
	}
	

%>



<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
<%
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  
  String db_url = "jdbc:oracle:thin:@203.247.239.1:1521:myora";
  String db_id = "reservation";
  String db_pw = "reservation2022";
  String driver = "oracle.jdbc.driver.OracleDriver";
  
  //id = request.getParameter("username");
  //sc_number = request.getParameter("sc_num");

  boolean YN = true;
  //request.setAttribute("username", id);
  //request.setAttribute("sc_num", sc_number);
%>




</head>
<body>
<script>
	alert("<%=format_now%>");
</script>
<img src="logo.jpg" style="height:20%">
<p class="text-left fs-1" style="width:65%; float:right; color:orange;">
	동국 대학교 경주 캠퍼스 <br>스터디룸 예약 서비스</p>
<!--  start of navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid text-center">
      <a class="navbar-brand" href="#">스터디룸 예약</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarColor01">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
			<li><a>예약하기 </a></li>
        </ul>
        <form class="d-flex" role="search">
          <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-light" type="submit">Search</button>
        </form>
      </div>
    </div>
  </nav>
<!-- end of navbar -->

<!-- start of db connection -->
<%
 try{
 	Class.forName(driver);
 	conn = DriverManager.getConnection(db_url, db_id, db_pw);
 	String sql = "select name,sc_number from sc_user where name = \'"+id+"\' and sc_number = \'"+sc_number+"\'";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	if(rs.next()){
		out.print(startBar());
		out.print("<p class='text-center'> hello "+id+" login successed <p>");
		out.print("</div>");
	}else{
		out.print("you are not joinus");
	} 
  }catch(Exception e){
	 e.printStackTrace();
	 out.print("error");
	 }
	
	 


	//end of confirm member
%>

<!-- end of db connection -->
<div class="position-absolute start-0 translate-left" style="width:50%;">

<% for(int i=1; i<=8; i++) { %>



<div class="container text-center">
  <div class="row">
 	<div class="col">
      <i>table<%=i %></i>
	</div>
	<div class="col">
	<form action ="Remain" method="post">
		<input type = 'hidden' name = "username" value = "<%=id %>">
		<input type = 'hidden' name = "sc_num" value = "<%=sc_number%>">
		<input type = 'hidden' name = "reser" value = "<%=i %>"> 
		<input type="submit" value="예약">
	</form>
  	</div>
  </div>
</div>

<%
	} //end of for
%>


</div>

<div class="position-absolute start-50 translate-right" style="width:50%;">
<% 
	LinkedList<String> search = search_list(1);
	if(search != null){
		for(String s:search){
			if(date_base.contains(s)){
				date_base.remove(s);
				
			}else{
	
			}
	}
	}
	for(String s_s: date_base){
		out.print(s_s+"<button>신청</button><br>");
	}
	
%>
</div>


</body>
</html>
<%
} //end of else
%>