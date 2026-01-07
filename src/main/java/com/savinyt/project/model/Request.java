package com.savinyt.project.model;
import java.sql.Timestamp;

public class Request {
    private final int requestId;
    private final String requesterName;
    private final String resourceName;
    private final String status;
    private final Timestamp requestDate;

    public Request(int requestId, String requesterName, String resourceName, String status, Timestamp requestDate) {
        this.requestId = requestId;
        this.requesterName = requesterName;
        this.resourceName = resourceName;
        this.status = status;
        this.requestDate = requestDate;
    }

    // --- GETTERS (Required for JSP) ---
    public int getRequestId() { return this.requestId; }
    public String getRequesterName() { return this.requesterName; }
    public String getResourceName() { return this.resourceName; }
    public String getStatus() { return this.status; }
    public Timestamp getRequestDate() { return this.requestDate; }
}