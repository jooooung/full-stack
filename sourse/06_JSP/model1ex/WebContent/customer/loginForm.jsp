<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String conPath = request.getContextPath(); 
	if(session.getAttribute("customer") != null){
		response.sendRedirect("main.jsp");
	}
// msg 처리
String msg = request.getParameter("msg");
if(msg != null){
%>
	<script>
		alert('<%=msg%>');
	</script>
<%}%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="<%=conPath%>/css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="loginForm_wrap">
		<div id="login_title">로그인</div>
		<form action="<%=conPath%>/customer/loginPro.jsp" method="post">
		<input type="hidden" name="method" value="<%=request.getParameter("method")%>">
			<table>
				<tr><td></td></tr>
				<tr>
					<td><label for="cid">아이디</label></td>
					<td><input type="text" name="cid" id="cid" required="required" autofocus="autofocus"
										value="<%
								 							String sessioncId = (String)session.getAttribute("cid");
																	out.println(sessioncId!=null ? sessioncId : "");
								 						%>"><!-- 회원가입 후 로그인 시 회원가입 아이디 가져오기 -->
					</td>
				</tr>
				<tr>
					<td><label for="cpw">비밀번호</label></td>
					<td><input type="password" name="cpw" id="cpw" required="required"></td>
				</tr>
				<tr><td></td></tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="로그인" class="loginBtn_style">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<%
							if(msg!=null){	// 로그인 실패
						%> 
							<p id="login_findIdPw" onclick="location.href='#'">
								아이디/비밀번호를 잊으셨나요?
							</p>
							<% }
						%>
					</td>
				</tr>
			</table>
			<p id="login_join">
				아직 회원이 아니신가요?
				<a href="<%=conPath%>/customer/joinForm.jsp">회원가입</a>
			</p>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>