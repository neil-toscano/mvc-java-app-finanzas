<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form action="transaction" method="POST">
    <div class="tabs">
        <button type="button" id="tabGasto" class="tab-btn btn-gasto active" onclick="switchType('expense')">Gasto</button>
        <button type="button" id="tabIngreso" class="tab-btn btn-ingreso inactive" onclick="switchType('income')">Ingreso</button>
    </div>
    <input type="hidden" name="type" id="movType" value="expense">

    <div class="form-group">
        <label id="labelMonto">Monto (S/)</label>
        <input type="number" name="amount" step="0.01" placeholder="0.00" required>
    </div>

    <div class="form-group">
        <label>Categoría</label>
        <select name="categoryId" id="categorySelect">
            <c:forEach var="cat" items="${expenseCategories}">
                <option value="${cat.id}">${cat.name}</option>
            </c:forEach>
        </select>
    </div>

    <div class="form-group">
        <label>Descripción (opcional)</label>
        <input type="text" name="description" placeholder="Detalles...">
    </div>

    <%-- BLOQUE DE ERROR --%>
    <c:if test="${not empty error}">
        <div style="background-color: #fff1f0; color: #d43f3a; padding: 12px;
                border-radius: 12px; margin-bottom: 20px; border: 1px solid #ffa39e;
                font-size: 0.9rem; display: flex; align-items: center; gap: 8px;">
            <strong>⚠️</strong> ${error}
        </div>
    </c:if>

    <button type="submit" id="mainBtn" class="submit-btn">Registrar Gasto</button>
</form>

<script>
    const expenseCats = [
        <c:forEach var="c" items="${expenseCategories}">
        {id: ${c.id}, name: '${c.name}'},
        </c:forEach>
    ];

    const incomeCats = [
        <c:forEach var="c" items="${incomeCategories}">
        {id: ${c.id}, name: '${c.name}'},
        </c:forEach>
    ];

    function switchType(type) {
        const tabG = document.getElementById('tabGasto');
        const tabI = document.getElementById('tabIngreso');
        const select = document.getElementById('categorySelect');
        const mainBtn = document.getElementById('mainBtn');
        const movType = document.getElementById('movType');

        select.innerHTML = "";

        if (type === 'expense') {
            tabG.className = 'tab-btn btn-gasto active';
            tabI.className = 'tab-btn btn-ingreso inactive';
            mainBtn.style.backgroundColor = '#ff6b00';
            mainBtn.innerText = 'Registrar Gasto';
            movType.value = 'expense';
            expenseCats.forEach(c => select.options.add(new Option(c.name, c.id)));
        } else {
            tabI.className = 'tab-btn btn-ingreso active';
            tabG.className = 'tab-btn btn-gasto inactive';
            mainBtn.style.backgroundColor = '#27ae60';
            mainBtn.innerText = 'Registrar Ingreso';
            movType.value = 'income';
            incomeCats.forEach(c => select.options.add(new Option(c.name, c.id)));
        }
    }
</script>