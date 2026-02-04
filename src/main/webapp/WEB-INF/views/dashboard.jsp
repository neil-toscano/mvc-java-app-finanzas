<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Finanzas Personales | Dashboard</title>
    <style>
        body {
            font-family: 'Inter', -apple-system, sans-serif;
            background-color: #fcfcfc;
            display: flex;
            justify-content: center;
            padding: 40px;
        }
        .card {
            background: white;
            border-radius: 24px;
            padding: 30px;
            min-width: 400px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            border: 1px solid #f0f0f0;
        }
        h2 { font-size: 1.5rem; margin-bottom: 25px; color: #1a1a1a; }

        /* Tabs Estilo Imagen */
        .tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        .tab-btn {
            flex: 1;
            padding: 12px;
            border-radius: 12px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            transition: 0.3s;
            font-size: 1rem;
        }
        .btn-gasto.active { background-color: #ff6b00; color: white; }
        .btn-ingreso.active { background-color: #27ae60; color: white; }
        .inactive { background-color: #f1f5f4; color: #4b5563; }

        /* Formulario */
        .form-group { margin-bottom: 18px; }
        label { display: block; margin-bottom: 8px; font-weight: 500; font-size: 0.9rem; }
        input, select {
            width: 100%;
            padding: 14px;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            background-color: #f9fafb;
            font-size: 1rem;
            box-sizing: border-box;
            outline: none;
        }
        input:focus { border-color: #ff6b00; }

        /* Botón Registro */
        .submit-btn {
            width: 100%;
            padding: 15px;
            border-radius: 12px;
            border: none;
            color: white;
            font-weight: bold;
            font-size: 1rem;
            cursor: pointer;
            margin-top: 10px;
            background-color: #ff6b00;
            transition: opacity 0.2s;
        }
        .submit-btn:hover { opacity: 0.9; }
    </style>
</head>
<body>




<div class="section-container">
    <div class="app-info">
        <h1>App de Finanzas Personales</h1>
        <p>Gestiona tus ingresos y gastos de forma inteligente con un calendario interactivo y control detallado por categorías.</p>
        <span class="app-badge">v1.0 • Neil Dev</span>
    </div>
    <br/>
    <div class="card">
        <h2>Registrar movimiento</h2>
        <%-- Asegúrate de que el nombre del archivo sea el correcto --%>
        <jsp:include page="formBudget.jsp" />
    </div>

    <br/>
    <div class="card">
        <jsp:include page="calendar.jsp" />
    </div>

    <br/>
    <div class="card">
        <h2>Movimientos del día</h2>
        <c:if test="${not empty fechaSeleccionada}">
            <p style="color: #666;">Mostrando datos de: <strong>${fechaSeleccionada}</strong></p>
        </c:if>
        <jsp:include page="transactionDay.jsp" />
    </div>
</div>

</body>
</html>