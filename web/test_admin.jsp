<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Test Page</title>
</head>
<body>
    <h1>Admin Test Page</h1>
    
    <h2>Session Information:</h2>
    <p><strong>User:</strong> ${sessionScope.user}</p>
    <p><strong>Username:</strong> ${sessionScope.user.username}</p>
    <p><strong>Full Name:</strong> ${sessionScope.user.fullName}</p>
    <p><strong>Role:</strong> ${sessionScope.user.role}</p>
    
    <h2>Request Information:</h2>
    <p><strong>Page Title:</strong> ${pageTitle}</p>
    <p><strong>Current Type:</strong> ${currentType}</p>
    <p><strong>User List Size:</strong> ${fn:length(userList)}</p>
    
    <h2>User List:</h2>
    <c:forEach items="${userList}" var="u">
        <p>ID: ${u.id}, Username: ${u.username}, Status: ${u.status}</p>
    </c:forEach>
    
    <hr>
    <a href="admin-user?type=customer">Go to Admin Customer Page</a> |
    <a href="admin-user?type=shopowner">Go to Admin Shop Owner Page</a>
</body>
</html>
