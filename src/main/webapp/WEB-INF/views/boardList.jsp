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

<table id ="tableBody" style="border: 1px solid black;">
    <thead>
    <tr>
        <th>Index</th>
        <th>Title</th>
        <th>Content</th>
        <th>Date</th>
        <th>Count</th>
    </tr>
    </thead>
    <tbody style="border: 1px solid black;">
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
        <input type="hidden" id="lastIdx" value="${vo.idx}">
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
          console.log(field);
          const value = $(this).text();
          $(this).html('<input type=text name='+field+' value='+value+' />');
       });
       $(this).hide();
       row.find("#complete").show();
    });

    // 수정 완료 버튼 클릭시
    $(document).on("click", "#complete", function () {
        const rowId = $(this).data("id");
        const row = $('#row-'+rowId);

        var jsonData = {idx: rowId};
        row.find(".editable").each(function () {
                var field = $(this).data("field");
                const value = $('input[name="'+field+'"]').val();
                if(field === 'title') {
                    jsonData.title = value;
                } else if (field === 'content') {
                    jsonData.content = value;
                } else if (field === 'indate') {
                    jsonData.indate = value;
                } else if (field === 'count') {
                    jsonData.count = parseInt(value);
                }
            });
        console.log(jsonData);
        $.ajax({
            url: '/board/'+rowId,
            method: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(jsonData),
            success: function () {
                alert('수정을 완료하였습니다.');

                row.find(".editable").each(function () {
                    var field = $(this).data("field");
                    const value = $('input[name="'+field+'"]').val();
                    $(this).html(value);
                });


                $('input').remove();
                row.find("#update").show();
                row.find("#complete").hide();

            }, error: function () {
                alert('수정을 실패하였습니다.');
            }
        });
    });

    //입력 버튼 클릭시
    $(document).on("click", "#insert", function () {
        console.log("insert clicked");
        const newRow = `
            <tr>
                <td> </td>
                <td><input type="text" name="title" placeholder="Enter title"></td>
                <td><input type="text" name="content" placeholder="Enter content"></td>
                <td><input type="text" name="indate"  placeholder="Enter content"></td>
                <td><input type="number" name="count" value="0"></td>
                <td>
                    <button class="save">저장</button>
                    <button class="cancel">취소</button>
                </td>
            </tr>
        `;
        $('#tableBody tbody').append(newRow);
    });

    //입력 저장 버튼 클릭
    $(document).on("click", ".save", function () {

        var jsonData = {};
        const row = $(this).closest('tr');
        jsonData.title = row.find('input[name="title"]').val();
        jsonData.content = row.find('input[name="content"]').val();
        jsonData.indate = row.find('input[name="indate"]').val();
        jsonData.count = row.find('input[name="count"]').val();

        console.log(jsonData);
        $.ajax({
            url: '/board',
            method: 'POST',
            data: JSON.stringify(jsonData),
            content: 'application/json',
            success: function (res) {
                console.log(res);
            }, error: function (res) {
                alert("저장에 실패 했습니다.");
            }
        });
    });

    //저장 취소 버튼 클릭 시
    $(document).on('click', '.cancel', function () {
        console.log("cancel clicked")
        $(this).closest('tr').remove();
    });
</script>
</html>
