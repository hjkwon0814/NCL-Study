<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<h1>Hello world!</h1>

	<P>The time on the server is ${serverTime}.</P>

	
	
	<a href="http://localhost:8080/testapp/abc">이동하기</a>
	
	
	<table border="1">
		<tr>
			<td>이름</td>
			<td>나이</td>
		</tr>
		<c:forEach var="userlist" items="${HomeUsersList}">
			<tr>
				<td><c:out value="${userlist.getName()}"></c:out></td>
				<td><c:out value="${userlist.getAge()}"></c:out></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
