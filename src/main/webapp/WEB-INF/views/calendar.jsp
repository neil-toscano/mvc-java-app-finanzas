<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .calendar-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
    }
    .month-title {
        font-size: 1.6rem;
        font-weight: 700;
        color: #1a1a1a;
        text-transform: capitalize;
    }

    .nav-group { display: flex; gap: 8px; }
    .nav-link {
        padding: 8px 16px;
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 10px;
        text-decoration: none;
        color: #4b5563;
        font-weight: 600;
        font-size: 0.9rem;
        transition: 0.2s;
    }
    .nav-link:hover { background: #f9fafb; border-color: #d1d5db; }

    .calendar-grid {
        display: grid;
        grid-template-columns: repeat(7, 1fr);
        gap: 10px;
    }
    .day-name {
        text-align: center;
        color: #a1a1aa;
        font-size: 0.85rem;
        font-weight: 600;
        padding-bottom: 15px;
    }

    .day-cell {
        background: #f8fafc;
        border-radius: 16px;
        min-height: 100px;
        padding: 12px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        text-decoration: none;
        transition: all 0.2s ease;
        border: 2px solid transparent;
    }
    .day-cell:hover { background: #f1f5f9; transform: translateY(-2px); }

    .day-cell.active {
        background: #4d7c0f;
        border-color: #365314;
    }
    .day-cell.active .day-num, .day-cell.active .day-amount {
        color: #ffffff !important;
    }

    .day-num {
        font-weight: 700;
        color: #334155;
        align-self: flex-end;
        font-size: 1.1rem;
    }

    .day-amount {
        font-size: 0.85rem;
        font-weight: 700;
        color: #991b1b;
    }
    .amount-pos { color: #166534; }

    .empty-cell { background: transparent; cursor: default; }
</style>

<div class="calendar-header">
    <div class="month-title">${mesNombre} De ${anioActual}</div>
    <div class="nav-group">
        <a href="?mes=${navAnterior.monthValue}&anio=${navAnterior.year}" class="nav-link">&larr;</a>

        <a href="?mes=${hoy.monthValue}&anio=${hoy.year}" class="nav-link">Hoy</a>

        <a href="?mes=${navSiguiente.monthValue}&anio=${navSiguiente.year}" class="nav-link">&rarr;</a>
    </div>
</div>

<div class="calendar-grid">
    <div class="day-name">Dom</div><div class="day-name">Lun</div><div class="day-name">Mar</div>
    <div class="day-name">Mié</div><div class="day-name">Jue</div><div class="day-name">Vie</div><div class="day-name">Sáb</div>

    <c:forEach begin="1" end="${espacios}">
        <div class="day-cell empty-cell"></div>
    </c:forEach>

    <c:forEach var="i" begin="1" end="${diasEnMes}">
        <c:set var="fullDate" value="${anioActual}-${mesActual < 10 ? '0' : ''}${mesActual}-${i < 10 ? '0' : ''}${i}" />

        <a href="?fecha=${fullDate}&mes=${mesActual}&anio=${anioActual}"
           class="day-cell ${fechaSeleccionada == fullDate ? 'active' : ''}">

                <%-- Balance del día desde el Map del controlador --%>
            <c:set var="monto" value="${dailyBalances[fullDate]}" />
            <div class="day-amount ${monto > 0 ? 'amount-pos' : ''}">

                <c:if test="${not empty monto}">${monto}</c:if>
            </div>

            <span class="day-num">${i}</span>
        </a>
    </c:forEach>
</div>