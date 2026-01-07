
### **Action:**

1. Create a file named `README.md` in your project root.
2. Paste the content below.
3. (Optional) Create a folder named `screenshots` and put images of your Login, Employee, and Manager pages there.

---

```markdown
# Identity Governance & Administration (IGA) Prototype

A robust Java web application demonstrating core Identity Governance principles, including **Role-Based Access Control (RBAC)** and **Access Request Workflows**.

Built to simulate a real-world enterprise environment where employees request access to high-risk resources and managers review/approve them, ensuring secure "Maker-Checker" compliance.

![Status](https://img.shields.io/badge/Status-Completed-success)
![Java](https://img.shields.io/badge/Java-Jakarta%20EE-orange)
![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-blue)

## 🚀 Features

* **RBAC Architecture:** Secure login system distinguishing between `EMPLOYEE` and `MANAGER` roles.
* **Access Request Workflow:** Employees can select corporate resources (e.g., Financial Data) and submit access requests.
* **Manager Approval Dashboard:** Managers view a queue of pending requests and can **Approve** or **Reject** them in real-time.
* **Audit Trail:** All requests, timestamps, and status changes are persisted in PostgreSQL for audit compliance.
* **Session Security:** Protected routes and session invalidation on logout.
* **Enterprise UI:** Clean, responsive user interface styled with professional CSS.

## 🛠️ Tech Stack

* **Backend:** Java (JDK 17+), Jakarta EE Servlets, JDBC
* **Frontend:** JSP (JavaServer Pages), CSS3 (Enterprise Theme)
* **Database:** PostgreSQL
* **Server:** Apache Tomcat 10.1 (Smart Tomcat)
* **Build Tool:** Maven

## 📸 Screenshots

## ⚙️ Setup & Installation

### 1. Database Setup (PostgreSQL)
Run the following SQL script to initialize the schema and seed data:

```sql
-- 1. Create Tables
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    role VARCHAR(20) NOT NULL -- 'EMPLOYEE' or 'MANAGER'
);

CREATE TABLE resources (
    id SERIAL PRIMARY KEY,
    resource_name VARCHAR(100) NOT NULL,
    risk_level VARCHAR(20) -- 'Low', 'Medium', 'High'
);

CREATE TABLE requests (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    resource_id INT REFERENCES resources(id),
    status VARCHAR(20) DEFAULT 'PENDING', -- 'PENDING', 'APPROVED', 'REJECTED'
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Insert Seed Data
INSERT INTO users (username, password, role) VALUES 
('alice', '123', 'EMPLOYEE'),
('bob', '123', 'MANAGER');

INSERT INTO resources (resource_name, risk_level) VALUES 
('Financial Data', 'High'),
('Employee Handbook', 'Low'),
('IT Admin Tools', 'Critical');

```

### 2. Configure Application

Open `src/main/java/com/saviynt/project/dao/DBConnection.java` and update your PostgreSQL credentials:

```java
private static final String URL = "jdbc:postgresql://localhost:5432/your_db_name";
private static final String USER = "your_postgres_user";
private static final String PASS = "your_postgres_password";

```

### 3. Run with IntelliJ IDEA

1. Open the project in IntelliJ.
2. Ensure **Smart Tomcat** plugin is installed.
3. Edit Configuration:
* **Context Path:** `/saviynt`
* **Deployment Directory:** `src/main/webapp`


4. Run the server.

### 4. Run via Command Line (Maven)

```bash
mvn clean package
# Deploy the resulting .war file to your Tomcat webapps folder

```

## 🔐 Usage Credentials

| Role | Username | Password | Access Level |
| --- | --- | --- | --- |
| **Employee** | `alice` | `123` | Can request access only. |
| **Manager** | `bob` | `123` | Can view dashboard and approve requests. |

## 🔮 Future Enhancements

* **Email Notifications:** Send emails upon request approval.
* **Password Hashing:** Integrate BCrypt for password security.
* **SoD Checks:** Implement Segregation of Duties rules before approval.

---

**Author:** alterra47

**Project Link:** [https://github.com/YourUsername/Saviynt-IGA-Project](https://www.google.com/search?q=https://github.com/YourUsername/Saviynt-IGA-Project)

```

```
