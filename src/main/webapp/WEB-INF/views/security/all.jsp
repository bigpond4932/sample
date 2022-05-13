<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>/security/all page</h1>
<sec:authorize access="isAuthenticated()">
<a href ="/customLogout">Logout</a>
</sec:authorize>
<sec:authorize access="isAnonymous()">
<a href ="/customlogin">Login</a>
</sec:authorize>
</body>
</html>