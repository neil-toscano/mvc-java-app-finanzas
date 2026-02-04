package es.neil.finanzas_java.controller;

import es.neil.finanzas_java.services.CategoryService;
import es.neil.finanzas_java.services.TransactionService;
import jakarta.inject.Inject;
import jakarta.mvc.Controller;
import jakarta.mvc.Models;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Response;

import java.math.BigDecimal;
import java.net.URI;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.Locale;

@Path("dashboard")
public class DashboardController {

    @Inject
    private Models models;

    @Inject
    private CategoryService categoryService;

    @Inject
    private TransactionService transactionService;

    @GET
    @Controller
    public String index(
            @QueryParam("mes") Integer mesParam,
            @QueryParam("anio") Integer anioParam,
            @QueryParam("fecha") String fechaParam) {

        LocalDate hoy = LocalDate.now();
        int mesMostrado = (mesParam != null) ? mesParam : hoy.getMonthValue();
        int anioMostrado = (anioParam != null) ? anioParam : hoy.getYear();

        LocalDate primerDiaMes = LocalDate.of(anioMostrado, mesMostrado, 1);

        LocalDate mesAnterior = primerDiaMes.minusMonths(1);
        LocalDate mesSiguiente = primerDiaMes.plusMonths(1);

        int espaciosEnBlanco = primerDiaMes.getDayOfWeek().getValue() % 7;
        int diasEnMes = primerDiaMes.lengthOfMonth();

        models.put("mesActual", mesMostrado);
        models.put("anioActual", anioMostrado);
        models.put("hoy", hoy);

        models.put("mesNombre", primerDiaMes.getMonth().getDisplayName(TextStyle.FULL, new Locale("es", "ES")));

        models.put("navAnterior", mesAnterior);
        models.put("navSiguiente", mesSiguiente);

        models.put("espacios", espaciosEnBlanco);
        models.put("diasEnMes", diasEnMes);

        models.put("dailyBalances", transactionService.getDailyBalance(mesMostrado, anioMostrado));

        models.put("incomeCategories", categoryService.findByType("income"));
        models.put("expenseCategories", categoryService.findByType("expense"));

        if (fechaParam != null && !fechaParam.isEmpty()) {
            LocalDate fechaFiltro = LocalDate.parse(fechaParam);
            models.put("transactions", transactionService.findByDate(fechaFiltro));
            models.put("fechaSeleccionada", fechaParam);
        } else {
            models.put("transactions", transactionService.findAll());
        }

        return "dashboard.jsp";
    }

    @POST
    @Path("update")
    @Controller
    public Response update(
            @FormParam("id") Integer id,
            @FormParam("amount") BigDecimal amount,
            @FormParam("description") String description) {

        if (id != null) {
            transactionService.update(id, amount, description);
        }

        return Response.seeOther(URI.create("dashboard")).build();
    }


}