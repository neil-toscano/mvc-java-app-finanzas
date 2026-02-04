package es.neil.finanzas_java.controller;

import es.neil.finanzas_java.model.Transactions;
import es.neil.finanzas_java.services.CategoryService;
import es.neil.finanzas_java.services.TransactionService;
import jakarta.inject.Inject;
import jakarta.mvc.Controller;
import jakarta.mvc.Models;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Response;

import java.math.BigDecimal;
import java.net.URI;
import java.sql.Connection;
import java.time.LocalDate;
import java.util.List;

@Path("transaction")
public class TransactionController {
    BigDecimal montoMinimo = new BigDecimal("1.00");

    @Inject
    private TransactionService transactionService;

    @Inject
    private CategoryService categoryService;

    @Inject
    private Models models;

    @GET
    @Controller
    public String listAll() {
        List<Transactions> allTransactions = transactionService.findAll();

        models.put("transactions", allTransactions);

        return "transactionList.jsp";
    }

    @POST
    @Controller
    public Response create(
            @FormParam("amount") BigDecimal amount,
            @FormParam("categoryId") Integer categoryId,
            @FormParam("description") String description,
            @FormParam("type") String type) {

        if (amount == null || amount.compareTo(montoMinimo) <= 0) {
            models.put("error", "El monto debe ser mayor a cero.");

            models.put("incomeCategories", categoryService.findByType("income"));
            models.put("expenseCategories", categoryService.findByType("expense"));
            models.put("transactions", transactionService.findAll());

            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("dashboard.jsp")
                    .build();
        }

        try {
            Transactions newTransaction = new Transactions();
            newTransaction.setUserId(1);
            newTransaction.setAmount(amount);
            newTransaction.setCategoryId(categoryId);
            newTransaction.setDescription(description);
            newTransaction.setType(type);
            newTransaction.setDate(LocalDate.now());

            transactionService.save(newTransaction);
            return Response.seeOther(URI.create("dashboard")).build();

        } catch (Exception e) {
            models.put("error", "Error interno al guardar: " + e.getMessage());

            // 3. También aquí debes recargar si hay error de base de datos
            models.put("incomeCategories", categoryService.findByType("income"));
            models.put("expenseCategories", categoryService.findByType("expense"));

            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("dashboard.jsp")
                    .build();
        }
    }

    @GET
    @Path("delete")
    @Controller
    public Response delete(@QueryParam("id") Integer id) {
        if (id != null) {
            transactionService.delete(id);
        }
        return Response.seeOther(URI.create("dashboard")).build();
    }

}
