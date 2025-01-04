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
        <th>Content</th>
        <th>Date</th>
        <th>Count</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="vo" items="${list}">
        <tr id="row-${vo.idx}">
            <td>${vo.idx}</td>
            <td class="editable" data-field="title">${vo.title}</td>
            <td class="editable" data-field="content">${vo.content}</td>
            <td class="editable" data-field="indate">${vo.indate}</td>
            <td class="editable" data-field="count">${vo.count}</td>
            <td> <button id="delete" data-id="${vo.idx}">삭제</button></td>
            <td> <button id="update" data-id="${vo.idx}">수정</button> </td>
            <td> <button id="complete" style="display: none;" data-id="${vo.idx}">완료</button> </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<button id="insert">입력</button>


</body>
<script>

    //삭제 하기
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

    //수정 모드로 전환하기
    $(document).on("click", "#update", function () {
       const rowId = $(this).data("id");
       const row = $('#row-'+rowId);

       row.find(".editable").each(function () {
          const field = $(this).data("field");
          const value = $(this).text();
          $(this).html('<input type=text name='+field+' value='+value+' />');
       });
       $(this).hide();
       row.find("#complete").show();
    });

    $(document).on("click", "#complete", function () {
        const rowId = $(this).data("id");
        const row = $('#row-'+rowId);

        var jsonData = {idx: rowId};
        jsonData.title = $('input').attr('name', 'title').val();
        jsonData.content = $('input').attr('name', 'content').val();
        jsonData.indate = $('input').attr('name', 'indate').val();
        jsonData.count = $('input').attr('name', 'count').val();

        console.log(jsonData);
        $.ajax({
            url: '/board/'+rowId,
            method: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(jsonData),
            success: function () {
                alert('수정을 완료하였습니다.');
            }, error: function () {
                alert('수정을 실패하였습니다.');
            }
        });
    })
</script>
</html>
