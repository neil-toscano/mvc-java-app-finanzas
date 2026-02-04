package es.neil.finanzas_java.controller;

import jakarta.annotation.Resource;
import jakarta.inject.Inject;
import jakarta.mvc.Controller;
import jakarta.mvc.Models;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


@Path("pruebas")
public class PruebasController {
    @Inject
    private Models models;

    @Resource(lookup="java:/finanzas_java/MySQLDS")
    private DataSource myPool;


    @GET
    @Controller
    public String hello() {
        List<String> emails = new ArrayList<>();
        String sql = "SELECT email FROM users";

        try (Connection conn = myPool.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                String userEmail = rs.getString("email");
                emails.add(userEmail);
                System.out.println("Email encontrado: " + userEmail);
            }

            // Pasamos la lista al JSP con el nombre "listaEmails"
            models.put("listaEmails", emails);

        } catch (SQLException e) {
            System.err.println("Error de SQL: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Error general: " + e.getMessage());
            e.printStackTrace();
        }

        return "hello.jsp";
    }
}
