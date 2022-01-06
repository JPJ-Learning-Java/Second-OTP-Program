<%@ page language="java" contentType="text/html; charset=UTF-8" %>
당신의 키는 → ${encodedKey} 입니다. <br>
당신의 바코드 주소는 → ${url} 입니다. <br><br>

<form action="<%=request.getContextPath() %>/otpResult.ok" method="get">
    code : <input name="user_code" type="text"><br><br>

    <input name="encodedKey" type="hidden" readonly="readonly" value="${encodedKey}"><br><br>
    <input type="submit" value="전송!">

</form>