package es.neil.finanzas_java.services;

import es.neil.finanzas_java.model.Transactions;
import jakarta.annotation.Resource;
import jakarta.enterprise.context.ApplicationScoped;
import javax.sql.DataSource;
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ApplicationScoped
public class TransactionService {

    @Resource(lookup = "java:/finanzas_java/MySQLDS")
    private DataSource dataSource;

    public List<Transactions> findAll() {
        List<Transactions> list = new ArrayList<>();
        String sql = "SELECT * FROM transactions";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Transactions t = new Transactions();
                t.setId(rs.getInt("id"));
                t.setCategoryId(rs.getInt("category_id"));
                t.setAmount(rs.getBigDecimal("amount"));
                t.setDescription(rs.getString("description"));
                t.setDate(rs.getDate("date").toLocalDate());
                t.setType(rs.getString("type"));
                list.add(t);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Transactions findById(Integer id) {
        String sql = "SELECT * FROM transactions WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Transactions t = new Transactions();
                    t.setId(rs.getInt("id"));
                    t.setAmount(rs.getBigDecimal("amount"));
                    // ... set resto de campos
                    return t;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void save(Transactions t) {
        String sql = "INSERT INTO transactions (user_id, amount, category_id, description, date, type) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, t.getUserId());
            ps.setBigDecimal(2, t.getAmount());
            ps.setInt(3, t.getCategoryId());
            ps.setString(4, t.getDescription());
            ps.setDate(5, java.sql.Date.valueOf(t.getDate()));
            ps.setString(6, t.getType());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Transactions> findByDate(LocalDate date) {
        List<Transactions> list = new ArrayList<>();
        String sql = "SELECT * FROM transactions WHERE user_id = ? AND date = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, 1);
            ps.setDate(2, java.sql.Date.valueOf(date));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Transactions t = new Transactions();
                    t.setId(rs.getInt("id"));
                    t.setCategoryId(rs.getInt("category_id"));
                    t.setAmount(rs.getBigDecimal("amount"));
                    t.setType(rs.getString("type"));
                    t.setDescription(rs.getString("description"));
                    list.add(t);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Map<String, BigDecimal> getDailyBalance(int month, int year) {
        Map<String, BigDecimal> balances = new HashMap<>();

        String sql = "SELECT date, SUM(CASE WHEN type = 'income' THEN amount ELSE -amount END) as balance " +
                "FROM transactions WHERE MONTH(date) = ? AND YEAR(date) = ? GROUP BY date";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    balances.put(rs.getDate("date").toString(), rs.getBigDecimal("balance"));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return balances;
    }

    public void delete(Integer id) {
        String sql = "DELETE FROM transactions WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Integer id, BigDecimal amount, String description) {
        String sql = "UPDATE transactions SET amount = ?, description = ? WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBigDecimal(1, amount);
            ps.setString(2, description);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}