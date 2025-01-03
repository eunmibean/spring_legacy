<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isELIgnored="false" %>

<html>
<body>

<table border="1">
    <thead>
    <tr>
        <th>Index</th>
        <th>Title</th>
        <th>Writer</th>
        <th>Date</th>
        <th>Count</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="vo" items="${list}">
        <tr>
            <td>${vo.idx}</td>
            <td>${vo.title}</td>
            <td>${vo.writer}</td>
            <td>${vo.indate}</td>
            <td>${vo.count}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<button id="insert">입력</button>
<button id="delete">삭제</button>
<button id="update">수정</button>

</body>
</html>
