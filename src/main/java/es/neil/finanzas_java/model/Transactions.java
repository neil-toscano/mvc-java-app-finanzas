package es.neil.finanzas_java.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Transactions {
    private Integer id;
    private Integer userId;
    private BigDecimal amount;
    private Integer categoryId;
    private String description;
    private LocalDate date;
    private String type; // 'expense' o 'income'
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Constructor vacío (Necesario para frameworks)
    public Transactions() {
    }

    // Constructor para insertar nuevos datos (sin ID ni fechas automáticas)
    public Transactions(Integer userId, BigDecimal amount, Integer categoryId, String description, LocalDate date, String type) {
        this.userId = userId;
        this.amount = amount;
        this.categoryId = categoryId;
        this.description = description;
        this.date = date;
        this.type = type;
    }

    // Getters y Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }

    public Integer getCategoryId() { return categoryId; }
    public void setCategoryId(Integer categoryId) { this.categoryId = categoryId; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    @Override
    public String toString() {
        return "Transaction{" +
                "id=" + id +
                ", amount=" + amount +
                ", type='" + type + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}