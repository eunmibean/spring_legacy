<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>Board List</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
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
        <tr id="row-${vo.idx}">
            <td>${vo.idx}</td>
            <td>${vo.title}</td>
            <td>${vo.content}</td>
            <td>${vo.indate}</td>
            <td>${vo.count}</td>
            <td> <button id="delete" data-id="${vo.idx}">삭제</button></td>
            <td> <button id="update" data-id="${vo.idx}">수정</button> </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<button id="insert">입력</button>


</body>
<script>
    $(document).on("click", "#delete", function () {
        const rowId = $(this).data("id");
        const rowElement = $('#row-'+rowId);

        if(confirm("삭제하시겠습니까?")){
            $.ajax({
                url: '/board/'+rowId,
                type: 'DELETE',
                success: function () {
                    alert("삭제가 되었습니다.");
                    rowElement.remove();
                }, error: function () {
                    alert("삭제에 실패하였습니다.")
                }

            });
        }
    });
</script>
</html>
