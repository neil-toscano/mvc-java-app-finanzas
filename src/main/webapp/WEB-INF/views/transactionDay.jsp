<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .history-container { margin-top: 10px; }

    .styled-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 0.95rem;
        background-color: white;
    }

    .styled-table thead tr {
        background-color: #f8fafc;
        color: #64748b;
        text-align: left;
        border-bottom: 2px solid #edf2f7;
    }

    .styled-table th, .styled-table td {
        padding: 16px 12px;
    }

    .styled-table tbody tr {
        border-bottom: 1px solid #f1f5f9;
        transition: background 0.2s;
    }

    .styled-table tbody tr:hover { background-color: #f8fafc; }

    /* Estilos para el tipo de transacción */
    .badge {
        padding: 5px 10px;
        border-radius: 8px;
        font-size: 0.8rem;
        font-weight: 700;
        text-transform: uppercase;
    }
    .badge-income { background-color: #dcfce7; color: #166534; }
    .badge-expense { background-color: #fee2e2; color: #991b1b; }

    .amount-text { font-weight: 600; }
    .income-val { color: #166534; }
    .expense-val { color: #991b1b; }

    /* Botones de acción */
    .action-btns { display: flex; gap: 8px; }
    .btn-action {
        padding: 6px 12px;
        border-radius: 8px;
        border: 1px solid #e2e8f0;
        cursor: pointer;
        font-size: 0.85rem;
        font-weight: 600;
        text-decoration: none;
        transition: 0.2s;
    }
    .btn-edit { color: #3b82f6; background: #eff6ff; }
    .btn-edit:hover { background: #dbeafe; }
    .btn-delete { color: #ef4444; background: #fef2f2; }
    .btn-delete:hover { background: #fee2e2; }

    .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); }
    .modal-content { background: white; margin: 10% auto; padding: 30px; border-radius: 24px; width: 400px; box-shadow: 0 5px 15px rgba(0,0,0,0.2); }
    .close { float: right; cursor: pointer; font-size: 1.5rem; }

</style>

<div class="history-container">
    <table class="styled-table">
        <thead>
        <tr>
            <th>Categoría</th>
            <th>Descripción</th>
            <th>Tipo</th>
            <th>Monto</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="t" items="${transactions}">
            <tr>
                <td>
                        <span style="color: #1e293b; font-weight: 500;">
                            Cat #${t.categoryId}
                        </span>
                </td>
                <td style="color: #64748b;">${not empty t.description ? t.description : '-'}</td>
                <td>
                        <span class="badge ${t.type == 'income' ? 'badge-income' : 'badge-expense'}">
                                ${t.type == 'income' ? 'Ingreso' : 'Gasto'}
                        </span>
                </td>
                <td>
                        <span class="amount-text ${t.type == 'income' ? 'income-val' : 'expense-val'}">
                            ${t.type == 'income' ? '+' : '-'} S/ ${t.amount}
                        </span>
                </td>
                <td class="action-btns">
<%--                    <c:url var="urlBorrar" value="/dashboard/delete">--%>
<%--                        <c:param name="id" value="${t.id}" />--%>
<%--                    </c:url>--%>
                            <button type="button" class="btn-action btn-edit"
                                    onclick="openEditModal('${t.id}', '${t.amount}', '${t.description}')">
                                Editar
                            </button>
                    <a href="transaction/delete?id=${t.id}" class="btn-action btn-delete">Borrar</a>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty transactions}">
            <tr>
                <td colspan="5" style="text-align: center; padding: 40px; color: #94a3b8;">
                    No se encontraron movimientos registrados.
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>

<%--    MODAL ACTUALIZAR  --%>
    <div id="editModal" class="modal">
        <div class="modal-content card">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>Editar Movimiento</h2>
            <form action="dashboard/update" method="POST">
                <input type="hidden" name="id" id="edit-id">

                <div class="form-group">
                    <label>Monto (S/)</label>
                    <input type="number" name="amount" id="edit-amount" step="0.01" required>
                </div>

                <div class="form-group">
                    <label>Descripción</label>
                    <input type="text" name="description" id="edit-description">
                </div>

                <button type="submit" class="submit-btn" style="background-color: #3b82f6;">Actualizar</button>
            </form>
        </div>
    </div>
</div>

<script>
    function openEditModal(id, amount, description) {
        document.getElementById('edit-id').value = id;
        document.getElementById('edit-amount').value = amount;
        document.getElementById('edit-description').value = description;
        document.getElementById('editModal').style.display = 'block';
    }

    function closeModal() {
        document.getElementById('editModal').style.display = 'none';
    }
</script>