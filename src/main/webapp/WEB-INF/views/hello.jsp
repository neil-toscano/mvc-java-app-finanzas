<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Lista de Usuarios</title>
</head>
<body>
<h1>Correos de Usuarios en MySQL</h1>

<table border="1">
    <thead>
    <tr>
        <th>Email</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="email" items="${listaEmails}">
        <tr>
            <td>${email}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<c:if test="${empty listaEmails}">
    <p>No se encontraron correos en la base de datos.</p>
</c:if>
</body>
</html>