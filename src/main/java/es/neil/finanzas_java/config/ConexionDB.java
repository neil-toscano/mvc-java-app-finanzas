package es.neil.finanzas_java.config;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class ConexionDB {
    private  static DataSource dataSource = null;

    private static final String JNDI_NAME = "java:com/env/jdbc/finanzasApp";

    private ConexionDB() {}

    private static void inicializarDataSource() {
        try {
            Context initContext = new InitialContext();
            dataSource = (DataSource) initContext.lookup(JNDI_NAME);
        } catch (NamingException e) {
            throw new RuntimeException("Error al localizar el recurso JNDI: " + JNDI_NAME, e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            synchronized (ConexionDB.class) {
                if (dataSource == null) {
                    inicializarDataSource();
                }
            }
        }
        return dataSource.getConnection();
    }
}
