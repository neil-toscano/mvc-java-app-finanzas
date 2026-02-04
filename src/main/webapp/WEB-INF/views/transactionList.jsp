<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Mis Finanzas | Neil</title>
    <style>
        /* Estilo Normal con CSS Puro */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f6;
            color: #333;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th {
            background-color: #3498db;
            color: white;
            text-align: left;
            padding: 12px;
        }
        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .monto {
            font-weight: bold;
            text-align: right;
        }
        .ingreso { color: #27ae60; }
        .gasto { color: #e74c3c; }

        .badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.85em;
            text-transform: uppercase;
        }
        .badge-in { background: #d4edda; color: #155724; }
        .badge-out { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>

<div class="container">
    <h2>Historial de Movimientos</h2>

    <table>
        <thead>
        <tr>
            <th>Fecha</th>
            <th>Descripción</th>
            <th style="text-align: right;">Monto</th>
            <th style="text-align: center;">Estado</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="t" items="${transactions}">
            <tr>
                <td>${t.date}</td>
                <td>${t.transaction}</td>
                <td class="monto ${t.type == 'income' ? 'ingreso' : 'gasto'}">
                        ${t.type == 'income' ? '+' : '-'} S/ ${t.amount}
                </td>
                <td style="text-align: center;">
                        <span class="badge ${t.type == 'income' ? 'badge-in' : 'badge-out'}">
                                ${t.type == 'income' ? 'Ingreso' : 'Gasto'}
                        </span>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty transactions}">
            <tr>
                <td colspan="4" style="text-align: center; color: #999; padding: 30px;">
                    No hay transacciones que mostrar.
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

</body>
</html>