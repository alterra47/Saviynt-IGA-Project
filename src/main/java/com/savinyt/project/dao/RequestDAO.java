package com.savinyt.project.dao;

import com.savinyt.project.model.User;
import com.savinyt.project.model.Request;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RequestDAO {

    // 1. Authenticate User
    public User login(String username, String password) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id, username, role FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(rs.getInt("id"), rs.getString("username"), rs.getString("role"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // 2. Create Access Request (Employee Action)
    public boolean createRequest(int userId, int resourceId) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO requests (user_id, resource_id, status) VALUES (?, ?, 'PENDING')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, resourceId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // 3. Get Pending Requests (Manager View - Uses JOIN)
    public List<Request> getPendingRequests() {
        List<Request> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            System.out.println("DEBUG: Connection opened..."); // DEBUG LINE

            String sql = "SELECT r.id, u.username, res.resource_name, r.status, r.request_date " +
                    "FROM requests r " +
                    "JOIN users u ON r.user_id = u.id " +
                    "JOIN resources res ON r.resource_id = res.id " +
                    "WHERE r.status = 'PENDING'";

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            int count = 0;
            while (rs.next()) {
                count++;
                // ... (Your existing list.add code) ...
                list.add(new Request(rs.getInt("id"), rs.getString("username"), rs.getString("resource_name"), rs.getString("status"), rs.getTimestamp("request_date")));
            }
            System.out.println("DEBUG: Found " + count + " pending requests."); // DEBUG LINE

        } catch (Exception e) {
            e.printStackTrace(); // THIS IS CRITICAL
        }
        return list;
    }

    // 4. Approve/Reject Request (Manager Action)
    public boolean updateStatus(int requestId, String newStatus) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE requests SET status = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setInt(2, requestId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}