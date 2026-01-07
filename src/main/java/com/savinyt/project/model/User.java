package com.savinyt.project.model;

public class User {
    private int id;
    private String username;
    private String role; // "EMPLOYEE" or "MANAGER"

    // Constructor
    public User(int id, String username, String role) {
        this.id = id;
        this.username = username;
        this.role = role;
    }

    // --- GETTERS (Crucial for JSP) ---
    public String getUsername() {
        return username;
    }

    public String getRole() {
        return role;
    }

    public int getId() {
        return id;
    }

    // --- SETTERS ---
    public void setUsername(String username) {
        this.username = username;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setId(int id) {
        this.id = id;
    }
}